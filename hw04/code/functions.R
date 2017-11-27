
#====================================================
# Title: Remove Missing
# Description: Function that takes in a input vector and returns the input vector without the missing values
# Input: Some vector
# Output: Input Vector without the missing values
#====================================================

remove_missing <- function(vec) { 
  index <- 1
  for (i in vec) {
    if (is.na(i)) {
      vec <- vec[-index]
    } else {
      index = index + 1
    }
  }
  vec
}

#====================================================
# Title: Get Minimum
# Description: Takes in a numeric vector and returns the minimum 
# Input: Some numeric vector
# Output: Minimum value of the numeric vector
#====================================================

get_minimum <- function(vec, na.rm = TRUE) {
  if (na.rm == TRUE) {
    vec = remove_missing(vec)
  }
  return(sort(vec)[1])
}

#====================================================
# Title: Get Maximum
# Description: Takes in a numeric vector and returns the maximum
# Input: Some numeric vector
# Output: Maximum value of the numeric vector
#====================================================

get_maximum <- function(vec, na.rm = TRUE) {
  if (na.rm == TRUE) {
    vec = remove_missing(vec)
  }
  return(sort(vec, decreasing = TRUE)[1])
}

#====================================================
# Title: Get Range
# Description: Returns the range of the numeric vector
# Input: Some numeric vector
# Output: Difference between the maximum and minimum value
#====================================================

get_range <- function(vec, na.rm = TRUE) {
  if (na.rm == TRUE) {
    vec = remove_missing(vec)
  }
  return(get_maximum(vec) - get_minimum(vec))
}


#====================================================
# Title: Get Median 
# Description: Function that returns the median value of a numeric vector
# Input: Some numeric vector
# Output: Median Value of the Numeric Value
#====================================================

get_median <- function(vec, na.rm = TRUE) {
  if (na.rm == TRUE) {
    vec <- remove_missing(vec)
  }
  size <- length(vec)
  if (size %% 2 == 0) {
    vec <- sort(vec)
    return((vec[size / 2] + vec[(size / 2) + 1])/2)
  } else {
    return(vec[size / 2 + 0.5])
  }
}

#====================================================
# Title: Get Average
# Description: Returns the average of all values in the numeric vector
# Input: Numeric Vector
# Output: Average of all values in the numeric vector
#====================================================

get_average <- function(vec, na.rm = TRUE) {

  if (na.rm == TRUE) {
    vec <- remove_missing(vec)
  }
  counter <- 0
  sum <- 0
  for (i in vec) {
    if (!is.na(i)) {
      counter = counter + 1
      sum = sum + i
    }
  }
  return(sum / counter)
}

#====================================================
# Title: Get Standard Deviation
# Description: Returns the Standard Deviation of Numeric Vector
# Input: Some numeric vector
# Output: Standard Deviation of Numeric Vector
#====================================================

get_stdev <- function(vec, na.rm = TRUE) {
  if (na.rm == TRUE) {
    vec <- remove_missing(vec)
  }
  ave = get_average(vec)
  sum = 0
  for (i in vec) {
    if (!is.na(i)) {
      sum = sum + ((i - ave) ^ 2)
    }
  }
  return (sqrt((1 / ((length(vec) - 1))) * sum))
}
#====================================================
# Title: First Quartile
# Description: Computes the first quartile of the input vector 
# Input: Some numeric vector
# Output: First quartile of numeric vector
#====================================================

get_quartile1 <- function(vec, na.rm = TRUE) {
  if (na.rm == TRUE) {
    vec <- remove_missing(vec)
  }
  vec2 <- remove_missing(vec)
  return (quantile(vec2)[[2]])
}

#====================================================
# Title: Third Quartile
# Description: Computes the first quartile of the input vector 
# Input: Some numeric vector
# Output: Third quartile of numeric vector
#====================================================

get_quartile3 <- function(vec, na.rm = TRUE) {
  if (na.rm == TRUE) {
    vec <- remove_missing(vec)
  }
  vec2 <- remove_missing(vec)
  return (quantile(vec2)[[4]])
}

