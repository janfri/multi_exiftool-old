require 'rubygems'
require 'spec'
require File.expand_path(File.join(File.dirname(__FILE__), %w[.. lib multi_exiftool]))

Spec::Runner.configure do |config|
  # == Mock Framework
  #
  # RSpec uses it's own mocking framework by default. If you prefer to
  # use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
end


class Fixture

  DIR = File.join(File.dirname(__FILE__), %w(.. data fixtures))

  def initialize name
    @name = name
  end

  def stdout
    StringIO.new(File.read(File.join(DIR, @name + '.stdout')))
  end

  def stderr
    StringIO.new(File.read(File.join(DIR, @name + '.stderr')))
  end

  # Class instance variable!
  @hash = {}

  Dir[File.join(Fixture::DIR, '*.stdout')].each do |filename|
    fixture_name = File.basename(filename, '.stdout')
    @hash[fixture_name] = Fixture.new(fixture_name)
  end

  class << self

    def method_missing sym, *args
      return @hash[sym.to_s] unless @hash[sym.to_s].nil?
      raise "Fixture #{sym} does not exist!"
    end

  end

end

include MultiExiftool
