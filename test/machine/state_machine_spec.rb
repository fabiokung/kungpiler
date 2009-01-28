require "lib/lexer"
require "lib/state_machine"

require "test/machine/test_machine"

describe "StateMachine" do

  def token(type)
    Token.new :type => type, :value => type
  end

  before(:each) do
    @lexer = mock(Lexer)
    @counter = mock("TransitionCounter")
    @context = mock("CompilationContext")
    @machine = TestMachine.new(@lexer, @context, @counter)
  end
  
  it "should raise error for invalid sequences" do
    @lexer.should_receive(:next_token).and_return(token('+'), token('identifier'), token('#'))
    @counter.should_receive(:s0_t2_called).once
    @counter.should_receive(:s2_t1_called).once
    
    lambda { @machine.start }.should raise_error("Unexpected token: (#, #)")
  end
  
  it "should end in the final state for valid input" do
    @lexer.should_receive(:next_token).and_return(token('+'), token('identifier'), token('.'))
    @lexer.should_receive(:lookahead).once.and_return(nil)
    @counter.should_receive(:s0_t1_called).once
    @counter.should_receive(:s0_t2_called).once
    @counter.should_receive(:s2_t1_called).once
    
    @machine.start
    @machine.actual_state.should eql(:s1)
  end
  
  it "should call the transitions many times for big inputs" do
    tokens = [ token('+'), token('identifier'), token('+'), token('identifier'), 
               token('+'), token('identifier'), token('.') ]
    @lexer.should_receive(:next_token).and_return(*tokens)
    @lexer.should_receive(:lookahead).once.and_return(nil)
    @counter.should_receive(:s0_t1_called).once
    @counter.should_receive(:s0_t2_called).exactly(3).times
    @counter.should_receive(:s2_t1_called).exactly(3).times
    
    @machine.start
    @machine.actual_state.should eql(:s1)
  end
  
  it "should call just only transition for small input" do
    @lexer.should_receive(:next_token).and_return(token('.'))
    @lexer.should_receive(:lookahead).once.and_return(nil)
    @counter.should_receive(:s0_t1_called).once
    
    @machine.start
    @machine.actual_state.should eql(:s1)
  end
  
  it "should raise error for incomplete inputs" do
    @lexer.should_receive(:next_token).and_return(token('+'), token('identifier'), nil)
    @counter.should_receive(:s0_t2_called).once
    @counter.should_receive(:s2_t1_called).once
    
    lambda { @machine.start }.should raise_error("Unexpected token: ")
  end
  
  it "should exit a final state if there is more input" do
    tokens = [ token('+'), token('identifier'), token(','), token('*'), token('identifier'), token(',') ]
    @lexer.should_receive(:next_token).and_return(*tokens)
    @lexer.should_receive(:lookahead).twice.and_return('identifier', nil)
    @counter.should_receive(:s0_t2_called).once
    @counter.should_receive(:s0_t3_called).twice
    @counter.should_receive(:s2_t1_called).twice
    @counter.should_receive(:s3_t1_called).once
    
    @machine.start
    @machine.actual_state.should eql(:s3)
  end
  
end
