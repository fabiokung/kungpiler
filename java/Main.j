.source Main.j
.class  public Main
.super  java/lang/Object

;
; standard initializer (calls java.lang.Object's initializer)
;
.method public <init>()V
   aload_0
   invokenonvirtual java/lang/Object/<init>()V
   return
.end method

.method public static main([Ljava/lang/String;)V
  .limit stack 6
  .limit locals 1
  
  getstatic java/lang/System/out Ljava/io/PrintStream;
  ldc "Oi Mundo!"
  invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
  
  return
.end method
