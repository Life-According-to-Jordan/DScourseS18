#load data 
data<-read.csv("CNN_ACC.csv", header = FALSE)

#load library 
library(ggplot2)

#set names for data
names(data)<-c("epoch", "accuracy", "model")
data

#plot the data
ggplot(data = data, 
       aes(epoch, accuracy)) + 
       theme_minimal() + 
       geom_point(aes(color = model)) + 
       labs(title="Training and Testing Accuracy")