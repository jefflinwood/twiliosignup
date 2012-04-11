require 'sinatra'
require 'twilio-ruby'
require 'redis'

configure do
	uri = URI.parse(ENV["REDISTOGO_URL"])
	REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
end

get '/' do
  REDIS.get("rocky")
end

get '/twilio' do
  response = Twilio::TwiML::Response.new do |r|
  	r.Sms 'You have subscribed to the RailsConf 2012 BohConf feed. Powered by Twilio. Text back STOP to leave'
	end
	response.text
end

get '/send' do
"Message Sent"
end
