require "lib/source_reader"
require "lib/token"

class Lexer
  # Available Tokens: 
  # CONST VAR PROCEDURE CALL BEGIN END IF THEN WHILE DO 
  # = # < <= > >= , ; ( ) := + - * / ident number
  
  # classification rules
  @@rules = {
    # regex => token
    /^\.$/ => '.',
    /^CONST$/ => 'const',
    /^VAR$/ => 'var',
    /^PROCEDURE$/ => 'procedure',
    /^CALL$/ => 'call',
    /^OUT$/ => 'out',
    /^IN$/ => 'in',
    /^BEGIN$/ => 'begin',
    /^END$/ => 'end',
    /^IF$/ => 'if',
    /^THEN$/ => 'then',
    /^WHILE$/ => 'while',
    /^DO$/ => 'do',
    /^\=$/ => '=',
    /^\#$/ => '#',
    /^<=$/ => '<=',
    /^<$/ => '<',
    /^>=$/ => '>=',
    /^>$/ => '>',
    /^,$/ => ',',
    /^;$/ => ';',
    /^\($/ => '(',
    /^\)$/ => ')',
    /^:=$/ => ':=',
    /^\+$/ => '+',
    /^-$/ => '-',
    /^\/$/ => '/',
    /^\*$/ => '*',
    /^\d+$/ => 'number',
    /^[a-z]\w*$/ => 'identifier',
  }
  
  attr_reader :reader
  
  def initialize(reader)
    @reader = reader
    @buffer = []
  end
  
  def empty?(chr)
    chr.nil? or chr =~ /\s/
  end
  
  def lookahead
    token = next_token
    @buffer.push(token)
    token
  end
  
  def next_token
    return @buffer.shift unless @buffer.empty?
    
    token = nil
    word = ""
    
    while true
      chr = reader.read_char
      chr = " " if chr == "\n"
      return nil if chr.nil? and not has_found_previous?(token)
      next if chr =~ /\s/ and not has_found_previous?(token)
      
      if chr.nil?
        type = nil
      else
        word += chr
        rule, type = @@rules.find do |rule, type|
          word =~ rule
        end
      end
      
      if not_found? type
        if has_found_previous? token
          # fallback
          reader.take_back(chr) unless empty?(chr)
          return token
        else
          return unknown_token(word) if empty?(chr)
          next
        end
      end
      
      token = Token.new(:type => type, :value => word)
    end
    
  end
  
  def unknown_token(value)
    Token.new(:type => value, :value => value)
  end
  
  def not_found?(type)
    type.nil?
  end
  
  def has_found_previous?(token)
    not token.nil?
  end
end
