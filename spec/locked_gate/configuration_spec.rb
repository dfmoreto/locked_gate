describe LockedGate::Configuration do
  it '#expiration_key sets :expiration_param' do
    subject.expiration_key :custom_expiration
    expect(subject.expiration_param).to eq :custom_expiration
  end

  describe '#capture_token_on_header' do
    it 'sets :token_header_capture_block' do
      block_to_test = proc { |request| request['some_token'] }
      subject.capture_token_on_header(with: block_to_test)
      expect(subject.token_header_capture_block).to eq block_to_test
    end

    it 'returns data to be used' do
      header = { 'some_token' => 'some_random_token' }
      block_to_test = proc { |headers| headers['some_token'] }
      subject.capture_token_on_header(with: block_to_test)
      expect(subject.token_header_capture_block.call(header)).to eq 'some_random_token'
    end
  end

  describe '#capture_token_on_params' do
    it 'sets :token_header_capture_block' do
      block_to_test = proc { |request| request['some_token'] }
      subject.capture_token_on_params(with: block_to_test)
      expect(subject.token_params_capture_block).to eq block_to_test
    end

    it 'returns data to be used' do
      params = { 'some_token' => 'some_random_token' }
      block_to_test = proc { |param| param['some_token'] }
      subject.capture_token_on_params(with: block_to_test)
      expect(subject.token_params_capture_block.call(params)).to eq 'some_random_token'
    end
  end

  it '#param_key sets new :token_header_capture_block returning only param key value' do
    params = { some_token: 'some_random_token' }
    subject.param_key :some_token
    expect(subject.token_params_capture_block.call(params)).to eq 'some_random_token'
  end
end
