require File.expand_path '../spec_helper.rb', __FILE__

describe 'Houses Service' do
  before(:each) do
    DB.execute('TRUNCATE TABLE houses;')
    stub_request(:get, 'http://lb/users/by_token').
        with(headers: {'Authorization'=>"Bearer #{token}"}).
        to_return(status: 200, body: '{"id":1,"email":"test@test.com","token":"a722658b-0fea-415c-937f-1c1d3c8342fd","created_at":"2017-11-14 16:06:52 +0000","updated_at":"2017-11-14 16:06:52 +0000"}', headers: {})
    stub_request(:get, 'http://lb/users/by_token').
        with(headers: {'Authorization'=>'Bearer wrong_token'}).
        to_return(status: 422, body: '', headers: {})
  end

  it 'should list all houses for user' do
    house_title = house.title
    header 'Authorization', "Bearer #{token}"
    get '/houses'

    expect(last_response).to be_ok
    body = JSON.parse(last_response.body)
    expect(body[0]['title'] == house_title).to be_truthy
  end

  it 'should not list all houses for user with wrong token' do
    header 'Authorization', 'Bearer wrong_token'
    get '/houses'

    expect(last_response.status).to equal(401)
  end

  def token
    'a722658b-0fea-415c-937f-1c1d3c8342fd'
  end

  def house
    House::Create.(title: 'MyHouse', user_id: 1)['model']
  end
end