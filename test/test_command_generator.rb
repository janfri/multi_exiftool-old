require 'test_helper'

context 'CommandGenerator' do

  setup do
    @wo = WriteObject.new
  end

  context 'write_tag_string' do

    test 'is empty for empty WriteObject' do
      assert_equal '', CommandGenerator.write_tag_string(WriteObject.new)
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

end
