#!/usr/bin/ruby

new_current = (ARGV[0].nil?) ? '/home/build/site/trunk/site' : ARGV[0]

%x{ rm current }
%x{ ln -s #{new_current} current }









