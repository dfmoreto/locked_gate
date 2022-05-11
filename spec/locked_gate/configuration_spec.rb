describe LockedGate::Configuration do
  it '#post_key sets :post_param' do
    subject.post_key :custom_post_token
    expect(subject.post_param).to eq :custom_post_token
  end

  it '#query_string_key sets :query_string_param' do
    subject.query_string_key :custom_query_string_token
    expect(subject.query_string_param).to eq :custom_query_string_token
  end

  it '#expiration_key sets :expiration_param' do
    subject.expiration_key :custom_expiration
    expect(subject.expiration_param).to eq :custom_expiration
  end

  describe '#header_regex' do
    it ':regex option sets header_config :regex' do
      subject.header_regex regex: /my_custom_regex/
      expect(subject.header_config.regex).to eq(/my_custom_regex/)
    end

    it ':match option sets header_config :match' do
      subject.header_regex match: '\5'
      expect(subject.header_config.match).to eq '\5'
    end
  end
end
