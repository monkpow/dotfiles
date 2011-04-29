#!/usr/bin/ruby 

#########################################################################################################
#
# Takes a list of javascript function names, and searches un-excluded directories for references
#
#########################################################################################################

require 'find'
 

def read_arg_into_memory(arg)
	switch,value=arg.split("=")
	switch.sub!(/-/,"")#just clip the first one
  instance_variable_set("@"+switch, value)
end

ARGV.each_with_index {|arg,i|  if arg=~/=/ 
	read_arg_into_memory(arg)
	ARGV[i]=nil
	end
}

ARGV.compact!

puts @src


ARGV.each {|functionName| 
 puts functionName  


}



#files=data.read

#files.each do |fs|  																# loop through filess defined in files.txt
#  Find.find(ROOT_DIR) do |path|												# find all files in ROOT_DIR
#    if FileTest.directory? path												# quit processing if the directory matches an exclude list
      #Find.prune if path =~ fs.exclusions  
    #end
#    path.grep(fs.filetype) do |file|									# in the remaining directories, find filetypes (like *jsp) and loop through
#      rules.each do |rule|														# loop through rules
#        File.open(file) do |f|												# open file and apply rule
#          linenumber=1;  															# keep track of line number // i think this is broken 
#          f.grep(rule.pattern) do |line|							# for each match, printMessage
            #printMessage(path,line,rule,linenumber)
            #linenumber=linenumber+1
          #end
        #end
      #end
    #end								
  #end
#end

#puts "Total errors:\t#{@totalErrors} \n"
#puts "Total warnings:\t#{@totalWarnings} \n"
#if (@warnings!='true' && @totalWarnings>0)
  #puts "To see warnings, execute:"
  #puts "$:build.sh jsp.critic.#{@type}.warnings"
#end
#exit  @exitcode









