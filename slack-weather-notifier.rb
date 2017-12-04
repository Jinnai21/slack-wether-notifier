require 'uri'
require 'open-uri'
require 'net/http'
require 'uri'
require 'json'
require 'dotenv'

class SlackWraper
  def self.post(text)
    data = { "text" => text }
    request_url = ENV['WEBHOOK_URL']
    uri = URI.parse(request_url)
    Net::HTTP.post_form(uri, {"payload" => data.to_json})  
  end
end
uri = 'http://weather.livedoor.com/forecast/webservice/json/v1?city=016010'

res     = JSON.load(open(uri).read)
title   = res['title']
link    = res['link']
weather = res['forecasts'].first
min     = weather['temperature']['min']
max     = weather['temperature']['max']
message = "[#{weather['date']}の#{title}](#{link})は「#{weather['telop']}」です。\n最高気温…#{max['celsius']}℃\n最低気温…#{min['celsius']}℃"

Dotenv.load
SlackWraper.post(message)