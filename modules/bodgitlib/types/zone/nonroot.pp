# @since 1.8.1
type Bodgitlib::Zone::NonRoot = Pattern[/(?x) ^ (?= [a-z0-9.-]{2,255} ) ( (?= [a-z0-9-]{1,63} \. ) [a-z0-9]+ ( - [a-z0-9]+ )* \. )* [a-z]{2,63} \. $/]
