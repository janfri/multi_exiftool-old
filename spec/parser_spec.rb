require File.join(File.dirname(__FILE__), %w[spec_helper])

describe MultiExiftool::Parser do

  describe 'parse' do

    it 'should return an empty array when trying to read from a non-existing file' do
      fix = Fixture.read_non_existing_file
      Parser.parse(fix.stdout, fix.stderr).should == []
    end

  end

end
