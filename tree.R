source('load.R')
source('clean.R')

library(tree)

model.create <- function(data) {
  tree(survived ~ sex + pclass + title + embarked + sibsp, data = data)
}

model.predict <- function(model, data) {predict(model, data)}

source('validate.R', echo = TRUE)
