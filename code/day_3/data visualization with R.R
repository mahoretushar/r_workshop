# first difference between bar plots & histograms is that there is gap between bars in barplots 
#whereras there is no gap in histogram
# both use bars but bar plot or graph is used for comparision of variables 
#whereas histograms are used for displaying frequencies
# if i need to compare male and female variables, 
#i will use bar plots and 
#if i neeed to display the numerical distribution of a quantity, 
#i will use histogram likes sales on monthly basis



setwd("E:/Machine learning with R-Akhilendra/Section 4")
Titanicdata <- read.csv("train_titanic.csv", header = TRUE)



str(Titanicdata)

library(Amelia)

missmap(Titanicdata, main="Missing values")

fbdata <- read.csv("dataset_Facebook.csv", header = TRUE, sep = ";")

#Bar charts are the most common data visualization for categorical data but also used for numerical variables
?barplot

barplot(fbdata)

str(fbdata)

barplot(fbdata$like, main = "Bar plot for likes", col = "red")
barplot(Titanicdata$Age)
hist(fbdata$like)

hist(as.numeric(Titanicdata$like))

hist(Titanicdata$Age)
View(Titanicdata)

barplot(fbdata$like, main = "Bar plot for likes", horiz=TRUE, col = "red")

barplot(fbdata$Post.Month, main = "Bar plot for likes", horiz=TRUE, col = "red")

#heat.colors(12



View(fbdata)

plot(Titanicdata$Age)

plot(fbdata$Lifetime.Post.Consumptions)

plot(fbdata$Lifetime.Post.Consumptions,xlim = c(0,1000), ylim = c(0, 5000), type = "h")
plot(fbdata$Page.total.likes)

?plot

plot(density(fbdata$Page.total.likes))
#The plot()function is a generic function. If we put two numeric variables inside this  function, 
#it produces a scatter. On the other hand, if we use one numeric variable and  another factor variable, 
#then it produces a boxplot of the numeric variable for each  unique value of the factor variable.

#type is a factor

plot(Lifetime.Post.Consumptions ~ Type, data = fbdata)

plot(Lifetime.Post.Total.Reach ~ Lifetime.Post.Total.Impressions , data = fbdata,
     main="Relationship between car Reach & Impressions",
     col= "red")



?plot
data("mtcars")

heatmap(as.matrix(mtcars),
        Rowv = NA,
        Colv = NA,
        col= heat.colors(4, alpha=1))

# dark line represent the median
# the bottom and top edges represent the first & third quartiles
#length of the box is equal to the interquartile range  (IQR, which is the difference between first and third quartiles


boxplot(fbdata$Page.total.likes)
str(fbdata)

#pair
#pairs() command makes a matrix of scatter plots, where all the variables in the specified dataset are plotted against each other. 
#The variable names, displayed in the diagonal running across from the top-left corner to the bottom-right corner, 
#are the key to reading the graph. For example, the scatter plot in the  first row and second column shows the relationship 
#between variable on the y axis  and on the x axis.

head(mtcars)
pairs(mtcars)
pairs(mtcars[,2:6])



# create multiple graphs
# c(2,3) mean 2 rows and 3 columns 
# this is particularly useful if you want to show some kind of comparsion like price movement of different stocks in a time
# or summary of a dataset with multiple graphs

par(mfrow=c(4,8)) 



# install rcolorbrewer

library(RColorBrewer)
display.brewer.all()

infy <- read.csv("infy.csv", header = TRUE)
head(infy)
str(infy)

tcs <- read.csv("tcs.csv", header = TRUE)
head(tcs)
wipro <- read.csv("wipro.csv", header = TRUE)


plot(Average.Price~Open.Price,data=infy,type="l",main="Percentage change in GDP",ylab="")

mtext(side=4,at=infy$Open.Price[infy$Open.Price],text="Open Price")

lines(infy$Average.Price~infy$High.Price,col=pal[2],lwd=2)

mtext(side=4,at=infy$High.Price[length(infy$High.Price)],text="High price", col=pal[2],line=0.3,las=2)

