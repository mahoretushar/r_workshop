require(dplyr)
library()

fb <- read.csv("dataset_Facebook.csv", header = TRUE, sep = ";")

a <- fb$Post.Hour
a

v <- fb[,2]
View(v)

u <- fb[1:10,2]
View(u)

z <- fb$Page.total.likes

a = mean(fb$Lifetime.Post.Total.Reach + fb$Page.total.likes + 
           fb$Lifetime.Post.Total.Impressions)
a

b = with(fb, mean(Lifetime.Post.Total.Reach + Page.total.likes + 
                    Lifetime.Post.Total.Impressions))

b
View(fb)
str(fb)

library(dplyr)
?select
Select<- select(fb, Category:Paid)
View(Select)

str(fb)
Filter <- filter(fb, Lifetime.Post.Total.Reach > 3000)
?arrange
arranged <- arrange(Filter,Lifetime.Post.Total.Reach)

View(arranged)

?mutate

View(arranged)

str(arranged)

arranged %>% mutate(
  comment.square = comment ^ 2,
  likeo = like + 2
)

View(arranged)

arranged <- arranged %>% mutate(
  comment.square = comment ^ 2,
  likeo = like + 2,
  )



str(fb)

#dataframe$columnname = as.numeric/factor(dataframe$columnname)

fb$comment <- as.numeric(fb$comment)
fb$Category <- as.factor(fb$Category)



View(fb)
fb <- read.csv("dataset_Facebook.csv", header = TRUE, sep = ";")
View(fb)

# with funciton 
a = mean(fb$Lifetime.Post.Total.Reach + fb$Page.total.likes + fb$Lifetime.Post.Total.Impressions)
a
# using with(), we can clean this up:
b = with(fb, mean(Lifetime.Post.Total.Reach + Page.total.likes + Lifetime.Post.Total.Impressions))
b



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

library(xlsx)
LA2017_candidate <- read.xlsx("LA 2017.xls", sheetIndex = 1)

LA2017_candidatebye <- read.xlsx("LA 2017.xls", sheetIndex = 3)

?merge
plxsell <- merge(LA2017_candidate, LA2017_candidatebye, all.x = TRUE, all.y = TRUE)

