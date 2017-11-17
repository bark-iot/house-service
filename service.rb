require 'sinatra'
require './config/authorize.rb'
require './config/database.rb'
require './config/concepts.rb'
require './config/logging.rb'


set :bind, '0.0.0.0'
set :port, 80
set :public_folder, 'public'

get '/houses' do
  result = House::List.(user_id: USER['id'])
  if result.success?
    body House::Representer.for_collection.new(result['models']).to_json
  else
    status 422
    body result['contract.default'].errors.messages.uniq.to_json
  end
end

post '/houses' do
  result = House::Create.(params.merge({user_id: USER['id']}))
  if result.success?
    body House::OwnerRepresenter.new(result['model']).to_json
  else
    if result['contract.default']
      status 422
      body result['contract.default'].errors.messages.uniq.to_json
    else
      status 404
    end
  end
end

put '/houses/:id' do

end

delete '/houses/:id' do

end

get '/houses/docs' do
  redirect '/houses/docs/index.html'
end