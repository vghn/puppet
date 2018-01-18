shared_examples 'profile::linuxfw' do
  describe iptables do
    it do
      is_expected.to have_rule('-A INPUT -m state --state RELATED,ESTABLISHED -m comment --comment "003 accept related established rules" -j ACCEPT')
    end

    it do
      is_expected.to have_rule('-A INPUT -p tcp -m multiport --dports 1234 -m state --state NEW -m comment --comment "123 test rule" -j ACCEPT')
    end

    it do
      is_expected.to have_rule('-A INPUT -p tcp -m multiport --dports 22 -m state --state NEW,ESTABLISHED -m limit --limit 6/min --limit-burst 6 -m comment --comment "004 accept ssh connections" -j ACCEPT')
    end
  end
end
