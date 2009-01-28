#!/usr/bin/env ruby
#
#  Created by Fabio  Correia Kung on 2007-09-17.
#  Copyright (c) 2007. All rights reserved.
require "lib/lexer"
require "lib/token"

def token(type, value)
  Token.new :type => type, :value => value
end

describe Lexer, " as token generator" do
  @@expected_tokens = [
    token('var', 'VAR'), token('identifier', 'x'), token(',', ','), 
    token('identifier', 'squ'), token(';', ';'),
    token('procedure', 'PROCEDURE'), token('identifier', 'square'), token(';', ';'),
    token('begin', 'BEGIN'), token('identifier', 'squ'), token(':=', ':='), token('identifier', 'x'),
    token('*', '*'), token('identifier', 'x'), token('end', 'END'), token(';', ';') ]
  
  before :each do
    @source_reader = SourceReader.new(:file => "test/fixtures/simple-example.pl0")
    @lexer = Lexer.new(@source_reader)
  end
  
  it "should read and classify tokens" do
    @@expected_tokens.each do |expected|
      read = @lexer.next_token
      # p read
      read.type.should == expected.type
      read.value.should == expected.value
    end
  end
  # 
  # it "should classify - as operator" do
  #   @source_reader.stub!(:read_words).and_return ["-"]
  #   tokens = @analyser.generate_tokens
  #   tokens.should_not be_nil
  #   tokens.size.should == 1
  #   tokens[0].type.should  == "operator"
  #   tokens[0].value.should == "-"
  # end
  # 
  # it "should classify * as operator" do
  #   @source_reader.stub!(:read_words).and_return ["*"]
  #   tokens = @analyser.generate_tokens
  #   tokens.should_not be_nil
  #   tokens.size.should == 1
  #   tokens[0].type.should  == "operator"
  #   tokens[0].value.should == "*"
  # end
  # 
  # it "should classify / as operator" do
  #   @source_reader.stub!(:read_words).and_return ["/"]
  #   tokens = @analyser.generate_tokens
  #   tokens.should_not be_nil
  #   tokens.size.should == 1
  #   tokens[0].type.should  == "operator"
  #   tokens[0].value.should == "/"
  # end
  # 
  # it "should classify ^ as operator" do
  #   @source_reader.stub!(:read_words).and_return ["^"]
  #   tokens = @analyser.generate_tokens
  #   tokens.should_not be_nil
  #   tokens.size.should == 1
  #   tokens[0].type.should  == "operator"
  #   tokens[0].value.should == "^"
  # end
  
end