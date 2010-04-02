require 'net/http'
require 'uri'

url = 'http://bugs.hive.viewpoints.com/wiki/1/Guides_&%2338_Blogs'
page_content = Net::HTTP.get(URI.parse(url))

total, complete = 0,0
arr = page_content.scan(/\[((nk|rm)\s*(\d\d*)\s*(DONE)*)/)

arr.each do |story| 
  points = story[2].to_i
  complete += points unless story[-1].nil?
  total += points
end

puts "#{complete} of #{total} points completed"
