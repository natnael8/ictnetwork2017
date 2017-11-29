require 'spec_helper'

if Puppet::Util::Package.versioncmp(Puppet.version, '4.4.0') >= 0
  describe 'test::ldap::dn', type: :class do
    describe 'accepts an LDAP DN' do
      [
        'CN=Steve Kille,O=Isode Limited,C=GB',
        'OU=Sales+CN=J. Smith,O=Widget Inc.,C=US',
        'CN=L. Eagle,O=Sue\, Grabbit and Runn,C=GB',
        'CN=Before\0DAfter,O=Test,C=GB',
        '1.3.6.1.4.1.1466.0=#04024869,O=Test,C=GB',
      ].each do |value|
        describe value.inspect do
          let(:params) {{ value: value }}
          it { is_expected.to compile }
        end
      end
    end
    describe 'rejects other values' do
      [
        123,
        'invalid',
      ].each do |value|
        describe value.inspect do
          let(:params) {{ value: value }}
          it { is_expected.to compile.and_raise_error(/parameter 'value' /) }
        end
      end
    end
  end
end
