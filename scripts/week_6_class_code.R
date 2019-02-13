# Week 6 Class Code

library(tidyverse)

####finishing up dplyr ===========

# create dataframe that will be used in ggplt later

surveys <- read_csv("data/portal_data_joined.csv")

#create df whwere there are no NAs in weight, hindfoot, sex cols, remove obsv of rare speices (< 50) times

surveys_complete <- surveys %>% 
  filter(!is.na(weight), !is.na(hindfoot_length), !is.na(sex))

species_counts <- surveys_complete %>% 
  group_by(species_id) %>% 
  tally() %>% 
  filter(n >= 50)

# want R to only use the species counts df in the surceys complete df %in% takes a list and tells it to loook within another list (is the entry on the left somewhere in the entry on the right?)

surveys_complete <- surveys_complete %>% 
  filter(species_id %in% species_counts$species_id)

#save a df as a csv
write_csv(surveys_complete, "data_output/surveys_complete.csv")

#### ggplot ===================

# ggplot(data = DATA, mapping = aes(MAPPINGS)) + 
# geom_function()

ggplot(surveys_complete)

#define a mapping

ggplot(surveys_complete, mapping = aes(x= weight, y=hindfoot_length)) +
  geom_point()

# saving a plot object, then you can use the object and just add layers with +

surveys_plot <- ggplot(surveys_complete, mapping = aes(x= weight, y=hindfoot_length))

surveys_plot + 
  geom_point()

# anything in the ggpot function (the first part), will be looked at by the geoms- these things will be acted upon globally, ie by anything that comes next
# you can specify the mapping for the geoms independently 

#challenge- make hexbin plot, this ends up beig more of a density plot so you can differernetiate the amount of points that are in a high density area

surveys_plot +
  geom_hex()

# we'ew going to build plots from the ground up

ggplot(surveys_complete, aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.1, color = "tomato") #add global moifications to that geom straight into geom_point, alpha is the transparency

#aes inside of geom_point will translate data inside of the points: set the color for the data points according to species_id
surveys_complete %>% 
  ggplot(aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.1, aes(color = species_id))

#putting color as a global aes- in this example it gives you the same plot, but remember that this color by species will be used by any other geoms that you add on to this plot
surveys_complete %>% 
  ggplot(aes(x = weight, y = hindfoot_length, color = species_id)) +
  geom_point(alpha = 0.1)

# using a little jitter- move the points slightly so they are not right on top of each other (not super helpful in this example because there are so many data points)
surveys_complete %>% 
  ggplot(aes(x = weight, y = hindfoot_length, color = species_id)) +
  geom_jitter(alpha = 0.1)

# Box plots

 surveys_complete %>% 
   ggplot(aes(x = species_id, y = weight)) +
   geom_boxplot()

# adding points to boxplot- when using multiple geoms that may overlay each other, the order of the lines matter
 surveys_complete %>% 
   ggplot(aes(x = species_id, y = weight)) +
   geom_jitter(alpha = 0.3, color = "tomato") +
   geom_boxplot(alpha = 0) 

 # plotting time series
 
 yearly_counts <- surveys_complete %>% 
   count(year, species_id) #same as group_by(year, species_id) %>% tally()
 
 yearly_counts %>% 
   ggplot(aes(x = year, y = n, group = species_id, color = species_id)) +
   geom_line()
 # above: geom line is looking back and pulling out both of the aes variable- 1. only want to draw lines to points of the same species and 2. when drawing those lines, want each speceis to be its own color
 
 # facetting
yearly_counts %>% 
  ggplot(aes(x = year, y = n)) +
  geom_line() +
  facet_wrap(~ species_id)

# including sex

yearly_sex_counts <- surveys_complete %>% 
  count(year, species_id, sex)

yearly_sex_counts %>% 
  ggplot(aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap( ~ species_id) +
  theme_bw() + #addint themes: bw gets rid of the grey backround
  theme(panel.grid = element_blank())  #got rid of the panel grid

ysx_polt <- yearly_sex_counts %>% 
  ggplot(aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap( ~ species_id) 

ysx_polt + theme_minimal()

# ggthemes package has a lot of different themes you can use
#can save any combinations of themes you have made as an object and then add it on to any plot:

my_theme <- theme_bw() + 
  theme(panel.grid = element_blank()) 

ysx_polt + my_theme

# a little more facetting

yearly_sex_weight <- surveys_complete %>% 
  group_by(year, sex, species_id) %>% 
  summarize(avg_weight = mean(weight))

yearly_sex_weight %>% 
  ggplot(aes(x = year, y = avg_weight, color = species_id)) +
  geom_line() + 
  facet_grid(sex ~ .)  #rows and cols separated by ~, the . means nothing in this dimension

# adding labels and stuff

yearly_sex_counts %>% 
  ggplot(aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap( ~ species_id) +
  theme_bw() + #adding themes: bw gets rid of the grey backround
  theme(panel.grid = element_blank()) +  #got rid of the panel grid
  labs( title = "Observed Species through Time", x = "Year of Observation", y = "Number of Species") +
  theme(text = element_text(size = 16)) +
  theme(axis.text.x = element_text(color = "grey20", size = 12, angle = 90, hjust = 0.5, vjust = 0.5))


ggsave("figs/my_test_facet_plot.jpeg", height = 8, width = 8) # will save the last plot made

# can make a script with all your personalized functions, themes, etc. and then use soure at the beginning of any of your new scripts and it will read all of those into the beginning of the current script


