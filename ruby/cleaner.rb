#!/usr/bin/ruby
require 'find'
require 'fileutils'
include FileUtils::Verbose

@extensions_to_clean=%w{zip dmg bz2}
@recyclery=ENV["HOME"]+'/.Trash/'

Find.find(ENV["HOME"]+'/Desktop') do |path|
  @extensions_to_clean.each { |pattern|  
    if path =~ /#{pattern}/
      mv(path,@recyclery)
    end  
##			path.grep(fs.filetype) do |file|									# in the remaining directories, find filetypes (like *jsp) and loop through
##				rules.each do |rule|														# loop through rules
##					File.open(file) do |f|												# open file and apply rule
##						linenumber=1;  															# keep track of line number // i think this is broken 
##						f.grep(rule.pattern) do |line|							# for each match, printMessage
##							printMessage(path,line,rule,linenumber)
##							linenumber=linenumber+1
##						end
##					end
##				end
##			end								
  }
end




##	
##		Find.find("*zip") do |path|												# find all files in ROOT_DIR
##	  puts 
##	end
##			if FileTest.directory? path												# quit processing if the directory matches an exclude list
##				Find.prune if path =~ fs.exclusions  
##			end
##			path.grep(fs.filetype) do |file|									# in the remaining directories, find filetypes (like *jsp) and loop through
##				rules.each do |rule|														# loop through rules
##					File.open(file) do |f|												# open file and apply rule
##						linenumber=1;  															# keep track of line number // i think this is broken 
##						f.grep(rule.pattern) do |line|							# for each match, printMessage
##							printMessage(path,line,rule,linenumber)
##							linenumber=linenumber+1
##						end
##					end
##				end
##			end								
##		end

#puts "Total errors:\t#{totalErrors} \n"
#puts "Total warnings:\t#{totalWarnings} \n"

