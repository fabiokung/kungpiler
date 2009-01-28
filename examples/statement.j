.source test/fixtures/statement.pl0
.class  public examples/statement
.super  java/lang/Object

.field public static final READER Ljava/io/BufferedReader;
.method public static getReader()Ljava/io/BufferedReader;
  .limit stack 6
  .limit locals 1
  
  getstatic examples/statement/READER Ljava/io/BufferedReader;
  ifnonnull #_Returning
  
  new java/io/BufferedReader
  dup
  new java/io/InputStreamReader
  dup
  getstatic java/lang/System/in Ljava/io/InputStream;
  invokespecial java/io/InputStreamReader/<init>(Ljava/io/InputStream;)V
  invokespecial java/io/BufferedReader/<init>(Ljava/io/Reader;)V
  putstatic examples/statement/READER Ljava/io/BufferedReader;

#_Returning:  
  getstatic examples/statement/READER Ljava/io/BufferedReader;
  areturn
.end method
    
.method public <init>()V
  aload_0
  invokenonvirtual java/lang/Object/<init>()V
  return
.end method
    
.method public static main([Ljava/lang/String;)V
  .limit stack 68
  .limit locals 1

  ldc 1
  ldc 2
  ldc 1
  imul
  iadd
  ldc 2
  ldc 1
  idiv
  if_icmpgt #main_1
  goto #main_2
  #main_1:
  getstatic java/lang/System/out Ljava/io/PrintStream;
  ldc 1
  invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
  invokevirtual java/lang/Object/toString()Ljava/lang/String;
  invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
  #main_2:
  nop
  ldc 2
  ldc 3
  iadd
  ldc 4
  iadd
  ldc 5
  if_icmplt #main_3
  goto #main_4
  #main_3:
  getstatic java/lang/System/out Ljava/io/PrintStream;
  ldc 2
  invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
  invokevirtual java/lang/Object/toString()Ljava/lang/String;
  invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
  #main_4:
  nop
  #main_5:
  ldc 1
  ldc 2
  if_icmpgt #main_6
  goto #main_7
  #main_6:
  getstatic java/lang/System/out Ljava/io/PrintStream;
  ldc 3
  invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
  invokevirtual java/lang/Object/toString()Ljava/lang/String;
  invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
  goto #main_5
  #main_7:

  return
.end method

