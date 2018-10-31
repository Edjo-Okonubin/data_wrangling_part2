# Load required packages----

library(tidyverse)

### USING MUTATE_ALL() FUNCTION---- 
#1.) To change all data to lower case

msleep %>% 
  mutate_all(tolower)

#2.) To clean messy Data. 
#Let's create messy dataset.
msleep_ohno <-msleep %>% 
  mutate_all(~paste(., " /n"))

msleep_ohno [, 1:4]

#Let's now clean up the messy data.
# This code works in two steps. It first removes any /n, and then trims\
# any additioanl white spaces.

msleep_corr <-msleep_ohno %>% 
  mutate_all(~str_replace_all(., "/n", "")) %>% 
  mutate_all(str_trim)

msleep_corr[, 1:4]

### USING MUTATE_IF() FUNCTION----
#1.) To round data. 
# Note that mutate_all() cannot handle all cleaning functions. Trying\
# to round data will result in error if you have both numerical and 
# character columns as shown in the code below:

msleep %>% 
  mutate_all(round)

#Use mutate_if() function to round data
msleep %>% 
  select(name, sleep_total:bodywt) %>% 
  mutate_if(is.numeric, round)

### USING MUTATE_AT() FUNCTION
#1.) To target and change specific columns

msleep %>%                                   #Take msleep dataset, and then...
  select(name, sleep_total:awake) %>%        # Select target columns
  mutate_at(vars(contains("sleep")), ~(.*60))# Mutate columns that contain "sleep" in hours and multiply by 60\
                                             # to give time in minutes.

### USING RENAME () FUNCTION AFTER A MUTATE() STATEMENT
#1.) To rename a column that has been mutated.
msleep %>% 
  select(name, sleep_total:awake) %>% 
  mutate_at(vars(contains("sleep")), ~(.*60)) %>% 
  rename_at(vars(contains("sleep")), ~paste0(., "_min"))
