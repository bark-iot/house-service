require 'sinatra'
require './config/logging.rb'
require './config/authorize.rb'
require './config/database.rb'
require './config/concepts.rb'
require './config/redis.rb'


set :bind, '0.0.0.0'
set :port, 80
set :public_folder, 'public'

get '/houses/docs' do
  redirect '/houses/docs/index.html'
end

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

get '/houses/:id' do
  result = House::Get.(params.merge({user_id: USER['id']}))
  if result.success?
    body House::Representer.new(result['model']).to_json
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
  result = House::Update.(params.merge({user_id: USER['id']}))
  if result.success?
    body House::Representer.new(result['model']).to_json
  else
    if result['contract.default']
      status 422
      body result['contract.default'].errors.messages.uniq.to_json
    else
      status 404
    end
  end
end

delete '/houses/:id' do
  result = House::Delete.(params.merge({user_id: USER['id']}))
  if result.success?
    status 200
  else
    if result['contract.default'].errors.messages.size > 0
      status 422
      body result['contract.default'].errors.messages.uniq.to_json
    else
      status 404
    end
  end
end