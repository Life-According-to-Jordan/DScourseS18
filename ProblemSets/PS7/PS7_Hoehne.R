library(stargazer)
wages<-read.csv("wages.csv")
wages2<-read.csv("wages.csv")
s<-sum(is.na(wages))
sprintf("The total missing values in wages is: %i", s)
names(wages)
summary(wages)
wages<- na.omit(wages, col=wages$hgc)
wages<- na.omit(wages, col=wages$tenure)
sum(is.na(wages$hgc))
sum(is.na(wages$tenure))
stargazer(wages, type= "latex")
#it appears as though the observations are missing not at at random. I believe the reason why the data 
#is missing is because log measures change in a variable. Because there is no change in the data, this 
#implies that these individuals did not have a change in income. Either no pay decrease, which is rare 
#in any case, or no pay increase, which is more common, especially if you're an Oklahoma school teacher. 
#Question 7 
#Estimate the regression using only complete cases (i.e. do listwise deletion on the log wage variable 
#... this assumes log wages are Missing Completely At Random)
complete.cases(wages2$logwage)
Regression1<- lm(logwage~., data=wages2)
stargazer(Regression1)
#Performing mean imputation to fill in missing log wages and imputing missing log wages as their 
#predicted values from the complete cases regression above (i.e. this would be consistent with 
#the “Missing at Random” assumption)
wages$logwage[is.na(wages$logwage)] <- mean(wages$logwage)
stargazer(wages, type="latex")
#Using the mice package to perform a multiple imputation regression model
library(mice)
wages_mice = mice(wages2, seed = 12345)
summary(wages_mice)
fit<-with(wages_mice, lm(logwage~ hgc+college + tenure + tenure^2 + age + married))
round(summary(pool(fit)))

