#Load required packages
library(tidyverse)

###RECODING DISCRETE COLUMNS----
#1.) Using mutate() with recode().
msleep %>% 
  mutate(conservation2 = recode(conservation,
                                "en" = "Endangered",
                                "lc" = "Least_Concern",
                                "domesticated" = "Least_Concern",
                                .default = "other")) %>% 
  count(conservation2)

#2.) Using mutate() with recode_factor().
msleep %>% 
  mutate(conservation2 = recode_factor(conservation,
                                       "en" = "Endangered",
                                       "lc" = "Least_Concern",
                                       "domesticated" = "Least_Concern",
                                       .default = "other", 
                                       .missing = "no data",
                                       .ordered = TRUE)) %>% 
  count(conservation2)

###CREATING NEW DISCRETE COLUMNS----
#1.) Two Levels:
#Using mutate() function with ifelse() statement.

msleep %>% 
  select(name, sleep_total) %>% 
  mutate(sleep_time = ifelse(sleep_total > 10, "long", "short"))

#2.) Multiple Levels:
#Using mutate() function with case_when() statement.

msleep %>%
  select(name, sleep_total) %>% 
  mutate(sleep_total_discr = case_when(
    sleep_total > 13 ~ "very long",
    sleep_total > 10 ~ "long",
    sleep_total > 7 ~ "limited", 
    TRUE ~ "short")) %>% 
  mutate(sleep_total_discr = factor(sleep_total_discr,
                                    levels = c("short", "limited",
                                               "long", "very long")))

#Using case_when() to group across columns
msleep %>% 
  mutate(silly_groups = case_when(
    brainwt < 10 ~ "light_headed",
    sleep_total > 10 ~ "lazy_sleeper",
    is.na(sleep_rem) ~ "absent_rem",
    TRUE ~ "other")) %>% 
  count(silly_groups)
