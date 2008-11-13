$:.unshift File.join(File.dirname(__FILE__), %w(.. .. lib))
require 'multi_exiftool'

write_opts = [{}, {:numerical => true}]

changesets = [{}, {:author => 'janfri'}, {:author => 'janfri', :comment => 'some comment'}, {:author => 'janfri', :comment => 'some comment', :keywords => [:a, :b, :c]}, {:orientation => 1}]

filenames = [['a.jpg', 'b.jpg', 'c.jpg'], ['hello world.tif'], ['a.jpg', 'b.jpg', 'c.jpg', 'hello world.tif'], ['a.jpg', 'b.jpg', 'c.jpg', 'hello world.tif', 'd.jpg']]

write_opts.each do |opts|
  changesets.each do |cs|
    filenames.each do |fnames|
      puts MultiExiftool::CommandGenerator.write_command(cs, fnames, opts)
    end
  end
end
