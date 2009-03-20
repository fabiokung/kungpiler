PL/0 Compiler, written in Ruby
==============================

This is a simple *one-step* compiler, which generates valid **Java Bytecode**, written in Ruby.

More details can be found in the `relatorio-compilador.pdf` (pt-BR) document, but here is a summary:

- [RSpec](http://rspec.info) Specifications (Example Groups in `test` folder) are a good place to learn how the compiler should work.
- Sample PL/0 programs can be found in the `test/fixtures` directory.
- Automata (Finite State Machines) I'm using to parse code can be found in the `lib/machine` directory. They follow a domain specific I've created in this project (`lib/state_machine.rb`) to describe automata.
- I am not using any parser generator, just because I wanted to deep learn how compilers work.
- The compiler generates Java Mnemonics, which are converted to Java Bytecode by the [Jasmin assembler](http://jasmin.sourceforge.net/).
- The PL/0 grammar I'm following can be seen in the `grammar.wirth` file. It is written in the [Wirth Syntax Notation](http://en.wikipedia.org/wiki/Wirth_syntax_notation).

Compiler Usage
==============

The `compile.rb` file acts as the compilation entry point; it starts the hole process. The `lib/` folder has the source code for all classes and the `test/` folder has unit tests, using [RSpec](http://rspec.info).

Minimum Requirements
--------------------

- Java Runtime Environment (JRE) >= 1.5 (http://java.sun.com); the `java` command must be available in the `$PATH` environment variable.

Recommended Requirements
------------------------

- Java Development Kit (JDK) >= 1.5 (http://java.sun.com);
- Ruby interpreter >= 1.8.5 (http://www.ruby-lang.org);
- `java`, `ruby` and `rake` commands must be in the `$PATH`;
- RubyGems (http://www.rubygems.org/read/chapter/3) - `gem` command available in `$PATH`.

Running with the minimum requirements
-------------------------------------

JRuby, the Ruby interpreter written n Java, is embedded in the compiler  for machines with only the Java Runtime Environment installed. In this case, Ruby code is executed by the JVM.

- inside of the compiler folder, create a new PL/0 folder. There are some examples available in the `test/fixtures` folder;
- to see the compiler usage instructions, run the `compile.bat` file inside some shell (cmd inside Windows, or sh inside unixes);
- still in the terminal window, to compile your PL/0 source:

  compile <source> <output>
  compile program.pl0 compiled

- in this case, the compiler generates two files: compiled.j (Jasmin Mnemonics) and compiled.class (executable Java bytecode, assembled by Jasmin);
- to run the generated class, invoke the Java Virtual Machine:

  java compiled

Running with Ruby interpreter installed
---------------------------------------

- to run the compiler, use the compile.rb script:

  ruby compile.rb <source> <output>
      
- if you want to run the rspec tests in the `test/` folder, just run `rake test`;
- spare some time reading the tests :-)

If you have some problem running the compiler, here is the full command line to be used:

  java -cp jruby.jar org.jruby.Main compile.rb <source> <output>
