require 'nokogiri'
require 'net/http'
require 'open-uri'

class YahooTransit
  attr_reader :title, :icon, :status, :info

  BASE_URL = 'https://transit.yahoo.co.jp/traininfo/detail'

  def initialize(a, b)
    url = getUrl(a, b)
    html = open(url) do |f| f.read end
    page = Nokogiri::HTML.parse(html, nil, 'UTF-8')

    @title = page.css("h1.title").inner_text
    text = page.css("div#mdServiceStatus > dl > dt").inner_text
    @icon = text.split('[')[1].split(']')[0]
    @status = text.split(']')[1]
    @info = page.css("div#mdServiceStatus > dl > dd > p").inner_text
  end

  def getUrl(a, b)
    return "#{BASE_URL}/%d/%d/" % [a, b]
  end
end

if __FILE__ == $0
  a = ARGV[0].to_i
  b = ARGV[1].to_i
  yt = YahooTransit.new(a, b)
  puts yt.title, yt.icon, yt.status, yt.info
end

