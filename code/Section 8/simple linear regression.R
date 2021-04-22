setwd("~/machine learning with R")

library(car)
library(ggplot2)
library(tabplot)
library(corrplot)
library(scatterplot3d)

library(dplyr)

library(devtools)
install_github("mtennekes/tabplot")

# source-https://archive.ics.uci.edu/ml/machine-learning-databases/auto-mpg/

?read.delim

auto.mpg <- read.delim("auto-mpg.data.txt", header = FALSE,sep = "")
View(auto.mpg)

colnames(auto.mpg) <- c("mpg","cylinders","displacement","horsepower","weight","acceleration","model year","origin","car name")
View(auto.mpg)

str(auto.mpg)

auto.mpg$`car name` <- as.factor(auto.mpg$`car name`)
auto.mpg$horsepower <- as.factor(auto.mpg$horsepower)

summary(auto.mpg)

# area of interest = mpg is influenced displacement of the car
# area of interest = dependent variable
# displacement = independent variable

hist(auto.mpg$mpg)

hist(auto.mpg$displacement)

tableplot(auto.mpg[,-9])

pairs(auto.mpg)

ggplot(data = auto.mpg,aes(y=auto.mpg$weight, x=auto.mpg$mpg)) +geom_boxplot(aes(col=mpg))+labs(title="Boxplot of weight & mpg")

plot(auto.mpg$weight, auto.mpg$mpg)
plot(auto.mpg$mpg,auto.mpg$weight)



mod <- lm(formula = mpg ~ weight, data = auto.mpg)
summary(mod)
# value of r-squared should be close to 1 to represent good variance
# we have got over 0.6 so it is good but not good enough

lmplot<-ggplot(data = auto.mpg, aes(x=weight, y=mpg)) + geom_point()

lmplot<- lmplot + geom_smooth(method ="lm", col="red")

lmplot + geom_smooth()

 # visualize residuals & fitted line
?plot

plot(mod, which = 1, pch=16)

# multiple linear regression

plot(auto.mpg, col="blue")

mod1 <- lm(formula = mpg ~ weight + displacement + acceleration, data = auto.mpg)
summary(mod1)

new.auto <- auto.mpg[,1:5]
head(new.auto)
str(new.auto)

new.auto$horsepower <- as.numeric(new.auto$horsepower)
new.auto$cylinders <- as.numeric(new.auto$cylinders)
str(new.auto)

cor.plot <- cor(as.matrix(new.auto))
corrplot(cor.plot)
# not comfortable with colors & need numbers, use method = "number"

corrplot(cor.plot, method = "number")

#mod.multi <- lm(formula = cylinders ~ displacement + weight, data = new.auto)

summary(mod)

plot(mod1, pch=16, which=1)



new.3dplot <- select(new.auto,cylinders,displacement,weight)
head(new.3dplot)

scatterplot3d(new.3dplot)


