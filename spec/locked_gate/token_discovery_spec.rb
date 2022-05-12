require 'locked_gate/token_discovery'
require 'locked_gate/configuration'

describe LockedGate::TokenDiscovery do
  let(:configuration) do
    config = LockedGate::Configuration.new
    config.capture_token_on_header with: proc { |headers| headers['Authorization'].gsub(/my_token (\w+)/, '\1') }
    config.param_key :post_token
    config
  end

  describe '#token' do
    it 'returns match from header capture' do
      token_discovery = described_class.new(configuration, headers: { 'Authorization' => 'my_token abcdefghi' })
      expect(token_discovery.token).to eq 'abcdefghi'
    end

    it 'returns from query string param if header is not present' do
      token_discovery = described_class.new(configuration, params: { post_token: 'abcdefghi' })
      expect(token_discovery.token).to eq 'abcdefghi'
    end
  end
end
