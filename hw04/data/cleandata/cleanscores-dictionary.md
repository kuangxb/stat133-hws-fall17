---
title: "cleanscore-dictionary.md"
author: "Xu-Bin Kuang"
date: "26/11/2017"
output: md_document
---

## Data `cleanscores.csv`

Contains cleaned scores for a hypothetical Stat 133 class.
Here's the description of the R objects in `rawscores.csv`:

- homework assignments: columns `HW1` to `HW9`, where each hw is worth 100 points
- lab attendance: column `ATT`, which is the number of attended labs (0 to 12)
- quiz scores, rescaled to 100: `QZ1` (12), `QZ2` (18 pts), `QZ3` (20 pts), `QZ4` (20 pts)
- exam scores: `Test1` (80 pts, rescoled to 100), `EX2` (90 pts, rescaled to 100)
- Total Homework Score : 'Homework', average of homework scores after dropping the lowest one
- Total Quiz Score : 'Quiz', average of quiz scores after dropping the lowest one
- Overall Score: 'Overall' total score in the class with the following weightages:
                  - 10% Lab Score
                  - 30$ Homework Score (Lowest Score Dropped)
                  - 15% Quiz Score (Lowest Score Dropped)
                  - 20% Test 1 Score
                  - 25% Test 2 Score
- Letter Grade: 'Grade', letter grade assigned based on Overall Score. The grade assignments are                  outlined as follows:

                  Score           Grade
                  [0 - 50)        F
                  [50 - 60)       D
                  [60 - 70)       C-
                  [70 - 77.5)     C
                  [77.5 - 79.5)   C+
                  [79.5 - 82)     B-
                  [82 - 86)       B
                  [86 - 88)       B+
                  [88 - 90)       A-
                  [90 - 95)       A
                  [95 - 100]      A+
                  
There are 334 rows and 16 columns.