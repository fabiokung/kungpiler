.source test/fixtures/aritmetic_expression.pl0
.class  public examples/aritmetic-expression
.super  java/lang/Object

.field public static final READER Ljava/io/BufferedReader;
.method public static getReader()Ljava/io/BufferedReader;
  .limit stack 6
  .limit locals 1
  
  getstatic examples/aritmetic-expression/READER Ljava/io/BufferedReader;
  ifnonnull #_Returning
  
  new java/io/BufferedReader
  dup
  new java/io/InputStreamReader
  dup
  getstatic java/lang/System/in Ljava/io/InputStream;
  invokespecial java/io/InputStreamReader/<init>(Ljava/io/InputStream;)V
  invokespecial java/io/BufferedReader/<init>(Ljava/io/Reader;)V
  putstatic examples/aritmetic-expression/READER Ljava/io/BufferedReader;

#_Returning:  
  getstatic examples/aritmetic-expression/READER Ljava/io/BufferedReader;
  areturn
.end method
    
.method public <init>()V
  aload_0
  invokenonvirtual java/lang/Object/<init>()V
  return
.end method
    
.method public static main([Ljava/lang/String;)V
  .limit stack 16
  .limit locals 1

  ldc 3
  ldc 2
  ldc 1
  imul
  ldc 1
  ldc 10
  isub
  imul
  iadd
  ldc 102
  iadd
  ineg
  ldc 32
  ldc 88
  imul
  iadd

  return
.end method

