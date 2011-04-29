#  Want to get copied of the access_logs for all of our cobrand files
#  build up a hash of the primary machine for each of the existing cobrands
#  then fetch yesterdays access_log and ssl_access_log
#


machines = {
  :craftsman => 'www04',
  :ssu => 'www02',
  :mysears => 'www01',
  :mygofer => 'www02',
  :viewpoints => 'www03'
}



def datestamp
    yesterday = Time.now - 86400    
    yesterday.strftime "%Y%m%d"
end

puts datestamp

machines.each do |machine|
  name = machine[0]
  host = machine[1]
  ['access_log', 'ssl_access_log'].each do |log|
    cmd  = %{scp nkrimm@urchin.viewpoints.com:/data02/archives/logs/hosts/#{host}.pro.viewpoints.com/#{name}/weblogs/archives/#{log}-#{datestamp}.gz ./#{log}-#{datestamp}.#{name}.gz}
    puts cmd
    puts %x{#{cmd}}
  end
end

