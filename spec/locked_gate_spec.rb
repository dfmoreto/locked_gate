require 'locked_gate/authentication_error'

RSpec.describe LockedGate do
  it 'has a version number' do
    expect(LockedGate::VERSION).to be_present
  end

  describe 'default configuration' do
    let(:locked_gate_class) { described_class.dup }

    context 'when there are not config set' do
      it ':expiration_param receive default value' do
        expect(locked_gate_class.configuration.expiration_param).to eq :exp
      end

      it 'header token is get with default way' do
        headers = { 'Authorization' => 'Bearer abdcefghij' }
        expect(locked_gate_class.configuration.token_header_capture_block.call(headers)).to eq 'abdcefghij'
      end

      it 'param token is get with default way' do
        params = { token: 'abdcefghij' }
        expect(locked_gate_class.configuration.token_params_capture_block.call(params)).to eq 'abdcefghij'
      end
    end

    context 'when there are config set' do
      before do
        locked_gate_class.configure do |config|
          config.expiration_key :expiration
          config.param_key :test_token
          config.capture_token_on_header with: proc { |header| header['Authorization'].gsub(/my_regex (\d+)/, '\1') }
        end
      end

      it ':expiration_param receive configured one' do
        expect(locked_gate_class.configuration.expiration_param).to eq :expiration
      end

      it 'header token is get with customized method' do
        headers = { 'Authorization' => 'my_regex 12345678' }
        expect(locked_gate_class.configuration.token_header_capture_block.call(headers)).to eq '12345678'
      end

      it 'param token is get with customized method' do
        params = { test_token: '12345678' }
        expect(locked_gate_class.configuration.token_params_capture_block.call(params)).to eq '12345678'
      end
    end
  end

  describe 'including' do
    context 'with custom configuration' do
      let(:some_class) do
        Class.new(ActionController::API) do
          include LockedGate

          gate_unlock_configuration do |config|
            config.expiration_key :custom_expiration
            config.param_key :custom_token
            config.capture_token_on_header with: proc { |header| header['Authorization'].gsub(/my_custom (\d+)/, '\1') }
          end
        end
      end

      it ':expiration_param receive configured one' do
        expect(some_class.custom_locked_gate_configuration.expiration_param).to eq :custom_expiration
      end

      it 'header token is get with customized method' do
        headers = { 'Authorization' => 'my_custom 12345678' }
        expect(some_class.custom_locked_gate_configuration.token_header_capture_block.call(headers)).to eq '12345678'
      end

      it 'param token is get with customized method' do
        params = { custom_token: '12345678' }
        expect(some_class.custom_locked_gate_configuration.token_params_capture_block.call(params)).to eq '12345678'
      end
    end

    context 'without custom configuration' do
      let(:some_class) do
        Class.new(ActionController::API) do
          include LockedGate
        end
      end

      it ':expiration_param receive default value' do
        expect(some_class.custom_locked_gate_configuration.expiration_param).to eq :exp
      end

      it 'header token is get with default way' do
        headers = { 'Authorization' => 'Bearer abdcefghij' }
        expect(some_class.custom_locked_gate_configuration.token_header_capture_block.call(headers)).to eq 'abdcefghij'
      end

      it 'param token is get with default way' do
        params = { token: 'abdcefghij' }
        expect(some_class.custom_locked_gate_configuration.token_params_capture_block.call(params)).to eq 'abdcefghij'
      end
    end
  end

  describe 'authenticate_user!', type: :request do
    it 'renders right status when token is valid' do
      token = JWT.encode({ email: 'test@test.com', exp: Integer(2.minutes.from_now) }, '123456', 'HS256')
      get '/authenticated', headers: { 'Authorization' => "Bearer #{token}" }
      expect(response).to have_http_status :ok
    end

    context 'when token is invalid' do
      it 'renders status 401' do
        get '/authenticated', headers: { 'Authorization' => 'invalid_token' }
        expect(response).to have_http_status :unauthorized
      end

      it 'renders a default response' do
        get '/authenticated', headers: { 'Authorization' => 'invalid_token' }
        json_response = JSON.parse(response.body)
        expect(json_response).to eq({ 'message' => 'Invalid token' })
      end
    end
  end
end
