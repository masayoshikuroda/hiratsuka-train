require 'nokogiri'
require 'net/http'
require 'open-uri'

class YahooTransit
  attr_reader :title, :icon, :status, :info

  BASE_URL = 'https://transit.yahoo.co.jp/diainfo'

  def initialize(a, b)
    url = getUrl(a, b)
    html = URI.open(url) do |f| f.read end
    page = Nokogiri::HTML.parse(html, nil, 'UTF-8')
    
    p page.css("div#mdServiceStatus > dl > dt").inner_text

    @title = page.css("h1.title").inner_text
    text = page.css("div#mdServiceStatus > dl > dt").inner_text
    @icon = page.css("div#mdServiceStatus > dl > dt > span").first.attr('class')
    @status = page.css("div#mdServiceStatus > dl > dt").inner_text
    @info = page.css("div#mdServiceStatus > dl > dd > p").inner_text
  end

  def getUrl(a, b)
    return "#{BASE_URL}/%d/%d" % [a, b]
  end
end

if __FILE__ == $0
  a = ARGV[0].to_i
  b = ARGV[1].to_i
  yt = YahooTransit.new(a, b)
  puts yt.title, yt.icon, yt.status, yt.info
end

