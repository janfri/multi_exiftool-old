require 'test_helper'

context 'ReadObject' do

  setup do
    @values = { 'Author' => 'janfri', 'Comment' => 'Test' }
    @read_object = ReadObject.new @values
  end

  test 'Value access via []' do
    @values.each do |key, val|
      assert_equal val, @read_object[key], "Test: @read_object['#{key}']"
    end
  end

  test 'Value access via method call' do
    assert_equal @read_object['Author'], @read_object.author
  end

  context 'Semantical values' do

    setup do
      @values = {'String' => 'some string', 'Integer' => '123', 'Float' => '1.23'}
      @read_object = ReadObject.new @values
    end

    [String, Integer, Float].each do |klass|
      test klass.to_s do
        assert_kind_of klass, @read_object[klass.to_s]
      end

    end

  end

  context 'path' do

    test 'raising MultiExiftool::Error if no path found' do
      assert_raises MultiExiftool::Error do
        @read_object.path
      end
    end

    test 'returns the full path' do
      full_path = __FILE__
      dir = File.dirname(__FILE__)
      filename = File.basename(__FILE__)
      read_object = ReadObject.new('Directory' => dir, 'Filename' => filename)
      assert_equal full_path, read_object.path
    end

  end

end
