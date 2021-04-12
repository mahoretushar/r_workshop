# Data Types
#
#Data can be of different types. Commonly
#
#vector
#matrix
#data.frame

library(xlsx)

a <- 20
class(a)
?read.table
?read.csv
golf <- read.csv('DEV_SAMPLE.csv')
View(golf)

?head
head(golf)
class(golf) 
?class

new.matrix <- as.matrix(golf)
class(new.matrix)
new.matrix

new.vector <- as.vector(golf$Balance)
class(new.vector)

?str()
str(golf)

#Numeric: refers to any number or numeric value
#Ex: 1.2, 4.5, 26 it even includes decimals
a1 <- 25
class(a1)

#Integer: refers to any number without a fractional part
#Ex: 1, 2, 3, etc.
a2 <- as.integer(a1)
class(a2)

#Character: refers to textual data
#Ex: learning, education
a3 <- "Batman"
a4 <- 'Bruce Wayen'
class(a4)

#Logical: refers to any values which is either TRUE or FALSE
#Ex: If x=10, y=20 then x>y is FALSE
x <- TRUE
class(x)

#Factor: refers to data in categories
#Ex: city, gender

#List: ordered collection, can be created with function list()

o.list <- list(fname="Bruce", lname="Wayen", age="50")
?list
class(o.list)
o.list
