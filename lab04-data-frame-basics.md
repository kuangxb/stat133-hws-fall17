Lab 4: Data Frame Basics
================
Gaston Sanchez

> ### Learning Objectives:
>
> -   Get started with data frames
> -   Understand basic operations
> -   Understand bracket and dollar notations

------------------------------------------------------------------------

Manipulating Data Frames
------------------------

The most common format/structure for a data set is a tabular format: with row and columns (like a spreadsheet). When your data is in this shape, most of the time you will work with R **data frames** (or similar rectangular structures like a `"matrix"`, `"table"`, etc).

Learning how to manipulate data tables is among the most important *data computing* basic skills. The traditional way of manipulating data frames in R is based on bracket notation, e.g. `dat[ , ]`, to select specific rows, columns, or cells. Also, the use of the dollar `$` operator to handle columns is fundamental. In this part of the lab, you will practice a wide array of data wrangling tasks with the so-called bracket notation, and the dollar operator.

I should say that there are alternative ways for manipulating tables in R. Among the most recent paradigms, there is the **plying** framework devised by Hadley Wickham. From his doctoral research, the first *plyr* tools were available in the packages `"plyr"` and `"reshape"`. Nowadays we have the `"reshape2"` package, and the extremely popular package `"dplyr"` (among other packages). You will have time to learn more about `"dplyr"` in the next weeks. In the meantime, take some time to understand more about the bracket notation.

Creating data frames
--------------------

Most of the (raw) data tables you will be working with will already be in some data file. However, from time to time you will face the need of creating some sort of data table in R. In these situations, you will likely have to create such table with a data frame. So let's look at various ways to "manually"" create a data frame.

**Option 1**: The primary option to build a data frame is with `data.frame()`. You pass a series of vectors (or factors), of the same length, separated by commas. Each vector (or factor) will become a column in the generated data frame. Preferably, give names to each column, like `col1`, `col2`, and `col3`, in the example below:

``` r
# creating a basic data frame
my_table1 <- data.frame(
  col1 = LETTERS[1:5],
  col2 = seq(from = 10, to = 50, by = 10),
  col3 = c(TRUE, TRUE, FALSE, TRUE, FALSE)
)

my_table1
```

    ##   col1 col2  col3
    ## 1    A   10  TRUE
    ## 2    B   20  TRUE
    ## 3    C   30 FALSE
    ## 4    D   40  TRUE
    ## 5    E   50 FALSE

**Option 2**: Another way to create data frames is with a `list` containing vectors or factors (of the same length), which then you convert to a data.frame with `data.frame()`:

``` r
# another way to create a basic data frame
my_list <- list(
  col1 = LETTERS[1:5],
  col2 = seq(from = 10, to = 50, by = 10),
  col3 = c(TRUE, TRUE, FALSE, TRUE, FALSE)
)

my_table2 <- data.frame(my_list)

my_table2
```

    ##   col1 col2  col3
    ## 1    A   10  TRUE
    ## 2    B   20  TRUE
    ## 3    C   30 FALSE
    ## 4    D   40  TRUE
    ## 5    E   50 FALSE

Remember that a `data.frame` is nothing more than a `list`. So as long as the elements in the list (vectors or factors) are of the same length, we can simply convert the list into a data frame.

By default, `data.frame()` converts character vectors into factors. You can check that by exmining the structure of the data frame with `str()`:

``` r
str(my_table2)
```

    ## 'data.frame':    5 obs. of  3 variables:
    ##  $ col1: Factor w/ 5 levels "A","B","C","D",..: 1 2 3 4 5
    ##  $ col2: num  10 20 30 40 50
    ##  $ col3: logi  TRUE TRUE FALSE TRUE FALSE

To prevent `data.frame()` from converting strings into factors, you must use the argument `stringsAsFactors = FALSE`

``` r
# strings as strings (not as factors)
my_table3 <- data.frame(
  col1 = LETTERS[1:5],
  col2 = seq(from = 10, to = 50, by = 10),
  col3 = c(TRUE, TRUE, FALSE, TRUE, FALSE),
  stringsAsFactors = FALSE
)

str(my_table3)
```

    ## 'data.frame':    5 obs. of  3 variables:
    ##  $ col1: chr  "A" "B" "C" "D" ...
    ##  $ col2: num  10 20 30 40 50
    ##  $ col3: logi  TRUE TRUE FALSE TRUE FALSE

### Your turn

Here's a table with the starting lineup of the Golden State Warriors:

| Player   | Position | Salary     | Points | PPG  | Rookie |
|----------|----------|------------|--------|------|--------|
| Thompson | SG       | 16,663,575 | 1742   | 22.3 | FALSE  |
| Curry    | PG       | 12,112,359 | 1999   | 25.3 | FALSE  |
| Green    | PF       | 15,330,435 | 776    | 10.2 | FALSE  |
| Durant   | SF       | 26,540,100 | 1555   | 25.1 | FALSE  |
| Pachulia | C        | 2,898,000  | 426    | 6.1  | FALSE  |

-   Start by creating vectors for each of the columns.
-   Use the vectors to create a first data frame with `data.frame()`.
-   Check that this data frame is of class `"data.frame"`, and that it is also a list.
-   Create another data frame by first starting with a `list()`, and then passing the list to `data.frame()`.
-   What would you do to obtain a data frame such that when you check its structure `str()` the variables are:
    -   *Player* as character
    -   *Position* as factor
    -   *Salary* as numeric or real (ignore the commas)
    -   *Points* as integer
    -   *PPG* as numeric or real
    -   *Rookie* as logical
-   Find out how to use the *column binding* function `cbind()` to create a tabular object with the vectors created in step 1 (inspect what class of object is obtained with `cbind()`).
-   How could you convert the object in the previous step into a data frame?

``` r
player = c("Thompson", "Curry", "Green", "Durant", "Pachulia")
position = c("SG", "PG", "PF", "SF", "C")
salary = c(16663575, 12112359, 15330435, 26540100, 2898000)
points = c(1742, 1999, 776, 1555, 426)
ppg = c(22.3, 25.3, 10.2, 25.1, 6.1)
rookie = c(FALSE, FALSE, FALSE, FALSE, FALSE)

myTable1 <- data.frame(Player = player, Position = position, Salary = salary, Points = points, PPG = ppg, Rookie = rookie)

myList <- list(Player = player, Position = position, Salary = salary, Points = points, PPG = ppg, Rookie = rookie)

myTable2 <- data.frame(myList, stringsAsFactors = FALSE)

str(myTable1)
```

    ## 'data.frame':    5 obs. of  6 variables:
    ##  $ Player  : Factor w/ 5 levels "Curry","Durant",..: 5 1 3 2 4
    ##  $ Position: Factor w/ 5 levels "C","PF","PG",..: 5 3 2 4 1
    ##  $ Salary  : num  16663575 12112359 15330435 26540100 2898000
    ##  $ Points  : num  1742 1999 776 1555 426
    ##  $ PPG     : num  22.3 25.3 10.2 25.1 6.1
    ##  $ Rookie  : logi  FALSE FALSE FALSE FALSE FALSE

``` r
str(myTable2)
```

    ## 'data.frame':    5 obs. of  6 variables:
    ##  $ Player  : chr  "Thompson" "Curry" "Green" "Durant" ...
    ##  $ Position: chr  "SG" "PG" "PF" "SF" ...
    ##  $ Salary  : num  16663575 12112359 15330435 26540100 2898000
    ##  $ Points  : num  1742 1999 776 1555 426
    ##  $ PPG     : num  22.3 25.3 10.2 25.1 6.1
    ##  $ Rookie  : logi  FALSE FALSE FALSE FALSE FALSE

------------------------------------------------------------------------

Basic Operations with Data Frames
---------------------------------

Now that you have seen some ways to create data frames, let's discuss a number of basic manipulations of data frames. I will show you some examples and then you'll have the chance to put in practice the following operations:

-   Selecting table elements:
    -   select a given cell
    -   select a set of cells
    -   select a given row
    -   select a set of rows
    -   select a given column
    -   select a set of columns
-   Adding a new column
-   Deleting a new column
-   Renaming a column
-   Moving a column
-   Transforming a column

Let's say you have a data frame `tbl` with the lineup of the Golden State Warriors:

        player position   salary points  ppg rookie
    1 Thompson       SG 16663575   1742 22.3  FALSE
    2    Curry       PG 12112359   1999 25.3  FALSE
    3    Green       PF 15330435    776 10.2  FALSE
    4   Durant       SF 26540100   1555 25.1  FALSE
    5 Pachulia        C  2898000    426  6.1  FALSE

#### Selecting elements

The data frame `tbl` is a 2-dimensional object: the 1st dimension corresponds to the rows, while the 2nd dimension corresponds to the columns. Because `tbl` has two dimensions, the bracket notation involves working with the data frame in this form: `tbl[ , ]`. In other words, you have to specify values inside the brackets for the 1st index, and the 2nd index: `tbl[index1, index2]`.

``` r
# select value in row 1 and column 1
tbl[1,1]
```

    ## [1] "Thompson"

``` r
# select value in row 2 and column 5
tbl[2,5]
```

    ## [1] 25.3

``` r
# select values in these cells
tbl[1:3,3:5]
```

    ##     salary points  ppg
    ## 1 16663575   1742 22.3
    ## 2 12112359   1999 25.3
    ## 3 15330435    776 10.2

If no value is specified for `index1` then all rows are included. Likewise, if no value is specified for `index2` then all columns are included.

``` r
# selecting first row
tbl[1, ]
```

    ##     player position   salary points  ppg rookie
    ## 1 Thompson       SG 16663575   1742 22.3  FALSE

``` r
# selecting third row
tbl[3, ]
```

    ##   player position   salary points  ppg rookie
    ## 3  Green       PF 15330435    776 10.2  FALSE

``` r
# selecting second column
tbl[ ,2]
```

    ## [1] "SG" "PG" "PF" "SF" "C"

``` r
# selecting columns 3 to 5
tbl[ ,3:5]
```

    ##     salary points  ppg
    ## 1 16663575   1742 22.3
    ## 2 12112359   1999 25.3
    ## 3 15330435    776 10.2
    ## 4 26540100   1555 25.1
    ## 5  2898000    426  6.1

#### Adding a column

Perhaps the simplest way to add a column is with the dollar operator `$`. You just need to give a name for the new column, and assign a vector (or factor):

``` r
# adding a column
tbl$new_column <- c('a', 'e', 'i', 'o', 'u')
tbl
```

    ##     player position   salary points  ppg rookie new_column
    ## 1 Thompson       SG 16663575   1742 22.3  FALSE          a
    ## 2    Curry       PG 12112359   1999 25.3  FALSE          e
    ## 3    Green       PF 15330435    776 10.2  FALSE          i
    ## 4   Durant       SF 26540100   1555 25.1  FALSE          o
    ## 5 Pachulia        C  2898000    426  6.1  FALSE          u

Another way to add a column is with the *column binding* function `cbind()`:

``` r
# vector of weights
weight <- c(215, 190, 230, 240, 270)

# adding weights to tbl
tbl <- cbind(tbl, weight)
tbl
```

    ##     player position   salary points  ppg rookie new_column weight
    ## 1 Thompson       SG 16663575   1742 22.3  FALSE          a    215
    ## 2    Curry       PG 12112359   1999 25.3  FALSE          e    190
    ## 3    Green       PF 15330435    776 10.2  FALSE          i    230
    ## 4   Durant       SF 26540100   1555 25.1  FALSE          o    240
    ## 5 Pachulia        C  2898000    426  6.1  FALSE          u    270

#### Deleting a column

The inverse operation of adding a column consists of **deleting** a column. This is possible with the `$` dollar operator. For instance, say you want to remove the column `new_column`. Use the `$` operator to select this column, and assign it the value `NULL` (think of this as *NULLifying* a column):

``` r
# deleting a column
tbl$new_column <- NULL
tbl
```

    ##     player position   salary points  ppg rookie weight
    ## 1 Thompson       SG 16663575   1742 22.3  FALSE    215
    ## 2    Curry       PG 12112359   1999 25.3  FALSE    190
    ## 3    Green       PF 15330435    776 10.2  FALSE    230
    ## 4   Durant       SF 26540100   1555 25.1  FALSE    240
    ## 5 Pachulia        C  2898000    426  6.1  FALSE    270

#### Renaming a column

What if you want to rename a column? There are various options to do this. One way is by changing the column`names` attribute:

``` r
# attributes
attributes(tbl)
```

    ## $names
    ## [1] "player"   "position" "salary"   "points"   "ppg"      "rookie"  
    ## [7] "weight"  
    ## 
    ## $row.names
    ## [1] 1 2 3 4 5
    ## 
    ## $class
    ## [1] "data.frame"

which is more commonly accessed with the `names()` function:

``` r
# column names
names(tbl)
```

    ## [1] "player"   "position" "salary"   "points"   "ppg"      "rookie"  
    ## [7] "weight"

Notice that `tbl` has a list of attributes. The element `names` is the vector of column names.

You can directly modify the vector of `names`; for example let's change `rookie` to `rooky`:

``` r
# changing rookie to rooky
attributes(tbl)$names[6] <- "rooky"

# display column names
names(tbl)
```

    ## [1] "player"   "position" "salary"   "points"   "ppg"      "rooky"   
    ## [7] "weight"

By the way: this way of changing the name of a variable is very low level, and probably unfamiliar to most useRs.

#### Moving a column

A more challenging operation is when you want to move a column to a different position. What if you want to move `salary` to the last position (last column)? One option is to create a vector of column names in the desired order, and then use this vector (for the index of columns) to reassign the data frame like this:

``` r
reordered_names <- c("player", "position", "points", "ppg", "rooky", "weight", "salary")

# moving salary at the end
tbl <- tbl[ ,reordered_names]
tbl
```

    ##     player position points  ppg rooky weight   salary
    ## 1 Thompson       SG   1742 22.3 FALSE    215 16663575
    ## 2    Curry       PG   1999 25.3 FALSE    190 12112359
    ## 3    Green       PF    776 10.2 FALSE    230 15330435
    ## 4   Durant       SF   1555 25.1 FALSE    240 26540100
    ## 5 Pachulia        C    426  6.1 FALSE    270  2898000

#### Transforming a column

A more common operation than deleting or moving a column, is to transform the values in a column. This can be easily accomplished with the `$` operator. For instance, let's say that we want to transform `salary` from dollars to millions of dollars:

``` r
# converting salary in millions of dollars
tbl$salary <- tbl$salary / 1000000
tbl
```

    ##     player position points  ppg rooky weight   salary
    ## 1 Thompson       SG   1742 22.3 FALSE    215 16.66358
    ## 2    Curry       PG   1999 25.3 FALSE    190 12.11236
    ## 3    Green       PF    776 10.2 FALSE    230 15.33043
    ## 4   Durant       SF   1555 25.1 FALSE    240 26.54010
    ## 5 Pachulia        C    426  6.1 FALSE    270  2.89800

Likewise, instead of using the `$` operator, you can refer to the column using bracket notation. Here's how to transform weight from pounds to kilograms (1 pound = 0.453592 kilograms):

``` r
# weight in kilograms
tbl[ ,"weight"] <- tbl[ ,"weight"] * 0.453592
tbl
```

    ##     player position points  ppg rooky    weight   salary
    ## 1 Thompson       SG   1742 22.3 FALSE  97.52228 16.66358
    ## 2    Curry       PG   1999 25.3 FALSE  86.18248 12.11236
    ## 3    Green       PF    776 10.2 FALSE 104.32616 15.33043
    ## 4   Durant       SF   1555 25.1 FALSE 108.86208 26.54010
    ## 5 Pachulia        C    426  6.1 FALSE 122.46984  2.89800

There is also the `transform()` function which transform values *interactively*, that is, temporarily:

``` r
# transform weight to inches
transform(tbl, weight = weight / 0.453592)
```

    ##     player position points  ppg rooky weight   salary
    ## 1 Thompson       SG   1742 22.3 FALSE    215 16.66358
    ## 2    Curry       PG   1999 25.3 FALSE    190 12.11236
    ## 3    Green       PF    776 10.2 FALSE    230 15.33043
    ## 4   Durant       SF   1555 25.1 FALSE    240 26.54010
    ## 5 Pachulia        C    426  6.1 FALSE    270  2.89800

`transform()` does its job of modifying the values of `weight` but only temporarily; if you inspect `tbl` you'll see what this means:

``` r
# did weight really change?
tbl
```

    ##     player position points  ppg rooky    weight   salary
    ## 1 Thompson       SG   1742 22.3 FALSE  97.52228 16.66358
    ## 2    Curry       PG   1999 25.3 FALSE  86.18248 12.11236
    ## 3    Green       PF    776 10.2 FALSE 104.32616 15.33043
    ## 4   Durant       SF   1555 25.1 FALSE 108.86208 26.54010
    ## 5 Pachulia        C    426  6.1 FALSE 122.46984  2.89800

To make the changes permanent with `transform()`, you need to reaassign them to the data frame:

``` r
# transform weight to inches (permanently)
tbl <- transform(tbl, weight = weight / 0.453592)
tbl
```

    ##     player position points  ppg rooky weight   salary
    ## 1 Thompson       SG   1742 22.3 FALSE    215 16.66358
    ## 2    Curry       PG   1999 25.3 FALSE    190 12.11236
    ## 3    Green       PF    776 10.2 FALSE    230 15.33043
    ## 4   Durant       SF   1555 25.1 FALSE    240 26.54010
    ## 5 Pachulia        C    426  6.1 FALSE    270  2.89800

------------------------------------------------------------------------

NBA Players Data
----------------

``` r
csv <- "https://github.com/ucb-stat133/stat133-fall-2017/raw/master/data/nba2017-players.csv"
download.file(url = csv, destfile = 'nba2017-players.csv')
dat <- read.csv('nba2017-players.csv', stringsAsFactors = FALSE)
```

Now that you've seen some of the most basic operations to maipulate data frames, let's apply them on a data set about NBA players. The corresponding data file is `nba2017-players.csv`, located in the `data/` folder of the course github repository. This file contains 15 variables measured on 441 players.

First download a copy of the csv file to your computer.

``` r
# download csv file into your working directory
csv <- "https://github.com/ucb-stat133/stat133-fall-2017/raw/master/data/nba2017-players.csv"
download.file(url = csv, destfile = 'nba2017-players.csv')
```

To import the data in R you can use the function `read.csv()`:

``` r
dat <- read.csv('nba2017-players.csv', stringsAsFactors = FALSE)
```

Notice that I'm specifying the argument `stringsAsFactors = FALSE` to avoid the conversion of characters into R factors. Why do you think this is a good practice?

All the default reading table functions generate a data frame. Typically, everytime I read a new data set which I'm not familiar with, or a data set that I haven't worked on in a long time, I always like to call a couple of functions to inspect its contents:

-   `dim()`
-   `head()`
-   `tail()`
-   `str()`
-   `summary()`

A first check-up is to examine the dimensions of the data frame with `dim()`:

``` r
# dimensions (# of rows, # of columns)
dim(dat)
```

    ## [1] 441  15

If you know in advanced how many rows and columns are in the data table, this is a good way to make sure that R was able to read all the records.

Then, depending on the size of the data, you may want to take a peek at its contents with `head()` or `tail()`, just to get an idea of what the data looks like:

``` r
# display first few rows
head(dat)
```

    ##              player team position height weight age experience
    ## 1        Al Horford  BOS        C     82    245  30          9
    ## 2      Amir Johnson  BOS       PF     81    240  29         11
    ## 3     Avery Bradley  BOS       SG     74    180  26          6
    ## 4 Demetrius Jackson  BOS       PG     73    201  22          0
    ## 5      Gerald Green  BOS       SF     79    205  31          9
    ## 6     Isaiah Thomas  BOS       PG     69    185  27          5
    ##                         college   salary games minutes points points3
    ## 1         University of Florida 26540100    68    2193    952      86
    ## 2                               12000000    80    1608    520      27
    ## 3 University of Texas at Austin  8269663    55    1835    894     108
    ## 4      University of Notre Dame  1450000     5      17     10       1
    ## 5                                1410598    47     538    262      39
    ## 6      University of Washington  6587132    76    2569   2199     245
    ##   points2 points1
    ## 1     293     108
    ## 2     186      67
    ## 3     251      68
    ## 4       2       3
    ## 5      56      33
    ## 6     437     590

For a more detailed description of how R is treating the data type in each column, you should use the structure function `str()`.

``` r
# check the structure
str(dat, vec.len = 1)
```

    ## 'data.frame':    441 obs. of  15 variables:
    ##  $ player    : chr  "Al Horford" ...
    ##  $ team      : chr  "BOS" ...
    ##  $ position  : chr  "C" ...
    ##  $ height    : int  82 81 ...
    ##  $ weight    : int  245 240 ...
    ##  $ age       : int  30 29 ...
    ##  $ experience: int  9 11 ...
    ##  $ college   : chr  "University of Florida" ...
    ##  $ salary    : num  26540100 ...
    ##  $ games     : int  68 80 ...
    ##  $ minutes   : int  2193 1608 ...
    ##  $ points    : int  952 520 ...
    ##  $ points3   : int  86 27 ...
    ##  $ points2   : int  293 186 ...
    ##  $ points1   : int  108 67 ...

This function `str()` displays the dimensions of the data frame, and then a list with the name of all the variables, and their data types (e.g. `chr` character, `num` real, etc). The argument `vec.len = 1` indicates that just the first element in each column should be displayed.

When working with data frames, remember to always take some time inspecting the contents, and checking how R is handling the data types. It is in these early stages of data exploration that you can catch potential issues in order to avoid disastrous consequences or bugs in subsequent stages.

------------------------------------------------------------------------

### Your turn:

Use bracket notation, the dollar operator, as well as concepts of logical subsetting and indexing to:

-   Display the last 5 rows of the data.

``` r
tail(dat, 5)
```

    ##              player team position height weight age experience
    ## 437 Marquese Chriss  PHO       PF     82    233  19          0
    ## 438    Ronnie Price  PHO       PG     74    190  33         11
    ## 439     T.J. Warren  PHO       SF     80    230  23          2
    ## 440      Tyler Ulis  PHO       PG     70    150  21          0
    ## 441  Tyson Chandler  PHO        C     85    240  34         15
    ##                             college   salary games minutes points points3
    ## 437        University of Washington  2941440    82    1743    753      72
    ## 438       Utah Valley State College   282595    14     134     14       3
    ## 439 North Carolina State University  2128920    66    2048    951      26
    ## 440          University of Kentucky   918369    61    1123    444      21
    ## 441                                 12415000    47    1298    397       0
    ##     points2 points1
    ## 437     212     113
    ## 438       1       3
    ## 439     377     119
    ## 440     163      55
    ## 441     153      91

-   Display those rows associated to players having height less than 70 inches tall.

``` r
dat[dat$height > 70, ]
```

    ##                       player team position height weight age experience
    ## 1                 Al Horford  BOS        C     82    245  30          9
    ## 2               Amir Johnson  BOS       PF     81    240  29         11
    ## 3              Avery Bradley  BOS       SG     74    180  26          6
    ## 4          Demetrius Jackson  BOS       PG     73    201  22          0
    ## 5               Gerald Green  BOS       SF     79    205  31          9
    ## 7                Jae Crowder  BOS       SF     78    235  26          4
    ## 8                James Young  BOS       SG     78    215  21          2
    ## 9               Jaylen Brown  BOS       SF     79    225  20          0
    ## 10             Jonas Jerebko  BOS       PF     82    231  29          6
    ## 11             Jordan Mickey  BOS       PF     80    235  22          1
    ## 12              Kelly Olynyk  BOS        C     84    238  25          3
    ## 13              Marcus Smart  BOS       SG     76    220  22          2
    ## 14              Terry Rozier  BOS       PG     74    190  22          1
    ## 15              Tyler Zeller  BOS        C     84    253  27          4
    ## 16             Channing Frye  CLE        C     83    255  33         10
    ## 17             Dahntay Jones  CLE       SF     78    225  36         12
    ## 18            Deron Williams  CLE       PG     75    200  32         11
    ## 19          Derrick Williams  CLE       PF     80    240  25          5
    ## 20               Edy Tavares  CLE        C     87    260  24          1
    ## 21             Iman Shumpert  CLE       SG     77    220  26          5
    ## 22                J.R. Smith  CLE       SG     78    225  31         12
    ## 23               James Jones  CLE       SF     80    218  36         13
    ## 25                Kevin Love  CLE       PF     82    251  28          8
    ## 26               Kyle Korver  CLE       SG     79    212  35         13
    ## 27              Kyrie Irving  CLE       PG     75    193  24          5
    ## 28              LeBron James  CLE       SF     80    250  32         13
    ## 29         Richard Jefferson  CLE       SF     79    233  36         15
    ## 30          Tristan Thompson  CLE        C     81    238  25          5
    ## 31             Bruno Caboclo  TOR       SF     81    218  21          2
    ## 32               Cory Joseph  TOR       SG     75    193  25          5
    ## 33              Delon Wright  TOR       PG     77    183  24          1
    ## 34             DeMar DeRozan  TOR       SG     79    221  27          7
    ## 35           DeMarre Carroll  TOR       SF     80    215  30          7
    ## 36             Fred VanVleet  TOR       PG     72    195  22          0
    ## 37              Jakob Poeltl  TOR        C     84    248  21          0
    ## 38         Jonas Valanciunas  TOR        C     84    265  24          4
    ## 39                Kyle Lowry  TOR       PG     72    205  30         10
    ## 40            Lucas Nogueira  TOR        C     84    241  24          2
    ## 41             Norman Powell  TOR       SG     76    215  23          1
    ## 42               P.J. Tucker  TOR       SF     78    245  31          5
    ## 43             Pascal Siakam  TOR       PF     81    230  22          0
    ## 44         Patrick Patterson  TOR       PF     81    230  27          6
    ## 45               Serge Ibaka  TOR       PF     82    235  27          7
    ## 46          Bojan Bogdanovic  WAS       SF     80    216  27          2
    ## 47              Bradley Beal  WAS       SG     77    207  23          4
    ## 48          Brandon Jennings  WAS       PG     73    170  27          7
    ## 49          Chris McCullough  WAS       PF     83    200  21          1
    ## 50             Daniel Ochefu  WAS        C     83    245  23          0
    ## 51               Ian Mahinmi  WAS        C     83    250  30          8
    ## 52               Jason Smith  WAS        C     84    245  30          8
    ## 53                 John Wall  WAS       PG     76    195  26          6
    ## 54             Marcin Gortat  WAS        C     83    240  32          9
    ## 55           Markieff Morris  WAS       PF     82    245  27          5
    ## 56               Otto Porter  WAS       SF     80    198  23          3
    ## 57         Sheldon McClellan  WAS       SG     77    200  24          0
    ## 58          Tomas Satoransky  WAS       SG     79    210  25          0
    ## 59                Trey Burke  WAS       PG     73    191  24          3
    ## 60           DeAndre' Bembry  ATL       SF     78    210  22          0
    ## 61           Dennis Schroder  ATL       PG     73    172  23          3
    ## 62             Dwight Howard  ATL        C     83    265  31         12
    ## 63            Ersan Ilyasova  ATL       PF     82    235  29          8
    ## 64             Jose Calderon  ATL       PG     75    200  35         11
    ## 65             Kent Bazemore  ATL       SF     77    201  27          4
    ## 66            Kris Humphries  ATL       PF     81    235  31         12
    ## 67           Malcolm Delaney  ATL       PG     75    190  27          0
    ## 68             Mike Dunleavy  ATL       SF     81    230  36         14
    ## 69              Mike Muscala  ATL        C     83    240  25          3
    ## 70              Paul Millsap  ATL       PF     80    246  31         10
    ## 71                Ryan Kelly  ATL       PF     83    230  25          3
    ## 72           Thabo Sefolosha  ATL       SF     79    220  32         10
    ## 73              Tim Hardaway  ATL       SG     78    205  24          3
    ## 74     Giannis Antetokounmpo  MIL       SF     83    222  22          3
    ## 75               Greg Monroe  MIL        C     83    265  26          6
    ## 76             Jabari Parker  MIL       PF     80    250  21          2
    ## 77               Jason Terry  MIL       SG     74    185  39         17
    ## 78               John Henson  MIL        C     83    229  26          4
    ## 79           Khris Middleton  MIL       SF     80    234  25          4
    ## 80           Malcolm Brogdon  MIL       SG     77    215  24          0
    ## 81       Matthew Dellavedova  MIL       PG     76    198  26          3
    ## 82           Michael Beasley  MIL       PF     81    235  28          8
    ## 83           Mirza Teletovic  MIL       PF     81    242  31          4
    ## 84             Rashad Vaughn  MIL       SG     78    202  20          1
    ## 85             Spencer Hawes  MIL       PF     85    245  28          9
    ## 86                Thon Maker  MIL        C     85    216  19          0
    ## 87                Tony Snell  MIL       SG     79    200  25          3
    ## 88              Aaron Brooks  IND       PG     72    161  32          8
    ## 89              Al Jefferson  IND        C     82    289  32         12
    ## 90                C.J. Miles  IND       SF     78    225  29         11
    ## 91             Georges Niang  IND       PF     80    230  23          0
    ## 92               Jeff Teague  IND       PG     74    186  28          7
    ## 93                 Joe Young  IND       PG     74    180  24          1
    ## 94            Kevin Seraphin  IND       PF     81    285  27          6
    ## 95          Lance Stephenson  IND       SG     77    230  26          6
    ## 96               Lavoy Allen  IND       PF     81    260  27          5
    ## 97               Monta Ellis  IND       SG     75    185  31         11
    ## 98              Myles Turner  IND        C     83    243  20          1
    ## 99               Paul George  IND       SF     81    220  26          6
    ## 100         Rakeem Christmas  IND       PF     81    250  25          1
    ## 101           Thaddeus Young  IND       PF     80    221  28          9
    ## 102           Anthony Morrow  CHI       SG     77    210  31          8
    ## 103             Bobby Portis  CHI       PF     83    230  21          1
    ## 104            Cameron Payne  CHI       PG     75    185  22          1
    ## 105        Cristiano Felicio  CHI        C     82    275  24          1
    ## 106         Denzel Valentine  CHI       SG     78    212  23          0
    ## 107              Dwyane Wade  CHI       SG     76    220  35         13
    ## 108            Isaiah Canaan  CHI       SG     72    201  25          3
    ## 109             Jerian Grant  CHI       PG     76    195  24          1
    ## 110             Jimmy Butler  CHI       SF     79    220  27          5
    ## 111        Joffrey Lauvergne  CHI        C     83    220  25          2
    ## 112  Michael Carter-Williams  CHI       PG     78    190  25          3
    ## 113           Nikola Mirotic  CHI       PF     82    220  25          2
    ## 114              Paul Zipser  CHI       SF     80    215  22          0
    ## 115              Rajon Rondo  CHI       PG     73    186  30         10
    ## 116              Robin Lopez  CHI        C     84    255  28          8
    ## 117             Dion Waiters  MIA       SG     76    225  25          4
    ## 118             Goran Dragic  MIA       PG     75    190  30          8
    ## 119         Hassan Whiteside  MIA        C     84    265  27          4
    ## 120            James Johnson  MIA       PF     81    250  29          7
    ## 121           Josh McRoberts  MIA       PF     82    240  29          9
    ## 122          Josh Richardson  MIA       SG     78    200  23          1
    ## 123          Justise Winslow  MIA       SF     79    225  20          1
    ## 124             Luke Babbitt  MIA       SF     81    225  27          6
    ## 125              Okaro White  MIA       PF     80    204  24          0
    ## 126          Rodney McGruder  MIA       SG     76    205  25          0
    ## 127            Tyler Johnson  MIA       PG     76    186  24          2
    ## 128            Udonis Haslem  MIA        C     80    235  36         13
    ## 129          Wayne Ellington  MIA       SG     76    200  29          7
    ## 130              Willie Reed  MIA        C     82    220  26          1
    ## 131           Andre Drummond  DET        C     83    279  23          4
    ## 132              Aron Baynes  DET        C     82    260  30          4
    ## 133               Beno Udrih  DET       PG     75    205  34         12
    ## 134         Boban Marjanovic  DET        C     87    290  28          1
    ## 135          Darrun Hilliard  DET       SG     78    205  23          1
    ## 136           Henry Ellenson  DET       PF     83    245  20          0
    ## 137                Ish Smith  DET       PG     72    175  28          6
    ## 138                Jon Leuer  DET       PF     82    228  27          5
    ## 139 Kentavious Caldwell-Pope  DET       SG     77    205  23          3
    ## 140            Marcus Morris  DET       SF     81    235  27          5
    ## 141          Michael Gbinije  DET       SG     79    200  24          0
    ## 142           Reggie Bullock  DET       SF     79    205  25          3
    ## 143           Reggie Jackson  DET       PG     75    208  26          5
    ## 144          Stanley Johnson  DET       SF     79    245  20          1
    ## 145            Tobias Harris  DET       PF     81    235  24          5
    ## 146            Brian Roberts  CHO       PG     73    173  31          4
    ## 147            Briante Weber  CHO       PG     74    165  24          1
    ## 148           Christian Wood  CHO       PF     83    220  21          1
    ## 149              Cody Zeller  CHO       PF     84    240  24          3
    ## 150           Frank Kaminsky  CHO        C     84    242  23          1
    ## 151              Jeremy Lamb  CHO       SG     77    185  24          4
    ## 152          Johnny O'Bryant  CHO       PF     81    257  23          2
    ## 153             Kemba Walker  CHO       PG     73    172  26          5
    ## 154          Marco Belinelli  CHO       SG     77    210  30          9
    ## 155          Marvin Williams  CHO       PF     81    237  30         11
    ## 156   Michael Kidd-Gilchrist  CHO       SF     79    232  23          4
    ## 157            Miles Plumlee  CHO        C     83    249  28          4
    ## 158            Nicolas Batum  CHO       SG     80    200  28          8
    ## 159           Ramon Sessions  CHO       PG     75    190  30          9
    ## 160           Treveon Graham  CHO       SG     78    220  23          0
    ## 161          Carmelo Anthony  NYK       SF     80    240  32         13
    ## 162           Chasson Randle  NYK       PG     74    185  23          0
    ## 163             Courtney Lee  NYK       SG     77    200  31          8
    ## 164             Derrick Rose  NYK       PG     75    190  28          7
    ## 165              Joakim Noah  NYK        C     83    230  31          9
    ## 166           Justin Holiday  NYK       SG     78    185  27          3
    ## 167       Kristaps Porzingis  NYK       PF     87    240  21          1
    ## 168             Kyle O'Quinn  NYK        C     82    250  26          4
    ## 169             Lance Thomas  NYK       PF     80    235  28          5
    ## 170         Marshall Plumlee  NYK        C     84    250  24          0
    ## 171            Maurice Ndour  NYK       PF     81    200  24          0
    ## 172     Mindaugas Kuzminskas  NYK       SF     81    215  27          0
    ## 173                Ron Baker  NYK       SG     76    220  23          0
    ## 174            Sasha Vujacic  NYK       SG     79    195  32          9
    ## 175        Willy Hernangomez  NYK        C     83    240  22          0
    ## 176             Aaron Gordon  ORL       SF     81    220  21          2
    ## 177          Bismack Biyombo  ORL        C     81    255  24          5
    ## 178              C.J. Watson  ORL       PG     74    175  32          9
    ## 179            D.J. Augustin  ORL       PG     72    183  29          8
    ## 180             Damjan Rudez  ORL       SF     82    228  30          2
    ## 181            Elfrid Payton  ORL       PG     76    185  22          2
    ## 182            Evan Fournier  ORL       SG     79    205  24          4
    ## 183               Jeff Green  ORL       PF     81    235  30          8
    ## 184              Jodie Meeks  ORL       SG     76    210  29          7
    ## 185      Marcus Georges-Hunt  ORL       SG     77    216  22          0
    ## 186            Mario Hezonja  ORL       SF     80    215  21          1
    ## 187           Nikola Vucevic  ORL        C     84    260  26          5
    ## 188          Patricio Garino  ORL       SG     78    210  23          0
    ## 189        Stephen Zimmerman  ORL        C     84    240  20          0
    ## 190            Terrence Ross  ORL       SF     79    206  25          4
    ## 191           Alex Poythress  PHI       PF     79    238  23          0
    ## 192              Dario Saric  PHI       PF     82    223  22          0
    ## 193         Gerald Henderson  PHI       SG     77    215  29          7
    ## 194            Jahlil Okafor  PHI        C     83    275  21          1
    ## 195           Jerryd Bayless  PHI       PG     75    200  28          8
    ## 196              Joel Embiid  PHI        C     84    250  22          0
    ## 197          Justin Anderson  PHI       SF     78    228  23          1
    ## 198             Nik Stauskas  PHI       SG     78    205  23          2
    ## 199           Richaun Holmes  PHI        C     82    245  23          1
    ## 200         Robert Covington  PHI       SF     81    215  26          3
    ## 201         Sergio Rodriguez  PHI       PG     75    176  30          4
    ## 202               Shawn Long  PHI        C     81    255  24          0
    ## 203           T.J. McConnell  PHI       PG     74    200  24          1
    ## 204           Tiago Splitter  PHI        C     83    245  32          6
    ## 205  Timothe Luwawu-Cabarrot  PHI       SF     78    205  21          0
    ## 206         Andrew Nicholson  BRK       PF     81    250  27          4
    ## 207           Archie Goodwin  BRK       SG     77    200  22          3
    ## 208              Brook Lopez  BRK        C     84    275  28          8
    ## 209             Caris LeVert  BRK       SF     79    203  22          0
    ## 210         Isaiah Whitehead  BRK       PG     76    213  21          0
    ## 211               Jeremy Lin  BRK       PG     75    200  28          6
    ## 212               Joe Harris  BRK       SG     78    219  25          2
    ## 213          Justin Hamilton  BRK        C     84    260  26          2
    ## 214           K.J. McDaniels  BRK       SF     78    205  23          2
    ## 215               Quincy Acy  BRK       PF     79    240  26          4
    ## 216               Randy Foye  BRK       SG     76    213  33         10
    ## 217  Rondae Hollis-Jefferson  BRK       SF     79    220  22          1
    ## 218          Sean Kilpatrick  BRK       SG     76    210  27          2
    ## 219        Spencer Dinwiddie  BRK       PG     78    200  23          2
    ## 220            Trevor Booker  BRK       PF     80    228  29          6
    ## 221           Andre Iguodala  GSW       SF     78    215  33         12
    ## 222             Damian Jones  GSW        C     84    245  21          0
    ## 223               David West  GSW        C     81    250  36         13
    ## 224           Draymond Green  GSW       PF     79    230  26          4
    ## 225                Ian Clark  GSW       SG     75    175  25          3
    ## 226     James Michael McAdoo  GSW       PF     81    230  24          2
    ## 227             JaVale McGee  GSW        C     84    270  29          8
    ## 228             Kevin Durant  GSW       SF     81    240  28          9
    ## 229             Kevon Looney  GSW        C     81    220  20          1
    ## 230            Klay Thompson  GSW       SG     79    215  26          5
    ## 231              Matt Barnes  GSW       SF     79    226  36         13
    ## 232            Patrick McCaw  GSW       SG     79    185  21          0
    ## 233         Shaun Livingston  GSW       PG     79    192  31         11
    ## 234            Stephen Curry  GSW       PG     75    190  28          7
    ## 235            Zaza Pachulia  GSW        C     83    270  32         13
    ## 236              Bryn Forbes  SAS       SG     75    190  23          0
    ## 237              Danny Green  SAS       SG     78    215  29          7
    ## 238                David Lee  SAS       PF     81    245  33         11
    ## 239            Davis Bertans  SAS       PF     82    210  24          0
    ## 240          Dejounte Murray  SAS       PG     77    170  20          0
    ## 241           Dewayne Dedmon  SAS        C     84    245  27          3
    ## 242             Joel Anthony  SAS        C     81    245  34          9
    ## 243         Jonathon Simmons  SAS       SG     78    195  27          1
    ## 244            Kawhi Leonard  SAS       SF     79    230  25          5
    ## 245            Kyle Anderson  SAS       SG     81    230  23          2
    ## 246        LaMarcus Aldridge  SAS       PF     83    260  31         10
    ## 247            Manu Ginobili  SAS       SG     78    205  39         14
    ## 248              Patty Mills  SAS       PG     72    185  28          7
    ## 249                Pau Gasol  SAS        C     84    250  36         15
    ## 250              Tony Parker  SAS       PG     74    185  34         15
    ## 251              Bobby Brown  HOU       PG     74    175  32          2
    ## 252           Chinanu Onuaku  HOU        C     82    245  20          0
    ## 253             Clint Capela  HOU        C     82    240  22          2
    ## 254              Eric Gordon  HOU       SG     76    215  28          8
    ## 255            Isaiah Taylor  HOU       PG     75    170  22          0
    ## 256             James Harden  HOU       PG     77    220  27          7
    ## 257             Kyle Wiltjer  HOU       PF     82    240  24          0
    ## 258             Lou Williams  HOU       SG     73    175  30         11
    ## 259         Montrezl Harrell  HOU        C     80    240  23          1
    ## 260         Patrick Beverley  HOU       SG     73    185  28          4
    ## 261            Ryan Anderson  HOU       PF     82    240  28          8
    ## 262               Sam Dekker  HOU       SF     81    230  22          1
    ## 263             Trevor Ariza  HOU       SF     80    215  31         12
    ## 264            Troy Williams  HOU       SF     79    218  22          0
    ## 265            Alan Anderson  LAC       SF     78    220  34          7
    ## 266            Austin Rivers  LAC       SG     76    200  24          4
    ## 267            Blake Griffin  LAC       PF     82    251  27          6
    ## 268             Brandon Bass  LAC       PF     80    250  31         11
    ## 269            Brice Johnson  LAC       PF     82    230  22          0
    ## 270               Chris Paul  LAC       PG     72    175  31         11
    ## 271           DeAndre Jordan  LAC        C     83    265  28          8
    ## 272            Diamond Stone  LAC        C     83    255  19          0
    ## 273              J.J. Redick  LAC       SG     76    190  32         10
    ## 274           Jamal Crawford  LAC       SG     77    200  36         16
    ## 275         Luc Mbah a Moute  LAC       SF     80    230  30          8
    ## 276        Marreese Speights  LAC        C     82    255  29          8
    ## 277              Paul Pierce  LAC       SF     79    235  39         18
    ## 278           Raymond Felton  LAC       PG     73    205  32         11
    ## 279           Wesley Johnson  LAC       SF     79    215  29          6
    ## 280               Alec Burks  UTA       SG     78    214  25          5
    ## 281               Boris Diaw  UTA       PF     80    250  34         13
    ## 282               Dante Exum  UTA       PG     78    190  21          1
    ## 283           Derrick Favors  UTA       PF     82    265  25          6
    ## 284              George Hill  UTA       PG     75    188  30          8
    ## 285           Gordon Hayward  UTA       SF     80    226  26          6
    ## 286              Jeff Withey  UTA        C     84    231  26          3
    ## 287               Joe Ingles  UTA       SF     80    226  29          2
    ## 288              Joe Johnson  UTA       SF     79    240  35         15
    ## 289            Joel Bolomboy  UTA       PF     81    235  23          0
    ## 290                Raul Neto  UTA       PG     73    179  24          1
    ## 291              Rodney Hood  UTA       SG     80    206  24          2
    ## 292              Rudy Gobert  UTA        C     85    245  24          3
    ## 293             Shelvin Mack  UTA       PG     75    203  26          5
    ## 294               Trey Lyles  UTA       PF     82    234  21          1
    ## 295             Alex Abrines  OKC       SG     78    190  23          0
    ## 296           Andre Roberson  OKC       SF     79    210  25          3
    ## 297         Domantas Sabonis  OKC       PF     83    240  20          0
    ## 298           Doug McDermott  OKC       SF     80    225  25          2
    ## 299              Enes Kanter  OKC        C     83    245  24          5
    ## 300             Jerami Grant  OKC       SF     80    210  22          2
    ## 301             Josh Huestis  OKC       PF     79    230  25          1
    ## 302             Kyle Singler  OKC       SF     80    228  28          4
    ## 303            Nick Collison  OKC       PF     82    255  36         12
    ## 304              Norris Cole  OKC       PG     74    175  28          5
    ## 305        Russell Westbrook  OKC       PG     75    200  28          8
    ## 306           Semaj Christon  OKC       PG     75    190  24          0
    ## 307             Steven Adams  OKC        C     84    255  23          3
    ## 308               Taj Gibson  OKC       PF     81    225  31          7
    ## 309           Victor Oladipo  OKC       SG     76    210  24          3
    ## 310          Andrew Harrison  MEM       PG     78    213  22          0
    ## 311           Brandan Wright  MEM       PF     82    210  29          8
    ## 312         Chandler Parsons  MEM       SF     82    230  28          5
    ## 313            Deyonta Davis  MEM        C     83    237  20          0
    ## 314              James Ennis  MEM       SF     79    210  26          2
    ## 315           JaMychal Green  MEM       PF     81    227  26          2
    ## 316            Jarell Martin  MEM       PF     82    239  22          1
    ## 317               Marc Gasol  MEM        C     85    255  32          8
    ## 318              Mike Conley  MEM       PG     73    175  29          9
    ## 319               Tony Allen  MEM       SG     76    213  35         12
    ## 320             Troy Daniels  MEM       SG     76    205  25          3
    ## 321             Vince Carter  MEM       SF     78    220  40         18
    ## 322             Wade Baldwin  MEM       PG     76    202  20          0
    ## 323             Wayne Selden  MEM       SG     77    230  22          0
    ## 324            Zach Randolph  MEM       PF     81    260  35         15
    ## 325          Al-Farouq Aminu  POR       SF     81    220  26          6
    ## 326             Allen Crabbe  POR       SG     78    210  24          3
    ## 327            C.J. McCollum  POR       SG     76    200  25          3
    ## 328           Damian Lillard  POR       PG     75    195  26          4
    ## 329                 Ed Davis  POR       PF     82    240  27          6
    ## 330              Evan Turner  POR       SF     79    220  28          6
    ## 331              Jake Layman  POR       SF     81    210  22          0
    ## 332             Jusuf Nurkic  POR        C     84    280  22          2
    ## 333         Maurice Harkless  POR       SF     81    215  23          4
    ## 334           Meyers Leonard  POR       PF     85    245  24          4
    ## 335              Noah Vonleh  POR       PF     82    240  21          2
    ## 336          Pat Connaughton  POR       SG     77    206  24          1
    ## 337           Shabazz Napier  POR       PG     73    175  25          2
    ## 338           Tim Quarterman  POR       SG     78    195  22          0
    ## 339         Danilo Gallinari  DEN       SF     82    225  28          7
    ## 340           Darrell Arthur  DEN       PF     81    235  28          7
    ## 341          Emmanuel Mudiay  DEN       PG     77    200  20          1
    ## 342              Gary Harris  DEN       SG     76    210  22          2
    ## 343             Jamal Murray  DEN       SG     76    207  19          0
    ## 344            Jameer Nelson  DEN       PG     72    190  34         12
    ## 345         Juan Hernangomez  DEN       PF     81    230  21          0
    ## 346           Kenneth Faried  DEN       PF     80    228  27          5
    ## 347            Malik Beasley  DEN       SG     77    196  20          0
    ## 348            Mason Plumlee  DEN        C     83    245  26          3
    ## 349              Mike Miller  DEN       SF     80    218  36         16
    ## 350             Nikola Jokic  DEN        C     82    250  21          1
    ## 351              Roy Hibbert  DEN        C     86    270  30          8
    ## 352              Will Barton  DEN       SG     78    175  26          4
    ## 353          Wilson Chandler  DEN       SF     80    225  29          8
    ## 354            Alexis Ajinca  NOP        C     86    248  28          6
    ## 355            Anthony Davis  NOP        C     82    253  23          4
    ## 356             Axel Toupane  NOP       SF     79    197  24          1
    ## 357            Cheick Diallo  NOP       PF     81    220  20          0
    ## 358         Dante Cunningham  NOP       SF     80    230  29          7
    ## 359         DeMarcus Cousins  NOP        C     83    270  26          6
    ## 360       Donatas Motiejunas  NOP       PF     84    222  26          4
    ## 361            E'Twaun Moore  NOP       SG     76    191  27          5
    ## 362          Jordan Crawford  NOP       SG     76    195  28          4
    ## 363             Jrue Holiday  NOP       PG     76    205  26          7
    ## 364                Omer Asik  NOP        C     84    255  30          6
    ## 365               Quinn Cook  NOP       PG     74    184  23          0
    ## 366             Solomon Hill  NOP       SF     79    225  25          3
    ## 367              Tim Frazier  NOP       PG     73    170  26          2
    ## 368             A.J. Hammons  DAL        C     84    260  24          0
    ## 369          DeAndre Liggins  DAL       SG     78    209  28          3
    ## 370             Devin Harris  DAL       PG     75    192  33         12
    ## 371            Dirk Nowitzki  DAL       PF     84    245  38         18
    ## 372      Dorian Finney-Smith  DAL       PF     80    220  23          0
    ## 373            Dwight Powell  DAL        C     83    240  25          2
    ## 374          Harrison Barnes  DAL       PF     80    210  24          4
    ## 375               J.J. Barea  DAL       PG     72    185  32         10
    ## 376            Jarrod Uthoff  DAL       PF     81    221  23          0
    ## 377             Nerlens Noel  DAL        C     83    228  22          2
    ## 378         Nicolas Brussino  DAL       SF     79    195  23          0
    ## 379              Salah Mejri  DAL        C     85    245  30          1
    ## 380               Seth Curry  DAL       PG     74    185  26          3
    ## 381          Wesley Matthews  DAL       SG     77    220  30          7
    ## 382             Yogi Ferrell  DAL       PG     72    180  23          0
    ## 383         Anthony Tolliver  SAC       PF     80    240  31          8
    ## 384            Arron Afflalo  SAC       SG     77    210  31          9
    ## 385             Ben McLemore  SAC       SG     77    195  23          3
    ## 386              Buddy Hield  SAC       SG     76    214  23          0
    ## 387          Darren Collison  SAC       PG     72    175  29          7
    ## 388           Garrett Temple  SAC       SG     78    195  30          6
    ## 389     Georgios Papagiannis  SAC        C     85    240  19          0
    ## 390             Kosta Koufos  SAC        C     84    265  27          8
    ## 391        Langston Galloway  SAC       PG     74    200  25          2
    ## 392       Malachi Richardson  SAC       SG     78    205  21          0
    ## 393                 Rudy Gay  SAC       SF     80    230  30         10
    ## 394          Skal Labissiere  SAC       PF     83    225  20          0
    ## 395                Ty Lawson  SAC       PG     71    195  29          7
    ## 396             Tyreke Evans  SAC       SF     78    220  27          7
    ## 397      Willie Cauley-Stein  SAC        C     84    240  23          1
    ## 398            Adreian Payne  MIN       PF     82    237  25          2
    ## 399           Andrew Wiggins  MIN       SF     80    199  21          2
    ## 400             Brandon Rush  MIN       SG     78    220  31          8
    ## 401             Cole Aldrich  MIN        C     83    250  28          6
    ## 402             Gorgui Dieng  MIN       PF     83    241  27          3
    ## 403              Jordan Hill  MIN        C     82    235  29          7
    ## 404       Karl-Anthony Towns  MIN        C     84    244  21          1
    ## 405                Kris Dunn  MIN       PG     76    210  22          0
    ## 406          Nemanja Bjelica  MIN       PF     82    240  28          1
    ## 407              Omri Casspi  MIN       SF     81    225  28          7
    ## 408              Ricky Rubio  MIN       PG     76    194  26          5
    ## 409         Shabazz Muhammad  MIN       SF     78    223  24          3
    ## 410               Tyus Jones  MIN       PG     74    195  20          1
    ## 411              Zach LaVine  MIN       SG     77    189  21          2
    ## 412           Brandon Ingram  LAL       SF     81    190  19          0
    ## 413             Corey Brewer  LAL       SF     81    186  30          9
    ## 414         D'Angelo Russell  LAL       PG     77    195  20          1
    ## 415              David Nwaba  LAL       SG     76    209  24          0
    ## 416              Ivica Zubac  LAL        C     85    265  19          0
    ## 417          Jordan Clarkson  LAL       SG     77    194  24          2
    ## 418            Julius Randle  LAL       PF     81    250  22          2
    ## 419          Larry Nance Jr.  LAL       PF     81    230  24          1
    ## 420                Luol Deng  LAL       SF     81    220  31         12
    ## 421        Metta World Peace  LAL       SF     78    260  37         16
    ## 422               Nick Young  LAL       SG     79    210  31          9
    ## 423              Tarik Black  LAL        C     81    250  25          2
    ## 424          Thomas Robinson  LAL       PF     82    237  25          4
    ## 425           Timofey Mozgov  LAL        C     85    275  30          6
    ## 426              Tyler Ennis  LAL       PG     75    194  22          2
    ## 427            Alan Williams  PHO        C     80    260  24          1
    ## 428                 Alex Len  PHO        C     85    260  23          3
    ## 429           Brandon Knight  PHO       SG     75    189  25          5
    ## 430            Derrick Jones  PHO       SF     79    190  19          0
    ## 431             Devin Booker  PHO       SG     78    206  20          1
    ## 432            Dragan Bender  PHO       PF     85    225  19          0
    ## 433           Elijah Millsap  PHO       SG     78    225  29          2
    ## 434             Eric Bledsoe  PHO       PG     73    190  27          6
    ## 435             Jared Dudley  PHO       PF     79    225  31          9
    ## 436          Leandro Barbosa  PHO       SG     75    194  34         13
    ## 437          Marquese Chriss  PHO       PF     82    233  19          0
    ## 438             Ronnie Price  PHO       PG     74    190  33         11
    ## 439              T.J. Warren  PHO       SF     80    230  23          2
    ## 441           Tyson Chandler  PHO        C     85    240  34         15
    ##                                                      college   salary
    ## 1                                      University of Florida 26540100
    ## 2                                                            12000000
    ## 3                              University of Texas at Austin  8269663
    ## 4                                   University of Notre Dame  1450000
    ## 5                                                             1410598
    ## 7                                       Marquette University  6286408
    ## 8                                     University of Kentucky  1825200
    ## 9                                   University of California  4743000
    ## 10                                                            5000000
    ## 11                                Louisiana State University  1223653
    ## 12                                        Gonzaga University  3094014
    ## 13                                 Oklahoma State University  3578880
    ## 14                                  University of Louisville  1906440
    ## 15                              University of North Carolina  8000000
    ## 16                                     University of Arizona  7806971
    ## 17                                           Duke University    18255
    ## 18                University of Illinois at Urbana-Champaign   259626
    ## 19                                     University of Arizona   268029
    ## 20                                                               5145
    ## 21                           Georgia Institute of Technology  9700000
    ## 22                                                           12800000
    ## 23                                       University of Miami  1551659
    ## 25                     University of California, Los Angeles 21165675
    ## 26                                      Creighton University  5239437
    ## 27                                           Duke University 17638063
    ## 28                                                           30963450
    ## 29                                     University of Arizona  2500000
    ## 30                             University of Texas at Austin 15330435
    ## 31                                                            1589640
    ## 32                             University of Texas at Austin  7330000
    ## 33                                        University of Utah  1577280
    ## 34                         University of Southern California 26540100
    ## 35                                    University of Missouri 14200000
    ## 36                                  Wichita State University   543471
    ## 37                                        University of Utah  2703960
    ## 38                                                           14382022
    ## 39                                      Villanova University 12000000
    ## 40                                                            1921320
    ## 41                     University of California, Los Angeles   874636
    ## 42                             University of Texas at Austin  5300000
    ## 43                               New Mexico State University  1196040
    ## 44                                    University of Kentucky  6050000
    ## 45                                                           12250000
    ## 46                                                            3730653
    ## 47                                     University of Florida 22116750
    ## 48                                                            1200000
    ## 49                                       Syracuse University  1191480
    ## 50                                      Villanova University   543471
    ## 51                                                           15944154
    ## 52                                 Colorado State University  5000000
    ## 53                                    University of Kentucky 16957900
    ## 54                                                           12000000
    ## 55                                      University of Kansas  7400000
    ## 56                                     Georgetown University  5893981
    ## 57                                       University of Miami   543471
    ## 58                                                            2870813
    ## 59                                    University of Michigan  3386598
    ## 60                                 Saint Joseph's University  1499760
    ## 61                                                            2708582
    ## 62                                                           23180275
    ## 63                                                            8400000
    ## 64                                                             392478
    ## 65                                   Old Dominion University 15730338
    ## 66                                   University of Minnesota  4000000
    ## 67       Virginia Polytechnic Institute and State University  2500000
    ## 68                                           Duke University  4837500
    ## 69                                       Bucknell University  1015696
    ## 70                                 Louisiana Tech University 20072033
    ## 71                                           Duke University   418228
    ## 72                                                            3850000
    ## 73                                    University of Michigan  2281605
    ## 74                                                            2995421
    ## 75                                     Georgetown University 17100000
    ## 76                                           Duke University  5374320
    ## 77                                     University of Arizona  1551659
    ## 78                              University of North Carolina 12517606
    ## 79                                      Texas A&M University 15200000
    ## 80                                    University of Virginia   925000
    ## 81                        Saint Mary's College of California  9607500
    ## 82                                   Kansas State University  1403611
    ## 83                                                           10500000
    ## 84                           University of Nevada, Las Vegas  1811040
    ## 85                                  University of Washington  6348759
    ## 86                                                            2568600
    ## 87                                  University of New Mexico  2368327
    ## 88                                      University of Oregon  2700000
    ## 89                                                           10230179
    ## 90                                                            4583450
    ## 91                                     Iowa State University   650000
    ## 92                                    Wake Forest University  8800000
    ## 93                                      University of Oregon  1052342
    ## 94                                                            1800000
    ## 95                                  University of Cincinnati  4000000
    ## 96                                         Temple University  4000000
    ## 97                                                           10770000
    ## 98                             University of Texas at Austin  2463840
    ## 99                       California State University, Fresno 18314532
    ## 100                                      Syracuse University  1052342
    ## 101                          Georgia Institute of Technology 14153652
    ## 102                          Georgia Institute of Technology  3488000
    ## 103                                   University of Arkansas  1453680
    ## 104                                  Murray State University  2112480
    ## 105                                                            874636
    ## 106                                Michigan State University  2092200
    ## 107                                     Marquette University 23200000
    ## 108                                  Murray State University  1015696
    ## 109                                 University of Notre Dame  1643040
    ## 110                                     Marquette University 17552209
    ## 111                                                           1709720
    ## 112                                      Syracuse University  3183526
    ## 113                                                           5782450
    ## 114                                                            750000
    ## 115                                   University of Kentucky 14000000
    ## 116                                      Stanford University 13219250
    ## 117                                      Syracuse University  2898000
    ## 118                                                          15890000
    ## 119                                      Marshall University 22116750
    ## 120                                   Wake Forest University  4000000
    ## 121                                          Duke University  5782450
    ## 122                                  University of Tennessee   874636
    ## 123                                          Duke University  2593440
    ## 124                               University of Nevada, Reno  1227000
    ## 125                                 Florida State University   210995
    ## 126                                  Kansas State University   543471
    ## 127                      California State University, Fresno  5628000
    ## 128                                    University of Florida  4000000
    ## 129                             University of North Carolina  6000000
    ## 130                                   Saint Louis University  1015696
    ## 131                                University of Connecticut 22116750
    ## 132                              Washington State University  6500000
    ## 133                                                           1551659
    ## 134                                                           7000000
    ## 135                                     Villanova University   874060
    ## 136                                     Marquette University  1704120
    ## 137                                   Wake Forest University  6000000
    ## 138                                  University of Wisconsin 10991957
    ## 139                                    University of Georgia  3678319
    ## 140                                     University of Kansas  4625000
    ## 141                                      Syracuse University   650000
    ## 142                             University of North Carolina  2255644
    ## 143                                           Boston College 14956522
    ## 144                                    University of Arizona  2969880
    ## 145                                  University of Tennessee 17200000
    ## 146                                     University of Dayton  1050961
    ## 147                         Virginia Commonwealth University   102898
    ## 148                          University of Nevada, Las Vegas   874636
    ## 149                                       Indiana University  5318313
    ## 150                                  University of Wisconsin  2730000
    ## 151                                University of Connecticut  6511628
    ## 152                               Louisiana State University   161483
    ## 153                                University of Connecticut 12000000
    ## 154                                                           6333333
    ## 155                             University of North Carolina 12250000
    ## 156                                   University of Kentucky 13000000
    ## 157                                          Duke University 12500000
    ## 158                                                          20869566
    ## 159                               University of Nevada, Reno  6000000
    ## 160                         Virginia Commonwealth University   543471
    ## 161                                      Syracuse University 24559380
    ## 162                                      Stanford University   143860
    ## 163                              Western Kentucky University 11242000
    ## 164                                    University of Memphis 21323250
    ## 165                                    University of Florida 17000000
    ## 166                                 University of Washington  1015696
    ## 167                                                           4317720
    ## 168                                 Norfolk State University  3900000
    ## 169                                          Duke University  6191000
    ## 170                                          Duke University   543471
    ## 171                                          Ohio University   543471
    ## 172                                                           2898000
    ## 173                                 Wichita State University   543471
    ## 174                                                           1410598
    ## 175                                                           1375000
    ## 176                                    University of Arizona  4351320
    ## 177                                                          17000000
    ## 178                                  University of Tennessee  5000000
    ## 179                            University of Texas at Austin  7250000
    ## 180                                                            980431
    ## 181                     University of Louisiana at Lafayette  2613600
    ## 182                                                          17000000
    ## 183                                    Georgetown University 15000000
    ## 184                                   University of Kentucky  6540000
    ## 185                          Georgia Institute of Technology    31969
    ## 186                                                           3909840
    ## 187                        University of Southern California 11750000
    ## 188                             George Washington University    31969
    ## 189                          University of Nevada, Las Vegas   950000
    ## 190                                 University of Washington 10000000
    ## 191                                   University of Kentucky    31969
    ## 192                                                           2318280
    ## 193                                          Duke University  9000000
    ## 194                                          Duke University  4788840
    ## 195                                    University of Arizona  9424084
    ## 196                                     University of Kansas  4826160
    ## 197                                   University of Virginia  1514160
    ## 198                                   University of Michigan  2993040
    ## 199                           Bowling Green State University  1025831
    ## 200                               Tennessee State University  1015696
    ## 201                                                           8000000
    ## 202                     University of Louisiana at Lafayette    89513
    ## 203                                    University of Arizona   874636
    ## 204                                                           8550000
    ## 205                                                           1326960
    ## 206                               St. Bonaventure University  6088993
    ## 207                                   University of Kentucky   119494
    ## 208                                      Stanford University 21165675
    ## 209                                   University of Michigan  1562280
    ## 210                                    Seton Hall University  1074145
    ## 211                                       Harvard University 11483254
    ## 212                                   University of Virginia   980431
    ## 213                               Louisiana State University  3000000
    ## 214                                       Clemson University  3333333
    ## 215                                        Baylor University  1790902
    ## 216                                     Villanova University  2500000
    ## 217                                    University of Arizona  1395600
    ## 218                                 University of Cincinnati   980431
    ## 219                                   University of Colorado   726672
    ## 220                                       Clemson University  9250000
    ## 221                                    University of Arizona 11131368
    ## 222                                    Vanderbilt University  1171560
    ## 223                                        Xavier University  1551659
    ## 224                                Michigan State University 15330435
    ## 225                                       Belmont University  1015696
    ## 226                             University of North Carolina   980431
    ## 227                               University of Nevada, Reno  1403611
    ## 228                            University of Texas at Austin 26540100
    ## 229                    University of California, Los Angeles  1182840
    ## 230                              Washington State University 16663575
    ## 231                    University of California, Los Angeles   383351
    ## 232                          University of Nevada, Las Vegas   543471
    ## 233                                                           5782450
    ## 234                                         Davidson College 12112359
    ## 235                                                           2898000
    ## 236                                Michigan State University   543471
    ## 237                             University of North Carolina 10000000
    ## 238                                    University of Florida  1551659
    ## 239                                                            543471
    ## 240                                 University of Washington  1180080
    ## 241                        University of Southern California  2898000
    ## 242                          University of Nevada, Las Vegas   165952
    ## 243                                    University of Houston   874636
    ## 244                               San Diego State University 17638063
    ## 245                    University of California, Los Angeles  1192080
    ## 246                            University of Texas at Austin 20575005
    ## 247                                                          14000000
    ## 248                       Saint Mary's College of California  3578948
    ## 249                                                          15500000
    ## 250                                                          14445313
    ## 251                   California State University, Fullerton   680534
    ## 252                                 University of Louisville   543471
    ## 253                                                           1296240
    ## 254                                       Indiana University 12385364
    ## 255                            University of Texas at Austin   255000
    ## 256                                 Arizona State University 26540100
    ## 257                                       Gonzaga University   543471
    ## 258                                                           7000000
    ## 259                                 University of Louisville  1000000
    ## 260                                   University of Arkansas  6000000
    ## 261                                 University of California 18735364
    ## 262                                  University of Wisconsin  1720560
    ## 263                    University of California, Los Angeles  7806971
    ## 264                                       Indiana University   150000
    ## 265                                Michigan State University  1315448
    ## 266                                          Duke University 11000000
    ## 267                                   University of Oklahoma 20140838
    ## 268                               Louisiana State University  1551659
    ## 269                             University of North Carolina  1273920
    ## 270                                   Wake Forest University 22868828
    ## 271                                     Texas A&M University 21165675
    ## 272                                   University of Maryland   543471
    ## 273                                          Duke University  7377500
    ## 274                                   University of Michigan 13253012
    ## 275                    University of California, Los Angeles  2203000
    ## 276                                    University of Florida  1403611
    ## 277                                     University of Kansas  3500000
    ## 278                             University of North Carolina  1551659
    ## 279                                      Syracuse University  5628000
    ## 280                                   University of Colorado 10154495
    ## 281                                                           7000000
    ## 282                                                           3940320
    ## 283                          Georgia Institute of Technology 11050000
    ## 284        Indiana University-Purdue University Indianapolis  8000000
    ## 285                                        Butler University 16073140
    ## 286                                     University of Kansas  1015696
    ## 287                                                           2250000
    ## 288                                   University of Arkansas 11000000
    ## 289                                   Weber State University   600000
    ## 290                                                            937800
    ## 291                                          Duke University  1406520
    ## 292                                                           2121288
    ## 293                                        Butler University  2433334
    ## 294                                   University of Kentucky  2340600
    ## 295                                                           5994764
    ## 296                                   University of Colorado  2183072
    ## 297                                       Gonzaga University  2440200
    ## 298                                     Creighton University  2483040
    ## 299                                                          17145838
    ## 300                                      Syracuse University   980431
    ## 301                                      Stanford University  1191480
    ## 302                                          Duke University  4837500
    ## 303                                     University of Kansas  3750000
    ## 304                               Cleveland State University   247991
    ## 305                    University of California, Los Angeles 26540100
    ## 306                                        Xavier University   543471
    ## 307                                 University of Pittsburgh  3140517
    ## 308                        University of Southern California  8950000
    ## 309                                       Indiana University  6552960
    ## 310                                   University of Kentucky   945000
    ## 311                             University of North Carolina  5700000
    ## 312                                    University of Florida 22116750
    ## 313                                Michigan State University  1369229
    ## 314                  California State University, Long Beach  2898000
    ## 315                                    University of Alabama   980431
    ## 316                               Louisiana State University  1286160
    ## 317                                                          21165675
    ## 318                                    Ohio State University 26540100
    ## 319                                Oklahoma State University  5505618
    ## 320                         Virginia Commonwealth University  3332940
    ## 321                             University of North Carolina  4264057
    ## 322                                    Vanderbilt University  1793760
    ## 323                                     University of Kansas    83119
    ## 324                                Michigan State University 10361445
    ## 325                                   Wake Forest University  7680965
    ## 326                                 University of California 18500000
    ## 327                                        Lehigh University  3219579
    ## 328                                   Weber State University 24328425
    ## 329                             University of North Carolina  6666667
    ## 330                                    Ohio State University 16393443
    ## 331                                   University of Maryland   600000
    ## 332                                                           1921320
    ## 333                                    St. John's University  8988764
    ## 334               University of Illinois at Urbana-Champaign  9213484
    ## 335                                       Indiana University  2751360
    ## 336                                 University of Notre Dame   874636
    ## 337                                University of Connecticut  1350120
    ## 338                               Louisiana State University   543471
    ## 339                                                          15050000
    ## 340                                     University of Kansas  8070175
    ## 341                                                           3241800
    ## 342                                Michigan State University  1655880
    ## 343                                   University of Kentucky  3210840
    ## 344                                Saint Joseph's University  4540525
    ## 345                                                           1987440
    ## 346                                Morehead State University 12078652
    ## 347                                 Florida State University  1627320
    ## 348                                          Duke University  2328530
    ## 349                                    University of Florida  3500000
    ## 350                                                           1358500
    ## 351                                    Georgetown University  5000000
    ## 352                                    University of Memphis  3533333
    ## 353                                        DePaul University 11200000
    ## 354                                                           4600000
    ## 355                                   University of Kentucky 22116750
    ## 356                                                             20580
    ## 357                                     University of Kansas   543471
    ## 358                                     Villanova University  2978250
    ## 359                                   University of Kentucky 16957900
    ## 360                                                            576724
    ## 361                                        Purdue University  8081363
    ## 362                                        Xavier University   173094
    ## 363                    University of California, Los Angeles 11286518
    ## 364                                                           9904494
    ## 365                                          Duke University    63938
    ## 366                                    University of Arizona 11241218
    ## 367                            Pennsylvania State University  2090000
    ## 368                                        Purdue University   650000
    ## 369                                   University of Kentucky  1015696
    ## 370                                  University of Wisconsin  4228000
    ## 371                                                          25000000
    ## 372                                    University of Florida   543471
    ## 373                                      Stanford University  8375000
    ## 374                             University of North Carolina 22116750
    ## 375                                  Northeastern University  4096950
    ## 376                                       University of Iowa    63938
    ## 377                                   University of Kentucky  4384490
    ## 378                                                            543471
    ## 379                                                            874636
    ## 380                                          Duke University  2898000
    ## 381                                     Marquette University 17100000
    ## 382                                       Indiana University   207798
    ## 383                                     Creighton University  8000000
    ## 384                    University of California, Los Angeles 12500000
    ## 385                                     University of Kansas  4008882
    ## 386                                   University of Oklahoma  3517200
    ## 387                    University of California, Los Angeles  5229454
    ## 388                               Louisiana State University  8000000
    ## 389                                                           2202240
    ## 390                                    Ohio State University  8046500
    ## 391                                Saint Joseph's University  5200000
    ## 392                                      Syracuse University  1439880
    ## 393                                University of Connecticut 13333333
    ## 394                                   University of Kentucky  1188840
    ## 395                             University of North Carolina  1315448
    ## 396                                    University of Memphis 10661286
    ## 397                                   University of Kentucky  3551160
    ## 398                                Michigan State University  2022240
    ## 399                                     University of Kansas  6006600
    ## 400                                     University of Kansas  3500000
    ## 401                                     University of Kansas  7643979
    ## 402                                 University of Louisville  2348783
    ## 403                                    University of Arizona  3911380
    ## 404                                   University of Kentucky  5960160
    ## 405                                       Providence College  3872520
    ## 406                                                           3800000
    ## 407                                                            138414
    ## 408                                                          13550000
    ## 409                    University of California, Los Angeles  3046299
    ## 410                                          Duke University  1339680
    ## 411                    University of California, Los Angeles  2240880
    ## 412                                          Duke University  5281680
    ## 413                                    University of Florida  7600000
    ## 414                                    Ohio State University  5332800
    ## 415 California Polytechnic State University, San Luis Obispo    73528
    ## 416                                                           1034956
    ## 417                                   University of Missouri 12500000
    ## 418                                   University of Kentucky  3267120
    ## 419                                    University of Wyoming  1207680
    ## 420                                          Duke University 18000000
    ## 421                                    St. John's University  1551659
    ## 422                        University of Southern California  5443918
    ## 423                                     University of Kansas  6191000
    ## 424                                     University of Kansas  1050961
    ## 425                                                          16000000
    ## 426                                      Syracuse University  1733880
    ## 427                  University of California, Santa Barbara   874636
    ## 428                                   University of Maryland  4823621
    ## 429                                   University of Kentucky 12606250
    ## 430                          University of Nevada, Las Vegas   543471
    ## 431                                   University of Kentucky  2223600
    ## 432                                                           4276320
    ## 433                      University of Alabama at Birmingham    23069
    ## 434                                   University of Kentucky 14000000
    ## 435                                           Boston College 10470000
    ## 436                                                           4000000
    ## 437                                 University of Washington  2941440
    ## 438                                Utah Valley State College   282595
    ## 439                          North Carolina State University  2128920
    ## 441                                                          12415000
    ##     games minutes points points3 points2 points1
    ## 1      68    2193    952      86     293     108
    ## 2      80    1608    520      27     186      67
    ## 3      55    1835    894     108     251      68
    ## 4       5      17     10       1       2       3
    ## 5      47     538    262      39      56      33
    ## 7      72    2335    999     157     176     176
    ## 8      29     220     68      12      13       6
    ## 9      78    1341    515      46     146      85
    ## 10     78    1232    299      45      69      26
    ## 11     25     141     38       0      15       8
    ## 12     75    1538    678      68     192      90
    ## 13     79    2399    835      94     175     203
    ## 14     74    1263    410      57      94      51
    ## 15     51     525    178       0      78      22
    ## 16     74    1398    676     137     101      63
    ## 17      1      12      9       0       3       3
    ## 18     24     486    179      22      46      21
    ## 19     25     427    156      21      33      27
    ## 20      1      24      6       0       3       0
    ## 21     76    1937    567      94     107      71
    ## 22     41    1187    351      95      28      10
    ## 23     48     381    132      31      13      13
    ## 25     60    1885   1142     145     225     257
    ## 26     35     859    373      97      34      14
    ## 27     72    2525   1816     177     494     297
    ## 28     74    2794   1954     124     612     358
    ## 29     79    1614    448      62      91      80
    ## 30     78    2336    630       0     262     106
    ## 31      9      40     14       2       4       0
    ## 32     80    2003    740      48     251      94
    ## 33     27     446    150      10      39      42
    ## 34     74    2620   2020      33     688     545
    ## 35     72    1882    638     109     111      89
    ## 36     37     294    107      11      28      18
    ## 37     54     626    165       0      67      31
    ## 38     80    2066    959       1     390     176
    ## 39     60    2244   1344     193     233     299
    ## 40     57    1088    253       3     100      44
    ## 41     76    1368    636      56     171     126
    ## 42     24     609    139      24      28      11
    ## 43     55     859    229       1     102      22
    ## 44     65    1599    445      94      60      43
    ## 45     23     712    327      41      87      30
    ## 46     26     601    330      45      62      71
    ## 47     77    2684   1779     223     414     282
    ## 48     23     374     81      11      18      12
    ## 49      2       8      1       0       0       1
    ## 50     19      75     24       0      12       0
    ## 51     31     555    173       0      65      43
    ## 52     74    1068    420      37     137      35
    ## 53     78    2836   1805      89     558     422
    ## 54     82    2556    883       0     390     103
    ## 55     76    2374   1063      71     335     180
    ## 56     80    2605   1075     148     266      99
    ## 57     30     287     90       7      23      23
    ## 58     57     719    154       9      52      23
    ## 59     57     703    285      31      85      22
    ## 60     38     371    101       1      46       6
    ## 61     79    2485   1414     100     448     218
    ## 62     74    2199   1002       0     388     226
    ## 63     26     633    270      32      61      52
    ## 64     17     247     61       8      15       7
    ## 65     73    1963    801      92     203     119
    ## 66     56     689    257      19      68      64
    ## 67     73    1248    391      26     119      75
    ## 68     30     475    169      33      24      22
    ## 69     70    1237    435      46     124      49
    ## 70     69    2343   1246      75     355     311
    ## 71     16     110     25       4       4       5
    ## 72     62    1596    444      41     133      55
    ## 73     79    2154   1143     149     266     164
    ## 74     80    2845   1832      49     607     471
    ## 75     81    1823    951       0     387     177
    ## 76     51    1728   1025      65     334     162
    ## 77     74    1365    307      73      32      24
    ## 78     58    1123    392       0     159      74
    ## 79     29     889    426      45     105      81
    ## 80     75    1982    767      78     212     109
    ## 81     76    1986    577      79     129      82
    ## 82     56     935    528      18     198      78
    ## 83     70    1133    451     104      52      35
    ## 84     41     458    142      26      31       2
    ## 85     19     171     83       9      21      14
    ## 86     57     562    226      28      55      32
    ## 87     80    2336    683     144     102      47
    ## 88     65     894    322      48      73      32
    ## 89     66     931    535       0     235      65
    ## 90     76    1776    815     169     112      84
    ## 91     23      93     21       1       8       2
    ## 92     82    2657   1254      90     312     360
    ## 93     33     135     68       5      21      11
    ## 94     49     559    232       0     109      14
    ## 95      6     132     43       5      13       2
    ## 96     61     871    177       0      77      23
    ## 97     74    1998    630      43     204      93
    ## 98     81    2541   1173      40     404     245
    ## 99     75    2689   1775     195     427     336
    ## 100    29     219     59       0      19      21
    ## 101    74    2237    814      45     317      45
    ## 102     9      87     41       6       6      11
    ## 103    64    1000    437      32     151      39
    ## 104    11     142     54      11      10       1
    ## 105    66    1040    316       0     128      60
    ## 106    57     976    291      73      29      14
    ## 107    60    1792   1096      45     369     223
    ## 108    39     592    181      25      38      30
    ## 109    63    1028    370      49      79      65
    ## 110    76    2809   1816      91     479     585
    ## 111    20     241     89       6      31       9
    ## 112    45     846    297      15      97      58
    ## 113    70    1679    744     129     129      99
    ## 114    44     843    240      33      55      31
    ## 115    69    1843    538      50     179      30
    ## 116    81    2271    839       0     382      75
    ## 117    46    1384    729      85     196      82
    ## 118    73    2459   1483     117     417     298
    ## 119    77    2513   1309       0     542     225
    ## 120    76    2085    975      87     281     152
    ## 121    22     381    107      13      31       6
    ## 122    53    1614    539      75     127      60
    ## 123    18     625    196       7      73      29
    ## 124    68    1065    324      87      26      11
    ## 125    35     471     98      12      21      20
    ## 126    78    1966    497      73     117      44
    ## 127    73    2178   1002      93     264     195
    ## 128    17     130     31       0      11       9
    ## 129    62    1500    648     149      82      37
    ## 130    71    1031    374       1     161      49
    ## 131    81    2409   1105       2     481     137
    ## 132    75    1163    365       0     143      79
    ## 133    39     560    227      11      81      32
    ## 134    35     293    191       0      72      47
    ## 135    39     381    127      12      35      21
    ## 136    19     146     60      10      13       4
    ## 137    81    1955    758      28     301      72
    ## 138    75    1944    767      49     261      98
    ## 139    76    2529   1047     153     217     154
    ## 140    79    2565   1105     118     303     145
    ## 141     9      32      4       0       1       2
    ## 142    31     467    141      28      26       5
    ## 143    52    1424    752      66     218     118
    ## 144    77    1371    339      45      84      36
    ## 145    82    2567   1321     109     402     190
    ## 146    41     416    142      17      29      33
    ## 147    13     159     50       1      19       9
    ## 148    13     107     35       0      12      11
    ## 149    62    1725    639       0     253     133
    ## 150    75    1954    874     116     204     118
    ## 151    62    1143    603      41     185     110
    ## 152     4      34     18       1       7       1
    ## 153    79    2739   1830     240     403     304
    ## 154    74    1778    780     102     162     150
    ## 155    76    2295    849     124     173     131
    ## 156    81    2349    743       1     294     152
    ## 157    13     174     31       0      14       3
    ## 158    77    2617   1164     135     258     243
    ## 159    50     811    312      21      79      91
    ## 160    27     189     57       9      10      10
    ## 161    74    2538   1659     151     451     304
    ## 162    18     225     95      10      18      29
    ## 163    77    2459    835     108     213      85
    ## 164    64    2082   1154      13     447     221
    ## 165    46    1015    232       0      99      34
    ## 166    82    1639    629      97     136      66
    ## 167    66    2164   1196     112     331     198
    ## 168    79    1229    496       2     213      64
    ## 169    46     968    275      38      59      43
    ## 170    21     170     40       0      16       8
    ## 171    32     331     98       1      38      19
    ## 172    68    1016    425      54     104      55
    ## 173    52     857    215      23      59      28
    ## 174    42     408    124      23      19      17
    ## 175    72    1324    587       4     242      91
    ## 176    80    2298   1019      77     316     156
    ## 177    81    1793    483       0     179     125
    ## 178    62    1012    281      32      64      57
    ## 179    78    1538    616      95     100     131
    ## 180    45     314     82      20      11       0
    ## 181    82    2412   1046      40     390     146
    ## 182    68    2234   1167     128     280     223
    ## 183    69    1534    638      53     167     145
    ## 184    36     738    327      56      47      65
    ## 185     5      48     14       1       1       9
    ## 186    65     960    317      43      74      40
    ## 187    75    2163   1096      23     460     107
    ## 188     5      43      0       0       0       0
    ## 189    19     108     23       0      10       3
    ## 190    24     748    299      46      69      23
    ## 191     6     157     64       6      19       8
    ## 192    81    2129   1040     106     275     172
    ## 193    72    1667    662      61     173     133
    ## 194    50    1134    590       0     242     106
    ## 195     3      71     33       2       9       9
    ## 196    31     786    627      36     164     191
    ## 197    24     518    203      21      54      32
    ## 198    80    2188    756     132     119     122
    ## 199    57    1193    559      27     203      72
    ## 200    67    2119    864     137     155     143
    ## 201    68    1518    530      92     118      18
    ## 202    18     234    148       7      54      19
    ## 203    81    2133    556      11     225      73
    ## 204     8      76     39       2      12       9
    ## 205    69    1190    445      50      95     105
    ## 206    10     111     30       2      11       2
    ## 207    12     184     95       4      30      23
    ## 208    75    2222   1539     134     421     295
    ## 209    57    1237    468      59     112      67
    ## 210    73    1643    543      44     160      91
    ## 211    36     883    523      58     117     115
    ## 212    52    1138    428      85      69      35
    ## 213    64    1177    442      55     119      39
    ## 214    20     293    126      11      35      23
    ## 215    32     510    209      36      29      43
    ## 216    69    1284    357      67      51      54
    ## 217    78    1761    675      15     220     190
    ## 218    70    1754    919     105     200     204
    ## 219    59    1334    432      38      96     126
    ## 220    71    1754    709      25     280      74
    ## 221    76    1998    574      64     155      72
    ## 222    10      85     19       0       8       3
    ## 223    68     854    316       3     132      43
    ## 224    76    2471    776      81     191     151
    ## 225    77    1137    527      61     150      44
    ## 226    52     457    147       2      60      21
    ## 227    77     739    472       0     208      56
    ## 228    62    2070   1555     117     434     336
    ## 229    53     447    135       2      54      21
    ## 230    78    2649   1742     268     376     186
    ## 231    20     410    114      18      20      20
    ## 232    71    1074    282      41      65      29
    ## 233    76    1345    389       1     172      42
    ## 234    79    2638   1999     324     351     325
    ## 235    70    1268    426       0     164      98
    ## 236    36     285     94      17      19       5
    ## 237    68    1807    497     118      58      27
    ## 238    79    1477    576       0     248      80
    ## 239    67     808    303      69      34      28
    ## 240    38     322    130       9      41      21
    ## 241    76    1330    387       0     161      65
    ## 242    19     122     25       0      10       5
    ## 243    78    1392    483      30     147      99
    ## 244    74    2474   1888     147     489     469
    ## 245    72    1020    246      15      78      45
    ## 246    72    2335   1243      23     477     220
    ## 247    69    1291    517      89      82      86
    ## 248    80    1754    759     147     126      66
    ## 249    64    1627    792      56     247     130
    ## 250    63    1587    638      23     242      85
    ## 251    25     123     62      14       9       2
    ## 252     5      52     14       0       5       4
    ## 253    65    1551    818       0     362      94
    ## 254    75    2323   1217     246     166     147
    ## 255     4      52      3       0       1       1
    ## 256    81    2947   2356     262     412     746
    ## 257    14      44     13       4       0       1
    ## 258    23     591    343      41      61      98
    ## 259    58    1064    527       1     224      76
    ## 260    67    2058    639     110     118      73
    ## 261    72    2116    979     204     119     129
    ## 262    77    1419    504      60     143      38
    ## 263    80    2773    936     191     135      93
    ## 264     6     139     58       8      14       6
    ## 265    30     308     86      14      16      12
    ## 266    74    2054    889     111     212     132
    ## 267    61    2076   1316      38     441     320
    ## 268    52     577    292       1     106      77
    ## 269     3       9      4       0       2       0
    ## 270    61    1921   1104     124     250     232
    ## 271    81    2570   1029       0     412     205
    ## 272     7      24     10       0       3       4
    ## 273    78    2198   1173     201     195     180
    ## 274    82    2157   1008     116     243     174
    ## 275    80    1787    484      43     148      59
    ## 276    82    1286    711     103     141     120
    ## 277    25     277     81      15      13      10
    ## 278    80    1700    538      46     175      50
    ## 279    68     810    186      29      44      11
    ## 280    42     653    283      25      74      60
    ## 281    73    1283    338      20     126      26
    ## 282    66    1228    412      44     111      58
    ## 283    50    1186    476       3     200      67
    ## 284    49    1544    829      94     195     157
    ## 285    73    2516   1601     149     396     362
    ## 286    51     432    146       0      55      36
    ## 287    82    1972    581     123      81      50
    ## 288    78    1843    715     106     167      63
    ## 289    12      53     22       1       8       3
    ## 290    40     346    100      10      31       8
    ## 291    59    1593    748     114     158      90
    ## 292    81    2744   1137       0     413     311
    ## 293    55    1205    430      37     133      53
    ## 294    71    1158    440      65      94      57
    ## 295    68    1055    406      94      40      44
    ## 296    79    2376    522      45     170      47
    ## 297    81    1632    479      51     141      44
    ## 298    22     430    145      21      35      12
    ## 299    72    1533   1033       5     397     224
    ## 300    78    1490    421      43     103      86
    ## 301     2      31     14       2       4       0
    ## 302    32     385     88       7      27      13
    ## 303    20     128     33       0      14       5
    ## 304    13     125     43       3      13       8
    ## 305    81    2802   2558     200     624     710
    ## 306    64     973    183      12      65      17
    ## 307    80    2389    905       0     374     157
    ## 308    23     487    207       1      88      28
    ## 309    67    2222   1067     127     285     116
    ## 310    72    1474    425      43      74     148
    ## 311    28     447    189       0      83      23
    ## 312    34     675    210      25      50      35
    ## 313    36     238     58       0      24      10
    ## 314    64    1501    429      51      95      86
    ## 315    77    2101    689      55     195     134
    ## 316    42     558    165       9      49      40
    ## 317    74    2531   1446     104     428     278
    ## 318    69    2292   1415     171     293     316
    ## 319    71    1914    643      15     259      80
    ## 320    67    1183    551     138      47      43
    ## 321    73    1799    586     112      81      88
    ## 322    33     405    106       3      33      31
    ## 323    11     189     55       3      17      12
    ## 324    73    1786   1028      21     412     141
    ## 325    61    1773    532      70     113      96
    ## 326    79    2254    845     134     169     105
    ## 327    80    2796   1837     185     507     268
    ## 328    75    2694   2024     214     447     488
    ## 329    46     789    200       0      75      50
    ## 330    65    1658    586      31     204      85
    ## 331    35     249     78      13      13      13
    ## 332    20     584    304       0     120      64
    ## 333    77    2223    773      68     246      77
    ## 334    74    1222    401      74      72      35
    ## 335    74    1265    327       7     123      60
    ## 336    39     316     98      17      20       7
    ## 337    53     512    218      34      39      38
    ## 338    16      80     31       5       8       0
    ## 339    63    2134   1145     126     209     349
    ## 340    41     639    262      53      42      19
    ## 341    55    1406    603      56     152     131
    ## 342    57    1782    851     107     213     104
    ## 343    82    1764    811     115     180     106
    ## 344    75    2045    687     106     162      45
    ## 345    62     842    305      46      55      57
    ## 346    61    1296    587       0     228     131
    ## 347    22     165     83       9      24       8
    ## 348    27     632    245       0      99      47
    ## 349    20     151     28       8       1       2
    ## 350    73    2038   1221      45     449     188
    ## 351     6      11      4       0       2       0
    ## 352    60    1705    820      87     208     143
    ## 353    71    2197   1117     110     323     141
    ## 354    39     584    207       0      89      29
    ## 355    75    2708   2099      40     730     519
    ## 356     2      41     11       1       4       0
    ## 357    17     199     87       0      36      15
    ## 358    66    1649    435      71     103      16
    ## 359    17     574    414      36     106      94
    ## 360    34     479    150      11      46      25
    ## 361    73    1820    700      77     206      57
    ## 362    19     442    267      37      68      20
    ## 363    67    2190   1029     100     305     119
    ## 364    31     482     85       0      31      23
    ## 365     9     111     52       6      16       2
    ## 366    80    2374    563      94      89     103
    ## 367    65    1525    464      40     123      98
    ## 368    22     163     48       5      12       9
    ## 369     1      25      8       0       3       2
    ## 370    65    1087    437      58      78     107
    ## 371    54    1424    769      79     217      98
    ## 372    81    1642    350      56      68      46
    ## 373    77    1333    516      21     173     107
    ## 374    79    2803   1518      78     521     242
    ## 375    35     771    381      53      89      44
    ## 376     9     115     40       3      13       5
    ## 377    22     483    188       0      77      34
    ## 378    54     521    150      29      23      17
    ## 379    73     905    213       1      87      36
    ## 380    70    2029    898     137     201      85
    ## 381    73    2495    986     174     159     146
    ## 382    36    1046    408      60      82      64
    ## 383    65    1477    461      90      65      61
    ## 384    61    1580    515      62     123      83
    ## 385    61    1176    495      65     115      70
    ## 386    25     727    378      59      83      35
    ## 387    68    2063    900      73     267     147
    ## 388    65    1728    506      82     101      58
    ## 389    22     355    124       0      56      12
    ## 390    71    1419    470       0     216      38
    ## 391    19     375    114      19      23      11
    ## 392    22     198     79       8      20      15
    ## 393    30    1013    562      42     159     118
    ## 394    33     612    289       3     114      52
    ## 395    69    1732    681      34     203     173
    ## 396    14     314    163      21      38      24
    ## 397    75    1421    611       0     255     101
    ## 398    18     135     63       3      20      14
    ## 399    82    3048   1933     103     606     412
    ## 400    47    1030    197      44      26      13
    ## 401    62     531    105       0      45      15
    ## 402    82    2653    816      16     316     136
    ## 403     7      47     12       0       5       2
    ## 404    82    3030   2061     101     701     356
    ## 405    78    1333    293      21      97      36
    ## 406    65    1190    403      56      95      45
    ## 407    13     222     45       2      17       5
    ## 408    75    2469    836      60     201     254
    ## 409    78    1516    772      49     239     147
    ## 410    60     774    209      26      49      33
    ## 411    47    1749    889     120     206     117
    ## 412    79    2279    740      55     221     133
    ## 413    24     358    129       5      48      18
    ## 414    63    1811    984     135     216     147
    ## 415    20     397    120       1      46      25
    ## 416    38     609    284       0     126      32
    ## 417    82    2397   1205     117     360     134
    ## 418    74    2132    975      17     360     204
    ## 419    63    1442    449      10     180      59
    ## 420    56    1486    425      51     113      46
    ## 421    25     160     57       9      10      10
    ## 422    60    1556    791     170     102      77
    ## 423    67    1091    383       1     149      82
    ## 424    48     560    241       0     105      31
    ## 425    54    1104    401       0     169      63
    ## 426    22     392    170      21      44      19
    ## 427    47     708    346       0     138      70
    ## 428    77    1560    613       3     227     150
    ## 429    54    1140    595      45     164     132
    ## 430    32     545    168       3      65      29
    ## 431    78    2730   1726     147     459     367
    ## 432    43     574    146      28      29       4
    ## 433     2      23      3       0       1       1
    ## 434    66    2176   1390     104     345     388
    ## 435    64    1362    434      77      80      43
    ## 436    67     963    419      35     137      40
    ## 437    82    1743    753      72     212     113
    ## 438    14     134     14       3       1       3
    ## 439    66    2048    951      26     377     119
    ## 441    47    1298    397       0     153      91

-   Of those players that are centers (position `C`), display their names and salaries.

``` r
dat[dat$position == "C", c(1, 9)]
```

    ##                   player   salary
    ## 1             Al Horford 26540100
    ## 12          Kelly Olynyk  3094014
    ## 15          Tyler Zeller  8000000
    ## 16         Channing Frye  7806971
    ## 20           Edy Tavares     5145
    ## 30      Tristan Thompson 15330435
    ## 37          Jakob Poeltl  2703960
    ## 38     Jonas Valanciunas 14382022
    ## 40        Lucas Nogueira  1921320
    ## 50         Daniel Ochefu   543471
    ## 51           Ian Mahinmi 15944154
    ## 52           Jason Smith  5000000
    ## 54         Marcin Gortat 12000000
    ## 62         Dwight Howard 23180275
    ## 69          Mike Muscala  1015696
    ## 75           Greg Monroe 17100000
    ## 78           John Henson 12517606
    ## 86            Thon Maker  2568600
    ## 89          Al Jefferson 10230179
    ## 98          Myles Turner  2463840
    ## 105    Cristiano Felicio   874636
    ## 111    Joffrey Lauvergne  1709720
    ## 116          Robin Lopez 13219250
    ## 119     Hassan Whiteside 22116750
    ## 128        Udonis Haslem  4000000
    ## 130          Willie Reed  1015696
    ## 131       Andre Drummond 22116750
    ## 132          Aron Baynes  6500000
    ## 134     Boban Marjanovic  7000000
    ## 150       Frank Kaminsky  2730000
    ## 157        Miles Plumlee 12500000
    ## 165          Joakim Noah 17000000
    ## 168         Kyle O'Quinn  3900000
    ## 170     Marshall Plumlee   543471
    ## 175    Willy Hernangomez  1375000
    ## 177      Bismack Biyombo 17000000
    ## 187       Nikola Vucevic 11750000
    ## 189    Stephen Zimmerman   950000
    ## 194        Jahlil Okafor  4788840
    ## 196          Joel Embiid  4826160
    ## 199       Richaun Holmes  1025831
    ## 202           Shawn Long    89513
    ## 204       Tiago Splitter  8550000
    ## 208          Brook Lopez 21165675
    ## 213      Justin Hamilton  3000000
    ## 222         Damian Jones  1171560
    ## 223           David West  1551659
    ## 227         JaVale McGee  1403611
    ## 229         Kevon Looney  1182840
    ## 235        Zaza Pachulia  2898000
    ## 241       Dewayne Dedmon  2898000
    ## 242         Joel Anthony   165952
    ## 249            Pau Gasol 15500000
    ## 252       Chinanu Onuaku   543471
    ## 253         Clint Capela  1296240
    ## 259     Montrezl Harrell  1000000
    ## 271       DeAndre Jordan 21165675
    ## 272        Diamond Stone   543471
    ## 276    Marreese Speights  1403611
    ## 286          Jeff Withey  1015696
    ## 292          Rudy Gobert  2121288
    ## 299          Enes Kanter 17145838
    ## 307         Steven Adams  3140517
    ## 313        Deyonta Davis  1369229
    ## 317           Marc Gasol 21165675
    ## 332         Jusuf Nurkic  1921320
    ## 348        Mason Plumlee  2328530
    ## 350         Nikola Jokic  1358500
    ## 351          Roy Hibbert  5000000
    ## 354        Alexis Ajinca  4600000
    ## 355        Anthony Davis 22116750
    ## 359     DeMarcus Cousins 16957900
    ## 364            Omer Asik  9904494
    ## 368         A.J. Hammons   650000
    ## 373        Dwight Powell  8375000
    ## 377         Nerlens Noel  4384490
    ## 379          Salah Mejri   874636
    ## 389 Georgios Papagiannis  2202240
    ## 390         Kosta Koufos  8046500
    ## 397  Willie Cauley-Stein  3551160
    ## 401         Cole Aldrich  7643979
    ## 403          Jordan Hill  3911380
    ## 404   Karl-Anthony Towns  5960160
    ## 416          Ivica Zubac  1034956
    ## 423          Tarik Black  6191000
    ## 425       Timofey Mozgov 16000000
    ## 427        Alan Williams   874636
    ## 428             Alex Len  4823621
    ## 441       Tyson Chandler 12415000

-   Create a data frame `durant` with Kevin Durant's information (i.e. row).

``` r
durantList = dat[dat$player == "Kevin Durant",]
durantFrame = data.frame(durantList)
```

-   Create a data frame `ucla` with the data of players from college UCLA ("University of California, Los Angeles").

``` r
uclaList <-  dat[dat$college == "University of California, Los Angeles", ]
uclaFrame <- data.frame(uclaList)
```

-   Create a data frame `rookies` with those players with 0 years of experience.

``` r
rookieList = dat[dat$experience == 0,]
rookieFrame = data.frame(rookieList)
```

-   Create a data frame `rookie_centers` with the data of Center rookie players.

``` r
rookieCFrame = rookieFrame[rookieFrame$position == "C", ]
```

-   Create a data frame `top_players` for players with more than 50 games and more than 100 minutes played.

``` r
topPlayers = data.frame(dat[dat$games > 50 & dat$minutes > 100, ])
```

-   What's the largest height value?

``` r
max(dat$height, na.rm=T)
```

    ## [1] 87

-   What's the minimum height value?

``` r
min(dat$height, na.rm=T)
```

    ## [1] 69

-   What's the overall average height?

``` r
ave(dat$height)[1]
```

    ## [1] 79.1542

-   Who is the tallest player?

``` r
dat[dat$height == 87, 1]
```

    ## [1] "Edy Tavares"        "Boban Marjanovic"   "Kristaps Porzingis"

-   Who is the shortest player?

``` r
dat[dat$height == 69, 1]
```

    ## [1] "Isaiah Thomas" "Kay Felder"

-   Which are the unique teams?

``` r
unique(dat$team)
```

    ##  [1] "BOS" "CLE" "TOR" "WAS" "ATL" "MIL" "IND" "CHI" "MIA" "DET" "CHO"
    ## [12] "NYK" "ORL" "PHI" "BRK" "GSW" "SAS" "HOU" "LAC" "UTA" "OKC" "MEM"
    ## [23] "POR" "DEN" "NOP" "DAL" "SAC" "MIN" "LAL" "PHO"

-   How many different teams?

``` r
length(unique(dat$team))
```

    ## [1] 30

-   Who is the oldest player?

``` r
dat[dat$age ==max(dat$age), 1]
```

    ## [1] "Vince Carter"

-   What is the median salary of all players?

``` r
median(dat$salary)
```

    ## [1] 3500000

-   What is the median salary of the players with 10 years of experience or more?

``` r
player10 <- dat[dat$experience > 10,]
median(player10$salary)
```

    ## [1] 5038468

-   What is the median salary of Shooting Guards (SG) and Point Guards (PG)?

``` r
pg_sg = dat[dat$position == "PG"|dat$position == "SG" ,]
median(pg_sg$salary)
```

    ## [1] 3230690

-   What is the median salary of Power Forwards (PF), 29 years or older, and 74 inches tall or less?

``` r
condList = subset(dat, position == "PF" & age >= 29 & height <= 74 )
median(condList$salary)
```

    ## [1] NA

-   How many players scored 4 points or less?

``` r
nrow(dat[dat$points <= 4,])
```

    ## [1] 7

-   Who are those players who scored 4 points or less?

``` r
dat[dat$points <= 4,]$player
```

    ## [1] "Chris McCullough" "Michael Gbinije"  "Patricio Garino" 
    ## [4] "Isaiah Taylor"    "Brice Johnson"    "Roy Hibbert"     
    ## [7] "Elijah Millsap"

-   Who is the player with 0 points?

``` r
dat[dat$points == 0,]$player
```

    ## [1] "Patricio Garino"

-   How many players are from "University of California, Berkeley"?

``` r
dat[dat$college == "University of California, Berkeley" ,]
```

    ##  [1] player     team       position   height     weight     age       
    ##  [7] experience college    salary     games      minutes    points    
    ## [13] points3    points2    points1   
    ## <0 rows> (or 0-length row.names)

-   Are there any players from "University of Notre Dame"? If so how many and who are they?

``` r
nrow(dat[dat$college == "University of Notre Dame",])
```

    ## [1] 3

``` r
dat[dat$college == "University of Notre Dame",]$player
```

    ## [1] "Demetrius Jackson" "Jerian Grant"      "Pat Connaughton"

-   Are there any players with weight greater than 260 pounds? If so how many and who are they?

``` r
nrow(dat[dat$weight > 260,])
```

    ## [1] 21

``` r
dat[dat$weight > 260,]$player
```

    ##  [1] "Jonas Valanciunas" "Dwight Howard"     "Greg Monroe"      
    ##  [4] "Al Jefferson"      "Kevin Seraphin"    "Cristiano Felicio"
    ##  [7] "Hassan Whiteside"  "Andre Drummond"    "Boban Marjanovic" 
    ## [10] "Jahlil Okafor"     "Brook Lopez"       "JaVale McGee"     
    ## [13] "Zaza Pachulia"     "DeAndre Jordan"    "Derrick Favors"   
    ## [16] "Jusuf Nurkic"      "Roy Hibbert"       "DeMarcus Cousins" 
    ## [19] "Kosta Koufos"      "Ivica Zubac"       "Timofey Mozgov"

-   How many players did not attend a college in the US?

``` r
nrow(dat[dat$college == "", ])
```

    ## [1] 85

-   Who is the player with the maximum rate of points per minute?

``` r
transform(dat, points = points / minutes)
```

    ##                       player team position height weight age experience
    ## 1                 Al Horford  BOS        C     82    245  30          9
    ## 2               Amir Johnson  BOS       PF     81    240  29         11
    ## 3              Avery Bradley  BOS       SG     74    180  26          6
    ## 4          Demetrius Jackson  BOS       PG     73    201  22          0
    ## 5               Gerald Green  BOS       SF     79    205  31          9
    ## 6              Isaiah Thomas  BOS       PG     69    185  27          5
    ## 7                Jae Crowder  BOS       SF     78    235  26          4
    ## 8                James Young  BOS       SG     78    215  21          2
    ## 9               Jaylen Brown  BOS       SF     79    225  20          0
    ## 10             Jonas Jerebko  BOS       PF     82    231  29          6
    ## 11             Jordan Mickey  BOS       PF     80    235  22          1
    ## 12              Kelly Olynyk  BOS        C     84    238  25          3
    ## 13              Marcus Smart  BOS       SG     76    220  22          2
    ## 14              Terry Rozier  BOS       PG     74    190  22          1
    ## 15              Tyler Zeller  BOS        C     84    253  27          4
    ## 16             Channing Frye  CLE        C     83    255  33         10
    ## 17             Dahntay Jones  CLE       SF     78    225  36         12
    ## 18            Deron Williams  CLE       PG     75    200  32         11
    ## 19          Derrick Williams  CLE       PF     80    240  25          5
    ## 20               Edy Tavares  CLE        C     87    260  24          1
    ## 21             Iman Shumpert  CLE       SG     77    220  26          5
    ## 22                J.R. Smith  CLE       SG     78    225  31         12
    ## 23               James Jones  CLE       SF     80    218  36         13
    ## 24                Kay Felder  CLE       PG     69    176  21          0
    ## 25                Kevin Love  CLE       PF     82    251  28          8
    ## 26               Kyle Korver  CLE       SG     79    212  35         13
    ## 27              Kyrie Irving  CLE       PG     75    193  24          5
    ## 28              LeBron James  CLE       SF     80    250  32         13
    ## 29         Richard Jefferson  CLE       SF     79    233  36         15
    ## 30          Tristan Thompson  CLE        C     81    238  25          5
    ## 31             Bruno Caboclo  TOR       SF     81    218  21          2
    ## 32               Cory Joseph  TOR       SG     75    193  25          5
    ## 33              Delon Wright  TOR       PG     77    183  24          1
    ## 34             DeMar DeRozan  TOR       SG     79    221  27          7
    ## 35           DeMarre Carroll  TOR       SF     80    215  30          7
    ## 36             Fred VanVleet  TOR       PG     72    195  22          0
    ## 37              Jakob Poeltl  TOR        C     84    248  21          0
    ## 38         Jonas Valanciunas  TOR        C     84    265  24          4
    ## 39                Kyle Lowry  TOR       PG     72    205  30         10
    ## 40            Lucas Nogueira  TOR        C     84    241  24          2
    ## 41             Norman Powell  TOR       SG     76    215  23          1
    ## 42               P.J. Tucker  TOR       SF     78    245  31          5
    ## 43             Pascal Siakam  TOR       PF     81    230  22          0
    ## 44         Patrick Patterson  TOR       PF     81    230  27          6
    ## 45               Serge Ibaka  TOR       PF     82    235  27          7
    ## 46          Bojan Bogdanovic  WAS       SF     80    216  27          2
    ## 47              Bradley Beal  WAS       SG     77    207  23          4
    ## 48          Brandon Jennings  WAS       PG     73    170  27          7
    ## 49          Chris McCullough  WAS       PF     83    200  21          1
    ## 50             Daniel Ochefu  WAS        C     83    245  23          0
    ## 51               Ian Mahinmi  WAS        C     83    250  30          8
    ## 52               Jason Smith  WAS        C     84    245  30          8
    ## 53                 John Wall  WAS       PG     76    195  26          6
    ## 54             Marcin Gortat  WAS        C     83    240  32          9
    ## 55           Markieff Morris  WAS       PF     82    245  27          5
    ## 56               Otto Porter  WAS       SF     80    198  23          3
    ## 57         Sheldon McClellan  WAS       SG     77    200  24          0
    ## 58          Tomas Satoransky  WAS       SG     79    210  25          0
    ## 59                Trey Burke  WAS       PG     73    191  24          3
    ## 60           DeAndre' Bembry  ATL       SF     78    210  22          0
    ## 61           Dennis Schroder  ATL       PG     73    172  23          3
    ## 62             Dwight Howard  ATL        C     83    265  31         12
    ## 63            Ersan Ilyasova  ATL       PF     82    235  29          8
    ## 64             Jose Calderon  ATL       PG     75    200  35         11
    ## 65             Kent Bazemore  ATL       SF     77    201  27          4
    ## 66            Kris Humphries  ATL       PF     81    235  31         12
    ## 67           Malcolm Delaney  ATL       PG     75    190  27          0
    ## 68             Mike Dunleavy  ATL       SF     81    230  36         14
    ## 69              Mike Muscala  ATL        C     83    240  25          3
    ## 70              Paul Millsap  ATL       PF     80    246  31         10
    ## 71                Ryan Kelly  ATL       PF     83    230  25          3
    ## 72           Thabo Sefolosha  ATL       SF     79    220  32         10
    ## 73              Tim Hardaway  ATL       SG     78    205  24          3
    ## 74     Giannis Antetokounmpo  MIL       SF     83    222  22          3
    ## 75               Greg Monroe  MIL        C     83    265  26          6
    ## 76             Jabari Parker  MIL       PF     80    250  21          2
    ## 77               Jason Terry  MIL       SG     74    185  39         17
    ## 78               John Henson  MIL        C     83    229  26          4
    ## 79           Khris Middleton  MIL       SF     80    234  25          4
    ## 80           Malcolm Brogdon  MIL       SG     77    215  24          0
    ## 81       Matthew Dellavedova  MIL       PG     76    198  26          3
    ## 82           Michael Beasley  MIL       PF     81    235  28          8
    ## 83           Mirza Teletovic  MIL       PF     81    242  31          4
    ## 84             Rashad Vaughn  MIL       SG     78    202  20          1
    ## 85             Spencer Hawes  MIL       PF     85    245  28          9
    ## 86                Thon Maker  MIL        C     85    216  19          0
    ## 87                Tony Snell  MIL       SG     79    200  25          3
    ## 88              Aaron Brooks  IND       PG     72    161  32          8
    ## 89              Al Jefferson  IND        C     82    289  32         12
    ## 90                C.J. Miles  IND       SF     78    225  29         11
    ## 91             Georges Niang  IND       PF     80    230  23          0
    ## 92               Jeff Teague  IND       PG     74    186  28          7
    ## 93                 Joe Young  IND       PG     74    180  24          1
    ## 94            Kevin Seraphin  IND       PF     81    285  27          6
    ## 95          Lance Stephenson  IND       SG     77    230  26          6
    ## 96               Lavoy Allen  IND       PF     81    260  27          5
    ## 97               Monta Ellis  IND       SG     75    185  31         11
    ## 98              Myles Turner  IND        C     83    243  20          1
    ## 99               Paul George  IND       SF     81    220  26          6
    ## 100         Rakeem Christmas  IND       PF     81    250  25          1
    ## 101           Thaddeus Young  IND       PF     80    221  28          9
    ## 102           Anthony Morrow  CHI       SG     77    210  31          8
    ## 103             Bobby Portis  CHI       PF     83    230  21          1
    ## 104            Cameron Payne  CHI       PG     75    185  22          1
    ## 105        Cristiano Felicio  CHI        C     82    275  24          1
    ## 106         Denzel Valentine  CHI       SG     78    212  23          0
    ## 107              Dwyane Wade  CHI       SG     76    220  35         13
    ## 108            Isaiah Canaan  CHI       SG     72    201  25          3
    ## 109             Jerian Grant  CHI       PG     76    195  24          1
    ## 110             Jimmy Butler  CHI       SF     79    220  27          5
    ## 111        Joffrey Lauvergne  CHI        C     83    220  25          2
    ## 112  Michael Carter-Williams  CHI       PG     78    190  25          3
    ## 113           Nikola Mirotic  CHI       PF     82    220  25          2
    ## 114              Paul Zipser  CHI       SF     80    215  22          0
    ## 115              Rajon Rondo  CHI       PG     73    186  30         10
    ## 116              Robin Lopez  CHI        C     84    255  28          8
    ## 117             Dion Waiters  MIA       SG     76    225  25          4
    ## 118             Goran Dragic  MIA       PG     75    190  30          8
    ## 119         Hassan Whiteside  MIA        C     84    265  27          4
    ## 120            James Johnson  MIA       PF     81    250  29          7
    ## 121           Josh McRoberts  MIA       PF     82    240  29          9
    ## 122          Josh Richardson  MIA       SG     78    200  23          1
    ## 123          Justise Winslow  MIA       SF     79    225  20          1
    ## 124             Luke Babbitt  MIA       SF     81    225  27          6
    ## 125              Okaro White  MIA       PF     80    204  24          0
    ## 126          Rodney McGruder  MIA       SG     76    205  25          0
    ## 127            Tyler Johnson  MIA       PG     76    186  24          2
    ## 128            Udonis Haslem  MIA        C     80    235  36         13
    ## 129          Wayne Ellington  MIA       SG     76    200  29          7
    ## 130              Willie Reed  MIA        C     82    220  26          1
    ## 131           Andre Drummond  DET        C     83    279  23          4
    ## 132              Aron Baynes  DET        C     82    260  30          4
    ## 133               Beno Udrih  DET       PG     75    205  34         12
    ## 134         Boban Marjanovic  DET        C     87    290  28          1
    ## 135          Darrun Hilliard  DET       SG     78    205  23          1
    ## 136           Henry Ellenson  DET       PF     83    245  20          0
    ## 137                Ish Smith  DET       PG     72    175  28          6
    ## 138                Jon Leuer  DET       PF     82    228  27          5
    ## 139 Kentavious Caldwell-Pope  DET       SG     77    205  23          3
    ## 140            Marcus Morris  DET       SF     81    235  27          5
    ## 141          Michael Gbinije  DET       SG     79    200  24          0
    ## 142           Reggie Bullock  DET       SF     79    205  25          3
    ## 143           Reggie Jackson  DET       PG     75    208  26          5
    ## 144          Stanley Johnson  DET       SF     79    245  20          1
    ## 145            Tobias Harris  DET       PF     81    235  24          5
    ## 146            Brian Roberts  CHO       PG     73    173  31          4
    ## 147            Briante Weber  CHO       PG     74    165  24          1
    ## 148           Christian Wood  CHO       PF     83    220  21          1
    ## 149              Cody Zeller  CHO       PF     84    240  24          3
    ## 150           Frank Kaminsky  CHO        C     84    242  23          1
    ## 151              Jeremy Lamb  CHO       SG     77    185  24          4
    ## 152          Johnny O'Bryant  CHO       PF     81    257  23          2
    ## 153             Kemba Walker  CHO       PG     73    172  26          5
    ## 154          Marco Belinelli  CHO       SG     77    210  30          9
    ## 155          Marvin Williams  CHO       PF     81    237  30         11
    ## 156   Michael Kidd-Gilchrist  CHO       SF     79    232  23          4
    ## 157            Miles Plumlee  CHO        C     83    249  28          4
    ## 158            Nicolas Batum  CHO       SG     80    200  28          8
    ## 159           Ramon Sessions  CHO       PG     75    190  30          9
    ## 160           Treveon Graham  CHO       SG     78    220  23          0
    ## 161          Carmelo Anthony  NYK       SF     80    240  32         13
    ## 162           Chasson Randle  NYK       PG     74    185  23          0
    ## 163             Courtney Lee  NYK       SG     77    200  31          8
    ## 164             Derrick Rose  NYK       PG     75    190  28          7
    ## 165              Joakim Noah  NYK        C     83    230  31          9
    ## 166           Justin Holiday  NYK       SG     78    185  27          3
    ## 167       Kristaps Porzingis  NYK       PF     87    240  21          1
    ## 168             Kyle O'Quinn  NYK        C     82    250  26          4
    ## 169             Lance Thomas  NYK       PF     80    235  28          5
    ## 170         Marshall Plumlee  NYK        C     84    250  24          0
    ## 171            Maurice Ndour  NYK       PF     81    200  24          0
    ## 172     Mindaugas Kuzminskas  NYK       SF     81    215  27          0
    ## 173                Ron Baker  NYK       SG     76    220  23          0
    ## 174            Sasha Vujacic  NYK       SG     79    195  32          9
    ## 175        Willy Hernangomez  NYK        C     83    240  22          0
    ## 176             Aaron Gordon  ORL       SF     81    220  21          2
    ## 177          Bismack Biyombo  ORL        C     81    255  24          5
    ## 178              C.J. Watson  ORL       PG     74    175  32          9
    ## 179            D.J. Augustin  ORL       PG     72    183  29          8
    ## 180             Damjan Rudez  ORL       SF     82    228  30          2
    ## 181            Elfrid Payton  ORL       PG     76    185  22          2
    ## 182            Evan Fournier  ORL       SG     79    205  24          4
    ## 183               Jeff Green  ORL       PF     81    235  30          8
    ## 184              Jodie Meeks  ORL       SG     76    210  29          7
    ## 185      Marcus Georges-Hunt  ORL       SG     77    216  22          0
    ## 186            Mario Hezonja  ORL       SF     80    215  21          1
    ## 187           Nikola Vucevic  ORL        C     84    260  26          5
    ## 188          Patricio Garino  ORL       SG     78    210  23          0
    ## 189        Stephen Zimmerman  ORL        C     84    240  20          0
    ## 190            Terrence Ross  ORL       SF     79    206  25          4
    ## 191           Alex Poythress  PHI       PF     79    238  23          0
    ## 192              Dario Saric  PHI       PF     82    223  22          0
    ## 193         Gerald Henderson  PHI       SG     77    215  29          7
    ## 194            Jahlil Okafor  PHI        C     83    275  21          1
    ## 195           Jerryd Bayless  PHI       PG     75    200  28          8
    ## 196              Joel Embiid  PHI        C     84    250  22          0
    ## 197          Justin Anderson  PHI       SF     78    228  23          1
    ## 198             Nik Stauskas  PHI       SG     78    205  23          2
    ## 199           Richaun Holmes  PHI        C     82    245  23          1
    ## 200         Robert Covington  PHI       SF     81    215  26          3
    ## 201         Sergio Rodriguez  PHI       PG     75    176  30          4
    ## 202               Shawn Long  PHI        C     81    255  24          0
    ## 203           T.J. McConnell  PHI       PG     74    200  24          1
    ## 204           Tiago Splitter  PHI        C     83    245  32          6
    ## 205  Timothe Luwawu-Cabarrot  PHI       SF     78    205  21          0
    ## 206         Andrew Nicholson  BRK       PF     81    250  27          4
    ## 207           Archie Goodwin  BRK       SG     77    200  22          3
    ## 208              Brook Lopez  BRK        C     84    275  28          8
    ## 209             Caris LeVert  BRK       SF     79    203  22          0
    ## 210         Isaiah Whitehead  BRK       PG     76    213  21          0
    ## 211               Jeremy Lin  BRK       PG     75    200  28          6
    ## 212               Joe Harris  BRK       SG     78    219  25          2
    ## 213          Justin Hamilton  BRK        C     84    260  26          2
    ## 214           K.J. McDaniels  BRK       SF     78    205  23          2
    ## 215               Quincy Acy  BRK       PF     79    240  26          4
    ## 216               Randy Foye  BRK       SG     76    213  33         10
    ## 217  Rondae Hollis-Jefferson  BRK       SF     79    220  22          1
    ## 218          Sean Kilpatrick  BRK       SG     76    210  27          2
    ## 219        Spencer Dinwiddie  BRK       PG     78    200  23          2
    ## 220            Trevor Booker  BRK       PF     80    228  29          6
    ## 221           Andre Iguodala  GSW       SF     78    215  33         12
    ## 222             Damian Jones  GSW        C     84    245  21          0
    ## 223               David West  GSW        C     81    250  36         13
    ## 224           Draymond Green  GSW       PF     79    230  26          4
    ## 225                Ian Clark  GSW       SG     75    175  25          3
    ## 226     James Michael McAdoo  GSW       PF     81    230  24          2
    ## 227             JaVale McGee  GSW        C     84    270  29          8
    ## 228             Kevin Durant  GSW       SF     81    240  28          9
    ## 229             Kevon Looney  GSW        C     81    220  20          1
    ## 230            Klay Thompson  GSW       SG     79    215  26          5
    ## 231              Matt Barnes  GSW       SF     79    226  36         13
    ## 232            Patrick McCaw  GSW       SG     79    185  21          0
    ## 233         Shaun Livingston  GSW       PG     79    192  31         11
    ## 234            Stephen Curry  GSW       PG     75    190  28          7
    ## 235            Zaza Pachulia  GSW        C     83    270  32         13
    ## 236              Bryn Forbes  SAS       SG     75    190  23          0
    ## 237              Danny Green  SAS       SG     78    215  29          7
    ## 238                David Lee  SAS       PF     81    245  33         11
    ## 239            Davis Bertans  SAS       PF     82    210  24          0
    ## 240          Dejounte Murray  SAS       PG     77    170  20          0
    ## 241           Dewayne Dedmon  SAS        C     84    245  27          3
    ## 242             Joel Anthony  SAS        C     81    245  34          9
    ## 243         Jonathon Simmons  SAS       SG     78    195  27          1
    ## 244            Kawhi Leonard  SAS       SF     79    230  25          5
    ## 245            Kyle Anderson  SAS       SG     81    230  23          2
    ## 246        LaMarcus Aldridge  SAS       PF     83    260  31         10
    ## 247            Manu Ginobili  SAS       SG     78    205  39         14
    ## 248              Patty Mills  SAS       PG     72    185  28          7
    ## 249                Pau Gasol  SAS        C     84    250  36         15
    ## 250              Tony Parker  SAS       PG     74    185  34         15
    ## 251              Bobby Brown  HOU       PG     74    175  32          2
    ## 252           Chinanu Onuaku  HOU        C     82    245  20          0
    ## 253             Clint Capela  HOU        C     82    240  22          2
    ## 254              Eric Gordon  HOU       SG     76    215  28          8
    ## 255            Isaiah Taylor  HOU       PG     75    170  22          0
    ## 256             James Harden  HOU       PG     77    220  27          7
    ## 257             Kyle Wiltjer  HOU       PF     82    240  24          0
    ## 258             Lou Williams  HOU       SG     73    175  30         11
    ## 259         Montrezl Harrell  HOU        C     80    240  23          1
    ## 260         Patrick Beverley  HOU       SG     73    185  28          4
    ## 261            Ryan Anderson  HOU       PF     82    240  28          8
    ## 262               Sam Dekker  HOU       SF     81    230  22          1
    ## 263             Trevor Ariza  HOU       SF     80    215  31         12
    ## 264            Troy Williams  HOU       SF     79    218  22          0
    ## 265            Alan Anderson  LAC       SF     78    220  34          7
    ## 266            Austin Rivers  LAC       SG     76    200  24          4
    ## 267            Blake Griffin  LAC       PF     82    251  27          6
    ## 268             Brandon Bass  LAC       PF     80    250  31         11
    ## 269            Brice Johnson  LAC       PF     82    230  22          0
    ## 270               Chris Paul  LAC       PG     72    175  31         11
    ## 271           DeAndre Jordan  LAC        C     83    265  28          8
    ## 272            Diamond Stone  LAC        C     83    255  19          0
    ## 273              J.J. Redick  LAC       SG     76    190  32         10
    ## 274           Jamal Crawford  LAC       SG     77    200  36         16
    ## 275         Luc Mbah a Moute  LAC       SF     80    230  30          8
    ## 276        Marreese Speights  LAC        C     82    255  29          8
    ## 277              Paul Pierce  LAC       SF     79    235  39         18
    ## 278           Raymond Felton  LAC       PG     73    205  32         11
    ## 279           Wesley Johnson  LAC       SF     79    215  29          6
    ## 280               Alec Burks  UTA       SG     78    214  25          5
    ## 281               Boris Diaw  UTA       PF     80    250  34         13
    ## 282               Dante Exum  UTA       PG     78    190  21          1
    ## 283           Derrick Favors  UTA       PF     82    265  25          6
    ## 284              George Hill  UTA       PG     75    188  30          8
    ## 285           Gordon Hayward  UTA       SF     80    226  26          6
    ## 286              Jeff Withey  UTA        C     84    231  26          3
    ## 287               Joe Ingles  UTA       SF     80    226  29          2
    ## 288              Joe Johnson  UTA       SF     79    240  35         15
    ## 289            Joel Bolomboy  UTA       PF     81    235  23          0
    ## 290                Raul Neto  UTA       PG     73    179  24          1
    ## 291              Rodney Hood  UTA       SG     80    206  24          2
    ## 292              Rudy Gobert  UTA        C     85    245  24          3
    ## 293             Shelvin Mack  UTA       PG     75    203  26          5
    ## 294               Trey Lyles  UTA       PF     82    234  21          1
    ## 295             Alex Abrines  OKC       SG     78    190  23          0
    ## 296           Andre Roberson  OKC       SF     79    210  25          3
    ## 297         Domantas Sabonis  OKC       PF     83    240  20          0
    ## 298           Doug McDermott  OKC       SF     80    225  25          2
    ## 299              Enes Kanter  OKC        C     83    245  24          5
    ## 300             Jerami Grant  OKC       SF     80    210  22          2
    ## 301             Josh Huestis  OKC       PF     79    230  25          1
    ## 302             Kyle Singler  OKC       SF     80    228  28          4
    ## 303            Nick Collison  OKC       PF     82    255  36         12
    ## 304              Norris Cole  OKC       PG     74    175  28          5
    ## 305        Russell Westbrook  OKC       PG     75    200  28          8
    ## 306           Semaj Christon  OKC       PG     75    190  24          0
    ## 307             Steven Adams  OKC        C     84    255  23          3
    ## 308               Taj Gibson  OKC       PF     81    225  31          7
    ## 309           Victor Oladipo  OKC       SG     76    210  24          3
    ## 310          Andrew Harrison  MEM       PG     78    213  22          0
    ## 311           Brandan Wright  MEM       PF     82    210  29          8
    ## 312         Chandler Parsons  MEM       SF     82    230  28          5
    ## 313            Deyonta Davis  MEM        C     83    237  20          0
    ## 314              James Ennis  MEM       SF     79    210  26          2
    ## 315           JaMychal Green  MEM       PF     81    227  26          2
    ## 316            Jarell Martin  MEM       PF     82    239  22          1
    ## 317               Marc Gasol  MEM        C     85    255  32          8
    ## 318              Mike Conley  MEM       PG     73    175  29          9
    ## 319               Tony Allen  MEM       SG     76    213  35         12
    ## 320             Troy Daniels  MEM       SG     76    205  25          3
    ## 321             Vince Carter  MEM       SF     78    220  40         18
    ## 322             Wade Baldwin  MEM       PG     76    202  20          0
    ## 323             Wayne Selden  MEM       SG     77    230  22          0
    ## 324            Zach Randolph  MEM       PF     81    260  35         15
    ## 325          Al-Farouq Aminu  POR       SF     81    220  26          6
    ## 326             Allen Crabbe  POR       SG     78    210  24          3
    ## 327            C.J. McCollum  POR       SG     76    200  25          3
    ## 328           Damian Lillard  POR       PG     75    195  26          4
    ## 329                 Ed Davis  POR       PF     82    240  27          6
    ## 330              Evan Turner  POR       SF     79    220  28          6
    ## 331              Jake Layman  POR       SF     81    210  22          0
    ## 332             Jusuf Nurkic  POR        C     84    280  22          2
    ## 333         Maurice Harkless  POR       SF     81    215  23          4
    ## 334           Meyers Leonard  POR       PF     85    245  24          4
    ## 335              Noah Vonleh  POR       PF     82    240  21          2
    ## 336          Pat Connaughton  POR       SG     77    206  24          1
    ## 337           Shabazz Napier  POR       PG     73    175  25          2
    ## 338           Tim Quarterman  POR       SG     78    195  22          0
    ## 339         Danilo Gallinari  DEN       SF     82    225  28          7
    ## 340           Darrell Arthur  DEN       PF     81    235  28          7
    ## 341          Emmanuel Mudiay  DEN       PG     77    200  20          1
    ## 342              Gary Harris  DEN       SG     76    210  22          2
    ## 343             Jamal Murray  DEN       SG     76    207  19          0
    ## 344            Jameer Nelson  DEN       PG     72    190  34         12
    ## 345         Juan Hernangomez  DEN       PF     81    230  21          0
    ## 346           Kenneth Faried  DEN       PF     80    228  27          5
    ## 347            Malik Beasley  DEN       SG     77    196  20          0
    ## 348            Mason Plumlee  DEN        C     83    245  26          3
    ## 349              Mike Miller  DEN       SF     80    218  36         16
    ## 350             Nikola Jokic  DEN        C     82    250  21          1
    ## 351              Roy Hibbert  DEN        C     86    270  30          8
    ## 352              Will Barton  DEN       SG     78    175  26          4
    ## 353          Wilson Chandler  DEN       SF     80    225  29          8
    ## 354            Alexis Ajinca  NOP        C     86    248  28          6
    ## 355            Anthony Davis  NOP        C     82    253  23          4
    ## 356             Axel Toupane  NOP       SF     79    197  24          1
    ## 357            Cheick Diallo  NOP       PF     81    220  20          0
    ## 358         Dante Cunningham  NOP       SF     80    230  29          7
    ## 359         DeMarcus Cousins  NOP        C     83    270  26          6
    ## 360       Donatas Motiejunas  NOP       PF     84    222  26          4
    ## 361            E'Twaun Moore  NOP       SG     76    191  27          5
    ## 362          Jordan Crawford  NOP       SG     76    195  28          4
    ## 363             Jrue Holiday  NOP       PG     76    205  26          7
    ## 364                Omer Asik  NOP        C     84    255  30          6
    ## 365               Quinn Cook  NOP       PG     74    184  23          0
    ## 366             Solomon Hill  NOP       SF     79    225  25          3
    ## 367              Tim Frazier  NOP       PG     73    170  26          2
    ## 368             A.J. Hammons  DAL        C     84    260  24          0
    ## 369          DeAndre Liggins  DAL       SG     78    209  28          3
    ## 370             Devin Harris  DAL       PG     75    192  33         12
    ## 371            Dirk Nowitzki  DAL       PF     84    245  38         18
    ## 372      Dorian Finney-Smith  DAL       PF     80    220  23          0
    ## 373            Dwight Powell  DAL        C     83    240  25          2
    ## 374          Harrison Barnes  DAL       PF     80    210  24          4
    ## 375               J.J. Barea  DAL       PG     72    185  32         10
    ## 376            Jarrod Uthoff  DAL       PF     81    221  23          0
    ## 377             Nerlens Noel  DAL        C     83    228  22          2
    ## 378         Nicolas Brussino  DAL       SF     79    195  23          0
    ## 379              Salah Mejri  DAL        C     85    245  30          1
    ## 380               Seth Curry  DAL       PG     74    185  26          3
    ## 381          Wesley Matthews  DAL       SG     77    220  30          7
    ## 382             Yogi Ferrell  DAL       PG     72    180  23          0
    ## 383         Anthony Tolliver  SAC       PF     80    240  31          8
    ## 384            Arron Afflalo  SAC       SG     77    210  31          9
    ## 385             Ben McLemore  SAC       SG     77    195  23          3
    ## 386              Buddy Hield  SAC       SG     76    214  23          0
    ## 387          Darren Collison  SAC       PG     72    175  29          7
    ## 388           Garrett Temple  SAC       SG     78    195  30          6
    ## 389     Georgios Papagiannis  SAC        C     85    240  19          0
    ## 390             Kosta Koufos  SAC        C     84    265  27          8
    ## 391        Langston Galloway  SAC       PG     74    200  25          2
    ## 392       Malachi Richardson  SAC       SG     78    205  21          0
    ## 393                 Rudy Gay  SAC       SF     80    230  30         10
    ## 394          Skal Labissiere  SAC       PF     83    225  20          0
    ## 395                Ty Lawson  SAC       PG     71    195  29          7
    ## 396             Tyreke Evans  SAC       SF     78    220  27          7
    ## 397      Willie Cauley-Stein  SAC        C     84    240  23          1
    ## 398            Adreian Payne  MIN       PF     82    237  25          2
    ## 399           Andrew Wiggins  MIN       SF     80    199  21          2
    ## 400             Brandon Rush  MIN       SG     78    220  31          8
    ## 401             Cole Aldrich  MIN        C     83    250  28          6
    ## 402             Gorgui Dieng  MIN       PF     83    241  27          3
    ## 403              Jordan Hill  MIN        C     82    235  29          7
    ## 404       Karl-Anthony Towns  MIN        C     84    244  21          1
    ## 405                Kris Dunn  MIN       PG     76    210  22          0
    ## 406          Nemanja Bjelica  MIN       PF     82    240  28          1
    ## 407              Omri Casspi  MIN       SF     81    225  28          7
    ## 408              Ricky Rubio  MIN       PG     76    194  26          5
    ## 409         Shabazz Muhammad  MIN       SF     78    223  24          3
    ## 410               Tyus Jones  MIN       PG     74    195  20          1
    ## 411              Zach LaVine  MIN       SG     77    189  21          2
    ## 412           Brandon Ingram  LAL       SF     81    190  19          0
    ## 413             Corey Brewer  LAL       SF     81    186  30          9
    ## 414         D'Angelo Russell  LAL       PG     77    195  20          1
    ## 415              David Nwaba  LAL       SG     76    209  24          0
    ## 416              Ivica Zubac  LAL        C     85    265  19          0
    ## 417          Jordan Clarkson  LAL       SG     77    194  24          2
    ## 418            Julius Randle  LAL       PF     81    250  22          2
    ## 419          Larry Nance Jr.  LAL       PF     81    230  24          1
    ## 420                Luol Deng  LAL       SF     81    220  31         12
    ## 421        Metta World Peace  LAL       SF     78    260  37         16
    ## 422               Nick Young  LAL       SG     79    210  31          9
    ## 423              Tarik Black  LAL        C     81    250  25          2
    ## 424          Thomas Robinson  LAL       PF     82    237  25          4
    ## 425           Timofey Mozgov  LAL        C     85    275  30          6
    ## 426              Tyler Ennis  LAL       PG     75    194  22          2
    ## 427            Alan Williams  PHO        C     80    260  24          1
    ## 428                 Alex Len  PHO        C     85    260  23          3
    ## 429           Brandon Knight  PHO       SG     75    189  25          5
    ## 430            Derrick Jones  PHO       SF     79    190  19          0
    ## 431             Devin Booker  PHO       SG     78    206  20          1
    ## 432            Dragan Bender  PHO       PF     85    225  19          0
    ## 433           Elijah Millsap  PHO       SG     78    225  29          2
    ## 434             Eric Bledsoe  PHO       PG     73    190  27          6
    ## 435             Jared Dudley  PHO       PF     79    225  31          9
    ## 436          Leandro Barbosa  PHO       SG     75    194  34         13
    ## 437          Marquese Chriss  PHO       PF     82    233  19          0
    ## 438             Ronnie Price  PHO       PG     74    190  33         11
    ## 439              T.J. Warren  PHO       SF     80    230  23          2
    ## 440               Tyler Ulis  PHO       PG     70    150  21          0
    ## 441           Tyson Chandler  PHO        C     85    240  34         15
    ##                                                      college   salary
    ## 1                                      University of Florida 26540100
    ## 2                                                            12000000
    ## 3                              University of Texas at Austin  8269663
    ## 4                                   University of Notre Dame  1450000
    ## 5                                                             1410598
    ## 6                                   University of Washington  6587132
    ## 7                                       Marquette University  6286408
    ## 8                                     University of Kentucky  1825200
    ## 9                                   University of California  4743000
    ## 10                                                            5000000
    ## 11                                Louisiana State University  1223653
    ## 12                                        Gonzaga University  3094014
    ## 13                                 Oklahoma State University  3578880
    ## 14                                  University of Louisville  1906440
    ## 15                              University of North Carolina  8000000
    ## 16                                     University of Arizona  7806971
    ## 17                                           Duke University    18255
    ## 18                University of Illinois at Urbana-Champaign   259626
    ## 19                                     University of Arizona   268029
    ## 20                                                               5145
    ## 21                           Georgia Institute of Technology  9700000
    ## 22                                                           12800000
    ## 23                                       University of Miami  1551659
    ## 24                                        Oakland University   543471
    ## 25                     University of California, Los Angeles 21165675
    ## 26                                      Creighton University  5239437
    ## 27                                           Duke University 17638063
    ## 28                                                           30963450
    ## 29                                     University of Arizona  2500000
    ## 30                             University of Texas at Austin 15330435
    ## 31                                                            1589640
    ## 32                             University of Texas at Austin  7330000
    ## 33                                        University of Utah  1577280
    ## 34                         University of Southern California 26540100
    ## 35                                    University of Missouri 14200000
    ## 36                                  Wichita State University   543471
    ## 37                                        University of Utah  2703960
    ## 38                                                           14382022
    ## 39                                      Villanova University 12000000
    ## 40                                                            1921320
    ## 41                     University of California, Los Angeles   874636
    ## 42                             University of Texas at Austin  5300000
    ## 43                               New Mexico State University  1196040
    ## 44                                    University of Kentucky  6050000
    ## 45                                                           12250000
    ## 46                                                            3730653
    ## 47                                     University of Florida 22116750
    ## 48                                                            1200000
    ## 49                                       Syracuse University  1191480
    ## 50                                      Villanova University   543471
    ## 51                                                           15944154
    ## 52                                 Colorado State University  5000000
    ## 53                                    University of Kentucky 16957900
    ## 54                                                           12000000
    ## 55                                      University of Kansas  7400000
    ## 56                                     Georgetown University  5893981
    ## 57                                       University of Miami   543471
    ## 58                                                            2870813
    ## 59                                    University of Michigan  3386598
    ## 60                                 Saint Joseph's University  1499760
    ## 61                                                            2708582
    ## 62                                                           23180275
    ## 63                                                            8400000
    ## 64                                                             392478
    ## 65                                   Old Dominion University 15730338
    ## 66                                   University of Minnesota  4000000
    ## 67       Virginia Polytechnic Institute and State University  2500000
    ## 68                                           Duke University  4837500
    ## 69                                       Bucknell University  1015696
    ## 70                                 Louisiana Tech University 20072033
    ## 71                                           Duke University   418228
    ## 72                                                            3850000
    ## 73                                    University of Michigan  2281605
    ## 74                                                            2995421
    ## 75                                     Georgetown University 17100000
    ## 76                                           Duke University  5374320
    ## 77                                     University of Arizona  1551659
    ## 78                              University of North Carolina 12517606
    ## 79                                      Texas A&M University 15200000
    ## 80                                    University of Virginia   925000
    ## 81                        Saint Mary's College of California  9607500
    ## 82                                   Kansas State University  1403611
    ## 83                                                           10500000
    ## 84                           University of Nevada, Las Vegas  1811040
    ## 85                                  University of Washington  6348759
    ## 86                                                            2568600
    ## 87                                  University of New Mexico  2368327
    ## 88                                      University of Oregon  2700000
    ## 89                                                           10230179
    ## 90                                                            4583450
    ## 91                                     Iowa State University   650000
    ## 92                                    Wake Forest University  8800000
    ## 93                                      University of Oregon  1052342
    ## 94                                                            1800000
    ## 95                                  University of Cincinnati  4000000
    ## 96                                         Temple University  4000000
    ## 97                                                           10770000
    ## 98                             University of Texas at Austin  2463840
    ## 99                       California State University, Fresno 18314532
    ## 100                                      Syracuse University  1052342
    ## 101                          Georgia Institute of Technology 14153652
    ## 102                          Georgia Institute of Technology  3488000
    ## 103                                   University of Arkansas  1453680
    ## 104                                  Murray State University  2112480
    ## 105                                                            874636
    ## 106                                Michigan State University  2092200
    ## 107                                     Marquette University 23200000
    ## 108                                  Murray State University  1015696
    ## 109                                 University of Notre Dame  1643040
    ## 110                                     Marquette University 17552209
    ## 111                                                           1709720
    ## 112                                      Syracuse University  3183526
    ## 113                                                           5782450
    ## 114                                                            750000
    ## 115                                   University of Kentucky 14000000
    ## 116                                      Stanford University 13219250
    ## 117                                      Syracuse University  2898000
    ## 118                                                          15890000
    ## 119                                      Marshall University 22116750
    ## 120                                   Wake Forest University  4000000
    ## 121                                          Duke University  5782450
    ## 122                                  University of Tennessee   874636
    ## 123                                          Duke University  2593440
    ## 124                               University of Nevada, Reno  1227000
    ## 125                                 Florida State University   210995
    ## 126                                  Kansas State University   543471
    ## 127                      California State University, Fresno  5628000
    ## 128                                    University of Florida  4000000
    ## 129                             University of North Carolina  6000000
    ## 130                                   Saint Louis University  1015696
    ## 131                                University of Connecticut 22116750
    ## 132                              Washington State University  6500000
    ## 133                                                           1551659
    ## 134                                                           7000000
    ## 135                                     Villanova University   874060
    ## 136                                     Marquette University  1704120
    ## 137                                   Wake Forest University  6000000
    ## 138                                  University of Wisconsin 10991957
    ## 139                                    University of Georgia  3678319
    ## 140                                     University of Kansas  4625000
    ## 141                                      Syracuse University   650000
    ## 142                             University of North Carolina  2255644
    ## 143                                           Boston College 14956522
    ## 144                                    University of Arizona  2969880
    ## 145                                  University of Tennessee 17200000
    ## 146                                     University of Dayton  1050961
    ## 147                         Virginia Commonwealth University   102898
    ## 148                          University of Nevada, Las Vegas   874636
    ## 149                                       Indiana University  5318313
    ## 150                                  University of Wisconsin  2730000
    ## 151                                University of Connecticut  6511628
    ## 152                               Louisiana State University   161483
    ## 153                                University of Connecticut 12000000
    ## 154                                                           6333333
    ## 155                             University of North Carolina 12250000
    ## 156                                   University of Kentucky 13000000
    ## 157                                          Duke University 12500000
    ## 158                                                          20869566
    ## 159                               University of Nevada, Reno  6000000
    ## 160                         Virginia Commonwealth University   543471
    ## 161                                      Syracuse University 24559380
    ## 162                                      Stanford University   143860
    ## 163                              Western Kentucky University 11242000
    ## 164                                    University of Memphis 21323250
    ## 165                                    University of Florida 17000000
    ## 166                                 University of Washington  1015696
    ## 167                                                           4317720
    ## 168                                 Norfolk State University  3900000
    ## 169                                          Duke University  6191000
    ## 170                                          Duke University   543471
    ## 171                                          Ohio University   543471
    ## 172                                                           2898000
    ## 173                                 Wichita State University   543471
    ## 174                                                           1410598
    ## 175                                                           1375000
    ## 176                                    University of Arizona  4351320
    ## 177                                                          17000000
    ## 178                                  University of Tennessee  5000000
    ## 179                            University of Texas at Austin  7250000
    ## 180                                                            980431
    ## 181                     University of Louisiana at Lafayette  2613600
    ## 182                                                          17000000
    ## 183                                    Georgetown University 15000000
    ## 184                                   University of Kentucky  6540000
    ## 185                          Georgia Institute of Technology    31969
    ## 186                                                           3909840
    ## 187                        University of Southern California 11750000
    ## 188                             George Washington University    31969
    ## 189                          University of Nevada, Las Vegas   950000
    ## 190                                 University of Washington 10000000
    ## 191                                   University of Kentucky    31969
    ## 192                                                           2318280
    ## 193                                          Duke University  9000000
    ## 194                                          Duke University  4788840
    ## 195                                    University of Arizona  9424084
    ## 196                                     University of Kansas  4826160
    ## 197                                   University of Virginia  1514160
    ## 198                                   University of Michigan  2993040
    ## 199                           Bowling Green State University  1025831
    ## 200                               Tennessee State University  1015696
    ## 201                                                           8000000
    ## 202                     University of Louisiana at Lafayette    89513
    ## 203                                    University of Arizona   874636
    ## 204                                                           8550000
    ## 205                                                           1326960
    ## 206                               St. Bonaventure University  6088993
    ## 207                                   University of Kentucky   119494
    ## 208                                      Stanford University 21165675
    ## 209                                   University of Michigan  1562280
    ## 210                                    Seton Hall University  1074145
    ## 211                                       Harvard University 11483254
    ## 212                                   University of Virginia   980431
    ## 213                               Louisiana State University  3000000
    ## 214                                       Clemson University  3333333
    ## 215                                        Baylor University  1790902
    ## 216                                     Villanova University  2500000
    ## 217                                    University of Arizona  1395600
    ## 218                                 University of Cincinnati   980431
    ## 219                                   University of Colorado   726672
    ## 220                                       Clemson University  9250000
    ## 221                                    University of Arizona 11131368
    ## 222                                    Vanderbilt University  1171560
    ## 223                                        Xavier University  1551659
    ## 224                                Michigan State University 15330435
    ## 225                                       Belmont University  1015696
    ## 226                             University of North Carolina   980431
    ## 227                               University of Nevada, Reno  1403611
    ## 228                            University of Texas at Austin 26540100
    ## 229                    University of California, Los Angeles  1182840
    ## 230                              Washington State University 16663575
    ## 231                    University of California, Los Angeles   383351
    ## 232                          University of Nevada, Las Vegas   543471
    ## 233                                                           5782450
    ## 234                                         Davidson College 12112359
    ## 235                                                           2898000
    ## 236                                Michigan State University   543471
    ## 237                             University of North Carolina 10000000
    ## 238                                    University of Florida  1551659
    ## 239                                                            543471
    ## 240                                 University of Washington  1180080
    ## 241                        University of Southern California  2898000
    ## 242                          University of Nevada, Las Vegas   165952
    ## 243                                    University of Houston   874636
    ## 244                               San Diego State University 17638063
    ## 245                    University of California, Los Angeles  1192080
    ## 246                            University of Texas at Austin 20575005
    ## 247                                                          14000000
    ## 248                       Saint Mary's College of California  3578948
    ## 249                                                          15500000
    ## 250                                                          14445313
    ## 251                   California State University, Fullerton   680534
    ## 252                                 University of Louisville   543471
    ## 253                                                           1296240
    ## 254                                       Indiana University 12385364
    ## 255                            University of Texas at Austin   255000
    ## 256                                 Arizona State University 26540100
    ## 257                                       Gonzaga University   543471
    ## 258                                                           7000000
    ## 259                                 University of Louisville  1000000
    ## 260                                   University of Arkansas  6000000
    ## 261                                 University of California 18735364
    ## 262                                  University of Wisconsin  1720560
    ## 263                    University of California, Los Angeles  7806971
    ## 264                                       Indiana University   150000
    ## 265                                Michigan State University  1315448
    ## 266                                          Duke University 11000000
    ## 267                                   University of Oklahoma 20140838
    ## 268                               Louisiana State University  1551659
    ## 269                             University of North Carolina  1273920
    ## 270                                   Wake Forest University 22868828
    ## 271                                     Texas A&M University 21165675
    ## 272                                   University of Maryland   543471
    ## 273                                          Duke University  7377500
    ## 274                                   University of Michigan 13253012
    ## 275                    University of California, Los Angeles  2203000
    ## 276                                    University of Florida  1403611
    ## 277                                     University of Kansas  3500000
    ## 278                             University of North Carolina  1551659
    ## 279                                      Syracuse University  5628000
    ## 280                                   University of Colorado 10154495
    ## 281                                                           7000000
    ## 282                                                           3940320
    ## 283                          Georgia Institute of Technology 11050000
    ## 284        Indiana University-Purdue University Indianapolis  8000000
    ## 285                                        Butler University 16073140
    ## 286                                     University of Kansas  1015696
    ## 287                                                           2250000
    ## 288                                   University of Arkansas 11000000
    ## 289                                   Weber State University   600000
    ## 290                                                            937800
    ## 291                                          Duke University  1406520
    ## 292                                                           2121288
    ## 293                                        Butler University  2433334
    ## 294                                   University of Kentucky  2340600
    ## 295                                                           5994764
    ## 296                                   University of Colorado  2183072
    ## 297                                       Gonzaga University  2440200
    ## 298                                     Creighton University  2483040
    ## 299                                                          17145838
    ## 300                                      Syracuse University   980431
    ## 301                                      Stanford University  1191480
    ## 302                                          Duke University  4837500
    ## 303                                     University of Kansas  3750000
    ## 304                               Cleveland State University   247991
    ## 305                    University of California, Los Angeles 26540100
    ## 306                                        Xavier University   543471
    ## 307                                 University of Pittsburgh  3140517
    ## 308                        University of Southern California  8950000
    ## 309                                       Indiana University  6552960
    ## 310                                   University of Kentucky   945000
    ## 311                             University of North Carolina  5700000
    ## 312                                    University of Florida 22116750
    ## 313                                Michigan State University  1369229
    ## 314                  California State University, Long Beach  2898000
    ## 315                                    University of Alabama   980431
    ## 316                               Louisiana State University  1286160
    ## 317                                                          21165675
    ## 318                                    Ohio State University 26540100
    ## 319                                Oklahoma State University  5505618
    ## 320                         Virginia Commonwealth University  3332940
    ## 321                             University of North Carolina  4264057
    ## 322                                    Vanderbilt University  1793760
    ## 323                                     University of Kansas    83119
    ## 324                                Michigan State University 10361445
    ## 325                                   Wake Forest University  7680965
    ## 326                                 University of California 18500000
    ## 327                                        Lehigh University  3219579
    ## 328                                   Weber State University 24328425
    ## 329                             University of North Carolina  6666667
    ## 330                                    Ohio State University 16393443
    ## 331                                   University of Maryland   600000
    ## 332                                                           1921320
    ## 333                                    St. John's University  8988764
    ## 334               University of Illinois at Urbana-Champaign  9213484
    ## 335                                       Indiana University  2751360
    ## 336                                 University of Notre Dame   874636
    ## 337                                University of Connecticut  1350120
    ## 338                               Louisiana State University   543471
    ## 339                                                          15050000
    ## 340                                     University of Kansas  8070175
    ## 341                                                           3241800
    ## 342                                Michigan State University  1655880
    ## 343                                   University of Kentucky  3210840
    ## 344                                Saint Joseph's University  4540525
    ## 345                                                           1987440
    ## 346                                Morehead State University 12078652
    ## 347                                 Florida State University  1627320
    ## 348                                          Duke University  2328530
    ## 349                                    University of Florida  3500000
    ## 350                                                           1358500
    ## 351                                    Georgetown University  5000000
    ## 352                                    University of Memphis  3533333
    ## 353                                        DePaul University 11200000
    ## 354                                                           4600000
    ## 355                                   University of Kentucky 22116750
    ## 356                                                             20580
    ## 357                                     University of Kansas   543471
    ## 358                                     Villanova University  2978250
    ## 359                                   University of Kentucky 16957900
    ## 360                                                            576724
    ## 361                                        Purdue University  8081363
    ## 362                                        Xavier University   173094
    ## 363                    University of California, Los Angeles 11286518
    ## 364                                                           9904494
    ## 365                                          Duke University    63938
    ## 366                                    University of Arizona 11241218
    ## 367                            Pennsylvania State University  2090000
    ## 368                                        Purdue University   650000
    ## 369                                   University of Kentucky  1015696
    ## 370                                  University of Wisconsin  4228000
    ## 371                                                          25000000
    ## 372                                    University of Florida   543471
    ## 373                                      Stanford University  8375000
    ## 374                             University of North Carolina 22116750
    ## 375                                  Northeastern University  4096950
    ## 376                                       University of Iowa    63938
    ## 377                                   University of Kentucky  4384490
    ## 378                                                            543471
    ## 379                                                            874636
    ## 380                                          Duke University  2898000
    ## 381                                     Marquette University 17100000
    ## 382                                       Indiana University   207798
    ## 383                                     Creighton University  8000000
    ## 384                    University of California, Los Angeles 12500000
    ## 385                                     University of Kansas  4008882
    ## 386                                   University of Oklahoma  3517200
    ## 387                    University of California, Los Angeles  5229454
    ## 388                               Louisiana State University  8000000
    ## 389                                                           2202240
    ## 390                                    Ohio State University  8046500
    ## 391                                Saint Joseph's University  5200000
    ## 392                                      Syracuse University  1439880
    ## 393                                University of Connecticut 13333333
    ## 394                                   University of Kentucky  1188840
    ## 395                             University of North Carolina  1315448
    ## 396                                    University of Memphis 10661286
    ## 397                                   University of Kentucky  3551160
    ## 398                                Michigan State University  2022240
    ## 399                                     University of Kansas  6006600
    ## 400                                     University of Kansas  3500000
    ## 401                                     University of Kansas  7643979
    ## 402                                 University of Louisville  2348783
    ## 403                                    University of Arizona  3911380
    ## 404                                   University of Kentucky  5960160
    ## 405                                       Providence College  3872520
    ## 406                                                           3800000
    ## 407                                                            138414
    ## 408                                                          13550000
    ## 409                    University of California, Los Angeles  3046299
    ## 410                                          Duke University  1339680
    ## 411                    University of California, Los Angeles  2240880
    ## 412                                          Duke University  5281680
    ## 413                                    University of Florida  7600000
    ## 414                                    Ohio State University  5332800
    ## 415 California Polytechnic State University, San Luis Obispo    73528
    ## 416                                                           1034956
    ## 417                                   University of Missouri 12500000
    ## 418                                   University of Kentucky  3267120
    ## 419                                    University of Wyoming  1207680
    ## 420                                          Duke University 18000000
    ## 421                                    St. John's University  1551659
    ## 422                        University of Southern California  5443918
    ## 423                                     University of Kansas  6191000
    ## 424                                     University of Kansas  1050961
    ## 425                                                          16000000
    ## 426                                      Syracuse University  1733880
    ## 427                  University of California, Santa Barbara   874636
    ## 428                                   University of Maryland  4823621
    ## 429                                   University of Kentucky 12606250
    ## 430                          University of Nevada, Las Vegas   543471
    ## 431                                   University of Kentucky  2223600
    ## 432                                                           4276320
    ## 433                      University of Alabama at Birmingham    23069
    ## 434                                   University of Kentucky 14000000
    ## 435                                           Boston College 10470000
    ## 436                                                           4000000
    ## 437                                 University of Washington  2941440
    ## 438                                Utah Valley State College   282595
    ## 439                          North Carolina State University  2128920
    ## 440                                   University of Kentucky   918369
    ## 441                                                          12415000
    ##     games minutes     points points3 points2 points1
    ## 1      68    2193 0.43410853      86     293     108
    ## 2      80    1608 0.32338308      27     186      67
    ## 3      55    1835 0.48719346     108     251      68
    ## 4       5      17 0.58823529       1       2       3
    ## 5      47     538 0.48698885      39      56      33
    ## 6      76    2569 0.85597509     245     437     590
    ## 7      72    2335 0.42783726     157     176     176
    ## 8      29     220 0.30909091      12      13       6
    ## 9      78    1341 0.38404176      46     146      85
    ## 10     78    1232 0.24269481      45      69      26
    ## 11     25     141 0.26950355       0      15       8
    ## 12     75    1538 0.44083225      68     192      90
    ## 13     79    2399 0.34806169      94     175     203
    ## 14     74    1263 0.32462391      57      94      51
    ## 15     51     525 0.33904762       0      78      22
    ## 16     74    1398 0.48354793     137     101      63
    ## 17      1      12 0.75000000       0       3       3
    ## 18     24     486 0.36831276      22      46      21
    ## 19     25     427 0.36533958      21      33      27
    ## 20      1      24 0.25000000       0       3       0
    ## 21     76    1937 0.29272070      94     107      71
    ## 22     41    1187 0.29570345      95      28      10
    ## 23     48     381 0.34645669      31      13      13
    ## 24     42     386 0.43005181       7      55      35
    ## 25     60    1885 0.60583554     145     225     257
    ## 26     35     859 0.43422584      97      34      14
    ## 27     72    2525 0.71920792     177     494     297
    ## 28     74    2794 0.69935576     124     612     358
    ## 29     79    1614 0.27757125      62      91      80
    ## 30     78    2336 0.26969178       0     262     106
    ## 31      9      40 0.35000000       2       4       0
    ## 32     80    2003 0.36944583      48     251      94
    ## 33     27     446 0.33632287      10      39      42
    ## 34     74    2620 0.77099237      33     688     545
    ## 35     72    1882 0.33900106     109     111      89
    ## 36     37     294 0.36394558      11      28      18
    ## 37     54     626 0.26357827       0      67      31
    ## 38     80    2066 0.46418199       1     390     176
    ## 39     60    2244 0.59893048     193     233     299
    ## 40     57    1088 0.23253676       3     100      44
    ## 41     76    1368 0.46491228      56     171     126
    ## 42     24     609 0.22824302      24      28      11
    ## 43     55     859 0.26658906       1     102      22
    ## 44     65    1599 0.27829894      94      60      43
    ## 45     23     712 0.45926966      41      87      30
    ## 46     26     601 0.54908486      45      62      71
    ## 47     77    2684 0.66281669     223     414     282
    ## 48     23     374 0.21657754      11      18      12
    ## 49      2       8 0.12500000       0       0       1
    ## 50     19      75 0.32000000       0      12       0
    ## 51     31     555 0.31171171       0      65      43
    ## 52     74    1068 0.39325843      37     137      35
    ## 53     78    2836 0.63645980      89     558     422
    ## 54     82    2556 0.34546166       0     390     103
    ## 55     76    2374 0.44776748      71     335     180
    ## 56     80    2605 0.41266795     148     266      99
    ## 57     30     287 0.31358885       7      23      23
    ## 58     57     719 0.21418637       9      52      23
    ## 59     57     703 0.40540541      31      85      22
    ## 60     38     371 0.27223720       1      46       6
    ## 61     79    2485 0.56901408     100     448     218
    ## 62     74    2199 0.45566166       0     388     226
    ## 63     26     633 0.42654028      32      61      52
    ## 64     17     247 0.24696356       8      15       7
    ## 65     73    1963 0.40804890      92     203     119
    ## 66     56     689 0.37300435      19      68      64
    ## 67     73    1248 0.31330128      26     119      75
    ## 68     30     475 0.35578947      33      24      22
    ## 69     70    1237 0.35165724      46     124      49
    ## 70     69    2343 0.53179684      75     355     311
    ## 71     16     110 0.22727273       4       4       5
    ## 72     62    1596 0.27819549      41     133      55
    ## 73     79    2154 0.53064067     149     266     164
    ## 74     80    2845 0.64393673      49     607     471
    ## 75     81    1823 0.52166758       0     387     177
    ## 76     51    1728 0.59317130      65     334     162
    ## 77     74    1365 0.22490842      73      32      24
    ## 78     58    1123 0.34906500       0     159      74
    ## 79     29     889 0.47919010      45     105      81
    ## 80     75    1982 0.38698285      78     212     109
    ## 81     76    1986 0.29053374      79     129      82
    ## 82     56     935 0.56470588      18     198      78
    ## 83     70    1133 0.39805825     104      52      35
    ## 84     41     458 0.31004367      26      31       2
    ## 85     19     171 0.48538012       9      21      14
    ## 86     57     562 0.40213523      28      55      32
    ## 87     80    2336 0.29238014     144     102      47
    ## 88     65     894 0.36017897      48      73      32
    ## 89     66     931 0.57465091       0     235      65
    ## 90     76    1776 0.45889640     169     112      84
    ## 91     23      93 0.22580645       1       8       2
    ## 92     82    2657 0.47196086      90     312     360
    ## 93     33     135 0.50370370       5      21      11
    ## 94     49     559 0.41502683       0     109      14
    ## 95      6     132 0.32575758       5      13       2
    ## 96     61     871 0.20321470       0      77      23
    ## 97     74    1998 0.31531532      43     204      93
    ## 98     81    2541 0.46162928      40     404     245
    ## 99     75    2689 0.66009669     195     427     336
    ## 100    29     219 0.26940639       0      19      21
    ## 101    74    2237 0.36388020      45     317      45
    ## 102     9      87 0.47126437       6       6      11
    ## 103    64    1000 0.43700000      32     151      39
    ## 104    11     142 0.38028169      11      10       1
    ## 105    66    1040 0.30384615       0     128      60
    ## 106    57     976 0.29815574      73      29      14
    ## 107    60    1792 0.61160714      45     369     223
    ## 108    39     592 0.30574324      25      38      30
    ## 109    63    1028 0.35992218      49      79      65
    ## 110    76    2809 0.64649341      91     479     585
    ## 111    20     241 0.36929461       6      31       9
    ## 112    45     846 0.35106383      15      97      58
    ## 113    70    1679 0.44312091     129     129      99
    ## 114    44     843 0.28469751      33      55      31
    ## 115    69    1843 0.29191536      50     179      30
    ## 116    81    2271 0.36944077       0     382      75
    ## 117    46    1384 0.52673410      85     196      82
    ## 118    73    2459 0.60309069     117     417     298
    ## 119    77    2513 0.52089136       0     542     225
    ## 120    76    2085 0.46762590      87     281     152
    ## 121    22     381 0.28083990      13      31       6
    ## 122    53    1614 0.33395291      75     127      60
    ## 123    18     625 0.31360000       7      73      29
    ## 124    68    1065 0.30422535      87      26      11
    ## 125    35     471 0.20806794      12      21      20
    ## 126    78    1966 0.25279756      73     117      44
    ## 127    73    2178 0.46005510      93     264     195
    ## 128    17     130 0.23846154       0      11       9
    ## 129    62    1500 0.43200000     149      82      37
    ## 130    71    1031 0.36275461       1     161      49
    ## 131    81    2409 0.45869655       2     481     137
    ## 132    75    1163 0.31384351       0     143      79
    ## 133    39     560 0.40535714      11      81      32
    ## 134    35     293 0.65187713       0      72      47
    ## 135    39     381 0.33333333      12      35      21
    ## 136    19     146 0.41095890      10      13       4
    ## 137    81    1955 0.38772379      28     301      72
    ## 138    75    1944 0.39454733      49     261      98
    ## 139    76    2529 0.41399763     153     217     154
    ## 140    79    2565 0.43079922     118     303     145
    ## 141     9      32 0.12500000       0       1       2
    ## 142    31     467 0.30192719      28      26       5
    ## 143    52    1424 0.52808989      66     218     118
    ## 144    77    1371 0.24726477      45      84      36
    ## 145    82    2567 0.51460849     109     402     190
    ## 146    41     416 0.34134615      17      29      33
    ## 147    13     159 0.31446541       1      19       9
    ## 148    13     107 0.32710280       0      12      11
    ## 149    62    1725 0.37043478       0     253     133
    ## 150    75    1954 0.44728762     116     204     118
    ## 151    62    1143 0.52755906      41     185     110
    ## 152     4      34 0.52941176       1       7       1
    ## 153    79    2739 0.66812705     240     403     304
    ## 154    74    1778 0.43869516     102     162     150
    ## 155    76    2295 0.36993464     124     173     131
    ## 156    81    2349 0.31630481       1     294     152
    ## 157    13     174 0.17816092       0      14       3
    ## 158    77    2617 0.44478410     135     258     243
    ## 159    50     811 0.38471023      21      79      91
    ## 160    27     189 0.30158730       9      10      10
    ## 161    74    2538 0.65366430     151     451     304
    ## 162    18     225 0.42222222      10      18      29
    ## 163    77    2459 0.33956893     108     213      85
    ## 164    64    2082 0.55427474      13     447     221
    ## 165    46    1015 0.22857143       0      99      34
    ## 166    82    1639 0.38377059      97     136      66
    ## 167    66    2164 0.55268022     112     331     198
    ## 168    79    1229 0.40358015       2     213      64
    ## 169    46     968 0.28409091      38      59      43
    ## 170    21     170 0.23529412       0      16       8
    ## 171    32     331 0.29607251       1      38      19
    ## 172    68    1016 0.41830709      54     104      55
    ## 173    52     857 0.25087515      23      59      28
    ## 174    42     408 0.30392157      23      19      17
    ## 175    72    1324 0.44335347       4     242      91
    ## 176    80    2298 0.44342907      77     316     156
    ## 177    81    1793 0.26938093       0     179     125
    ## 178    62    1012 0.27766798      32      64      57
    ## 179    78    1538 0.40052016      95     100     131
    ## 180    45     314 0.26114650      20      11       0
    ## 181    82    2412 0.43366501      40     390     146
    ## 182    68    2234 0.52238138     128     280     223
    ## 183    69    1534 0.41590613      53     167     145
    ## 184    36     738 0.44308943      56      47      65
    ## 185     5      48 0.29166667       1       1       9
    ## 186    65     960 0.33020833      43      74      40
    ## 187    75    2163 0.50670365      23     460     107
    ## 188     5      43 0.00000000       0       0       0
    ## 189    19     108 0.21296296       0      10       3
    ## 190    24     748 0.39973262      46      69      23
    ## 191     6     157 0.40764331       6      19       8
    ## 192    81    2129 0.48849225     106     275     172
    ## 193    72    1667 0.39712058      61     173     133
    ## 194    50    1134 0.52028219       0     242     106
    ## 195     3      71 0.46478873       2       9       9
    ## 196    31     786 0.79770992      36     164     191
    ## 197    24     518 0.39189189      21      54      32
    ## 198    80    2188 0.34552102     132     119     122
    ## 199    57    1193 0.46856664      27     203      72
    ## 200    67    2119 0.40773950     137     155     143
    ## 201    68    1518 0.34914361      92     118      18
    ## 202    18     234 0.63247863       7      54      19
    ## 203    81    2133 0.26066573      11     225      73
    ## 204     8      76 0.51315789       2      12       9
    ## 205    69    1190 0.37394958      50      95     105
    ## 206    10     111 0.27027027       2      11       2
    ## 207    12     184 0.51630435       4      30      23
    ## 208    75    2222 0.69261926     134     421     295
    ## 209    57    1237 0.37833468      59     112      67
    ## 210    73    1643 0.33049300      44     160      91
    ## 211    36     883 0.59229898      58     117     115
    ## 212    52    1138 0.37609842      85      69      35
    ## 213    64    1177 0.37553101      55     119      39
    ## 214    20     293 0.43003413      11      35      23
    ## 215    32     510 0.40980392      36      29      43
    ## 216    69    1284 0.27803738      67      51      54
    ## 217    78    1761 0.38330494      15     220     190
    ## 218    70    1754 0.52394527     105     200     204
    ## 219    59    1334 0.32383808      38      96     126
    ## 220    71    1754 0.40421893      25     280      74
    ## 221    76    1998 0.28728729      64     155      72
    ## 222    10      85 0.22352941       0       8       3
    ## 223    68     854 0.37002342       3     132      43
    ## 224    76    2471 0.31404290      81     191     151
    ## 225    77    1137 0.46350044      61     150      44
    ## 226    52     457 0.32166302       2      60      21
    ## 227    77     739 0.63870095       0     208      56
    ## 228    62    2070 0.75120773     117     434     336
    ## 229    53     447 0.30201342       2      54      21
    ## 230    78    2649 0.65760664     268     376     186
    ## 231    20     410 0.27804878      18      20      20
    ## 232    71    1074 0.26256983      41      65      29
    ## 233    76    1345 0.28921933       1     172      42
    ## 234    79    2638 0.75777104     324     351     325
    ## 235    70    1268 0.33596215       0     164      98
    ## 236    36     285 0.32982456      17      19       5
    ## 237    68    1807 0.27504151     118      58      27
    ## 238    79    1477 0.38997969       0     248      80
    ## 239    67     808 0.37500000      69      34      28
    ## 240    38     322 0.40372671       9      41      21
    ## 241    76    1330 0.29097744       0     161      65
    ## 242    19     122 0.20491803       0      10       5
    ## 243    78    1392 0.34698276      30     147      99
    ## 244    74    2474 0.76313662     147     489     469
    ## 245    72    1020 0.24117647      15      78      45
    ## 246    72    2335 0.53233405      23     477     220
    ## 247    69    1291 0.40046476      89      82      86
    ## 248    80    1754 0.43272520     147     126      66
    ## 249    64    1627 0.48678549      56     247     130
    ## 250    63    1587 0.40201638      23     242      85
    ## 251    25     123 0.50406504      14       9       2
    ## 252     5      52 0.26923077       0       5       4
    ## 253    65    1551 0.52740168       0     362      94
    ## 254    75    2323 0.52389152     246     166     147
    ## 255     4      52 0.05769231       0       1       1
    ## 256    81    2947 0.79945707     262     412     746
    ## 257    14      44 0.29545455       4       0       1
    ## 258    23     591 0.58037225      41      61      98
    ## 259    58    1064 0.49530075       1     224      76
    ## 260    67    2058 0.31049563     110     118      73
    ## 261    72    2116 0.46266541     204     119     129
    ## 262    77    1419 0.35517970      60     143      38
    ## 263    80    2773 0.33754057     191     135      93
    ## 264     6     139 0.41726619       8      14       6
    ## 265    30     308 0.27922078      14      16      12
    ## 266    74    2054 0.43281402     111     212     132
    ## 267    61    2076 0.63391137      38     441     320
    ## 268    52     577 0.50606586       1     106      77
    ## 269     3       9 0.44444444       0       2       0
    ## 270    61    1921 0.57470068     124     250     232
    ## 271    81    2570 0.40038911       0     412     205
    ## 272     7      24 0.41666667       0       3       4
    ## 273    78    2198 0.53366697     201     195     180
    ## 274    82    2157 0.46731572     116     243     174
    ## 275    80    1787 0.27084499      43     148      59
    ## 276    82    1286 0.55287714     103     141     120
    ## 277    25     277 0.29241877      15      13      10
    ## 278    80    1700 0.31647059      46     175      50
    ## 279    68     810 0.22962963      29      44      11
    ## 280    42     653 0.43338438      25      74      60
    ## 281    73    1283 0.26344505      20     126      26
    ## 282    66    1228 0.33550489      44     111      58
    ## 283    50    1186 0.40134907       3     200      67
    ## 284    49    1544 0.53691710      94     195     157
    ## 285    73    2516 0.63632750     149     396     362
    ## 286    51     432 0.33796296       0      55      36
    ## 287    82    1972 0.29462475     123      81      50
    ## 288    78    1843 0.38795442     106     167      63
    ## 289    12      53 0.41509434       1       8       3
    ## 290    40     346 0.28901734      10      31       8
    ## 291    59    1593 0.46955430     114     158      90
    ## 292    81    2744 0.41435860       0     413     311
    ## 293    55    1205 0.35684647      37     133      53
    ## 294    71    1158 0.37996546      65      94      57
    ## 295    68    1055 0.38483412      94      40      44
    ## 296    79    2376 0.21969697      45     170      47
    ## 297    81    1632 0.29350490      51     141      44
    ## 298    22     430 0.33720930      21      35      12
    ## 299    72    1533 0.67384214       5     397     224
    ## 300    78    1490 0.28255034      43     103      86
    ## 301     2      31 0.45161290       2       4       0
    ## 302    32     385 0.22857143       7      27      13
    ## 303    20     128 0.25781250       0      14       5
    ## 304    13     125 0.34400000       3      13       8
    ## 305    81    2802 0.91291934     200     624     710
    ## 306    64     973 0.18807811      12      65      17
    ## 307    80    2389 0.37881959       0     374     157
    ## 308    23     487 0.42505133       1      88      28
    ## 309    67    2222 0.48019802     127     285     116
    ## 310    72    1474 0.28833107      43      74     148
    ## 311    28     447 0.42281879       0      83      23
    ## 312    34     675 0.31111111      25      50      35
    ## 313    36     238 0.24369748       0      24      10
    ## 314    64    1501 0.28580946      51      95      86
    ## 315    77    2101 0.32793908      55     195     134
    ## 316    42     558 0.29569892       9      49      40
    ## 317    74    2531 0.57131569     104     428     278
    ## 318    69    2292 0.61736475     171     293     316
    ## 319    71    1914 0.33594566      15     259      80
    ## 320    67    1183 0.46576500     138      47      43
    ## 321    73    1799 0.32573652     112      81      88
    ## 322    33     405 0.26172840       3      33      31
    ## 323    11     189 0.29100529       3      17      12
    ## 324    73    1786 0.57558791      21     412     141
    ## 325    61    1773 0.30005640      70     113      96
    ## 326    79    2254 0.37488909     134     169     105
    ## 327    80    2796 0.65701001     185     507     268
    ## 328    75    2694 0.75129918     214     447     488
    ## 329    46     789 0.25348542       0      75      50
    ## 330    65    1658 0.35343788      31     204      85
    ## 331    35     249 0.31325301      13      13      13
    ## 332    20     584 0.52054795       0     120      64
    ## 333    77    2223 0.34772830      68     246      77
    ## 334    74    1222 0.32815057      74      72      35
    ## 335    74    1265 0.25849802       7     123      60
    ## 336    39     316 0.31012658      17      20       7
    ## 337    53     512 0.42578125      34      39      38
    ## 338    16      80 0.38750000       5       8       0
    ## 339    63    2134 0.53655108     126     209     349
    ## 340    41     639 0.41001565      53      42      19
    ## 341    55    1406 0.42887624      56     152     131
    ## 342    57    1782 0.47755331     107     213     104
    ## 343    82    1764 0.45975057     115     180     106
    ## 344    75    2045 0.33594132     106     162      45
    ## 345    62     842 0.36223278      46      55      57
    ## 346    61    1296 0.45293210       0     228     131
    ## 347    22     165 0.50303030       9      24       8
    ## 348    27     632 0.38765823       0      99      47
    ## 349    20     151 0.18543046       8       1       2
    ## 350    73    2038 0.59911678      45     449     188
    ## 351     6      11 0.36363636       0       2       0
    ## 352    60    1705 0.48093842      87     208     143
    ## 353    71    2197 0.50842057     110     323     141
    ## 354    39     584 0.35445205       0      89      29
    ## 355    75    2708 0.77511078      40     730     519
    ## 356     2      41 0.26829268       1       4       0
    ## 357    17     199 0.43718593       0      36      15
    ## 358    66    1649 0.26379624      71     103      16
    ## 359    17     574 0.72125436      36     106      94
    ## 360    34     479 0.31315240      11      46      25
    ## 361    73    1820 0.38461538      77     206      57
    ## 362    19     442 0.60407240      37      68      20
    ## 363    67    2190 0.46986301     100     305     119
    ## 364    31     482 0.17634855       0      31      23
    ## 365     9     111 0.46846847       6      16       2
    ## 366    80    2374 0.23715249      94      89     103
    ## 367    65    1525 0.30426230      40     123      98
    ## 368    22     163 0.29447853       5      12       9
    ## 369     1      25 0.32000000       0       3       2
    ## 370    65    1087 0.40202392      58      78     107
    ## 371    54    1424 0.54002809      79     217      98
    ## 372    81    1642 0.21315469      56      68      46
    ## 373    77    1333 0.38709677      21     173     107
    ## 374    79    2803 0.54156261      78     521     242
    ## 375    35     771 0.49416342      53      89      44
    ## 376     9     115 0.34782609       3      13       5
    ## 377    22     483 0.38923395       0      77      34
    ## 378    54     521 0.28790787      29      23      17
    ## 379    73     905 0.23535912       1      87      36
    ## 380    70    2029 0.44258255     137     201      85
    ## 381    73    2495 0.39519038     174     159     146
    ## 382    36    1046 0.39005736      60      82      64
    ## 383    65    1477 0.31211916      90      65      61
    ## 384    61    1580 0.32594937      62     123      83
    ## 385    61    1176 0.42091837      65     115      70
    ## 386    25     727 0.51994498      59      83      35
    ## 387    68    2063 0.43625788      73     267     147
    ## 388    65    1728 0.29282407      82     101      58
    ## 389    22     355 0.34929577       0      56      12
    ## 390    71    1419 0.33121917       0     216      38
    ## 391    19     375 0.30400000      19      23      11
    ## 392    22     198 0.39898990       8      20      15
    ## 393    30    1013 0.55478776      42     159     118
    ## 394    33     612 0.47222222       3     114      52
    ## 395    69    1732 0.39318707      34     203     173
    ## 396    14     314 0.51910828      21      38      24
    ## 397    75    1421 0.42997889       0     255     101
    ## 398    18     135 0.46666667       3      20      14
    ## 399    82    3048 0.63418635     103     606     412
    ## 400    47    1030 0.19126214      44      26      13
    ## 401    62     531 0.19774011       0      45      15
    ## 402    82    2653 0.30757633      16     316     136
    ## 403     7      47 0.25531915       0       5       2
    ## 404    82    3030 0.68019802     101     701     356
    ## 405    78    1333 0.21980495      21      97      36
    ## 406    65    1190 0.33865546      56      95      45
    ## 407    13     222 0.20270270       2      17       5
    ## 408    75    2469 0.33859862      60     201     254
    ## 409    78    1516 0.50923483      49     239     147
    ## 410    60     774 0.27002584      26      49      33
    ## 411    47    1749 0.50829045     120     206     117
    ## 412    79    2279 0.32470382      55     221     133
    ## 413    24     358 0.36033520       5      48      18
    ## 414    63    1811 0.54334622     135     216     147
    ## 415    20     397 0.30226700       1      46      25
    ## 416    38     609 0.46633826       0     126      32
    ## 417    82    2397 0.50271172     117     360     134
    ## 418    74    2132 0.45731707      17     360     204
    ## 419    63    1442 0.31137309      10     180      59
    ## 420    56    1486 0.28600269      51     113      46
    ## 421    25     160 0.35625000       9      10      10
    ## 422    60    1556 0.50835476     170     102      77
    ## 423    67    1091 0.35105408       1     149      82
    ## 424    48     560 0.43035714       0     105      31
    ## 425    54    1104 0.36322464       0     169      63
    ## 426    22     392 0.43367347      21      44      19
    ## 427    47     708 0.48870056       0     138      70
    ## 428    77    1560 0.39294872       3     227     150
    ## 429    54    1140 0.52192982      45     164     132
    ## 430    32     545 0.30825688       3      65      29
    ## 431    78    2730 0.63223443     147     459     367
    ## 432    43     574 0.25435540      28      29       4
    ## 433     2      23 0.13043478       0       1       1
    ## 434    66    2176 0.63878676     104     345     388
    ## 435    64    1362 0.31864905      77      80      43
    ## 436    67     963 0.43509865      35     137      40
    ## 437    82    1743 0.43201377      72     212     113
    ## 438    14     134 0.10447761       3       1       3
    ## 439    66    2048 0.46435547      26     377     119
    ## 440    61    1123 0.39536955      21     163      55
    ## 441    47    1298 0.30585516       0     153      91

``` r
dat[dat$points == max(dat$points), ]
```

    ##                player team position height weight age experience
    ## 305 Russell Westbrook  OKC       PG     75    200  28          8
    ##                                   college   salary games minutes points
    ## 305 University of California, Los Angeles 26540100    81    2802   2558
    ##     points3 points2 points1
    ## 305     200     624     710

-   Who is the player with the maximum rate of three-points per minute?

``` r
transform(dat, points3 = points3 / minutes)
```

    ##                       player team position height weight age experience
    ## 1                 Al Horford  BOS        C     82    245  30          9
    ## 2               Amir Johnson  BOS       PF     81    240  29         11
    ## 3              Avery Bradley  BOS       SG     74    180  26          6
    ## 4          Demetrius Jackson  BOS       PG     73    201  22          0
    ## 5               Gerald Green  BOS       SF     79    205  31          9
    ## 6              Isaiah Thomas  BOS       PG     69    185  27          5
    ## 7                Jae Crowder  BOS       SF     78    235  26          4
    ## 8                James Young  BOS       SG     78    215  21          2
    ## 9               Jaylen Brown  BOS       SF     79    225  20          0
    ## 10             Jonas Jerebko  BOS       PF     82    231  29          6
    ## 11             Jordan Mickey  BOS       PF     80    235  22          1
    ## 12              Kelly Olynyk  BOS        C     84    238  25          3
    ## 13              Marcus Smart  BOS       SG     76    220  22          2
    ## 14              Terry Rozier  BOS       PG     74    190  22          1
    ## 15              Tyler Zeller  BOS        C     84    253  27          4
    ## 16             Channing Frye  CLE        C     83    255  33         10
    ## 17             Dahntay Jones  CLE       SF     78    225  36         12
    ## 18            Deron Williams  CLE       PG     75    200  32         11
    ## 19          Derrick Williams  CLE       PF     80    240  25          5
    ## 20               Edy Tavares  CLE        C     87    260  24          1
    ## 21             Iman Shumpert  CLE       SG     77    220  26          5
    ## 22                J.R. Smith  CLE       SG     78    225  31         12
    ## 23               James Jones  CLE       SF     80    218  36         13
    ## 24                Kay Felder  CLE       PG     69    176  21          0
    ## 25                Kevin Love  CLE       PF     82    251  28          8
    ## 26               Kyle Korver  CLE       SG     79    212  35         13
    ## 27              Kyrie Irving  CLE       PG     75    193  24          5
    ## 28              LeBron James  CLE       SF     80    250  32         13
    ## 29         Richard Jefferson  CLE       SF     79    233  36         15
    ## 30          Tristan Thompson  CLE        C     81    238  25          5
    ## 31             Bruno Caboclo  TOR       SF     81    218  21          2
    ## 32               Cory Joseph  TOR       SG     75    193  25          5
    ## 33              Delon Wright  TOR       PG     77    183  24          1
    ## 34             DeMar DeRozan  TOR       SG     79    221  27          7
    ## 35           DeMarre Carroll  TOR       SF     80    215  30          7
    ## 36             Fred VanVleet  TOR       PG     72    195  22          0
    ## 37              Jakob Poeltl  TOR        C     84    248  21          0
    ## 38         Jonas Valanciunas  TOR        C     84    265  24          4
    ## 39                Kyle Lowry  TOR       PG     72    205  30         10
    ## 40            Lucas Nogueira  TOR        C     84    241  24          2
    ## 41             Norman Powell  TOR       SG     76    215  23          1
    ## 42               P.J. Tucker  TOR       SF     78    245  31          5
    ## 43             Pascal Siakam  TOR       PF     81    230  22          0
    ## 44         Patrick Patterson  TOR       PF     81    230  27          6
    ## 45               Serge Ibaka  TOR       PF     82    235  27          7
    ## 46          Bojan Bogdanovic  WAS       SF     80    216  27          2
    ## 47              Bradley Beal  WAS       SG     77    207  23          4
    ## 48          Brandon Jennings  WAS       PG     73    170  27          7
    ## 49          Chris McCullough  WAS       PF     83    200  21          1
    ## 50             Daniel Ochefu  WAS        C     83    245  23          0
    ## 51               Ian Mahinmi  WAS        C     83    250  30          8
    ## 52               Jason Smith  WAS        C     84    245  30          8
    ## 53                 John Wall  WAS       PG     76    195  26          6
    ## 54             Marcin Gortat  WAS        C     83    240  32          9
    ## 55           Markieff Morris  WAS       PF     82    245  27          5
    ## 56               Otto Porter  WAS       SF     80    198  23          3
    ## 57         Sheldon McClellan  WAS       SG     77    200  24          0
    ## 58          Tomas Satoransky  WAS       SG     79    210  25          0
    ## 59                Trey Burke  WAS       PG     73    191  24          3
    ## 60           DeAndre' Bembry  ATL       SF     78    210  22          0
    ## 61           Dennis Schroder  ATL       PG     73    172  23          3
    ## 62             Dwight Howard  ATL        C     83    265  31         12
    ## 63            Ersan Ilyasova  ATL       PF     82    235  29          8
    ## 64             Jose Calderon  ATL       PG     75    200  35         11
    ## 65             Kent Bazemore  ATL       SF     77    201  27          4
    ## 66            Kris Humphries  ATL       PF     81    235  31         12
    ## 67           Malcolm Delaney  ATL       PG     75    190  27          0
    ## 68             Mike Dunleavy  ATL       SF     81    230  36         14
    ## 69              Mike Muscala  ATL        C     83    240  25          3
    ## 70              Paul Millsap  ATL       PF     80    246  31         10
    ## 71                Ryan Kelly  ATL       PF     83    230  25          3
    ## 72           Thabo Sefolosha  ATL       SF     79    220  32         10
    ## 73              Tim Hardaway  ATL       SG     78    205  24          3
    ## 74     Giannis Antetokounmpo  MIL       SF     83    222  22          3
    ## 75               Greg Monroe  MIL        C     83    265  26          6
    ## 76             Jabari Parker  MIL       PF     80    250  21          2
    ## 77               Jason Terry  MIL       SG     74    185  39         17
    ## 78               John Henson  MIL        C     83    229  26          4
    ## 79           Khris Middleton  MIL       SF     80    234  25          4
    ## 80           Malcolm Brogdon  MIL       SG     77    215  24          0
    ## 81       Matthew Dellavedova  MIL       PG     76    198  26          3
    ## 82           Michael Beasley  MIL       PF     81    235  28          8
    ## 83           Mirza Teletovic  MIL       PF     81    242  31          4
    ## 84             Rashad Vaughn  MIL       SG     78    202  20          1
    ## 85             Spencer Hawes  MIL       PF     85    245  28          9
    ## 86                Thon Maker  MIL        C     85    216  19          0
    ## 87                Tony Snell  MIL       SG     79    200  25          3
    ## 88              Aaron Brooks  IND       PG     72    161  32          8
    ## 89              Al Jefferson  IND        C     82    289  32         12
    ## 90                C.J. Miles  IND       SF     78    225  29         11
    ## 91             Georges Niang  IND       PF     80    230  23          0
    ## 92               Jeff Teague  IND       PG     74    186  28          7
    ## 93                 Joe Young  IND       PG     74    180  24          1
    ## 94            Kevin Seraphin  IND       PF     81    285  27          6
    ## 95          Lance Stephenson  IND       SG     77    230  26          6
    ## 96               Lavoy Allen  IND       PF     81    260  27          5
    ## 97               Monta Ellis  IND       SG     75    185  31         11
    ## 98              Myles Turner  IND        C     83    243  20          1
    ## 99               Paul George  IND       SF     81    220  26          6
    ## 100         Rakeem Christmas  IND       PF     81    250  25          1
    ## 101           Thaddeus Young  IND       PF     80    221  28          9
    ## 102           Anthony Morrow  CHI       SG     77    210  31          8
    ## 103             Bobby Portis  CHI       PF     83    230  21          1
    ## 104            Cameron Payne  CHI       PG     75    185  22          1
    ## 105        Cristiano Felicio  CHI        C     82    275  24          1
    ## 106         Denzel Valentine  CHI       SG     78    212  23          0
    ## 107              Dwyane Wade  CHI       SG     76    220  35         13
    ## 108            Isaiah Canaan  CHI       SG     72    201  25          3
    ## 109             Jerian Grant  CHI       PG     76    195  24          1
    ## 110             Jimmy Butler  CHI       SF     79    220  27          5
    ## 111        Joffrey Lauvergne  CHI        C     83    220  25          2
    ## 112  Michael Carter-Williams  CHI       PG     78    190  25          3
    ## 113           Nikola Mirotic  CHI       PF     82    220  25          2
    ## 114              Paul Zipser  CHI       SF     80    215  22          0
    ## 115              Rajon Rondo  CHI       PG     73    186  30         10
    ## 116              Robin Lopez  CHI        C     84    255  28          8
    ## 117             Dion Waiters  MIA       SG     76    225  25          4
    ## 118             Goran Dragic  MIA       PG     75    190  30          8
    ## 119         Hassan Whiteside  MIA        C     84    265  27          4
    ## 120            James Johnson  MIA       PF     81    250  29          7
    ## 121           Josh McRoberts  MIA       PF     82    240  29          9
    ## 122          Josh Richardson  MIA       SG     78    200  23          1
    ## 123          Justise Winslow  MIA       SF     79    225  20          1
    ## 124             Luke Babbitt  MIA       SF     81    225  27          6
    ## 125              Okaro White  MIA       PF     80    204  24          0
    ## 126          Rodney McGruder  MIA       SG     76    205  25          0
    ## 127            Tyler Johnson  MIA       PG     76    186  24          2
    ## 128            Udonis Haslem  MIA        C     80    235  36         13
    ## 129          Wayne Ellington  MIA       SG     76    200  29          7
    ## 130              Willie Reed  MIA        C     82    220  26          1
    ## 131           Andre Drummond  DET        C     83    279  23          4
    ## 132              Aron Baynes  DET        C     82    260  30          4
    ## 133               Beno Udrih  DET       PG     75    205  34         12
    ## 134         Boban Marjanovic  DET        C     87    290  28          1
    ## 135          Darrun Hilliard  DET       SG     78    205  23          1
    ## 136           Henry Ellenson  DET       PF     83    245  20          0
    ## 137                Ish Smith  DET       PG     72    175  28          6
    ## 138                Jon Leuer  DET       PF     82    228  27          5
    ## 139 Kentavious Caldwell-Pope  DET       SG     77    205  23          3
    ## 140            Marcus Morris  DET       SF     81    235  27          5
    ## 141          Michael Gbinije  DET       SG     79    200  24          0
    ## 142           Reggie Bullock  DET       SF     79    205  25          3
    ## 143           Reggie Jackson  DET       PG     75    208  26          5
    ## 144          Stanley Johnson  DET       SF     79    245  20          1
    ## 145            Tobias Harris  DET       PF     81    235  24          5
    ## 146            Brian Roberts  CHO       PG     73    173  31          4
    ## 147            Briante Weber  CHO       PG     74    165  24          1
    ## 148           Christian Wood  CHO       PF     83    220  21          1
    ## 149              Cody Zeller  CHO       PF     84    240  24          3
    ## 150           Frank Kaminsky  CHO        C     84    242  23          1
    ## 151              Jeremy Lamb  CHO       SG     77    185  24          4
    ## 152          Johnny O'Bryant  CHO       PF     81    257  23          2
    ## 153             Kemba Walker  CHO       PG     73    172  26          5
    ## 154          Marco Belinelli  CHO       SG     77    210  30          9
    ## 155          Marvin Williams  CHO       PF     81    237  30         11
    ## 156   Michael Kidd-Gilchrist  CHO       SF     79    232  23          4
    ## 157            Miles Plumlee  CHO        C     83    249  28          4
    ## 158            Nicolas Batum  CHO       SG     80    200  28          8
    ## 159           Ramon Sessions  CHO       PG     75    190  30          9
    ## 160           Treveon Graham  CHO       SG     78    220  23          0
    ## 161          Carmelo Anthony  NYK       SF     80    240  32         13
    ## 162           Chasson Randle  NYK       PG     74    185  23          0
    ## 163             Courtney Lee  NYK       SG     77    200  31          8
    ## 164             Derrick Rose  NYK       PG     75    190  28          7
    ## 165              Joakim Noah  NYK        C     83    230  31          9
    ## 166           Justin Holiday  NYK       SG     78    185  27          3
    ## 167       Kristaps Porzingis  NYK       PF     87    240  21          1
    ## 168             Kyle O'Quinn  NYK        C     82    250  26          4
    ## 169             Lance Thomas  NYK       PF     80    235  28          5
    ## 170         Marshall Plumlee  NYK        C     84    250  24          0
    ## 171            Maurice Ndour  NYK       PF     81    200  24          0
    ## 172     Mindaugas Kuzminskas  NYK       SF     81    215  27          0
    ## 173                Ron Baker  NYK       SG     76    220  23          0
    ## 174            Sasha Vujacic  NYK       SG     79    195  32          9
    ## 175        Willy Hernangomez  NYK        C     83    240  22          0
    ## 176             Aaron Gordon  ORL       SF     81    220  21          2
    ## 177          Bismack Biyombo  ORL        C     81    255  24          5
    ## 178              C.J. Watson  ORL       PG     74    175  32          9
    ## 179            D.J. Augustin  ORL       PG     72    183  29          8
    ## 180             Damjan Rudez  ORL       SF     82    228  30          2
    ## 181            Elfrid Payton  ORL       PG     76    185  22          2
    ## 182            Evan Fournier  ORL       SG     79    205  24          4
    ## 183               Jeff Green  ORL       PF     81    235  30          8
    ## 184              Jodie Meeks  ORL       SG     76    210  29          7
    ## 185      Marcus Georges-Hunt  ORL       SG     77    216  22          0
    ## 186            Mario Hezonja  ORL       SF     80    215  21          1
    ## 187           Nikola Vucevic  ORL        C     84    260  26          5
    ## 188          Patricio Garino  ORL       SG     78    210  23          0
    ## 189        Stephen Zimmerman  ORL        C     84    240  20          0
    ## 190            Terrence Ross  ORL       SF     79    206  25          4
    ## 191           Alex Poythress  PHI       PF     79    238  23          0
    ## 192              Dario Saric  PHI       PF     82    223  22          0
    ## 193         Gerald Henderson  PHI       SG     77    215  29          7
    ## 194            Jahlil Okafor  PHI        C     83    275  21          1
    ## 195           Jerryd Bayless  PHI       PG     75    200  28          8
    ## 196              Joel Embiid  PHI        C     84    250  22          0
    ## 197          Justin Anderson  PHI       SF     78    228  23          1
    ## 198             Nik Stauskas  PHI       SG     78    205  23          2
    ## 199           Richaun Holmes  PHI        C     82    245  23          1
    ## 200         Robert Covington  PHI       SF     81    215  26          3
    ## 201         Sergio Rodriguez  PHI       PG     75    176  30          4
    ## 202               Shawn Long  PHI        C     81    255  24          0
    ## 203           T.J. McConnell  PHI       PG     74    200  24          1
    ## 204           Tiago Splitter  PHI        C     83    245  32          6
    ## 205  Timothe Luwawu-Cabarrot  PHI       SF     78    205  21          0
    ## 206         Andrew Nicholson  BRK       PF     81    250  27          4
    ## 207           Archie Goodwin  BRK       SG     77    200  22          3
    ## 208              Brook Lopez  BRK        C     84    275  28          8
    ## 209             Caris LeVert  BRK       SF     79    203  22          0
    ## 210         Isaiah Whitehead  BRK       PG     76    213  21          0
    ## 211               Jeremy Lin  BRK       PG     75    200  28          6
    ## 212               Joe Harris  BRK       SG     78    219  25          2
    ## 213          Justin Hamilton  BRK        C     84    260  26          2
    ## 214           K.J. McDaniels  BRK       SF     78    205  23          2
    ## 215               Quincy Acy  BRK       PF     79    240  26          4
    ## 216               Randy Foye  BRK       SG     76    213  33         10
    ## 217  Rondae Hollis-Jefferson  BRK       SF     79    220  22          1
    ## 218          Sean Kilpatrick  BRK       SG     76    210  27          2
    ## 219        Spencer Dinwiddie  BRK       PG     78    200  23          2
    ## 220            Trevor Booker  BRK       PF     80    228  29          6
    ## 221           Andre Iguodala  GSW       SF     78    215  33         12
    ## 222             Damian Jones  GSW        C     84    245  21          0
    ## 223               David West  GSW        C     81    250  36         13
    ## 224           Draymond Green  GSW       PF     79    230  26          4
    ## 225                Ian Clark  GSW       SG     75    175  25          3
    ## 226     James Michael McAdoo  GSW       PF     81    230  24          2
    ## 227             JaVale McGee  GSW        C     84    270  29          8
    ## 228             Kevin Durant  GSW       SF     81    240  28          9
    ## 229             Kevon Looney  GSW        C     81    220  20          1
    ## 230            Klay Thompson  GSW       SG     79    215  26          5
    ## 231              Matt Barnes  GSW       SF     79    226  36         13
    ## 232            Patrick McCaw  GSW       SG     79    185  21          0
    ## 233         Shaun Livingston  GSW       PG     79    192  31         11
    ## 234            Stephen Curry  GSW       PG     75    190  28          7
    ## 235            Zaza Pachulia  GSW        C     83    270  32         13
    ## 236              Bryn Forbes  SAS       SG     75    190  23          0
    ## 237              Danny Green  SAS       SG     78    215  29          7
    ## 238                David Lee  SAS       PF     81    245  33         11
    ## 239            Davis Bertans  SAS       PF     82    210  24          0
    ## 240          Dejounte Murray  SAS       PG     77    170  20          0
    ## 241           Dewayne Dedmon  SAS        C     84    245  27          3
    ## 242             Joel Anthony  SAS        C     81    245  34          9
    ## 243         Jonathon Simmons  SAS       SG     78    195  27          1
    ## 244            Kawhi Leonard  SAS       SF     79    230  25          5
    ## 245            Kyle Anderson  SAS       SG     81    230  23          2
    ## 246        LaMarcus Aldridge  SAS       PF     83    260  31         10
    ## 247            Manu Ginobili  SAS       SG     78    205  39         14
    ## 248              Patty Mills  SAS       PG     72    185  28          7
    ## 249                Pau Gasol  SAS        C     84    250  36         15
    ## 250              Tony Parker  SAS       PG     74    185  34         15
    ## 251              Bobby Brown  HOU       PG     74    175  32          2
    ## 252           Chinanu Onuaku  HOU        C     82    245  20          0
    ## 253             Clint Capela  HOU        C     82    240  22          2
    ## 254              Eric Gordon  HOU       SG     76    215  28          8
    ## 255            Isaiah Taylor  HOU       PG     75    170  22          0
    ## 256             James Harden  HOU       PG     77    220  27          7
    ## 257             Kyle Wiltjer  HOU       PF     82    240  24          0
    ## 258             Lou Williams  HOU       SG     73    175  30         11
    ## 259         Montrezl Harrell  HOU        C     80    240  23          1
    ## 260         Patrick Beverley  HOU       SG     73    185  28          4
    ## 261            Ryan Anderson  HOU       PF     82    240  28          8
    ## 262               Sam Dekker  HOU       SF     81    230  22          1
    ## 263             Trevor Ariza  HOU       SF     80    215  31         12
    ## 264            Troy Williams  HOU       SF     79    218  22          0
    ## 265            Alan Anderson  LAC       SF     78    220  34          7
    ## 266            Austin Rivers  LAC       SG     76    200  24          4
    ## 267            Blake Griffin  LAC       PF     82    251  27          6
    ## 268             Brandon Bass  LAC       PF     80    250  31         11
    ## 269            Brice Johnson  LAC       PF     82    230  22          0
    ## 270               Chris Paul  LAC       PG     72    175  31         11
    ## 271           DeAndre Jordan  LAC        C     83    265  28          8
    ## 272            Diamond Stone  LAC        C     83    255  19          0
    ## 273              J.J. Redick  LAC       SG     76    190  32         10
    ## 274           Jamal Crawford  LAC       SG     77    200  36         16
    ## 275         Luc Mbah a Moute  LAC       SF     80    230  30          8
    ## 276        Marreese Speights  LAC        C     82    255  29          8
    ## 277              Paul Pierce  LAC       SF     79    235  39         18
    ## 278           Raymond Felton  LAC       PG     73    205  32         11
    ## 279           Wesley Johnson  LAC       SF     79    215  29          6
    ## 280               Alec Burks  UTA       SG     78    214  25          5
    ## 281               Boris Diaw  UTA       PF     80    250  34         13
    ## 282               Dante Exum  UTA       PG     78    190  21          1
    ## 283           Derrick Favors  UTA       PF     82    265  25          6
    ## 284              George Hill  UTA       PG     75    188  30          8
    ## 285           Gordon Hayward  UTA       SF     80    226  26          6
    ## 286              Jeff Withey  UTA        C     84    231  26          3
    ## 287               Joe Ingles  UTA       SF     80    226  29          2
    ## 288              Joe Johnson  UTA       SF     79    240  35         15
    ## 289            Joel Bolomboy  UTA       PF     81    235  23          0
    ## 290                Raul Neto  UTA       PG     73    179  24          1
    ## 291              Rodney Hood  UTA       SG     80    206  24          2
    ## 292              Rudy Gobert  UTA        C     85    245  24          3
    ## 293             Shelvin Mack  UTA       PG     75    203  26          5
    ## 294               Trey Lyles  UTA       PF     82    234  21          1
    ## 295             Alex Abrines  OKC       SG     78    190  23          0
    ## 296           Andre Roberson  OKC       SF     79    210  25          3
    ## 297         Domantas Sabonis  OKC       PF     83    240  20          0
    ## 298           Doug McDermott  OKC       SF     80    225  25          2
    ## 299              Enes Kanter  OKC        C     83    245  24          5
    ## 300             Jerami Grant  OKC       SF     80    210  22          2
    ## 301             Josh Huestis  OKC       PF     79    230  25          1
    ## 302             Kyle Singler  OKC       SF     80    228  28          4
    ## 303            Nick Collison  OKC       PF     82    255  36         12
    ## 304              Norris Cole  OKC       PG     74    175  28          5
    ## 305        Russell Westbrook  OKC       PG     75    200  28          8
    ## 306           Semaj Christon  OKC       PG     75    190  24          0
    ## 307             Steven Adams  OKC        C     84    255  23          3
    ## 308               Taj Gibson  OKC       PF     81    225  31          7
    ## 309           Victor Oladipo  OKC       SG     76    210  24          3
    ## 310          Andrew Harrison  MEM       PG     78    213  22          0
    ## 311           Brandan Wright  MEM       PF     82    210  29          8
    ## 312         Chandler Parsons  MEM       SF     82    230  28          5
    ## 313            Deyonta Davis  MEM        C     83    237  20          0
    ## 314              James Ennis  MEM       SF     79    210  26          2
    ## 315           JaMychal Green  MEM       PF     81    227  26          2
    ## 316            Jarell Martin  MEM       PF     82    239  22          1
    ## 317               Marc Gasol  MEM        C     85    255  32          8
    ## 318              Mike Conley  MEM       PG     73    175  29          9
    ## 319               Tony Allen  MEM       SG     76    213  35         12
    ## 320             Troy Daniels  MEM       SG     76    205  25          3
    ## 321             Vince Carter  MEM       SF     78    220  40         18
    ## 322             Wade Baldwin  MEM       PG     76    202  20          0
    ## 323             Wayne Selden  MEM       SG     77    230  22          0
    ## 324            Zach Randolph  MEM       PF     81    260  35         15
    ## 325          Al-Farouq Aminu  POR       SF     81    220  26          6
    ## 326             Allen Crabbe  POR       SG     78    210  24          3
    ## 327            C.J. McCollum  POR       SG     76    200  25          3
    ## 328           Damian Lillard  POR       PG     75    195  26          4
    ## 329                 Ed Davis  POR       PF     82    240  27          6
    ## 330              Evan Turner  POR       SF     79    220  28          6
    ## 331              Jake Layman  POR       SF     81    210  22          0
    ## 332             Jusuf Nurkic  POR        C     84    280  22          2
    ## 333         Maurice Harkless  POR       SF     81    215  23          4
    ## 334           Meyers Leonard  POR       PF     85    245  24          4
    ## 335              Noah Vonleh  POR       PF     82    240  21          2
    ## 336          Pat Connaughton  POR       SG     77    206  24          1
    ## 337           Shabazz Napier  POR       PG     73    175  25          2
    ## 338           Tim Quarterman  POR       SG     78    195  22          0
    ## 339         Danilo Gallinari  DEN       SF     82    225  28          7
    ## 340           Darrell Arthur  DEN       PF     81    235  28          7
    ## 341          Emmanuel Mudiay  DEN       PG     77    200  20          1
    ## 342              Gary Harris  DEN       SG     76    210  22          2
    ## 343             Jamal Murray  DEN       SG     76    207  19          0
    ## 344            Jameer Nelson  DEN       PG     72    190  34         12
    ## 345         Juan Hernangomez  DEN       PF     81    230  21          0
    ## 346           Kenneth Faried  DEN       PF     80    228  27          5
    ## 347            Malik Beasley  DEN       SG     77    196  20          0
    ## 348            Mason Plumlee  DEN        C     83    245  26          3
    ## 349              Mike Miller  DEN       SF     80    218  36         16
    ## 350             Nikola Jokic  DEN        C     82    250  21          1
    ## 351              Roy Hibbert  DEN        C     86    270  30          8
    ## 352              Will Barton  DEN       SG     78    175  26          4
    ## 353          Wilson Chandler  DEN       SF     80    225  29          8
    ## 354            Alexis Ajinca  NOP        C     86    248  28          6
    ## 355            Anthony Davis  NOP        C     82    253  23          4
    ## 356             Axel Toupane  NOP       SF     79    197  24          1
    ## 357            Cheick Diallo  NOP       PF     81    220  20          0
    ## 358         Dante Cunningham  NOP       SF     80    230  29          7
    ## 359         DeMarcus Cousins  NOP        C     83    270  26          6
    ## 360       Donatas Motiejunas  NOP       PF     84    222  26          4
    ## 361            E'Twaun Moore  NOP       SG     76    191  27          5
    ## 362          Jordan Crawford  NOP       SG     76    195  28          4
    ## 363             Jrue Holiday  NOP       PG     76    205  26          7
    ## 364                Omer Asik  NOP        C     84    255  30          6
    ## 365               Quinn Cook  NOP       PG     74    184  23          0
    ## 366             Solomon Hill  NOP       SF     79    225  25          3
    ## 367              Tim Frazier  NOP       PG     73    170  26          2
    ## 368             A.J. Hammons  DAL        C     84    260  24          0
    ## 369          DeAndre Liggins  DAL       SG     78    209  28          3
    ## 370             Devin Harris  DAL       PG     75    192  33         12
    ## 371            Dirk Nowitzki  DAL       PF     84    245  38         18
    ## 372      Dorian Finney-Smith  DAL       PF     80    220  23          0
    ## 373            Dwight Powell  DAL        C     83    240  25          2
    ## 374          Harrison Barnes  DAL       PF     80    210  24          4
    ## 375               J.J. Barea  DAL       PG     72    185  32         10
    ## 376            Jarrod Uthoff  DAL       PF     81    221  23          0
    ## 377             Nerlens Noel  DAL        C     83    228  22          2
    ## 378         Nicolas Brussino  DAL       SF     79    195  23          0
    ## 379              Salah Mejri  DAL        C     85    245  30          1
    ## 380               Seth Curry  DAL       PG     74    185  26          3
    ## 381          Wesley Matthews  DAL       SG     77    220  30          7
    ## 382             Yogi Ferrell  DAL       PG     72    180  23          0
    ## 383         Anthony Tolliver  SAC       PF     80    240  31          8
    ## 384            Arron Afflalo  SAC       SG     77    210  31          9
    ## 385             Ben McLemore  SAC       SG     77    195  23          3
    ## 386              Buddy Hield  SAC       SG     76    214  23          0
    ## 387          Darren Collison  SAC       PG     72    175  29          7
    ## 388           Garrett Temple  SAC       SG     78    195  30          6
    ## 389     Georgios Papagiannis  SAC        C     85    240  19          0
    ## 390             Kosta Koufos  SAC        C     84    265  27          8
    ## 391        Langston Galloway  SAC       PG     74    200  25          2
    ## 392       Malachi Richardson  SAC       SG     78    205  21          0
    ## 393                 Rudy Gay  SAC       SF     80    230  30         10
    ## 394          Skal Labissiere  SAC       PF     83    225  20          0
    ## 395                Ty Lawson  SAC       PG     71    195  29          7
    ## 396             Tyreke Evans  SAC       SF     78    220  27          7
    ## 397      Willie Cauley-Stein  SAC        C     84    240  23          1
    ## 398            Adreian Payne  MIN       PF     82    237  25          2
    ## 399           Andrew Wiggins  MIN       SF     80    199  21          2
    ## 400             Brandon Rush  MIN       SG     78    220  31          8
    ## 401             Cole Aldrich  MIN        C     83    250  28          6
    ## 402             Gorgui Dieng  MIN       PF     83    241  27          3
    ## 403              Jordan Hill  MIN        C     82    235  29          7
    ## 404       Karl-Anthony Towns  MIN        C     84    244  21          1
    ## 405                Kris Dunn  MIN       PG     76    210  22          0
    ## 406          Nemanja Bjelica  MIN       PF     82    240  28          1
    ## 407              Omri Casspi  MIN       SF     81    225  28          7
    ## 408              Ricky Rubio  MIN       PG     76    194  26          5
    ## 409         Shabazz Muhammad  MIN       SF     78    223  24          3
    ## 410               Tyus Jones  MIN       PG     74    195  20          1
    ## 411              Zach LaVine  MIN       SG     77    189  21          2
    ## 412           Brandon Ingram  LAL       SF     81    190  19          0
    ## 413             Corey Brewer  LAL       SF     81    186  30          9
    ## 414         D'Angelo Russell  LAL       PG     77    195  20          1
    ## 415              David Nwaba  LAL       SG     76    209  24          0
    ## 416              Ivica Zubac  LAL        C     85    265  19          0
    ## 417          Jordan Clarkson  LAL       SG     77    194  24          2
    ## 418            Julius Randle  LAL       PF     81    250  22          2
    ## 419          Larry Nance Jr.  LAL       PF     81    230  24          1
    ## 420                Luol Deng  LAL       SF     81    220  31         12
    ## 421        Metta World Peace  LAL       SF     78    260  37         16
    ## 422               Nick Young  LAL       SG     79    210  31          9
    ## 423              Tarik Black  LAL        C     81    250  25          2
    ## 424          Thomas Robinson  LAL       PF     82    237  25          4
    ## 425           Timofey Mozgov  LAL        C     85    275  30          6
    ## 426              Tyler Ennis  LAL       PG     75    194  22          2
    ## 427            Alan Williams  PHO        C     80    260  24          1
    ## 428                 Alex Len  PHO        C     85    260  23          3
    ## 429           Brandon Knight  PHO       SG     75    189  25          5
    ## 430            Derrick Jones  PHO       SF     79    190  19          0
    ## 431             Devin Booker  PHO       SG     78    206  20          1
    ## 432            Dragan Bender  PHO       PF     85    225  19          0
    ## 433           Elijah Millsap  PHO       SG     78    225  29          2
    ## 434             Eric Bledsoe  PHO       PG     73    190  27          6
    ## 435             Jared Dudley  PHO       PF     79    225  31          9
    ## 436          Leandro Barbosa  PHO       SG     75    194  34         13
    ## 437          Marquese Chriss  PHO       PF     82    233  19          0
    ## 438             Ronnie Price  PHO       PG     74    190  33         11
    ## 439              T.J. Warren  PHO       SF     80    230  23          2
    ## 440               Tyler Ulis  PHO       PG     70    150  21          0
    ## 441           Tyson Chandler  PHO        C     85    240  34         15
    ##                                                      college   salary
    ## 1                                      University of Florida 26540100
    ## 2                                                            12000000
    ## 3                              University of Texas at Austin  8269663
    ## 4                                   University of Notre Dame  1450000
    ## 5                                                             1410598
    ## 6                                   University of Washington  6587132
    ## 7                                       Marquette University  6286408
    ## 8                                     University of Kentucky  1825200
    ## 9                                   University of California  4743000
    ## 10                                                            5000000
    ## 11                                Louisiana State University  1223653
    ## 12                                        Gonzaga University  3094014
    ## 13                                 Oklahoma State University  3578880
    ## 14                                  University of Louisville  1906440
    ## 15                              University of North Carolina  8000000
    ## 16                                     University of Arizona  7806971
    ## 17                                           Duke University    18255
    ## 18                University of Illinois at Urbana-Champaign   259626
    ## 19                                     University of Arizona   268029
    ## 20                                                               5145
    ## 21                           Georgia Institute of Technology  9700000
    ## 22                                                           12800000
    ## 23                                       University of Miami  1551659
    ## 24                                        Oakland University   543471
    ## 25                     University of California, Los Angeles 21165675
    ## 26                                      Creighton University  5239437
    ## 27                                           Duke University 17638063
    ## 28                                                           30963450
    ## 29                                     University of Arizona  2500000
    ## 30                             University of Texas at Austin 15330435
    ## 31                                                            1589640
    ## 32                             University of Texas at Austin  7330000
    ## 33                                        University of Utah  1577280
    ## 34                         University of Southern California 26540100
    ## 35                                    University of Missouri 14200000
    ## 36                                  Wichita State University   543471
    ## 37                                        University of Utah  2703960
    ## 38                                                           14382022
    ## 39                                      Villanova University 12000000
    ## 40                                                            1921320
    ## 41                     University of California, Los Angeles   874636
    ## 42                             University of Texas at Austin  5300000
    ## 43                               New Mexico State University  1196040
    ## 44                                    University of Kentucky  6050000
    ## 45                                                           12250000
    ## 46                                                            3730653
    ## 47                                     University of Florida 22116750
    ## 48                                                            1200000
    ## 49                                       Syracuse University  1191480
    ## 50                                      Villanova University   543471
    ## 51                                                           15944154
    ## 52                                 Colorado State University  5000000
    ## 53                                    University of Kentucky 16957900
    ## 54                                                           12000000
    ## 55                                      University of Kansas  7400000
    ## 56                                     Georgetown University  5893981
    ## 57                                       University of Miami   543471
    ## 58                                                            2870813
    ## 59                                    University of Michigan  3386598
    ## 60                                 Saint Joseph's University  1499760
    ## 61                                                            2708582
    ## 62                                                           23180275
    ## 63                                                            8400000
    ## 64                                                             392478
    ## 65                                   Old Dominion University 15730338
    ## 66                                   University of Minnesota  4000000
    ## 67       Virginia Polytechnic Institute and State University  2500000
    ## 68                                           Duke University  4837500
    ## 69                                       Bucknell University  1015696
    ## 70                                 Louisiana Tech University 20072033
    ## 71                                           Duke University   418228
    ## 72                                                            3850000
    ## 73                                    University of Michigan  2281605
    ## 74                                                            2995421
    ## 75                                     Georgetown University 17100000
    ## 76                                           Duke University  5374320
    ## 77                                     University of Arizona  1551659
    ## 78                              University of North Carolina 12517606
    ## 79                                      Texas A&M University 15200000
    ## 80                                    University of Virginia   925000
    ## 81                        Saint Mary's College of California  9607500
    ## 82                                   Kansas State University  1403611
    ## 83                                                           10500000
    ## 84                           University of Nevada, Las Vegas  1811040
    ## 85                                  University of Washington  6348759
    ## 86                                                            2568600
    ## 87                                  University of New Mexico  2368327
    ## 88                                      University of Oregon  2700000
    ## 89                                                           10230179
    ## 90                                                            4583450
    ## 91                                     Iowa State University   650000
    ## 92                                    Wake Forest University  8800000
    ## 93                                      University of Oregon  1052342
    ## 94                                                            1800000
    ## 95                                  University of Cincinnati  4000000
    ## 96                                         Temple University  4000000
    ## 97                                                           10770000
    ## 98                             University of Texas at Austin  2463840
    ## 99                       California State University, Fresno 18314532
    ## 100                                      Syracuse University  1052342
    ## 101                          Georgia Institute of Technology 14153652
    ## 102                          Georgia Institute of Technology  3488000
    ## 103                                   University of Arkansas  1453680
    ## 104                                  Murray State University  2112480
    ## 105                                                            874636
    ## 106                                Michigan State University  2092200
    ## 107                                     Marquette University 23200000
    ## 108                                  Murray State University  1015696
    ## 109                                 University of Notre Dame  1643040
    ## 110                                     Marquette University 17552209
    ## 111                                                           1709720
    ## 112                                      Syracuse University  3183526
    ## 113                                                           5782450
    ## 114                                                            750000
    ## 115                                   University of Kentucky 14000000
    ## 116                                      Stanford University 13219250
    ## 117                                      Syracuse University  2898000
    ## 118                                                          15890000
    ## 119                                      Marshall University 22116750
    ## 120                                   Wake Forest University  4000000
    ## 121                                          Duke University  5782450
    ## 122                                  University of Tennessee   874636
    ## 123                                          Duke University  2593440
    ## 124                               University of Nevada, Reno  1227000
    ## 125                                 Florida State University   210995
    ## 126                                  Kansas State University   543471
    ## 127                      California State University, Fresno  5628000
    ## 128                                    University of Florida  4000000
    ## 129                             University of North Carolina  6000000
    ## 130                                   Saint Louis University  1015696
    ## 131                                University of Connecticut 22116750
    ## 132                              Washington State University  6500000
    ## 133                                                           1551659
    ## 134                                                           7000000
    ## 135                                     Villanova University   874060
    ## 136                                     Marquette University  1704120
    ## 137                                   Wake Forest University  6000000
    ## 138                                  University of Wisconsin 10991957
    ## 139                                    University of Georgia  3678319
    ## 140                                     University of Kansas  4625000
    ## 141                                      Syracuse University   650000
    ## 142                             University of North Carolina  2255644
    ## 143                                           Boston College 14956522
    ## 144                                    University of Arizona  2969880
    ## 145                                  University of Tennessee 17200000
    ## 146                                     University of Dayton  1050961
    ## 147                         Virginia Commonwealth University   102898
    ## 148                          University of Nevada, Las Vegas   874636
    ## 149                                       Indiana University  5318313
    ## 150                                  University of Wisconsin  2730000
    ## 151                                University of Connecticut  6511628
    ## 152                               Louisiana State University   161483
    ## 153                                University of Connecticut 12000000
    ## 154                                                           6333333
    ## 155                             University of North Carolina 12250000
    ## 156                                   University of Kentucky 13000000
    ## 157                                          Duke University 12500000
    ## 158                                                          20869566
    ## 159                               University of Nevada, Reno  6000000
    ## 160                         Virginia Commonwealth University   543471
    ## 161                                      Syracuse University 24559380
    ## 162                                      Stanford University   143860
    ## 163                              Western Kentucky University 11242000
    ## 164                                    University of Memphis 21323250
    ## 165                                    University of Florida 17000000
    ## 166                                 University of Washington  1015696
    ## 167                                                           4317720
    ## 168                                 Norfolk State University  3900000
    ## 169                                          Duke University  6191000
    ## 170                                          Duke University   543471
    ## 171                                          Ohio University   543471
    ## 172                                                           2898000
    ## 173                                 Wichita State University   543471
    ## 174                                                           1410598
    ## 175                                                           1375000
    ## 176                                    University of Arizona  4351320
    ## 177                                                          17000000
    ## 178                                  University of Tennessee  5000000
    ## 179                            University of Texas at Austin  7250000
    ## 180                                                            980431
    ## 181                     University of Louisiana at Lafayette  2613600
    ## 182                                                          17000000
    ## 183                                    Georgetown University 15000000
    ## 184                                   University of Kentucky  6540000
    ## 185                          Georgia Institute of Technology    31969
    ## 186                                                           3909840
    ## 187                        University of Southern California 11750000
    ## 188                             George Washington University    31969
    ## 189                          University of Nevada, Las Vegas   950000
    ## 190                                 University of Washington 10000000
    ## 191                                   University of Kentucky    31969
    ## 192                                                           2318280
    ## 193                                          Duke University  9000000
    ## 194                                          Duke University  4788840
    ## 195                                    University of Arizona  9424084
    ## 196                                     University of Kansas  4826160
    ## 197                                   University of Virginia  1514160
    ## 198                                   University of Michigan  2993040
    ## 199                           Bowling Green State University  1025831
    ## 200                               Tennessee State University  1015696
    ## 201                                                           8000000
    ## 202                     University of Louisiana at Lafayette    89513
    ## 203                                    University of Arizona   874636
    ## 204                                                           8550000
    ## 205                                                           1326960
    ## 206                               St. Bonaventure University  6088993
    ## 207                                   University of Kentucky   119494
    ## 208                                      Stanford University 21165675
    ## 209                                   University of Michigan  1562280
    ## 210                                    Seton Hall University  1074145
    ## 211                                       Harvard University 11483254
    ## 212                                   University of Virginia   980431
    ## 213                               Louisiana State University  3000000
    ## 214                                       Clemson University  3333333
    ## 215                                        Baylor University  1790902
    ## 216                                     Villanova University  2500000
    ## 217                                    University of Arizona  1395600
    ## 218                                 University of Cincinnati   980431
    ## 219                                   University of Colorado   726672
    ## 220                                       Clemson University  9250000
    ## 221                                    University of Arizona 11131368
    ## 222                                    Vanderbilt University  1171560
    ## 223                                        Xavier University  1551659
    ## 224                                Michigan State University 15330435
    ## 225                                       Belmont University  1015696
    ## 226                             University of North Carolina   980431
    ## 227                               University of Nevada, Reno  1403611
    ## 228                            University of Texas at Austin 26540100
    ## 229                    University of California, Los Angeles  1182840
    ## 230                              Washington State University 16663575
    ## 231                    University of California, Los Angeles   383351
    ## 232                          University of Nevada, Las Vegas   543471
    ## 233                                                           5782450
    ## 234                                         Davidson College 12112359
    ## 235                                                           2898000
    ## 236                                Michigan State University   543471
    ## 237                             University of North Carolina 10000000
    ## 238                                    University of Florida  1551659
    ## 239                                                            543471
    ## 240                                 University of Washington  1180080
    ## 241                        University of Southern California  2898000
    ## 242                          University of Nevada, Las Vegas   165952
    ## 243                                    University of Houston   874636
    ## 244                               San Diego State University 17638063
    ## 245                    University of California, Los Angeles  1192080
    ## 246                            University of Texas at Austin 20575005
    ## 247                                                          14000000
    ## 248                       Saint Mary's College of California  3578948
    ## 249                                                          15500000
    ## 250                                                          14445313
    ## 251                   California State University, Fullerton   680534
    ## 252                                 University of Louisville   543471
    ## 253                                                           1296240
    ## 254                                       Indiana University 12385364
    ## 255                            University of Texas at Austin   255000
    ## 256                                 Arizona State University 26540100
    ## 257                                       Gonzaga University   543471
    ## 258                                                           7000000
    ## 259                                 University of Louisville  1000000
    ## 260                                   University of Arkansas  6000000
    ## 261                                 University of California 18735364
    ## 262                                  University of Wisconsin  1720560
    ## 263                    University of California, Los Angeles  7806971
    ## 264                                       Indiana University   150000
    ## 265                                Michigan State University  1315448
    ## 266                                          Duke University 11000000
    ## 267                                   University of Oklahoma 20140838
    ## 268                               Louisiana State University  1551659
    ## 269                             University of North Carolina  1273920
    ## 270                                   Wake Forest University 22868828
    ## 271                                     Texas A&M University 21165675
    ## 272                                   University of Maryland   543471
    ## 273                                          Duke University  7377500
    ## 274                                   University of Michigan 13253012
    ## 275                    University of California, Los Angeles  2203000
    ## 276                                    University of Florida  1403611
    ## 277                                     University of Kansas  3500000
    ## 278                             University of North Carolina  1551659
    ## 279                                      Syracuse University  5628000
    ## 280                                   University of Colorado 10154495
    ## 281                                                           7000000
    ## 282                                                           3940320
    ## 283                          Georgia Institute of Technology 11050000
    ## 284        Indiana University-Purdue University Indianapolis  8000000
    ## 285                                        Butler University 16073140
    ## 286                                     University of Kansas  1015696
    ## 287                                                           2250000
    ## 288                                   University of Arkansas 11000000
    ## 289                                   Weber State University   600000
    ## 290                                                            937800
    ## 291                                          Duke University  1406520
    ## 292                                                           2121288
    ## 293                                        Butler University  2433334
    ## 294                                   University of Kentucky  2340600
    ## 295                                                           5994764
    ## 296                                   University of Colorado  2183072
    ## 297                                       Gonzaga University  2440200
    ## 298                                     Creighton University  2483040
    ## 299                                                          17145838
    ## 300                                      Syracuse University   980431
    ## 301                                      Stanford University  1191480
    ## 302                                          Duke University  4837500
    ## 303                                     University of Kansas  3750000
    ## 304                               Cleveland State University   247991
    ## 305                    University of California, Los Angeles 26540100
    ## 306                                        Xavier University   543471
    ## 307                                 University of Pittsburgh  3140517
    ## 308                        University of Southern California  8950000
    ## 309                                       Indiana University  6552960
    ## 310                                   University of Kentucky   945000
    ## 311                             University of North Carolina  5700000
    ## 312                                    University of Florida 22116750
    ## 313                                Michigan State University  1369229
    ## 314                  California State University, Long Beach  2898000
    ## 315                                    University of Alabama   980431
    ## 316                               Louisiana State University  1286160
    ## 317                                                          21165675
    ## 318                                    Ohio State University 26540100
    ## 319                                Oklahoma State University  5505618
    ## 320                         Virginia Commonwealth University  3332940
    ## 321                             University of North Carolina  4264057
    ## 322                                    Vanderbilt University  1793760
    ## 323                                     University of Kansas    83119
    ## 324                                Michigan State University 10361445
    ## 325                                   Wake Forest University  7680965
    ## 326                                 University of California 18500000
    ## 327                                        Lehigh University  3219579
    ## 328                                   Weber State University 24328425
    ## 329                             University of North Carolina  6666667
    ## 330                                    Ohio State University 16393443
    ## 331                                   University of Maryland   600000
    ## 332                                                           1921320
    ## 333                                    St. John's University  8988764
    ## 334               University of Illinois at Urbana-Champaign  9213484
    ## 335                                       Indiana University  2751360
    ## 336                                 University of Notre Dame   874636
    ## 337                                University of Connecticut  1350120
    ## 338                               Louisiana State University   543471
    ## 339                                                          15050000
    ## 340                                     University of Kansas  8070175
    ## 341                                                           3241800
    ## 342                                Michigan State University  1655880
    ## 343                                   University of Kentucky  3210840
    ## 344                                Saint Joseph's University  4540525
    ## 345                                                           1987440
    ## 346                                Morehead State University 12078652
    ## 347                                 Florida State University  1627320
    ## 348                                          Duke University  2328530
    ## 349                                    University of Florida  3500000
    ## 350                                                           1358500
    ## 351                                    Georgetown University  5000000
    ## 352                                    University of Memphis  3533333
    ## 353                                        DePaul University 11200000
    ## 354                                                           4600000
    ## 355                                   University of Kentucky 22116750
    ## 356                                                             20580
    ## 357                                     University of Kansas   543471
    ## 358                                     Villanova University  2978250
    ## 359                                   University of Kentucky 16957900
    ## 360                                                            576724
    ## 361                                        Purdue University  8081363
    ## 362                                        Xavier University   173094
    ## 363                    University of California, Los Angeles 11286518
    ## 364                                                           9904494
    ## 365                                          Duke University    63938
    ## 366                                    University of Arizona 11241218
    ## 367                            Pennsylvania State University  2090000
    ## 368                                        Purdue University   650000
    ## 369                                   University of Kentucky  1015696
    ## 370                                  University of Wisconsin  4228000
    ## 371                                                          25000000
    ## 372                                    University of Florida   543471
    ## 373                                      Stanford University  8375000
    ## 374                             University of North Carolina 22116750
    ## 375                                  Northeastern University  4096950
    ## 376                                       University of Iowa    63938
    ## 377                                   University of Kentucky  4384490
    ## 378                                                            543471
    ## 379                                                            874636
    ## 380                                          Duke University  2898000
    ## 381                                     Marquette University 17100000
    ## 382                                       Indiana University   207798
    ## 383                                     Creighton University  8000000
    ## 384                    University of California, Los Angeles 12500000
    ## 385                                     University of Kansas  4008882
    ## 386                                   University of Oklahoma  3517200
    ## 387                    University of California, Los Angeles  5229454
    ## 388                               Louisiana State University  8000000
    ## 389                                                           2202240
    ## 390                                    Ohio State University  8046500
    ## 391                                Saint Joseph's University  5200000
    ## 392                                      Syracuse University  1439880
    ## 393                                University of Connecticut 13333333
    ## 394                                   University of Kentucky  1188840
    ## 395                             University of North Carolina  1315448
    ## 396                                    University of Memphis 10661286
    ## 397                                   University of Kentucky  3551160
    ## 398                                Michigan State University  2022240
    ## 399                                     University of Kansas  6006600
    ## 400                                     University of Kansas  3500000
    ## 401                                     University of Kansas  7643979
    ## 402                                 University of Louisville  2348783
    ## 403                                    University of Arizona  3911380
    ## 404                                   University of Kentucky  5960160
    ## 405                                       Providence College  3872520
    ## 406                                                           3800000
    ## 407                                                            138414
    ## 408                                                          13550000
    ## 409                    University of California, Los Angeles  3046299
    ## 410                                          Duke University  1339680
    ## 411                    University of California, Los Angeles  2240880
    ## 412                                          Duke University  5281680
    ## 413                                    University of Florida  7600000
    ## 414                                    Ohio State University  5332800
    ## 415 California Polytechnic State University, San Luis Obispo    73528
    ## 416                                                           1034956
    ## 417                                   University of Missouri 12500000
    ## 418                                   University of Kentucky  3267120
    ## 419                                    University of Wyoming  1207680
    ## 420                                          Duke University 18000000
    ## 421                                    St. John's University  1551659
    ## 422                        University of Southern California  5443918
    ## 423                                     University of Kansas  6191000
    ## 424                                     University of Kansas  1050961
    ## 425                                                          16000000
    ## 426                                      Syracuse University  1733880
    ## 427                  University of California, Santa Barbara   874636
    ## 428                                   University of Maryland  4823621
    ## 429                                   University of Kentucky 12606250
    ## 430                          University of Nevada, Las Vegas   543471
    ## 431                                   University of Kentucky  2223600
    ## 432                                                           4276320
    ## 433                      University of Alabama at Birmingham    23069
    ## 434                                   University of Kentucky 14000000
    ## 435                                           Boston College 10470000
    ## 436                                                           4000000
    ## 437                                 University of Washington  2941440
    ## 438                                Utah Valley State College   282595
    ## 439                          North Carolina State University  2128920
    ## 440                                   University of Kentucky   918369
    ## 441                                                          12415000
    ##     games minutes points      points3 points2 points1
    ## 1      68    2193    952 0.0392156863     293     108
    ## 2      80    1608    520 0.0167910448     186      67
    ## 3      55    1835    894 0.0588555858     251      68
    ## 4       5      17     10 0.0588235294       2       3
    ## 5      47     538    262 0.0724907063      56      33
    ## 6      76    2569   2199 0.0953678474     437     590
    ## 7      72    2335    999 0.0672376874     176     176
    ## 8      29     220     68 0.0545454545      13       6
    ## 9      78    1341    515 0.0343027591     146      85
    ## 10     78    1232    299 0.0365259740      69      26
    ## 11     25     141     38 0.0000000000      15       8
    ## 12     75    1538    678 0.0442132640     192      90
    ## 13     79    2399    835 0.0391829929     175     203
    ## 14     74    1263    410 0.0451306413      94      51
    ## 15     51     525    178 0.0000000000      78      22
    ## 16     74    1398    676 0.0979971388     101      63
    ## 17      1      12      9 0.0000000000       3       3
    ## 18     24     486    179 0.0452674897      46      21
    ## 19     25     427    156 0.0491803279      33      27
    ## 20      1      24      6 0.0000000000       3       0
    ## 21     76    1937    567 0.0485286526     107      71
    ## 22     41    1187    351 0.0800336984      28      10
    ## 23     48     381    132 0.0813648294      13      13
    ## 24     42     386    166 0.0181347150      55      35
    ## 25     60    1885   1142 0.0769230769     225     257
    ## 26     35     859    373 0.1129220023      34      14
    ## 27     72    2525   1816 0.0700990099     494     297
    ## 28     74    2794   1954 0.0443808160     612     358
    ## 29     79    1614    448 0.0384138786      91      80
    ## 30     78    2336    630 0.0000000000     262     106
    ## 31      9      40     14 0.0500000000       4       0
    ## 32     80    2003    740 0.0239640539     251      94
    ## 33     27     446    150 0.0224215247      39      42
    ## 34     74    2620   2020 0.0125954198     688     545
    ## 35     72    1882    638 0.0579171095     111      89
    ## 36     37     294    107 0.0374149660      28      18
    ## 37     54     626    165 0.0000000000      67      31
    ## 38     80    2066    959 0.0004840271     390     176
    ## 39     60    2244   1344 0.0860071301     233     299
    ## 40     57    1088    253 0.0027573529     100      44
    ## 41     76    1368    636 0.0409356725     171     126
    ## 42     24     609    139 0.0394088670      28      11
    ## 43     55     859    229 0.0011641444     102      22
    ## 44     65    1599    445 0.0587867417      60      43
    ## 45     23     712    327 0.0575842697      87      30
    ## 46     26     601    330 0.0748752080      62      71
    ## 47     77    2684   1779 0.0830849478     414     282
    ## 48     23     374     81 0.0294117647      18      12
    ## 49      2       8      1 0.0000000000       0       1
    ## 50     19      75     24 0.0000000000      12       0
    ## 51     31     555    173 0.0000000000      65      43
    ## 52     74    1068    420 0.0346441948     137      35
    ## 53     78    2836   1805 0.0313822285     558     422
    ## 54     82    2556    883 0.0000000000     390     103
    ## 55     76    2374   1063 0.0299073294     335     180
    ## 56     80    2605   1075 0.0568138196     266      99
    ## 57     30     287     90 0.0243902439      23      23
    ## 58     57     719    154 0.0125173853      52      23
    ## 59     57     703    285 0.0440967283      85      22
    ## 60     38     371    101 0.0026954178      46       6
    ## 61     79    2485   1414 0.0402414487     448     218
    ## 62     74    2199   1002 0.0000000000     388     226
    ## 63     26     633    270 0.0505529226      61      52
    ## 64     17     247     61 0.0323886640      15       7
    ## 65     73    1963    801 0.0468670402     203     119
    ## 66     56     689    257 0.0275761974      68      64
    ## 67     73    1248    391 0.0208333333     119      75
    ## 68     30     475    169 0.0694736842      24      22
    ## 69     70    1237    435 0.0371867421     124      49
    ## 70     69    2343   1246 0.0320102433     355     311
    ## 71     16     110     25 0.0363636364       4       5
    ## 72     62    1596    444 0.0256892231     133      55
    ## 73     79    2154   1143 0.0691736305     266     164
    ## 74     80    2845   1832 0.0172231986     607     471
    ## 75     81    1823    951 0.0000000000     387     177
    ## 76     51    1728   1025 0.0376157407     334     162
    ## 77     74    1365    307 0.0534798535      32      24
    ## 78     58    1123    392 0.0000000000     159      74
    ## 79     29     889    426 0.0506186727     105      81
    ## 80     75    1982    767 0.0393541877     212     109
    ## 81     76    1986    577 0.0397784491     129      82
    ## 82     56     935    528 0.0192513369     198      78
    ## 83     70    1133    451 0.0917917034      52      35
    ## 84     41     458    142 0.0567685590      31       2
    ## 85     19     171     83 0.0526315789      21      14
    ## 86     57     562    226 0.0498220641      55      32
    ## 87     80    2336    683 0.0616438356     102      47
    ## 88     65     894    322 0.0536912752      73      32
    ## 89     66     931    535 0.0000000000     235      65
    ## 90     76    1776    815 0.0951576577     112      84
    ## 91     23      93     21 0.0107526882       8       2
    ## 92     82    2657   1254 0.0338727889     312     360
    ## 93     33     135     68 0.0370370370      21      11
    ## 94     49     559    232 0.0000000000     109      14
    ## 95      6     132     43 0.0378787879      13       2
    ## 96     61     871    177 0.0000000000      77      23
    ## 97     74    1998    630 0.0215215215     204      93
    ## 98     81    2541   1173 0.0157418339     404     245
    ## 99     75    2689   1775 0.0725176646     427     336
    ## 100    29     219     59 0.0000000000      19      21
    ## 101    74    2237    814 0.0201162271     317      45
    ## 102     9      87     41 0.0689655172       6      11
    ## 103    64    1000    437 0.0320000000     151      39
    ## 104    11     142     54 0.0774647887      10       1
    ## 105    66    1040    316 0.0000000000     128      60
    ## 106    57     976    291 0.0747950820      29      14
    ## 107    60    1792   1096 0.0251116071     369     223
    ## 108    39     592    181 0.0422297297      38      30
    ## 109    63    1028    370 0.0476653696      79      65
    ## 110    76    2809   1816 0.0323958704     479     585
    ## 111    20     241     89 0.0248962656      31       9
    ## 112    45     846    297 0.0177304965      97      58
    ## 113    70    1679    744 0.0768314473     129      99
    ## 114    44     843    240 0.0391459075      55      31
    ## 115    69    1843    538 0.0271296799     179      30
    ## 116    81    2271    839 0.0000000000     382      75
    ## 117    46    1384    729 0.0614161850     196      82
    ## 118    73    2459   1483 0.0475803172     417     298
    ## 119    77    2513   1309 0.0000000000     542     225
    ## 120    76    2085    975 0.0417266187     281     152
    ## 121    22     381    107 0.0341207349      31       6
    ## 122    53    1614    539 0.0464684015     127      60
    ## 123    18     625    196 0.0112000000      73      29
    ## 124    68    1065    324 0.0816901408      26      11
    ## 125    35     471     98 0.0254777070      21      20
    ## 126    78    1966    497 0.0371312309     117      44
    ## 127    73    2178   1002 0.0426997245     264     195
    ## 128    17     130     31 0.0000000000      11       9
    ## 129    62    1500    648 0.0993333333      82      37
    ## 130    71    1031    374 0.0009699321     161      49
    ## 131    81    2409   1105 0.0008302200     481     137
    ## 132    75    1163    365 0.0000000000     143      79
    ## 133    39     560    227 0.0196428571      81      32
    ## 134    35     293    191 0.0000000000      72      47
    ## 135    39     381    127 0.0314960630      35      21
    ## 136    19     146     60 0.0684931507      13       4
    ## 137    81    1955    758 0.0143222506     301      72
    ## 138    75    1944    767 0.0252057613     261      98
    ## 139    76    2529   1047 0.0604982206     217     154
    ## 140    79    2565   1105 0.0460038986     303     145
    ## 141     9      32      4 0.0000000000       1       2
    ## 142    31     467    141 0.0599571734      26       5
    ## 143    52    1424    752 0.0463483146     218     118
    ## 144    77    1371    339 0.0328227571      84      36
    ## 145    82    2567   1321 0.0424620179     402     190
    ## 146    41     416    142 0.0408653846      29      33
    ## 147    13     159     50 0.0062893082      19       9
    ## 148    13     107     35 0.0000000000      12      11
    ## 149    62    1725    639 0.0000000000     253     133
    ## 150    75    1954    874 0.0593654043     204     118
    ## 151    62    1143    603 0.0358705162     185     110
    ## 152     4      34     18 0.0294117647       7       1
    ## 153    79    2739   1830 0.0876232202     403     304
    ## 154    74    1778    780 0.0573678290     162     150
    ## 155    76    2295    849 0.0540305011     173     131
    ## 156    81    2349    743 0.0004257131     294     152
    ## 157    13     174     31 0.0000000000      14       3
    ## 158    77    2617   1164 0.0515857853     258     243
    ## 159    50     811    312 0.0258939581      79      91
    ## 160    27     189     57 0.0476190476      10      10
    ## 161    74    2538   1659 0.0594956659     451     304
    ## 162    18     225     95 0.0444444444      18      29
    ## 163    77    2459    835 0.0439202928     213      85
    ## 164    64    2082   1154 0.0062439962     447     221
    ## 165    46    1015    232 0.0000000000      99      34
    ## 166    82    1639    629 0.0591824283     136      66
    ## 167    66    2164   1196 0.0517560074     331     198
    ## 168    79    1229    496 0.0016273393     213      64
    ## 169    46     968    275 0.0392561983      59      43
    ## 170    21     170     40 0.0000000000      16       8
    ## 171    32     331     98 0.0030211480      38      19
    ## 172    68    1016    425 0.0531496063     104      55
    ## 173    52     857    215 0.0268378063      59      28
    ## 174    42     408    124 0.0563725490      19      17
    ## 175    72    1324    587 0.0030211480     242      91
    ## 176    80    2298   1019 0.0335073977     316     156
    ## 177    81    1793    483 0.0000000000     179     125
    ## 178    62    1012    281 0.0316205534      64      57
    ## 179    78    1538    616 0.0617685306     100     131
    ## 180    45     314     82 0.0636942675      11       0
    ## 181    82    2412   1046 0.0165837479     390     146
    ## 182    68    2234   1167 0.0572963295     280     223
    ## 183    69    1534    638 0.0345501956     167     145
    ## 184    36     738    327 0.0758807588      47      65
    ## 185     5      48     14 0.0208333333       1       9
    ## 186    65     960    317 0.0447916667      74      40
    ## 187    75    2163   1096 0.0106333796     460     107
    ## 188     5      43      0 0.0000000000       0       0
    ## 189    19     108     23 0.0000000000      10       3
    ## 190    24     748    299 0.0614973262      69      23
    ## 191     6     157     64 0.0382165605      19       8
    ## 192    81    2129   1040 0.0497886332     275     172
    ## 193    72    1667    662 0.0365926815     173     133
    ## 194    50    1134    590 0.0000000000     242     106
    ## 195     3      71     33 0.0281690141       9       9
    ## 196    31     786    627 0.0458015267     164     191
    ## 197    24     518    203 0.0405405405      54      32
    ## 198    80    2188    756 0.0603290676     119     122
    ## 199    57    1193    559 0.0226320201     203      72
    ## 200    67    2119    864 0.0646531383     155     143
    ## 201    68    1518    530 0.0606060606     118      18
    ## 202    18     234    148 0.0299145299      54      19
    ## 203    81    2133    556 0.0051570558     225      73
    ## 204     8      76     39 0.0263157895      12       9
    ## 205    69    1190    445 0.0420168067      95     105
    ## 206    10     111     30 0.0180180180      11       2
    ## 207    12     184     95 0.0217391304      30      23
    ## 208    75    2222   1539 0.0603060306     421     295
    ## 209    57    1237    468 0.0476960388     112      67
    ## 210    73    1643    543 0.0267802800     160      91
    ## 211    36     883    523 0.0656851642     117     115
    ## 212    52    1138    428 0.0746924429      69      35
    ## 213    64    1177    442 0.0467289720     119      39
    ## 214    20     293    126 0.0375426621      35      23
    ## 215    32     510    209 0.0705882353      29      43
    ## 216    69    1284    357 0.0521806854      51      54
    ## 217    78    1761    675 0.0085178876     220     190
    ## 218    70    1754    919 0.0598631699     200     204
    ## 219    59    1334    432 0.0284857571      96     126
    ## 220    71    1754    709 0.0142531357     280      74
    ## 221    76    1998    574 0.0320320320     155      72
    ## 222    10      85     19 0.0000000000       8       3
    ## 223    68     854    316 0.0035128806     132      43
    ## 224    76    2471    776 0.0327802509     191     151
    ## 225    77    1137    527 0.0536499560     150      44
    ## 226    52     457    147 0.0043763676      60      21
    ## 227    77     739    472 0.0000000000     208      56
    ## 228    62    2070   1555 0.0565217391     434     336
    ## 229    53     447    135 0.0044742729      54      21
    ## 230    78    2649   1742 0.1011702529     376     186
    ## 231    20     410    114 0.0439024390      20      20
    ## 232    71    1074    282 0.0381750466      65      29
    ## 233    76    1345    389 0.0007434944     172      42
    ## 234    79    2638   1999 0.1228203184     351     325
    ## 235    70    1268    426 0.0000000000     164      98
    ## 236    36     285     94 0.0596491228      19       5
    ## 237    68    1807    497 0.0653016049      58      27
    ## 238    79    1477    576 0.0000000000     248      80
    ## 239    67     808    303 0.0853960396      34      28
    ## 240    38     322    130 0.0279503106      41      21
    ## 241    76    1330    387 0.0000000000     161      65
    ## 242    19     122     25 0.0000000000      10       5
    ## 243    78    1392    483 0.0215517241     147      99
    ## 244    74    2474   1888 0.0594179466     489     469
    ## 245    72    1020    246 0.0147058824      78      45
    ## 246    72    2335   1243 0.0098501071     477     220
    ## 247    69    1291    517 0.0689388071      82      86
    ## 248    80    1754    759 0.0838084379     126      66
    ## 249    64    1627    792 0.0344191764     247     130
    ## 250    63    1587    638 0.0144927536     242      85
    ## 251    25     123     62 0.1138211382       9       2
    ## 252     5      52     14 0.0000000000       5       4
    ## 253    65    1551    818 0.0000000000     362      94
    ## 254    75    2323   1217 0.1058975463     166     147
    ## 255     4      52      3 0.0000000000       1       1
    ## 256    81    2947   2356 0.0889039701     412     746
    ## 257    14      44     13 0.0909090909       0       1
    ## 258    23     591    343 0.0693739425      61      98
    ## 259    58    1064    527 0.0009398496     224      76
    ## 260    67    2058    639 0.0534499514     118      73
    ## 261    72    2116    979 0.0964083176     119     129
    ## 262    77    1419    504 0.0422832981     143      38
    ## 263    80    2773    936 0.0688784710     135      93
    ## 264     6     139     58 0.0575539568      14       6
    ## 265    30     308     86 0.0454545455      16      12
    ## 266    74    2054    889 0.0540408958     212     132
    ## 267    61    2076   1316 0.0183044316     441     320
    ## 268    52     577    292 0.0017331023     106      77
    ## 269     3       9      4 0.0000000000       2       0
    ## 270    61    1921   1104 0.0645497137     250     232
    ## 271    81    2570   1029 0.0000000000     412     205
    ## 272     7      24     10 0.0000000000       3       4
    ## 273    78    2198   1173 0.0914467698     195     180
    ## 274    82    2157   1008 0.0537783959     243     174
    ## 275    80    1787    484 0.0240626749     148      59
    ## 276    82    1286    711 0.0800933126     141     120
    ## 277    25     277     81 0.0541516245      13      10
    ## 278    80    1700    538 0.0270588235     175      50
    ## 279    68     810    186 0.0358024691      44      11
    ## 280    42     653    283 0.0382848392      74      60
    ## 281    73    1283    338 0.0155884645     126      26
    ## 282    66    1228    412 0.0358306189     111      58
    ## 283    50    1186    476 0.0025295110     200      67
    ## 284    49    1544    829 0.0608808290     195     157
    ## 285    73    2516   1601 0.0592209857     396     362
    ## 286    51     432    146 0.0000000000      55      36
    ## 287    82    1972    581 0.0623732252      81      50
    ## 288    78    1843    715 0.0575149213     167      63
    ## 289    12      53     22 0.0188679245       8       3
    ## 290    40     346    100 0.0289017341      31       8
    ## 291    59    1593    748 0.0715630885     158      90
    ## 292    81    2744   1137 0.0000000000     413     311
    ## 293    55    1205    430 0.0307053942     133      53
    ## 294    71    1158    440 0.0561312608      94      57
    ## 295    68    1055    406 0.0890995261      40      44
    ## 296    79    2376    522 0.0189393939     170      47
    ## 297    81    1632    479 0.0312500000     141      44
    ## 298    22     430    145 0.0488372093      35      12
    ## 299    72    1533   1033 0.0032615786     397     224
    ## 300    78    1490    421 0.0288590604     103      86
    ## 301     2      31     14 0.0645161290       4       0
    ## 302    32     385     88 0.0181818182      27      13
    ## 303    20     128     33 0.0000000000      14       5
    ## 304    13     125     43 0.0240000000      13       8
    ## 305    81    2802   2558 0.0713775874     624     710
    ## 306    64     973    183 0.0123329908      65      17
    ## 307    80    2389    905 0.0000000000     374     157
    ## 308    23     487    207 0.0020533881      88      28
    ## 309    67    2222   1067 0.0571557156     285     116
    ## 310    72    1474    425 0.0291723202      74     148
    ## 311    28     447    189 0.0000000000      83      23
    ## 312    34     675    210 0.0370370370      50      35
    ## 313    36     238     58 0.0000000000      24      10
    ## 314    64    1501    429 0.0339773484      95      86
    ## 315    77    2101    689 0.0261780105     195     134
    ## 316    42     558    165 0.0161290323      49      40
    ## 317    74    2531   1446 0.0410904781     428     278
    ## 318    69    2292   1415 0.0746073298     293     316
    ## 319    71    1914    643 0.0078369906     259      80
    ## 320    67    1183    551 0.1166525782      47      43
    ## 321    73    1799    586 0.0622568093      81      88
    ## 322    33     405    106 0.0074074074      33      31
    ## 323    11     189     55 0.0158730159      17      12
    ## 324    73    1786   1028 0.0117581187     412     141
    ## 325    61    1773    532 0.0394811055     113      96
    ## 326    79    2254    845 0.0594498669     169     105
    ## 327    80    2796   1837 0.0661659514     507     268
    ## 328    75    2694   2024 0.0794357832     447     488
    ## 329    46     789    200 0.0000000000      75      50
    ## 330    65    1658    586 0.0186972256     204      85
    ## 331    35     249     78 0.0522088353      13      13
    ## 332    20     584    304 0.0000000000     120      64
    ## 333    77    2223    773 0.0305892937     246      77
    ## 334    74    1222    401 0.0605564648      72      35
    ## 335    74    1265    327 0.0055335968     123      60
    ## 336    39     316     98 0.0537974684      20       7
    ## 337    53     512    218 0.0664062500      39      38
    ## 338    16      80     31 0.0625000000       8       0
    ## 339    63    2134   1145 0.0590440487     209     349
    ## 340    41     639    262 0.0829420970      42      19
    ## 341    55    1406    603 0.0398293030     152     131
    ## 342    57    1782    851 0.0600448934     213     104
    ## 343    82    1764    811 0.0651927438     180     106
    ## 344    75    2045    687 0.0518337408     162      45
    ## 345    62     842    305 0.0546318290      55      57
    ## 346    61    1296    587 0.0000000000     228     131
    ## 347    22     165     83 0.0545454545      24       8
    ## 348    27     632    245 0.0000000000      99      47
    ## 349    20     151     28 0.0529801325       1       2
    ## 350    73    2038   1221 0.0220804711     449     188
    ## 351     6      11      4 0.0000000000       2       0
    ## 352    60    1705    820 0.0510263930     208     143
    ## 353    71    2197   1117 0.0500682749     323     141
    ## 354    39     584    207 0.0000000000      89      29
    ## 355    75    2708   2099 0.0147710487     730     519
    ## 356     2      41     11 0.0243902439       4       0
    ## 357    17     199     87 0.0000000000      36      15
    ## 358    66    1649    435 0.0430563978     103      16
    ## 359    17     574    414 0.0627177700     106      94
    ## 360    34     479    150 0.0229645094      46      25
    ## 361    73    1820    700 0.0423076923     206      57
    ## 362    19     442    267 0.0837104072      68      20
    ## 363    67    2190   1029 0.0456621005     305     119
    ## 364    31     482     85 0.0000000000      31      23
    ## 365     9     111     52 0.0540540541      16       2
    ## 366    80    2374    563 0.0395956192      89     103
    ## 367    65    1525    464 0.0262295082     123      98
    ## 368    22     163     48 0.0306748466      12       9
    ## 369     1      25      8 0.0000000000       3       2
    ## 370    65    1087    437 0.0533578657      78     107
    ## 371    54    1424    769 0.0554775281     217      98
    ## 372    81    1642    350 0.0341047503      68      46
    ## 373    77    1333    516 0.0157539385     173     107
    ## 374    79    2803   1518 0.0278273279     521     242
    ## 375    35     771    381 0.0687418936      89      44
    ## 376     9     115     40 0.0260869565      13       5
    ## 377    22     483    188 0.0000000000      77      34
    ## 378    54     521    150 0.0556621881      23      17
    ## 379    73     905    213 0.0011049724      87      36
    ## 380    70    2029    898 0.0675209463     201      85
    ## 381    73    2495    986 0.0697394790     159     146
    ## 382    36    1046    408 0.0573613767      82      64
    ## 383    65    1477    461 0.0609343263      65      61
    ## 384    61    1580    515 0.0392405063     123      83
    ## 385    61    1176    495 0.0552721088     115      70
    ## 386    25     727    378 0.0811554333      83      35
    ## 387    68    2063    900 0.0353853611     267     147
    ## 388    65    1728    506 0.0474537037     101      58
    ## 389    22     355    124 0.0000000000      56      12
    ## 390    71    1419    470 0.0000000000     216      38
    ## 391    19     375    114 0.0506666667      23      11
    ## 392    22     198     79 0.0404040404      20      15
    ## 393    30    1013    562 0.0414610069     159     118
    ## 394    33     612    289 0.0049019608     114      52
    ## 395    69    1732    681 0.0196304850     203     173
    ## 396    14     314    163 0.0668789809      38      24
    ## 397    75    1421    611 0.0000000000     255     101
    ## 398    18     135     63 0.0222222222      20      14
    ## 399    82    3048   1933 0.0337926509     606     412
    ## 400    47    1030    197 0.0427184466      26      13
    ## 401    62     531    105 0.0000000000      45      15
    ## 402    82    2653    816 0.0060309084     316     136
    ## 403     7      47     12 0.0000000000       5       2
    ## 404    82    3030   2061 0.0333333333     701     356
    ## 405    78    1333    293 0.0157539385      97      36
    ## 406    65    1190    403 0.0470588235      95      45
    ## 407    13     222     45 0.0090090090      17       5
    ## 408    75    2469    836 0.0243013366     201     254
    ## 409    78    1516    772 0.0323218997     239     147
    ## 410    60     774    209 0.0335917313      49      33
    ## 411    47    1749    889 0.0686106346     206     117
    ## 412    79    2279    740 0.0241333918     221     133
    ## 413    24     358    129 0.0139664804      48      18
    ## 414    63    1811    984 0.0745444506     216     147
    ## 415    20     397    120 0.0025188917      46      25
    ## 416    38     609    284 0.0000000000     126      32
    ## 417    82    2397   1205 0.0488110138     360     134
    ## 418    74    2132    975 0.0079737336     360     204
    ## 419    63    1442    449 0.0069348128     180      59
    ## 420    56    1486    425 0.0343203230     113      46
    ## 421    25     160     57 0.0562500000      10      10
    ## 422    60    1556    791 0.1092544987     102      77
    ## 423    67    1091    383 0.0009165903     149      82
    ## 424    48     560    241 0.0000000000     105      31
    ## 425    54    1104    401 0.0000000000     169      63
    ## 426    22     392    170 0.0535714286      44      19
    ## 427    47     708    346 0.0000000000     138      70
    ## 428    77    1560    613 0.0019230769     227     150
    ## 429    54    1140    595 0.0394736842     164     132
    ## 430    32     545    168 0.0055045872      65      29
    ## 431    78    2730   1726 0.0538461538     459     367
    ## 432    43     574    146 0.0487804878      29       4
    ## 433     2      23      3 0.0000000000       1       1
    ## 434    66    2176   1390 0.0477941176     345     388
    ## 435    64    1362    434 0.0565345081      80      43
    ## 436    67     963    419 0.0363447560     137      40
    ## 437    82    1743    753 0.0413080895     212     113
    ## 438    14     134     14 0.0223880597       1       3
    ## 439    66    2048    951 0.0126953125     377     119
    ## 440    61    1123    444 0.0186999110     163      55
    ## 441    47    1298    397 0.0000000000     153      91

``` r
dat[dat$points3 == max(dat$points3), ]
```

    ##            player team position height weight age experience
    ## 234 Stephen Curry  GSW       PG     75    190  28          7
    ##              college   salary games minutes points points3 points2 points1
    ## 234 Davidson College 12112359    79    2638   1999     324     351     325

-   Who is the player with the maximum rate of two-points per minute?

``` r
transform(dat, points2 = points2 / minutes)
```

    ##                       player team position height weight age experience
    ## 1                 Al Horford  BOS        C     82    245  30          9
    ## 2               Amir Johnson  BOS       PF     81    240  29         11
    ## 3              Avery Bradley  BOS       SG     74    180  26          6
    ## 4          Demetrius Jackson  BOS       PG     73    201  22          0
    ## 5               Gerald Green  BOS       SF     79    205  31          9
    ## 6              Isaiah Thomas  BOS       PG     69    185  27          5
    ## 7                Jae Crowder  BOS       SF     78    235  26          4
    ## 8                James Young  BOS       SG     78    215  21          2
    ## 9               Jaylen Brown  BOS       SF     79    225  20          0
    ## 10             Jonas Jerebko  BOS       PF     82    231  29          6
    ## 11             Jordan Mickey  BOS       PF     80    235  22          1
    ## 12              Kelly Olynyk  BOS        C     84    238  25          3
    ## 13              Marcus Smart  BOS       SG     76    220  22          2
    ## 14              Terry Rozier  BOS       PG     74    190  22          1
    ## 15              Tyler Zeller  BOS        C     84    253  27          4
    ## 16             Channing Frye  CLE        C     83    255  33         10
    ## 17             Dahntay Jones  CLE       SF     78    225  36         12
    ## 18            Deron Williams  CLE       PG     75    200  32         11
    ## 19          Derrick Williams  CLE       PF     80    240  25          5
    ## 20               Edy Tavares  CLE        C     87    260  24          1
    ## 21             Iman Shumpert  CLE       SG     77    220  26          5
    ## 22                J.R. Smith  CLE       SG     78    225  31         12
    ## 23               James Jones  CLE       SF     80    218  36         13
    ## 24                Kay Felder  CLE       PG     69    176  21          0
    ## 25                Kevin Love  CLE       PF     82    251  28          8
    ## 26               Kyle Korver  CLE       SG     79    212  35         13
    ## 27              Kyrie Irving  CLE       PG     75    193  24          5
    ## 28              LeBron James  CLE       SF     80    250  32         13
    ## 29         Richard Jefferson  CLE       SF     79    233  36         15
    ## 30          Tristan Thompson  CLE        C     81    238  25          5
    ## 31             Bruno Caboclo  TOR       SF     81    218  21          2
    ## 32               Cory Joseph  TOR       SG     75    193  25          5
    ## 33              Delon Wright  TOR       PG     77    183  24          1
    ## 34             DeMar DeRozan  TOR       SG     79    221  27          7
    ## 35           DeMarre Carroll  TOR       SF     80    215  30          7
    ## 36             Fred VanVleet  TOR       PG     72    195  22          0
    ## 37              Jakob Poeltl  TOR        C     84    248  21          0
    ## 38         Jonas Valanciunas  TOR        C     84    265  24          4
    ## 39                Kyle Lowry  TOR       PG     72    205  30         10
    ## 40            Lucas Nogueira  TOR        C     84    241  24          2
    ## 41             Norman Powell  TOR       SG     76    215  23          1
    ## 42               P.J. Tucker  TOR       SF     78    245  31          5
    ## 43             Pascal Siakam  TOR       PF     81    230  22          0
    ## 44         Patrick Patterson  TOR       PF     81    230  27          6
    ## 45               Serge Ibaka  TOR       PF     82    235  27          7
    ## 46          Bojan Bogdanovic  WAS       SF     80    216  27          2
    ## 47              Bradley Beal  WAS       SG     77    207  23          4
    ## 48          Brandon Jennings  WAS       PG     73    170  27          7
    ## 49          Chris McCullough  WAS       PF     83    200  21          1
    ## 50             Daniel Ochefu  WAS        C     83    245  23          0
    ## 51               Ian Mahinmi  WAS        C     83    250  30          8
    ## 52               Jason Smith  WAS        C     84    245  30          8
    ## 53                 John Wall  WAS       PG     76    195  26          6
    ## 54             Marcin Gortat  WAS        C     83    240  32          9
    ## 55           Markieff Morris  WAS       PF     82    245  27          5
    ## 56               Otto Porter  WAS       SF     80    198  23          3
    ## 57         Sheldon McClellan  WAS       SG     77    200  24          0
    ## 58          Tomas Satoransky  WAS       SG     79    210  25          0
    ## 59                Trey Burke  WAS       PG     73    191  24          3
    ## 60           DeAndre' Bembry  ATL       SF     78    210  22          0
    ## 61           Dennis Schroder  ATL       PG     73    172  23          3
    ## 62             Dwight Howard  ATL        C     83    265  31         12
    ## 63            Ersan Ilyasova  ATL       PF     82    235  29          8
    ## 64             Jose Calderon  ATL       PG     75    200  35         11
    ## 65             Kent Bazemore  ATL       SF     77    201  27          4
    ## 66            Kris Humphries  ATL       PF     81    235  31         12
    ## 67           Malcolm Delaney  ATL       PG     75    190  27          0
    ## 68             Mike Dunleavy  ATL       SF     81    230  36         14
    ## 69              Mike Muscala  ATL        C     83    240  25          3
    ## 70              Paul Millsap  ATL       PF     80    246  31         10
    ## 71                Ryan Kelly  ATL       PF     83    230  25          3
    ## 72           Thabo Sefolosha  ATL       SF     79    220  32         10
    ## 73              Tim Hardaway  ATL       SG     78    205  24          3
    ## 74     Giannis Antetokounmpo  MIL       SF     83    222  22          3
    ## 75               Greg Monroe  MIL        C     83    265  26          6
    ## 76             Jabari Parker  MIL       PF     80    250  21          2
    ## 77               Jason Terry  MIL       SG     74    185  39         17
    ## 78               John Henson  MIL        C     83    229  26          4
    ## 79           Khris Middleton  MIL       SF     80    234  25          4
    ## 80           Malcolm Brogdon  MIL       SG     77    215  24          0
    ## 81       Matthew Dellavedova  MIL       PG     76    198  26          3
    ## 82           Michael Beasley  MIL       PF     81    235  28          8
    ## 83           Mirza Teletovic  MIL       PF     81    242  31          4
    ## 84             Rashad Vaughn  MIL       SG     78    202  20          1
    ## 85             Spencer Hawes  MIL       PF     85    245  28          9
    ## 86                Thon Maker  MIL        C     85    216  19          0
    ## 87                Tony Snell  MIL       SG     79    200  25          3
    ## 88              Aaron Brooks  IND       PG     72    161  32          8
    ## 89              Al Jefferson  IND        C     82    289  32         12
    ## 90                C.J. Miles  IND       SF     78    225  29         11
    ## 91             Georges Niang  IND       PF     80    230  23          0
    ## 92               Jeff Teague  IND       PG     74    186  28          7
    ## 93                 Joe Young  IND       PG     74    180  24          1
    ## 94            Kevin Seraphin  IND       PF     81    285  27          6
    ## 95          Lance Stephenson  IND       SG     77    230  26          6
    ## 96               Lavoy Allen  IND       PF     81    260  27          5
    ## 97               Monta Ellis  IND       SG     75    185  31         11
    ## 98              Myles Turner  IND        C     83    243  20          1
    ## 99               Paul George  IND       SF     81    220  26          6
    ## 100         Rakeem Christmas  IND       PF     81    250  25          1
    ## 101           Thaddeus Young  IND       PF     80    221  28          9
    ## 102           Anthony Morrow  CHI       SG     77    210  31          8
    ## 103             Bobby Portis  CHI       PF     83    230  21          1
    ## 104            Cameron Payne  CHI       PG     75    185  22          1
    ## 105        Cristiano Felicio  CHI        C     82    275  24          1
    ## 106         Denzel Valentine  CHI       SG     78    212  23          0
    ## 107              Dwyane Wade  CHI       SG     76    220  35         13
    ## 108            Isaiah Canaan  CHI       SG     72    201  25          3
    ## 109             Jerian Grant  CHI       PG     76    195  24          1
    ## 110             Jimmy Butler  CHI       SF     79    220  27          5
    ## 111        Joffrey Lauvergne  CHI        C     83    220  25          2
    ## 112  Michael Carter-Williams  CHI       PG     78    190  25          3
    ## 113           Nikola Mirotic  CHI       PF     82    220  25          2
    ## 114              Paul Zipser  CHI       SF     80    215  22          0
    ## 115              Rajon Rondo  CHI       PG     73    186  30         10
    ## 116              Robin Lopez  CHI        C     84    255  28          8
    ## 117             Dion Waiters  MIA       SG     76    225  25          4
    ## 118             Goran Dragic  MIA       PG     75    190  30          8
    ## 119         Hassan Whiteside  MIA        C     84    265  27          4
    ## 120            James Johnson  MIA       PF     81    250  29          7
    ## 121           Josh McRoberts  MIA       PF     82    240  29          9
    ## 122          Josh Richardson  MIA       SG     78    200  23          1
    ## 123          Justise Winslow  MIA       SF     79    225  20          1
    ## 124             Luke Babbitt  MIA       SF     81    225  27          6
    ## 125              Okaro White  MIA       PF     80    204  24          0
    ## 126          Rodney McGruder  MIA       SG     76    205  25          0
    ## 127            Tyler Johnson  MIA       PG     76    186  24          2
    ## 128            Udonis Haslem  MIA        C     80    235  36         13
    ## 129          Wayne Ellington  MIA       SG     76    200  29          7
    ## 130              Willie Reed  MIA        C     82    220  26          1
    ## 131           Andre Drummond  DET        C     83    279  23          4
    ## 132              Aron Baynes  DET        C     82    260  30          4
    ## 133               Beno Udrih  DET       PG     75    205  34         12
    ## 134         Boban Marjanovic  DET        C     87    290  28          1
    ## 135          Darrun Hilliard  DET       SG     78    205  23          1
    ## 136           Henry Ellenson  DET       PF     83    245  20          0
    ## 137                Ish Smith  DET       PG     72    175  28          6
    ## 138                Jon Leuer  DET       PF     82    228  27          5
    ## 139 Kentavious Caldwell-Pope  DET       SG     77    205  23          3
    ## 140            Marcus Morris  DET       SF     81    235  27          5
    ## 141          Michael Gbinije  DET       SG     79    200  24          0
    ## 142           Reggie Bullock  DET       SF     79    205  25          3
    ## 143           Reggie Jackson  DET       PG     75    208  26          5
    ## 144          Stanley Johnson  DET       SF     79    245  20          1
    ## 145            Tobias Harris  DET       PF     81    235  24          5
    ## 146            Brian Roberts  CHO       PG     73    173  31          4
    ## 147            Briante Weber  CHO       PG     74    165  24          1
    ## 148           Christian Wood  CHO       PF     83    220  21          1
    ## 149              Cody Zeller  CHO       PF     84    240  24          3
    ## 150           Frank Kaminsky  CHO        C     84    242  23          1
    ## 151              Jeremy Lamb  CHO       SG     77    185  24          4
    ## 152          Johnny O'Bryant  CHO       PF     81    257  23          2
    ## 153             Kemba Walker  CHO       PG     73    172  26          5
    ## 154          Marco Belinelli  CHO       SG     77    210  30          9
    ## 155          Marvin Williams  CHO       PF     81    237  30         11
    ## 156   Michael Kidd-Gilchrist  CHO       SF     79    232  23          4
    ## 157            Miles Plumlee  CHO        C     83    249  28          4
    ## 158            Nicolas Batum  CHO       SG     80    200  28          8
    ## 159           Ramon Sessions  CHO       PG     75    190  30          9
    ## 160           Treveon Graham  CHO       SG     78    220  23          0
    ## 161          Carmelo Anthony  NYK       SF     80    240  32         13
    ## 162           Chasson Randle  NYK       PG     74    185  23          0
    ## 163             Courtney Lee  NYK       SG     77    200  31          8
    ## 164             Derrick Rose  NYK       PG     75    190  28          7
    ## 165              Joakim Noah  NYK        C     83    230  31          9
    ## 166           Justin Holiday  NYK       SG     78    185  27          3
    ## 167       Kristaps Porzingis  NYK       PF     87    240  21          1
    ## 168             Kyle O'Quinn  NYK        C     82    250  26          4
    ## 169             Lance Thomas  NYK       PF     80    235  28          5
    ## 170         Marshall Plumlee  NYK        C     84    250  24          0
    ## 171            Maurice Ndour  NYK       PF     81    200  24          0
    ## 172     Mindaugas Kuzminskas  NYK       SF     81    215  27          0
    ## 173                Ron Baker  NYK       SG     76    220  23          0
    ## 174            Sasha Vujacic  NYK       SG     79    195  32          9
    ## 175        Willy Hernangomez  NYK        C     83    240  22          0
    ## 176             Aaron Gordon  ORL       SF     81    220  21          2
    ## 177          Bismack Biyombo  ORL        C     81    255  24          5
    ## 178              C.J. Watson  ORL       PG     74    175  32          9
    ## 179            D.J. Augustin  ORL       PG     72    183  29          8
    ## 180             Damjan Rudez  ORL       SF     82    228  30          2
    ## 181            Elfrid Payton  ORL       PG     76    185  22          2
    ## 182            Evan Fournier  ORL       SG     79    205  24          4
    ## 183               Jeff Green  ORL       PF     81    235  30          8
    ## 184              Jodie Meeks  ORL       SG     76    210  29          7
    ## 185      Marcus Georges-Hunt  ORL       SG     77    216  22          0
    ## 186            Mario Hezonja  ORL       SF     80    215  21          1
    ## 187           Nikola Vucevic  ORL        C     84    260  26          5
    ## 188          Patricio Garino  ORL       SG     78    210  23          0
    ## 189        Stephen Zimmerman  ORL        C     84    240  20          0
    ## 190            Terrence Ross  ORL       SF     79    206  25          4
    ## 191           Alex Poythress  PHI       PF     79    238  23          0
    ## 192              Dario Saric  PHI       PF     82    223  22          0
    ## 193         Gerald Henderson  PHI       SG     77    215  29          7
    ## 194            Jahlil Okafor  PHI        C     83    275  21          1
    ## 195           Jerryd Bayless  PHI       PG     75    200  28          8
    ## 196              Joel Embiid  PHI        C     84    250  22          0
    ## 197          Justin Anderson  PHI       SF     78    228  23          1
    ## 198             Nik Stauskas  PHI       SG     78    205  23          2
    ## 199           Richaun Holmes  PHI        C     82    245  23          1
    ## 200         Robert Covington  PHI       SF     81    215  26          3
    ## 201         Sergio Rodriguez  PHI       PG     75    176  30          4
    ## 202               Shawn Long  PHI        C     81    255  24          0
    ## 203           T.J. McConnell  PHI       PG     74    200  24          1
    ## 204           Tiago Splitter  PHI        C     83    245  32          6
    ## 205  Timothe Luwawu-Cabarrot  PHI       SF     78    205  21          0
    ## 206         Andrew Nicholson  BRK       PF     81    250  27          4
    ## 207           Archie Goodwin  BRK       SG     77    200  22          3
    ## 208              Brook Lopez  BRK        C     84    275  28          8
    ## 209             Caris LeVert  BRK       SF     79    203  22          0
    ## 210         Isaiah Whitehead  BRK       PG     76    213  21          0
    ## 211               Jeremy Lin  BRK       PG     75    200  28          6
    ## 212               Joe Harris  BRK       SG     78    219  25          2
    ## 213          Justin Hamilton  BRK        C     84    260  26          2
    ## 214           K.J. McDaniels  BRK       SF     78    205  23          2
    ## 215               Quincy Acy  BRK       PF     79    240  26          4
    ## 216               Randy Foye  BRK       SG     76    213  33         10
    ## 217  Rondae Hollis-Jefferson  BRK       SF     79    220  22          1
    ## 218          Sean Kilpatrick  BRK       SG     76    210  27          2
    ## 219        Spencer Dinwiddie  BRK       PG     78    200  23          2
    ## 220            Trevor Booker  BRK       PF     80    228  29          6
    ## 221           Andre Iguodala  GSW       SF     78    215  33         12
    ## 222             Damian Jones  GSW        C     84    245  21          0
    ## 223               David West  GSW        C     81    250  36         13
    ## 224           Draymond Green  GSW       PF     79    230  26          4
    ## 225                Ian Clark  GSW       SG     75    175  25          3
    ## 226     James Michael McAdoo  GSW       PF     81    230  24          2
    ## 227             JaVale McGee  GSW        C     84    270  29          8
    ## 228             Kevin Durant  GSW       SF     81    240  28          9
    ## 229             Kevon Looney  GSW        C     81    220  20          1
    ## 230            Klay Thompson  GSW       SG     79    215  26          5
    ## 231              Matt Barnes  GSW       SF     79    226  36         13
    ## 232            Patrick McCaw  GSW       SG     79    185  21          0
    ## 233         Shaun Livingston  GSW       PG     79    192  31         11
    ## 234            Stephen Curry  GSW       PG     75    190  28          7
    ## 235            Zaza Pachulia  GSW        C     83    270  32         13
    ## 236              Bryn Forbes  SAS       SG     75    190  23          0
    ## 237              Danny Green  SAS       SG     78    215  29          7
    ## 238                David Lee  SAS       PF     81    245  33         11
    ## 239            Davis Bertans  SAS       PF     82    210  24          0
    ## 240          Dejounte Murray  SAS       PG     77    170  20          0
    ## 241           Dewayne Dedmon  SAS        C     84    245  27          3
    ## 242             Joel Anthony  SAS        C     81    245  34          9
    ## 243         Jonathon Simmons  SAS       SG     78    195  27          1
    ## 244            Kawhi Leonard  SAS       SF     79    230  25          5
    ## 245            Kyle Anderson  SAS       SG     81    230  23          2
    ## 246        LaMarcus Aldridge  SAS       PF     83    260  31         10
    ## 247            Manu Ginobili  SAS       SG     78    205  39         14
    ## 248              Patty Mills  SAS       PG     72    185  28          7
    ## 249                Pau Gasol  SAS        C     84    250  36         15
    ## 250              Tony Parker  SAS       PG     74    185  34         15
    ## 251              Bobby Brown  HOU       PG     74    175  32          2
    ## 252           Chinanu Onuaku  HOU        C     82    245  20          0
    ## 253             Clint Capela  HOU        C     82    240  22          2
    ## 254              Eric Gordon  HOU       SG     76    215  28          8
    ## 255            Isaiah Taylor  HOU       PG     75    170  22          0
    ## 256             James Harden  HOU       PG     77    220  27          7
    ## 257             Kyle Wiltjer  HOU       PF     82    240  24          0
    ## 258             Lou Williams  HOU       SG     73    175  30         11
    ## 259         Montrezl Harrell  HOU        C     80    240  23          1
    ## 260         Patrick Beverley  HOU       SG     73    185  28          4
    ## 261            Ryan Anderson  HOU       PF     82    240  28          8
    ## 262               Sam Dekker  HOU       SF     81    230  22          1
    ## 263             Trevor Ariza  HOU       SF     80    215  31         12
    ## 264            Troy Williams  HOU       SF     79    218  22          0
    ## 265            Alan Anderson  LAC       SF     78    220  34          7
    ## 266            Austin Rivers  LAC       SG     76    200  24          4
    ## 267            Blake Griffin  LAC       PF     82    251  27          6
    ## 268             Brandon Bass  LAC       PF     80    250  31         11
    ## 269            Brice Johnson  LAC       PF     82    230  22          0
    ## 270               Chris Paul  LAC       PG     72    175  31         11
    ## 271           DeAndre Jordan  LAC        C     83    265  28          8
    ## 272            Diamond Stone  LAC        C     83    255  19          0
    ## 273              J.J. Redick  LAC       SG     76    190  32         10
    ## 274           Jamal Crawford  LAC       SG     77    200  36         16
    ## 275         Luc Mbah a Moute  LAC       SF     80    230  30          8
    ## 276        Marreese Speights  LAC        C     82    255  29          8
    ## 277              Paul Pierce  LAC       SF     79    235  39         18
    ## 278           Raymond Felton  LAC       PG     73    205  32         11
    ## 279           Wesley Johnson  LAC       SF     79    215  29          6
    ## 280               Alec Burks  UTA       SG     78    214  25          5
    ## 281               Boris Diaw  UTA       PF     80    250  34         13
    ## 282               Dante Exum  UTA       PG     78    190  21          1
    ## 283           Derrick Favors  UTA       PF     82    265  25          6
    ## 284              George Hill  UTA       PG     75    188  30          8
    ## 285           Gordon Hayward  UTA       SF     80    226  26          6
    ## 286              Jeff Withey  UTA        C     84    231  26          3
    ## 287               Joe Ingles  UTA       SF     80    226  29          2
    ## 288              Joe Johnson  UTA       SF     79    240  35         15
    ## 289            Joel Bolomboy  UTA       PF     81    235  23          0
    ## 290                Raul Neto  UTA       PG     73    179  24          1
    ## 291              Rodney Hood  UTA       SG     80    206  24          2
    ## 292              Rudy Gobert  UTA        C     85    245  24          3
    ## 293             Shelvin Mack  UTA       PG     75    203  26          5
    ## 294               Trey Lyles  UTA       PF     82    234  21          1
    ## 295             Alex Abrines  OKC       SG     78    190  23          0
    ## 296           Andre Roberson  OKC       SF     79    210  25          3
    ## 297         Domantas Sabonis  OKC       PF     83    240  20          0
    ## 298           Doug McDermott  OKC       SF     80    225  25          2
    ## 299              Enes Kanter  OKC        C     83    245  24          5
    ## 300             Jerami Grant  OKC       SF     80    210  22          2
    ## 301             Josh Huestis  OKC       PF     79    230  25          1
    ## 302             Kyle Singler  OKC       SF     80    228  28          4
    ## 303            Nick Collison  OKC       PF     82    255  36         12
    ## 304              Norris Cole  OKC       PG     74    175  28          5
    ## 305        Russell Westbrook  OKC       PG     75    200  28          8
    ## 306           Semaj Christon  OKC       PG     75    190  24          0
    ## 307             Steven Adams  OKC        C     84    255  23          3
    ## 308               Taj Gibson  OKC       PF     81    225  31          7
    ## 309           Victor Oladipo  OKC       SG     76    210  24          3
    ## 310          Andrew Harrison  MEM       PG     78    213  22          0
    ## 311           Brandan Wright  MEM       PF     82    210  29          8
    ## 312         Chandler Parsons  MEM       SF     82    230  28          5
    ## 313            Deyonta Davis  MEM        C     83    237  20          0
    ## 314              James Ennis  MEM       SF     79    210  26          2
    ## 315           JaMychal Green  MEM       PF     81    227  26          2
    ## 316            Jarell Martin  MEM       PF     82    239  22          1
    ## 317               Marc Gasol  MEM        C     85    255  32          8
    ## 318              Mike Conley  MEM       PG     73    175  29          9
    ## 319               Tony Allen  MEM       SG     76    213  35         12
    ## 320             Troy Daniels  MEM       SG     76    205  25          3
    ## 321             Vince Carter  MEM       SF     78    220  40         18
    ## 322             Wade Baldwin  MEM       PG     76    202  20          0
    ## 323             Wayne Selden  MEM       SG     77    230  22          0
    ## 324            Zach Randolph  MEM       PF     81    260  35         15
    ## 325          Al-Farouq Aminu  POR       SF     81    220  26          6
    ## 326             Allen Crabbe  POR       SG     78    210  24          3
    ## 327            C.J. McCollum  POR       SG     76    200  25          3
    ## 328           Damian Lillard  POR       PG     75    195  26          4
    ## 329                 Ed Davis  POR       PF     82    240  27          6
    ## 330              Evan Turner  POR       SF     79    220  28          6
    ## 331              Jake Layman  POR       SF     81    210  22          0
    ## 332             Jusuf Nurkic  POR        C     84    280  22          2
    ## 333         Maurice Harkless  POR       SF     81    215  23          4
    ## 334           Meyers Leonard  POR       PF     85    245  24          4
    ## 335              Noah Vonleh  POR       PF     82    240  21          2
    ## 336          Pat Connaughton  POR       SG     77    206  24          1
    ## 337           Shabazz Napier  POR       PG     73    175  25          2
    ## 338           Tim Quarterman  POR       SG     78    195  22          0
    ## 339         Danilo Gallinari  DEN       SF     82    225  28          7
    ## 340           Darrell Arthur  DEN       PF     81    235  28          7
    ## 341          Emmanuel Mudiay  DEN       PG     77    200  20          1
    ## 342              Gary Harris  DEN       SG     76    210  22          2
    ## 343             Jamal Murray  DEN       SG     76    207  19          0
    ## 344            Jameer Nelson  DEN       PG     72    190  34         12
    ## 345         Juan Hernangomez  DEN       PF     81    230  21          0
    ## 346           Kenneth Faried  DEN       PF     80    228  27          5
    ## 347            Malik Beasley  DEN       SG     77    196  20          0
    ## 348            Mason Plumlee  DEN        C     83    245  26          3
    ## 349              Mike Miller  DEN       SF     80    218  36         16
    ## 350             Nikola Jokic  DEN        C     82    250  21          1
    ## 351              Roy Hibbert  DEN        C     86    270  30          8
    ## 352              Will Barton  DEN       SG     78    175  26          4
    ## 353          Wilson Chandler  DEN       SF     80    225  29          8
    ## 354            Alexis Ajinca  NOP        C     86    248  28          6
    ## 355            Anthony Davis  NOP        C     82    253  23          4
    ## 356             Axel Toupane  NOP       SF     79    197  24          1
    ## 357            Cheick Diallo  NOP       PF     81    220  20          0
    ## 358         Dante Cunningham  NOP       SF     80    230  29          7
    ## 359         DeMarcus Cousins  NOP        C     83    270  26          6
    ## 360       Donatas Motiejunas  NOP       PF     84    222  26          4
    ## 361            E'Twaun Moore  NOP       SG     76    191  27          5
    ## 362          Jordan Crawford  NOP       SG     76    195  28          4
    ## 363             Jrue Holiday  NOP       PG     76    205  26          7
    ## 364                Omer Asik  NOP        C     84    255  30          6
    ## 365               Quinn Cook  NOP       PG     74    184  23          0
    ## 366             Solomon Hill  NOP       SF     79    225  25          3
    ## 367              Tim Frazier  NOP       PG     73    170  26          2
    ## 368             A.J. Hammons  DAL        C     84    260  24          0
    ## 369          DeAndre Liggins  DAL       SG     78    209  28          3
    ## 370             Devin Harris  DAL       PG     75    192  33         12
    ## 371            Dirk Nowitzki  DAL       PF     84    245  38         18
    ## 372      Dorian Finney-Smith  DAL       PF     80    220  23          0
    ## 373            Dwight Powell  DAL        C     83    240  25          2
    ## 374          Harrison Barnes  DAL       PF     80    210  24          4
    ## 375               J.J. Barea  DAL       PG     72    185  32         10
    ## 376            Jarrod Uthoff  DAL       PF     81    221  23          0
    ## 377             Nerlens Noel  DAL        C     83    228  22          2
    ## 378         Nicolas Brussino  DAL       SF     79    195  23          0
    ## 379              Salah Mejri  DAL        C     85    245  30          1
    ## 380               Seth Curry  DAL       PG     74    185  26          3
    ## 381          Wesley Matthews  DAL       SG     77    220  30          7
    ## 382             Yogi Ferrell  DAL       PG     72    180  23          0
    ## 383         Anthony Tolliver  SAC       PF     80    240  31          8
    ## 384            Arron Afflalo  SAC       SG     77    210  31          9
    ## 385             Ben McLemore  SAC       SG     77    195  23          3
    ## 386              Buddy Hield  SAC       SG     76    214  23          0
    ## 387          Darren Collison  SAC       PG     72    175  29          7
    ## 388           Garrett Temple  SAC       SG     78    195  30          6
    ## 389     Georgios Papagiannis  SAC        C     85    240  19          0
    ## 390             Kosta Koufos  SAC        C     84    265  27          8
    ## 391        Langston Galloway  SAC       PG     74    200  25          2
    ## 392       Malachi Richardson  SAC       SG     78    205  21          0
    ## 393                 Rudy Gay  SAC       SF     80    230  30         10
    ## 394          Skal Labissiere  SAC       PF     83    225  20          0
    ## 395                Ty Lawson  SAC       PG     71    195  29          7
    ## 396             Tyreke Evans  SAC       SF     78    220  27          7
    ## 397      Willie Cauley-Stein  SAC        C     84    240  23          1
    ## 398            Adreian Payne  MIN       PF     82    237  25          2
    ## 399           Andrew Wiggins  MIN       SF     80    199  21          2
    ## 400             Brandon Rush  MIN       SG     78    220  31          8
    ## 401             Cole Aldrich  MIN        C     83    250  28          6
    ## 402             Gorgui Dieng  MIN       PF     83    241  27          3
    ## 403              Jordan Hill  MIN        C     82    235  29          7
    ## 404       Karl-Anthony Towns  MIN        C     84    244  21          1
    ## 405                Kris Dunn  MIN       PG     76    210  22          0
    ## 406          Nemanja Bjelica  MIN       PF     82    240  28          1
    ## 407              Omri Casspi  MIN       SF     81    225  28          7
    ## 408              Ricky Rubio  MIN       PG     76    194  26          5
    ## 409         Shabazz Muhammad  MIN       SF     78    223  24          3
    ## 410               Tyus Jones  MIN       PG     74    195  20          1
    ## 411              Zach LaVine  MIN       SG     77    189  21          2
    ## 412           Brandon Ingram  LAL       SF     81    190  19          0
    ## 413             Corey Brewer  LAL       SF     81    186  30          9
    ## 414         D'Angelo Russell  LAL       PG     77    195  20          1
    ## 415              David Nwaba  LAL       SG     76    209  24          0
    ## 416              Ivica Zubac  LAL        C     85    265  19          0
    ## 417          Jordan Clarkson  LAL       SG     77    194  24          2
    ## 418            Julius Randle  LAL       PF     81    250  22          2
    ## 419          Larry Nance Jr.  LAL       PF     81    230  24          1
    ## 420                Luol Deng  LAL       SF     81    220  31         12
    ## 421        Metta World Peace  LAL       SF     78    260  37         16
    ## 422               Nick Young  LAL       SG     79    210  31          9
    ## 423              Tarik Black  LAL        C     81    250  25          2
    ## 424          Thomas Robinson  LAL       PF     82    237  25          4
    ## 425           Timofey Mozgov  LAL        C     85    275  30          6
    ## 426              Tyler Ennis  LAL       PG     75    194  22          2
    ## 427            Alan Williams  PHO        C     80    260  24          1
    ## 428                 Alex Len  PHO        C     85    260  23          3
    ## 429           Brandon Knight  PHO       SG     75    189  25          5
    ## 430            Derrick Jones  PHO       SF     79    190  19          0
    ## 431             Devin Booker  PHO       SG     78    206  20          1
    ## 432            Dragan Bender  PHO       PF     85    225  19          0
    ## 433           Elijah Millsap  PHO       SG     78    225  29          2
    ## 434             Eric Bledsoe  PHO       PG     73    190  27          6
    ## 435             Jared Dudley  PHO       PF     79    225  31          9
    ## 436          Leandro Barbosa  PHO       SG     75    194  34         13
    ## 437          Marquese Chriss  PHO       PF     82    233  19          0
    ## 438             Ronnie Price  PHO       PG     74    190  33         11
    ## 439              T.J. Warren  PHO       SF     80    230  23          2
    ## 440               Tyler Ulis  PHO       PG     70    150  21          0
    ## 441           Tyson Chandler  PHO        C     85    240  34         15
    ##                                                      college   salary
    ## 1                                      University of Florida 26540100
    ## 2                                                            12000000
    ## 3                              University of Texas at Austin  8269663
    ## 4                                   University of Notre Dame  1450000
    ## 5                                                             1410598
    ## 6                                   University of Washington  6587132
    ## 7                                       Marquette University  6286408
    ## 8                                     University of Kentucky  1825200
    ## 9                                   University of California  4743000
    ## 10                                                            5000000
    ## 11                                Louisiana State University  1223653
    ## 12                                        Gonzaga University  3094014
    ## 13                                 Oklahoma State University  3578880
    ## 14                                  University of Louisville  1906440
    ## 15                              University of North Carolina  8000000
    ## 16                                     University of Arizona  7806971
    ## 17                                           Duke University    18255
    ## 18                University of Illinois at Urbana-Champaign   259626
    ## 19                                     University of Arizona   268029
    ## 20                                                               5145
    ## 21                           Georgia Institute of Technology  9700000
    ## 22                                                           12800000
    ## 23                                       University of Miami  1551659
    ## 24                                        Oakland University   543471
    ## 25                     University of California, Los Angeles 21165675
    ## 26                                      Creighton University  5239437
    ## 27                                           Duke University 17638063
    ## 28                                                           30963450
    ## 29                                     University of Arizona  2500000
    ## 30                             University of Texas at Austin 15330435
    ## 31                                                            1589640
    ## 32                             University of Texas at Austin  7330000
    ## 33                                        University of Utah  1577280
    ## 34                         University of Southern California 26540100
    ## 35                                    University of Missouri 14200000
    ## 36                                  Wichita State University   543471
    ## 37                                        University of Utah  2703960
    ## 38                                                           14382022
    ## 39                                      Villanova University 12000000
    ## 40                                                            1921320
    ## 41                     University of California, Los Angeles   874636
    ## 42                             University of Texas at Austin  5300000
    ## 43                               New Mexico State University  1196040
    ## 44                                    University of Kentucky  6050000
    ## 45                                                           12250000
    ## 46                                                            3730653
    ## 47                                     University of Florida 22116750
    ## 48                                                            1200000
    ## 49                                       Syracuse University  1191480
    ## 50                                      Villanova University   543471
    ## 51                                                           15944154
    ## 52                                 Colorado State University  5000000
    ## 53                                    University of Kentucky 16957900
    ## 54                                                           12000000
    ## 55                                      University of Kansas  7400000
    ## 56                                     Georgetown University  5893981
    ## 57                                       University of Miami   543471
    ## 58                                                            2870813
    ## 59                                    University of Michigan  3386598
    ## 60                                 Saint Joseph's University  1499760
    ## 61                                                            2708582
    ## 62                                                           23180275
    ## 63                                                            8400000
    ## 64                                                             392478
    ## 65                                   Old Dominion University 15730338
    ## 66                                   University of Minnesota  4000000
    ## 67       Virginia Polytechnic Institute and State University  2500000
    ## 68                                           Duke University  4837500
    ## 69                                       Bucknell University  1015696
    ## 70                                 Louisiana Tech University 20072033
    ## 71                                           Duke University   418228
    ## 72                                                            3850000
    ## 73                                    University of Michigan  2281605
    ## 74                                                            2995421
    ## 75                                     Georgetown University 17100000
    ## 76                                           Duke University  5374320
    ## 77                                     University of Arizona  1551659
    ## 78                              University of North Carolina 12517606
    ## 79                                      Texas A&M University 15200000
    ## 80                                    University of Virginia   925000
    ## 81                        Saint Mary's College of California  9607500
    ## 82                                   Kansas State University  1403611
    ## 83                                                           10500000
    ## 84                           University of Nevada, Las Vegas  1811040
    ## 85                                  University of Washington  6348759
    ## 86                                                            2568600
    ## 87                                  University of New Mexico  2368327
    ## 88                                      University of Oregon  2700000
    ## 89                                                           10230179
    ## 90                                                            4583450
    ## 91                                     Iowa State University   650000
    ## 92                                    Wake Forest University  8800000
    ## 93                                      University of Oregon  1052342
    ## 94                                                            1800000
    ## 95                                  University of Cincinnati  4000000
    ## 96                                         Temple University  4000000
    ## 97                                                           10770000
    ## 98                             University of Texas at Austin  2463840
    ## 99                       California State University, Fresno 18314532
    ## 100                                      Syracuse University  1052342
    ## 101                          Georgia Institute of Technology 14153652
    ## 102                          Georgia Institute of Technology  3488000
    ## 103                                   University of Arkansas  1453680
    ## 104                                  Murray State University  2112480
    ## 105                                                            874636
    ## 106                                Michigan State University  2092200
    ## 107                                     Marquette University 23200000
    ## 108                                  Murray State University  1015696
    ## 109                                 University of Notre Dame  1643040
    ## 110                                     Marquette University 17552209
    ## 111                                                           1709720
    ## 112                                      Syracuse University  3183526
    ## 113                                                           5782450
    ## 114                                                            750000
    ## 115                                   University of Kentucky 14000000
    ## 116                                      Stanford University 13219250
    ## 117                                      Syracuse University  2898000
    ## 118                                                          15890000
    ## 119                                      Marshall University 22116750
    ## 120                                   Wake Forest University  4000000
    ## 121                                          Duke University  5782450
    ## 122                                  University of Tennessee   874636
    ## 123                                          Duke University  2593440
    ## 124                               University of Nevada, Reno  1227000
    ## 125                                 Florida State University   210995
    ## 126                                  Kansas State University   543471
    ## 127                      California State University, Fresno  5628000
    ## 128                                    University of Florida  4000000
    ## 129                             University of North Carolina  6000000
    ## 130                                   Saint Louis University  1015696
    ## 131                                University of Connecticut 22116750
    ## 132                              Washington State University  6500000
    ## 133                                                           1551659
    ## 134                                                           7000000
    ## 135                                     Villanova University   874060
    ## 136                                     Marquette University  1704120
    ## 137                                   Wake Forest University  6000000
    ## 138                                  University of Wisconsin 10991957
    ## 139                                    University of Georgia  3678319
    ## 140                                     University of Kansas  4625000
    ## 141                                      Syracuse University   650000
    ## 142                             University of North Carolina  2255644
    ## 143                                           Boston College 14956522
    ## 144                                    University of Arizona  2969880
    ## 145                                  University of Tennessee 17200000
    ## 146                                     University of Dayton  1050961
    ## 147                         Virginia Commonwealth University   102898
    ## 148                          University of Nevada, Las Vegas   874636
    ## 149                                       Indiana University  5318313
    ## 150                                  University of Wisconsin  2730000
    ## 151                                University of Connecticut  6511628
    ## 152                               Louisiana State University   161483
    ## 153                                University of Connecticut 12000000
    ## 154                                                           6333333
    ## 155                             University of North Carolina 12250000
    ## 156                                   University of Kentucky 13000000
    ## 157                                          Duke University 12500000
    ## 158                                                          20869566
    ## 159                               University of Nevada, Reno  6000000
    ## 160                         Virginia Commonwealth University   543471
    ## 161                                      Syracuse University 24559380
    ## 162                                      Stanford University   143860
    ## 163                              Western Kentucky University 11242000
    ## 164                                    University of Memphis 21323250
    ## 165                                    University of Florida 17000000
    ## 166                                 University of Washington  1015696
    ## 167                                                           4317720
    ## 168                                 Norfolk State University  3900000
    ## 169                                          Duke University  6191000
    ## 170                                          Duke University   543471
    ## 171                                          Ohio University   543471
    ## 172                                                           2898000
    ## 173                                 Wichita State University   543471
    ## 174                                                           1410598
    ## 175                                                           1375000
    ## 176                                    University of Arizona  4351320
    ## 177                                                          17000000
    ## 178                                  University of Tennessee  5000000
    ## 179                            University of Texas at Austin  7250000
    ## 180                                                            980431
    ## 181                     University of Louisiana at Lafayette  2613600
    ## 182                                                          17000000
    ## 183                                    Georgetown University 15000000
    ## 184                                   University of Kentucky  6540000
    ## 185                          Georgia Institute of Technology    31969
    ## 186                                                           3909840
    ## 187                        University of Southern California 11750000
    ## 188                             George Washington University    31969
    ## 189                          University of Nevada, Las Vegas   950000
    ## 190                                 University of Washington 10000000
    ## 191                                   University of Kentucky    31969
    ## 192                                                           2318280
    ## 193                                          Duke University  9000000
    ## 194                                          Duke University  4788840
    ## 195                                    University of Arizona  9424084
    ## 196                                     University of Kansas  4826160
    ## 197                                   University of Virginia  1514160
    ## 198                                   University of Michigan  2993040
    ## 199                           Bowling Green State University  1025831
    ## 200                               Tennessee State University  1015696
    ## 201                                                           8000000
    ## 202                     University of Louisiana at Lafayette    89513
    ## 203                                    University of Arizona   874636
    ## 204                                                           8550000
    ## 205                                                           1326960
    ## 206                               St. Bonaventure University  6088993
    ## 207                                   University of Kentucky   119494
    ## 208                                      Stanford University 21165675
    ## 209                                   University of Michigan  1562280
    ## 210                                    Seton Hall University  1074145
    ## 211                                       Harvard University 11483254
    ## 212                                   University of Virginia   980431
    ## 213                               Louisiana State University  3000000
    ## 214                                       Clemson University  3333333
    ## 215                                        Baylor University  1790902
    ## 216                                     Villanova University  2500000
    ## 217                                    University of Arizona  1395600
    ## 218                                 University of Cincinnati   980431
    ## 219                                   University of Colorado   726672
    ## 220                                       Clemson University  9250000
    ## 221                                    University of Arizona 11131368
    ## 222                                    Vanderbilt University  1171560
    ## 223                                        Xavier University  1551659
    ## 224                                Michigan State University 15330435
    ## 225                                       Belmont University  1015696
    ## 226                             University of North Carolina   980431
    ## 227                               University of Nevada, Reno  1403611
    ## 228                            University of Texas at Austin 26540100
    ## 229                    University of California, Los Angeles  1182840
    ## 230                              Washington State University 16663575
    ## 231                    University of California, Los Angeles   383351
    ## 232                          University of Nevada, Las Vegas   543471
    ## 233                                                           5782450
    ## 234                                         Davidson College 12112359
    ## 235                                                           2898000
    ## 236                                Michigan State University   543471
    ## 237                             University of North Carolina 10000000
    ## 238                                    University of Florida  1551659
    ## 239                                                            543471
    ## 240                                 University of Washington  1180080
    ## 241                        University of Southern California  2898000
    ## 242                          University of Nevada, Las Vegas   165952
    ## 243                                    University of Houston   874636
    ## 244                               San Diego State University 17638063
    ## 245                    University of California, Los Angeles  1192080
    ## 246                            University of Texas at Austin 20575005
    ## 247                                                          14000000
    ## 248                       Saint Mary's College of California  3578948
    ## 249                                                          15500000
    ## 250                                                          14445313
    ## 251                   California State University, Fullerton   680534
    ## 252                                 University of Louisville   543471
    ## 253                                                           1296240
    ## 254                                       Indiana University 12385364
    ## 255                            University of Texas at Austin   255000
    ## 256                                 Arizona State University 26540100
    ## 257                                       Gonzaga University   543471
    ## 258                                                           7000000
    ## 259                                 University of Louisville  1000000
    ## 260                                   University of Arkansas  6000000
    ## 261                                 University of California 18735364
    ## 262                                  University of Wisconsin  1720560
    ## 263                    University of California, Los Angeles  7806971
    ## 264                                       Indiana University   150000
    ## 265                                Michigan State University  1315448
    ## 266                                          Duke University 11000000
    ## 267                                   University of Oklahoma 20140838
    ## 268                               Louisiana State University  1551659
    ## 269                             University of North Carolina  1273920
    ## 270                                   Wake Forest University 22868828
    ## 271                                     Texas A&M University 21165675
    ## 272                                   University of Maryland   543471
    ## 273                                          Duke University  7377500
    ## 274                                   University of Michigan 13253012
    ## 275                    University of California, Los Angeles  2203000
    ## 276                                    University of Florida  1403611
    ## 277                                     University of Kansas  3500000
    ## 278                             University of North Carolina  1551659
    ## 279                                      Syracuse University  5628000
    ## 280                                   University of Colorado 10154495
    ## 281                                                           7000000
    ## 282                                                           3940320
    ## 283                          Georgia Institute of Technology 11050000
    ## 284        Indiana University-Purdue University Indianapolis  8000000
    ## 285                                        Butler University 16073140
    ## 286                                     University of Kansas  1015696
    ## 287                                                           2250000
    ## 288                                   University of Arkansas 11000000
    ## 289                                   Weber State University   600000
    ## 290                                                            937800
    ## 291                                          Duke University  1406520
    ## 292                                                           2121288
    ## 293                                        Butler University  2433334
    ## 294                                   University of Kentucky  2340600
    ## 295                                                           5994764
    ## 296                                   University of Colorado  2183072
    ## 297                                       Gonzaga University  2440200
    ## 298                                     Creighton University  2483040
    ## 299                                                          17145838
    ## 300                                      Syracuse University   980431
    ## 301                                      Stanford University  1191480
    ## 302                                          Duke University  4837500
    ## 303                                     University of Kansas  3750000
    ## 304                               Cleveland State University   247991
    ## 305                    University of California, Los Angeles 26540100
    ## 306                                        Xavier University   543471
    ## 307                                 University of Pittsburgh  3140517
    ## 308                        University of Southern California  8950000
    ## 309                                       Indiana University  6552960
    ## 310                                   University of Kentucky   945000
    ## 311                             University of North Carolina  5700000
    ## 312                                    University of Florida 22116750
    ## 313                                Michigan State University  1369229
    ## 314                  California State University, Long Beach  2898000
    ## 315                                    University of Alabama   980431
    ## 316                               Louisiana State University  1286160
    ## 317                                                          21165675
    ## 318                                    Ohio State University 26540100
    ## 319                                Oklahoma State University  5505618
    ## 320                         Virginia Commonwealth University  3332940
    ## 321                             University of North Carolina  4264057
    ## 322                                    Vanderbilt University  1793760
    ## 323                                     University of Kansas    83119
    ## 324                                Michigan State University 10361445
    ## 325                                   Wake Forest University  7680965
    ## 326                                 University of California 18500000
    ## 327                                        Lehigh University  3219579
    ## 328                                   Weber State University 24328425
    ## 329                             University of North Carolina  6666667
    ## 330                                    Ohio State University 16393443
    ## 331                                   University of Maryland   600000
    ## 332                                                           1921320
    ## 333                                    St. John's University  8988764
    ## 334               University of Illinois at Urbana-Champaign  9213484
    ## 335                                       Indiana University  2751360
    ## 336                                 University of Notre Dame   874636
    ## 337                                University of Connecticut  1350120
    ## 338                               Louisiana State University   543471
    ## 339                                                          15050000
    ## 340                                     University of Kansas  8070175
    ## 341                                                           3241800
    ## 342                                Michigan State University  1655880
    ## 343                                   University of Kentucky  3210840
    ## 344                                Saint Joseph's University  4540525
    ## 345                                                           1987440
    ## 346                                Morehead State University 12078652
    ## 347                                 Florida State University  1627320
    ## 348                                          Duke University  2328530
    ## 349                                    University of Florida  3500000
    ## 350                                                           1358500
    ## 351                                    Georgetown University  5000000
    ## 352                                    University of Memphis  3533333
    ## 353                                        DePaul University 11200000
    ## 354                                                           4600000
    ## 355                                   University of Kentucky 22116750
    ## 356                                                             20580
    ## 357                                     University of Kansas   543471
    ## 358                                     Villanova University  2978250
    ## 359                                   University of Kentucky 16957900
    ## 360                                                            576724
    ## 361                                        Purdue University  8081363
    ## 362                                        Xavier University   173094
    ## 363                    University of California, Los Angeles 11286518
    ## 364                                                           9904494
    ## 365                                          Duke University    63938
    ## 366                                    University of Arizona 11241218
    ## 367                            Pennsylvania State University  2090000
    ## 368                                        Purdue University   650000
    ## 369                                   University of Kentucky  1015696
    ## 370                                  University of Wisconsin  4228000
    ## 371                                                          25000000
    ## 372                                    University of Florida   543471
    ## 373                                      Stanford University  8375000
    ## 374                             University of North Carolina 22116750
    ## 375                                  Northeastern University  4096950
    ## 376                                       University of Iowa    63938
    ## 377                                   University of Kentucky  4384490
    ## 378                                                            543471
    ## 379                                                            874636
    ## 380                                          Duke University  2898000
    ## 381                                     Marquette University 17100000
    ## 382                                       Indiana University   207798
    ## 383                                     Creighton University  8000000
    ## 384                    University of California, Los Angeles 12500000
    ## 385                                     University of Kansas  4008882
    ## 386                                   University of Oklahoma  3517200
    ## 387                    University of California, Los Angeles  5229454
    ## 388                               Louisiana State University  8000000
    ## 389                                                           2202240
    ## 390                                    Ohio State University  8046500
    ## 391                                Saint Joseph's University  5200000
    ## 392                                      Syracuse University  1439880
    ## 393                                University of Connecticut 13333333
    ## 394                                   University of Kentucky  1188840
    ## 395                             University of North Carolina  1315448
    ## 396                                    University of Memphis 10661286
    ## 397                                   University of Kentucky  3551160
    ## 398                                Michigan State University  2022240
    ## 399                                     University of Kansas  6006600
    ## 400                                     University of Kansas  3500000
    ## 401                                     University of Kansas  7643979
    ## 402                                 University of Louisville  2348783
    ## 403                                    University of Arizona  3911380
    ## 404                                   University of Kentucky  5960160
    ## 405                                       Providence College  3872520
    ## 406                                                           3800000
    ## 407                                                            138414
    ## 408                                                          13550000
    ## 409                    University of California, Los Angeles  3046299
    ## 410                                          Duke University  1339680
    ## 411                    University of California, Los Angeles  2240880
    ## 412                                          Duke University  5281680
    ## 413                                    University of Florida  7600000
    ## 414                                    Ohio State University  5332800
    ## 415 California Polytechnic State University, San Luis Obispo    73528
    ## 416                                                           1034956
    ## 417                                   University of Missouri 12500000
    ## 418                                   University of Kentucky  3267120
    ## 419                                    University of Wyoming  1207680
    ## 420                                          Duke University 18000000
    ## 421                                    St. John's University  1551659
    ## 422                        University of Southern California  5443918
    ## 423                                     University of Kansas  6191000
    ## 424                                     University of Kansas  1050961
    ## 425                                                          16000000
    ## 426                                      Syracuse University  1733880
    ## 427                  University of California, Santa Barbara   874636
    ## 428                                   University of Maryland  4823621
    ## 429                                   University of Kentucky 12606250
    ## 430                          University of Nevada, Las Vegas   543471
    ## 431                                   University of Kentucky  2223600
    ## 432                                                           4276320
    ## 433                      University of Alabama at Birmingham    23069
    ## 434                                   University of Kentucky 14000000
    ## 435                                           Boston College 10470000
    ## 436                                                           4000000
    ## 437                                 University of Washington  2941440
    ## 438                                Utah Valley State College   282595
    ## 439                          North Carolina State University  2128920
    ## 440                                   University of Kentucky   918369
    ## 441                                                          12415000
    ##     games minutes points points3     points2 points1
    ## 1      68    2193    952      86 0.133606931     108
    ## 2      80    1608    520      27 0.115671642      67
    ## 3      55    1835    894     108 0.136784741      68
    ## 4       5      17     10       1 0.117647059       3
    ## 5      47     538    262      39 0.104089219      33
    ## 6      76    2569   2199     245 0.170105099     590
    ## 7      72    2335    999     157 0.075374732     176
    ## 8      29     220     68      12 0.059090909       6
    ## 9      78    1341    515      46 0.108873975      85
    ## 10     78    1232    299      45 0.056006494      26
    ## 11     25     141     38       0 0.106382979       8
    ## 12     75    1538    678      68 0.124837451      90
    ## 13     79    2399    835      94 0.072947061     203
    ## 14     74    1263    410      57 0.074425970      51
    ## 15     51     525    178       0 0.148571429      22
    ## 16     74    1398    676     137 0.072246066      63
    ## 17      1      12      9       0 0.250000000       3
    ## 18     24     486    179      22 0.094650206      21
    ## 19     25     427    156      21 0.077283372      27
    ## 20      1      24      6       0 0.125000000       0
    ## 21     76    1937    567      94 0.055240062      71
    ## 22     41    1187    351      95 0.023588880      10
    ## 23     48     381    132      31 0.034120735      13
    ## 24     42     386    166       7 0.142487047      35
    ## 25     60    1885   1142     145 0.119363395     257
    ## 26     35     859    373      97 0.039580908      14
    ## 27     72    2525   1816     177 0.195643564     297
    ## 28     74    2794   1954     124 0.219040802     358
    ## 29     79    1614    448      62 0.056381660      80
    ## 30     78    2336    630       0 0.112157534     106
    ## 31      9      40     14       2 0.100000000       0
    ## 32     80    2003    740      48 0.125312032      94
    ## 33     27     446    150      10 0.087443946      42
    ## 34     74    2620   2020      33 0.262595420     545
    ## 35     72    1882    638     109 0.058979809      89
    ## 36     37     294    107      11 0.095238095      18
    ## 37     54     626    165       0 0.107028754      31
    ## 38     80    2066    959       1 0.188770571     176
    ## 39     60    2244   1344     193 0.103832442     299
    ## 40     57    1088    253       3 0.091911765      44
    ## 41     76    1368    636      56 0.125000000     126
    ## 42     24     609    139      24 0.045977011      11
    ## 43     55     859    229       1 0.118742724      22
    ## 44     65    1599    445      94 0.037523452      43
    ## 45     23     712    327      41 0.122191011      30
    ## 46     26     601    330      45 0.103161398      71
    ## 47     77    2684   1779     223 0.154247392     282
    ## 48     23     374     81      11 0.048128342      12
    ## 49      2       8      1       0 0.000000000       1
    ## 50     19      75     24       0 0.160000000       0
    ## 51     31     555    173       0 0.117117117      43
    ## 52     74    1068    420      37 0.128277154      35
    ## 53     78    2836   1805      89 0.196755994     422
    ## 54     82    2556    883       0 0.152582160     103
    ## 55     76    2374   1063      71 0.141112047     180
    ## 56     80    2605   1075     148 0.102111324      99
    ## 57     30     287     90       7 0.080139373      23
    ## 58     57     719    154       9 0.072322670      23
    ## 59     57     703    285      31 0.120910384      22
    ## 60     38     371    101       1 0.123989218       6
    ## 61     79    2485   1414     100 0.180281690     218
    ## 62     74    2199   1002       0 0.176443838     226
    ## 63     26     633    270      32 0.096366509      52
    ## 64     17     247     61       8 0.060728745       7
    ## 65     73    1963    801      92 0.103413143     119
    ## 66     56     689    257      19 0.098693759      64
    ## 67     73    1248    391      26 0.095352564      75
    ## 68     30     475    169      33 0.050526316      22
    ## 69     70    1237    435      46 0.100242522      49
    ## 70     69    2343   1246      75 0.151515152     311
    ## 71     16     110     25       4 0.036363636       5
    ## 72     62    1596    444      41 0.083333333      55
    ## 73     79    2154   1143     149 0.123491179     164
    ## 74     80    2845   1832      49 0.213356766     471
    ## 75     81    1823    951       0 0.212287438     177
    ## 76     51    1728   1025      65 0.193287037     162
    ## 77     74    1365    307      73 0.023443223      24
    ## 78     58    1123    392       0 0.141585040      74
    ## 79     29     889    426      45 0.118110236      81
    ## 80     75    1982    767      78 0.106962664     109
    ## 81     76    1986    577      79 0.064954683      82
    ## 82     56     935    528      18 0.211764706      78
    ## 83     70    1133    451     104 0.045895852      35
    ## 84     41     458    142      26 0.067685590       2
    ## 85     19     171     83       9 0.122807018      14
    ## 86     57     562    226      28 0.097864769      32
    ## 87     80    2336    683     144 0.043664384      47
    ## 88     65     894    322      48 0.081655481      32
    ## 89     66     931    535       0 0.252416756      65
    ## 90     76    1776    815     169 0.063063063      84
    ## 91     23      93     21       1 0.086021505       2
    ## 92     82    2657   1254      90 0.117425668     360
    ## 93     33     135     68       5 0.155555556      11
    ## 94     49     559    232       0 0.194991055      14
    ## 95      6     132     43       5 0.098484848       2
    ## 96     61     871    177       0 0.088404133      23
    ## 97     74    1998    630      43 0.102102102      93
    ## 98     81    2541   1173      40 0.158992523     245
    ## 99     75    2689   1775     195 0.158795091     336
    ## 100    29     219     59       0 0.086757991      21
    ## 101    74    2237    814      45 0.141707644      45
    ## 102     9      87     41       6 0.068965517      11
    ## 103    64    1000    437      32 0.151000000      39
    ## 104    11     142     54      11 0.070422535       1
    ## 105    66    1040    316       0 0.123076923      60
    ## 106    57     976    291      73 0.029713115      14
    ## 107    60    1792   1096      45 0.205915179     223
    ## 108    39     592    181      25 0.064189189      30
    ## 109    63    1028    370      49 0.076848249      65
    ## 110    76    2809   1816      91 0.170523318     585
    ## 111    20     241     89       6 0.128630705       9
    ## 112    45     846    297      15 0.114657210      58
    ## 113    70    1679    744     129 0.076831447      99
    ## 114    44     843    240      33 0.065243179      31
    ## 115    69    1843    538      50 0.097124254      30
    ## 116    81    2271    839       0 0.168207838      75
    ## 117    46    1384    729      85 0.141618497      82
    ## 118    73    2459   1483     117 0.169581131     298
    ## 119    77    2513   1309       0 0.215678472     225
    ## 120    76    2085    975      87 0.134772182     152
    ## 121    22     381    107      13 0.081364829       6
    ## 122    53    1614    539      75 0.078686493      60
    ## 123    18     625    196       7 0.116800000      29
    ## 124    68    1065    324      87 0.024413146      11
    ## 125    35     471     98      12 0.044585987      20
    ## 126    78    1966    497      73 0.059511699      44
    ## 127    73    2178   1002      93 0.121212121     195
    ## 128    17     130     31       0 0.084615385       9
    ## 129    62    1500    648     149 0.054666667      37
    ## 130    71    1031    374       1 0.156159069      49
    ## 131    81    2409   1105       2 0.199667912     137
    ## 132    75    1163    365       0 0.122957868      79
    ## 133    39     560    227      11 0.144642857      32
    ## 134    35     293    191       0 0.245733788      47
    ## 135    39     381    127      12 0.091863517      21
    ## 136    19     146     60      10 0.089041096       4
    ## 137    81    1955    758      28 0.153964194      72
    ## 138    75    1944    767      49 0.134259259      98
    ## 139    76    2529   1047     153 0.085804666     154
    ## 140    79    2565   1105     118 0.118128655     145
    ## 141     9      32      4       0 0.031250000       2
    ## 142    31     467    141      28 0.055674518       5
    ## 143    52    1424    752      66 0.153089888     118
    ## 144    77    1371    339      45 0.061269147      36
    ## 145    82    2567   1321     109 0.156603039     190
    ## 146    41     416    142      17 0.069711538      33
    ## 147    13     159     50       1 0.119496855       9
    ## 148    13     107     35       0 0.112149533      11
    ## 149    62    1725    639       0 0.146666667     133
    ## 150    75    1954    874     116 0.104401228     118
    ## 151    62    1143    603      41 0.161854768     110
    ## 152     4      34     18       1 0.205882353       1
    ## 153    79    2739   1830     240 0.147133991     304
    ## 154    74    1778    780     102 0.091113611     150
    ## 155    76    2295    849     124 0.075381264     131
    ## 156    81    2349    743       1 0.125159642     152
    ## 157    13     174     31       0 0.080459770       3
    ## 158    77    2617   1164     135 0.098586167     243
    ## 159    50     811    312      21 0.097410604      91
    ## 160    27     189     57       9 0.052910053      10
    ## 161    74    2538   1659     151 0.177698976     304
    ## 162    18     225     95      10 0.080000000      29
    ## 163    77    2459    835     108 0.086620577      85
    ## 164    64    2082   1154      13 0.214697406     221
    ## 165    46    1015    232       0 0.097536946      34
    ## 166    82    1639    629      97 0.082977425      66
    ## 167    66    2164   1196     112 0.152957486     198
    ## 168    79    1229    496       2 0.173311635      64
    ## 169    46     968    275      38 0.060950413      43
    ## 170    21     170     40       0 0.094117647       8
    ## 171    32     331     98       1 0.114803625      19
    ## 172    68    1016    425      54 0.102362205      55
    ## 173    52     857    215      23 0.068844807      28
    ## 174    42     408    124      23 0.046568627      17
    ## 175    72    1324    587       4 0.182779456      91
    ## 176    80    2298   1019      77 0.137510879     156
    ## 177    81    1793    483       0 0.099832683     125
    ## 178    62    1012    281      32 0.063241107      57
    ## 179    78    1538    616      95 0.065019506     131
    ## 180    45     314     82      20 0.035031847       0
    ## 181    82    2412   1046      40 0.161691542     146
    ## 182    68    2234   1167     128 0.125335721     223
    ## 183    69    1534    638      53 0.108865711     145
    ## 184    36     738    327      56 0.063685637      65
    ## 185     5      48     14       1 0.020833333       9
    ## 186    65     960    317      43 0.077083333      40
    ## 187    75    2163   1096      23 0.212667591     107
    ## 188     5      43      0       0 0.000000000       0
    ## 189    19     108     23       0 0.092592593       3
    ## 190    24     748    299      46 0.092245989      23
    ## 191     6     157     64       6 0.121019108       8
    ## 192    81    2129   1040     106 0.129168624     172
    ## 193    72    1667    662      61 0.103779244     133
    ## 194    50    1134    590       0 0.213403880     106
    ## 195     3      71     33       2 0.126760563       9
    ## 196    31     786    627      36 0.208651399     191
    ## 197    24     518    203      21 0.104247104      32
    ## 198    80    2188    756     132 0.054387569     122
    ## 199    57    1193    559      27 0.170159262      72
    ## 200    67    2119    864     137 0.073147711     143
    ## 201    68    1518    530      92 0.077733860      18
    ## 202    18     234    148       7 0.230769231      19
    ## 203    81    2133    556      11 0.105485232      73
    ## 204     8      76     39       2 0.157894737       9
    ## 205    69    1190    445      50 0.079831933     105
    ## 206    10     111     30       2 0.099099099       2
    ## 207    12     184     95       4 0.163043478      23
    ## 208    75    2222   1539     134 0.189468947     295
    ## 209    57    1237    468      59 0.090541633      67
    ## 210    73    1643    543      44 0.097382836      91
    ## 211    36     883    523      58 0.132502831     115
    ## 212    52    1138    428      85 0.060632689      35
    ## 213    64    1177    442      55 0.101104503      39
    ## 214    20     293    126      11 0.119453925      23
    ## 215    32     510    209      36 0.056862745      43
    ## 216    69    1284    357      67 0.039719626      54
    ## 217    78    1761    675      15 0.124929018     190
    ## 218    70    1754    919     105 0.114025086     204
    ## 219    59    1334    432      38 0.071964018     126
    ## 220    71    1754    709      25 0.159635120      74
    ## 221    76    1998    574      64 0.077577578      72
    ## 222    10      85     19       0 0.094117647       3
    ## 223    68     854    316       3 0.154566745      43
    ## 224    76    2471    776      81 0.077296641     151
    ## 225    77    1137    527      61 0.131926121      44
    ## 226    52     457    147       2 0.131291028      21
    ## 227    77     739    472       0 0.281461434      56
    ## 228    62    2070   1555     117 0.209661836     336
    ## 229    53     447    135       2 0.120805369      21
    ## 230    78    2649   1742     268 0.141940355     186
    ## 231    20     410    114      18 0.048780488      20
    ## 232    71    1074    282      41 0.060521415      29
    ## 233    76    1345    389       1 0.127881041      42
    ## 234    79    2638   1999     324 0.133055345     325
    ## 235    70    1268    426       0 0.129337539      98
    ## 236    36     285     94      17 0.066666667       5
    ## 237    68    1807    497     118 0.032097399      27
    ## 238    79    1477    576       0 0.167907921      80
    ## 239    67     808    303      69 0.042079208      28
    ## 240    38     322    130       9 0.127329193      21
    ## 241    76    1330    387       0 0.121052632      65
    ## 242    19     122     25       0 0.081967213       5
    ## 243    78    1392    483      30 0.105603448      99
    ## 244    74    2474   1888     147 0.197655618     469
    ## 245    72    1020    246      15 0.076470588      45
    ## 246    72    2335   1243      23 0.204282655     220
    ## 247    69    1291    517      89 0.063516654      86
    ## 248    80    1754    759     147 0.071835804      66
    ## 249    64    1627    792      56 0.151813153     130
    ## 250    63    1587    638      23 0.152488973      85
    ## 251    25     123     62      14 0.073170732       2
    ## 252     5      52     14       0 0.096153846       4
    ## 253    65    1551    818       0 0.233397808      94
    ## 254    75    2323   1217     246 0.071459320     147
    ## 255     4      52      3       0 0.019230769       1
    ## 256    81    2947   2356     262 0.139803190     746
    ## 257    14      44     13       4 0.000000000       1
    ## 258    23     591    343      41 0.103214890      98
    ## 259    58    1064    527       1 0.210526316      76
    ## 260    67    2058    639     110 0.057337221      73
    ## 261    72    2116    979     204 0.056238185     129
    ## 262    77    1419    504      60 0.100775194      38
    ## 263    80    2773    936     191 0.048683736      93
    ## 264     6     139     58       8 0.100719424       6
    ## 265    30     308     86      14 0.051948052      12
    ## 266    74    2054    889     111 0.103213242     132
    ## 267    61    2076   1316      38 0.212427746     320
    ## 268    52     577    292       1 0.183708839      77
    ## 269     3       9      4       0 0.222222222       0
    ## 270    61    1921   1104     124 0.130140552     232
    ## 271    81    2570   1029       0 0.160311284     205
    ## 272     7      24     10       0 0.125000000       4
    ## 273    78    2198   1173     201 0.088717015     180
    ## 274    82    2157   1008     116 0.112656467     174
    ## 275    80    1787    484      43 0.082820369      59
    ## 276    82    1286    711     103 0.109642302     120
    ## 277    25     277     81      15 0.046931408      10
    ## 278    80    1700    538      46 0.102941176      50
    ## 279    68     810    186      29 0.054320988      11
    ## 280    42     653    283      25 0.113323124      60
    ## 281    73    1283    338      20 0.098207327      26
    ## 282    66    1228    412      44 0.090390879      58
    ## 283    50    1186    476       3 0.168634064      67
    ## 284    49    1544    829      94 0.126295337     157
    ## 285    73    2516   1601     149 0.157392687     362
    ## 286    51     432    146       0 0.127314815      36
    ## 287    82    1972    581     123 0.041075051      50
    ## 288    78    1843    715     106 0.090613131      63
    ## 289    12      53     22       1 0.150943396       3
    ## 290    40     346    100      10 0.089595376       8
    ## 291    59    1593    748     114 0.099183930      90
    ## 292    81    2744   1137       0 0.150510204     311
    ## 293    55    1205    430      37 0.110373444      53
    ## 294    71    1158    440      65 0.081174439      57
    ## 295    68    1055    406      94 0.037914692      44
    ## 296    79    2376    522      45 0.071548822      47
    ## 297    81    1632    479      51 0.086397059      44
    ## 298    22     430    145      21 0.081395349      12
    ## 299    72    1533   1033       5 0.258969341     224
    ## 300    78    1490    421      43 0.069127517      86
    ## 301     2      31     14       2 0.129032258       0
    ## 302    32     385     88       7 0.070129870      13
    ## 303    20     128     33       0 0.109375000       5
    ## 304    13     125     43       3 0.104000000       8
    ## 305    81    2802   2558     200 0.222698073     710
    ## 306    64     973    183      12 0.066803700      17
    ## 307    80    2389    905       0 0.156550858     157
    ## 308    23     487    207       1 0.180698152      28
    ## 309    67    2222   1067     127 0.128262826     116
    ## 310    72    1474    425      43 0.050203528     148
    ## 311    28     447    189       0 0.185682327      23
    ## 312    34     675    210      25 0.074074074      35
    ## 313    36     238     58       0 0.100840336      10
    ## 314    64    1501    429      51 0.063291139      86
    ## 315    77    2101    689      55 0.092812946     134
    ## 316    42     558    165       9 0.087813620      40
    ## 317    74    2531   1446     104 0.169103121     278
    ## 318    69    2292   1415     171 0.127835951     316
    ## 319    71    1914    643      15 0.135318704      80
    ## 320    67    1183    551     138 0.039729501      43
    ## 321    73    1799    586     112 0.045025014      88
    ## 322    33     405    106       3 0.081481481      31
    ## 323    11     189     55       3 0.089947090      12
    ## 324    73    1786   1028      21 0.230683091     141
    ## 325    61    1773    532      70 0.063733785      96
    ## 326    79    2254    845     134 0.074977817     105
    ## 327    80    2796   1837     185 0.181330472     268
    ## 328    75    2694   2024     214 0.165924276     488
    ## 329    46     789    200       0 0.095057034      50
    ## 330    65    1658    586      31 0.123039807      85
    ## 331    35     249     78      13 0.052208835      13
    ## 332    20     584    304       0 0.205479452      64
    ## 333    77    2223    773      68 0.110661269      77
    ## 334    74    1222    401      74 0.058919804      35
    ## 335    74    1265    327       7 0.097233202      60
    ## 336    39     316     98      17 0.063291139       7
    ## 337    53     512    218      34 0.076171875      38
    ## 338    16      80     31       5 0.100000000       0
    ## 339    63    2134   1145     126 0.097938144     349
    ## 340    41     639    262      53 0.065727700      19
    ## 341    55    1406    603      56 0.108108108     131
    ## 342    57    1782    851     107 0.119528620     104
    ## 343    82    1764    811     115 0.102040816     106
    ## 344    75    2045    687     106 0.079217604      45
    ## 345    62     842    305      46 0.065320665      57
    ## 346    61    1296    587       0 0.175925926     131
    ## 347    22     165     83       9 0.145454545       8
    ## 348    27     632    245       0 0.156645570      47
    ## 349    20     151     28       8 0.006622517       2
    ## 350    73    2038   1221      45 0.220314033     188
    ## 351     6      11      4       0 0.181818182       0
    ## 352    60    1705    820      87 0.121994135     143
    ## 353    71    2197   1117     110 0.147018662     141
    ## 354    39     584    207       0 0.152397260      29
    ## 355    75    2708   2099      40 0.269571640     519
    ## 356     2      41     11       1 0.097560976       0
    ## 357    17     199     87       0 0.180904523      15
    ## 358    66    1649    435      71 0.062462098      16
    ## 359    17     574    414      36 0.184668990      94
    ## 360    34     479    150      11 0.096033403      25
    ## 361    73    1820    700      77 0.113186813      57
    ## 362    19     442    267      37 0.153846154      20
    ## 363    67    2190   1029     100 0.139269406     119
    ## 364    31     482     85       0 0.064315353      23
    ## 365     9     111     52       6 0.144144144       2
    ## 366    80    2374    563      94 0.037489469     103
    ## 367    65    1525    464      40 0.080655738      98
    ## 368    22     163     48       5 0.073619632       9
    ## 369     1      25      8       0 0.120000000       2
    ## 370    65    1087    437      58 0.071757130     107
    ## 371    54    1424    769      79 0.152387640      98
    ## 372    81    1642    350      56 0.041412911      46
    ## 373    77    1333    516      21 0.129782446     107
    ## 374    79    2803   1518      78 0.185872280     242
    ## 375    35     771    381      53 0.115434501      44
    ## 376     9     115     40       3 0.113043478       5
    ## 377    22     483    188       0 0.159420290      34
    ## 378    54     521    150      29 0.044145873      17
    ## 379    73     905    213       1 0.096132597      36
    ## 380    70    2029    898     137 0.099063578      85
    ## 381    73    2495    986     174 0.063727455     146
    ## 382    36    1046    408      60 0.078393881      64
    ## 383    65    1477    461      90 0.044008125      61
    ## 384    61    1580    515      62 0.077848101      83
    ## 385    61    1176    495      65 0.097789116      70
    ## 386    25     727    378      59 0.114167813      35
    ## 387    68    2063    900      73 0.129423170     147
    ## 388    65    1728    506      82 0.058449074      58
    ## 389    22     355    124       0 0.157746479      12
    ## 390    71    1419    470       0 0.152219873      38
    ## 391    19     375    114      19 0.061333333      11
    ## 392    22     198     79       8 0.101010101      15
    ## 393    30    1013    562      42 0.156959526     118
    ## 394    33     612    289       3 0.186274510      52
    ## 395    69    1732    681      34 0.117205543     173
    ## 396    14     314    163      21 0.121019108      24
    ## 397    75    1421    611       0 0.179451091     101
    ## 398    18     135     63       3 0.148148148      14
    ## 399    82    3048   1933     103 0.198818898     412
    ## 400    47    1030    197      44 0.025242718      13
    ## 401    62     531    105       0 0.084745763      15
    ## 402    82    2653    816      16 0.119110441     136
    ## 403     7      47     12       0 0.106382979       2
    ## 404    82    3030   2061     101 0.231353135     356
    ## 405    78    1333    293      21 0.072768192      36
    ## 406    65    1190    403      56 0.079831933      45
    ## 407    13     222     45       2 0.076576577       5
    ## 408    75    2469    836      60 0.081409478     254
    ## 409    78    1516    772      49 0.157651715     147
    ## 410    60     774    209      26 0.063307494      33
    ## 411    47    1749    889     120 0.117781589     117
    ## 412    79    2279    740      55 0.096972356     133
    ## 413    24     358    129       5 0.134078212      18
    ## 414    63    1811    984     135 0.119271121     147
    ## 415    20     397    120       1 0.115869018      25
    ## 416    38     609    284       0 0.206896552      32
    ## 417    82    2397   1205     117 0.150187735     134
    ## 418    74    2132    975      17 0.168855535     204
    ## 419    63    1442    449      10 0.124826630      59
    ## 420    56    1486    425      51 0.076043069      46
    ## 421    25     160     57       9 0.062500000      10
    ## 422    60    1556    791     170 0.065552699      77
    ## 423    67    1091    383       1 0.136571952      82
    ## 424    48     560    241       0 0.187500000      31
    ## 425    54    1104    401       0 0.153079710      63
    ## 426    22     392    170      21 0.112244898      19
    ## 427    47     708    346       0 0.194915254      70
    ## 428    77    1560    613       3 0.145512821     150
    ## 429    54    1140    595      45 0.143859649     132
    ## 430    32     545    168       3 0.119266055      29
    ## 431    78    2730   1726     147 0.168131868     367
    ## 432    43     574    146      28 0.050522648       4
    ## 433     2      23      3       0 0.043478261       1
    ## 434    66    2176   1390     104 0.158547794     388
    ## 435    64    1362    434      77 0.058737151      43
    ## 436    67     963    419      35 0.142263759      40
    ## 437    82    1743    753      72 0.121629375     113
    ## 438    14     134     14       3 0.007462687       3
    ## 439    66    2048    951      26 0.184082031     119
    ## 440    61    1123    444      21 0.145146928      55
    ## 441    47    1298    397       0 0.117873652      91

``` r
dat[dat$points2 == max(dat$points2), ]
```

    ##            player team position height weight age experience
    ## 355 Anthony Davis  NOP        C     82    253  23          4
    ##                    college   salary games minutes points points3 points2
    ## 355 University of Kentucky 22116750    75    2708   2099      40     730
    ##     points1
    ## 355     519

-   Who is the player with the maximum rate of one-points (free-throws) per minute?

``` r
transform(dat, points1 = points1 / minutes)
```

    ##                       player team position height weight age experience
    ## 1                 Al Horford  BOS        C     82    245  30          9
    ## 2               Amir Johnson  BOS       PF     81    240  29         11
    ## 3              Avery Bradley  BOS       SG     74    180  26          6
    ## 4          Demetrius Jackson  BOS       PG     73    201  22          0
    ## 5               Gerald Green  BOS       SF     79    205  31          9
    ## 6              Isaiah Thomas  BOS       PG     69    185  27          5
    ## 7                Jae Crowder  BOS       SF     78    235  26          4
    ## 8                James Young  BOS       SG     78    215  21          2
    ## 9               Jaylen Brown  BOS       SF     79    225  20          0
    ## 10             Jonas Jerebko  BOS       PF     82    231  29          6
    ## 11             Jordan Mickey  BOS       PF     80    235  22          1
    ## 12              Kelly Olynyk  BOS        C     84    238  25          3
    ## 13              Marcus Smart  BOS       SG     76    220  22          2
    ## 14              Terry Rozier  BOS       PG     74    190  22          1
    ## 15              Tyler Zeller  BOS        C     84    253  27          4
    ## 16             Channing Frye  CLE        C     83    255  33         10
    ## 17             Dahntay Jones  CLE       SF     78    225  36         12
    ## 18            Deron Williams  CLE       PG     75    200  32         11
    ## 19          Derrick Williams  CLE       PF     80    240  25          5
    ## 20               Edy Tavares  CLE        C     87    260  24          1
    ## 21             Iman Shumpert  CLE       SG     77    220  26          5
    ## 22                J.R. Smith  CLE       SG     78    225  31         12
    ## 23               James Jones  CLE       SF     80    218  36         13
    ## 24                Kay Felder  CLE       PG     69    176  21          0
    ## 25                Kevin Love  CLE       PF     82    251  28          8
    ## 26               Kyle Korver  CLE       SG     79    212  35         13
    ## 27              Kyrie Irving  CLE       PG     75    193  24          5
    ## 28              LeBron James  CLE       SF     80    250  32         13
    ## 29         Richard Jefferson  CLE       SF     79    233  36         15
    ## 30          Tristan Thompson  CLE        C     81    238  25          5
    ## 31             Bruno Caboclo  TOR       SF     81    218  21          2
    ## 32               Cory Joseph  TOR       SG     75    193  25          5
    ## 33              Delon Wright  TOR       PG     77    183  24          1
    ## 34             DeMar DeRozan  TOR       SG     79    221  27          7
    ## 35           DeMarre Carroll  TOR       SF     80    215  30          7
    ## 36             Fred VanVleet  TOR       PG     72    195  22          0
    ## 37              Jakob Poeltl  TOR        C     84    248  21          0
    ## 38         Jonas Valanciunas  TOR        C     84    265  24          4
    ## 39                Kyle Lowry  TOR       PG     72    205  30         10
    ## 40            Lucas Nogueira  TOR        C     84    241  24          2
    ## 41             Norman Powell  TOR       SG     76    215  23          1
    ## 42               P.J. Tucker  TOR       SF     78    245  31          5
    ## 43             Pascal Siakam  TOR       PF     81    230  22          0
    ## 44         Patrick Patterson  TOR       PF     81    230  27          6
    ## 45               Serge Ibaka  TOR       PF     82    235  27          7
    ## 46          Bojan Bogdanovic  WAS       SF     80    216  27          2
    ## 47              Bradley Beal  WAS       SG     77    207  23          4
    ## 48          Brandon Jennings  WAS       PG     73    170  27          7
    ## 49          Chris McCullough  WAS       PF     83    200  21          1
    ## 50             Daniel Ochefu  WAS        C     83    245  23          0
    ## 51               Ian Mahinmi  WAS        C     83    250  30          8
    ## 52               Jason Smith  WAS        C     84    245  30          8
    ## 53                 John Wall  WAS       PG     76    195  26          6
    ## 54             Marcin Gortat  WAS        C     83    240  32          9
    ## 55           Markieff Morris  WAS       PF     82    245  27          5
    ## 56               Otto Porter  WAS       SF     80    198  23          3
    ## 57         Sheldon McClellan  WAS       SG     77    200  24          0
    ## 58          Tomas Satoransky  WAS       SG     79    210  25          0
    ## 59                Trey Burke  WAS       PG     73    191  24          3
    ## 60           DeAndre' Bembry  ATL       SF     78    210  22          0
    ## 61           Dennis Schroder  ATL       PG     73    172  23          3
    ## 62             Dwight Howard  ATL        C     83    265  31         12
    ## 63            Ersan Ilyasova  ATL       PF     82    235  29          8
    ## 64             Jose Calderon  ATL       PG     75    200  35         11
    ## 65             Kent Bazemore  ATL       SF     77    201  27          4
    ## 66            Kris Humphries  ATL       PF     81    235  31         12
    ## 67           Malcolm Delaney  ATL       PG     75    190  27          0
    ## 68             Mike Dunleavy  ATL       SF     81    230  36         14
    ## 69              Mike Muscala  ATL        C     83    240  25          3
    ## 70              Paul Millsap  ATL       PF     80    246  31         10
    ## 71                Ryan Kelly  ATL       PF     83    230  25          3
    ## 72           Thabo Sefolosha  ATL       SF     79    220  32         10
    ## 73              Tim Hardaway  ATL       SG     78    205  24          3
    ## 74     Giannis Antetokounmpo  MIL       SF     83    222  22          3
    ## 75               Greg Monroe  MIL        C     83    265  26          6
    ## 76             Jabari Parker  MIL       PF     80    250  21          2
    ## 77               Jason Terry  MIL       SG     74    185  39         17
    ## 78               John Henson  MIL        C     83    229  26          4
    ## 79           Khris Middleton  MIL       SF     80    234  25          4
    ## 80           Malcolm Brogdon  MIL       SG     77    215  24          0
    ## 81       Matthew Dellavedova  MIL       PG     76    198  26          3
    ## 82           Michael Beasley  MIL       PF     81    235  28          8
    ## 83           Mirza Teletovic  MIL       PF     81    242  31          4
    ## 84             Rashad Vaughn  MIL       SG     78    202  20          1
    ## 85             Spencer Hawes  MIL       PF     85    245  28          9
    ## 86                Thon Maker  MIL        C     85    216  19          0
    ## 87                Tony Snell  MIL       SG     79    200  25          3
    ## 88              Aaron Brooks  IND       PG     72    161  32          8
    ## 89              Al Jefferson  IND        C     82    289  32         12
    ## 90                C.J. Miles  IND       SF     78    225  29         11
    ## 91             Georges Niang  IND       PF     80    230  23          0
    ## 92               Jeff Teague  IND       PG     74    186  28          7
    ## 93                 Joe Young  IND       PG     74    180  24          1
    ## 94            Kevin Seraphin  IND       PF     81    285  27          6
    ## 95          Lance Stephenson  IND       SG     77    230  26          6
    ## 96               Lavoy Allen  IND       PF     81    260  27          5
    ## 97               Monta Ellis  IND       SG     75    185  31         11
    ## 98              Myles Turner  IND        C     83    243  20          1
    ## 99               Paul George  IND       SF     81    220  26          6
    ## 100         Rakeem Christmas  IND       PF     81    250  25          1
    ## 101           Thaddeus Young  IND       PF     80    221  28          9
    ## 102           Anthony Morrow  CHI       SG     77    210  31          8
    ## 103             Bobby Portis  CHI       PF     83    230  21          1
    ## 104            Cameron Payne  CHI       PG     75    185  22          1
    ## 105        Cristiano Felicio  CHI        C     82    275  24          1
    ## 106         Denzel Valentine  CHI       SG     78    212  23          0
    ## 107              Dwyane Wade  CHI       SG     76    220  35         13
    ## 108            Isaiah Canaan  CHI       SG     72    201  25          3
    ## 109             Jerian Grant  CHI       PG     76    195  24          1
    ## 110             Jimmy Butler  CHI       SF     79    220  27          5
    ## 111        Joffrey Lauvergne  CHI        C     83    220  25          2
    ## 112  Michael Carter-Williams  CHI       PG     78    190  25          3
    ## 113           Nikola Mirotic  CHI       PF     82    220  25          2
    ## 114              Paul Zipser  CHI       SF     80    215  22          0
    ## 115              Rajon Rondo  CHI       PG     73    186  30         10
    ## 116              Robin Lopez  CHI        C     84    255  28          8
    ## 117             Dion Waiters  MIA       SG     76    225  25          4
    ## 118             Goran Dragic  MIA       PG     75    190  30          8
    ## 119         Hassan Whiteside  MIA        C     84    265  27          4
    ## 120            James Johnson  MIA       PF     81    250  29          7
    ## 121           Josh McRoberts  MIA       PF     82    240  29          9
    ## 122          Josh Richardson  MIA       SG     78    200  23          1
    ## 123          Justise Winslow  MIA       SF     79    225  20          1
    ## 124             Luke Babbitt  MIA       SF     81    225  27          6
    ## 125              Okaro White  MIA       PF     80    204  24          0
    ## 126          Rodney McGruder  MIA       SG     76    205  25          0
    ## 127            Tyler Johnson  MIA       PG     76    186  24          2
    ## 128            Udonis Haslem  MIA        C     80    235  36         13
    ## 129          Wayne Ellington  MIA       SG     76    200  29          7
    ## 130              Willie Reed  MIA        C     82    220  26          1
    ## 131           Andre Drummond  DET        C     83    279  23          4
    ## 132              Aron Baynes  DET        C     82    260  30          4
    ## 133               Beno Udrih  DET       PG     75    205  34         12
    ## 134         Boban Marjanovic  DET        C     87    290  28          1
    ## 135          Darrun Hilliard  DET       SG     78    205  23          1
    ## 136           Henry Ellenson  DET       PF     83    245  20          0
    ## 137                Ish Smith  DET       PG     72    175  28          6
    ## 138                Jon Leuer  DET       PF     82    228  27          5
    ## 139 Kentavious Caldwell-Pope  DET       SG     77    205  23          3
    ## 140            Marcus Morris  DET       SF     81    235  27          5
    ## 141          Michael Gbinije  DET       SG     79    200  24          0
    ## 142           Reggie Bullock  DET       SF     79    205  25          3
    ## 143           Reggie Jackson  DET       PG     75    208  26          5
    ## 144          Stanley Johnson  DET       SF     79    245  20          1
    ## 145            Tobias Harris  DET       PF     81    235  24          5
    ## 146            Brian Roberts  CHO       PG     73    173  31          4
    ## 147            Briante Weber  CHO       PG     74    165  24          1
    ## 148           Christian Wood  CHO       PF     83    220  21          1
    ## 149              Cody Zeller  CHO       PF     84    240  24          3
    ## 150           Frank Kaminsky  CHO        C     84    242  23          1
    ## 151              Jeremy Lamb  CHO       SG     77    185  24          4
    ## 152          Johnny O'Bryant  CHO       PF     81    257  23          2
    ## 153             Kemba Walker  CHO       PG     73    172  26          5
    ## 154          Marco Belinelli  CHO       SG     77    210  30          9
    ## 155          Marvin Williams  CHO       PF     81    237  30         11
    ## 156   Michael Kidd-Gilchrist  CHO       SF     79    232  23          4
    ## 157            Miles Plumlee  CHO        C     83    249  28          4
    ## 158            Nicolas Batum  CHO       SG     80    200  28          8
    ## 159           Ramon Sessions  CHO       PG     75    190  30          9
    ## 160           Treveon Graham  CHO       SG     78    220  23          0
    ## 161          Carmelo Anthony  NYK       SF     80    240  32         13
    ## 162           Chasson Randle  NYK       PG     74    185  23          0
    ## 163             Courtney Lee  NYK       SG     77    200  31          8
    ## 164             Derrick Rose  NYK       PG     75    190  28          7
    ## 165              Joakim Noah  NYK        C     83    230  31          9
    ## 166           Justin Holiday  NYK       SG     78    185  27          3
    ## 167       Kristaps Porzingis  NYK       PF     87    240  21          1
    ## 168             Kyle O'Quinn  NYK        C     82    250  26          4
    ## 169             Lance Thomas  NYK       PF     80    235  28          5
    ## 170         Marshall Plumlee  NYK        C     84    250  24          0
    ## 171            Maurice Ndour  NYK       PF     81    200  24          0
    ## 172     Mindaugas Kuzminskas  NYK       SF     81    215  27          0
    ## 173                Ron Baker  NYK       SG     76    220  23          0
    ## 174            Sasha Vujacic  NYK       SG     79    195  32          9
    ## 175        Willy Hernangomez  NYK        C     83    240  22          0
    ## 176             Aaron Gordon  ORL       SF     81    220  21          2
    ## 177          Bismack Biyombo  ORL        C     81    255  24          5
    ## 178              C.J. Watson  ORL       PG     74    175  32          9
    ## 179            D.J. Augustin  ORL       PG     72    183  29          8
    ## 180             Damjan Rudez  ORL       SF     82    228  30          2
    ## 181            Elfrid Payton  ORL       PG     76    185  22          2
    ## 182            Evan Fournier  ORL       SG     79    205  24          4
    ## 183               Jeff Green  ORL       PF     81    235  30          8
    ## 184              Jodie Meeks  ORL       SG     76    210  29          7
    ## 185      Marcus Georges-Hunt  ORL       SG     77    216  22          0
    ## 186            Mario Hezonja  ORL       SF     80    215  21          1
    ## 187           Nikola Vucevic  ORL        C     84    260  26          5
    ## 188          Patricio Garino  ORL       SG     78    210  23          0
    ## 189        Stephen Zimmerman  ORL        C     84    240  20          0
    ## 190            Terrence Ross  ORL       SF     79    206  25          4
    ## 191           Alex Poythress  PHI       PF     79    238  23          0
    ## 192              Dario Saric  PHI       PF     82    223  22          0
    ## 193         Gerald Henderson  PHI       SG     77    215  29          7
    ## 194            Jahlil Okafor  PHI        C     83    275  21          1
    ## 195           Jerryd Bayless  PHI       PG     75    200  28          8
    ## 196              Joel Embiid  PHI        C     84    250  22          0
    ## 197          Justin Anderson  PHI       SF     78    228  23          1
    ## 198             Nik Stauskas  PHI       SG     78    205  23          2
    ## 199           Richaun Holmes  PHI        C     82    245  23          1
    ## 200         Robert Covington  PHI       SF     81    215  26          3
    ## 201         Sergio Rodriguez  PHI       PG     75    176  30          4
    ## 202               Shawn Long  PHI        C     81    255  24          0
    ## 203           T.J. McConnell  PHI       PG     74    200  24          1
    ## 204           Tiago Splitter  PHI        C     83    245  32          6
    ## 205  Timothe Luwawu-Cabarrot  PHI       SF     78    205  21          0
    ## 206         Andrew Nicholson  BRK       PF     81    250  27          4
    ## 207           Archie Goodwin  BRK       SG     77    200  22          3
    ## 208              Brook Lopez  BRK        C     84    275  28          8
    ## 209             Caris LeVert  BRK       SF     79    203  22          0
    ## 210         Isaiah Whitehead  BRK       PG     76    213  21          0
    ## 211               Jeremy Lin  BRK       PG     75    200  28          6
    ## 212               Joe Harris  BRK       SG     78    219  25          2
    ## 213          Justin Hamilton  BRK        C     84    260  26          2
    ## 214           K.J. McDaniels  BRK       SF     78    205  23          2
    ## 215               Quincy Acy  BRK       PF     79    240  26          4
    ## 216               Randy Foye  BRK       SG     76    213  33         10
    ## 217  Rondae Hollis-Jefferson  BRK       SF     79    220  22          1
    ## 218          Sean Kilpatrick  BRK       SG     76    210  27          2
    ## 219        Spencer Dinwiddie  BRK       PG     78    200  23          2
    ## 220            Trevor Booker  BRK       PF     80    228  29          6
    ## 221           Andre Iguodala  GSW       SF     78    215  33         12
    ## 222             Damian Jones  GSW        C     84    245  21          0
    ## 223               David West  GSW        C     81    250  36         13
    ## 224           Draymond Green  GSW       PF     79    230  26          4
    ## 225                Ian Clark  GSW       SG     75    175  25          3
    ## 226     James Michael McAdoo  GSW       PF     81    230  24          2
    ## 227             JaVale McGee  GSW        C     84    270  29          8
    ## 228             Kevin Durant  GSW       SF     81    240  28          9
    ## 229             Kevon Looney  GSW        C     81    220  20          1
    ## 230            Klay Thompson  GSW       SG     79    215  26          5
    ## 231              Matt Barnes  GSW       SF     79    226  36         13
    ## 232            Patrick McCaw  GSW       SG     79    185  21          0
    ## 233         Shaun Livingston  GSW       PG     79    192  31         11
    ## 234            Stephen Curry  GSW       PG     75    190  28          7
    ## 235            Zaza Pachulia  GSW        C     83    270  32         13
    ## 236              Bryn Forbes  SAS       SG     75    190  23          0
    ## 237              Danny Green  SAS       SG     78    215  29          7
    ## 238                David Lee  SAS       PF     81    245  33         11
    ## 239            Davis Bertans  SAS       PF     82    210  24          0
    ## 240          Dejounte Murray  SAS       PG     77    170  20          0
    ## 241           Dewayne Dedmon  SAS        C     84    245  27          3
    ## 242             Joel Anthony  SAS        C     81    245  34          9
    ## 243         Jonathon Simmons  SAS       SG     78    195  27          1
    ## 244            Kawhi Leonard  SAS       SF     79    230  25          5
    ## 245            Kyle Anderson  SAS       SG     81    230  23          2
    ## 246        LaMarcus Aldridge  SAS       PF     83    260  31         10
    ## 247            Manu Ginobili  SAS       SG     78    205  39         14
    ## 248              Patty Mills  SAS       PG     72    185  28          7
    ## 249                Pau Gasol  SAS        C     84    250  36         15
    ## 250              Tony Parker  SAS       PG     74    185  34         15
    ## 251              Bobby Brown  HOU       PG     74    175  32          2
    ## 252           Chinanu Onuaku  HOU        C     82    245  20          0
    ## 253             Clint Capela  HOU        C     82    240  22          2
    ## 254              Eric Gordon  HOU       SG     76    215  28          8
    ## 255            Isaiah Taylor  HOU       PG     75    170  22          0
    ## 256             James Harden  HOU       PG     77    220  27          7
    ## 257             Kyle Wiltjer  HOU       PF     82    240  24          0
    ## 258             Lou Williams  HOU       SG     73    175  30         11
    ## 259         Montrezl Harrell  HOU        C     80    240  23          1
    ## 260         Patrick Beverley  HOU       SG     73    185  28          4
    ## 261            Ryan Anderson  HOU       PF     82    240  28          8
    ## 262               Sam Dekker  HOU       SF     81    230  22          1
    ## 263             Trevor Ariza  HOU       SF     80    215  31         12
    ## 264            Troy Williams  HOU       SF     79    218  22          0
    ## 265            Alan Anderson  LAC       SF     78    220  34          7
    ## 266            Austin Rivers  LAC       SG     76    200  24          4
    ## 267            Blake Griffin  LAC       PF     82    251  27          6
    ## 268             Brandon Bass  LAC       PF     80    250  31         11
    ## 269            Brice Johnson  LAC       PF     82    230  22          0
    ## 270               Chris Paul  LAC       PG     72    175  31         11
    ## 271           DeAndre Jordan  LAC        C     83    265  28          8
    ## 272            Diamond Stone  LAC        C     83    255  19          0
    ## 273              J.J. Redick  LAC       SG     76    190  32         10
    ## 274           Jamal Crawford  LAC       SG     77    200  36         16
    ## 275         Luc Mbah a Moute  LAC       SF     80    230  30          8
    ## 276        Marreese Speights  LAC        C     82    255  29          8
    ## 277              Paul Pierce  LAC       SF     79    235  39         18
    ## 278           Raymond Felton  LAC       PG     73    205  32         11
    ## 279           Wesley Johnson  LAC       SF     79    215  29          6
    ## 280               Alec Burks  UTA       SG     78    214  25          5
    ## 281               Boris Diaw  UTA       PF     80    250  34         13
    ## 282               Dante Exum  UTA       PG     78    190  21          1
    ## 283           Derrick Favors  UTA       PF     82    265  25          6
    ## 284              George Hill  UTA       PG     75    188  30          8
    ## 285           Gordon Hayward  UTA       SF     80    226  26          6
    ## 286              Jeff Withey  UTA        C     84    231  26          3
    ## 287               Joe Ingles  UTA       SF     80    226  29          2
    ## 288              Joe Johnson  UTA       SF     79    240  35         15
    ## 289            Joel Bolomboy  UTA       PF     81    235  23          0
    ## 290                Raul Neto  UTA       PG     73    179  24          1
    ## 291              Rodney Hood  UTA       SG     80    206  24          2
    ## 292              Rudy Gobert  UTA        C     85    245  24          3
    ## 293             Shelvin Mack  UTA       PG     75    203  26          5
    ## 294               Trey Lyles  UTA       PF     82    234  21          1
    ## 295             Alex Abrines  OKC       SG     78    190  23          0
    ## 296           Andre Roberson  OKC       SF     79    210  25          3
    ## 297         Domantas Sabonis  OKC       PF     83    240  20          0
    ## 298           Doug McDermott  OKC       SF     80    225  25          2
    ## 299              Enes Kanter  OKC        C     83    245  24          5
    ## 300             Jerami Grant  OKC       SF     80    210  22          2
    ## 301             Josh Huestis  OKC       PF     79    230  25          1
    ## 302             Kyle Singler  OKC       SF     80    228  28          4
    ## 303            Nick Collison  OKC       PF     82    255  36         12
    ## 304              Norris Cole  OKC       PG     74    175  28          5
    ## 305        Russell Westbrook  OKC       PG     75    200  28          8
    ## 306           Semaj Christon  OKC       PG     75    190  24          0
    ## 307             Steven Adams  OKC        C     84    255  23          3
    ## 308               Taj Gibson  OKC       PF     81    225  31          7
    ## 309           Victor Oladipo  OKC       SG     76    210  24          3
    ## 310          Andrew Harrison  MEM       PG     78    213  22          0
    ## 311           Brandan Wright  MEM       PF     82    210  29          8
    ## 312         Chandler Parsons  MEM       SF     82    230  28          5
    ## 313            Deyonta Davis  MEM        C     83    237  20          0
    ## 314              James Ennis  MEM       SF     79    210  26          2
    ## 315           JaMychal Green  MEM       PF     81    227  26          2
    ## 316            Jarell Martin  MEM       PF     82    239  22          1
    ## 317               Marc Gasol  MEM        C     85    255  32          8
    ## 318              Mike Conley  MEM       PG     73    175  29          9
    ## 319               Tony Allen  MEM       SG     76    213  35         12
    ## 320             Troy Daniels  MEM       SG     76    205  25          3
    ## 321             Vince Carter  MEM       SF     78    220  40         18
    ## 322             Wade Baldwin  MEM       PG     76    202  20          0
    ## 323             Wayne Selden  MEM       SG     77    230  22          0
    ## 324            Zach Randolph  MEM       PF     81    260  35         15
    ## 325          Al-Farouq Aminu  POR       SF     81    220  26          6
    ## 326             Allen Crabbe  POR       SG     78    210  24          3
    ## 327            C.J. McCollum  POR       SG     76    200  25          3
    ## 328           Damian Lillard  POR       PG     75    195  26          4
    ## 329                 Ed Davis  POR       PF     82    240  27          6
    ## 330              Evan Turner  POR       SF     79    220  28          6
    ## 331              Jake Layman  POR       SF     81    210  22          0
    ## 332             Jusuf Nurkic  POR        C     84    280  22          2
    ## 333         Maurice Harkless  POR       SF     81    215  23          4
    ## 334           Meyers Leonard  POR       PF     85    245  24          4
    ## 335              Noah Vonleh  POR       PF     82    240  21          2
    ## 336          Pat Connaughton  POR       SG     77    206  24          1
    ## 337           Shabazz Napier  POR       PG     73    175  25          2
    ## 338           Tim Quarterman  POR       SG     78    195  22          0
    ## 339         Danilo Gallinari  DEN       SF     82    225  28          7
    ## 340           Darrell Arthur  DEN       PF     81    235  28          7
    ## 341          Emmanuel Mudiay  DEN       PG     77    200  20          1
    ## 342              Gary Harris  DEN       SG     76    210  22          2
    ## 343             Jamal Murray  DEN       SG     76    207  19          0
    ## 344            Jameer Nelson  DEN       PG     72    190  34         12
    ## 345         Juan Hernangomez  DEN       PF     81    230  21          0
    ## 346           Kenneth Faried  DEN       PF     80    228  27          5
    ## 347            Malik Beasley  DEN       SG     77    196  20          0
    ## 348            Mason Plumlee  DEN        C     83    245  26          3
    ## 349              Mike Miller  DEN       SF     80    218  36         16
    ## 350             Nikola Jokic  DEN        C     82    250  21          1
    ## 351              Roy Hibbert  DEN        C     86    270  30          8
    ## 352              Will Barton  DEN       SG     78    175  26          4
    ## 353          Wilson Chandler  DEN       SF     80    225  29          8
    ## 354            Alexis Ajinca  NOP        C     86    248  28          6
    ## 355            Anthony Davis  NOP        C     82    253  23          4
    ## 356             Axel Toupane  NOP       SF     79    197  24          1
    ## 357            Cheick Diallo  NOP       PF     81    220  20          0
    ## 358         Dante Cunningham  NOP       SF     80    230  29          7
    ## 359         DeMarcus Cousins  NOP        C     83    270  26          6
    ## 360       Donatas Motiejunas  NOP       PF     84    222  26          4
    ## 361            E'Twaun Moore  NOP       SG     76    191  27          5
    ## 362          Jordan Crawford  NOP       SG     76    195  28          4
    ## 363             Jrue Holiday  NOP       PG     76    205  26          7
    ## 364                Omer Asik  NOP        C     84    255  30          6
    ## 365               Quinn Cook  NOP       PG     74    184  23          0
    ## 366             Solomon Hill  NOP       SF     79    225  25          3
    ## 367              Tim Frazier  NOP       PG     73    170  26          2
    ## 368             A.J. Hammons  DAL        C     84    260  24          0
    ## 369          DeAndre Liggins  DAL       SG     78    209  28          3
    ## 370             Devin Harris  DAL       PG     75    192  33         12
    ## 371            Dirk Nowitzki  DAL       PF     84    245  38         18
    ## 372      Dorian Finney-Smith  DAL       PF     80    220  23          0
    ## 373            Dwight Powell  DAL        C     83    240  25          2
    ## 374          Harrison Barnes  DAL       PF     80    210  24          4
    ## 375               J.J. Barea  DAL       PG     72    185  32         10
    ## 376            Jarrod Uthoff  DAL       PF     81    221  23          0
    ## 377             Nerlens Noel  DAL        C     83    228  22          2
    ## 378         Nicolas Brussino  DAL       SF     79    195  23          0
    ## 379              Salah Mejri  DAL        C     85    245  30          1
    ## 380               Seth Curry  DAL       PG     74    185  26          3
    ## 381          Wesley Matthews  DAL       SG     77    220  30          7
    ## 382             Yogi Ferrell  DAL       PG     72    180  23          0
    ## 383         Anthony Tolliver  SAC       PF     80    240  31          8
    ## 384            Arron Afflalo  SAC       SG     77    210  31          9
    ## 385             Ben McLemore  SAC       SG     77    195  23          3
    ## 386              Buddy Hield  SAC       SG     76    214  23          0
    ## 387          Darren Collison  SAC       PG     72    175  29          7
    ## 388           Garrett Temple  SAC       SG     78    195  30          6
    ## 389     Georgios Papagiannis  SAC        C     85    240  19          0
    ## 390             Kosta Koufos  SAC        C     84    265  27          8
    ## 391        Langston Galloway  SAC       PG     74    200  25          2
    ## 392       Malachi Richardson  SAC       SG     78    205  21          0
    ## 393                 Rudy Gay  SAC       SF     80    230  30         10
    ## 394          Skal Labissiere  SAC       PF     83    225  20          0
    ## 395                Ty Lawson  SAC       PG     71    195  29          7
    ## 396             Tyreke Evans  SAC       SF     78    220  27          7
    ## 397      Willie Cauley-Stein  SAC        C     84    240  23          1
    ## 398            Adreian Payne  MIN       PF     82    237  25          2
    ## 399           Andrew Wiggins  MIN       SF     80    199  21          2
    ## 400             Brandon Rush  MIN       SG     78    220  31          8
    ## 401             Cole Aldrich  MIN        C     83    250  28          6
    ## 402             Gorgui Dieng  MIN       PF     83    241  27          3
    ## 403              Jordan Hill  MIN        C     82    235  29          7
    ## 404       Karl-Anthony Towns  MIN        C     84    244  21          1
    ## 405                Kris Dunn  MIN       PG     76    210  22          0
    ## 406          Nemanja Bjelica  MIN       PF     82    240  28          1
    ## 407              Omri Casspi  MIN       SF     81    225  28          7
    ## 408              Ricky Rubio  MIN       PG     76    194  26          5
    ## 409         Shabazz Muhammad  MIN       SF     78    223  24          3
    ## 410               Tyus Jones  MIN       PG     74    195  20          1
    ## 411              Zach LaVine  MIN       SG     77    189  21          2
    ## 412           Brandon Ingram  LAL       SF     81    190  19          0
    ## 413             Corey Brewer  LAL       SF     81    186  30          9
    ## 414         D'Angelo Russell  LAL       PG     77    195  20          1
    ## 415              David Nwaba  LAL       SG     76    209  24          0
    ## 416              Ivica Zubac  LAL        C     85    265  19          0
    ## 417          Jordan Clarkson  LAL       SG     77    194  24          2
    ## 418            Julius Randle  LAL       PF     81    250  22          2
    ## 419          Larry Nance Jr.  LAL       PF     81    230  24          1
    ## 420                Luol Deng  LAL       SF     81    220  31         12
    ## 421        Metta World Peace  LAL       SF     78    260  37         16
    ## 422               Nick Young  LAL       SG     79    210  31          9
    ## 423              Tarik Black  LAL        C     81    250  25          2
    ## 424          Thomas Robinson  LAL       PF     82    237  25          4
    ## 425           Timofey Mozgov  LAL        C     85    275  30          6
    ## 426              Tyler Ennis  LAL       PG     75    194  22          2
    ## 427            Alan Williams  PHO        C     80    260  24          1
    ## 428                 Alex Len  PHO        C     85    260  23          3
    ## 429           Brandon Knight  PHO       SG     75    189  25          5
    ## 430            Derrick Jones  PHO       SF     79    190  19          0
    ## 431             Devin Booker  PHO       SG     78    206  20          1
    ## 432            Dragan Bender  PHO       PF     85    225  19          0
    ## 433           Elijah Millsap  PHO       SG     78    225  29          2
    ## 434             Eric Bledsoe  PHO       PG     73    190  27          6
    ## 435             Jared Dudley  PHO       PF     79    225  31          9
    ## 436          Leandro Barbosa  PHO       SG     75    194  34         13
    ## 437          Marquese Chriss  PHO       PF     82    233  19          0
    ## 438             Ronnie Price  PHO       PG     74    190  33         11
    ## 439              T.J. Warren  PHO       SF     80    230  23          2
    ## 440               Tyler Ulis  PHO       PG     70    150  21          0
    ## 441           Tyson Chandler  PHO        C     85    240  34         15
    ##                                                      college   salary
    ## 1                                      University of Florida 26540100
    ## 2                                                            12000000
    ## 3                              University of Texas at Austin  8269663
    ## 4                                   University of Notre Dame  1450000
    ## 5                                                             1410598
    ## 6                                   University of Washington  6587132
    ## 7                                       Marquette University  6286408
    ## 8                                     University of Kentucky  1825200
    ## 9                                   University of California  4743000
    ## 10                                                            5000000
    ## 11                                Louisiana State University  1223653
    ## 12                                        Gonzaga University  3094014
    ## 13                                 Oklahoma State University  3578880
    ## 14                                  University of Louisville  1906440
    ## 15                              University of North Carolina  8000000
    ## 16                                     University of Arizona  7806971
    ## 17                                           Duke University    18255
    ## 18                University of Illinois at Urbana-Champaign   259626
    ## 19                                     University of Arizona   268029
    ## 20                                                               5145
    ## 21                           Georgia Institute of Technology  9700000
    ## 22                                                           12800000
    ## 23                                       University of Miami  1551659
    ## 24                                        Oakland University   543471
    ## 25                     University of California, Los Angeles 21165675
    ## 26                                      Creighton University  5239437
    ## 27                                           Duke University 17638063
    ## 28                                                           30963450
    ## 29                                     University of Arizona  2500000
    ## 30                             University of Texas at Austin 15330435
    ## 31                                                            1589640
    ## 32                             University of Texas at Austin  7330000
    ## 33                                        University of Utah  1577280
    ## 34                         University of Southern California 26540100
    ## 35                                    University of Missouri 14200000
    ## 36                                  Wichita State University   543471
    ## 37                                        University of Utah  2703960
    ## 38                                                           14382022
    ## 39                                      Villanova University 12000000
    ## 40                                                            1921320
    ## 41                     University of California, Los Angeles   874636
    ## 42                             University of Texas at Austin  5300000
    ## 43                               New Mexico State University  1196040
    ## 44                                    University of Kentucky  6050000
    ## 45                                                           12250000
    ## 46                                                            3730653
    ## 47                                     University of Florida 22116750
    ## 48                                                            1200000
    ## 49                                       Syracuse University  1191480
    ## 50                                      Villanova University   543471
    ## 51                                                           15944154
    ## 52                                 Colorado State University  5000000
    ## 53                                    University of Kentucky 16957900
    ## 54                                                           12000000
    ## 55                                      University of Kansas  7400000
    ## 56                                     Georgetown University  5893981
    ## 57                                       University of Miami   543471
    ## 58                                                            2870813
    ## 59                                    University of Michigan  3386598
    ## 60                                 Saint Joseph's University  1499760
    ## 61                                                            2708582
    ## 62                                                           23180275
    ## 63                                                            8400000
    ## 64                                                             392478
    ## 65                                   Old Dominion University 15730338
    ## 66                                   University of Minnesota  4000000
    ## 67       Virginia Polytechnic Institute and State University  2500000
    ## 68                                           Duke University  4837500
    ## 69                                       Bucknell University  1015696
    ## 70                                 Louisiana Tech University 20072033
    ## 71                                           Duke University   418228
    ## 72                                                            3850000
    ## 73                                    University of Michigan  2281605
    ## 74                                                            2995421
    ## 75                                     Georgetown University 17100000
    ## 76                                           Duke University  5374320
    ## 77                                     University of Arizona  1551659
    ## 78                              University of North Carolina 12517606
    ## 79                                      Texas A&M University 15200000
    ## 80                                    University of Virginia   925000
    ## 81                        Saint Mary's College of California  9607500
    ## 82                                   Kansas State University  1403611
    ## 83                                                           10500000
    ## 84                           University of Nevada, Las Vegas  1811040
    ## 85                                  University of Washington  6348759
    ## 86                                                            2568600
    ## 87                                  University of New Mexico  2368327
    ## 88                                      University of Oregon  2700000
    ## 89                                                           10230179
    ## 90                                                            4583450
    ## 91                                     Iowa State University   650000
    ## 92                                    Wake Forest University  8800000
    ## 93                                      University of Oregon  1052342
    ## 94                                                            1800000
    ## 95                                  University of Cincinnati  4000000
    ## 96                                         Temple University  4000000
    ## 97                                                           10770000
    ## 98                             University of Texas at Austin  2463840
    ## 99                       California State University, Fresno 18314532
    ## 100                                      Syracuse University  1052342
    ## 101                          Georgia Institute of Technology 14153652
    ## 102                          Georgia Institute of Technology  3488000
    ## 103                                   University of Arkansas  1453680
    ## 104                                  Murray State University  2112480
    ## 105                                                            874636
    ## 106                                Michigan State University  2092200
    ## 107                                     Marquette University 23200000
    ## 108                                  Murray State University  1015696
    ## 109                                 University of Notre Dame  1643040
    ## 110                                     Marquette University 17552209
    ## 111                                                           1709720
    ## 112                                      Syracuse University  3183526
    ## 113                                                           5782450
    ## 114                                                            750000
    ## 115                                   University of Kentucky 14000000
    ## 116                                      Stanford University 13219250
    ## 117                                      Syracuse University  2898000
    ## 118                                                          15890000
    ## 119                                      Marshall University 22116750
    ## 120                                   Wake Forest University  4000000
    ## 121                                          Duke University  5782450
    ## 122                                  University of Tennessee   874636
    ## 123                                          Duke University  2593440
    ## 124                               University of Nevada, Reno  1227000
    ## 125                                 Florida State University   210995
    ## 126                                  Kansas State University   543471
    ## 127                      California State University, Fresno  5628000
    ## 128                                    University of Florida  4000000
    ## 129                             University of North Carolina  6000000
    ## 130                                   Saint Louis University  1015696
    ## 131                                University of Connecticut 22116750
    ## 132                              Washington State University  6500000
    ## 133                                                           1551659
    ## 134                                                           7000000
    ## 135                                     Villanova University   874060
    ## 136                                     Marquette University  1704120
    ## 137                                   Wake Forest University  6000000
    ## 138                                  University of Wisconsin 10991957
    ## 139                                    University of Georgia  3678319
    ## 140                                     University of Kansas  4625000
    ## 141                                      Syracuse University   650000
    ## 142                             University of North Carolina  2255644
    ## 143                                           Boston College 14956522
    ## 144                                    University of Arizona  2969880
    ## 145                                  University of Tennessee 17200000
    ## 146                                     University of Dayton  1050961
    ## 147                         Virginia Commonwealth University   102898
    ## 148                          University of Nevada, Las Vegas   874636
    ## 149                                       Indiana University  5318313
    ## 150                                  University of Wisconsin  2730000
    ## 151                                University of Connecticut  6511628
    ## 152                               Louisiana State University   161483
    ## 153                                University of Connecticut 12000000
    ## 154                                                           6333333
    ## 155                             University of North Carolina 12250000
    ## 156                                   University of Kentucky 13000000
    ## 157                                          Duke University 12500000
    ## 158                                                          20869566
    ## 159                               University of Nevada, Reno  6000000
    ## 160                         Virginia Commonwealth University   543471
    ## 161                                      Syracuse University 24559380
    ## 162                                      Stanford University   143860
    ## 163                              Western Kentucky University 11242000
    ## 164                                    University of Memphis 21323250
    ## 165                                    University of Florida 17000000
    ## 166                                 University of Washington  1015696
    ## 167                                                           4317720
    ## 168                                 Norfolk State University  3900000
    ## 169                                          Duke University  6191000
    ## 170                                          Duke University   543471
    ## 171                                          Ohio University   543471
    ## 172                                                           2898000
    ## 173                                 Wichita State University   543471
    ## 174                                                           1410598
    ## 175                                                           1375000
    ## 176                                    University of Arizona  4351320
    ## 177                                                          17000000
    ## 178                                  University of Tennessee  5000000
    ## 179                            University of Texas at Austin  7250000
    ## 180                                                            980431
    ## 181                     University of Louisiana at Lafayette  2613600
    ## 182                                                          17000000
    ## 183                                    Georgetown University 15000000
    ## 184                                   University of Kentucky  6540000
    ## 185                          Georgia Institute of Technology    31969
    ## 186                                                           3909840
    ## 187                        University of Southern California 11750000
    ## 188                             George Washington University    31969
    ## 189                          University of Nevada, Las Vegas   950000
    ## 190                                 University of Washington 10000000
    ## 191                                   University of Kentucky    31969
    ## 192                                                           2318280
    ## 193                                          Duke University  9000000
    ## 194                                          Duke University  4788840
    ## 195                                    University of Arizona  9424084
    ## 196                                     University of Kansas  4826160
    ## 197                                   University of Virginia  1514160
    ## 198                                   University of Michigan  2993040
    ## 199                           Bowling Green State University  1025831
    ## 200                               Tennessee State University  1015696
    ## 201                                                           8000000
    ## 202                     University of Louisiana at Lafayette    89513
    ## 203                                    University of Arizona   874636
    ## 204                                                           8550000
    ## 205                                                           1326960
    ## 206                               St. Bonaventure University  6088993
    ## 207                                   University of Kentucky   119494
    ## 208                                      Stanford University 21165675
    ## 209                                   University of Michigan  1562280
    ## 210                                    Seton Hall University  1074145
    ## 211                                       Harvard University 11483254
    ## 212                                   University of Virginia   980431
    ## 213                               Louisiana State University  3000000
    ## 214                                       Clemson University  3333333
    ## 215                                        Baylor University  1790902
    ## 216                                     Villanova University  2500000
    ## 217                                    University of Arizona  1395600
    ## 218                                 University of Cincinnati   980431
    ## 219                                   University of Colorado   726672
    ## 220                                       Clemson University  9250000
    ## 221                                    University of Arizona 11131368
    ## 222                                    Vanderbilt University  1171560
    ## 223                                        Xavier University  1551659
    ## 224                                Michigan State University 15330435
    ## 225                                       Belmont University  1015696
    ## 226                             University of North Carolina   980431
    ## 227                               University of Nevada, Reno  1403611
    ## 228                            University of Texas at Austin 26540100
    ## 229                    University of California, Los Angeles  1182840
    ## 230                              Washington State University 16663575
    ## 231                    University of California, Los Angeles   383351
    ## 232                          University of Nevada, Las Vegas   543471
    ## 233                                                           5782450
    ## 234                                         Davidson College 12112359
    ## 235                                                           2898000
    ## 236                                Michigan State University   543471
    ## 237                             University of North Carolina 10000000
    ## 238                                    University of Florida  1551659
    ## 239                                                            543471
    ## 240                                 University of Washington  1180080
    ## 241                        University of Southern California  2898000
    ## 242                          University of Nevada, Las Vegas   165952
    ## 243                                    University of Houston   874636
    ## 244                               San Diego State University 17638063
    ## 245                    University of California, Los Angeles  1192080
    ## 246                            University of Texas at Austin 20575005
    ## 247                                                          14000000
    ## 248                       Saint Mary's College of California  3578948
    ## 249                                                          15500000
    ## 250                                                          14445313
    ## 251                   California State University, Fullerton   680534
    ## 252                                 University of Louisville   543471
    ## 253                                                           1296240
    ## 254                                       Indiana University 12385364
    ## 255                            University of Texas at Austin   255000
    ## 256                                 Arizona State University 26540100
    ## 257                                       Gonzaga University   543471
    ## 258                                                           7000000
    ## 259                                 University of Louisville  1000000
    ## 260                                   University of Arkansas  6000000
    ## 261                                 University of California 18735364
    ## 262                                  University of Wisconsin  1720560
    ## 263                    University of California, Los Angeles  7806971
    ## 264                                       Indiana University   150000
    ## 265                                Michigan State University  1315448
    ## 266                                          Duke University 11000000
    ## 267                                   University of Oklahoma 20140838
    ## 268                               Louisiana State University  1551659
    ## 269                             University of North Carolina  1273920
    ## 270                                   Wake Forest University 22868828
    ## 271                                     Texas A&M University 21165675
    ## 272                                   University of Maryland   543471
    ## 273                                          Duke University  7377500
    ## 274                                   University of Michigan 13253012
    ## 275                    University of California, Los Angeles  2203000
    ## 276                                    University of Florida  1403611
    ## 277                                     University of Kansas  3500000
    ## 278                             University of North Carolina  1551659
    ## 279                                      Syracuse University  5628000
    ## 280                                   University of Colorado 10154495
    ## 281                                                           7000000
    ## 282                                                           3940320
    ## 283                          Georgia Institute of Technology 11050000
    ## 284        Indiana University-Purdue University Indianapolis  8000000
    ## 285                                        Butler University 16073140
    ## 286                                     University of Kansas  1015696
    ## 287                                                           2250000
    ## 288                                   University of Arkansas 11000000
    ## 289                                   Weber State University   600000
    ## 290                                                            937800
    ## 291                                          Duke University  1406520
    ## 292                                                           2121288
    ## 293                                        Butler University  2433334
    ## 294                                   University of Kentucky  2340600
    ## 295                                                           5994764
    ## 296                                   University of Colorado  2183072
    ## 297                                       Gonzaga University  2440200
    ## 298                                     Creighton University  2483040
    ## 299                                                          17145838
    ## 300                                      Syracuse University   980431
    ## 301                                      Stanford University  1191480
    ## 302                                          Duke University  4837500
    ## 303                                     University of Kansas  3750000
    ## 304                               Cleveland State University   247991
    ## 305                    University of California, Los Angeles 26540100
    ## 306                                        Xavier University   543471
    ## 307                                 University of Pittsburgh  3140517
    ## 308                        University of Southern California  8950000
    ## 309                                       Indiana University  6552960
    ## 310                                   University of Kentucky   945000
    ## 311                             University of North Carolina  5700000
    ## 312                                    University of Florida 22116750
    ## 313                                Michigan State University  1369229
    ## 314                  California State University, Long Beach  2898000
    ## 315                                    University of Alabama   980431
    ## 316                               Louisiana State University  1286160
    ## 317                                                          21165675
    ## 318                                    Ohio State University 26540100
    ## 319                                Oklahoma State University  5505618
    ## 320                         Virginia Commonwealth University  3332940
    ## 321                             University of North Carolina  4264057
    ## 322                                    Vanderbilt University  1793760
    ## 323                                     University of Kansas    83119
    ## 324                                Michigan State University 10361445
    ## 325                                   Wake Forest University  7680965
    ## 326                                 University of California 18500000
    ## 327                                        Lehigh University  3219579
    ## 328                                   Weber State University 24328425
    ## 329                             University of North Carolina  6666667
    ## 330                                    Ohio State University 16393443
    ## 331                                   University of Maryland   600000
    ## 332                                                           1921320
    ## 333                                    St. John's University  8988764
    ## 334               University of Illinois at Urbana-Champaign  9213484
    ## 335                                       Indiana University  2751360
    ## 336                                 University of Notre Dame   874636
    ## 337                                University of Connecticut  1350120
    ## 338                               Louisiana State University   543471
    ## 339                                                          15050000
    ## 340                                     University of Kansas  8070175
    ## 341                                                           3241800
    ## 342                                Michigan State University  1655880
    ## 343                                   University of Kentucky  3210840
    ## 344                                Saint Joseph's University  4540525
    ## 345                                                           1987440
    ## 346                                Morehead State University 12078652
    ## 347                                 Florida State University  1627320
    ## 348                                          Duke University  2328530
    ## 349                                    University of Florida  3500000
    ## 350                                                           1358500
    ## 351                                    Georgetown University  5000000
    ## 352                                    University of Memphis  3533333
    ## 353                                        DePaul University 11200000
    ## 354                                                           4600000
    ## 355                                   University of Kentucky 22116750
    ## 356                                                             20580
    ## 357                                     University of Kansas   543471
    ## 358                                     Villanova University  2978250
    ## 359                                   University of Kentucky 16957900
    ## 360                                                            576724
    ## 361                                        Purdue University  8081363
    ## 362                                        Xavier University   173094
    ## 363                    University of California, Los Angeles 11286518
    ## 364                                                           9904494
    ## 365                                          Duke University    63938
    ## 366                                    University of Arizona 11241218
    ## 367                            Pennsylvania State University  2090000
    ## 368                                        Purdue University   650000
    ## 369                                   University of Kentucky  1015696
    ## 370                                  University of Wisconsin  4228000
    ## 371                                                          25000000
    ## 372                                    University of Florida   543471
    ## 373                                      Stanford University  8375000
    ## 374                             University of North Carolina 22116750
    ## 375                                  Northeastern University  4096950
    ## 376                                       University of Iowa    63938
    ## 377                                   University of Kentucky  4384490
    ## 378                                                            543471
    ## 379                                                            874636
    ## 380                                          Duke University  2898000
    ## 381                                     Marquette University 17100000
    ## 382                                       Indiana University   207798
    ## 383                                     Creighton University  8000000
    ## 384                    University of California, Los Angeles 12500000
    ## 385                                     University of Kansas  4008882
    ## 386                                   University of Oklahoma  3517200
    ## 387                    University of California, Los Angeles  5229454
    ## 388                               Louisiana State University  8000000
    ## 389                                                           2202240
    ## 390                                    Ohio State University  8046500
    ## 391                                Saint Joseph's University  5200000
    ## 392                                      Syracuse University  1439880
    ## 393                                University of Connecticut 13333333
    ## 394                                   University of Kentucky  1188840
    ## 395                             University of North Carolina  1315448
    ## 396                                    University of Memphis 10661286
    ## 397                                   University of Kentucky  3551160
    ## 398                                Michigan State University  2022240
    ## 399                                     University of Kansas  6006600
    ## 400                                     University of Kansas  3500000
    ## 401                                     University of Kansas  7643979
    ## 402                                 University of Louisville  2348783
    ## 403                                    University of Arizona  3911380
    ## 404                                   University of Kentucky  5960160
    ## 405                                       Providence College  3872520
    ## 406                                                           3800000
    ## 407                                                            138414
    ## 408                                                          13550000
    ## 409                    University of California, Los Angeles  3046299
    ## 410                                          Duke University  1339680
    ## 411                    University of California, Los Angeles  2240880
    ## 412                                          Duke University  5281680
    ## 413                                    University of Florida  7600000
    ## 414                                    Ohio State University  5332800
    ## 415 California Polytechnic State University, San Luis Obispo    73528
    ## 416                                                           1034956
    ## 417                                   University of Missouri 12500000
    ## 418                                   University of Kentucky  3267120
    ## 419                                    University of Wyoming  1207680
    ## 420                                          Duke University 18000000
    ## 421                                    St. John's University  1551659
    ## 422                        University of Southern California  5443918
    ## 423                                     University of Kansas  6191000
    ## 424                                     University of Kansas  1050961
    ## 425                                                          16000000
    ## 426                                      Syracuse University  1733880
    ## 427                  University of California, Santa Barbara   874636
    ## 428                                   University of Maryland  4823621
    ## 429                                   University of Kentucky 12606250
    ## 430                          University of Nevada, Las Vegas   543471
    ## 431                                   University of Kentucky  2223600
    ## 432                                                           4276320
    ## 433                      University of Alabama at Birmingham    23069
    ## 434                                   University of Kentucky 14000000
    ## 435                                           Boston College 10470000
    ## 436                                                           4000000
    ## 437                                 University of Washington  2941440
    ## 438                                Utah Valley State College   282595
    ## 439                          North Carolina State University  2128920
    ## 440                                   University of Kentucky   918369
    ## 441                                                          12415000
    ##     games minutes points points3 points2     points1
    ## 1      68    2193    952      86     293 0.049247606
    ## 2      80    1608    520      27     186 0.041666667
    ## 3      55    1835    894     108     251 0.037057221
    ## 4       5      17     10       1       2 0.176470588
    ## 5      47     538    262      39      56 0.061338290
    ## 6      76    2569   2199     245     437 0.229661347
    ## 7      72    2335    999     157     176 0.075374732
    ## 8      29     220     68      12      13 0.027272727
    ## 9      78    1341    515      46     146 0.063385533
    ## 10     78    1232    299      45      69 0.021103896
    ## 11     25     141     38       0      15 0.056737589
    ## 12     75    1538    678      68     192 0.058517555
    ## 13     79    2399    835      94     175 0.084618591
    ## 14     74    1263    410      57      94 0.040380048
    ## 15     51     525    178       0      78 0.041904762
    ## 16     74    1398    676     137     101 0.045064378
    ## 17      1      12      9       0       3 0.250000000
    ## 18     24     486    179      22      46 0.043209877
    ## 19     25     427    156      21      33 0.063231850
    ## 20      1      24      6       0       3 0.000000000
    ## 21     76    1937    567      94     107 0.036654621
    ## 22     41    1187    351      95      28 0.008424600
    ## 23     48     381    132      31      13 0.034120735
    ## 24     42     386    166       7      55 0.090673575
    ## 25     60    1885   1142     145     225 0.136339523
    ## 26     35     859    373      97      34 0.016298021
    ## 27     72    2525   1816     177     494 0.117623762
    ## 28     74    2794   1954     124     612 0.128131711
    ## 29     79    1614    448      62      91 0.049566295
    ## 30     78    2336    630       0     262 0.045376712
    ## 31      9      40     14       2       4 0.000000000
    ## 32     80    2003    740      48     251 0.046929606
    ## 33     27     446    150      10      39 0.094170404
    ## 34     74    2620   2020      33     688 0.208015267
    ## 35     72    1882    638     109     111 0.047290117
    ## 36     37     294    107      11      28 0.061224490
    ## 37     54     626    165       0      67 0.049520767
    ## 38     80    2066    959       1     390 0.085188771
    ## 39     60    2244   1344     193     233 0.133244207
    ## 40     57    1088    253       3     100 0.040441176
    ## 41     76    1368    636      56     171 0.092105263
    ## 42     24     609    139      24      28 0.018062397
    ## 43     55     859    229       1     102 0.025611176
    ## 44     65    1599    445      94      60 0.026891807
    ## 45     23     712    327      41      87 0.042134831
    ## 46     26     601    330      45      62 0.118136439
    ## 47     77    2684   1779     223     414 0.105067064
    ## 48     23     374     81      11      18 0.032085561
    ## 49      2       8      1       0       0 0.125000000
    ## 50     19      75     24       0      12 0.000000000
    ## 51     31     555    173       0      65 0.077477477
    ## 52     74    1068    420      37     137 0.032771536
    ## 53     78    2836   1805      89     558 0.148801128
    ## 54     82    2556    883       0     390 0.040297340
    ## 55     76    2374   1063      71     335 0.075821398
    ## 56     80    2605   1075     148     266 0.038003839
    ## 57     30     287     90       7      23 0.080139373
    ## 58     57     719    154       9      52 0.031988873
    ## 59     57     703    285      31      85 0.031294452
    ## 60     38     371    101       1      46 0.016172507
    ## 61     79    2485   1414     100     448 0.087726358
    ## 62     74    2199   1002       0     388 0.102773988
    ## 63     26     633    270      32      61 0.082148499
    ## 64     17     247     61       8      15 0.028340081
    ## 65     73    1963    801      92     203 0.060621498
    ## 66     56     689    257      19      68 0.092888244
    ## 67     73    1248    391      26     119 0.060096154
    ## 68     30     475    169      33      24 0.046315789
    ## 69     70    1237    435      46     124 0.039611964
    ## 70     69    2343   1246      75     355 0.132735809
    ## 71     16     110     25       4       4 0.045454545
    ## 72     62    1596    444      41     133 0.034461153
    ## 73     79    2154   1143     149     266 0.076137419
    ## 74     80    2845   1832      49     607 0.165553603
    ## 75     81    1823    951       0     387 0.097092704
    ## 76     51    1728   1025      65     334 0.093750000
    ## 77     74    1365    307      73      32 0.017582418
    ## 78     58    1123    392       0     159 0.065894924
    ## 79     29     889    426      45     105 0.091113611
    ## 80     75    1982    767      78     212 0.054994955
    ## 81     76    1986    577      79     129 0.041289023
    ## 82     56     935    528      18     198 0.083422460
    ## 83     70    1133    451     104      52 0.030891439
    ## 84     41     458    142      26      31 0.004366812
    ## 85     19     171     83       9      21 0.081871345
    ## 86     57     562    226      28      55 0.056939502
    ## 87     80    2336    683     144     102 0.020119863
    ## 88     65     894    322      48      73 0.035794183
    ## 89     66     931    535       0     235 0.069817401
    ## 90     76    1776    815     169     112 0.047297297
    ## 91     23      93     21       1       8 0.021505376
    ## 92     82    2657   1254      90     312 0.135491155
    ## 93     33     135     68       5      21 0.081481481
    ## 94     49     559    232       0     109 0.025044723
    ## 95      6     132     43       5      13 0.015151515
    ## 96     61     871    177       0      77 0.026406429
    ## 97     74    1998    630      43     204 0.046546547
    ## 98     81    2541   1173      40     404 0.096418733
    ## 99     75    2689   1775     195     427 0.124953514
    ## 100    29     219     59       0      19 0.095890411
    ## 101    74    2237    814      45     317 0.020116227
    ## 102     9      87     41       6       6 0.126436782
    ## 103    64    1000    437      32     151 0.039000000
    ## 104    11     142     54      11      10 0.007042254
    ## 105    66    1040    316       0     128 0.057692308
    ## 106    57     976    291      73      29 0.014344262
    ## 107    60    1792   1096      45     369 0.124441964
    ## 108    39     592    181      25      38 0.050675676
    ## 109    63    1028    370      49      79 0.063229572
    ## 110    76    2809   1816      91     479 0.208259167
    ## 111    20     241     89       6      31 0.037344398
    ## 112    45     846    297      15      97 0.068557920
    ## 113    70    1679    744     129     129 0.058963669
    ## 114    44     843    240      33      55 0.036773428
    ## 115    69    1843    538      50     179 0.016277808
    ## 116    81    2271    839       0     382 0.033025099
    ## 117    46    1384    729      85     196 0.059248555
    ## 118    73    2459   1483     117     417 0.121187475
    ## 119    77    2513   1309       0     542 0.089534421
    ## 120    76    2085    975      87     281 0.072901679
    ## 121    22     381    107      13      31 0.015748031
    ## 122    53    1614    539      75     127 0.037174721
    ## 123    18     625    196       7      73 0.046400000
    ## 124    68    1065    324      87      26 0.010328638
    ## 125    35     471     98      12      21 0.042462845
    ## 126    78    1966    497      73     117 0.022380468
    ## 127    73    2178   1002      93     264 0.089531680
    ## 128    17     130     31       0      11 0.069230769
    ## 129    62    1500    648     149      82 0.024666667
    ## 130    71    1031    374       1     161 0.047526673
    ## 131    81    2409   1105       2     481 0.056870071
    ## 132    75    1163    365       0     143 0.067927773
    ## 133    39     560    227      11      81 0.057142857
    ## 134    35     293    191       0      72 0.160409556
    ## 135    39     381    127      12      35 0.055118110
    ## 136    19     146     60      10      13 0.027397260
    ## 137    81    1955    758      28     301 0.036828645
    ## 138    75    1944    767      49     261 0.050411523
    ## 139    76    2529   1047     153     217 0.060893634
    ## 140    79    2565   1105     118     303 0.056530214
    ## 141     9      32      4       0       1 0.062500000
    ## 142    31     467    141      28      26 0.010706638
    ## 143    52    1424    752      66     218 0.082865169
    ## 144    77    1371    339      45      84 0.026258206
    ## 145    82    2567   1321     109     402 0.074016362
    ## 146    41     416    142      17      29 0.079326923
    ## 147    13     159     50       1      19 0.056603774
    ## 148    13     107     35       0      12 0.102803738
    ## 149    62    1725    639       0     253 0.077101449
    ## 150    75    1954    874     116     204 0.060388946
    ## 151    62    1143    603      41     185 0.096237970
    ## 152     4      34     18       1       7 0.029411765
    ## 153    79    2739   1830     240     403 0.110989412
    ## 154    74    1778    780     102     162 0.084364454
    ## 155    76    2295    849     124     173 0.057080610
    ## 156    81    2349    743       1     294 0.064708387
    ## 157    13     174     31       0      14 0.017241379
    ## 158    77    2617   1164     135     258 0.092854413
    ## 159    50     811    312      21      79 0.112207152
    ## 160    27     189     57       9      10 0.052910053
    ## 161    74    2538   1659     151     451 0.119779354
    ## 162    18     225     95      10      18 0.128888889
    ## 163    77    2459    835     108     213 0.034566897
    ## 164    64    2082   1154      13     447 0.106147935
    ## 165    46    1015    232       0      99 0.033497537
    ## 166    82    1639    629      97     136 0.040268456
    ## 167    66    2164   1196     112     331 0.091497227
    ## 168    79    1229    496       2     213 0.052074858
    ## 169    46     968    275      38      59 0.044421488
    ## 170    21     170     40       0      16 0.047058824
    ## 171    32     331     98       1      38 0.057401813
    ## 172    68    1016    425      54     104 0.054133858
    ## 173    52     857    215      23      59 0.032672112
    ## 174    42     408    124      23      19 0.041666667
    ## 175    72    1324    587       4     242 0.068731118
    ## 176    80    2298   1019      77     316 0.067885117
    ## 177    81    1793    483       0     179 0.069715561
    ## 178    62    1012    281      32      64 0.056324111
    ## 179    78    1538    616      95     100 0.085175553
    ## 180    45     314     82      20      11 0.000000000
    ## 181    82    2412   1046      40     390 0.060530680
    ## 182    68    2234   1167     128     280 0.099820949
    ## 183    69    1534    638      53     167 0.094524120
    ## 184    36     738    327      56      47 0.088075881
    ## 185     5      48     14       1       1 0.187500000
    ## 186    65     960    317      43      74 0.041666667
    ## 187    75    2163   1096      23     460 0.049468331
    ## 188     5      43      0       0       0 0.000000000
    ## 189    19     108     23       0      10 0.027777778
    ## 190    24     748    299      46      69 0.030748663
    ## 191     6     157     64       6      19 0.050955414
    ## 192    81    2129   1040     106     275 0.080789103
    ## 193    72    1667    662      61     173 0.079784043
    ## 194    50    1134    590       0     242 0.093474427
    ## 195     3      71     33       2       9 0.126760563
    ## 196    31     786    627      36     164 0.243002545
    ## 197    24     518    203      21      54 0.061776062
    ## 198    80    2188    756     132     119 0.055758684
    ## 199    57    1193    559      27     203 0.060352054
    ## 200    67    2119    864     137     155 0.067484663
    ## 201    68    1518    530      92     118 0.011857708
    ## 202    18     234    148       7      54 0.081196581
    ## 203    81    2133    556      11     225 0.034224098
    ## 204     8      76     39       2      12 0.118421053
    ## 205    69    1190    445      50      95 0.088235294
    ## 206    10     111     30       2      11 0.018018018
    ## 207    12     184     95       4      30 0.125000000
    ## 208    75    2222   1539     134     421 0.132763276
    ## 209    57    1237    468      59     112 0.054163298
    ## 210    73    1643    543      44     160 0.055386488
    ## 211    36     883    523      58     117 0.130237826
    ## 212    52    1138    428      85      69 0.030755712
    ## 213    64    1177    442      55     119 0.033135089
    ## 214    20     293    126      11      35 0.078498294
    ## 215    32     510    209      36      29 0.084313725
    ## 216    69    1284    357      67      51 0.042056075
    ## 217    78    1761    675      15     220 0.107893242
    ## 218    70    1754    919     105     200 0.116305587
    ## 219    59    1334    432      38      96 0.094452774
    ## 220    71    1754    709      25     280 0.042189282
    ## 221    76    1998    574      64     155 0.036036036
    ## 222    10      85     19       0       8 0.035294118
    ## 223    68     854    316       3     132 0.050351288
    ## 224    76    2471    776      81     191 0.061108863
    ## 225    77    1137    527      61     150 0.038698329
    ## 226    52     457    147       2      60 0.045951860
    ## 227    77     739    472       0     208 0.075778078
    ## 228    62    2070   1555     117     434 0.162318841
    ## 229    53     447    135       2      54 0.046979866
    ## 230    78    2649   1742     268     376 0.070215176
    ## 231    20     410    114      18      20 0.048780488
    ## 232    71    1074    282      41      65 0.027001862
    ## 233    76    1345    389       1     172 0.031226766
    ## 234    79    2638   1999     324     351 0.123199393
    ## 235    70    1268    426       0     164 0.077287066
    ## 236    36     285     94      17      19 0.017543860
    ## 237    68    1807    497     118      58 0.014941893
    ## 238    79    1477    576       0     248 0.054163846
    ## 239    67     808    303      69      34 0.034653465
    ## 240    38     322    130       9      41 0.065217391
    ## 241    76    1330    387       0     161 0.048872180
    ## 242    19     122     25       0      10 0.040983607
    ## 243    78    1392    483      30     147 0.071120690
    ## 244    74    2474   1888     147     489 0.189571544
    ## 245    72    1020    246      15      78 0.044117647
    ## 246    72    2335   1243      23     477 0.094218415
    ## 247    69    1291    517      89      82 0.066615027
    ## 248    80    1754    759     147     126 0.037628278
    ## 249    64    1627    792      56     247 0.079901659
    ## 250    63    1587    638      23     242 0.053560176
    ## 251    25     123     62      14       9 0.016260163
    ## 252     5      52     14       0       5 0.076923077
    ## 253    65    1551    818       0     362 0.060606061
    ## 254    75    2323   1217     246     166 0.063280241
    ## 255     4      52      3       0       1 0.019230769
    ## 256    81    2947   2356     262     412 0.253138785
    ## 257    14      44     13       4       0 0.022727273
    ## 258    23     591    343      41      61 0.165820643
    ## 259    58    1064    527       1     224 0.071428571
    ## 260    67    2058    639     110     118 0.035471331
    ## 261    72    2116    979     204     119 0.060964083
    ## 262    77    1419    504      60     143 0.026779422
    ## 263    80    2773    936     191     135 0.033537685
    ## 264     6     139     58       8      14 0.043165468
    ## 265    30     308     86      14      16 0.038961039
    ## 266    74    2054    889     111     212 0.064264849
    ## 267    61    2076   1316      38     441 0.154142582
    ## 268    52     577    292       1     106 0.133448873
    ## 269     3       9      4       0       2 0.000000000
    ## 270    61    1921   1104     124     250 0.120770432
    ## 271    81    2570   1029       0     412 0.079766537
    ## 272     7      24     10       0       3 0.166666667
    ## 273    78    2198   1173     201     195 0.081892630
    ## 274    82    2157   1008     116     243 0.080667594
    ## 275    80    1787    484      43     148 0.033016228
    ## 276    82    1286    711     103     141 0.093312597
    ## 277    25     277     81      15      13 0.036101083
    ## 278    80    1700    538      46     175 0.029411765
    ## 279    68     810    186      29      44 0.013580247
    ## 280    42     653    283      25      74 0.091883614
    ## 281    73    1283    338      20     126 0.020265004
    ## 282    66    1228    412      44     111 0.047231270
    ## 283    50    1186    476       3     200 0.056492411
    ## 284    49    1544    829      94     195 0.101683938
    ## 285    73    2516   1601     149     396 0.143879173
    ## 286    51     432    146       0      55 0.083333333
    ## 287    82    1972    581     123      81 0.025354970
    ## 288    78    1843    715     106     167 0.034183397
    ## 289    12      53     22       1       8 0.056603774
    ## 290    40     346    100      10      31 0.023121387
    ## 291    59    1593    748     114     158 0.056497175
    ## 292    81    2744   1137       0     413 0.113338192
    ## 293    55    1205    430      37     133 0.043983402
    ## 294    71    1158    440      65      94 0.049222798
    ## 295    68    1055    406      94      40 0.041706161
    ## 296    79    2376    522      45     170 0.019781145
    ## 297    81    1632    479      51     141 0.026960784
    ## 298    22     430    145      21      35 0.027906977
    ## 299    72    1533   1033       5     397 0.146118721
    ## 300    78    1490    421      43     103 0.057718121
    ## 301     2      31     14       2       4 0.000000000
    ## 302    32     385     88       7      27 0.033766234
    ## 303    20     128     33       0      14 0.039062500
    ## 304    13     125     43       3      13 0.064000000
    ## 305    81    2802   2558     200     624 0.253390435
    ## 306    64     973    183      12      65 0.017471737
    ## 307    80    2389    905       0     374 0.065717874
    ## 308    23     487    207       1      88 0.057494867
    ## 309    67    2222   1067     127     285 0.052205221
    ## 310    72    1474    425      43      74 0.100407056
    ## 311    28     447    189       0      83 0.051454139
    ## 312    34     675    210      25      50 0.051851852
    ## 313    36     238     58       0      24 0.042016807
    ## 314    64    1501    429      51      95 0.057295137
    ## 315    77    2101    689      55     195 0.063779153
    ## 316    42     558    165       9      49 0.071684588
    ## 317    74    2531   1446     104     428 0.109838009
    ## 318    69    2292   1415     171     293 0.137870855
    ## 319    71    1914    643      15     259 0.041797283
    ## 320    67    1183    551     138      47 0.036348267
    ## 321    73    1799    586     112      81 0.048916064
    ## 322    33     405    106       3      33 0.076543210
    ## 323    11     189     55       3      17 0.063492063
    ## 324    73    1786   1028      21     412 0.078947368
    ## 325    61    1773    532      70     113 0.054145516
    ## 326    79    2254    845     134     169 0.046583851
    ## 327    80    2796   1837     185     507 0.095851216
    ## 328    75    2694   2024     214     447 0.181143281
    ## 329    46     789    200       0      75 0.063371356
    ## 330    65    1658    586      31     204 0.051266586
    ## 331    35     249     78      13      13 0.052208835
    ## 332    20     584    304       0     120 0.109589041
    ## 333    77    2223    773      68     246 0.034637877
    ## 334    74    1222    401      74      72 0.028641571
    ## 335    74    1265    327       7     123 0.047430830
    ## 336    39     316     98      17      20 0.022151899
    ## 337    53     512    218      34      39 0.074218750
    ## 338    16      80     31       5       8 0.000000000
    ## 339    63    2134   1145     126     209 0.163542643
    ## 340    41     639    262      53      42 0.029733959
    ## 341    55    1406    603      56     152 0.093172119
    ## 342    57    1782    851     107     213 0.058361392
    ## 343    82    1764    811     115     180 0.060090703
    ## 344    75    2045    687     106     162 0.022004890
    ## 345    62     842    305      46      55 0.067695962
    ## 346    61    1296    587       0     228 0.101080247
    ## 347    22     165     83       9      24 0.048484848
    ## 348    27     632    245       0      99 0.074367089
    ## 349    20     151     28       8       1 0.013245033
    ## 350    73    2038   1221      45     449 0.092247301
    ## 351     6      11      4       0       2 0.000000000
    ## 352    60    1705    820      87     208 0.083870968
    ## 353    71    2197   1117     110     323 0.064178425
    ## 354    39     584    207       0      89 0.049657534
    ## 355    75    2708   2099      40     730 0.191654357
    ## 356     2      41     11       1       4 0.000000000
    ## 357    17     199     87       0      36 0.075376884
    ## 358    66    1649    435      71     103 0.009702850
    ## 359    17     574    414      36     106 0.163763066
    ## 360    34     479    150      11      46 0.052192067
    ## 361    73    1820    700      77     206 0.031318681
    ## 362    19     442    267      37      68 0.045248869
    ## 363    67    2190   1029     100     305 0.054337900
    ## 364    31     482     85       0      31 0.047717842
    ## 365     9     111     52       6      16 0.018018018
    ## 366    80    2374    563      94      89 0.043386689
    ## 367    65    1525    464      40     123 0.064262295
    ## 368    22     163     48       5      12 0.055214724
    ## 369     1      25      8       0       3 0.080000000
    ## 370    65    1087    437      58      78 0.098436063
    ## 371    54    1424    769      79     217 0.068820225
    ## 372    81    1642    350      56      68 0.028014616
    ## 373    77    1333    516      21     173 0.080270068
    ## 374    79    2803   1518      78     521 0.086336068
    ## 375    35     771    381      53      89 0.057068742
    ## 376     9     115     40       3      13 0.043478261
    ## 377    22     483    188       0      77 0.070393375
    ## 378    54     521    150      29      23 0.032629559
    ## 379    73     905    213       1      87 0.039779006
    ## 380    70    2029    898     137     201 0.041892558
    ## 381    73    2495    986     174     159 0.058517034
    ## 382    36    1046    408      60      82 0.061185468
    ## 383    65    1477    461      90      65 0.041299932
    ## 384    61    1580    515      62     123 0.052531646
    ## 385    61    1176    495      65     115 0.059523810
    ## 386    25     727    378      59      83 0.048143054
    ## 387    68    2063    900      73     267 0.071255453
    ## 388    65    1728    506      82     101 0.033564815
    ## 389    22     355    124       0      56 0.033802817
    ## 390    71    1419    470       0     216 0.026779422
    ## 391    19     375    114      19      23 0.029333333
    ## 392    22     198     79       8      20 0.075757576
    ## 393    30    1013    562      42     159 0.116485686
    ## 394    33     612    289       3     114 0.084967320
    ## 395    69    1732    681      34     203 0.099884527
    ## 396    14     314    163      21      38 0.076433121
    ## 397    75    1421    611       0     255 0.071076707
    ## 398    18     135     63       3      20 0.103703704
    ## 399    82    3048   1933     103     606 0.135170604
    ## 400    47    1030    197      44      26 0.012621359
    ## 401    62     531    105       0      45 0.028248588
    ## 402    82    2653    816      16     316 0.051262721
    ## 403     7      47     12       0       5 0.042553191
    ## 404    82    3030   2061     101     701 0.117491749
    ## 405    78    1333    293      21      97 0.027006752
    ## 406    65    1190    403      56      95 0.037815126
    ## 407    13     222     45       2      17 0.022522523
    ## 408    75    2469    836      60     201 0.102875658
    ## 409    78    1516    772      49     239 0.096965699
    ## 410    60     774    209      26      49 0.042635659
    ## 411    47    1749    889     120     206 0.066895369
    ## 412    79    2279    740      55     221 0.058358929
    ## 413    24     358    129       5      48 0.050279330
    ## 414    63    1811    984     135     216 0.081170624
    ## 415    20     397    120       1      46 0.062972292
    ## 416    38     609    284       0     126 0.052545156
    ## 417    82    2397   1205     117     360 0.055903212
    ## 418    74    2132    975      17     360 0.095684803
    ## 419    63    1442    449      10     180 0.040915395
    ## 420    56    1486    425      51     113 0.030955585
    ## 421    25     160     57       9      10 0.062500000
    ## 422    60    1556    791     170     102 0.049485861
    ## 423    67    1091    383       1     149 0.075160403
    ## 424    48     560    241       0     105 0.055357143
    ## 425    54    1104    401       0     169 0.057065217
    ## 426    22     392    170      21      44 0.048469388
    ## 427    47     708    346       0     138 0.098870056
    ## 428    77    1560    613       3     227 0.096153846
    ## 429    54    1140    595      45     164 0.115789474
    ## 430    32     545    168       3      65 0.053211009
    ## 431    78    2730   1726     147     459 0.134432234
    ## 432    43     574    146      28      29 0.006968641
    ## 433     2      23      3       0       1 0.043478261
    ## 434    66    2176   1390     104     345 0.178308824
    ## 435    64    1362    434      77      80 0.031571219
    ## 436    67     963    419      35     137 0.041536864
    ## 437    82    1743    753      72     212 0.064830752
    ## 438    14     134     14       3       1 0.022388060
    ## 439    66    2048    951      26     377 0.058105469
    ## 440    61    1123    444      21     163 0.048975957
    ## 441    47    1298    397       0     153 0.070107858

``` r
dat[dat$points1 == max(dat$points1), ]
```

    ##           player team position height weight age experience
    ## 256 James Harden  HOU       PG     77    220  27          7
    ##                      college   salary games minutes points points3 points2
    ## 256 Arizona State University 26540100    81    2947   2356     262     412
    ##     points1
    ## 256     746

-   Create a data frame `gsw` with the name, height, weight of Golden State Warriors (GSW)

``` r
gsw <- dat[dat$team == "GSW", c(1,4,5) ]
```

-   Display the data in `gsw` sorted by height in increasing order (hint: see `?sort` and `?order`)

``` r
gsw[order(gsw$height),]
```

    ##                   player height weight
    ## 225            Ian Clark     75    175
    ## 234        Stephen Curry     75    190
    ## 221       Andre Iguodala     78    215
    ## 224       Draymond Green     79    230
    ## 230        Klay Thompson     79    215
    ## 231          Matt Barnes     79    226
    ## 232        Patrick McCaw     79    185
    ## 233     Shaun Livingston     79    192
    ## 223           David West     81    250
    ## 226 James Michael McAdoo     81    230
    ## 228         Kevin Durant     81    240
    ## 229         Kevon Looney     81    220
    ## 235        Zaza Pachulia     83    270
    ## 222         Damian Jones     84    245
    ## 227         JaVale McGee     84    270

-   Display the data in gsw by weight in decreasing order (hint: see `?sort` and `?order`)

``` r
gsw[order(gsw$weight, decreasing = TRUE),]
```

    ##                   player height weight
    ## 227         JaVale McGee     84    270
    ## 235        Zaza Pachulia     83    270
    ## 223           David West     81    250
    ## 222         Damian Jones     84    245
    ## 228         Kevin Durant     81    240
    ## 224       Draymond Green     79    230
    ## 226 James Michael McAdoo     81    230
    ## 231          Matt Barnes     79    226
    ## 229         Kevon Looney     81    220
    ## 221       Andre Iguodala     78    215
    ## 230        Klay Thompson     79    215
    ## 233     Shaun Livingston     79    192
    ## 234        Stephen Curry     75    190
    ## 232        Patrick McCaw     79    185
    ## 225            Ian Clark     75    175

-   Display the player name, team, and salary, of the top 5 highest-paid players (hint: see `?sort` and `?order`)

``` r
dat[order(dat$salary, decreasing = TRUE),][1:5,c("player", "team", "salary")]
```

    ##            player team   salary
    ## 28   LeBron James  CLE 30963450
    ## 1      Al Horford  BOS 26540100
    ## 34  DeMar DeRozan  TOR 26540100
    ## 228  Kevin Durant  GSW 26540100
    ## 256  James Harden  HOU 26540100

-   Display the player name, team, and points3, of the top 10 three-point players (hint: see `?sort` and `?order`)

``` r
dat[order(dat$points3, decreasing = TRUE),][1:10,c("player", "team", "points3")]
```

    ##             player team points3
    ## 234  Stephen Curry  GSW     324
    ## 230  Klay Thompson  GSW     268
    ## 256   James Harden  HOU     262
    ## 254    Eric Gordon  HOU     246
    ## 6    Isaiah Thomas  BOS     245
    ## 153   Kemba Walker  CHO     240
    ## 47    Bradley Beal  WAS     223
    ## 328 Damian Lillard  POR     214
    ## 261  Ryan Anderson  HOU     204
    ## 273    J.J. Redick  LAC     201

Group By
--------

Group-by operations are very common in data analytics. Without dedicated functions, these operations tend to be very hard (labor intensive).

**Quick try**: Using just bracket notation, try to create a data frame with two columns: the team name, and the team payroll (addition of all player salaries).

So what functions can you use in R to perform group by operations? In base R, the main function for group-by operations is `aggregate()`.

Here's an example using `aggregate()` to get the median salary, grouped by team:

``` r
aggregate(dat$salary, by = list(dat$team), FUN = median)
```

    ##    Group.1       x
    ## 1      ATL 3279291
    ## 2      BOS 4743000
    ## 3      BRK 1790902
    ## 4      CHI 2112480
    ## 5      CHO 6000000
    ## 6      CLE 5239437
    ## 7      DAL 2898000
    ## 8      DEN 3500000
    ## 9      DET 4625000
    ## 10     GSW 1551659
    ## 11     HOU 1508400
    ## 12     IND 4000000
    ## 13     LAC 3500000
    ## 14     LAL 5281680
    ## 15     MEM 3332940
    ## 16     MIA 3449000
    ## 17     MIL 4184870
    ## 18     MIN 3650000
    ## 19     NOP 3789125
    ## 20     NYK 2898000
    ## 21     OKC 3140517
    ## 22     ORL 5000000
    ## 23     PHI 2318280
    ## 24     PHO 2941440
    ## 25     POR 4943123
    ## 26     SAC 5200000
    ## 27     SAS 2898000
    ## 28     TOR 5300000
    ## 29     UTA 2433334
    ## 30     WAS 4365326

The same example above can also be obtained with `aggreagte()` using formula notation like this:

``` r
aggregate(salary ~ team, data = dat, FUN = median)
```

    ##    team  salary
    ## 1   ATL 3279291
    ## 2   BOS 4743000
    ## 3   BRK 1790902
    ## 4   CHI 2112480
    ## 5   CHO 6000000
    ## 6   CLE 5239437
    ## 7   DAL 2898000
    ## 8   DEN 3500000
    ## 9   DET 4625000
    ## 10  GSW 1551659
    ## 11  HOU 1508400
    ## 12  IND 4000000
    ## 13  LAC 3500000
    ## 14  LAL 5281680
    ## 15  MEM 3332940
    ## 16  MIA 3449000
    ## 17  MIL 4184870
    ## 18  MIN 3650000
    ## 19  NOP 3789125
    ## 20  NYK 2898000
    ## 21  OKC 3140517
    ## 22  ORL 5000000
    ## 23  PHI 2318280
    ## 24  PHO 2941440
    ## 25  POR 4943123
    ## 26  SAC 5200000
    ## 27  SAS 2898000
    ## 28  TOR 5300000
    ## 29  UTA 2433334
    ## 30  WAS 4365326

Here's another example using `aggregate()` to get the average height and average weight, grouped by position:

``` r
aggregate(dat[ ,c('height', 'weight')], by = list(dat$position), FUN = mean)
```

    ##   Group.1   height   weight
    ## 1       C 83.25843 250.7978
    ## 2      PF 81.50562 235.8539
    ## 3      PG 74.30588 188.5765
    ## 4      SF 79.63855 220.4699
    ## 5      SG 77.02105 204.7684

The same example above can also be obtained with `aggreagte()` using formula notation like this:

``` r
aggregate(. ~ position, data = dat[ ,c('position', 'height', 'weight')],
          FUN = mean)
```

    ##   position   height   weight
    ## 1        C 83.25843 250.7978
    ## 2       PF 81.50562 235.8539
    ## 3       PG 74.30588 188.5765
    ## 4       SF 79.63855 220.4699
    ## 5       SG 77.02105 204.7684

### Your turn

-   Create a data frame with the average height, average weight, and average age, grouped by position

``` r
aggregate(dat[ ,c('height', 'weight','age')], by = list(dat$position), FUN = mean)
```

    ##   Group.1   height   weight      age
    ## 1       C 83.25843 250.7978 25.93258
    ## 2      PF 81.50562 235.8539 25.93258
    ## 3      PG 74.30588 188.5765 26.38824
    ## 4      SF 79.63855 220.4699 27.07229
    ## 5      SG 77.02105 204.7684 26.20000

-   Create a data frame with the average height, average weight, and average age, grouped by team

``` r
aggregate(dat[ ,c('height', 'weight','age')], by = list(dat$team), FUN = mean)
```

    ##    Group.1   height   weight      age
    ## 1      ATL 79.14286 219.9286 28.42857
    ## 2      BOS 78.20000 219.8667 25.26667
    ## 3      BRK 78.66667 222.4000 25.46667
    ## 4      CHI 78.53333 215.6000 25.80000
    ## 5      CHO 78.80000 212.8000 25.86667
    ## 6      CLE 78.86667 226.4000 29.60000
    ## 7      DAL 79.13333 215.6667 26.93333
    ## 8      DEN 79.40000 220.2667 25.80000
    ## 9      DET 79.53333 228.0000 25.46667
    ## 10     GSW 79.86667 223.5333 27.73333
    ## 11     HOU 78.28571 214.8571 25.64286
    ## 12     IND 78.50000 226.0714 27.00000
    ## 13     LAC 78.80000 225.0667 29.53333
    ## 14     LAL 80.00000 224.3333 25.53333
    ## 15     MEM 79.26667 221.7333 27.40000
    ## 16     MIA 79.00000 219.2857 26.71429
    ## 17     MIL 80.35714 224.1429 25.71429
    ## 18     MIN 79.71429 221.5714 25.07143
    ## 19     NOP 79.50000 218.9286 25.78571
    ## 20     NYK 80.00000 218.3333 26.60000
    ## 21     OKC 79.26667 219.2000 25.73333
    ## 22     ORL 78.93333 216.2000 25.20000
    ## 23     PHI 79.33333 225.0000 24.73333
    ## 24     PHO 78.53333 213.8000 25.40000
    ## 25     POR 79.42857 217.9286 24.21429
    ## 26     SAC 78.46667 216.6000 25.86667
    ## 27     SAS 79.13333 217.3333 28.86667
    ## 28     TOR 79.06667 222.6000 25.20000
    ## 29     UTA 79.46667 222.1333 26.20000
    ## 30     WAS 79.50000 215.1429 25.85714

-   Create a data frame with the average height, average weight, and average age, grouped by team and position.

``` r
aggregate(dat[ ,c('height', 'weight','age')], by = list(dat$team, dat$position), FUN = mean)
```

    ##     Group.1 Group.2   height   weight      age
    ## 1       ATL       C 83.00000 252.5000 28.00000
    ## 2       BOS       C 83.33333 245.3333 27.33333
    ## 3       BRK       C 84.00000 267.5000 27.00000
    ## 4       CHI       C 83.00000 250.0000 25.66667
    ## 5       CHO       C 83.50000 245.5000 25.50000
    ## 6       CLE       C 83.66667 251.0000 27.33333
    ## 7       DAL       C 83.75000 243.2500 25.25000
    ## 8       DEN       C 83.66667 255.0000 25.66667
    ## 9       DET       C 84.00000 276.3333 27.00000
    ## 10      GSW       C 82.60000 251.0000 27.60000
    ## 11      HOU       C 81.33333 241.6667 21.66667
    ## 12      IND       C 82.50000 266.0000 26.00000
    ## 13      LAC       C 82.66667 258.3333 25.33333
    ## 14      LAL       C 83.66667 263.3333 24.66667
    ## 15      MEM       C 84.00000 246.0000 26.00000
    ## 16      MIA       C 82.00000 240.0000 29.66667
    ## 17      MIL       C 83.66667 236.6667 23.66667
    ## 18      MIN       C 83.00000 243.0000 26.00000
    ## 19      NOP       C 83.75000 256.5000 26.75000
    ## 20      NYK       C 83.00000 242.5000 25.75000
    ## 21      OKC       C 83.50000 250.0000 23.50000
    ## 22      ORL       C 83.00000 251.6667 23.33333
    ## 23      PHI       C 82.60000 254.0000 24.40000
    ## 24      PHO       C 83.33333 253.3333 27.00000
    ## 25      POR       C 84.00000 280.0000 22.00000
    ## 26      SAC       C 84.33333 248.3333 23.00000
    ## 27      SAS       C 83.00000 246.6667 32.33333
    ## 28      TOR       C 84.00000 251.3333 23.00000
    ## 29      UTA       C 84.50000 238.0000 25.00000
    ## 30      WAS       C 83.25000 245.0000 28.75000
    ## 31      ATL      PF 81.50000 236.5000 29.00000
    ## 32      BOS      PF 81.00000 235.3333 26.66667
    ## 33      BRK      PF 80.00000 239.3333 27.33333
    ## 34      CHI      PF 82.50000 225.0000 23.00000
    ## 35      CHO      PF 82.25000 238.5000 24.50000
    ## 36      CLE      PF 81.00000 245.5000 26.50000
    ## 37      DAL      PF 81.25000 224.0000 27.00000
    ## 38      DEN      PF 80.66667 231.0000 25.33333
    ## 39      DET      PF 82.00000 236.0000 23.66667
    ## 40      GSW      PF 80.00000 230.0000 25.00000
    ## 41      HOU      PF 82.00000 240.0000 26.00000
    ## 42      IND      PF 80.60000 249.2000 26.00000
    ## 43      LAC      PF 81.33333 243.6667 26.66667
    ## 44      LAL      PF 81.33333 239.0000 23.66667
    ## 45      MEM      PF 81.50000 234.0000 28.00000
    ## 46      MIA      PF 81.00000 231.3333 27.33333
    ## 47      MIL      PF 81.75000 243.0000 27.00000
    ## 48      MIN      PF 82.33333 239.3333 26.66667
    ## 49      NOP      PF 82.50000 221.0000 23.00000
    ## 50      NYK      PF 82.66667 225.0000 24.33333
    ## 51      OKC      PF 81.25000 237.5000 28.00000
    ## 52      ORL      PF 81.00000 235.0000 30.00000
    ## 53      PHI      PF 80.50000 230.5000 22.50000
    ## 54      PHO      PF 82.00000 227.6667 23.00000
    ## 55      POR      PF 83.00000 241.6667 24.00000
    ## 56      SAC      PF 81.50000 232.5000 25.50000
    ## 57      SAS      PF 82.00000 238.3333 29.33333
    ## 58      TOR      PF 81.33333 231.6667 25.33333
    ## 59      UTA      PF 81.25000 246.0000 25.75000
    ## 60      WAS      PF 82.50000 222.5000 24.00000
    ## 61      ATL      PG 74.33333 187.3333 28.33333
    ## 62      BOS      PG 72.00000 192.0000 23.66667
    ## 63      BRK      PG 76.33333 204.3333 24.00000
    ## 64      CHI      PG 75.50000 189.0000 25.25000
    ## 65      CHO      PG 73.75000 175.0000 27.75000
    ## 66      CLE      PG 73.00000 189.6667 25.66667
    ## 67      DAL      PG 73.25000 185.5000 28.50000
    ## 68      DEN      PG 74.50000 195.0000 27.00000
    ## 69      DET      PG 74.00000 196.0000 29.33333
    ## 70      GSW      PG 77.00000 191.0000 29.50000
    ## 71      HOU      PG 75.33333 188.3333 27.00000
    ## 72      IND      PG 73.33333 175.6667 28.00000
    ## 73      LAC      PG 72.50000 190.0000 31.50000
    ## 74      LAL      PG 76.00000 194.5000 21.00000
    ## 75      MEM      PG 75.66667 196.6667 23.66667
    ## 76      MIA      PG 75.50000 188.0000 27.00000
    ## 77      MIL      PG 76.00000 198.0000 26.00000
    ## 78      MIN      PG 75.33333 199.6667 22.66667
    ## 79      NOP      PG 74.33333 186.3333 25.00000
    ## 80      NYK      PG 74.50000 187.5000 25.50000
    ## 81      OKC      PG 74.66667 188.3333 26.66667
    ## 82      ORL      PG 74.00000 181.0000 27.66667
    ## 83      PHI      PG 74.66667 192.0000 27.33333
    ## 84      PHO      PG 72.33333 176.6667 27.00000
    ## 85      POR      PG 74.00000 185.0000 25.50000
    ## 86      SAC      PG 72.33333 190.0000 27.66667
    ## 87      SAS      PG 74.33333 180.0000 27.33333
    ## 88      TOR      PG 73.66667 194.3333 25.33333
    ## 89      UTA      PG 75.25000 190.0000 25.25000
    ## 90      WAS      PG 74.00000 185.3333 25.66667
    ## 91      ATL      SF 78.75000 215.2500 29.25000
    ## 92      BOS      SF 78.66667 221.6667 25.66667
    ## 93      BRK      SF 78.66667 209.3333 22.33333
    ## 94      CHI      SF 79.50000 217.5000 24.50000
    ## 95      CHO      SF 79.00000 232.0000 23.00000
    ## 96      CLE      SF 79.25000 231.5000 35.00000
    ## 97      DAL      SF 79.00000 195.0000 23.00000
    ## 98      DEN      SF 80.66667 222.6667 31.00000
    ## 99      DET      SF 79.66667 228.3333 24.00000
    ## 100     GSW      SF 79.33333 227.0000 32.33333
    ## 101     HOU      SF 80.00000 221.0000 25.00000
    ## 102     IND      SF 79.50000 222.5000 27.50000
    ## 103     LAC      SF 79.00000 225.0000 33.00000
    ## 104     LAL      SF 80.25000 214.0000 29.25000
    ## 105     MEM      SF 79.66667 220.0000 31.33333
    ## 106     MIA      SF 80.00000 225.0000 23.50000
    ## 107     MIL      SF 81.50000 228.0000 23.50000
    ## 108     MIN      SF 79.66667 215.6667 24.33333
    ## 109     NOP      SF 79.33333 217.3333 26.00000
    ## 110     NYK      SF 80.50000 227.5000 29.50000
    ## 111     OKC      SF 79.75000 218.2500 25.00000
    ## 112     ORL      SF 80.50000 217.2500 24.25000
    ## 113     PHI      SF 79.00000 216.0000 23.33333
    ## 114     PHO      SF 79.50000 210.0000 21.00000
    ## 115     POR      SF 80.50000 216.2500 24.75000
    ## 116     SAC      SF 79.00000 225.0000 28.50000
    ## 117     SAS      SF 79.00000 230.0000 25.00000
    ## 118     TOR      SF 79.66667 226.0000 27.33333
    ## 119     UTA      SF 79.66667 230.6667 30.00000
    ## 120     WAS      SF 80.00000 207.0000 25.00000
    ## 121     ATL      SG 78.00000 205.0000 24.00000
    ## 122     BOS      SG 76.00000 205.0000 23.00000
    ## 123     BRK      SG 76.75000 210.5000 26.75000
    ## 124     CHI      SG 75.75000 210.7500 28.50000
    ## 125     CHO      SG 78.00000 203.7500 26.25000
    ## 126     CLE      SG 78.00000 219.0000 30.66667
    ## 127     DAL      SG 77.50000 214.5000 29.00000
    ## 128     DEN      SG 76.75000 197.0000 21.75000
    ## 129     DET      SG 78.00000 203.3333 23.33333
    ## 130     GSW      SG 77.66667 191.6667 24.00000
    ## 131     HOU      SG 74.00000 191.6667 28.66667
    ## 132     IND      SG 76.00000 207.5000 28.50000
    ## 133     LAC      SG 76.33333 196.6667 30.66667
    ## 134     LAL      SG 77.33333 204.3333 26.33333
    ## 135     MEM      SG 76.33333 216.0000 27.33333
    ## 136     MIA      SG 76.50000 207.5000 25.50000
    ## 137     MIL      SG 77.00000 200.5000 27.00000
    ## 138     MIN      SG 77.50000 204.5000 26.00000
    ## 139     NOP      SG 76.00000 193.0000 27.50000
    ## 140     NYK      SG 77.50000 200.0000 28.25000
    ## 141     OKC      SG 77.00000 200.0000 23.50000
    ## 142     ORL      SG 77.50000 210.2500 24.50000
    ## 143     PHI      SG 77.50000 210.0000 26.00000
    ## 144     PHO      SG 76.50000 203.5000 27.00000
    ## 145     POR      SG 77.25000 202.7500 23.75000
    ## 146     SAC      SG 77.20000 203.8000 25.60000
    ## 147     SAS      SG 78.00000 207.0000 28.20000
    ## 148     TOR      SG 76.66667 209.6667 25.00000
    ## 149     UTA      SG 79.00000 210.0000 24.50000
    ## 150     WAS      SG 77.66667 205.6667 24.00000

-   Difficult: Create a data frame with the minimum salary, median salary, mean salary, and maximum salary, grouped by team and position.

``` r
aggregate(dat$salary, by = cbind((dat[,c('team', 'position')])), FUN = function(x){ 
    return(
      paste(c(mn=mean(x) , md=median(x), mini=min(x)), collapse = ' ')
    )
  }
)
```

    ##     team position                                 x
    ## 1    ATL        C     12097985.5 12097985.5 1015696
    ## 2    BOS        C    12544704.6666667 8e+06 3094014
    ## 3    BRK        C       12082837.5 12082837.5 3e+06
    ## 4    CHI        C   5267868.66666667 1709720 874636
    ## 5    CHO        C           7615000 7615000 2730000
    ## 6    CLE        C     7714183.66666667 7806971 5145
    ## 7    DAL        C          3571031.5 2629563 650000
    ## 8    DEN        C  2895676.66666667 2328530 1358500
    ## 9    DET        C            11872250 7e+06 6500000
    ## 10   GSW        C           1641534 1403611 1171560
    ## 11   HOU        C     946570.333333333 1e+06 543471
    ## 12   IND        C       6347009.5 6347009.5 2463840
    ## 13   LAC        C   7704252.33333333 1403611 543471
    ## 14   LAL        C  7741985.33333333 6191000 1034956
    ## 15   MEM        C         11267452 11267452 1369229
    ## 16   MIA        C    9044148.66666667 4e+06 1015696
    ## 17   MIL        C 10728735.3333333 12517606 2568600
    ## 18   MIN        C  5838506.33333333 5960160 3911380
    ## 19   NOP        C         13394786 13431197 4600000
    ## 20   NYK        C         5704617.75 2637500 543471
    ## 21   OKC        C     10143177.5 10143177.5 3140517
    ## 22   ORL        C           9900000 11750000 950000
    ## 23   PHI        C           3856068.8 4788840 89513
    ## 24   PHO        C   6037752.33333333 4823621 874636
    ## 25   POR        C           1921320 1921320 1921320
    ## 26   SAC        C  4599966.66666667 3551160 2202240
    ## 27   SAS        C            6187984 2898000 165952
    ## 28   TOR        C  6335767.33333333 2703960 1921320
    ## 29   UTA        C           1568492 1568492 1015696
    ## 30   WAS        C         8371906.25 8500000 543471
    ## 31   ATL       PF         8222565.25 6200000 418228
    ## 32   BOS       PF             6074551 5e+06 1223653
    ## 33   BRK       PF           5709965 6088993 1790902
    ## 34   CHI       PF           3618065 3618065 1453680
    ## 35   CHO       PF          4651108 3096474.5 161483
    ## 36   CLE       PF          10716852 10716852 268029
    ## 37   DAL       PF      11931039.75 11330110.5 63938
    ## 38   DEN       PF  7378755.66666667 8070175 1987440
    ## 39   DET       PF          9965359 10991957 1704120
    ## 40   GSW       PF            8155433 8155433 980431
    ## 41   HOU       PF        9639417.5 9639417.5 543471
    ## 42   IND       PF          4331198.8 1800000 650000
    ## 43   LAC       PF  7655472.33333333 1551659 1273920
    ## 44   LAL       PF  1841920.33333333 1207680 1050961
    ## 45   MEM       PF            4582009 3493080 980431
    ## 46   MIA       PF     3331148.33333333 4e+06 210995
    ## 47   MIL       PF       5906672.5 5861539.5 1403611
    ## 48   MIN       PF  2723674.33333333 2348783 2022240
    ## 49   NOP       PF          560097.5 560097.5 543471
    ## 50   NYK       PF   3684063.66666667 4317720 543471
    ## 51   OKC       PF           4082920 3095100 1191480
    ## 52   ORL       PF           1.5e+07 1.5e+07 1.5e+07
    ## 53   PHI       PF         1175124.5 1175124.5 31969
    ## 54   PHO       PF           5895920 4276320 2941440
    ## 55   POR       PF  6210503.66666667 6666667 2751360
    ## 56   SAC       PF           4594420 4594420 1188840
    ## 57   SAS       PF   7556711.66666667 1551659 543471
    ## 58   TOR       PF           6498680 6050000 1196040
    ## 59   UTA       PF             5247650 4670300 6e+05
    ## 60   WAS       PF           4295740 4295740 1191480
    ## 61   ATL       PG            1867020 2500000 392478
    ## 62   BOS       PG           3314524 1906440 1450000
    ## 63   BRK       PG   4428023.66666667 1074145 726672
    ## 64   CHI       PG         5234761.5 2648003 1643040
    ## 65   CHO       PG       4788464.75 3525480.5 102898
    ## 66   CLE       PG    6147053.33333333 543471 259626
    ## 67   DAL       PG            2857687 3497475 207798
    ## 68   DEN       PG       3891162.5 3891162.5 3241800
    ## 69   DET       PG             7502727 6e+06 1551659
    ## 70   GSW       PG       8947404.5 8947404.5 5782450
    ## 71   HOU       PG    9158544.66666667 680534 255000
    ## 72   IND       PG           4184114 2700000 1052342
    ## 73   LAC       PG     12210243.5 12210243.5 1551659
    ## 74   LAL       PG           3533340 3533340 1733880
    ## 75   MEM       PG            9759620 1793760 945000
    ## 76   MIA       PG         10759000 10759000 5628000
    ## 77   MIL       PG           9607500 9607500 9607500
    ## 78   MIN       PG  6254066.66666667 3872520 1339680
    ## 79   NOP       PG             4480152 2090000 63938
    ## 80   NYK       PG          10733555 10733555 143860
    ## 81   OKC       PG    9110520.66666667 543471 247991
    ## 82   ORL       PG    4954533.33333333 5e+06 2613600
    ## 83   PHI       PG     6099573.33333333 8e+06 874636
    ## 84   PHO       PG             5066988 918369 282595
    ## 85   POR       PG     12839272.5 12839272.5 1350120
    ## 86   SAC       PG  3914967.33333333 5200000 1315448
    ## 87   SAS       PG           6401447 3578948 1180080
    ## 88   TOR       PG            4706917 1577280 543471
    ## 89   UTA       PG          3827863.5 3186827 937800
    ## 90   WAS       PG  7181499.33333333 3386598 1200000
    ## 91   ATL       SF         6479399.5 4343750 1499760
    ## 92   BOS       SF  4146668.66666667 4743000 1410598
    ## 93   BRK       SF           2097071 1562280 1395600
    ## 94   CHI       SF        9151104.5 9151104.5 750000
    ## 95   CHO       SF           1.3e+07 1.3e+07 1.3e+07
    ## 96   CLE       SF           8758341 2025829.5 18255
    ## 97   DAL       SF              543471 543471 543471
    ## 98   DEN       SF 9916666.66666667 11200000 3500000
    ## 99   DET       SF           3283508 2969880 2255644
    ## 100  GSW       SF  12684939.6666667 11131368 383351
    ## 101  HOU       SF   3225843.66666667 1720560 150000
    ## 102  IND       SF         11448991 11448991 4583450
    ## 103  LAC       SF           3161612 2851500 1315448
    ## 104  LAL       SF        8108334.75 6440840 1551659
    ## 105  MEM       SF  9759602.33333333 4264057 2898000
    ## 106  MIA       SF           1910220 1910220 1227000
    ## 107  MIL       SF       9097710.5 9097710.5 2995421
    ## 108  MIN       SF            3063771 3046299 138414
    ## 109  NOP       SF    4746682.66666667 2978250 20580
    ## 110  NYK       SF         13728690 13728690 2898000
    ## 111  OKC       SF         2621010.75 2333056 980431
    ## 112  ORL       SF         4810397.75 4130580 980431
    ## 113  PHI       SF  1285605.33333333 1326960 1015696
    ## 114  PHO       SF        1336195.5 1336195.5 543471
    ## 115  POR       SF           8415793 8334864.5 6e+05
    ## 116  SAC       SF    11997309.5 11997309.5 10661286
    ## 117  SAS       SF        17638063 17638063 17638063
    ## 118  TOR       SF           7029880 5300000 1589640
    ## 119  UTA       SF           9774380 1.1e+07 2250000
    ## 120  WAS       SF           4812317 4812317 3730653
    ## 121  ATL       SG           2281605 2281605 2281605
    ## 122  BOS       SG  4557914.33333333 3578880 1825200
    ## 123  BRK       SG             1145089 980431 119494
    ## 124  CHI       SG           7448974 2790100 1015696
    ## 125  CHO       SG        8564499.5 6422480.5 543471
    ## 126  CLE       SG           9246479 9700000 5239437
    ## 127  DAL       SG           9057848 9057848 1015696
    ## 128  DEN       SG        2506843.25 2433360 1627320
    ## 129  DET       SG    1734126.33333333 874060 650000
    ## 130  GSW       SG   6074247.33333333 1015696 543471
    ## 131  HOU       SG               8461788 7e+06 6e+06
    ## 132  IND       SG             7385000 7385000 4e+06
    ## 133  LAC       SG          10543504 1.1e+07 7377500
    ## 134  LAL       SG    6005815.33333333 5443918 73528
    ## 135  MEM       SG    2973892.33333333 3332940 83119
    ## 136  MIA       SG         2579026.75 1886318 543471
    ## 137  MIL       SG        1664006.5 1681349.5 925000
    ## 138  MIN       SG           2870440 2870440 2240880
    ## 139  NOP       SG        4127228.5 4127228.5 173094
    ## 140  NYK       SG         3552941.25 1213147 543471
    ## 141  OKC       SG           6273862 6273862 5994764
    ## 142  ORL       SG         5900984.5 3285984.5 31969
    ## 143  PHI       SG           5996520 5996520 2993040
    ## 144  PHO       SG          4713229.75 3111800 23069
    ## 145  POR       SG        5784421.5 2047107.5 543471
    ## 146  SAC       SG         5893192.4 4008882 1439880
    ## 147  SAS       SG          5322037.4 1192080 543471
    ## 148  TOR       SG   11581578.6666667 7330000 874636
    ## 149  UTA       SG       5780507.5 5780507.5 1406520
    ## 150  WAS       SG   8510344.66666667 2870813 543471

------------------------------------------------------------------------
