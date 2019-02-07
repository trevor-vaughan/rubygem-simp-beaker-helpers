require 'spec_helper_acceptance'

describe 'Offline mode' do
  hosts.each do |host|
    context "on #{host}" do
      it 'preps for testing by downloading boxes for tests' do
        on(host, 'runuser build_user -l -c "vagrant box add --provider virtualbox centos/6"')
        on(host, 'runuser build_user -l -c "vagrant box add --provider virtualbox centos/7"')
      end

      it 'downloads a module to test' do
        on(host, 'runuser build_user -l -c "git clone https://github.com/simp/pupmod-simp-aide"')
      end

      it 'preps the module for building' do
        on(host, 'runuser build_user -l -c "cd pupmod-simp-aide; bundle update"')
      end

      it 'disables all non-hostbound network traffic via iptables' do
        on(host, %(iptables -I OUTPUT -d `ip route | awk '/default/ {print $3}'`/16 -j ACCEPT))
        on(host, 'iptables -A OUTPUT -j DROP')
      end
    end
  end
end
