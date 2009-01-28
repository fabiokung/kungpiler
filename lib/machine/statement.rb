require "lib/state_machine"
require "lib/machine/aritmetic_expression"

class Statement
  include StateMachine
  
  attr_accessor :assignment_field, :if_begin_label, :if_end_label, 
                :while_test_label, :while_begin_label, :while_end_label
  
  def pending_operations
    @pending_operations ||= []
  end
  
  # STATES
  
  initial_state :s0 do
    transition 'identifier' do |token|
      self.assignment_field = context[token.value]
      :s2
    end
    transition 'call' do
      :s5
    end
    transition 'out' do
      :s37
    end
    transition 'in' do
      :s39
    end
    transition 'begin' do
      :s7
    end
    transition 'if' do
      :s13
    end
    transition 'while' do
      :s25
    end
    transition do
      :s1
    end
  end
  
  final_state :s1
  
  state :s2 do
    transition ':=' do
      :s3
    end
  end
  
  state :s3 do
    transition do
      sub_machine AritmeticExpression
      context << "putstatic #{context.class_name}/#{assignment_field} I"
      :s4
    end
  end
  
  state :s4 do
    transition do
      self.assignment_field = nil
      :s1
    end
  end
  
  state :s5 do
    transition 'identifier' do |token|
      context << "invokestatic #{context.class_name}/#{token.value}()V"
      :s6
    end
  end
  
  state :s6 do
    transition { :s1 }
  end
  
  state :s7 do
    transition do
      sub_machine Statement
      :s8
    end
  end
  
  state :s8 do
    transition { :s9 }
  end
  
  state :s9 do
    transition ';' do
      :s10
    end
    transition 'end' do
      :s12
    end
  end
  
  state :s10 do
    transition do
      sub_machine Statement
      :s11
    end
  end
  
  state :s11 do
    transition { :s9 }
  end
  state :s12 do
    transition { :s1 }
  end
  
  state :s13 do
    transition do
      sub_machine AritmeticExpression
      :s14
    end
  end
  
  state :s14 do
    transition '=' do
      pending_operations.push "if_icmpeq"
      :s16
    end
    transition '#' do
      pending_operations.push "if_icmpne"
      :s17
    end
    transition '<' do
      pending_operations.push "if_icmplt"
      :s18
    end
    transition '<=' do
      pending_operations.push "if_icmple"
      :s19
    end
    transition '>' do
      pending_operations.push "if_icmpgt"
      :s20
    end
    transition '>=' do
      pending_operations.push "if_icmpge"
      :s21
    end
  end
  
  state :s16 do
    transition { :s15 }
  end
  state :s17 do
    transition { :s15 }
  end
  state :s18 do
    transition { :s15 }
  end
  state :s19 do
    transition { :s15 }
  end
  state :s20 do
    transition { :s15 }
  end
  state :s21 do
    transition { :s15 }
  end
  
  state :s15 do
    transition do
      sub_machine AritmeticExpression
      :s22
    end
  end
  
  state :s22 do
    transition 'then' do
      self.if_begin_label = context.next_label
      self.if_end_label = context.next_label
      context << "#{pending_operations.pop} #{if_begin_label}"
      context << "goto #{if_end_label}"
      :s23
    end
  end
  
  state :s23 do
    transition do
      context << "#{if_begin_label}:"
      sub_machine Statement
      context << "#{if_end_label}:"
      :s24
    end
  end
  
  state :s24 do
    transition do
      self.if_begin_label = nil
      self.if_end_label = nil
      context << "nop"
      :s1
    end
  end
  
  state :s25 do
    transition do
      self.while_test_label = context.next_label
      self.while_begin_label = context.next_label
      self.while_end_label = context.next_label
      
      context << "#{while_test_label}:"
      sub_machine AritmeticExpression
      :s26
    end
  end
  
  state :s26 do
    transition '=' do
      pending_operations.push "if_icmpeq"
      :s28
    end
    transition '#' do
      pending_operations.push "if_icmpne"
      :s29
    end
    transition '<' do
      pending_operations.push "if_icmplt"
      :s30
    end
    transition '<=' do
      pending_operations.push "if_icmple"
      :s31
    end
    transition '>' do
      pending_operations.push "if_icmpgt"
      :s32
    end
    transition '>=' do
      pending_operations.push "if_icmpge"
      :s33
    end
  end
  
  state :s28 do
    transition { :s27 }
  end
  state :s29 do
    transition { :s27 }
  end
  state :s30 do
    transition { :s27 }
  end
  state :s31 do
    transition { :s27 }
  end
  state :s32 do
    transition { :s27 }
  end
  state :s33 do
    transition { :s27 }
  end
  
  state :s27 do
    transition do
      sub_machine AritmeticExpression
      :s34
    end
  end
  
  state :s34 do
    transition 'do' do
      context << "#{pending_operations.pop} #{while_begin_label}"
      context << "goto #{while_end_label}"
      :s35
    end
  end
  
  state :s35 do
    transition do
      context << "#{while_begin_label}:"
      sub_machine Statement
      context << "goto #{while_test_label}"
      context << "#{while_end_label}:"
      :s36
    end
  end
  
  state :s36 do
    transition { :s1 }
  end
  
  state :s37 do
    transition do
      context << "getstatic java/lang/System/out Ljava/io/PrintStream;"
      sub_machine AritmeticExpression
      :s38
    end
  end
  
  state :s38 do
    transition do
      context << "invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;"
      context << "invokevirtual java/lang/Object/toString()Ljava/lang/String;"
      context << "invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V"
      :s1
    end
  end
  
  state :s39 do
    transition 'identifier' do |token|
      context << "invokestatic #{context.class_name}/getReader()Ljava/io/BufferedReader;"
      context << "invokevirtual java/io/BufferedReader/readLine()Ljava/lang/String;"
      context << "invokestatic java/lang/Integer/valueOf(Ljava/lang/String;)Ljava/lang/Integer;"
      context << "invokevirtual java/lang/Integer/intValue()I"
      context << "putstatic #{context.class_name}/#{context[token.value]} I"
      :s40
    end
  end
  
  state :s40 do
    transition { :s1 }
  end
end