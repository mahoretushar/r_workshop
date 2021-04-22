setwd("E:/Machine learning with R-Akhilendra/Section 11")

# source-https://archive.ics.uci.edu/ml/machine-learning-databases/heart-disease/

heart.dis <- read.delim("processed.cleveland.data.txt", sep = ",")
View(heart.dis)

colnames(heart.dis) <- c(
  "age",
  "sex",
  "cp",
  "rbp",
  "chol",
  "fbs",
  "recg",
  "max hr",
  "angina",
  "oldpeak",
  "slope",
  "# of major vessels",
  "thal",
  "output"
)
View(heart.dis)

str(heart.dis)
