source('load.R')
source('clean.R')

# most people died
mean(train$survived)
test$survived <- 0

# most females survived
mean(train[train$sex == 'F', 'survived'])
test[test$sex == 'F', 'survived'] <- 1

# any group of females die?
mean(train[train$sex == 'F' & train$pclass == 3 & train$sibsp > 1, 'survived'])

mean(train[train$sex == 'F' & train$pclass > 1 & train$sibsp > 1, 'survived'])
test[test$sex == 'F' & test$pclass > 1 & test$sibsp > 1, 'survived'] <- 0

mean(train[train$sex == 'F' & train$pclass > 1 & train$sibsp > 1 & train$embarked == 'C', 'survived'])
test[test$sex == 'F' & test$pclass > 1 & test$sibsp > 1 & test$embarked == 'C', 'survived'] <- 1

# any group of males survive?
mean(train[train$sex == 'M' & train$pclass == 1, 'survived'])
mean(train[train$title == 'master', 'survived'])
test[test$title == 'master', 'survived'] <- 1
mean(train[train$title == 'master' & train$pclass == 3, 'survived'])
test[test$title == 'master' & test$pclass == 3, 'survived'] <- 0
mean(train[train$title == 'master' & train$pclass == 3 & train$embarked == 'C', 'survived'])
test[test$title == 'master' & test$pclass == 3 & train$embarked == 'C', 'survived'] <- 1

# compare train and test survival rates
mean(train$survived)
mean(test$survived)

answer <- data.frame(PassengerId = test$passengerid, Survived = test$survived)
write.csv(answer, 'submit-003.csv', quote = FALSE, row.names = FALSE)
sum(read.csv('submit-002.csv') != answer)
sum(read.csv('submit-001.csv') != answer)

