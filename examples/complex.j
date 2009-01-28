.source test/fixtures/complex-example.pl0
.class  public examples/complex
.super  java/lang/Object

.field public static final READER Ljava/io/BufferedReader;
.field static main_x I
.field public static final main_m I = 7
.field static main_y I
.field public static final main_n I = 85
.field static main_z I
.field static main_q I
.field static main_r I
.field static main_@scope_w I
.field static main_@scope_f I
.field static main_@scope_g I
.method public static getReader()Ljava/io/BufferedReader;
  .limit stack 6
  .limit locals 1
  
  getstatic examples/complex/READER Ljava/io/BufferedReader;
  ifnonnull #_Returning
  
  new java/io/BufferedReader
  dup
  new java/io/InputStreamReader
  dup
  getstatic java/lang/System/in Ljava/io/InputStream;
  invokespecial java/io/InputStreamReader/<init>(Ljava/io/InputStream;)V
  invokespecial java/io/BufferedReader/<init>(Ljava/io/Reader;)V
  putstatic examples/complex/READER Ljava/io/BufferedReader;

#_Returning:  
  getstatic examples/complex/READER Ljava/io/BufferedReader;
  areturn
.end method
    
.method public <init>()V
  aload_0
  invokenonvirtual java/lang/Object/<init>()V
  return
.end method
    
.method public static main([Ljava/lang/String;)V
  .limit stack 60
  .limit locals 1

  ldc 25
  putstatic examples/complex/main_x I
  ldc 3
  putstatic examples/complex/main_y I
  invokestatic examples/complex/divide()V
  ldc 84
  putstatic examples/complex/main_x I
  ldc 36
  putstatic examples/complex/main_y I
  invokestatic examples/complex/gcd()V
  getstatic java/lang/System/out Ljava/io/PrintStream;
  getstatic examples/complex/main_z I
  invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
  invokevirtual java/lang/Object/toString()Ljava/lang/String;
  invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V

  return
.end method

.method public static divide()V
  .limit stack 124
  .limit locals 1
  
  getstatic examples/complex/main_x I
  putstatic examples/complex/main_r I
  ldc 0
  putstatic examples/complex/main_q I
  getstatic examples/complex/main_y I
  putstatic examples/complex/main_@scope_w I
  #main_@scope_1:
  getstatic examples/complex/main_@scope_w I
  getstatic examples/complex/main_r I
  if_icmple #main_@scope_2
  goto #main_@scope_3
  #main_@scope_2:
  ldc 2
  getstatic examples/complex/main_@scope_w I
  imul
  putstatic examples/complex/main_@scope_w I
  goto #main_@scope_1
  #main_@scope_3:
  #main_@scope_4:
  getstatic examples/complex/main_@scope_w I
  getstatic examples/complex/main_y I
  if_icmpgt #main_@scope_5
  goto #main_@scope_6
  #main_@scope_5:
  ldc 2
  getstatic examples/complex/main_q I
  imul
  putstatic examples/complex/main_q I
  getstatic examples/complex/main_@scope_w I
  ldc 2
  idiv
  putstatic examples/complex/main_@scope_w I
  getstatic examples/complex/main_@scope_w I
  getstatic examples/complex/main_r I
  if_icmple #main_@scope_7
  goto #main_@scope_8
  #main_@scope_7:
  getstatic examples/complex/main_r I
  getstatic examples/complex/main_@scope_w I
  isub
  putstatic examples/complex/main_r I
  getstatic examples/complex/main_q I
  ldc 1
  iadd
  putstatic examples/complex/main_q I
  #main_@scope_8:
  nop
  goto #main_@scope_4
  #main_@scope_6:
  getstatic java/lang/System/out Ljava/io/PrintStream;
  getstatic examples/complex/main_q I
  invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
  invokevirtual java/lang/Object/toString()Ljava/lang/String;
  invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V

  return
.end method

.method public static gcd()V
  .limit stack 92
  .limit locals 1
  
  getstatic examples/complex/main_x I
  putstatic examples/complex/main_@scope_f I
  getstatic examples/complex/main_y I
  putstatic examples/complex/main_@scope_g I
  #main_@scope_1:
  getstatic examples/complex/main_@scope_f I
  getstatic examples/complex/main_@scope_g I
  if_icmpne #main_@scope_2
  goto #main_@scope_3
  #main_@scope_2:
  getstatic examples/complex/main_@scope_f I
  getstatic examples/complex/main_@scope_g I
  if_icmplt #main_@scope_4
  goto #main_@scope_5
  #main_@scope_4:
  getstatic examples/complex/main_@scope_g I
  getstatic examples/complex/main_@scope_f I
  isub
  putstatic examples/complex/main_@scope_g I
  #main_@scope_5:
  nop
  getstatic examples/complex/main_@scope_g I
  getstatic examples/complex/main_@scope_f I
  if_icmplt #main_@scope_6
  goto #main_@scope_7
  #main_@scope_6:
  getstatic examples/complex/main_@scope_f I
  getstatic examples/complex/main_@scope_g I
  isub
  putstatic examples/complex/main_@scope_f I
  #main_@scope_7:
  nop
  goto #main_@scope_1
  #main_@scope_3:
  getstatic examples/complex/main_@scope_f I
  putstatic examples/complex/main_z I

  return
.end method

