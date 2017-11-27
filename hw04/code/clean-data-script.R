library(readr)
library(dplyr)
source('functions.R')
data <- read.csv('../data/rawdata/rawscores.csv', stringsAsFactors = FALSE)
sink('../output/summary-rawscores.txt')
str(data)
print_stats(apply(data, 2, summary_stats))
sink()

for (i in 1:nrow(data)) {
  for (j in 1:ncol(data)) {
    if (is.na(data[i,j])) {
      data[i,j] <- 0
    }
  }
}

data$QZ1 <- rescale100(data$QZ1, xmin = 0, xmax = 12)
data$QZ2 <- rescale100(data$QZ2, xmin = 0, xmax = 18)
data$QZ3 <- rescale100(data$QZ3, xmin = 0, xmax = 20)
data$QZ5 <- rescale100(data$QZ4, xmin = 0, xmax = 20)
data$Test1 <- rescale100(data$EX1, xmin = 0, xmax = 80)
data$Test2 <- rescale100(data$EX2, xmin = 0, xmax = 90)
data$Homework <- apply(data[1:9], 1, score_homework, drop = TRUE)
data$Quiz <- apply(data[11:14], 1, score_quiz, drop = TRUE)
data$Lab <- apply(data[10],1, score_lab)
data$Overall <- (0.1 * data$Lab) + (0.3 * data$Homework) + (0.15 * data$Quiz) + (0.2 * data$Test1) + (0.25 * data$Test2)

score_grade <- function(score) {
  if (score >= 95) {
    return("A+")
  }
  else if (score >= 90 ) {
    return("A")
  }
  else if (score >= 88) {
    return("A-")
  }
  else if (score >= 86) {
    return("B+")
  }
  else if (score >= 82) {
    return("B")
  }
  else if (score >= 79.5) {
    return("B-")
  }
  else if (score >= 77.5) {
    return("C+")
  }
  else if (score >= 70) {
    return("C")
  }
  else if (score >= 60) {
    return("C-")
  }
  else if (score >= 50) {
    return("D")
  }
  else {
    return("F")
  }
}

data$Grade <- apply(data["Overall"], 1, score_grade)


for (i in 18:23){
  x <- paste('../output', colnames(data[i]), sep = '/')
  z <- paste(x, 'stats.txt', sep = '-')
  sink(z)
  print_stats(summary_stats(data[[i]]))
  sink()
}


data$Grade = factor(data$Grade,
                         levels = c('A+', 'A', 'A-',
                                    'B+', 'B', 'B-',
                                    'C+', 'C', 'C-',
                                    'D', 'F'))

sink('../output/summary-cleanscores.txt')
str(data)
sink()


write.csv(data, file = "../data/cleandata/cleanscores.csv", row.names = FALSE)