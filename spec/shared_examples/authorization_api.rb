shared_examples_for 'AuthorizationApi' do

  context 'unauthorized' do

    it 'returns 401 status if there is no access_token' do
      request
      expect(response.status).to eq 401
    end

    it 'returns 401 status if  access_token is invalid' do
      request(access_token: '1234')
      expect(response.status).to eq 401
    end
  end
end