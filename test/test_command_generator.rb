require 'test_helper'

context 'CommandGenerator' do

  context 'extra options' do
    
    test 'numerical' do
      assert_equal '', CommandGenerator.options_string
      assert_equal '-n', CommandGenerator.options_string(:numerical => true)
    end
  end



  context 'write_tag_string' do

    setup do
      @wo = WriteObject.new
    end


    test 'is empty for empty WriteObject' do
      assert_equal '', CommandGenerator.write_tag_string(@wo)
    end

    test 'is correct for WriteObject with some values' do
      author = 'janfri'
      comment = 'some_comment'
      @wo.author = author
      @wo.comment = comment
      assert_equal %Q(-author="#{author}" -comment="#{comment}").size, CommandGenerator.write_tag_string(@wo).size
      assert_match /-author="#{author}"/, CommandGenerator.write_tag_string(@wo)
      assert_match /-comment="#{comment}"/, CommandGenerator.write_tag_string(@wo)
    end

  end

  # TODO: context 'read_tag_string'

end
