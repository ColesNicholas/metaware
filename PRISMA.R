#----------------------------------------------
# load libraries
library("tidyverse")
library("readxl")

#----------------------------------------------
# load screening data
DF.screen <- 
  read_xlsx(path = "data/metaware_EsData_raw.xlsx",
            sheet = "records.screening",
            na = c("N/A"))

# load coding data
DF.code <- 
  read_xlsx(path = "data/metaware_EsData_raw.xlsx",
            sheet = "coding",
            na = c("N/A"))

#----------------------------------------------
# estimate # of records per search
DF.screen %>% 
  group_by(database) %>% 
  summarise(n = n())

#----------------------------------------------
# total number of records assessed
DF.screen %>%
  nrow()

#----------------------------------------------
# total number of records excluded
DF.screen %>% 
  filter(MW_include == 0 |
           NC_include == 0) %>% 
  nrow()

#----------------------------------------------
# reasons for exclusions
# sometimes the final decision is in MW's column (e.g., if he decided it was not eligible)
# other times it is in NC's column (e.g., if MW asked NC to look at the record)
DF.screen %>%
  
  # identify final exclusion reason
  mutate(exclusion.final = 
           if_else(condition = !is.na(NC_rationale),
                   true = NC_rationale,
                   false = MW_rationale)) %>% 
  
  # select excluded records
  filter(MW_include == 0 |
           NC_include == 0) %>% 
  
  # summarise
  group_by(exclusion.final) %>% 
  summarise(n = n())

#----------------------------------------------
# why so many 5's?
DF.screen %>%
  
  # identify final exclusion reason
  mutate(exclusion.final = 
           if_else(condition = !is.na(NC_rationale),
                   true = NC_rationale,
                   false = MW_rationale)) %>% 
  
  filter(exclusion.final == 5) %>% 
  View()

#----------------------------------------------
# Should also split by search type and check the reasons. E.g., there should be no 6's in Searches 1 and 2. If there is, it was a neural outcomes
DF.screen %>%
  
  # identify final exclusion reason
  mutate(exclusion.final = 
           if_else(condition = !is.na(NC_rationale),
                   true = NC_rationale,
                   false = MW_rationale)) %>% 
  
  # select excluded records
  filter(MW_include == 0 |
           NC_include == 0) %>% 
  
  # summarise
  group_by(database, exclusion.final) %>% 
  summarise(n = n()) %>% View()

#----------------------------------------------
# number of papers
DF.code$name %>% 
  unique %>%
  length()

# number of studies
DF.code$id %>% 
  unique %>%
  length()

# number of effect sizes'
DF.code %>% 
  nrow
