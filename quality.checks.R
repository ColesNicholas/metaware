DF <- read_xlsx(path = "data/metaware_EsData_raw.xlsx",
                sheet = "records.screening",
                na = c("N/A"))

# check that the include numbers are correct
DF$MW_include %>% 
  unique()

DF$MW_rationale %>% 
  unique()

DF$NC_include %>% 
  unique()

DF$NC_rationale %>% 
  unique()

# check that NC didn't miss anything
tmp <- DF %>% 
  filter(MW_include == 1)

tmp %>% 
  group_by(NC_include) %>% 
  summarise(n = n())

# check that the number of records that NC said would be include actually matches how many were in there 
DF %>% 
  filter(NC_include == 1) %>% 
  nrow()

D2F <- read_xlsx(path = "data/metaware_EsData_raw.xlsx",
                sheet = "coding",
                na = c("N/A"))

D2F$name %>% unique %>% length


s <- DF %>% 
  filter(NC_include == 1) %>% 
  select(title) %>% 
  arrange(title)

c <- D2F$name %>% 
  unique()

s.c <- merge(s, c)