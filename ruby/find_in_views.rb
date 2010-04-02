#!/usr/bin/ruby
# find all .rhtml, .html, or .html.erb files matching a string


def erb_files
  return @files if @files 
  files = Dir.glob('**/*html*')
  @files = files.delete_if { |file| file =~ /vendor/ }
end


def filtered_file_list(arg)
  return @filtered_file_list if @filtered_file_list
  erb_files.find_all do |file| 
    value = false
    unless File.directory? file 
      f = File.open(file); 
      value = f.grep(/#{arg}/).size >= 1
    end
    value
  end
end

response = filtered_file_list(ARGV[0])
puts response
