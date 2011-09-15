ls_out = `ls`
files = ls_out.split /\n/

files.each do |file|
  file_name, file_ext = file.split(/\./)
  new_fn = "scss/" + file_name + ".scss"
  puts `git mv #{file} #{new_fn}`
end


