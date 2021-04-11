#setwd("")
#https://www.kaggle.com/c/titanic/data

titanicd <- read.csv("train_titanic.csv")

View(titanicd)

#in order to treat the blank string as NA, one can specify that na.strings equals either "NA" or an empty string

titanicdna <- read.csv("train_titanic.csv", na.strings = c("NA", ""))

View(titanicdna)
str(titanicdna)

summary(titanicdna)

#The is.na function is used to denote which index of the attribute contains the NA value. 
#Here, we apply it to the Age attribute first:

is.na(titanicdna$Age)


# The is.na function indicates the missing value of the Age attribute. 
#To get a general number of how many missing values there are, you can perform a sum to calculate this

sum(is.na(titanicdna$Age))

str(titanicdna)

177/891

# total percentage of missing values


#To calculate the percentage of missing values, 
#one method adopted is to count the number of missing values against nonmissing values: 

sum(is.na(titanicdna$Age) == TRUE) /  length(titanicdna$Age)

summary(titanicdna)

#To get a percentage of the missing value of the attributes, 
#you can use sapply to calculate the percentage of all the attributes:
?sapply

# stop this video and write similar code for other variables from line # 19 to 37.
# na.rm is used to ignore the NA and otherwise, it will throw NA as result instead of mean
# na.omit() from dplyr is useful when you want to drop NA values
mnAge <- mean(titanicdna$Age, na.rm = TRUE)
mnAge
View(titanicdna)

?mutate

Ageupdated <- mutate(titanicdna,Ageupdated = ifelse(is.na(Age), mnAge,Age))

View(Ageupdated)

View(titanicdna)

sum(is.na(titanicdna$Embarked))

# C = Cherbourg, Q = Queenstown, S = Southampton

Embarkedupdated <- mutate(titanicdna,Embarkedupdated = ifelse(is.na(Embarked), "S",Embarked))

sum(is.na(titanicdna$Embarkedupdated))
