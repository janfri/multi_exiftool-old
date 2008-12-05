require 'test_helper'

context 'Parser' do

  setup do
    @parser = Parser.new
  end

  context 'parse_reading' do

    context 'read_non_existing_file' do

      setup do
        fix = Fixture.read_non_existing_file
        @parser.parse_reading(fix.stdout, fix.stderr)
      end

      test 'has an empty result' do
        assert_equal [], @parser.result
      end

      test 'has one meaningfull error' do
        assert_equal 1, @parser.errors.size
        assert_match /File not found/, @parser.errors.join
      end

    end

    context 'read_one_file' do

      setup do
        fix = Fixture.read_one_file
        @parser.parse_reading(fix.stdout, fix.stderr)
        @result = @parser.result
      end

      test 'has one meaningful result' do
        assert_kind_of Array, @result
        assert_equal 1, @result.size
        data = @result.first
        assert_equal '2005:10:06 15:41:08', data['DateTimeOriginal']
        assert_equal '9.0', data['FNumber'] 
      end

      test 'has no errors' do
        assert_empty @parser.errors
      end

    end

    context 'read_two_files' do

      setup do
        fix = Fixture.read_two_files
        @parser.parse_reading(fix.stdout, fix.stderr)
        @result = @parser.result
      end

      test 'has two meaningful results' do
        assert_kind_of Array, @result
        assert_equal 2, @result.size 
        data1 = @result[0]
        assert_equal '2008:02:16 16:10:52', data1['DateTimeOriginal'] 
        assert_equal '6.7', data1['FNumber'] 
        data2 = @result[1]
        assert_equal '2008:03:01 13:23:22', data2['DateTimeOriginal'] 
        assert_equal '4.5', data2['FNumber'] 
      end

      test 'has no errors' do
        assert_empty @parser.errors
      end

    end

  end

  context 'parse_writing' do

    context 'try to write to a non existing file' do

      setup do
        fix = Fixture.write_to_non_existing_file
        @parser.parse_writing(fix.stdout, fix.stderr)
      end

      test 'has one meaningful error' do
        assert_equal 1, @parser.errors.size
        assert_match /File not found/, @parser.errors.join
      end

    end

  end

end
