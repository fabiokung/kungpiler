require "lib/source_reader"

describe SourceReader, " extracting chars from source files" do
  it "should raise an exception unless receives file name" do
    lambda { SourceReader.new "file" }.should raise_error
    lambda { SourceReader.new :f => "file" }.should raise_error
    lambda {SourceReader.new "file" => "file"}.should raise_error
    lambda { SourceReader.new "file_name" => "file" }.should raise_error
  end
  
  it "should not raise exception if receives file name" do
    lambda { 
      r2 = SourceReader.new :file_name => "file"
      r2.file_name.should_not be_nil
    }.should_not raise_error
    
    lambda { 
      r2 = SourceReader.new :file => "file"
      r2.file_name.should_not be_nil
    }.should_not raise_error
  end
  
  it "should extract chars from source files" do
    expected_chars = ["t", "h", "i", "s", " ", "i", "s"]
    
    reader = SourceReader.new(:file => "test/fixtures/simple.source")
    expected_chars.each do |expected_char|
      reader.read_char.should == expected_char
    end
    reader.close
  end
  
  it "should take back chars" do
    expected = ["t", "h", "i", "s", " ", "i", "s"]
    reader = SourceReader.new(:file => "test/fixtures/simple.source")
    reader.read_char.should == expected[0]
    reader.read_char.should == expected[1]
    reader.read_char.should == expected[2]
    reader.take_back(expected[1])
    reader.take_back(expected[2])
    reader.read_char.should == expected[2]
    reader.read_char.should == expected[1]
    reader.read_char.should == expected[3]
    reader.take_back(expected[3])
    reader.read_char.should == expected[3]
    reader.read_char.should == expected[4]
    reader.read_char.should == expected[5]
    reader.read_char.should == expected[6]
    reader.close
  end
  
  it "should give nil if file is closed" do
    reader = SourceReader.new(:file => "test/fixtures/simple.source")
    reader.read_char.should eql("t")
    reader.close
    reader.read_char.should be_nil
    reader.read_char.should be_nil
  end
  
end
