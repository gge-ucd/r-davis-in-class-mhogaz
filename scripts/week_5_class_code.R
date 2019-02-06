#Week 5 Class Code

library(tidyverse)


#using this under tidyverse (read_csv vs. read.csv) you do not need to use stringAsFactors = F (automatic), gives you the col specifications in the console once the file has been loaded

surveys <- read_csv("data/portal_data_joined.csv")

str(surveys)

#this is a tbl datframe now (which is a tudyverse thing)

#select- used when you want to select cols

select(surveys, plot_id, species_id, weight)

#filter- to filter rows

filter(surveys, year == 1995)

#if you want to use multiple finctions, you can do them in separate steps...

surveys2 <- filter(surveys, weight < 5)
surveys_sml <- select(surveys2, species_id, sex, weight)

#taking multiple steps like this can be a little clunky and there is more room for error, so we pipe... %>% (ctrl-shift-m), can think of it like "then". Take the thing on the left (surveys) and put it in the first space on the right i.e. filter(x, )

surveys_sml2 <- surveys %>% 
  filter(weight < 5) %>% 
  select(species_id, sex, weight)

# surveys_sml2 and surveys_sml are the same!

#Challenge! Subset surveys to include individuals collected before 1995 and retain only the columns year, sex, and weigh

surveys_challenge <-surveys %>% 
  filter(year < 1995) %>% 
  select(year, sex, weight)

#mutate is used to create new cols
#create a new col where the weight is in kg. the first spot is the name of the new col

surveys <- surveys %>% 
  mutate(weight_kg = weight/1000)

#can use mutate again with another pipe

surveys <- surveys %>% 
  mutate(weight_kg = weight/1000) %>% 
  mutate(weight_kg2 = weight_kg * 2) 

#filter out NAs first (deltes the rows that are NAs for the given col)

surveys %>% 
  filter(!is.na(weight)) %>% 
  mutate(weight_kg = weight/1000) %>% 
  summary()

# "complete cases" to filter out all of the NAs- any row that has an NA in any col

#Challenge: Create a new data frame from the surveys data that meets the following criteria: contains only the  species_id column and a new column called hindfoot_half containing values that are half the  hindfoot_length values. In this hindfoot_half column, there are no NAs and all values are less than 30.


surveys_challenge <- surveys %>% 
  mutate(hindfoot_half = hindfoot_length/2) %>% 
  select(species_id, hindfoot_half) %>% 
  filter(!is.na(hindfoot_half)) %>% 
  filter(hindfoot_half < 30)

#group by- plit-apply-combine, usually used with summaraize, which spits out a new dataframe (whereas mutate works within the existing dataframe- new col)

surveys_sex <- surveys %>% 
  group_by(sex) %>% 
  summarise(mean_weight = mean(weight, na.rm = T))

surveys %>% 
  group_by(sex) %>% 
  mutate(mean_weight = mean(weight, na.rm = T)) %>% View

# tally will give you counts of what you are looking at

surveys %>%  #tells us where the NAs are in species 
  group_by(species) %>% 
  filter(is.na(sex)) %>% 
  tally()

surveys %>% 
  group_by(sex) %>% 
  tally()

#group by with mult cols

surveys %>% 
  group_by(sex, species_id) %>% 
  summarize(mean_weight = mean(weight, na.rm = T)) %>% View

# if you don't remove the NAs first, you will get values that are not a number NaN

surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(sex, species_id) %>% 
  summarize(mean_weight = mean(weight)) %>% View

# you can summarize multiple things by adding in after a comma in the summarize ()

surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(sex, species_id) %>% 
  summarize(mean_weight = mean(weight), min_weight = min(weight)) %>% View

# Gathering and spreading
#create a new row where values are associated with each plot

#spread- takes the value you want to spread, key col variable is the value you want to look at for the spread, and value is the variable you want to populate each with 

surveys_gw <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(genus, plot_id) %>% 
  summarize(mean_weight = mean(weight))

#want each genus to be its own col- spread!

surveys_spread <- surveys_gw %>% 
  spread(key = genus, value = mean_weight)

surveys_gw %>% 
  spread(key = genus, value = mean_weight, fill = 0) %>% View

#Gathering

surveys_gather <- surveys_spread %>% 
  gather(key = genus, value = mean_weight, -plot_id) %>% View
