for (v in c(1:5)) {
  print(v)
}

for (v in c(1:5)) {
  if(v <= 5)
  print(v)
  else(
    print("i m done")
  )
        
}

a <- c(1:5)

for (v in a) {
  if(v <= 5)
    print(v)
  else(
    print("i m done")
  )
  
}

b <- c(1:10)

for (v in a) {
  if(v <= 5)
    print(v)
  else(
    print("i m done")
  )
  
}

setwd("~/Great lakes")

library(corpcor)
library(GPArotation)
library(psych)
library(ggplot2)
library(ggfortify)
library(nFactors)
library(dplyr)
library(expm)
library(Hmisc)

iplbatting <- read.csv("batting_bowling_ipl_bat.csv", header = TRUE)


View(iplbatting)

for (v in iplbatting$Runs) {
    print(v)
  
}

r <- iplbatting[6,]
r <- 500

while (r!=495){
  
 
  print("this is my")
  
}

rt <- 1
while (rt < 6){
  
  print(rt)
  rt = rt+1
  
}

