#!/usr/bin/ruby

command = ARGV[1] || 'restart'
site    = ARGV[0] || 'viewpoints'

cl_out = %{sudo /etc/init.d/mongrel #{command} site_#{site}}
puts cl_out
puts `#{cl_out}`


