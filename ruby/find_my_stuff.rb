#!/usr/bin/ruby -w
# wants to associate all jsp srcs with thier node list to see if there are repeated nodes
# find . -name "*jsp" | xargs grep "<render:" |  grep "node" | grep -v "attribute" | sed "s/[^:]*:\s*//" | sort | uniq | less  

require 'find'
ROOT_DIR=ARGV[0]

nodeList=Hash.new

Find.find(ROOT_DIR) do |path|												# find all files in ROOT_DIR
  path.grep(/jsp/) do |file|									# in the remaining directories, find filetypes (like *jsp) and loop through
    File.open(file) do |f|												# open file and apply rule
      f.grep(/<render:/) do |match|
        match =~ /src="([^"]*)"/ 
          source=$1
        match =~/node="([^"]*)"/
        node=$1
        if source!=nil
        nodeList.store(source,[]) if ! nodeList.has_key?(source)
        nodeList[source].push(node) if node!=nil
        end
      end
    end								
  end
end

nodeList.each do |key, value|
  values=value.uniq
  if values.length>1 
  puts "\nmodule src=#{key}"
  values.each do |value|
    puts "node: #{value}"
  end
  end
end
