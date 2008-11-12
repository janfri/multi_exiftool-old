$:.unshift File.join(File.dirname(__FILE__), %w(.. .. lib))
require 'multi_exiftool'

read_opts = [{}, {:numerical => true}, {:only => [:filename, :rotation, :orientation]},  {:numerical => true, :only => [:filename, :rotation, :orientation]}]

filenames = [['a.jpg', 'b.jpg', 'c.jpg'], ['hello world.tif'], ['a.jpg', 'b.jpg', 'c.jpg', 'hello world.tif'], ['a.jpg', 'b.jpg', 'c.jpg', 'hello world.tif', 'd.jpg']]

read_opts.each do |opts|
  filenames.each do |fnames|
    puts MultiExiftool::CommandGenerator.read_command fnames, opts
  end
end
