# @since 1.6.0
type Bodgitlib::LDAP::URI::LDAPI::Simple = Pattern[/(?x) ^ ldapi:\/\/ (?: (?= [a-zA-Z0-9.%_-]{2,255} ) (?: [a-zA-Z0-9._-] | % [[:xdigit:]]{2} )+ )? \/? $/]
