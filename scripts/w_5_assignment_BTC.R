library(tidyverse)

#read csv file using tidyverse
surveys <- read_csv("data/portal_data_joined.csv")

#subset to keep all the rows where weight is between 30 and 60, then print the first 6 rows of the tibble

surveys %>% #pipe in surveys for all following functions
  filter(weight >= 30) %>% #filter to select rows
  filter(weight <= 60) %>% 
  head() #head to print first 6 rows

#Make a tibble that shows the max weight for each species + sex combination, and name it biggest_critters. Use the arrange function to look at the biggest and smallest critters in the tibble

biggest_critters <- surveys %>% #pipe in surveys
  group_by(sex, species_id) %>% #group surveys by sex and species ID
  summarize(max_weight = max(weight, na.rm = TRUE)) %>% #summarize sex and species ID combos with max weight
  arrange(desc(max_weight)) #arrange max weight from high to low

#Where are the NAs concentrated?

where_are_NAs <- surveys %>% 
  arrange(desc(is.na(sex)), #arrange to search for NAs by sex, plot_id, species_id, and plot_type
          desc(is.na(plot_id)), 
          desc(is.na(species_id)), 
          desc(is.na(plot_type))) %>%
  group_by(sex, plot_id, species_id, plot_type) %>% #group_by for variables used above
  tally() #tally to make new column of number of data points 

#Take surveys, remove the rows where weight is NA and add a column that contains the average weight of each species+sex combination. Then get rid of all the columns except for species, sex, weight, and your new average weight column.

surveys_avg_weight <- surveys %>% 
  filter(!is.na(weight)) %>% #filter out NAs
  group_by(species_id, sex) %>% #group by species+sex combo
  mutate(mean_weight = mean(weight)) %>% #add new column of mean weight
  select(species_id, sex, weight, mean_weight) #%>% #select only these columns
  #View()

#Challenge: Take surveys_avg_weight and add a new column called above_average that contains logical values stating whether or not a row’s weight is above average for its species+sex combination

above_average_weights <- surveys_avg_weight %>% 
  mutate(above_average = weight > mean_weight) #%>% #mutate to add new row of TRUE/FALSE
  #View()

#Extra Challenge: Figure out what the scale function does, and add a column to surveys that has the scaled weight, by species. Then sort by this column and look at the relative biggest and smallest individuals. Do any of them stand out as particularly big or small?

scaled_weights <- surveys %>% 
  group_by(species_id) %>% #group by just species_id
  mutate(scaled_weight = scale(weight, center = TRUE, scale = FALSE)) %>% #add new column of scaled_weight
  arrange(desc(scaled_weight)) #%>% #arrange scaled_weight from largest to smallest
  #View() 
  #Looks like Sigmodon fulviventer had the largest scaled weight (140.12) 



    
