require 'test_helper'

context 'Parser#parse' do

  setup do
    @parser = Parser.new
  end

  context 'read_non_existing_file' do

    test 'returns an empty result' do
      fix = Fixture.read_non_existing_file
      @parser.parse_reading(fix.stdout, fix.stderr)
      assert_equal [], @parser.result
    end

    # TODO: Testing errors
  end

  context 'read_one_file' do

    setup do
      fix = Fixture.read_one_file
      @parser.parse_reading(fix.stdout, fix.stderr)
      @result = @parser.result
    end

    test 'returns an array with one result of meaningful data' do
      assert_kind_of Array, @result
      assert_equal 1, @result.size
      data = @result.first.data
      assert_equal '2005:10:06 15:41:08', data['DateTimeOriginal']
      assert_equal '9.0', data['FNumber'] 
    end

  end

  context 'read_two_files' do

    setup do
      fix = Fixture.read_two_files
      @parser.parse_reading(fix.stdout, fix.stderr)
      @result = @parser.result
    end

    test 'returns an array with two results of meaningful data' do
      assert_kind_of Array, @result
      assert_equal 2, @result.size 
      data1 = @result[0].data
      assert_equal '2008:02:16 16:10:52', data1['DateTimeOriginal'] 
      assert_equal '6.7', data1['FNumber'] 
      data2 = @result[1].data
      assert_equal '2008:03:01 13:23:22', data2['DateTimeOriginal'] 
      assert_equal '4.5', data2['FNumber'] 
    end

  end

end
