###NBA Player Statistics###
Source: www.basketball-reference.com
Example stats from specific team: https://www.basketball-reference.com/teams/GSW/2017.html

Description: This data set provides the statistics for all active NBA players across various statistical catergories.

This data set has 441 rows and 24 variables.

Below is the description of column labels and abbreviations according to the glossary of basketball-reference:

* Player: first and last names of player
* Team: 3-letter team abbreviation
* Position: player’s position
* Experience: years of experience in NBA (a value of R means rookie) 
* Salary: player salary in dollars
* Rank: Rank of player in his team
* Age: Age of Player at the start of February 1st of that season. 
* GP: Games Played furing regular season
* GS: Games Started
* MIN: Minutes Played during regular season
* FGM: Field Goals Made
* FGA: Field Goal Attempts
* Points3: 3-Point Field Goals
* Points3_atts: 3-Point Field Goal Attempts
* Points2: 2-Point Field Goals
* Points2_atts: 2-Point Field Goal Attempts
* FTM: Free Throws Made
* FTA: Free Throw Attempts
* OREB: Offensive Rebounds
* DREB: Defensive Rebounds
* AST: Assists
* STL: Steals
* BLK: Blocks
* TO: Turnovers

There are five types of player positions (see [wikipedia](https://en.wikipedia.org/wiki/Basketball_positions) for more details):

+ `PG`: point guard
+ `SG`: shooting guard
+ `SF`: small forward
+ `PF`: power forward
+ `C`: center

The values in `points` result from adding all scored points:

```{r}
points1 + (2 * points2) + (3 * points3)
```