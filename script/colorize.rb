#!/usr/bin/env ruby
$stdin.readlines.each do |line|
  if line =~ /\{\+|\[-/
    puts line.gsub('{+', "\e[32m").gsub('+}', "\e[0m").gsub('[-', "\e[31m").gsub('-]', "\e[0m")
  end
end
