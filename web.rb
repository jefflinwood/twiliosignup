require 'sinatra'
require 'twilio-ruby'
require 'redis'

configure do
	uri = URI.parse(ENV["REDISTOGO_URL"])
	REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
end

get '/' do
  	REDIS.scard "sms_followers"
end

get '/twilio' do
	if params['Body'].include? "STOP"
		REDIS.srem "sms_followers", params['From']
		response = Twilio::TwiML::Response.new do |r|
  			r.Sms 'You have unsubscribed from the RailsConf 2012 BohConf feed. Powered by Twilio.'
		end
		response.text
	else

		REDIS.sadd "sms_followers", params['From']
  		response = Twilio::TwiML::Response.new do |r|
  			r.Sms 'You have subscribed to the RailsConf 2012 BohConf feed. Powered by Twilio. Text back STOP to leave'
		end
		response.text
	end
end

get '/members' do
	REDIS.smembers "sms_followers"
end

get '/clear' do
	REDIS.del "sms_followers"
end
