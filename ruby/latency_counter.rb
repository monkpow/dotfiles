#!/usr/bin/ruby
# pass in a log file using erma and extract times, average, etc.

@timesCalled=0
@average=0
@totalLatency=0
@minLatency=0
@maxLatency=0

while (line=gets)
  currentValue=line.split("|")[2].to_i
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
