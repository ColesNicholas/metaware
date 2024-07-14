# This code is used to complile information for a PRISMA flowchart detailing the literature search strategy
# author: "Anonymous for peer review; NAC"

#----------------------------------------------
# load libraries
library("tidyverse")
library("readxl")
library("here")

# specify directory
i_am("images/PRISMA.R")

#----------------------------------------------
# load screening data
DF.screen <- 
  read_xlsx(path = here("data/metaware_EsData_raw.xlsx"),
            sheet = "records.screening",
            na = c("N/A"))

# load coding data
DF.code <- 
  read_xlsx(path = here("data/metaware_EsData_raw.xlsx"),
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
# number of papers
DF.code$name %>% 
  unique %>%
  length()

# number of studies
DF.code$id %>% 
  unique %>%
  length()

# number of effect sizes
DF.code %>% 
  nrow