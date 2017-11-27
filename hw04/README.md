 Stat 133 Grade Visualizer
=========================

In this project, I worked with on a data set containing raw scores of
fictitious students in a hypothetical Stat 133 course.From the user
point of view, the main deliverable is a shiny app that visualizes: 1)
the overall grade distribution, 2) the distribution and summary
statistics of various scores, and 3) the relationships between pairs of
scores.

Running the Shiny App
---------------------

    library(shiny)

    ## Warning: package 'shiny' was built under R version 3.2.5

    #runGitHub("stat133-hws-fall17", "kuangxb", subdir = "hw04/app")

Testing
-------

The tests can be found in 'tests.R'. Run them using 'tester-script.R'

Functions
=========

The full list of functions and their descriptions can be found in
"code/functions.R"

Data
====

Rawdata and Cleaned Data along with their respective dictionaries.

Output
======

-   Statistical Summarries of the data files, tests, homeworks, labs,
    quizzes and Overall Grade.
-   Results from running tests.

Comments and Reflections
========================

-   This was first time writing unit tests in R and my first exposure to
    the 'testthat' package.

-   testthat was rather straight forward, 0.

-   This was first time working with ggvis, I found the syntax rather
    confusing but got the hang of it after this homework.

-   This was my first time working with conditional Panels (5).

-   I found ggplot the most visually appealing and easy to use.

-   I worked on it together with a few friends, we brainstormed many of
    the problems together. Especially during the shinyapp section. Aiden
    Rafii, Marc Mansour and Justin Nelson.

-   It took me about 15 hours to complete this HW.

-   Implementign ShinyApp took the longest time.
