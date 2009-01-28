require "lib/state_machine"
require "lib/machine/statement"

class Block
  include StateMachine
  
  attr_accessor :const_name, :procedure_name

  initial_state :s0 do
    transition 'const' do
      :s1
    end
    transition do
      :s11
    end
  end
  
  state :s1 do
    transition 'identifier' do |token|
      self.const_name = token.value
      :s2
    end
  end
  
  state :s2 do
    transition '=' do
      :s3
    end
  end
  
  state :s3 do
    transition 'number' do |token|
      context.allocate_constant_for(const_name, token.value)
      self.const_name = nil
      :s4
    end
  end
  
  state :s4 do
    transition { :s5 }
  end
  
  state :s5 do
    transition ',' do
      :s6
    end
    transition ';' do
      :s10
    end
  end
  
  state :s6 do
    transition 'identifier' do |token|
      self.const_name = token.value
      :s7
    end
  end
  
  state :s7 do
    transition '=' do
      :s8
    end
  end
  
  state :s8 do
    transition 'number' do |token|
      context.allocate_constant_for(const_name, token.value)
      self.const_name = nil
      :s9
    end
  end
  
  state :s9 do
    transition { :s5 }
  end
  
  state :s10 do
    transition { :s11 }
  end
  
  state :s11 do
    transition 'var' do
      :s12
    end
    transition do
      :s18
    end
  end
  
  state :s12 do
    transition 'identifier' do |token|
      context.allocate_field_for token.value
      :s13
    end
  end
  
  state :s13 do
    transition { :s14 }
  end
  
  state :s14 do
    transition ',' do
      :s15
    end
    transition ';' do
      :s17
    end
  end
  
  state :s15 do
    transition 'identifier' do |token|
      context.allocate_field_for token.value
      :s16
    end
  end
  
  state :s16 do
    transition { :s14 }
  end
  
  state :s17 do
    transition { :s18 }
  end
  
  state :s18 do
    transition { :s19 }
  end
  
  state :s19 do
    transition 'procedure' do
      :s20
    end
    transition do
      sub_machine Statement
      :s25
    end
  end
  
  state :s20 do
    transition 'identifier' do |token|
      self.procedure_name = token.value
      :s21
    end
  end
  
  state :s21 do
    transition ';' do
      :s22
    end
  end
  
  state :s22 do
    transition do
      sub_machine(Block, context.sub_context(procedure_name))
      :s23
    end
  end
  
  state :s23 do
    transition ';' do
      self.procedure_name = nil
      :s24
    end
  end
  
  state :s24 do
    transition { :s19 }
  end
  
  final_state :s25

end