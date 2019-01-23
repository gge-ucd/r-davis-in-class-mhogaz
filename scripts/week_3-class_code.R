read.csv("data/tidy.csv")

x <- 4

#vectors- use c() to create vector of multiple values

weight_g <- c(50, 60, 31, 89)
weight_g

#now charcters
animals <- c("mouse", "rat", "dog", "cat")
animals

#vector exploration tools
length(x = weight_g)

#all items in a vector must be the same class
class(weight_g)
class(animals)

#structure of an object; first tool for looking at an object
str(weight_g)

#add another value to a vector; be careful about adding values and running multiple times
weight_g <- c(weight_g, 105)

weight_g <- c(25, weight_g)
weight_g

# 6 types of atmoic vectors: "numeric" ("double"), "character", "logical", "integer", "complex", "raw"

# the first four listed are the main ones we work with

typeof(weight_g)

weight_integer <- c(20L, 21L, 85L)

#challenge: We’ve seen that atomic vectors can be of type character, numeric (or double), integer, and logical. But what happens if we try to mix these types in a single vector?

num_char <- c(1, 2, 3, "a")
num_logical <- c(1, 2, 3, TRUE)
char_logical <- c("a", "b", "c", TRUE)
tricky <- c(1, 2, 3, "4")

num_logical <- c(1, 2, 3, TRUE)
char_logical <- c("a", "b", "c", TRUE)
combined_logical <- c(num_logical, char_logical)

#coersion to make sure all values in vector are the same type (least to most specific type): character, double, integer, logical

#subsetting vectors
animals

# use square brackets to pull out a value in a given position
animals[3]
animals[c(2,3)]
animals[c(3, 1, 3)]

# conditonal subsetting
weight_g[c(T, F, T, T, F, T, T)]

weight_g > 50

#this gives us all of the values in the vector that are greater than 50. First generating the logical vector 
weight_g[weight_g > 50]

#multiple conditions- give me the weight_g values where weight_g is less than 30 or greater than 50
weight_g[weight_g < 30 | weight_g > 50]

#weight_g values where weight_g is greater than or equal to 30 and weight_g is equal to 90
weight_g[weight_g >= 30 & weight_g == 90] #no number in the vector is exactly equal to 90

#searching for characters
animals[animals == "cat" | animals == "rat"]

#rat is the second one in the vector, so that is why the second value is true- it shows you where in the original vector one of the values is. Using brackets in the second example tells you which value is the one that is the same
animals %in% c("rat", "antelope", "jackalope", "hippogriff")

animals[animals %in% c("rat", "antelope", "jackalope", "hippogriff")]

#challenge- these are giving you the alphabetic order

"four" > "five"
"six" > "five"

# missing values

heights <- c(2, 4, 4, NA, 6)
str(heights)

mean(weight_g)
mean(heights)
max(heights)
mean(x = heights, na.rm = T)
max(heights, na.rm = T)

# will tell you logical vector for which are NA
is.na(heights)

na.omit(heights)
complete.cases(heights) #these are complete cases or not
