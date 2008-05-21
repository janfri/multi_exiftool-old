require File.join(File.dirname(__FILE__), %w[spec_helper])
require 'stringio'

describe MultiExiftool::Parser do

  before :each do
    @parser = MultiExiftool::Parser.new
  end

  describe 'parse_read' do

    it 'should return true for correct input data' do
      fix = fixture.read_sea_jpg
      @parser.parse_read(fix.stdout, fix.stderr).should == true
    end

    it 'should return false whenn errors occur' do
      fix = fixture.read_non_existing_file
      @parser.parse_read(fix.stdout, fix.stderr).should == false
    end

  end

end
