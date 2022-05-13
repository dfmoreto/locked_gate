describe 'No Custom Requests', type: :request do
  context 'when api is authenticated' do
    it 'renders right status when token is valid' do
      token = JWT.encode({ email: 'test@test.com', exp: Integer(2.minutes.from_now) }, '123456', 'HS256')
      get '/no_custom_api/authenticated', headers: { 'Authorization' => "Bearer #{token}" }
      expect(response).to have_http_status :ok
    end

    context 'when token is invalid' do
      it 'renders status 401' do
        get '/no_custom_api/authenticated', headers: { 'Authorization' => 'invalid_token' }
        expect(response).to have_http_status :unauthorized
      end

      it 'renders a default response' do
        get '/no_custom_api/authenticated', headers: { 'Authorization' => 'invalid_token' }
        json_response = JSON.parse(response.body)
        expect(json_response).to eq({ 'message' => 'Invalid token' })
      end
    end
  end

  context 'when api is unauthenticated' do
    it 'renders 200 status without any token' do
      get '/no_custom_api/unauthenticated'
      expect(response).to have_http_status :ok
    end
  end
end
