require "lib/compiler"
require "lib/machine/aritmetic_expression"
require "lib/machine/statement"
require "lib/machine/block"
require "lib/machine/program"

describe Compiler do
  
  it "should compile aritmetic expressions" do
    compiler = Compiler.new(AritmeticExpression, 
                            'test/fixtures/aritmetic_expression.pl0', 
                            'examples/aritmetic-expression')
    compiler.compile
  end
  
  it "should compile statements" do
    compiler = Compiler.new(Statement, 'test/fixtures/statement.pl0', 'examples/statement')
    compiler.compile
  end
  
  it "should compile simple programs" do
    compiler = Compiler.new(Program, 'test/fixtures/simple-example.pl0', 'examples/simple')
    compiler.compile
  end
  
  it "should compile complex programs" do
    compiler = Compiler.new(Program, 'test/fixtures/complex-example.pl0', 'examples/complex')
    compiler.compile
  end
  
end
