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
      @change_set = OpenStruct.new
    end


    test 'is empty for empty WriteObject' do
      assert_equal '', CommandGenerator.write_tag_string(@change_set)
    end

    test 'is correct for WriteObject with some values' do
      author = 'janfri'
      comment = 'some_comment'
      @change_set.author = author
      @change_set.comment = comment
      assert_equal %Q(-author="#{author}" -comment="#{comment}").size, CommandGenerator.write_tag_string(@change_set).size
      assert_match /-author="#{author}"/, CommandGenerator.write_tag_string(@change_set)
      assert_match /-comment="#{comment}"/, CommandGenerator.write_tag_string(@change_set)
    end

    test 'works with array values aka list tags' do
      keywords = %w(red yellow green)
      @change_set.keywords = keywords
      assert_equal %Q(-keywords="red" -keywords="yellow" -keywords="green"), CommandGenerator.write_tag_string(@change_set)
    end

  end

  # TODO: context 'read_tag_string'

  context 'escape' do

    test 'strings without spaces and backspace are not changed' do
      simple = 'simple'
      assert_equal simple, CommandGenerator.escape(simple)
    end

    test 'strings with spaces and no backslash are simple enclosed in quotes' do
      string = 'string with spaces'
      assert_equal %Q("#{string}"), CommandGenerator.escape(string)
    end

    test 'strings with backslashes are enclosed ba quotes and backspaces are masked' do
      string = 'backslash\string'
      assert_equal string.inspect, CommandGenerator.escape(string)
    end

  end

end
