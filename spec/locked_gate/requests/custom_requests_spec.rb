describe 'Custom Requests', type: :request do
  context 'when api is authenticated without any customization' do
    context 'with valid token' do
      let(:token) { JWT.encode({ email: 'test@test.com', expiration: Integer(2.minutes.from_now) }, 'abcdef', 'HS256') }

      it 'renders right status when header token is valid' do
        token = JWT.encode({ email: 'test@test.com', expiration: Integer(2.minutes.from_now) }, 'abcdef', 'HS256')
        get '/custom_api/no_custom_authenticated', headers: { 'Authorization' => "api_token #{token}" }
        expect(response).to have_http_status :ok
      end

      it 'renders right status when param token is valid' do
        get '/custom_api/no_custom_authenticated', params: { api_token: token }
        expect(response).to have_http_status :ok
      end
    end

    context 'when token is invalid' do
      it 'renders status 401' do
        get '/custom_api/no_custom_authenticated', headers: { 'Authorization' => 'invalid_token' }
        expect(response).to have_http_status :unauthorized
      end

      it 'renders a default response' do
        get '/custom_api/no_custom_authenticated', headers: { 'Authorization' => 'invalid_token' }
        json_response = JSON.parse(response.body)
        expect(json_response).to eq({ 'message' => 'Invalid token' })
      end
    end
  end

  context 'when api is authenticated with its own customization' do
    context 'with valid token' do
      let(:token) { JWT.encode({ email: 'test@test.com', custom_expiration: Integer(2.minutes.from_now) }, 'abcdef', 'HS256') }

      it 'renders right status when header token is valid' do
        get '/custom_api/custom_authenticated', headers: { 'Authorization' => "custom_token #{token}" }
        expect(response).to have_http_status :ok
      end

      it 'renders right status when param token is valid' do
        get '/custom_api/custom_authenticated', params: { custom_token: token }
        expect(response).to have_http_status :ok
      end
    end

    context 'with invalid token' do
      it 'renders status 401' do
        get '/custom_api/custom_authenticated', headers: { 'Authorization' => 'invalid_token' }
        expect(response).to have_http_status :unauthorized
      end

      it 'renders a default response' do
        get '/custom_api/custom_authenticated', headers: { 'Authorization' => 'invalid_token' }
        json_response = JSON.parse(response.body)
        expect(json_response).to eq({ 'message' => 'Invalid token' })
      end
    end
  end

  context 'when api is unauthenticated' do
    it 'renders 200 status without any token' do
      get '/custom_api/unauthenticated'
      expect(response).to have_http_status :ok
    end
  end
end
