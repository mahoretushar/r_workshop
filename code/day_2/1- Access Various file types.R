#1.	Reading CSV files with R
read.csv()
fb<- read.csv("dataset_Facebook.csv", header = TRUE, sep = ";")

View(fb)

?read.csv

read.csv(file, header = TRUE, sep = ",", quote = "\"",
         dec = ".", fill = TRUE, comment.char = "", ...)


#read.csv2 is used in countries that use a comma as decimal point and a semicolon as field separator.
read.csv2()
#additional function- for reading csv and other formats like copy paste
#data.table package
#separator is automatically recognized
fread()
#2.	Reading xls files with R
library(xlsx)
?read.xlsx()

fbx <- read.xlsx("LungCap_Dataset.xls", sheetIndex = 1)
#3.	Reading txt files with R
?read.delim()
read.delim()
#read.table is similar to .csv and can be used to read csv files
read.table()
#4.	read xml
library(XML)
?xmlParse()
# read json
library(rjson)
?fromJSON

#foreign package to read octave, SAS, SPSS and other formats
library(foreign)

