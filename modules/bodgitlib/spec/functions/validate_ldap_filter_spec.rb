require 'spec_helper'

describe 'validate_ldap_filter' do
  it { expect { should run.with_params() }.to raise_error(/Wrong number of arguments given/) }
  it { expect { should run.with_params(123) }.to raise_error(/Requires either an array or string to work with/) }
  it { expect { should run.with_params([123]) }.to raise_error(/Requires either an array or string to work with/) }
  it { expect { should run.with_params([]) }.to raise_error(/Requires an array with at least 1 element/) }
  it { expect { should run.with_params('invalid') }.to raise_error(/is not a valid LDAP filter/) }
  it { expect { should run.with_params(['invalid']) }.to raise_error(/is not a valid LDAP filter/) }
  # Taken from the RFC 4515 examples
  it { should run.with_params('(cn=Babs Jensen)') }
  it { should run.with_params('(!(cn=Tim Howes))') }
  it { should run.with_params('(&(objectClass=Person)(|(sn=Jensen)(cn=Babs J*)))') }
  it { should run.with_params('(o=univ*of*mich*)') }
  it { should run.with_params('(seeAlso=)') }
  it { should run.with_params('(cn:caseExactMatch:=Fred Flintstone)') }
  it { should run.with_params('(cn:=Betty Rubble)') }
  it { should run.with_params('(sn:dn:2.4.6.8.10:=Barney Rubble)') }
  it { should run.with_params('(o:dn:=Ace Industry)') }
  it { should run.with_params('(:1.2.3:=Wilma Flintstone)') }
  it { should run.with_params('(:DN:2.4.6.8.10:=Dino)') }
  it { should run.with_params('(o=Parens R Us \28for all your parenthetical needs\29)') }
  it { should run.with_params('(cn=*\2A*)') }
  it { should run.with_params('(filename=C:\5cMyFile)') }
  it { should run.with_params('(bin=\00\00\00\04)') }
  it { should run.with_params('(sn=Lu\c4\8di\c4\87)') }
  it { should run.with_params('(1.3.6.1.4.1.1466.0=\04\02\48\69)') }
  # Issue #8 highlighted this one
  it { should run.with_params('(&(sAMAccountName=%u)(!(memberOf=cn=groupname,ou=User Security Groups,ou=Users,dc=my,dc=example,dc=com)))') }
  it {
    should run.with_params([
      '(cn=Babs Jensen)',
      '(!(cn=Tim Howes))',
      '(&(objectClass=Person)(|(sn=Jensen)(cn=Babs J*)))',
      '(o=univ*of*mich*)',
      '(seeAlso=)',
      '(cn:caseExactMatch:=Fred Flintstone)',
      '(cn:=Betty Rubble)',
      '(sn:dn:2.4.6.8.10:=Barney Rubble)',
      '(o:dn:=Ace Industry)',
      '(:1.2.3:=Wilma Flintstone)',
      '(:DN:2.4.6.8.10:=Dino)',
      '(o=Parens R Us \28for all your parenthetical needs\29)',
      '(cn=*\2A*)',
      '(filename=C:\5cMyFile)',
      '(bin=\00\00\00\04)',
      '(sn=Lu\c4\8di\c4\87)',
      '(1.3.6.1.4.1.1466.0=\04\02\48\69)',
      '(&(sAMAccountName=%u)(!(memberOf=cn=groupname,ou=User Security Groups,ou=Users,dc=my,dc=example,dc=com)))',
    ])
  }
end
