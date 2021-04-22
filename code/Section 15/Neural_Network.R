
library(neuralnet)
library(data.table)
library(scales)
library(caret)


# data source- https://archive.ics.uci.edu/ml/machine-learning-databases/adult/

?read.delim

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

str(income.orig)

summary(income.orig)

occ.matrix <- model.matrix(~ occupation.new - 1, data = income.orig)
income.orig <- data.frame(income.orig, occ.matrix)

library(plyr)
library(dplyr)

str(income.orig)

income.orig$final.class <- revalue(income.orig$final.class, c(" >50K"="1"))

income.orig$final.class <- revalue(income.orig$final.class, c(" <=50K"="0"))




# training & test datasets
set.seed(100)
income.orig$random <- runif (nrow(income.orig), 0, 1)
trainingData <- income.orig [which(income.orig$random <= 0.8),] 
testData <- income.orig [which(income.orig$random > 0.8),] 
c (nrow(trainingData), nrow(testData))


?"neuralnet"

# neuralnet only works with quantitative variables, 
#you need to convert factors to binary ("dummy") variables, with the model.matrix

str(trainingData)

?neuralnet
nn1 <- neuralnet(formula = as.numeric(final.class) ~ occupation.new.Adm.clerical + occupation.new.Armed.Forces + occupation.new.Craft.repair + occupation.new.Exec.managerial
                 +occupation.new.Farming.fishing +occupation.new.Handlers.cleaners+occupation.new.Machine.op.inspct+occupation.new.Other.service
                 +occupation.new.Priv.house.serv+age , 
                 data = trainingData, 
                 hidden = c(5,2),
                 err.fct = "sse",
                 linear.output = FALSE,
                 lifesign = "full",
                 lifesign.step = 10,
                 threshold = 0.01,
                 stepmax = 2000
)

plot (nn1)

nn1$result.matrix

## Assigning the Probabilities to Dev Sample
trainingData$Prob = nn1$net.result[[1]] 
View(trainingData)

## The distribution of the estimated probabilities
quantile(trainingData$Prob, c(0,1,5,10,25,50,75,90,95,98,99,100)/100)
boxplot(trainingData$Prob)



## Rebuilding the model by Scaling the Independent Variables

str(income.orig)
## build the neural net model by scaling the variables
scaled.data <- subset(income.orig, 
            select = c(  "occupation.new.Adm.clerical" , "occupation.new.Armed.Forces" , "occupation.new.Craft.repair" , "occupation.new.Exec.managerial"
                         ,"occupation.new.Farming.fishing"
                         ,"occupation.new.Priv.house.serv","age")
)
nn.devscaled <- scale(scaled.data)
# add final class column to it
nn.devscaled <- cbind(income.orig[15],nn.devscaled)
View(nn.devscaled)
# to decide number of neurons, take square root of total variables
# err.fct is error function=loss function
# linear output = false because this is a classification problem

nn2 <- neuralnet(formula =as.numeric(final.class)~  occupation.new.Adm.clerical+occupation.new.Armed.Forces
                 +age,
                 data = nn.devscaled, 
                 hidden =c(9,3),
                 err.fct = "sse",
                 linear.output = FALSE,
                 lifesign = "full",
                 lifesign.step = 10,
                 threshold = 0.05,
                 stepmax = 2000,
                 
)

weights1 <- nn2$weights
weights1
plot(nn2)


## Assigning the Probabilities to training 
nn.devscaled$Prob2= nn2$net.result[[1]] 


## The distribution of the estimated probabilities
quantile(nn.devscaled$Prob, c(0,1,5,10,25,50,75,90,95,99,100)/100)
hist(nn.devscaled$Prob)





## Assgining 0 / 1 class based on certain threshold
nn.devscaled$Class = ifelse(nn.devscaled$Prob>0.21,1,0)
with( nn.devscaled, table(final.class, as.factor(Class)))

# classification error - 1845/14000 - 0.1317857143

## We can use the confusionMatrix function of the caret package 
##install.packages("caret")






## Other Model Performance Measures

library(ROCR)
class(nn.dev)
pred <- prediction(nn.devscaled$Prob, nn.devscaled$final.class)
perf <- performance(pred, "tpr", "fpr")
plot(perf)

KS <- max(attr(perf, 'y.values')[[1]]-attr(perf, 'x.values')[[1]])
auc <- performance(pred,"auc"); 
auc <- as.numeric(auc@y.values)

library(ineq)
gini = ineq(nn.devscaled$Prob, type="Gini")

auc
KS
gini
 



