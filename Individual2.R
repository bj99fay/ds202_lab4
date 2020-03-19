library(tidyverse)
library(readxl)
setwd("/Users/chase/Desktop/RProjects/ds202/ds202_lab4")


defense <- read_excel('cyclonesFootball2019.xlsx', sheet='Defensive')
head(defense)
defense <- data.frame(defense)
defense$Name <- as.factor(defense$Name)
defense$Opponent_Opponent <- as.factor(defense$Opponent_Opponent)
head(defense)
defense <- defense %>% mutate_at(.vars=c(3:11), .funs= list(as.numeric))

biography <- read_excel('cyclonesFootball2019.xlsx', sheet='Biography')
biography <- data.frame(biography)

biography <- biography %>% separate(Height, sep = "-", into = c('Ft', 'inch'), remove = TRUE)  
biography$Ft <- as.numeric(biography$Ft)
biography$inch <- as.numeric(biography$inch)

biography$Height <- biography %>% transmute(inches = (Ft * 12) + inch)
biography <- biography %>% select(-c(3,4))
biography <- biography %>% mutate_at(.vars = c(1,2,4,5,6), .funs = funs(as.factor)) %>% mutate_at(.vars = c(3), .funs = funs(as.numeric))
head(biography)




