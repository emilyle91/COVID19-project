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

#P-value = 0 < 0.05 --> the mean is significant differences
#At 95% CI, the dead age's mean is 16.7 to 24.3 years more than the the alive age's mean
#Conclusion: reject null hypothesis, finding that the people die from COVID is older.

#Hypothesis 2: Female have lower death rate than male
#Create two required data subset: Women and men
women =  subset(data, data$gender == "female")
men = subset(data, data$gender == "male")

#Compare the death rate between two gender (another mean code)
sum(women$death_dummy)/nrow(women) #death rate of women = 3.6%
sum(men$death_dummy)/nrow(men) #death rate of men = 8.46%

#Conduct statistical importance
t.test(women$death_dummy, men$death_dummy, alternative = "two.sided", conf.level = 0.95)

#P-value = 0.002 < 0.05 --> the mean is significant difference
#At 95% CI, women death rate is lower from 1.7% to 7.8% than men death rate
#Conclusion: reject the null hypothesis (female have the same death rate with male), finding that female have lower death rate than male
