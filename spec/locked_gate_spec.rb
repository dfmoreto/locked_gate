RSpec.describe LockedGate do
  it 'has a version number' do
    expect(LockedGate::VERSION).to be_present
  end

  describe 'default configuration' do
    let(:locked_gate_class) { described_class.clone }

    context 'when there are not config set' do
      it ':post_param receive default value' do
        expect(locked_gate_class.configuration.post_param).to eq :token
      end

      it ':query_string_param receive default value' do
        expect(locked_gate_class.configuration.query_string_param).to eq :token
      end

      it ':expiration_param receive default value' do
        expect(locked_gate_class.configuration.expiration_param).to eq :exp
      end

      it 'header_config :regex receive default value' do
        expect(locked_gate_class.configuration.header_config.regex).to eq /Bearer (.*)\s?/
      end

      it 'header_config :match receive default value' do
        expect(locked_gate_class.configuration.header_config.match).to eq '\1'
      end
    end

    context 'when there are config set' do
      before do
        locked_gate_class.configure do |config|
          config.post_key :test_post
          config.query_string_key :query_string_test
          config.expiration_key :expiration
          config.header_regex regex: /my_regex/, match: '\3'
        end
      end

      it ':post_param receive configured value' do
        expect(locked_gate_class.configuration.post_param).to eq :test_post
      end

      it ':query_string_param receive configured value' do
        expect(locked_gate_class.configuration.query_string_param).to eq :query_string_test
      end

      it ':expiration_param receive configured value' do
        expect(locked_gate_class.configuration.expiration_param).to eq :expiration
      end

      it 'header_config :regex receive configured value' do
        expect(locked_gate_class.configuration.header_config.regex).to eq(/my_regex/)
      end

      it 'header_config :match receive configured value' do
        expect(locked_gate_class.configuration.header_config.match).to eq '\3'
      end
    end
  end

  describe 'including' do
    context 'without custom configuration' do
      let(:some_class) do
        Class.new do
          include LockedGate
        end
      end

      it ':post_param receive default value' do
        expect(some_class.custom_locked_gate_configuration.post_param).to eq :token
      end

      it ':query_string_param receive default value' do
        expect(some_class.custom_locked_gate_configuration.query_string_param).to eq :token
      end

      it ':expiration_param receive default value' do
        expect(some_class.custom_locked_gate_configuration.expiration_param).to eq :exp
      end

      it 'header_config :regex receive default value' do
        expect(some_class.custom_locked_gate_configuration.header_config.regex).to eq /Bearer (.*)\s?/
      end

      it 'header_config :match receive default value' do
        expect(some_class.custom_locked_gate_configuration.header_config.match).to eq '\1'
      end
    end

    context 'with custom configuration' do
      let(:some_class) do
        Class.new do
          include LockedGate

          gate_unlock_configuration do |config|
            config.post_key :custom_post_token
            config.query_string_key :custom_query_string_token
            config.expiration_key :custom_expiration
            config.header_regex regex: /custom_regex/, match: '\2'
          end
        end
      end

      it ':post_param receive default value' do
        expect(some_class.custom_locked_gate_configuration.post_param).to eq :custom_post_token
      end

      it ':query_string_param receive default value' do
        expect(some_class.custom_locked_gate_configuration.query_string_param).to eq :custom_query_string_token
      end

      it ':expiration_param receive default value' do
        expect(some_class.custom_locked_gate_configuration.expiration_param).to eq :custom_expiration
      end

      it 'header_config :regex receive default value' do
        expect(some_class.custom_locked_gate_configuration.header_config.regex).to eq /custom_regex/
      end

      it 'header_config :match receive default value' do
        expect(some_class.custom_locked_gate_configuration.header_config.match).to eq '\2'
      end
    end
  end
end
