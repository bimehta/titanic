source('load.R')
source('clean.R')

sum(full$embarked == '')
ggplot(full, aes(embarked)) + geom_histogram()

ggplot(train, aes(embarked, survived)) + stat_summary(fun.y = mean, geom = 'bar')
last_plot() + facet_wrap(~ sex)