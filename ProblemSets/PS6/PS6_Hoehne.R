#set our working directory so we can locate our csv file 
setwd("/Users/jordan/desktop/")

#read our csv file 
wages<-read.csv("wage2.csv")

#load in packages
library(psych)
library(ggplot2)
library(dbplot)
library(highcharter)

#read our csv
wages<-read.csv("wage2.csv")

#exploratory analysis 
summary(wages)
describe(wages)

#check classes for each type of data
class(wages$wage)
class(wages$hours)
class(wages$IQ)
class(wages$KWW)
class(wages$educ)
class(wages$exper)
class(wages$tenure)
class(wages$age)
class(wages$married)
class(wages$black)
class(wages$south)
class(wages$urban)
class(wages$sibs)
class(wages$brthord)
class(wages$meduc)
class(wages$feduc)
class(wages$lwage)

#Check for missing values in the entire dataframe
any(is.na(wages))

#Check for the total number of missing values in the entire dataframe
sum(is.na(wages))

#Check for missing values in a particular column in the dataframe
any(is.na(wages$meduc))
any(is.na(wages$feduc))
any(is.null(wages$birthord))

#Check for the total number of missing values in a particular column in the dataframe
sum(is.na(wages$meduc))
sum(is.na(wages$feduc))
sum(is.null(wages$birthord))

#Eliminate missing values completely from the entire dataframe
wages2<-na.omit(wages)

#plotting the relationship between male and female education 
ggplot(data=wages2,aes(x=feduc, y=meduc)) + geom_point() + theme_minimal()

#let's visualize a simple linear regression on the data 
#perhaps there is a relationship between education and marriage 
ggplot(data=wages2,aes(x=feduc, y=meduc, color=married)) + geom_point() + 
  geom_smooth(se=FALSE, method="lm")+
  theme_minimal()

#Although when we plot the data, it looks as though there are indivudals with different levels 
#of education implying no direct relationship between education and marriage

#geom density plot of the data 
ggplot(data=wages2,aes(x=wage, y=IQ)) + geom_density2d() + 
  theme_minimal()

#using a general histogram, we can visualize the general distribution of feduc in the data set
ggplot(data=wages2,aes(x=feduc)) + geom_histogram(bins=7) + theme_minimal()


#set new data.frame
newwages <- wages2[order(wages2$wage),] 
class(newwages)
head(newwages)

#using highcharter
highchart() %>% 
  hc_chart(type = "scatter") %>% 
  hc_title(text = "Earnings For Each Individual, Least to Greatest") %>% 
  hc_add_series(data = newwages$wage)

