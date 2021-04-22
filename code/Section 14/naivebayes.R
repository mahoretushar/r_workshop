# source - https://archive.ics.uci.edu/ml/machine-learning-databases/nursery/

nursery <- read.delim("nursery.data.txt", sep = ",", header = FALSE)

colnames(nursery) <- c(
  "parents",
  "has_nurs",
  "form",
  "children",
  "housing",
  "finance",
  "social",
  "health",
  "class"
)

str(nursery)

summary(nursery)

sum(is.na(nursery))

set.seed(100)
nursery$random <- runif (nrow(nursery), 0, 1)
trainingData <- nursery[which(nursery$random <= 0.8),]
testData <- nursery[which(nursery$random > 0.8),]
c (nrow(trainingData), nrow(testData))

print(table(nursery$class))

print(table(nursery$parents))

print(table(nursery$children))

library(e1071)

naive.classfier=naiveBayes(class~., data=nursery)
print(naive.classfier)


# scoring
trainingData$predict.class <- predict(naive.classfier, trainingData, type="class") 

with(trainingData, table(class, predict.class))

library(caret)
confusionMatrix(with(trainingData, table(class, predict.class)))

testData$predict.class <- predict(naive.classfier, testData, type="class") 

confusionMatrix(with(testData, table(class, predict.class)))

library(naivebayes)

new.lib=naive_bayes(class~.,usekernel=T, data=trainingData)
print(new.lib)
