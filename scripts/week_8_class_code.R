library(lubridate)
library(tidyverse)

load("data/mauna_loa_met_2001_minute.rda")

as.Date("02-01-1998", format = "%m-%d-%Y")

mdy("02-01-1998")

# datetime data- POSIXcT wants year, month day hours, min, sec; use format if it is not this way

tm1 <- as.POSIXct("2016-07-24 23:55:26 PDT")

tm2 <- as.POSIXct("25072016 08:32:07", format = "%d%m%Y %H:%M:%S")

#can tell the time zone

tm3 <- as.POSIXct("2010-12-01 11:42:03", tz = "GMT")

#strptime is for specifying time zone and date format in the same call

tm4 <- as.POSIXct(strptime(C, format = "%Y/%m/%d %H:%M"), tz = "America/Los_Angeles")

tz(tm4)

Sys.timezone()


# you can do the same thing with lubridate

ymd_hm("2010-12-01 11:43", tz = "America/Los_Angeles")


nfy <- read_csv("data/2015_NFY_solinst.csv", skip = 12)

nfy2 <- read_csv("data/2015_NFY_solinst.csv", skip = 12, col_types = "ccidd") #col types are character, charcter, integer, double, double

nfy3 <- read_csv("data/2015_NFY_solinst.csv", skip = 12, col_types = cols(Date = col_date()))
glimpse(nfy3) #this lets you specify which col you want to make different, everything else will be default

# create new col datetime, it will be added on to the end of the sheet

nfy$datetime <- paste(nfy$Date, " ", nfy$Time, sep = "")

# need to make the datetime col in the datetime format, not a character, otherwise R doesn't know what to do with it

nfy2$datetime <- ymd_hms(nfy$datetime, tz = "America/Los_Angeles")

summary(mloa_2001)

mloa_2001$datetime <- paste0(mloa_2001$year, "-", mloa_2001$month, "-", mloa_2001$day, "-", mloa_2001$hour24, ":", mloa_2001$min)
 glimpse(mloa_2001)

mloa_2001$datetime <- ymd_hm(mloa_2001$datetime)
 
 
 #### Challenge ####
 # Challenge with dplyr & ggplot
 # Remove the NA’s (-99 and -999) in rel_humid, temp_C_2m, windSpeed_m_s
 # Use dplyr to calculate the mean monthly temperature (temp_C_2m) using the datetime column (HINT: look at lubridate functions like month())
 # Make a ggplot of the avg monthly temperature
 # Make a ggplot of the daily average temperature for July (HINT: try yday() function with some summarize() in dplyr)
 
 mloa_2001_sm <- mloa_2001 %>% 
   filter(rel_humid != -99, rel_humid != -999) %>% 
   filter(temp_C_2m != -99, temp_C_2m != -999) %>% 
   filter(windSpeed_m_s != -99, windSpeed_m_s != -999)
 
 glimpse(mloa_2001_sm) 
 
 mloa3 <- mloa_2001_sm %>% 
   mutate(which_month = month(datetime, lab = T)) %>% #we are making a new col named which_month and using the lubridate function of month, which pulls out the month for the col specified, which here is datetime. lab = T gives you the name of the month as opposed to the numeric month 
   group_by(which_month) %>% 
   summarize(avg_temp = mean(temp_C_2m))

 mloa3 %>% ggplot() +
   geom_point(aes(x = which_month, y = avg_temp), size = 3, color = "blue") +
   geom_line(aes(x= which_month, y = avg_temp))

 #### Functions #### 
 
 # any operation that you want to perform more than once can become a function
 
 log(5) # 5 is the argument of the funciton log
 
 # this function says take a and b and return the_sum, which has been desineted as a + b
 my_sum <- function(a, b){
   the_sum <- a + b
   return(the_sum)
 }

 my_sum(3, 7)

 # can add default values to the funtion
 my_sum <- function(a=1, b=2){
   the_sum <- a + b
   return(the_sum)
 }

 my_sum() 

 #Create a function that converts the temp in K to the temp in C (subtract 273.15)
 
 conv_temp <- function(a, b= 273.15) {
   conv <- a - b
   return(conv)
 }

 conv_temp(100) 

 
 ### Iterations ####
 
 x <- 1:10
log(x) 

# for loops- will repeat code with a new starting value

for(i in 1:10) {
  print(i)
} # for ea value i,in the vector1:10, I want to do whatever is in the {}


for(i in 1:10){
  print(i)
  print(i^2)
}

# we can use the "i" value as an index
for(i in 1:10){
  print(letters[i])
  print(mtcars$wt[i])
}

#make a results vecotor ahead of time

results <- rep(NA, 10)

for(i in 1:10){
  results[i] <- letters[i]
}
