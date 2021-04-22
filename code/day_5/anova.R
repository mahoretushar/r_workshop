library(dplyr)
library(ggplot2)
library(readxl)
library(psych)
library(car)
library(foreign)
library(nlme)
library(onewaytests)
library(tabplot)
library(MASS)
library(rcompanion)
library(WRS2)

library(devtools)


plxsell <- read.csv("PL_X_SELL.csv")
class(plxsell)

View(plxsell)
str(plxsell)
summary(plxsell)

#using tableplot from tabplot to visualize entire dataset

tableplot(plxsell)


#visualization with boxplot


ggplot(data = plxsell,aes(y=plxsell$Balance, x=plxsell$Occupation)) +geom_boxplot(aes(col=Occupation))+labs(title="Boxplot of Balance for all occupation types")


# Normality Test
#select subset with 5000 rows

fivethd <- plxsell[1:5000,]

#fivethd$Occupation<-factor(fivethd$Occupation,labels = c("PROF","SAL","SELF-EMP","SENP"))

?cat
cat("Normality p-values by Factor place: ")
for(i in unique(factor(fivethd$Occupation))){
  cat(shapiro.test(fivethd[fivethd$Occupation==i, ]$Balance)$p.value," ")
}

#test for normality- normality assumption is not violated
# null hypothesis, balance is not influenced by occupation
#alternative hypothesis, balance is influenced by occupation
# p value is less than 0.05, therefore we reject null hypothesis


# Test of homogenity
# Levene's & bartlett tests are used to test if samples have equal variances. 
#Equal variances across samples is called homogeneity of variance

leveneTest(plxsell$Balance ~ plxsell$Occupation, data = plxsell)


bartlett.test(plxsell$Balance ~ plxsell$Occupation)
# ANOVA Model

anova_Model <- aov(plxsell$Balance ~ plxsell$Occupation, data = plxsell)

summary(anova_Model)
# Tukey Test is a post-hoc test based 
#ANOVA test can tell us if the output is significant, it won't tell us where is the difference

#we  use Tukey's HSD to find out which specific groups's means are different. 

tukey_HSD <- TukeyHSD(anova_Model)

tukey_HSD

plot(tukey_HSD)

# Two way anova

#plxsell$Occupation<-factor(plxsell$Occupation,labels = c("PROF","SAL","SELF-EMP","SENP"))
#plxsell$Gender<-factor(plxsell$Gender,labels = c("Male","Female","Org"))


?tapply
tapply(plxsell$Balance,list(plxsell$Occupation,plxsell$Gender), mean)

tapply(plxsell$Balance,list(plxsell$Occupation,plxsell$Gender), sd)

#interaction plot displays the levels of one variable on the X axis and 
#has a separate line for the means of each level of the other variable. 
#The Y axis is the dependent variable. 
# itshows that the effect of variable is different for different variables

# interaction plot
interaction.plot(plxsell$Gender,plxsell$Occupation,plxsell$Balance)

#barlett test
leveneTest(plxsell$Balance ~ plxsell$Occupation*plxsell$Gender)

anova2<-aov(Balance~Occupation+Gender+Occupation:Gender,data = plxsell)
summary(anova2)

tukey_HSD2 <- TukeyHSD(anova2)

tukey_HSD

plot(tukey_HSD2)

