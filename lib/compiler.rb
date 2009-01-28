require "lib/lexer"
require "lib/source_reader"
require "lib/compilation_context"
require "lib/state_machine"

class Compiler
  
  attr_reader :output_file
  
  def initialize(machine, source_file, output_file = 'Main')
    @source_file = source_file
    @output_file = output_file
    @reader = SourceReader.new(:file => source_file)
    @lexer = Lexer.new(@reader)
    @context = CompilationContext.new(self)
    @analyser_machine = machine.new(@lexer, @context)
  end
  
  def compile
    @analyser_machine.start
    
    code = <<-HEADER
.source #{@source_file}
.class  public #{@output_file}
.super  java/lang/Object

.field public static final READER Ljava/io/BufferedReader;
    HEADER

    @context.each_field do |field|
      if field.kind_of?(Array)
        code << ".field public static final #{field[0]} I = #{field[1]}\n"
      else
        code << ".field static #{field} I\n"
      end
    end
    
    code << <<-STATIC
.method public static getReader()Ljava/io/BufferedReader;
  .limit stack 6
  .limit locals 1
  
  getstatic #{@context.class_name}/READER Ljava/io/BufferedReader;
  ifnonnull #_Returning
  
  new java/io/BufferedReader
  dup
  new java/io/InputStreamReader
  dup
  getstatic java/lang/System/in Ljava/io/InputStream;
  invokespecial java/io/InputStreamReader/<init>(Ljava/io/InputStream;)V
  invokespecial java/io/BufferedReader/<init>(Ljava/io/Reader;)V
  putstatic #{@context.class_name}/READER Ljava/io/BufferedReader;

#_Returning:  
  getstatic #{@context.class_name}/READER Ljava/io/BufferedReader;
  areturn
.end method
    
    STATIC
    
    code << <<-CONSTRUCTOR
.method public <init>()V
  aload_0
  invokenonvirtual java/lang/Object/<init>()V
  return
.end method
    
    CONSTRUCTOR

    code << <<-MAIN
.method public static main([Ljava/lang/String;)V
  .limit stack #{@context.stack_size}
  .limit locals #{@context.locals_size}

#{@context.code}
  return
.end method

    MAIN
    
    @context.each_method do |met|
      code << <<-METHOD
.method public static #{met.name}()V
  .limit stack #{met.stack_size}
  .limit locals #{met.locals_size}
  
#{met.code}
  return
.end method

      METHOD
    end
    
    print code if $DEBUG
    File.open(@output_file + '.j', "w") do |f|
      f << code
    end
  end
end
