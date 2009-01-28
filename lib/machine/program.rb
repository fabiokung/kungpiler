require "lib/state_machine"
require "lib/machine/block"

class Program
  include StateMachine
  
  initial_state :s0 do
    transition do
      sub_machine Block
      :s1
    end
  end
  
  state :s1 do
    transition '.' do
      :s2
    end
  end
  
  final_state :s2

end