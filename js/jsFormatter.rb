#!/usr/bin/ruby
# e.g. ruby -i js/jsFormatter.rb ~/.vim/test_files/calendar.js

while line=gets
  line.gsub! /function\(/, 'function ('
  line.gsub! /if\(/, 'if ('
  line.gsub! /\( /, '('
  line.gsub! /\s\)/, ')'
  line.gsub! /\t/, '  '
  line.gsub! /\)\{/, ') {'
  #line.gsub! /(\s)\{/, '\1 '
  print line
end
