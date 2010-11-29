# scp  nkrimm@urchin.viewpoints.com:/data02/archives/logs/hosts/www03.pro.viewpoints.com/viewpoints/weblogs/archives/ssl_access_log-2010055.gz . 

require 'logger'

$log = Logger.new STDOUT

n=File.open('image_inventory.txt')
r=n.readlines
file_list = r.map {|f| f.sub(/:.*\n/,"") if f.match /NO REF/}.compact

sample_file_list = file_list #.slice(1,10)

sample_file_list.each do |file|
  puts file
  numfound = `zgrep -c #{file} logs/*access_log-*.gz` 
  grep_results = numfound.split(/\n/)
  grep_results.collect! do |p| p.split(/:/)[1] end
  b = grep_results.reduce do |sum, n| sum.to_i + n.to_i end
  if b !=0
    puts "file #{file} was found #{b} times.  Better keep it for now"
  end
end

#puts sample_file_list
