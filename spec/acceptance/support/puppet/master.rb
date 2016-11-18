shared_examples 'profile::puppet::master' do
  describe iptables do
    it do
      is_expected.to have_rule('-A INPUT -p tcp -m multiport --dports 8140 '\
                               '-m comment --comment "100 allow puppet '\
                               'access" -j ACCEPT')
    end
  end
end