lines(infy$Average.Price~infy$Low.Price,col=pal[3],lwd=2)
mtext(side=4,at=infy$Low.Price[length(infy$Low.Price)],text="Low price", col=pal[3],line=0.3,las=2)



# map- not very common usage but good to know
library(maps)

map()
?map
map("france")
map("usa", fill=TRUE, col=heat.colors(256))

#library(rgdal)
#library(RgoogleMaps)

library(ggplot2)
# ggplot2 comes with commands- qplot & ggplot
#geom_point(): This will create a scatter plot 
#geom_line(): This will create a line chart 
#geom_bar(): This will create a bar chart 
#geom_boxplot(): This will create a box plot 
#geom_text(): This will write certain text inside the plot area

?qplot

data("iris")

qplot(Sepal.Length, Sepal.Width, data=iris, colour = Species) 

library(xlsx)

lung= read.xlsx("LungCap_Dataset.xls", sheetIndex = 1, header = TRUE)


qplot(lung$Age..years.,lung$Height.inches.,data = lung,shape=as.factor(Gender))
str(lung)

ggplot(data = lung, aes(x=Age..years., y=Height.inches.)) + geom_bar(stat = "identity",position = "dodge",colour= "blue", fill = "gray")


sctplot<-ggplot(data = lung, aes(x=Age..years., y=Height.inches.)) + geom_point()

sctplot<- sctplot + geom_smooth(method ="lm", col="red")

sctplot + geom_smooth(col="green")

str(lung)
?ggplot

ggplot(data= lung, aes(x=Smoke, y=LungCap.cc., fill=Age..years.)) + geom_bar(stat="identity",position="dodge")

ggplot(data= lung, aes(x=Smoke, y=LungCap.cc.)) + geom_bar(stat="identity",position="dodge")

ggplot(data= lung, aes(x=Smoke, y=LungCap.cc., fill=Age..years.)) + geom_bar(stat="identity",position="dodge")+coord_flip()

ggplot(data=lung,aes(x=Age..years.))+geom_density()

ggplot(data=lung,aes(y=LungCap.cc.,x=Gender))+geom_boxplot() 

CTDF.dev <- read.csv("DEV_SAMPLE.csv", header = TRUE)
head(CTDF.dev)
str(CTDF.dev)
ggplot(data = CTDF.dev,aes(y=CTDF.dev$Balance, x=CTDF.dev$Occupation)) +geom_boxplot(aes(col=Occupation))+labs(title="Boxplot of Balance for all occupation types")

data("iris")
head(iris)

library(lattice)
xyplot(Sepal.Length~Sepal.Width, data=iris, groups=Species)

# first 3 variables are numeric and Species is factor, it is grouping based on Species

barchart(Sepal.Length+Sepal.Width+Petal.Length~Species,data=iris)

barchart(Sepal.Length+Sepal.Width+Petal.Length~Species,data=iris, auto.key=list(column=3))

barchart(Sepal.Length+Sepal.Width+Petal.Length~Species,data=iris, stack=TRUE)

Titanicdata <- read.csv("train_titanic.csv", header = TRUE)

View(Titanicdata)
str(Titanicdata)

barchart(Age~Survived|Sex,data=Titanicdata)
?barchart

histogram(~Age|Sex,data=Titanicdata)

histogram(~Age|Sex+Survived,data=Titanicdata)

densityplot(~Age|Sex,data=Titanicdata)

bwplot(~Age|Sex+Survived,data=Titanicdata)

bwplot(~Age,data=Titanicdata)



library(scatterplot3d)
scatterplot3d(x=iris$Sepal.Length,y=iris$Sepal.Width,z=iris$Species)



?scatterplot3d

scatterplot3d(x=iris$Sepal.Length,y=iris$Sepal.Width,z=iris$Species, pch = 16)

scatterplot3d(x=iris$Sepal.Length,y=iris$Sepal.Width,z=iris$Species, pch = 16, highlight.3d=TRUE,col.axis="blue",
              col.grid="lightblue")
