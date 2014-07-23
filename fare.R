source('load.R')
source('clean.R')

sum(is.na(full$fare))

full[order(full$fare), 'fare']

qplot(fare, data = full)

ggplot(full, aes(fare)) + geom_histogram(binwidth = 20) + facet_wrap(~ pclass)