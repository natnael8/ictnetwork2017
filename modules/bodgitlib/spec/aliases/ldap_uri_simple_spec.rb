require 'spec_helper'

if Puppet::Util::Package.versioncmp(Puppet.version, '4.4.0') >= 0
  describe 'test::ldap::uri::simple', type: :class do
    describe 'accepts an LDAP URI' do
      [
        'ldap://',
        'ldap:///',
        'ldaps://',
        'ldaps:///',
        'ldapi://',
        'ldapi:///',
        'ldap://example.com',
        'ldap://example.com:389',
        'ldap://example.com:389/',
        'ldap://localhost',
        'ldap://localhost:389',
        'ldap://localhost:389/',
        'ldap://127.0.0.1',
        'ldap://127.0.0.1:389',
        'ldap://127.0.0.1:389/',
        'ldap://[1:2:3:4:5:6:7:8]',
        'ldap://[1:2:3:4:5:6:7:8]:389',
        'ldap://[1:2:3:4:5:6:7:8]:389/',
        'ldap://[::1]',
        'ldap://[::1]:389',
        'ldap://[::1]:389/',
        'ldap://[1:2:3:4:5:6:1.2.3.4]',
        'ldap://[1:2:3:4:5:6:1.2.3.4]:389',
        'ldap://[1:2:3:4:5:6:1.2.3.4]:389/',
        'ldap://[::1.2.3.4]',
        'ldap://[::1.2.3.4]:389',
        'ldap://[::1.2.3.4]:389/',
        'ldapi://%2fexample%2fcom',
        'ldapi://%2fexample%2fcom/',
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
        'ldap://127.0.0.1:65536',
        # LDAPI URI should not have a port
        'ldapi://%2fexample%2fcom:389',
      ].each do |value|
        describe value.inspect do
          let(:params) {{ value: value }}
          it { is_expected.to compile.and_raise_error(/parameter 'value' /) }
        end
      end
    end
  end
end
