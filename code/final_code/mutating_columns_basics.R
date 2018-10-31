###MUTATING COLUMNS----
#The Basics----
#Load required package
library(tidyverse)

#Take a peek at inbuilt dataset.
glimpse(msleep)

#Change sleep data measured in hours to minutes.

msleep %>% 
  select(name, sleep_total) %>% 
  mutate(sleep_total_min = sleep_total * 60)

#Create new columns using aggregate functions.
msleep %>% 
  select(name, sleep_total) %>% 
  mutate(sleep_total_vs_AVG = sleep_total- round(mean(sleep_total), 1),
         sleep_total_vs_MIN = sleep_total- min(sleep_total))

#Performing aggregate functions by row.
msleep %>% 
  select(name, contains("sleep")) %>% 
  rowwise() %>% 
  mutate(avg = mean(c(sleep_rem, sleep_cycle)))
