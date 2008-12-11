require 'test_helper'

context 'CommandGenerator' do

  context 'extra options' do
    
    test 'numerical' do
      assert_equal [], CommandGenerator.options_array
      assert_equal ['-n'], CommandGenerator.options_array(:numerical => true)
    end

  end

  context 'write_tag_array' do

    setup do
      @change_set = OpenStruct.new
    end

    test 'is empty for empty change set' do
      assert_equal [], CommandGenerator.write_tag_array(@change_set)
    end

    test 'is correct for change set with some values' do
      author = 'janfri'
      comment = 'some_comment'
      @change_set.author = author
      @change_set.comment = comment
      assert_equal ["-author=#{author}", "-comment=#{comment}"], CommandGenerator.write_tag_array(@change_set)
    end

    test 'works with array values aka list tags' do
      keywords = %w(red yellow green)
      @change_set.keywords = keywords
      assert_equal ["-keywords=red", "-keywords=yellow", "-keywords=green"], CommandGenerator.write_tag_array(@change_set)
    end

    test 'handle snail_case tags' do
      @change_set.focal_length = 35
      assert_equal ['-focallength=35'], CommandGenerator.write_tag_array(@change_set)
    end

  end

  context 'read_tag_array' do

    context 'parameter only' do

      test 'array of tags' do
        assert_equal %w(-fnumber -iso), CommandGenerator.read_tag_array([:fnumber, :iso])
        assert_equal ['-focallength'], CommandGenerator.read_tag_array([:focallength])
      end

      test 'single tag' do
        assert_equal ['-focallength'], CommandGenerator.read_tag_array(:focallength)
      end

      test 'snailcase tags' do
        assert_equal ['-focallength'], CommandGenerator.read_tag_array(:focal_length)
      end

    end

  end

  context 'filenames_array' do

    test 'simple names' do
      filenames = %w(a.jpg b.jpg c.tif)
      assert_equal filenames, CommandGenerator.filenames_array(filenames)
    end

    test 'names with spaces' do
      filenames = ['hello world.jpg', 'how are you.tif']
      assert_equal filenames.map {|fn| '"' << fn << '"'}, CommandGenerator.filenames_array(filenames)
    end

  end

  context 'read_tag_array' do

    test 'is empty for empty tag array' do
      assert_equal [], CommandGenerator.read_tag_array([])
    end

    test 'is correct for some tags' do
      tags = [:filename, :rotation, :orientation]
      assert_equal %w(-filename -rotation -orientation), CommandGenerator.read_tag_array(tags)  
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


  # TODO: read_command, write_command

end
