source('load.R')
source('clean.R')

sum(is.na(full$title))

ggplot(train, aes(title, survived)) + stat_summary(fun.y = mean, geom = 'bar')
ggplot(train, aes(title, survived)) + stat_summary(fun.y = sum, geom = 'bar')
