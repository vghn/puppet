shared_examples 'profile::linuxfw' do
  describe iptables do
    it do
      is_expected.to have_rule(
        '-A INPUT -m state ' \
        '--state RELATED,ESTABLISHED -j ACCEPT'
      )
    end
    it do
      is_expected.to have_rule('-A INPUT -p tcp -m multiport --dports 1234 ' \
                               '-m comment --comment "123 test rule" ' \
                               '-m state --state NEW -j ACCEPT')
    end
  end
end
