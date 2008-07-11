require 'test_helper'

context 'WriterObject' do

  setup do
    @wo = WriteObject.new
  end

  context 'with some values' do

    setup do
      @author = 'janfri'
      @comment = 'some_comment'
      @wo.author = @author
      @wo.comment = @comment
    end

    test 'attributes are correct set' do
      assert_equal @author, @wo.author
      assert_equal @comment, @wo.comment
    end

  end

end
