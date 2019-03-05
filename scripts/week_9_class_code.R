# week 9 class code

# iterations continued ####

sapply(1:10, sqrt) #first argument is the object you want to iterate over (data), the second is the function you want to APPLY to each thing

#example for loop to an apply function

result <- rep(NA, 10) # repeat NA 10 times
for(i in 1:10){
  result[i] <- sqrt(i) / 2
}
 result

 # now use apply function
 
 results_apply <- sapply(1:10, function(x) sqrt(x)/2) # this does the same thing as the for loop, but is one line and simpler
 results_apply 

 # you can pass additional arguments inside of apply
 mtcars_na <- mtcars

 mtcars_na[1, 1:4] <-  NA 

 sapply(mtcars_na, mean) 
 sapply(mtcars_na, mean, na.rm = T)  #every time you apply mean to the cars columns, na.rm = T 

 # back to the tidyverse
 
 library(tidyverse)
mtcars %>% 
  map(mean)

mtcars %>% 
  map_dbl(mean) #this map gives you a vector of doubles (numbers), all of the map functions are explicit and give you back what you are asking for specifically

mtcars %>% 
  map_chr(mean)

#map2_ for 2 sets of inputs

map2_chr(rownames(mtcars), mtcars$mpg, function(x,y) paste(x, "gets", y, "miles per gallon"))

# complete workflow- we are going to attempt to rescale things within the mtcars dataset (weight)

(mtcars$wt[1] - min(mtcars$wt)) / (max(mtcars$wt) - min(mtcars$wt))

# generalize

(x - min(x)) / (max(x) - min(x))

# make that into a function
rescale_01 <- function(x){
  (x - min(x)) / (max(x) - min(x))
}
rescale_01(mtcars$wt)

# iterating!

map_df(mtcars, rescale_01) # you can use map to get back an entire dataframe that is rescaled
