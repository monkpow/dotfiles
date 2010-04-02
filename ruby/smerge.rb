#!/usr/bin/env ruby
 
puts('Usage:  smerge REV') and exit(0) if ARGV.size == 0
 
rev = ARGV[0]
rev = "#{rev.to_i - 1}:#{rev}" if rev =~ /^\d+$/
 
cmd = "svn merge -r #{rev} svn+ssh://nkrimm@svn.hive.viewpoints.com/usr/local/svn/site/trunk/site ."
puts cmd
system cmd
