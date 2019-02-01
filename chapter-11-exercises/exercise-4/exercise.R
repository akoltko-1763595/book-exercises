# Exercise 4: practicing with dplyr

# Install the `"nycflights13"` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
#install.packages("nycflights13")
library("nycflights13")
library("dplyr")

# The data frame `flights` should now be accessible to you.
# Use functions to inspect it: how many rows and columns does it have?
# What are the names of the columns?
# Use `??flights` to search for documentation on the data set (for what the 
# columns represent)
?flights

# Use `dplyr` to give the data frame a new column that is the amount of time
# gained or lost while flying (that is: how much of the delay arriving occured
# during flight, as opposed to before departing).
flights <- flights %>% 
  mutate(gain_in_air = dep_delay - arr_delay)

View(flights)
# Use `dplyr` to sort your data frame in descending order by the column you just
# created. Remember to save this as a variable (or in the same one!)
flights <- arrange(flights, gain_in_air)

# For practice, repeat the last 2 steps in a single statement using the pipe
# operator. You can clear your environmental variables to "reset" the data frame
flights <- flights %>% 
  mutate(
    gain_in_air = dep_delay - arr_delay
  ) %>% 
  arrange(
    desc(
      gain_in_air
    )
  )

# Make a histogram of the amount of time gained using the `hist()` function
flights %>% 
  select(gain_in_air) %>% 
  pull() %>% 
  hist()

# On average, did flights gain or lose time?
# Note: use the `na.rm = TRUE` argument to remove NA values from your aggregation

flights %>% 
  select(gain_in_air) %>% 
  pull() %>% 
  mean(na.rm = TRUE) #outputs -5.66
#since average gain_in_air < 0, time is gained in a flight


# Create a data.frame of flights headed to SeaTac ('SEA'), only including the
# origin, destination, and the "gain_in_air" column you just created
sea_flights <- flights %>% 
  filter(dest == "SEA") %>% 
  select(origin, dest, gain_in_air) %>% 
  arrange(origin)

# On average, did flights to SeaTac gain or loose time?
sea_flights %>% 
  summarise(
    avg_time = mean(gain_in_air, na.rm = TRUE)
  )


# Consider flights from JFK to SEA. What was the average, min, and max air time
# of those flights? Bonus: use pipes to answer this question in one statement
# (without showing any other data)!
flights %>% 
  filter(
    origin == 'JFK', 
    dest == 'SEA'
  ) %>% 
  summarize(
    origin = "JFK",
    dest = "SEA", 
    avg_flight = mean(air_time, na.rm = TRUE), 
    best_flight = min(air_time, na.rm = TRUE), 
    worst_flight = max(air_time, na.rm = TRUE)
  )

