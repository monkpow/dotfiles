#!/usr/bin/ruby
# e.g. ruby -i js/jsFormatter.rb ~/.vim/test_files/calendar.js

while line=gets
  line.gsub! /{/, '{\r'
  print line
end
