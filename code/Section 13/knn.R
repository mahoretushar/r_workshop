# https://archive.ics.uci.edu/ml/machine-learning-databases/glass/glass.names

glass.data<- read.delim("glass.data.txt", sep = ",")
View(glass.data)



colnames(glass.data) <- c(
  "Id",
  "RI",
  "Na.Sodium",
  "Magnesium",
  "Aluminum",
  "Silicon",
  "Potassium",
  "Calcium",
  "Barium",
  "Iron",
  "Type.glass"
)
View(glass.data)

str(glass.data)

summary(glass.data)

sum(is.na(glass.data))

set.seed(100)
glass.data$random <- runif (nrow(glass.data), 0, 1)
trainingData <- glass.data[which(glass.data$random <= 0.8),]
testData <- glass.data[which(glass.data$random > 0.8),]
c (nrow(trainingData), nrow(testData))

normalize <- function(x){
  return ((x-min(x))/(max(x)-min(x)))
}

train.norm <- as.data.frame(lapply(trainingData[,-11], normalize))
test.norm <- as.data.frame(lapply(trainingData[,-11], normalize))
# 


str(trainingData)
output <- trainingData$Type.glass

test.output <- testData$Type.glass

library(class)


model1<- knn(train=train.norm, test=test.norm, cl=output, k=16)

k16 <- 100* sum(output == model1) /NROW(output)
k16

table(model1, trainingData[,11])

library(caret)

confusionMatrix(table(model2, trainingData[,11]))

model2<- knn(train=train.norm, test=test.norm, cl=output, k=3)

k3 <- 100* sum(output == model2) /NROW(output)
k3

model1


plot(model1)

