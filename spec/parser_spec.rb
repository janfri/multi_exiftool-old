require File.join(File.dirname(__FILE__), %w[spec_helper])

describe MultiExiftool::Parser do

  describe 'parse' do

    it 'should return an empty array when trying to read from a non-existing file' do
      fix = Fixture.read_non_existing_file
      Parser.parse(fix.stdout, fix.stderr).should == []
    end

    describe 'reading one file' do

      before :all do
        fix = Fixture.read_one_file
        @result = Parser.parse(fix.stdout, fix.stderr)
      end

      it 'should return an array with one result' do
        @result.should be_kind_of(Array)
        @result.size.should == 1
      end

    end

  end

end
