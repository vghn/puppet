shared_examples 'profile::aws::s3fs' do
  describe package('libcurl4-gnutls-dev') do
    it { is_expected.to be_installed }
  end
  describe package('libfuse-dev') do
    it { is_expected.to be_installed }
  end
  describe package('libssl-dev') do
    it { is_expected.to be_installed }
  end
  describe package('libxml2-dev') do
    it { is_expected.to be_installed }
  end
  describe package('s3fs-fuse') do
    it { is_expected.to be_installed }
  end
end
