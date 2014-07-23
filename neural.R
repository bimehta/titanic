source('load.R')
source('clean.R')

library(nnet)

model <- nnet(survived ~ sex + pclass + age + title + sibsp, size = 1, data = train, maxit = 100000)
survived <- round(predict(model, test, type = 'raw'))
mean(survived)
