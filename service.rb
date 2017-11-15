require 'sinatra'
require './config/database.rb'
require './config/concepts.rb'
require './config/logging.rb'


set :bind, '0.0.0.0'
set :port, 80
set :public_folder, 'public'

get '/houses/docs' do
  redirect '/houses/docs/index.html'
end

def bearer_token
  pattern = /^Bearer /
  header = request.env['HTTP_AUTHORIZATION']
  header.gsub(pattern, '') if header && header.match(pattern)
end