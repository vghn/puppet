shared_examples 'profile::rvm' do
  describe command('/usr/local/rvm/bin/rvm list') do
    its(:stdout) { is_expected.to match(/ruby/) }
    its(:exit_status) { is_expected.to eq 0 }
  end
end
