
print('excercise 1')
library("rvest")
library("dplyr")

imdb <- read_html("http://www.imdb.com/showtimes/cinema/US/ci100180205?ref_=inth_tny_th")

title <- imdb %>% html_nodes(".info span a") %>% html_text
time <- imdb %>% html_nodes("time") %>% html_text

mydf <- data.frame(title, time)

list(mydf)

print('excercise 2')
library(Quandl)

#quandl user api granted upon enrolling as a user
mydata = Quandl("FRED/GDP", start_date="2000-12-31", end_date="2018-12-31", collapse="annual", rows=4)

#data returned as data.frame
class(mydata)

mydata

print('it worked, thank you for running my code!')


