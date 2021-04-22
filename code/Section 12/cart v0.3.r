## loading the library

library(rattle)
library(RColorBrewer)
library(ggplot2)
library(data.table) 
library(scales) 
library(ROCR)
library(ineq)
library(tabplot)


library(xlsx)



# data source- https://archive.ics.uci.edu/ml/machine-learning-databases/breast-cancer-wisconsin/



b.cancer <- read.delim("breast-cancer-wisconsin.data.txt", sep = ",", header = FALSE)

View(b.cancer)

colnames(b.cancer) <- c(
  "code",
  "Clump.Thickness",
  "Uniformity.of.Cell.Size",
  "Uniformity.of.Cell.Shape",
  "Marginal.Adhesion",
  "Single.Epithelial.Cell.Size",
  "Bare.Nuclei",
  "Bland.Chromatin",
  "Normal.Nucleoli",
  "Mitoses",
  "Class"
)



#structure of data

str(b.cancer)

# print total number of NAs in the data

sum(is.na(b.cancer))

summary(b.cancer)

# wrong way in this case

#bank.data$default <- as.numeric(bank.data$default)

# right way
# one hot encoding
#library(modelr)

#dummy.data<- model.matrix(~default, data = bank.data)
# 
# dummy.data<- model_matrix(b.cancer,~ default-1)
# 
# bankdata.updated <- cbind(b.cancer,dummy.data)


library(plyr)
library(dplyr)



# data exploration

#ggplot(data = election.dev,aes(y=election.dev$BALANCE, x=election.dev$OCCUPATION)) +geom_boxplot(aes(col=OCCUPATION))+labs(title="Boxplot of Balance for all occupation types")


#ggplot(data = election.dev,aes(y=election.dev$BALANCE, x=election.dev$AGE_BKT)) +geom_boxplot(aes(col=AGE_BKT))+labs(title="Boxplot of Balance for age brackets types")

# g <- ggplot(election.dev, aes(election.dev$HOLDING_PERIOD))
# g + geom_bar()
# g + geom_bar(aes(weight = election.dev$HOLDING_PERIOD))
# g + geom_bar()
# 
# g <- ggplot(election.dev, aes(election.dev$AGE))
# g + geom_bar()
# g + geom_bar(aes(weight = election.dev$AGE))
# g + geom_bar()


# g <- ggplot(election.dev, aes(election.dev$TARGET))
# g + geom_bar()
# g + geom_bar(aes(weight = election.dev$TARGET))
# g + geom_bar(aes(fill = '#A4A4A4',, color="darkred"))
# 
# sctplot<-ggplot(data = election.dev, aes(x=AGE, y=BALANCE)) + geom_point()
# 
# sctplot<- sctplot + geom_smooth(method ="lm", col="red")
# 
# sctplot + geom_smooth(col="green")



set.seed(100)
b.cancer$random <- runif (nrow(b.cancer), 0, 1)
trainingData <- b.cancer [which(b.cancer$random <= 0.8),] 
testData <- b.cancer [which(b.cancer$random > 0.8),] 
c (nrow(trainingData), nrow(testData))


library(rpart)
library(rpart.plot)

#cart

?rpart.control

r.ctrl = rpart.control(minsplit=50, minbucket = 10, cp = 0.02, xval = 10) 


m1 <- rpart(formula = Class ~ ., 
            data = b.cancer, method = "class", control = r.ctrl) 
m1


#node), split, n, loss, yval, (yprob)
# node) represent the node number
# split= name of variable/attributes used for split
# n =of data elements in this node
# loss = presence of untarget elements in this stage
# yval= label assigned to a node
# yprob = displays proportion of 0 and 1 class

fancyRpartPlot(m1, uniform=TRUE, cex=0.4)

## to find how the tree performs 
printcp(m1) 
# cp indicates the classification error
#nsplit displays the split node at which classification error is encountered
# rel error column display that classification keeps going down as number of splits goes up
# xerror indicates cross validation error, if there is overfitting error will go up so we need to find the lowest value and use that 
# as cp value for pruning the ree
plotcp(m1) 

#pruning
ptree<- prune(m1, cp= 0.16,"CP") 
printcp(ptree) 
fancyRpartPlot(ptree, uniform=TRUE,  main="Pruned Classification Tree") 

# scoring
trainingData$predict.class <- predict(ptree, trainingData, type="class") 
trainingData$predict.score <- predict(ptree, trainingData, type="prob") 

# predict.score.1 columns give probability of record being 1
# predict.score.0 columns give probability of record being 0
head(trainingData) 
View(trainingData)

pred <- prediction(trainingData$predict.score[,2],(trainingData$Class)) 
perf <- performance(pred, "tpr", "fpr") 
KS <- max(attr(perf, 'y.values')[[1]]-attr(perf, 'x.values')[[1]]) 
# KS value of 40 or above good but we should target higher value
KS
auc <- performance(pred,"auc");  
auc
auc <- as.numeric(auc@y.values) 

# gini is computed on probability column

gini = ineq(trainingData$predict.score[,2], type="Gini") 
plot(perf)

#classification error
with(trainingData, table(Class, predict.class))
#Mis-Classification Error  = 31+11/ 332+31+11+181            = 0.07567568 (7.5%)
auc
KS
gini



# Holdout sample



nrow(testData)

## Scoring Holdout sample
testData$predict.class <- predict(ptree, testData, type="class")
testData$predict.score <- predict(ptree, testData, type="prob")



View(testData)




pred <- prediction(testData$predict.score[,2], testData$Class)
perf <- performance(pred, "tpr", "fpr")
KS <- max(attr(perf, 'y.values')[[1]]-attr(perf, 'x.values')[[1]])
auc <- performance(pred,"auc"); 
auc <- as.numeric(auc@y.values)

gini = ineq(testData$predict.score[,2], type="Gini")

with(testData, table(Class, predict.class))
#classification error- 13+2/71+13+2+48 =0.1119403 (11.19%)
auc
KS
gini

# library("randomForest")
# churn.rf = randomForest(churn ~ ., data = trainset, importance = T) 

