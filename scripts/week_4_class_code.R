# Intro to Dataframes

download.file(url = "https://ndownloader.figshare.com/files/2292169", destfile = "data/portal_data_joined.csv")

surveys <- read.csv(file = "data/portal_data_joined.csv")


head(surveys) #prints the first 6 rows with every column of the dataframe

str(surveys) #structure of the object, in this case, a dataframe- tells us how many rows (obs) and columns (variables) as well as type of vector for each col

dim(surveys)
nrow(surveys)
ncol(surveys)

tail(surveys)

names(surveys) #characters of each of the col names

summary(surveys) #intitially see if there is anything messed up with the data

#subsetting datframes

animal_vec <- c("mouse", "cat", "rat")
animal_vec[2]

#dataframes are 2D

surveys[1,1] #first row, first col
surveys[2,1] #always row, then col

#whole first col as a vector
surveys[,1] #leaving one of the dimensions blank will give everything in that dimension

head(surveys[1]) #this output is a dataframe with one col- result of using a single number with no comma

#pull out the first 3 values in the 6th col
surveys[1:3,6]

#pull out a whole, single observation- this is a dataframe with the length of one row
surveys[5,]

#negative sign to exclude indices
surveys[1:5,-1] #get the first 5 rows without the first col


surveys[-10:34786,] # R doesn't like going past 0, wrapt it in c()
surveys[-c(10:34786),]

surveys[c(10, 15, 20, 10),]

#more ways to subset

surveys["plot_id"] #single col as dataframe
surveys[,"plot_id"] #single col as vector

surveys[["plot_id"]] #single col as vector, we'll come back to using double brackets with list

surveys$year #single col as vector

# challenge
surveys_200 <- surveys[200,]

nrow(surveys)
surveys_last <- surveys[34786,]
tail(surveys)
surveys_last

surveys[nrow(surveys),]

surveys_middle <- surveys[(34786/2),]

surveys[-c(7:nrow(surveys)),]

#Finally, factors

#creating our own factor

sex <- factor(c("male", "female", "female", "male"))
sex
class(sex)
typeof(sex)

#levels gives back a character vector of the levels
levels(sex)
levels(surveys$genus)

nlevels(sex)

concentration <- factor(c("high", "medium", "high", "low"))
concentration

concentration <- factor(concentration, levels = c("low", "medium", "high"))
concentration

# let's try adding to a factor
concentration <- c(concentration, "very high")
concentration

#coerces to characters if you add a value that doesn't match a current level

#let's just make them characters
as.character(sex)

#factors with numeric levels
year_factor <- factor(c(1990, 1923, 1965, 2018))
as.numeric(year_factor)
as.character(year_factor)

# this will actually give us a numeric vector
as.numeric(as.character(year_factor))

# recommended way of doing the above- 
as.numeric(levels(year_factor))[year_factor]

#why are there so many factors in this dataframe?
?read.csv
 #read.csv will take any character strings it can find and by default will turn them to factors. Need to have the argument strinsASFactors = F

surveys_no_factors <- read.csv(file = "data/portal_data_joined.csv", stringsAsFactors = F)


#renaming factors
sex <- surveys$sex
levels(sex)
levels(sex)[1] <- "undertermined"


#working with dates
library(lubridate)

my_date <- ymd("2015-01-01")
str(my_date)

my_date <- ymd(paste("2015", "05", "17", sep = "-"))
my_date

# we can do this to an entire col

paste(surveys$year, surveys$month, surveys$day, sep = "-")
surveys$date <- ymd(paste(surveys$year, surveys$month, surveys$day, sep = "-"))

surveys$date[is.na(surveys$date)]
