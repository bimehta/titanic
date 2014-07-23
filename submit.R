answer <- data.frame(PassengerId = test$passengerid, Survived = survived)
write.csv(answer, 'submit-003.csv', quote = FALSE, row.names = FALSE)
sum(read.csv('submit-002.csv') != answer)
sum(read.csv('submit-001.csv') != answer)