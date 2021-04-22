# source- https://archive.ics.uci.edu/ml/machine-learning-databases/water-treatment/


water <- read.delim("water-treatment.data.txt", header=FALSE, sep = ",")

water <- read.delim("water-treatment.data.txt", header=FALSE, sep = ",",na.strings=c("?"," ","NA"))
View(water)

colnames(water) <- c(
  "Q-E",
  "ZN-E",      
  "PH-E",     
 "DBO-E",    
  "DQO-E",     
 "SS-E",    
 "SSV-E",     
  "SED-E",     
  "COND-E",  
  "PH-P",     
 "DBO-P",    
  "SS-P",   
  "SSV-P",      
  "SED-P",   
  "COND-P",    
  "PH-D",     
  "DBO-D",    
  "DQO-D",   
  "SS-D",       
  "SSV-D",    
  "SED-D",      
  "COND-D",  
  "PH-S",     
  "DBO-S",    
  "DQO-S",     
  "SS-S",     
  "SSV-S",     
  "SED-S",   
  "COND-S",     
  "RD-DBO-P",  
  "RD-SS-P",    
  "RD-SED-P",   
  "RD-DBO-S",   
  "RD-DQO-S",   
  "RD-DBO-G",
  "RD-DQO-G",   
  "RD-SS-G",    
  "RD-SED-G",
  "percent"
)

# print total number of NAs in the data

sum(is.na(water))

# print the columns with NAs in the data

colnames(water)[colSums(is.na(water)) > 0]

str(water)

library(Amelia)

missmap(water)

water[is.na(water)] <- 50
## scale func.watertion standardizes the values






scaled.water <- scale(water)

scaled.water <- scale(water[,-1])

View(scaled.water)


# Identifying the optimal number of clusters


library(NbClust)
?NbClust

set.seed(100)
nc.water <- NbClust(water[,-1], distance = "euclidean", method="kmeans")
table(nc.water$Best.n[1,])

barplot(table(nc.water$Best.n[1,]),
        xlab="Numer of Clusters", ylab="Number of Criteria",
        main="Number of Clusters Chosen by 26 Criteria")


?kmeans
kwater = kmeans(x=scaled.water, centers = 3, nstart = 10)
kwater

## plotting the clusters
##install.packages("fpc")
library(fpc)
plotcluster(scaled.water, kwater$cluster)


library(cluster)
?clusplot
clusplot(scaled.water, kwater$cluster, 
         color=TRUE, shade=TRUE, labels=2, lines=1)

#add a new column Cluster and assign values of clusters to individual data points
water$Clusters <- kwater$cluster
View(water)
aggr = aggregate(water[,-1],list(water$Clusters),mean)
profile.updated <- data.frame( Cluster=aggr[,1],
                            Freq=as.vector(table(water$Clusters)),
                            aggr[,-1])

View(profile.updated)

