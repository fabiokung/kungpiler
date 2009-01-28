require "lib/state_machine"

describe StateMachine::Transitions do

  before(:each) do
    @state_machine = mock(StateMachine)
    @state = :s10
    @transitions = StateMachine::Transitions.new(@state_machine, @state)
  end
  
  it "should delegate all state calls to the machine" do
    @state_machine.should_receive(:s0).once
    @state_machine.should_receive(:s1).twice
    @transitions.s0
    @transitions.s1
    @transitions.s1
  end
  
  it "is deterministic if has only the empty transition" do
    @transitions.transition do
      # nothing
    end
    @transitions.deterministic?.should be_true
  end
  
  it "is deterministic if has transitions but no empty transition" do
    @transitions.transition '+' do
      # nothing
    end
    @transitions.transition 'identifier' do
      # nothing
    end
    @transitions.deterministic?.should be_true
  end
  
  it "is not deterministic if has normal and empty transitions" do
    @transitions.transition '*' do
      # nothing
    end
    @transitions.transition do
      # nothing
    end
    @transitions.deterministic?.should be_false
  end
  
  it "should tell if has only the empty transition" do
    @transitions.transition do
      # nothing
    end
    @transitions.has_only_empty?.should be_true
  end
  
  it "should tell that has not only the empty transition if has only normal transitions" do
    @transitions.transition '/' do
      # nothing
    end
    @transitions.transition '#' do
      # nothing
    end
    @transitions.has_only_empty?.should be_false
  end
  
  it "should tell that has not only the empty transition if has others" do
    @transitions.transition '-' do
      # nothing
    end
    @transitions.transition do
      # nothing
    end
    @transitions.has_only_empty?.should be_false
  end

  it "should raise error if the transition has already been defined" do
    @transitions.transition '-' do
      # nothing
    end
    lambda {
      @transitions.transition '-' do
        # nothing
      end
    }.should raise_error("transition for - already defined for the state: s10")
  end
  
  it "should tell if has the transition" do
    @transitions.transition '*' do
      # nothing
    end
    @transitions.has?('*').should be_true
  end

  it "should tell if has not the transition" do
    @transitions.transition '/' do
      # nothing
    end
    @transitions.transition do
      # nothing
    end
    @transitions.has?('*').should be_false
  end
  
  it "should raise error if unexistent transition has been choosen" do
    @transitions.transition '/' do
      # nothing
    end
    lambda {
      @transitions.choose('*')
    }.should raise_error("Unexpected token: *")
  end
  
  it "should call the choosen transition and go to the returned state" do
    block_called = false
    t = lambda { block_called = true; :s0 }
    @state_machine.should_receive(:s0).once
    
    @transitions.transition '+', &t
    @transitions.choose('+')
    
    block_called.should be_true
  end  
end
