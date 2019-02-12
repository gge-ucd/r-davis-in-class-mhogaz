library(tidyverse)

#load and assign surveys data
surveys <- read_csv("data/portal_data_joined.csv")

#filter so weight is only between 30 and 60
surveys_weight <- surveys %>% 
  filter(weight > 30 & weight < 60) 

#print top 6 rows of filtered surveys
head(surveys_weight)

#create biggest critters tibble that is a summary of the max weights of each sex-species combo
biggest_critters <- surveys %>% 
  group_by(species, sex) %>% 
  filter(!is.na(weight)) %>% 
  summarize(max_wt = max(weight))

#arrange to look at biggest and smallest of biggest_critters
biggest_critters %>% 
  arrange(desc(max_wt)) %>% 
  head()

biggest_critters %>% 
  arrange(desc(max_wt)) %>% 
  tail()

#explore where the NAs are in the data
surveys %>%  
  group_by(sex)
  filter(is.na(weight)) %>% 
  tally() %>% 
  arrange(desc(n)) %>% View

surveys %>%  
  group_by(hindfoot_length) %>% 
  filter(is.na(weight)) %>% 
  tally() %>% 
  arrange(desc(n)) %>% View

surveys %>%  
  group_by(species) %>% 
  filter(is.na(weight)) %>% 
  tally() %>% 
  arrange(desc(n)) %>% View

#make new tibble with the average weights of the sex-species combos
surveys_avg_weight <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(species, sex) %>% 
  mutate(avg_wt = mean(weight)) %>% 
  select(species, sex, weight, avg_wt)

#challenge: make new col above_average with logical values stating whether a row's weight is above average or not for each spp-sex combo

surveys_avg_weight <-  surveys_avg_weight %>% 
  mutate(above_avg = weight > avg_wt)

#extra challenge: add col that has scaled weight by spp. Sort and look at relative biggest and smallest indiviuals

surveys <- surveys %>% 
  mutate_at(scale, .vars = vars(weight, species)) 
#not done with the above, doesn't work yet  

         