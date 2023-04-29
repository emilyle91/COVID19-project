#import COVID csv file
data <- read.csv("C:/Users/emily/OneDrive/Tài liệu/Project/Project 1/COVID19_line_list_data.csv")
#import the Hmisc package
library(Hmisc)
describe(data)