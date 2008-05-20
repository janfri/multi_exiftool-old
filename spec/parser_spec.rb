require File.join(File.dirname(__FILE__), %w[spec_helper])
require 'stringio'

describe MultiExiftool::Parser do

  describe 'parse_read' do

    before :all do
      @parser = MultiExiftool::Parser.new
    end

    it 'should return true for correct input data' do
      read_background = fixture 'read_background'
      @parser.parse_read(read_background.stdout, read_background.stderr).should == true
    end

    it 'should return false whenn errors occur' do
      file_not_found = fixture 'file_not_found'
      @parser.parse_read(file_not_found.stdout, file_not_found.stderr).should == false
    end

  end

end
