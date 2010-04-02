#!/usr/bin/ruby -w
# backup all files 
# in a specific set of directories
# that have been updated in the last 24 hours
# rather than fighting throught the details of creating directories, tar up all files
# the untar in destination

require 'find'
require 'fileutils'
include FileUtils::Verbose

@files_of_concern=`find . -mtime -2`
#@files_of_concern.grep(/tmp|\.\/\.|bin|Library|Applications|Music|DS_Store/) {
@files_of_concern.grep(/^tmp/){|file|
puts file
break
}
@files_of_concern.each do |file|
  #puts file
end
