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

colnames(biography)
colnames(defense)
biography$Hometown
biography <- biography %>% separate(Hometown, se = ", ", into = c("Home City", "Home State"))
biography

biography %>% add_count(`Home State`, name = "Players in State") %>% select(`Home State`, `Players in State`) %>% distinct()


#offense
offense <- read_excel('cyclonesFootball2019.xlsx', sheet='Offensive')
offense$Name <- as.factor(offense$Name)
offense$Opponent_Opponent <- as.factor(offense$Opponent_Opponent)
offense <-separate(offense, "Passing_CMP-ATT", into=c("Passing_CMP", "Passing_ATT"), sep="-\r\n ")
offense <- mutate_at(offense, .vars=c(3:13), .funs=list(as.numeric))

offClean <- offense
str(offClean)
offClean

offJoin <- biography %>% inner_join(offClean, by = 'Name')

library(ggplot2)
ggplot(data = offJoin, mapping = aes(Weight, Receiving_YDS)) + geom_point() +geom_smooth(method = 'lm')



