# Exercise 4: DPLYR and flights data

# Install the nycflights13 package and read it in.  Require the dplyr package
# install.packages("nycflights13")
library(nycflights13)
library(dplyr)

# The data.frame flights should now be accessible to you.  View it, 
# and get some basic information about the number of rows/columns
View(flights)
nrow(flights)
ncol(flights)
# Add a column that is the amount of time gained in the air (`arr_delay` - `dep_delay`)
flights <- mutate(flights, gain = arr_delay - dep_delay)

# Sort your data.frame desceding by the column you just created
flights <- arrange(flights, -gain)

# Try doing the last 2 steps in a single operation using the pipe operator
flights <- flights %>% mutate(gain = arr_delay - dep_delay) %>% 
  arrange(-gain)

# Make a histogram of the amount of gain using the `hist` command
hist(flights$gain)

# On average, did flights gain or lose time?
mean(flights$gain, na.rm = T)
# Lost about 5.5 min
# Create a data.frame that is of flights headed to seatac ('SEA'), 
seatac.flights <- filter(flights, dest == "SEA")

# On average, did flights to seatac gain or loose time?
mean(seatac.flights$gain, na.rm = T)
# Lost about 11.5 min
### Bonus ###
# Write a function that allows you to specify an origin, a destination, and a column of interest
# that returns a data.frame of flights from the origin to the destination and only the column of interest
## Hint: see chapter 11 section on standard evaluation
OriginDestInterest <- function(my.origin, destination, column) {
  return(flights %>% filter(origin == my.origin, dest == destination) %>% select_(column))
}

# Retireve the air_time column for flights from JFK to SEA
result <- OriginDestInterest("JFK", "SEA", "air_time")

# What was the average air time of those flights (in hours)?  
mean(result$air_time, na.rm = T) / 60
# About 5.5 hours

# What was the min/max average air time for the JFK to SEA flights?
min(result$air_time, na.rm = T) / 60
# About 4.5 hours
max(result$air_time, na.rm = T) / 60
# About 6.5 hours