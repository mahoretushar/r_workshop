
# source-https://archive.ics.uci.edu/ml/machine-learning-databases/heart-disease/

heart.dis <- read.delim("processed.cleveland.data.txt", sep = ",")
View(heart.dis)

colnames(heart.dis) <- c(
  "age",
  "sex",
  "cp",
  "rbp",
  "chol",
  "fbs",
  "recg",
  "max.hr",
  "angina",
  "oldpeak",
  "slope",
  "major.vessels",
  "thal",
  "output"
)
View(heart.dis)

str(heart.dis)

summary(heart.dis)

sum(is.na(heart.dis))

set.seed(100)
heart.dis$random <- runif (nrow(heart.dis), 0, 1)
trainingData <- heart.dis [which(heart.dis$random <= 0.8),] 
testData <- heart.dis [which(heart.dis$random > 0.8),] 
c (nrow(trainingData), nrow(testData))

library(randomForest)

#ntree = number of forest
#mtry = number of variables to be used for each forest/node
# nodesize = similar to minbucket(terminal node)
# importance= which variable is more important than others


random.heart <- randomForest(as.factor(output) ~ ., data = trainingData, 
                   ntree=50, mtry = 3, nodesize = 10,
                   importance=TRUE)

# OOB = out of bag 
# we have 50 trees which mean that there are 50 models. All obs won't be there in each model
# missing values are called out of bag
# out of bag values are used as testing set by model
# model will use these OOBs to predict class of these obs. 
# OOB is the mean prediction error on each training sample using out of bag value
print(random.heart)

# plot to tell us optimum number of trees

plot(random.heart, main="")
legend("topright", c("OOB", "1", "2","3", "4"), text.col=1:6, lty=1:3, col=1:3)
title(main="Error Rates Random Forest")

# same information in table format
random.heart$err.rate

## List the importance of the variables.
importantvariables <- round(randomForest::importance(random.heart), 2)
importantvariables[order(importantvariables[,3], decreasing=TRUE),]

# variable with highest meandecreasegini is the best variable-max.hr
?tuneRF
## Tuning Random Forest-used for finding optimum value of mtry

?tuneRF
tune.forest <- tuneRF(x = trainingData, 
              y=as.factor(trainingData$output),
              mtryStart = 3, 
              ntreeTry=50, 
              trace=TRUE, 
              plot = TRUE,
              doBest = TRUE,
              improve = TRUE,
              nodesize = 10, 
              importance=TRUE)

tune.forest$importance



#predict
trainingData$predict.class <- predict(tune.forest, trainingData, type="class")
trainingData$predict.score <- predict(tune.forest, trainingData, type="prob")

View(trainingData)



sum(trainingData$output) / nrow(trainingData)


# KS,AUC, gini cannot be calculated in this case because output variable is not binary

## Classification Error
with(trainingData, table(output, predict.class))

library(class)


?knn
# add predict class for test data set 
model1<- knn(train=trainingData, test=trainingData, cl=trainingData[,14], k=16)
model1
