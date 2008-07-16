require 'test_helper'

context 'ReadObject' do

  setup do
    @values = { 'Author' => 'janfri', 'Comment' => 'Test' }
    @read_object = ReadObject.new @values
  end

  test 'Value access' do
    @values.each do |key, val|
      assert_equal val, @read_object[key], "Test: @read_object['#{key}']"
    end
  end

end
