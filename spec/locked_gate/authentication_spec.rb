require 'locked_gate/authentication'
require 'locked_gate/authentication_error'

describe LockedGate::Authentication do
  let(:token_expiration) { Time.zone.at(2.hours.from_now.to_i) }
  let(:configuration) { LockedGate::Configuration.new }
  let(:jwt_token) { JWT.encode({ email: 'test@test.com', exp: Integer(token_expiration) }, '123456', 'HS256') }

  describe '#authenticate!' do
    it 'raises AuthenticateError something wrong happen on strategy authentication' do
      authentication = described_class.new(configuration, 'invalid_jwt_token')

      expect do
        authentication.authenticate!
      end.to raise_error(LockedGate::AuthenticationError)
    end

    it 'set model Key when token is valid' do
      authentication = described_class.new(configuration, jwt_token)
      authentication.authenticate!
      expect(LockedGate::Key.attributes).to eq({ user: { email: 'test@test.com' }, expiration: token_expiration, token: jwt_token })
    end
  end
end
