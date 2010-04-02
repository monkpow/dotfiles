#!/usr/bin/ruby


SDir="/opt/orbitz/services/log/wl-3.30.16-0/"

#(1..10).each {|num| 

num=10

#`mkdir #{num}`
`scp nkrimm@egapp#{num}.prod.o.com:#{SDir}/*tracking* #{num}/`


#} 
