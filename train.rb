require_relative 'yahootransit'

a = 27
b = 0

yt = YahooTransit.new(a, b)
message = '東海道線は'
if yt.status == '平常運転' then
  message += yt.status + 'です。'
else
  message += yt.info
end

puts '{'
puts '  "title": '    + sprintf('"%s"', yt.title) + ','
puts '  "icon": '     + sprintf('"%s"', yt.icon)  + ','
puts '  "status": '   + sprintf('"%s"', yt.status)+ ','
puts '  "info": '     + sprintf('"%s"', yt.info)  + ',' 
puts '  "message": '  + sprintf('"%s"', message)
puts '}'
