require 'locked_gate/auth_strategies/jwt'
require 'locked_gate/authentication_error'

describe LockedGate::AuthStrategies::JWT do
  let(:token_expiration) { Time.zone.at(2.hours.from_now.to_i) }
  let(:configuration) { LockedGate::Configuration.new }
  let(:jwt_token) { JWT.encode({ email: 'test@test.com', exp: Integer(token_expiration) }, '123456', 'HS256') }

  describe '#authenticate!' do
    let(:expired_jwt_token) { JWT.encode({ email: 'test@test.com', exp: 2.minutes.ago.to_i }, '123456', 'HS256') }

    it 'raises AuthenticationError when token is invalid' do
      auth = described_class.new(configuration, 'some_invalid_token')
      expect do
        auth.authenticate!
      end.to raise_error(LockedGate::AuthenticationError)
    end

    it 'raises AuthenticationError whem token is expired' do
      auth = described_class.new(configuration, expired_jwt_token)
      expect do
        auth.authenticate!
      end.to raise_error(LockedGate::AuthenticationError)
    end

    it 'does not raise any error when token is valid' do
      auth = described_class.new(configuration, jwt_token)
      expect do
        auth.authenticate!
      end.not_to raise_error
    end
  end

  it '#expiration return expiration date' do
    auth = described_class.new(configuration, jwt_token)
    expect(auth.expiration).to eq token_expiration
  end

  it '#user_data returns hash with user fields' do
    auth = described_class.new(configuration, jwt_token)
    expect(auth.user_info).to eq({ email: 'test@test.com' })
  end
end
