#!/usr/bin/ruby

Servers=%w{
wmapp01.stag.o.com 
wmapp02.stag.o.com
}
Servers.each_with_index {|f,i|
  puts "#{i}: #{f}"
}
t=gets.chomp!
puts "ssh nkrimm@#{Servers[t.to_i]}"