#====================================================
# Title: Count Missing
# Description: Counts the numbr of missing values
# Input: Some numeric vector
# Output: Returns the number of the missing values
#====================================================

count_missing <- function(vec) { 
  count = 0
  for (i in 1:length(vec)) {
    if (is.na(vec[i])) {
      count = count + 1
    }
  }
  return(count)
}

#====================================================
# Title: Stat Summary
# Description: Counts the numbr of missing values
# Input: Some numeric vector
# Output: Returns the number of the missing values
#====================================================


summary_stats <- function(vec) {
  list(minimum = get_minimum(vec), percent10 = quantile(remove_missing(vec), probs = 0,1), 
       quartile1 = get_quartile1(vec), median = get_median(vec), 
       mean = get_average(vec),quartile3 = get_quartile3(vec),
       percent90 = quantile(remove_missing(vec), probs = 0.9), 
       maximum = get_maximum(vec), range = get_range(vec), 
       stdev = get_stdev(vec), missing = count_missing(vec))
}

#====================================================
# Title: Print Stats
# Description: Takes a list of summary statistics and prints the value in a nice format
# Input: List of Summary Statistics
# Output: Printed values in a nice format
#====================================================

print_stats <- function(stats){
  cat('minimum  :', unlist(stats[1]), '\n')
  cat('percent10:', unlist(stats[2]),'\n')
  cat('quartile1:', unlist(stats[3]), '\n')
  cat('median   :', unlist(stats[4]), '\n')
  cat('mean     :', unlist(stats[5]), '\n')
  cat('quartile3:', unlist(stats[6]), '\n')
  cat('percent90:', unlist(stats[7]), '\n')
  cat('maximum  :', unlist(stats[8]), '\n')
  cat('range    :', unlist(stats[9]), '\n')
  cat('stdev    :', unlist(stats[10]), '\n')
  cat('missing  :', unlist(stats[11]), '\n')
}

#====================================================
# Title: Rescale
# Description: Computes a rescaled vector with a potential scale from 0 to 100
# Input: A numeric vector x, a minimum xmin, and a maximum xmax
# Output: Rescaled vector
#====================================================

rescale100 <- function(x, xmin, xmax) {
  term <- (x - xmin) / (xmax - xmin)
  return(100 * term)
}

#====================================================
# Title: Drop Lowest
# Description: Takes in a numeric vector and returns the vector after removing the lowest value
# Input: Some numeric vector of length N
# Output: Numeric vector of length N - 1 with the lowest term removed
#====================================================

drop_lowest <- function(vec) {
  min <- 1
  for (i in 1:length(vec)) {
    if (vec[i] < vec[min]) {
      min = i
    }
  }
  vec = vec[-min]
  return(vec)
}

#====================================================
# Title: Score Homework
# Description: Takes in numeric vector of homework scores and returns the mean of the homework scores. 
# Input: Some numeric vector of homework scores, an option to drop the lowest score
# Output: Average of homework scores
#====================================================

score_homework <- function(hws, drop = TRUE) {
  if (drop == TRUE) {
    hws <- drop_lowest(hws)
  }
  return(get_average(hws))
}

#====================================================
# Title: Score Quiz
# Description: Takes in numeric vector of quiz scores and returns the mean of the quiz scores. 
# Input: Some numeric vector of quiz scores, an option to drop the lowest score
# Output: Average of quiz scores
#====================================================

score_quiz <- function(hws, drop = TRUE) {
  if (drop == TRUE) {
    hws <- drop_lowest(hws)
  }
  return(get_average(hws))
}

#====================================================
# Title: Score Lab
# Description: A function that takes a numeric value of lab attendance, and returns the lab score. 
# Input: An attendance score between 0 - 12
# Output: Corresponding lab score based on attendance
#====================================================

score_lab <- function(score) {
  if (score >= 11) {
    return(100)
  } else if (score == 10) {
    return(80)
  } else if (score == 9) {
    return(60)
  } else if (score == 8) {
    return(40)
  } else if (score == 7) {
    return(20)
  } else {
    return(0)
  }
}


