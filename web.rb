require 'sinatra'
require 'twilio-ruby'

get '/' do
  "Hello, world"
end

get '/twilio' do
  response = Twilio::TwiML::Response.new do |r|
  r.Sms 'hello there'
end

# print the result
response.text
end
