require 'sinatra'
require 'twilio-ruby'

get '/' do
  "Hello, world"
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
