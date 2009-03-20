PL/0 Compiler, written in Ruby
==============================

This is a simple *one-step* compiler, which generates valid **Java Bytecode**, written in Ruby.

More details can be found in the relatorio.pdf (pt-BR) document, but here is a summary:

- [RSpec](http://rspec.info) Specifications (Example Groups in `test` folder) are a good place to learn how the compiler should work.
- Sample PL/0 programs can be found in the `test/fixtures` directory.
- Automata (Finite State Machines) I'm using to parse code can be found in the `lib/machine` directory. They follow a domain specific I've created in this project (`lib/state_machine.rb`) to describe automata.
- I am not using any parser generator, just because I wanted to deep learn how compilers work.
- The compiler generates Java Mnemonics, which are converted to Java Bytecode by the [Jasmin assembler](http://jasmin.sourceforge.net/).
- The PL/0 grammar I'm following can be seen in the `grammar.wirth` file. It is written in the [Wirth Syntax Notation](http://en.wikipedia.org/wiki/Wirth_syntax_notation).
