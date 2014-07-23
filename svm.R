source('load.R')
source('clean.R')

library(kernlab)

model.create <- function(data) {
  ksvm(survived ~ sex + pclass + cabin + embarked, data = data)
}

model.predict <- function(model, data) {predict(model, data, type = 'response')}

source('validate.R', echo = TRUE)