require 'spec_helper'

RSpec.describe 'Zeus AMI' do
  it_behaves_like 'profile::base'
  it_behaves_like 'profile::ec2'
  it_behaves_like 'profile::docker'
  it_behaves_like 'profile::puppet::master'
end
