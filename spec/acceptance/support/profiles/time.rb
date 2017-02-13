shared_examples 'profile::time' do
  describe package('tzdata') do
    it { is_expected.to be_installed }
  end

  req_files = %w(/etc/localtime /etc/timezone)
  req_files.each do |req_file|
    describe file(req_file) do
      it { is_expected.to exist }
    end
  end
end
