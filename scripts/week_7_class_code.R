# Week 7 Class Code

# how to install a package from github

install.packages("devtools")

library(devtools)
library(tidyverse)
install_github("thmasp85/[artchwokr")

#### Data Import and Export ####

wide_dat <- read_csv("data/wide_eg.csv", skip = 2) #skip tells you the number of lines to skip before reading the data- in this case there are 2 lines before the data header starts

# load rda file- rda files can contain one or more objects. saves everything in the environment and all of the steps you have taken to get to it- only works in R. saveRDS and readRDS for RDS, save and load for rda

load("data/mauna_loa_met_2001_minute.rda")

#.rds has to be a single r object

saveRDS(wide_dat, "data/wide_data.rds")

#remove from the environment- use rm()
rm(wide_dat)

#read it in

wide_data_rds <- readRDS("data/wide_data.rds")

#other packages: readxl, googlesheets, googledrive, foreign (contains a bunch of different file formats)

#### datetime data ####

library(lubridate)

sample_dates1 <- c("2016-02-01", "2016-03-17", "2017-01-01")

as.Date(sample_dates1)
# looking for dates that look like YYYY-MM-DD

sample_dates2 <- c("02-01-2001", "04-04-1991")

as.Date(sample_dates2, format = "%m-%d-%Y")

# you can tell R the format for a lot of different types 

as.Date("2016/01/01", fomrat = "%y/%m/%d")

# b = the shortened month name (text) B = full month name (text)

as.Date("Jul 04, 2017", format = "%b%d,%Y")

#Date Calculations

date1 <-  as.Date("2017-07-11")
date2 <- as.Date("2016- 04-22")

print(date1 - date2) # default is to give in days

# time difference in weeks

print(difftime(date1, date2, units = "week"))

six.weeks <- seq(date1, length = 6, by = "week") # gives you a sequence of the next 6 weeks after the starting date

# Challenge: create a seq of 10 dates starting at date1 with 2 week intervals

ten.weeks <- seq(date1, length = 10, by = "2 week") #can use 14, 14 days

# lubridate package does it easier!

ymd("2016/01/01")
dmy("04.04.91")
