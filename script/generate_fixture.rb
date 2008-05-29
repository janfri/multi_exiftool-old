#!/usr/bin/env ruby

if ARGV.size < 2 
  $stderr.puts "usage: #$0 [fixturename] [exiftool-opts]* [filename]+"
  exit(-1)
end

fixture = ARGV.shift
params =  ARGV.map {|a| a.sub(/(.+?=)(.*)/, '\1"\2"')}.join(' ')

fixture_filename = File.join(File.dirname(__FILE__), %w(.. data fixtures), fixture)

cmd = "exiftool -s -t #{params} > #{fixture_filename}.stdout 2> #{fixture_filename}.stderr"

if $DEBUG
  puts cmd
  exit 0
end

result = system cmd

if File.exist?("#{fixture_filename}.stdout") && File.exist?("#{fixture_filename}.stderr")
  puts "Fixture #{fixture} generated."
else
  puts "Error while generating fixture #{fixture}."
  exit(-1)
end
