require "lib/state_machine"

class AritmeticExpression
  include StateMachine
  
  attr_accessor :invert_signal
  
  def pending_operations
    @pending_operations ||= []
  end
  
  ## STATES
  
  initial_state :s0 do
    transition '+' do
      self.invert_signal = false
      :s1
    end
    transition '-' do
      self.invert_signal = true
      :s2
    end
    transition do
      self.invert_signal = false
      :s3
    end
  end
  
  state :s1 do
    transition { :s3 }
  end
  state :s2 do
    transition { :s3 }
  end
  
  state :s3 do
    transition 'identifier' do |token|
      # take the variable value
      var_field = context[token.value]
      context << "getstatic #{context.class_name}/#{var_field} I"
      :s4
    end
    transition 'number' do |token|
      context << "ldc #{token.value}"
      :s5
    end
    transition '(' do
      :s6
    end
  end
  
  state :s4 do
    transition { :s9 }
  end
  state :s5 do
    transition { :s9 }
  end
  
  state :s6 do
    transition do
      sub_machine AritmeticExpression
      :s7
    end
  end
  
  state :s7 do
    transition ')' do
      :s8
    end
  end
  
  state :s8 do
    transition { :s9 }
  end
  state :s9 do
    context << "ineg" if invert_signal
    transition { :s10 }
  end
  
  state :s10 do
    transition '*' do
      pending_operations.push "imul"
      :s11
    end
    transition '/' do
      pending_operations.push "idiv"
      :s12
    end
    transition do
      :s19
    end
  end
  
  state :s11 do
    transition { :s13 }
  end
  state :s12 do
    transition { :s13 }
  end
  
  state :s13 do
    transition 'identifier' do |token|
      var_field = context[token.value]
      context << "getstatic #{context.class_name}/#{var_field} I"
      :s14
    end
    transition 'number' do |token|
      context << "ldc #{token.value}"
      :s15
    end
    transition '(' do
      :s16
    end
  end
  
  state :s14 do
    transition { :s13b }
  end
  state :s15 do
    transition { :s13b }
  end
  
  state :s16 do
    transition do
      sub_machine AritmeticExpression
      :s17
    end
  end
  
  state :s17 do
    transition ')' do
      :s18
    end
  end
  
  state :s18 do
    transition { :s13b }
  end
  
  state :s13b do
    transition do
      context << pending_operations.pop
      :s10
    end
  end
  
  final_state :s19 do
    transition '+' do
      pending_operations.push "iadd"
      :s20
    end
    transition '-' do
      pending_operations.push "isub"
      :s21
    end
  end
  
  state :s20 do
    transition { :s22 }
  end
  state :s21 do
    transition { :s22 }
  end

  state :s22 do
    transition 'identifier' do |token|
      var_field = context[token.value]
      context << "getstatic #{context.class_name}/#{var_field} I"
      :s23
    end
    transition 'number' do |token|
      context << "ldc #{token.value}"
      :s24
    end
    transition '(' do
      :s25
    end
  end
  
  state :s23 do
    transition { :s28 }
  end
  state :s24 do
    transition { :s28 }
  end
  
  state :s25 do
    transition do
      sub_machine AritmeticExpression
      :s26
    end
  end
  
  state :s26 do
    transition ')' do
      :s27
    end
  end
  
  state :s27 do
    transition { :s28 }
  end
  state :s28 do
    transition { :s29 }
  end
  
  state :s29 do
    transition '*' do
      pending_operations.push "imul"
      :s30
    end
    transition '/' do
      pending_operations.push "idiv"
      :s31
    end
    transition do
      context << pending_operations.pop
      :s19
    end
  end
  
  state :s30 do
    transition { :s32 }
  end
  state :s31 do
    transition { :s32 }
  end
  
  state :s32 do
    transition 'identifier' do |token|
      var_field = context[token.value]
      context << "getstatic #{context.class_name}/#{var_field} I"
      :s35
    end
    transition 'number' do |token|
      context << "ldc #{token.value}"
      :s36
    end
    transition '(' do
      :s37
    end
  end
  
  state :s35 do
    transition { :s39 }
  end
  state :s36 do
    transition { :s39 }
  end
  
  state :s37 do
    transition do
      sub_machine AritmeticExpression
      :s38
    end
  end
  
  state :s38 do
    transition ')' do
      :s39
    end
  end
  
  state :s39 do
    transition do
      context << pending_operations.pop
      :s29
    end
  end
end
