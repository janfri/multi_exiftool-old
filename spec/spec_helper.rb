require File.expand_path(
    File.join(File.dirname(__FILE__), %w[.. lib multi_exiftool]))

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

require 'ostruct'

def fixture name
  filename = File.join(File.dirname(__FILE__), %w(.. data fixtures), name)
  o = OpenStruct.new
  o.stdout = File.read(filename + '.stdout')
  o.stderr = File.read(filename + '.stderr')
  o
end
