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

    test 'is empty for empty change set' do
      assert_equal '', CommandGenerator.write_tag_string(@change_set)
    end

    test 'is correct for change set with some values' do
      author = 'janfri'
      comment = 'some_comment'
      @change_set.author = author
      @change_set.comment = comment
      assert_equal %Q(-author=#{author} -comment=#{comment}).size, CommandGenerator.write_tag_string(@change_set).size
      assert_match /-author=#{author}/, CommandGenerator.write_tag_string(@change_set)
      assert_match /-comment=#{comment}/, CommandGenerator.write_tag_string(@change_set)
    end

    test 'works with array values aka list tags' do
      keywords = %w(red yellow green)
      @change_set.keywords = keywords
      assert_equal %Q(-keywords=red -keywords=yellow -keywords=green), CommandGenerator.write_tag_string(@change_set)
    end

  end

  context 'filenames_string' do

    test 'simple names' do
      filenames = %w(a.jpg b.jpg c.tif)
      assert_equal filenames.join(' '), CommandGenerator.filenames_string(filenames)
    end

    test 'names with spaces' do
      filenames = ['hello world.jpg', 'how are you.tif']
      assert_equal filenames.map {|fn| '"' << fn << '"'}.join(' '), CommandGenerator.filenames_string(filenames)
    end

  end

  context 'read_tag_string' do

    test 'is empty for empty tag array' do
      assert_equal '', CommandGenerator.read_tag_string([])
    end

    test 'is correct for some tags' do
      tags = [:filename, :rotation, :orientation]
      assert_equal '-filename -rotation -orientation', CommandGenerator.read_tag_string(tags)  
    end

  end

  context 'escape' do

    test 'strings without spaces and backspace are not changed' do
      simple = 'simple'
      assert_equal simple, CommandGenerator.escape(simple)
    end

    test 'strings with spaces and no backslash are simple enclosed in quotes' do
      string = 'string with spaces'
      assert_equal string.inspect, CommandGenerator.escape(string)
    end

    test 'strings with backslashes are enclosed by quotes and backspaces are masked' do
      string = 'backslash\string'
      assert_equal string.inspect, CommandGenerator.escape(string)
    end

  end


  # TODO: read_command_string, write_command_string

end
