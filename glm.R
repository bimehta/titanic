source('load.R')
source('clean.R')

model <- glm(survived ~ sex + pclass + age + title + sibsp, train, family = binomial)
cv.glm(train, model, K = 10)$delta[1]

survived <- round(predict(model, test) > 0)

train$survived <- as.factor(train$survived)
cv.ctrl <- trainControl("repeatedcv", repeats = 3, summaryFunction = twoClassSummary, classProbs = TRUE)
set.seed(1234)
glm.cv <- train(
  survived ~ sex + pclass,
  data = train,
  method = "glm",
  metric = "ROC",
  trControl = cv.ctrl
)