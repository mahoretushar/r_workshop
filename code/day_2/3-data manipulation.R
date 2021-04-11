setwd("~/great lakes/Facebook_metrics")



fb <- read.csv("dataset_Facebook.csv", header = TRUE)

View(fb)

?read.csv

fb <- read.csv("dataset_Facebook.csv", header = TRUE, sep = ";")

require(dplyr)

Select<- head(select(fb, Category:Paid))
View(Select)

View(fb)

str(fb)

fb$Post.Hour

v <- fb[,2]
View(v)

u <- fb[1:10,2]
View(u)

str(fb)

#dataframe$columnname = as.numeric/factor(dataframe$columnname)

fb$comment <- as.numeric(fb$comment)

# merge

authors <- data.frame(
  ## I(*) : use character columns of names to get sensible sort order
  surname = I(c("Tukey", "Venables", "Tierney", "Ripley", "McNeil")),
  nationality = c("US", "Australia", "US", "UK", "Australia"),
  deceased = c("yes", rep("no", 4)))
authorN <- within(authors, { name <- surname; rm(surname) })
books <- data.frame(
  name = I(c("Tukey", "Venables", "Tierney",
             "Ripley", "Ripley", "McNeil", "R Core")),
  title = c("Exploratory Data Analysis",
            "Modern Applied Statistics ...",
            "LISP-STAT",
            "Spatial Statistics", "Stochastic Simulation",
            "Interactive Data Analysis",
            "An Introduction to R"),
  other.author = c(NA, "Ripley", NA, NA, NA, NA,
                   "Venables & Smith"))


m1 <- merge(authors, books, by.x = "surname", by.y = "name")
m2 <- merge(books, authors, by.x = "name", by.y = "surname")
?merge

View(fb)
fb <- read.csv("dataset_Facebook.csv", header = TRUE, sep = ";")
View(fb)

# with funciton 
a = mean(fb$Lifetime.Post.Total.Reach + fb$Page.total.likes + fb$Lifetime.Post.Total.Impressions)
a
# using with(), we can clean this up:
b = with(fb, mean(Lifetime.Post.Total.Reach + Page.total.likes + Lifetime.Post.Total.Impressions))
b

library(dplyr)

?subset

reach <- subset(fb,select=c(Lifetime.Post.Total.Reach,Page.total.likes))
View(reach)

str(fb)
?select
reach1 <- select(fb,Lifetime.Post.reach.by.people.who.like.your.Page,comment  )
View(reach1)
#ends_with() = Select columns that end with a character string
#contains() = Select columns that contain a character string
#matches() = Select columns that match a regular expression
#one_of() = Select columns names that are from a group of names

?filter

reach3 <- filter(fb, Category == 2)
View(reach3)

reach4 <- filter(fb, Category == 2, Post.Month == 12)
View(reach4)

?arrange
reach5 <- arrange(fb,Post.Month)
View(reach5)

?rename

fb <- rename(fb,  month = Post.Month)
View(fb)