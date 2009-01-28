require "lib/state_machine"

class TestMachine
  include StateMachine
  attr_reader :counter
  
  def initialize(lexer, context, counter)
    super(lexer, context)
    @counter = counter
  end

  initial_state :s0 do
    transition '.' do
      counter.s0_t1_called
      :s1
    end
    transition '+' do
      counter.s0_t2_called
      :s2
    end
    transition ',' do
      counter.s0_t3_called
      :s3
    end
  end

  final_state :s1

  state :s2 do
    transition 'identifier' do
      counter.s2_t1_called
      :s0
    end
  end
  
  final_state :s3 do
    transition '*' do
      counter.s3_t1_called
      :s2
    end
  end
end
