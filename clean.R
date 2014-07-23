full$last <- sapply(strsplit(full$name, ','), function(x) x[1])
full$age <- round(full$age)
full$fare <- round(full$fare)
full$sex <- factor(toupper(substring(full$sex, 1, 1)))
full$cabin[full$cabin == ''] <- full$pclass[full$cabin == '']
full$cabin <- factor(sapply(full$cabin, function(cabin) substring(cabin, 1, 1)))
full$embarked <- factor(full$embarked)
full[full$embarked == '', 'embarked'] <- 'S'

full$title <- NA
full[grepl(' Mr\\.', full$name), 'title'] <- 'mr'
full[grepl(' Mrs\\.', full$name), 'title'] <- 'mrs'
full[grepl(' Rev\\.', full$name), 'title'] <- 'rev'
full[grepl(' Dr\\.', full$name), 'title'] <- 'dr'
full[grepl(' Master\\.', full$name), 'title'] <- 'master'
full[grepl(' Miss\\.', full$name), 'title'] <- 'miss'
full[grepl(' Don\\.', full$name), 'title'] <- 'sir'
full[grepl(' Dona\\.', full$name), 'title'] <- 'lady'
full[grepl(' Mme\\.', full$name), 'title'] <- 'lady'
full[grepl(' Ms\\.', full$name), 'title'] <- 'lady'
full[grepl(' Major\\.', full$name), 'title'] <- 'sir'
full[grepl(' Lady\\.', full$name), 'title'] <- 'lady'
full[grepl(' Sir\\.', full$name), 'title'] <- 'sir'
full[grepl(' Mlle\\.', full$name), 'title'] <- 'lady'
full[grepl(' Col\\.', full$name), 'title'] <- 'sir'
full[grepl(' Capt\\.', full$name), 'title'] <- 'sir'
full[grepl(' Countess\\.', full$name), 'title'] <- 'lady'
full[grepl(' Jonkheer\\.', full$name), 'title'] <- 'lady'
full$title <- factor(full$title)

full$ticket <- factor(sapply(full$ticket, function(ticket) {
  if (grepl('paris', ticket, ignore.case = TRUE)) {
    return('paris')
  } else if (substring(ticket, 1, 2) == 'PC') {
    return('pc')
  } else if (substring(ticket, 1, 2) == 'PP') {
    return('pp')
  } else if (substring(ticket, 1, 4) == 'P/PP') {
    return('ppp')
  } else if (substring(ticket, 1, 5) == 'S.O.C') {
    return('soc')
  } else if (substring(ticket, 1, 4) == 'SO/C') {
    return('soc')
  } else if (substring(ticket, 1, 4) == 'STON') {
    return('ston')
  } else if (substring(ticket, 1, 2) == 'XX') {
    return('xx')
  } else {
    return('xx')
  }
}))

full$last.any.lived <- sapply(1 : nrow(full), function(i) {
  survivors <- subset(
    full, last == full[i, 'last'] & 
      name != full[i, 'name'] & 
      !is.na(full[i, 'survived'])
  )
  ifelse (nrow(survivors) == 0, 0.5, 1.0 * (sum(survivors$survived) > 0))
})

# impute age to mean age for title
full[is.na(full$age), 'age'] <- sapply(full[is.na(full$age), 'title'], function(title) {
  round(mean(full[full$title == title, 'age'], na.rm = TRUE))
})

train <- subset(full, !is.na(survived))
row.names(train) <- NULL
test <- subset(full, is.na(survived))
row.names(test) <- NULL