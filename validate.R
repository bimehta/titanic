n <- nrow(train)
best.score <- 0
best.model <- NULL

results <- data.frame(scores = replicate(30, {
  trial <- sample(1 : n, n * 4 / 5)
  model <- model.create(train[trial, ])
  cv <- train[-trial, ]
  score <- mean(cv$survived == round(model.predict(model, cv)))
  if (score > best.score) {
    best.score <<- score
    best.model <<- model
  }
  score
}))  

ggplot(results, aes(scores)) + geom_histogram(binwidth = .01)