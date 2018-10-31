#Load required packages
library(tidyverse)

###BRINGING IN COLUMNS FROM OTHER DATA TABLES----

msleep %>%                                           # Take msleep dataset, and then...
  select(name, conservation) %>%                     # Select target variables.
  mutate (conservation = toupper(conservation)) %>%  # Change conservation variable to uppercase.
  left_join(conservation_table, by = c("conservation" = "abbreviation")) %>% 
  mutate(description = ifelse(is.na(description), conservation, description))

###GATHERING DATA----
msleep %>% 
  select(name, contains("sleep")) %>% 
  gather(key = "sleep_measure", value = "time", -name)

#Restoring the original order with factor_key = TRUE argument.
(msleep_g <-msleep %>% 
    select(name, contains("sleep")) %>% 
  gather(key = "sleep_measure", value = "time", -name, factor_key = TRUE))

###SPREADING DATA----

msleep_g %>%                  # Take mslee_g dataset, and then...
  spread(sleep_measure, time) # Split the key(sleep_measure) value pair into constituent columns

#Turning Data into NA using na_if() function. Note that this function\
#can turn pretty much any value into NA, as shown below:

msleep %>%
  select(name:order) %>% 
  na_if("omni")

