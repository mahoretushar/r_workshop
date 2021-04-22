# logistic regression is part of glm (generalized linear model)

# data source- https://archive.ics.uci.edu/ml/machine-learning-databases/adult/

?read.delim

income.orig <- read.delim("adult-data.txt", header = FALSE, sep = ",")

View(income.orig)

# impute na instead of ?
# can't impute NA directly if it is present in factors

income.orig <- read.delim("adult-data.txt", header = FALSE, sep = ",", na.strings=c(""," "," ?","NA"))

# name the columns
colnames(income.orig) <- c(
  "age",
  "workclass",
  "final.weight",
  "education",
  "education.num",
  "marital-status",
  "occupation",
  "relationship",
  "race",
  "sex",
  "capital.gain",
  "capital.loss",
  "hours.per.week",
  "country",
  "final.class"
)

View(income.orig)

#structure of data

str(income.orig)

# print total number of NAs in the data

sum(is.na(income.orig))

# print the columns with NAs in the data

colnames(income.orig)[colSums(is.na(income.orig)) > 0]
summary(income.orig)

#install.packages("mice")

library(mice)

# displays a table with NA

md.pattern(income.orig)

#verify number of NAs

sum(is.na(income.orig$workclass))
sum(is.na(income.orig$country))
sum(is.na(income.orig$occupation))

summary(income.orig)

#library-Hmisc, mice are good choice for handling NAs
# create 

library(forcats) 
workclass.new<- fct_explicit_na(income.orig$workclass, na_level = " None")
income.orig$workclass.new <- workclass.new


country.new<- fct_explicit_na(income.orig$country, na_level = " None")
income.orig$country.new <- country.new

occupation.new<- fct_explicit_na(income.orig$occupation, na_level = " None")
income.orig$occupation.new <- occupation.new

# dependent variable = final class

library(ggplot2)

# final weight for all occupation types
ggplot(data = income.orig,aes(y=income.orig$final.weight, x=income.orig$occupation.new)) +geom_boxplot(aes(col=occupation.new))+labs(title="Boxplot of Weights for all occupation types")

#final weight for all education types

ggplot(data = income.orig,aes(y=income.orig$final.weight, x=income.orig$education)) +geom_boxplot(aes(col=education))+labs(title="Boxplot of Weights for all education types")

#Histogram for relationship

g <- ggplot(income.orig, aes(income.orig$relationship))
g + geom_bar()
g + geom_bar(aes(weight = income.orig$relationship))
g + geom_bar()

#Histogram to represent gender distribution 

g <- ggplot(income.orig, aes(income.orig$sex))
g + geom_bar()
g + geom_bar(aes(weight = income.orig$sex))
g + geom_bar(aes(fill = '#A4A4A4',, color="darkred"))


# list=false to ensure that resultant is not in the form of a list
# replacing less than and more than 50000 with 0 and 1
# always select random values/rows for training and test datasets

library(plyr)
library(dplyr)

str(income.orig)

income.orig$final.class <- revalue(income.orig$final.class, c(" >50K"="1"))

income.orig$final.class <- revalue(income.orig$final.class, c(" <=50K"="0"))
?mutate
View(income.orig)
# create data partition- create a vector
library(caret)
set.seed(101)
# income_sampling <-   createDataPartition(income.orig$final.class, p = 0.80, list = FALSE)
# class(income_sampling)
# class(income.orig)
# 
# View(income_sampling)
# 
# income.train <- income.orig[income_sampling,]
# View(income.train)
# 
# class(income.train)
# 
# income.trainlabels <- income.orig$final.class[income_sampling]
# # then same for test dataset
# # one more way of random selection for training & test


income.orig$random <- runif (nrow(income.orig), 0, 1)
View(income.orig)
# training & test datasets
set.seed(100)
trainingData <- income.orig [which(income.orig$random <= 0.8),] 
testData <- income.orig [which(income.orig$random > 0.8),] 
c (nrow(trainingData), nrow(testData))

View(trainingData)
# when you use only 1 variable like age, you will be doing univariate logistic analysis
# we are using multiple variables to mimic real world scenario, therefore it is multivariate logistic analysis

# run logistic regression using glm function
# glm with family binomial is used to run binomial logistic regression
# binomial logistic regression is used when the outcome can have only 2 values like yes or no, true or false
# multinomial logistic regression is used when outcome can be more than 2 different classes like type a, type b, type c etc.
# lower aic indicates better model
# AIC = akaike information criterion
?glm
income.model <- glm(final.class~  sex+age+workclass+final.weight+education+occupation+country, data=trainingData, family=binomial("logit"))
str(trainingData)
trainingData$final.weight <- as.numeric(trainingData$final.weight)
trainingData$age <- as.numeric(trainingData$age)
trainingData$workclass <- as.factor(trainingData$workclass)
trainingData$education <- as.factor(trainingData$education)
trainingData$final.class <- as.numeric(trainingData$final.class)

# higher z value is good
# deviance residual should be closer to 0
# postive and higher estimate value indicate higher significance 
# Number of Fisher Scoring iterations indicates how quickly our model converged

summary(income.model) 
# calculate p value by multiplying corresponding z value
# set lower.tail to F if z value is positive

pnorm(-5.735 , lower.tail = T) * 2

# final weight, country doesn't look very significant

income.model2 <- glm(final.class~  sex+age+workclass+education+occupation, data=trainingData, family=binomial("logit"))

# higher z value is good

summary(income.model2) 

plot(income.model2)



?predict

# predict <- predict(income.model2, type = 'response')
# 
# trainingData$prediction <- predict

income.woNA <- na.omit(trainingData)

prediction <- predict(income.model, type = 'response')

income.woNA$prediction <- prediction
View(income.woNA)

# we can update prediction column to use 0 & 1 if the probability is less than 0.5 or greater than 0.5 respectively
# but we will create a new column for this purpose instead of updating prediction column
income.woNA$prediction.updated <- ifelse(prediction>0.5,1, 0)

# confusion matrix


with(income.woNA, table(final.class, prediction.updated))

# total obs
16923+1277+3497+2525

#incorrect obs
1277+3494

#classification error in percentage

4771/24222 * 100

income.test <- na.omit(testData)

test.prediction <- predict(income.model, income.test, type='response')

income.test$predicted <- test.prediction

income.test$prediction.updated <- ifelse(test.prediction>0.5,1, 0)
View(income.test)

with(income.test, table(final.class, prediction.updated))

a <- 4158+296+847+639
b <- 296+847

b/a * 100

# roc curve-Receiver operating characteristic
# it is used for evaluating performance
# tpr vs fpr
# tpr = senstivity & recall
#

library(ROCR)
ROCRpred <- prediction(test.prediction, income.test$final.class)
ROCRperf <- performance(ROCRpred, 'tpr','fpr')
plot(ROCRperf)



