#!/usr/bin/ruby

files = %x(find . -name "*rhtml" -or -name "*html.erb" -or -name "*rb" | xargs grep -h "i_arrow_right_circle" .)

fs = files.split(/\n/)
fs.map! do |matching_line|
  matching_line.split(/["']/).detect do |fragment| fragment.include? 'i_arrow_right_circle' end
end

puts "number of matching lines: #{fs.size}"
puts "number of unique matching lines: #{fs.sort.uniq.size}"

#what if we put them in order, do we get fewer uniques?

lines = fs
lines.map! do |line| arr = line.split " "; line = arr.sort.join(" ") end
puts lines.sort.uniq


def find_instances_of(string)
  files = %x(find . -name "*rhtml" -or -name "*html.erb" -or -name "*rb" | xargs grep -h "${string}" .)
  fs = files.split(/\n/)
end





