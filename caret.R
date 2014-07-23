library(randomForest)
library(gbm)
library(plyr)
library(e1071)
library(elasticnet)
library(pls)
library(leaps)
library(kernlab)
library(mboost)
library(mgcv)
library(pROC)
library(caret)
library(doMC)

registerDoMC(cores = 5)

source('load.R')
source('clean.R')

data <- train
data$survived <- as.factor(data$survived)

form <- survived ~ sex + pclass
form <- survived ~ sex + pclass + age + title + sibsp

ctrl <- trainControl('repeatedcv', number = 5, repeats = 3)
ctrl <- trainControl("repeatedcv", repeats = 3, summaryFunction = twoClassSummary, classProbs = TRUE)

fit <- train(form, data, 'rf', trControl = ctrl)
fit <- train(form, data, 'svmLinear', trControl = ctrl)
fit <- train(form, data, 'svmRadial', trControl = ctrl)
fit <- train(form, data, 'lda', trControl = ctrl)
fit <- train(form, data, 'qda', trControl = ctrl)
fit <- train(form, data, 'glm', trControl = ctrl)
fit <- train(form, data, 'knn', trControl = ctrl)

survived <- predict(fit, test)
source('submit.R')
