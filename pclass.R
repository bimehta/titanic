source('load.R')
source('clean.R')

ggplot(train, aes(pclass, survived)) + stat_summary(fun.y = mean, geom = 'bar') + facet_wrap(embarked ~ sex)