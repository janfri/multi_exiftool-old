require 'test_helper'

context 'WriterObject' do

  setup do
    @wo = WriteObject.new
  end

  context 'with some values' do

    setup do
      @values = { 'Author' => 'janfri', 'Comment' => 'some_comment' }
      @write_object = WriteObject.new @values
    end

    test 'attributes are correct set' do
      @values.each do |key, val|
        assert_equal val, @write_object[key], "Test: @write_object['#{key}']"
      end
    end

  end

end
