#  critic.rb
#  nkrimm|20070201
#  a regex-based static code analysis tool 
#  takes a directory and a 'type' as args
#  example: 
#  critic.rb [dir] [type]
#  critic.rb /webapp/ROOT.war jsp
#  this will search [dir] for all files described by [type]
#  [type] points by convention to a subdirectory named [type] 
#  [type] directory contains two files
#  fileset.txt (describes the filetype and exclusions list)
#  rules.txt (describes the rules to be applied)
#  both are csv files, which are converted into objects
#  by csv-reader
#
#  After set up, all files in [dir] matching rules in [type]/fileset.txt
#  will be searched for [rules] matches
#  [rules] have severity of 0 [warning] or 1 [error]
#  any instance of 1 [error] causes the script to return exit code 1
#  [error]s and [warning]s are printed to the console.
#	 Note: comments are not supported in [rules|fileset].txt
#	 Both files are written with regexs embedded.  
#	 Caution when editing if you're not familiar with regex!
#
#  To add a new test type, create a directory with that name,
#  and copy/modify an existing rules.txt and fileset.txt

# TODOs
# ok - need to segment rules directories
# ok- need to return error code
# ok- add line numbers
#	count errors and warnings on exit
# skip commented code in tests
# add multi-line regex -- I believe this is supported already, but I don't have a multiline regex written
# support multiple filesets

require 'src/csv-reader'
require 'find'
ROOT_DIR=ARGV[0]
RULES_FILE="#{ARGV[1]}/rules.txt"
FILE_LIST="#{ARGV[1]}/fileset.txt"

exitcode=0
totalErrors=0
totalWarnings=0

def printMessage(path, line, rule, linenumber)
	# concats a bunch of strings together for output
	if rule.severity==1 
			severity="Error"
			exitcode=1
			#totalErrors=totalErrors+1
	elsif rule.severity==0
			severity="Warn"
			#totalWarnings=totalWarnings + 1
	end
	response="" << severity
  response<< "\t \n"
	response<< "\tFile:\t" << path << "\n"
	response<< "\tLine#:\t" << linenumber.to_s << "\n"
	response<< "\tLine:\t" << line.strip << "\n" 
	response<< "\tRule:\t" << rule.response << "\n" 
	response<< "\t\n\n" 
	puts response
end

#use csv-reader to process text files into objects in memory
data=Reader.make(RULES_FILE) # Capture return value and
rules = data.read                     # call a class method on it.
data=Reader.make(FILE_LIST);
fileset=data.read

fileset.each do |fs|  																# loop through filesets defined in fileset.txt
	Find.find(ROOT_DIR) do |path|												# find all files in ROOT_DIR
		if FileTest.directory? path												# quit processing if the directory matches an exclude list
			Find.prune if path =~ fs.exclusions  
		end
		path.grep(fs.filetype) do |file|									# in the remaining directories, find filetypes (like *jsp) and loop through
			rules.each do |rule|														# loop through rules
				File.open(file) do |f|												# open file and apply rule
					linenumber=1;  															# keep track of line number // i think this is broken 
					f.grep(rule.pattern) do |line|							# for each match, printMessage
						printMessage(path,line,rule,linenumber)
						linenumber=linenumber+1
					end
				end
			end
		end								
	end
end

#puts "Total errors:\t#{totalErrors} \n"
#puts "Total warnings:\t#{totalWarnings} \n"

exit exitcode
