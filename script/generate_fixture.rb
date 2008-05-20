#!/usr/bin/env ruby

unless ARGV.size == 2 
  $stderr.puts "usage: #$0 [fixturename] [filename]"
  exit -1
end

fixture = ARGV.shift
filename = ARGV.shift

fixture_filename = File.join(File.dirname(__FILE__), %w(.. data fixtures), fixture)

cmd = "exiftool -s -t #{filename} > #{fixture_filename}.stdout 2> #{fixture_filename}.stderr"

puts cmd if $DEBUG

result = system cmd

if result
  puts "Fixture #{fixture} generated."
else
  puts "Error while generating fixture #{fixture}."
  exit -1
end
