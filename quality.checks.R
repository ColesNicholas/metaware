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
# check that coding categories are correct
DF.screen$MW_include %>% 
  unique()

DF.screen$MW_rationale %>% 
  unique()

DF.screen$NC_include %>% 
  unique()

DF.screen$NC_rationale %>% 
  unique()

#----------------------------------------------
# check that NC didn't miss any records that MW said were eligible
DF.screen %>% 
  filter(MW_include == 1) %>% 
  group_by(NC_include) %>% 
  summarise(n = n())

# examine MW and NC cross-tabs (there should be a handful of double-coded records)
table(DF.screen$MW_include, 
      DF.screen$NC_include)

#----------------------------------------------
# check that number of eligible articles = number of included articles
s <- DF.screen %>% 
  filter(NC_include == 1) %>% 
  nrow()

c <- DF.code$name %>% 
  unique %>%
  length()

s == c

rm(s, c)
