# you can use <- or = to create variables or objects in R
# int
a1 <- 100
a12 = 101

# floating number
a2 <- 100.5
class(a2)
new.a2 <- as.integer(a2)
class(new.a2)

# string or character

a3 <- "hello"

# if you use quotes, it becomes string even if you include number in it
a4 <- "100"

# To print, either write the variable or use print command

a1
print("Hi Hello")
a2

# when using print with variable, you don't need to use quotes
print(a3)
print(a4)

# when using print with numbers, you don't need to use quotes

print(4)

# when using print with string, you need to use quotes

print("this is a string")

# all the variables are saved as objects & displayed in right hand top section
# use ? before any function to get more information on that.
# you won't be creating these simple variables though
# you will be creating different data types in R for machine learning. There are 4 types of atomic vector 
# These data types are;
#Vectors
#Matrices
#Data Frames
#Lists
#Arrays
#Factors


# let's start with vector 
# use C() function to create vectors
# C() stand for concatenate 


# create vectors

?c
v1 <- c(1,2,3)
v2 <- c(4,5,6)

# you can directly perform calculations in R on these vectors 
 
c1 <- v1 * v2
c1
c2 <- v1 + v2
c2

# logical vector 
b = c(TRUE,  FALSE, TRUE )


#list

x = list( v1, c1, v2, 100)
x
class(x)


#Let's create a list containing a vector, a matrix, and a list.

new.list <- list(c("Sachin","Saurav","Rahul"), matrix(c(28000,25000,220000,100,500,800), nrow = 2), list("x",12.3))
print(new.list)

#manipulation
#Give names to the elements in the list.
 
names(new.list) <- c("Names", "Numbers", "Random")
?name
print(new.list)

#Access the first element of the list.
print(new.list[1])
print(new.list[3])

#Add an element at the end of the list.
new.list[4] <- "New Player"
print(new.list[4])

#Remove the element.
new.list[3]  <- NULL 

# Print the 4th Element.
print(new.list[3])

#Update the 3rd Element.
new.list[3] <- "updated element"
print(new.list[3])

#How to Merge Lists in R Programming language?
#Merge the two lists.

two.list <- c(x,new.list) 
print(two.list)

# R Predefined Lists
# Lists for letters and month names are predefined:
# letters 
# 
# A matrix is a two-dimensional vector (fixed size, all cell types the same).
# 
# array is a vector with one or more dimensions.  
#An array with two dimensions is same as a matrix. 
#An array with three or more dimensions is an n-dimensional array.
# 
# A data frame is called a table in most languages. Each column holds the same type, and the columns can have header names.
# 
# Arrays
# Create two vectors of different lengths.
v1.new <- c(2,9,3)
v2.new <- c(10,11,12,13)

# create a array with these vectors
new.arr <- array(c(v1.new,v2.new), dim = c(3,3,4))
print(new.arr)

#naming columns
income.orig <- read.delim("adult-data.txt", header = FALSE, sep = ",", na.strings=c(""," "," ?","NA"))

?colnames
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

new.vector <- income.orig[120:3000,5]
View(new.vector)
income.orig$education.num <- NULL
View(income.orig)

income.orig$edu.new <- 125

str(income.orig)

income.orig$edu.new <- as.integer(income.orig$edu.new)
