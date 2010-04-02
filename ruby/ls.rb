#!/usr/bin/ruby -w
# a filter for ls

d=`ls -Al`
e=d.split(/\s{4}/)
puts e

