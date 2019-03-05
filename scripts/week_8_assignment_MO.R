# week 8 assignment

library(tidyverse)
library(lubridate)

#### Part 1 ####
# load the american river data
am_riv <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/2015_NFA_solinst_08_05.csv", skip = 13)

#create a dateime column at then end of the dataframe by using paste and the Date and Time cols
am_riv$datetime <- paste(am_riv$Date, " ", am_riv$Time, sep = "")

# convert new datetime col into datetine format, not character; use lubridate
am_riv$datetime <- ymd_hms(am_riv$datetime, tz = "America/Los_Angeles")

# new col for week
am_riv$week <- week(am_riv$datetime)

#Calculate the weekly mean, max, and min water temperatures 
am_riv_temp <- am_riv %>% 
  group_by(week) %>% 
  summarize(mean_temp = mean(Temperature), max_temp = max(Temperature), min_temp = min(Temperature))
  
# plot as a point plot (all on the same graph)
week.plot <- am_riv_temp %>% 
  ggplot(aes(x = week)) +
  geom_point(aes(y = mean_temp), shape = 0, color = "mediumpurple") +
  geom_point(aes(y = max_temp), shape = 1, color = "tomato") +
  geom_point(aes(y = min_temp), shape = 2, color = "steelblue1") +
  theme_bw() +
  labs(title = "Weekly American River Temperatures", x = "Week", y = "Temperature")
week.plot

#Calculate the hourly mean Level for April through June 

#make new colums for hour and month data
am_riv$hour <- hour(am_riv$datetime)
am_riv$month <- month(am_riv$datetime)

 am_riv_level <- am_riv %>% 
   filter(month == 4| month == 5 | month ==  6) %>% 
   group_by(month, hour, datetime) %>% 
   summarize(hourly_level = mean(Level))
   
# make a line plot (y axis should be the hourly mean level, x axis should be datetime)
level.plot <- am_riv_level %>%
  ggplot(aes(x = datetime, y = hourly_level)) +
  geom_line()
level.plot

#### Part 2 ####
load("data/mauna_loa_met_2001_minute.rda")

#create datetime column
mloa_2001$datetime <- paste0(mloa_2001$year, "-", mloa_2001$month, "-", mloa_2001$day, "-", mloa_2001$hour24, ":", mloa_2001$min)
glimpse(mloa_2001)

#format datetime as datetime
mloa_2001$datetime <- ymd_hm(mloa_2001$datetime)

# remove -99 and -999 from data
mloa_2001_sm <- mloa_2001 %>% 
  filter(rel_humid != -99, rel_humid != -999) %>% 
  filter(temp_C_2m != -99, temp_C_2m != -999) %>% 
  filter(windSpeed_m_s != -99, windSpeed_m_s != -999)

# write plot_temp function that returns a graph of the temp_C_2m for a single month
plot_temp <- function(monthtoplot, dat = mloa_2001_sm) {
  df <- filter(dat, month == monthtoplot)
  plot <- df %>% 
    ggplot() +
    geom_line(aes(x = datetime, y = temp_C_2m)) 
  return(plot)
}
plot_temp(1)
