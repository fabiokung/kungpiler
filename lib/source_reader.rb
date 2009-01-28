class SourceReader
  attr_reader :file_name
  
  def initialize(args)
    @file_name = args[:file_name] || args[:file]
    raise "Please suply the :file_name" if @file_name.nil?
    @buffer = []
  end
  
  def read_char
    @file ||= File.new(@file_name)
    raise "File Not Found" if @file.nil?
    
    return @buffer.pop unless @buffer.empty?
    return nil if @file.closed?
    read = @file.getc
    @file.close if read.nil?
    read ? read.chr : nil
  end
  
  def take_back(chr)
    @buffer.push(chr)
  end
  
  def close
    @file.close
  end
end
