source('load.R')
source('clean.R')

library(randomForest)

model.create <- function(data) {
  randomForest(survived ~ sex + pclass + cabin + embarked, data = data)
}

model.predict <- function(model, data) {predict(model, data)}

source('validate.R', echo = TRUE)