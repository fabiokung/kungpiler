#!/usr/bin/env ruby

require "lib/compiler"
require "lib/machine/program"

if ARGV.size < 2
  puts <<-USAGE
  
Usage: compile[.bat|.sh] <source-file> <output-file> [true | false]

The compiler will produce two output files: <output-file>.j and <output-file>.class, 
whose are the java bytecode assembly and java executable (binary) bytecode, respectively.

The last parameter enables debugging info and is opcional. Default is false.
Debug info will show each automaton transition and consumed tokens and the generated 
code will be also printed in the end.

You should be able to run the executable java class file with:

java <output-file>

  USAGE
  
  return
end

$DEBUG = ARGV[2] || false

compiler = Compiler.new(Program, ARGV[0], ARGV[1])
compiler.compile

`java -cp jasmin-2.3/jasmin.jar Jasmin #{ARGV[1]}.j`
