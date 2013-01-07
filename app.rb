require 'sinatra'

get '/' do
  output = `ruby bin/themeanbot.rb`
  output
end


get '/ping' do
  "hello world from heroku #{Time.now}" 
end
