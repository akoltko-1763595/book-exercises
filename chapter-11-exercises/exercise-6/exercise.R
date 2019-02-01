# Exercise 6: dplyr join operations

# Install the `"nycflights13"` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
#install.packages("nycflights13")  # should be done already
library("nycflights13")
library("dplyr")

# Create a dataframe of the average arrival delays for each _destination_, then 
# use `left_join()` to join on the "airports" dataframe, which has the airport
# information
# Which airport had the largest average arrival delay?
arr_delays_by_dest <- 
  flights %>% 
  group_by(dest) %>% 
  summarize(
    avg_arr_delay = mean(arr_delay, na.rm = TRUE)
  ) %>% 
  left_join(select(airports, faa, name), by = c("dest" = "faa")) %>% 
  select(name, dest, avg_arr_delay) %>% 
  arrange(desc(avg_arr_delay))

worst_airport <- arr_delays_by_dest %>% 
  head(1) %>% 
  pull(name)
#columbia Metropolitan had the largest average delay

# Create a dataframe of the average arrival delay for each _airline_, then use
# `left_join()` to join on the "airlines" dataframe
# Which airline had the smallest average arrival delay?
arr_delays_by_carrier <- 
  flights %>% 
  group_by(carrier) %>% 
  summarize(
    avg_arr_delay = mean(arr_delay, na.rm = TRUE)
  ) %>% 
  left_join(airlines, by = "carrier") %>% 
  select(name, carrier, avg_arr_delay) %>% 
  arrange(desc(avg_arr_delay))

best_carrier <- arr_delays_by_carrier %>%
  arrange(avg_arr_delay) %>% 
  head(1) %>% 
  pull(name)
