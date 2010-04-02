#!/usr/bin/ruby
# pass in a log file using erma and extract times, average, etc.

@timesCalled=0
@average=0
@totalLatency=0
@minLatency=0
@maxLatency=0

#wl-3.2|org.apache.jsp.tag.web.util.monitoring_tag./WEB-INF/module/itinerary/include/airItineraryToggle.jsp|4
while (line=gets)
  puts line
  currentValue=line.split("content_access")[1].split(":")[1].to_i
  puts currentValue
  @timesCalled+=1
  @totalLatency+=currentValue
  @minLatency=currentValue if currentValue < @minLatency
  @maxLatency=currentValue if currentValue > @maxLatency
end

@average=@totalLatency/@timesCalled

puts "total calls #{@timesCalled}"
puts "average latency #{@average}"
puts "min latency #{@minLatency}"
puts "max latency  #{@maxLatency}"
