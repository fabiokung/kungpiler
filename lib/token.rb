class Token
  attr_reader :value
  
  def initialize(args, &block)
    @type = String.new args[:type]
    @value = String.new args[:value]
    yield self if block_given?
  end
  
  def type
    @type
  end
  
  def eql?(other)
    self.==(other)
  end
  
  def ==(other)
    p "testing =="
    (type == other.type) && (value == other.value)
  end
  
  def ===(other)
    (type === other.type && value === other.value)
  end
  
  def to_s
    "(#{type}, #{value})"
  end
end
