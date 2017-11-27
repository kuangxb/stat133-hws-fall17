library("testthat")
source("functions.R")

case_1 <- c(1, 4, 7, NA, 10)
case_2 <- c(NA, NA, NA, NA, 5)
case_3 <- c(-1, 1, 0)
case_4 <- c(0, 0, 0, 0)


context("Testing remove_missing()")
test_that('missing values are removed', {
  expect_equal(remove_missing(case_1), c(1, 4, 7, 10))
  expect_equal(length(remove_missing(case_1)), 4)
  expect_equal(remove_missing(case_2), c(5))
  expect_equal(length(remove_missing(case_2)), 1)
})

context("Testing get_minimum()")
test_that("minimum value should be returned", {
  expect_equal(get_minimum(case_1), 1)
  expect_equal(get_minimum(case_2), 5)
  expect_equal(get_minimum(case_3), -1)
  expect_equal(get_minimum(case_4), 0)
})

context("Testing get_maximum()")

test_that("maximum value should be returned", {
  expect_equal(get_maximum(case_1), 10)
  expect_equal(get_maximum(case_2), 5)
  expect_equal(get_maximum(case_3), 1)
  expect_equal(get_maximum(case_4), 0)
})

context("Testing get_range()")

test_that("range value should be returned", {
  expect_equal(get_range(case_1), 9)
  expect_equal(get_range(case_2), 0)
  expect_equal(get_range(case_3), 2)
  expect_equal(get_range(case_4), 0)
})

context("Testing get_median()")

test_that("return median of numeric vector", {
  expect_equal(get_median(case_1), 5.5)
  expect_equal(get_median(case_2, na.rm = TRUE), 5)
  expect_equal(get_median(case_3), 1)
  expect_equal(get_median(case_4), 0)
})

context("Testing get_average()")

test_that("return average of numeric vector", {
  expect_equal(get_average(case_1), 5.5)
  expect_equal(get_average(case_2), 5)
  expect_equal(get_average(case_3), 0)
  expect_equal(get_average(case_4), 0)
})

context("Testing get_stdev()")

test_that("return Standard Deviation of numeric vector", {
  expect_equal(get_stdev(case_1), 3.872983, tolerance = 1e-6)
  expect_equal(get_stdev(case_2, na.rm = TRUE), NaN)
  expect_equal(get_stdev(case_3), 1)
  expect_equal(get_stdev(case_4), 0)
})

context("Testing get_quartile1()")

test_that("return First Quartile of numeric vector", {
  expect_equal(get_quartile1(case_1), 3.25, tolerance = 1e-6)
  expect_equal(get_quartile1(case_2, na.rm = TRUE), 5)
  expect_equal(get_quartile1(case_3), -0.5)
  expect_equal(get_quartile1(case_4), 0)
})

context("Testing get_quartile3()")

test_that("return Standard Deviation of numeric vector", {
  expect_equal(get_quartile3(case_1), 7.75, tolerance = 1e-6)
  expect_equal(get_quartile3(case_2, na.rm = TRUE), 5)
  expect_equal(get_quartile3(case_3), 0.5)
  expect_equal(get_quartile3(case_4), 0)
})

context("Testing count_missing()")

test_that("return Standard Deviation of numeric vector", {
  expect_equal(count_missing(case_1), 1)
  expect_equal(count_missing(case_2), 4)
  expect_equal(count_missing(case_3), 0)
  expect_equal(count_missing(case_4), 0)
})

context("Testing summary_stats()")

test_that("return Summary Statistics of numeric vector", {
  stats <- summary_stats(case_1)
  expect_equal(names(stats), c("minimum", "percent10", "quartile1"
                               , "median", "mean", "quartile3", "percent90"
                               , "maximum", "range", "stdev", "missing"))
  expect_equal(stats[["minimum"]], 1)
  expect_equal(stats[["quartile3"]], 7.75)
  expect_equal(names(stats)[3], "quartile1")
})

context("Testing rescale100()")
test_that("return rescaled vector", {
  expect_equal(rescale100(case_1, 0, 10), c(10, 40, 70, NA, 100))
  b <- c(18, 15, 16, 4, 17, 9)
  expect_equal(rescale100(b, 0, 20), c(90, 75, 80, 20, 85, 45))
  expect_equal(rescale100(case_3, 0, 5), c(-20, 20, 0))
  expect_equal(rescale100(case_4, 0, 100), c(0, 0, 0, 0))
})

context("Testing drop_lowest()")

test_that("remove lowest value from numeric vector", {
  expect_equal(drop_lowest(remove_missing(case_1)), c(4, 7, 10))
  b <- c(10, 10, 8.5, 4, 7, 9)
  expect_equal(drop_lowest(b), c(10, 10, 8.5, 7, 9))
  expect_equal(drop_lowest(case_3), c(1, 0))
  expect_equal(drop_lowest(case_4), c(0, 0, 0))
})

context("Testing score_homework()")

test_that("return averagoe of homework scores, lowest might/might not be dropped", {
  hws <- c(100, 80, 30, 70, 75, 85)
  expect_equal(score_homework(hws), 82)
  expect_equal(score_homework(hws, drop = FALSE), 73.33333, tolerance = 1e-6)
  hws2 <- c(100, 80, 0, 90, 95, 85)
  expect_equal(score_homework(hws2), 90)
  expect_equal(score_homework(hws2, drop = FALSE), 75)
})

context("Testing score_quiz()")

test_that("return averagoe of homework scores, lowest might/might not be dropped", {
  quiz <- c(100, 80, 70, 0)
  expect_equal(score_quiz(quiz), 83.33333, tolerance = 1e-6)
  expect_equal(score_quiz(quiz, drop = FALSE), 62.5, tolerance = 1e-6)
  quiz2 <- c(10, 8, 5, 9)
  expect_equal(score_quiz(quiz2), 9)
  expect_equal(score_quiz(quiz2, drop = FALSE), 8)
})

context("Testing score_lab()")

test_that("return lab scores", {
  expect_equal(score_lab(12), 100)
  expect_equal(score_lab(10), 80)
  expect_equal(score_lab(9), 60)
  expect_equal(score_lab(6), 0)
})






