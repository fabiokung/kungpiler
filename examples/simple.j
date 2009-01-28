.source test/fixtures/simple-example.pl0
.class  public examples/simple
.super  java/lang/Object

.field public static final READER Ljava/io/BufferedReader;
.field static main_squ I
.field static main_x I
.method public static getReader()Ljava/io/BufferedReader;
  .limit stack 6
  .limit locals 1
  
  getstatic examples/simple/READER Ljava/io/BufferedReader;
  ifnonnull #_Returning
  
  new java/io/BufferedReader
  dup
  new java/io/InputStreamReader
  dup
  getstatic java/lang/System/in Ljava/io/InputStream;
  invokespecial java/io/InputStreamReader/<init>(Ljava/io/InputStream;)V
  invokespecial java/io/BufferedReader/<init>(Ljava/io/Reader;)V
  putstatic examples/simple/READER Ljava/io/BufferedReader;

#_Returning:  
  getstatic examples/simple/READER Ljava/io/BufferedReader;
  areturn
.end method
    
.method public <init>()V
  aload_0
  invokenonvirtual java/lang/Object/<init>()V
  return
.end method
    
.method public static main([Ljava/lang/String;)V
  .limit stack 56
  .limit locals 1

  invokestatic examples/simple/getReader()Ljava/io/BufferedReader;
  invokevirtual java/io/BufferedReader/readLine()Ljava/lang/String;
  invokestatic java/lang/Integer/valueOf(Ljava/lang/String;)Ljava/lang/Integer;
  invokevirtual java/lang/Integer/intValue()I
  putstatic examples/simple/main_x I
  #main_1:
  getstatic examples/simple/main_x I
  ldc 10
  if_icmple #main_2
  goto #main_3
  #main_2:
  invokestatic examples/simple/square()V
  getstatic java/lang/System/out Ljava/io/PrintStream;
  getstatic examples/simple/main_squ I
  invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
  invokevirtual java/lang/Object/toString()Ljava/lang/String;
  invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
  getstatic examples/simple/main_x I
  ldc 1
  iadd
  putstatic examples/simple/main_x I
  goto #main_1
  #main_3:

  return
.end method

.method public static square()V
  .limit stack 16
  .limit locals 1
  
  getstatic examples/simple/main_x I
  getstatic examples/simple/main_x I
  imul
  putstatic examples/simple/main_squ I

  return
.end method

