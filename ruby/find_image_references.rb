# find all .rhtml, .html, or .html.erb css or *rb files  containing a string

def view_files 
  return @files if @files 
  files = []
  ['**/*html', '**/*erb', '**/*css', '**/*js', '**/*rb'].each do |pattern|
    files = files +  Dir.glob(pattern)
  end 

  @files = files.delete_if { |file| file =~ /vendor/ }
end

def file_short_name(file_name)
  file_name.split('/')[-1]
end

def find_image_references(arg)
  view_files.find_all do |file|
    value = false
    unless File.directory? file 
      f = File.open(file); 
      value = f.grep(/#{file_short_name arg}/).size >= 1
    end
    value
  end
end

ARGV.each do |arg|
  searching_for = file_short_name arg
  response =  find_image_references arg
  if response.size == 0
    puts "#{searching_for}: NO REFERENCES FOUND"
  else
    puts "#{searching_for}: #{response.join(',')}"
  end
end
