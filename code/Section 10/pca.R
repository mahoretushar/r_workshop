
# data source- https://archive.ics.uci.edu/ml/machine-learning-databases/arrhythmia/

# PCA only works with numerical column

?read.delim

ca.arry <- read.delim("arrhythmia.data.txt", header = FALSE, sep = ",")


View(ca.arry)

# impute na instead of ?
# can't impute NA directly if it is present in factors

ca.arry <- read.delim("arrhythmia.data.txt", header = FALSE, sep = ",", na.strings=c("?"," ","NA"))

View(ca.arry)

str(ca.arry)

summary(ca.arry)



pairs(ca.arry, gap = 0, pch = 21)
library(corpcor) 
corrmatrix<-cor(ca.arry)

# print the names of the column with 0

colnames(ca.arry)[colSums(is.na(ca.arry)) > 0]

ca.arry.updated <- ca.arry[, -c(11:15)]

str(ca.arry.updated)
?cor
corrmatrix<- cor(ca.arry.updated, use = "complete.obs")

ca.zero <- subset(ca.arry.updated, select=colSums(ca.arry.updated) > 0)
View(ca.zero)

corrmatrix<- cor(ca.zero, use = "complete.obs")
corrmatrix

library(corrplot)

corrplot(corrmatrix)

?princomp

pc <- princomp(ca.zero, cor = TRUE, scores = TRUE)
summary(pc)

plot(pc)

plot(pc, type="l")

attributes(pc)

pc$loadings
pc$scores

lo.model <- glm(V2 ~  pc$scores[,1]+pc$scores[,2], data=ca.zero, family=binomial("logit"))
summary(lo.model)

library(pls)
#pcr() function is similar to that for lm()
?pcr
pcr.m <- pcr(V2~pc$scores[,1]+pc$scores[,2], data = ca.zero, scale = TRUE, validation = "CV")

pcr.m2 <- pcr(V2~., data = ca.arry, scale = TRUE, validation = "CV")

summary(pcr.m)

validationplot(pcr.m)
