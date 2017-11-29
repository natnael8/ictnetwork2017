# @since 1.5.0
type Bodgitlib::Domain = Pattern[/(?x) ^ (?= [a-z0-9.-]{2,255} ) ( (?= [a-z0-9-]{1,63} \. ) [a-z0-9]+ ( - [a-z0-9]+ )* \. )* [a-z]{2,63} $/]
