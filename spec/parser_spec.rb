require File.join(File.dirname(__FILE__), %w[spec_helper])

describe MultiExiftool::Parser do

  describe 'parse' do

    describe 'read_non_existing_file' do

      it 'should return an empty array' do
        fix = Fixture.read_non_existing_file
        Parser.parse(fix.stdout, fix.stderr).should == []
      end

    end

    describe 'read_one_file' do

      before :all do
        fix = Fixture.read_one_file
        @result = Parser.parse(fix.stdout, fix.stderr)
      end

      it 'should return an array with one result of meaningful data' do
        @result.should be_kind_of(Array)
        @result.size.should == 1
        data = @result.first.data
        data['DateTimeOriginal'].should == '2005:10:06 15:41:08'
        data['FNumber'].should == '9.0'
      end

    end

    describe 'read_two_files' do

      before :all do
        fix = Fixture.read_two_files
        @result = Parser.parse(fix.stdout, fix.stderr)
      end

      it 'should return an array with two results of meaningful data' do
        @result.should be_kind_of(Array)
        @result.size.should == 2
        data1 = @result[0].data
        data1['DateTimeOriginal'].should == '2008:02:16 16:10:52'
        data1['FNumber'].should == '6.7'
        data2 = @result[1].data
        data2['DateTimeOriginal'].should == '2008:03:01 13:23:22'
        data2['FNumber'].should == '4.5'
      end

    end

  end

end
