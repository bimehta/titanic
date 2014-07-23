source('load.R')
source('clean.R')

sum(is.na(full$sex) || full$sex == ' ')

ggplot(train, aes(sex, survived)) + stat_summary(fun.y = mean, geom = 'bar')