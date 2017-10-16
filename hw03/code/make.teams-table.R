#====================================================
# Title: Make 2017 Teams Table
# Description: Creating a comprehensive CSV file for NBA teams
# Input: data files nba2017-roster.csv and nba2017-stats.csv
# Output: data file nba2017-teams.csv, star plot - teams_star_plot.pdf, scatter plot - experience_salary.pdf  
# Author: Xu-Bin Kuang
#====================================================

#Loading the packages
library(dplyr)
library(ggplot2)
library(readr)


#Setting working directory
setwd("/Users/KuangXu-Bin/Desktop/Berkeley/Fall_2017/stat133/stat133-hws-fall17/hw03/data")
  
#Loading data
data_teams <- read.csv("nba2017-roster.csv")
data_stats <- read.csv("nba2017-stats.csv")

#Adding new variables to stats
data_stats <- data_stats %>% mutate(missed_fg = field_goals_atts - field_goals_made) %>%
              mutate(missed_ft = points1_atts - points1_made) %>%
              mutate(points = points3_made*3 + points2_made*2 + points1_made) %>%            
              mutate( rebounds = off_rebounds + def_rebounds) %>%
              mutate( efficiency = (points + rebounds + assists + steals + blocks
                                               - missed_fg - missed_ft - turnovers) / games_played)


#Sinking to new summary file
sink(file = '../output/efficiency-summary.txt')
summary(data_stats$efficiency)
sink()

#Merging the two tables
teams_stats <- merge(data_stats, data_teams)

#Data Aggregation

teams <- teams_stats %>% 
  select(team, experience, points3_made, points2_made, points1_made, points, off_rebounds,
  salary, def_rebounds, assists, steals, blocks, turnovers, fouls, efficiency) %>% 
  group_by(team) %>%  summarise(experience = sum(experience), salary = sum(salary/1000000), points3 = sum(points3_made),
  points2 = sum(points2_made), free_throws = sum(points1_made), points = sum(points),
  off_rebounds = sum(off_rebounds), def_rebounds = sum(def_rebounds), assists = sum(assists),
  steals = sum(steals), blocks = sum(blocks), turnovers = sum(turnovers), fouls = sum(fouls), efficiency = sum(efficiency))

#Outputs
sink(file = '../output/text-summary.txt' )
summary(teams)
sink()

write.csv(teams, file = '../data/nba2017-teams.csv')

#Plots
pdf('../images/teams_star_plot.pdf')
startplot <- stars(teams[ ,-1], labels = as.character(teams$team))
dev.off()

pdf('../images/experience_salary.pdf')
ggplot(teams, aes(experience,salary)) + geom_text(aes(label= team)) + geom_point()
dev.off()



