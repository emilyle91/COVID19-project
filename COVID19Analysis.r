rm(list = ls())

#import the Hmisc package
library(Hmisc)

#import COVID csv file
data <- read.csv("COVID19_line_list_data.csv")

#list the column headers
colnames(data) 

#Hmisc code to take a brief look in each data categories
describe(data)

#list the distinct information in the "dead" data category since there are 14 distinct and is suspect as error
unique(data$death)

#clean the death data, convert the dead logical vector to dead_dummy integer vector (1=death, 0=no death)
data$death_dummy <- as.integer(data$death != 0)

#list the distinct information in the "recovered" data category since there are 32 distinct and is suspect as error
unique(data$recovered)

#clean the recovered data
data$recovered_dummy <- as.integer(data$recovered != 0)

#calculate the death rate
death_rate <- sum(data$death_dummy)/nrow(data)
print(death_rate)

#calculate the recovered rate 
recovered_rate <- sum(data$recovered_dummy)/nrow(data)
print(recovered_rate)

#Hypothesis 1: People died from COVID older than people who survived
#Test the hypothesis 

#Create two variable: people died from COVID, people alive after suffer COVID
dead = subset (data, data$death_dummy == 1)
alive = subset (data, data$death_dummy == 0)

#Conduct the mean of each subset's age, remove the NA variable in the age data and compare the average age of each dead and alive variable.
mean(dead$age, na.rm = TRUE)
mean(alive$age, na.rm = TRUE)

#Conduct the statistical differences
t.test(dead$age, alive$age, alternative = "two.sided", conf.level = 0.95)

