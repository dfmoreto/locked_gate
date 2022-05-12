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

  describe '#header_config' do
    it ':regex option sets header_regex' do
      subject.header_config regex: /my_custom_regex/
      expect(subject.header_regex).to eq(/my_custom_regex/)
    end

    it 'header_regex keeps the same if :regex is not sent' do
      expect do
        subject.header_config
      end.not_to change(subject, :header_regex)
    end

    it ':match option sets header_match' do
      subject.header_config match: '\5'
      expect(subject.header_match).to eq '\5'
    end

    it 'header_match keeps the same if :match is not sent' do
      expect do
        subject.header_config
      end.not_to change(subject, :header_match)
    end
  end
end
