#!/usr/bin/ruby

site    = ARGV[0] || 'viewpoints'

cl_out = %{tail -f log/#{site}dev.log | egrep -v "(SELECT|SHOW|Session ID|BEGIN|COMMIT)"}
puts cl_out
exec "#{cl_out}"


