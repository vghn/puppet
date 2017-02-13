shared_examples 'profile::aws::s3fs' do
  packages = %w(libcurl4-gnutls-dev libfuse-dev libssl-dev libxml2-dev s3fs-fuse)
  packages.each do |pkg|
    describe package(pkg) do
      it { is_expected.to be_installed }
    end
  end
end
