require 'locked_gate/token_discovery'
require 'locked_gate/configuration'

describe LockedGate::TokenDiscovery do
  let(:configuration) do
    config = LockedGate::Configuration.new
    config.post_key :post_token
    config.query_string_key :query_string_token
    config.header_regex regex: /my_token (\w+)/, match: '\1'
    config
  end

  describe '#token' do
    it 'returns match from header if Authorization is present' do
      token_discovery = described_class.new(configuration, headers: { 'Authorization' => 'my_token abcdefghi' })
      expect(token_discovery.token).to eq 'abcdefghi'
    end

    it 'returns match from header if Authorization even if query string or post param are present' do
      token_discovery = described_class.new(configuration, headers: { 'Authorization' => 'my_token abcdefghi' }, 
                                                           params: { query_string_token: 'jklmnopq', post_token: 'rstuvwxyz' })
      expect(token_discovery.token).to eq 'abcdefghi'
    end

    it 'returns from query string param if header is not present' do
      token_discovery = described_class.new(configuration, params: { query_string_token: 'abcdefghi' })
      expect(token_discovery.token).to eq 'abcdefghi'
    end

    it 'returns from query string param even if post param is present' do
      token_discovery = described_class.new(configuration, params: { query_string_token: 'abcdefghi', post_token: 'jklmnopq' })
      expect(token_discovery.token).to eq 'abcdefghi'
    end

    it 'returns from post param if header and query string are not present' do
      token_discovery = described_class.new(configuration, params: { post_token: 'abcdefghi' })
      expect(token_discovery.token).to eq 'abcdefghi'
    end
  end
end
