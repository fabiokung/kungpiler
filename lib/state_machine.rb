require "lib/token"

module StateMachine
  
  attr_reader :lexer, :context
  attr_accessor :actual_state
  
  def self.included(klass)
    klass.extend(ClassMethods)
  end
  
  def initialize(lexer, compilation_context)
    @lexer = lexer
    @context = compilation_context
  end
  
  def start
    method(self.class.initial_state_name).call
  end
  
  def final_state?(name)
    self.class.final_states.include?(name)
  end
  
  def sub_machine(machine_class, ctx = nil)
    p "Calling submachine: #{machine_class}" if $DEBUG
    context.stack_size += 4 if ctx.nil?
    ctx ||= context
    sub = machine_class.new(lexer, ctx)
    sub.start
    p "Returning from submachine: #{machine_class}" if $DEBUG
  end
  
  module ClassMethods

    def initial_state_name
      @initial_state_name ||= nil
    end

    def final_states
      @final_states ||= []
    end
    
    def final_state(name, &behavior)
      final_states << name
      proceeding_method_name = (name.to_s + "_proceeding").to_sym
      state(proceeding_method_name, &behavior)
      define_method name do
        p "final state: #{name}" if $DEBUG
        transitions = StateMachine::Transitions.new(self, name)
        transitions.instance_eval &behavior if block_given?
        method(proceeding_method_name).call if transitions.has?(lexer.lookahead)
        @actual_state = name
      end
    end

    def initial_state(name, &behavior)
      raise "The State Machine already has an initial state: #{initial_state_name}" if initial_state_name
      @initial_state_name = name
      state(name, &behavior)
    end
    
    def state(name, &behavior)
      define_method name do
        @actual_state = name
        p "actual state: #{name}" if $DEBUG
        transitions = StateMachine::Transitions.new(self, name)
        transitions.instance_eval &behavior
      
        if transitions.has_only_empty?
          transitions.choose(nil)
        else
          if transitions.deterministic?
            transitions.choose(lexer.next_token)
          else
            if transitions.has?(lexer.lookahead)
              transitions.choose(lexer.next_token)
            else
              transitions.choose(nil)
            end
          end
        end
      end
    end
    
  end
  
  class Transitions
    attr_reader :transitions
    
    def initialize(machine, state)
      @has_only_empty = true
      @machine = machine
      @state = state
      @transitions = {}
    end
    
    def transition(token_type = nil, &blk)
      raise "transition for #{token_type} already defined for the state: #{@state}" if transitions.has_key?(token_type)
      @has_only_empty = false if token_type
      transitions[token_type] = blk
    end
    
    def choose(token)
      p "received #{token}" if $DEBUG
      raise "Unexpected token: #{token}" unless transitions.has_key?(type_for(token))
      new_state = transitions[type_for(token)].call(token).to_sym
      @machine.method(new_state).call
    end
    
    def method_missing(name, *args, &blk)
      @machine.method(name).call(*args, &blk)
    end
    
    def has?(token)
      @transitions.has_key?(type_for(token))
    end
    
    def has_only_empty?
      @has_only_empty
    end
    
    def deterministic?
      has_only_empty? || !@transitions.has_key?(nil)
    end
    
    def type_for(token)
      return token.type if token.kind_of?(Token)
      token
    end
    
    def context
      @machine.context
    end
  end
end
