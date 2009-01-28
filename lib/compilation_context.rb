class CompilationContext
  attr_reader :code, :parent, :sub_scopes, :symbol_table
  attr_accessor :stack_size, :locals_size
  
  def initialize(compiler, scope = 'main', parent = nil)
    @compiler = compiler
    @sub_scopes = []
    @parent = parent
    parent.sub_scopes << self unless parent.nil?
    @code = ""
    @stack_size = 4
    @locals_size = 1
    @current_label = 0
    @scope = scope
    @symbol_table = {}
  end
  
  def each_field(&blk)
    @symbol_table.each do |identifier, field|
      yield field
    end
    @sub_scopes.each do |sub_scope|
      sub_scope.each_field(&blk)
    end
  end
  
  def each_method(&blk)
    @sub_scopes.each do |sub_scope|
      yield sub_scope
      sub_scope.each_method(&blk)
    end
  end
  
  def <<(code_chunk)
    code << "  " << code_chunk << "\n"
  end
  
  def name
    @scope
  end
  
  def scope
    return @scope if parent.nil?
    "#{parent.scope}_@scope"
  end
  
  def sub_context(name)
    CompilationContext.new(@compiler, name, self)
  end
  
  def next_label
    @current_label += 1
    "##{scope}_#{@current_label}"
  end
  
  def class_name
    @compiler.output_file
  end
  
  def [](identifier)
    field_name = symbol_table[identifier]
    return field_name unless field_name.nil?
    return parent[identifier] unless parent.nil?
    raise "Unknown identifier: #{identifier}"
  end
  
  def allocate_field_for(identifier)
    symbol_table[identifier] = "#{scope}_#{identifier}"
  end
  
  def allocate_constant_for(identifier, value)
    symbol_table[identifier] = ["#{scope}_#{identifier}", value]
  end
end
