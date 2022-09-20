## ----setup and load packages, include = FALSE--------------------------------------------------------------------------------
# load libraries
library("tidyverse")
library("readxl")


## ----open/clean data, message = FALSE, warning = FALSE-----------------------------------------------------------------------
# import data
DF <- read_xlsx(path = "data/metaware_EsData_raw.xlsx",
                sheet = "coding",
                na = c("NA"))

# change ref.type pvc to cvp (for aesthetics)
DF[DF$ref.type == "pvc", ]$ref.type = "cvp"

# delete unnecessary variables
DF <- DF %>% 
  
  # remove reference columns
  select(-ends_with("ref")) %>% 
  
  # remove variables we won't include in any analyses
  select(-c(dv, note, outcome)) %>% 
  
  # convert factors to factors
  mutate(id = as.factor(id),
         published = as.factor(published),
         student = as.factor(student),
         paid = as.factor(paid),
         online = as.factor(online),
         ref.type = as.factor(ref.type))

# create blank columns for effect size and effect size variance
# Note: these pre-exisiting columns are necessary for the 
# Cohen's d functions (defined later) to work
DF$es <- NA
DF$es.var <- NA


## ----define function EsBetwMean----------------------------------------------------------------------------------------------
# formula: Cooper, Hedges, & Valentine, 2009; p. 226
EsBetwMean <- function(n.1, m.1, sd.1, 
                       n.2, m.2, sd.2){
    sd.within <- sqrt((((n.1 - 1) * (sd.1^2)) +
                       ((n.2 - 1) * (sd.2^2))) /
                        (n.1 + n.2 - 2));
    
    es <- (m.1 - m.2) / sd.within;
    return(es)
}


## ----define function EsBetwTval----------------------------------------------------------------------------------------------
# formula: Cooper, Hedges, & Valentine, 2009; p. 228
EsBetwTval <- function(n.1, n.2, tval){
    es <- tval * sqrt((n.1 + n.2) / 
                      (n.1 * n.2));
    return(es)
}


## ----define function EsBetwFval----------------------------------------------------------------------------------------------
# formula: Cooper, Hedges, & Valentine, 2009; p. 228
EsBetwFval <- function(n.1, n.2, fval){
  es <- sqrt((fval * (n.1 + n.2)) / 
             (n.1 * n.2)); 
    return(es)
  }


## ----define function EsBetwPval----------------------------------------------------------------------------------------------
# formula: Cooper, Hedges, & Valentine, 2009; p. 228
EsBetwPval <- function(n.1, n.2, pval){
  # calculate the inverse of the cumulative distribution function of t
  t.inv <- qt(p = (pval / 2), 
              df = (n.1 + n.2 - 2),
              lower.tail = FALSE);
  
  es <- t.inv * sqrt((n.1 + n.2) /
                     (n.1 * n.2));
  return(es)
}


## ----define function EsVarBetw-----------------------------------------------------------------------------------------------
# formula: Cooper, Hedges, & Valentine, 2009; p. 228
EsVarBetw <- function(n.1, n.2, es){       
   es.var <- ((n.1 + n.2) / (n.1 * n.2)) +
             ((es^2) / (2 * (n.1 + n.2)));
   return(es.var)
}


## ----define functions EsBetwCount and EsVarBetwCount-------------------------------------------------------------------------
# cohen's d
EsBetwCount <- function(n.1, n.2, count.1, count.2){
  # calculate odds ratio
  # formula: Borenstein et al. 2011; p. 36; Equation 5.8
  or <- (count.1 * (n.2 - count.2)) / 
        ((n.1 - count.1) * count.2);
  
  # calculate log odds ratio
  # formula: Borenstein et al. 2011; p. 36; Equation 5.9
  log.or = log(or);
  
  # convert log odds ratio to Cohen's d
  # formula: Borenstein et al. 2011; p . 47 Equation 7.1
  es <- log.or * (sqrt(3) / pi);
  return(es)
}

# variance of cohen's d
EsVarBetwCount <- function(n.1, n.2, count.1, count.2){
  # calculate log odds ratio variance
  # formula: Borenstein et al. 2011; p. 36; Equation 5.10
  log.or.var = (1 / count.1) +
               (1 / (n.2 - count.2)) +
               (1 / (n.1 - count.1)) +
               (1 / count.2);
  
  # convert log odds ratio variance to variance of Cohen's d
  # formula: Borenstein et al. 2011; p. 47 Equation 7.2
  es.var = log.or.var * (3 / pi^2);
  return(es.var)
}


## ----b: call functions to calculate d----------------------------------------------------------------------------------------
for (i in 1:nrow(DF)) {
  if (DF$design[i] == "between"){
    
    # call EsBetwMean on cases with between-subject designs and *means*
    if (DF$es.calc[i] == "m_sd") {
      DF$es[i] <- EsBetwMean(n.1 = DF$n.1[i],
                             m.1 = DF$m.1[i],
                             sd.1 = DF$sd.1[i],
                             n.2 = DF$n.2[i],
                             m.2 = DF$m.2[i],
                             sd.2 = DF$sd.2[i]) 
      } 
    # call EsBetwTval on cases with between-subject designs and *t-values*
    if (DF$es.calc[i] == "t") {
      DF$es[i] <- EsBetwTval(n.1 = DF$n.1[i],
                             n.2 = DF$n.2[i],
                             tval = DF$tval[i])
      }
    
    # call EsBetwFval on cases with between-subject designs and *F-values*
    if (DF$es.calc[i] == "f") {
      DF$es[i] <- EsBetwFval(n.1 = DF$n.1[i],
                             n.2 = DF$n.2[i],
                             fval = DF$fval[i])
    }
    
    # call EsBetwPval on cases with between-subject designs and *p-values*
    if (DF$es.calc[i] == "p") {
      DF$es[i] <- EsBetwPval(n.1 = DF$n.1[i],
                             n.2 = DF$n.2[i],
                             pval = DF$pval[i])
    }
    
    # call EsBetwCount and EsVarBetwCount on cases with between-subject designs and *count data*
    if (DF$es.calc[i] == "or") {
      DF$es[i] <- EsBetwCount(n.1 = DF$n.1[i],
                              n.2 = DF$n.2[i],
                              count.1 = DF$count.1[i],
                              count.2 = DF$count.2[i])
      
      DF$es.var[i] <- EsVarBetwCount(n.1 = DF$n.1[i],
                                     n.2 = DF$n.2[i],
                                     count.1 = DF$count.1[i],
                                     count.2 = DF$count.2[i])
    }
    
    # call EsVarBetw on cases with continuous data and a between subject designs
    if (DF$es.calc[i] != "or"){
      DF$es.var[i] <- EsVarBetw(n.1 = DF$n.1[i],
                                n.2 = DF$n.2[i],
                                es = DF$es[i])
    }
    }
}


## ----assumed correlation-----------------------------------------------------------------------------------------------------
# if no correlation is defined, set it at .5
if(!exists("corr")){
  corr <- .5
}


## ----EsWitnMean--------------------------------------------------------------------------------------------------------------
# formula: Cooper, Hedges, & Valentine, 2009; p. 229
# formula for imputing sd.diff:
# http://handbook.cochrane.org/chapter_16/16_4_6_1_mean_differences.htm
EsWitnMean <- function(m.1, sd.1, m.2, sd.2, corr){
  sd.diff <- sqrt((sd.1^2) + (sd.2^2) -
                  (2 * corr * sd.1 * sd.2));
        
  es <- ((m.1 - m.2) / sd.diff) * sqrt(2 * (1- corr));
  return(es)
}


## ----EsWitnTval--------------------------------------------------------------------------------------------------------------
# formula: Cooper, Hedges, & Valentine, 2009; p. 229
EsWitnTval <- function(n.1, tval, corr){
  es <- tval * sqrt((2 * (1 - corr)) / n.1);
  return(es)
}


## ----EsWitnFval--------------------------------------------------------------------------------------------------------------
# formula: Cooper, Hedges, & Valentine, 2009; p. 229
EsWitnFval <- function(n.1, fval, corr){
  es <- sqrt((2 * fval * (1- corr)) / n.1);
  return(es)
}


## ----EsVarWitn---------------------------------------------------------------------------------------------------------------
# formula: Cooper, Hedges, & Valentine, 2009; p. 229
EsVarWitn <- function(n.1, es){
  es.var <- ((1 / n.1) + 
             ((es^2) / (2 * n.1))) *
            2 * (1 - corr);
  return(es.var)
}


## ----w: call functions to calculate d----------------------------------------------------------------------------------------
for (i in 1:nrow(DF)) {
  if (DF$design[i] == "within"){
    
    # call EsWitnMean on cases with within-subject designs and *means*
    if(DF$es.calc[i] == "m_sd") {
      DF$es[i] <- EsWitnMean(m.1 = DF$m.1[i],
                             sd.1 = DF$sd.1[i],
                             m.2 = DF$m.2[i],
                             sd.2 = DF$sd.2[i],
                             corr = corr)
    }
    
    # call EsWitnTval on cases with within-subject designs and *t-values*
    if (DF$es.calc[i] == "t") {
      DF$es[i] <- EsWitnTval(n.1 = DF$n.1[i],
                             tval = DF$tval[i],
                             corr = corr)
  }  
    
    # call EsWitnFval on cases with within-subject designs and *F-values*
    if (DF$es.calc[i] == "f") {
      DF$es[i] <- EsWitnFval(n.1 = DF$n.1[i],
                             fval = DF$fval[i],
                             corr = corr)
    }
    
    # call EsVarWitn on cases with within subject designs
    DF$es.var[i] <- EsVarWitn(n.1 = DF$n.1[i],
                              es = DF$es[i])
    }
  }
  


## ----del var-----------------------------------------------------------------------------------------------------------------
# delete unnecessary variables
rm(corr, i,
   EsBetwFval, EsBetwMean, EsBetwTval,
   EsBetwPval, EsVarBetw, EsVarWitn,
   EsWitnFval, EsWitnMean, EsWitnTval,
   EsBetwCount, EsVarBetwCount)


## ----specify es direction----------------------------------------------------------------------------------------------------
DF <- DF %>% 
  # specify direction of the effect size
  rowwise() %>% 
  mutate(es = if_else(condition = direction == "positive",
                      true = abs(es),
                      false = abs(es) * -1)
         ) %>% 
  ungroup()


## ----------------------------------------------------------------------------------------------------------------------------
DF <- DF %>% 
  select(-c(es.calc : pval))


## ----------------------------------------------------------------------------------------------------------------------------
# import data
DF.surv <- read_csv(file = "data/metaware_SurvData_raw.csv") %>% 
  # remove unnecessary variables
  select(-c(StartDate : UserLanguage),
         -c(hap1_bl1_hap : survey_order),
         -contains("Click"),
         -contains("Submit"),
         -contains("Count")) %>% 
  
  # remove row containing ImportId
  filter(!grepl("ImportId", `1_awr`)) %>% 
  
  # assign participant ids
  mutate(ss = 1 : nrow(.),
         ss = as.character(ss)) %>%  
  
  # select vignettes columns
  select(`1_awr` : `119_opp`, ss) %>% 
  
  # extract key from first row
  mutate_all(~if_else(condition = grepl("#", .),
                      true = substr(x = .,
                                    start = 2,
                                    stop = 9),
                      false = .))

# append first row to column name
## append name
colnames(DF.surv) <- paste(sep = "##",
                           colnames(DF.surv),
                           as.character(unlist(DF.surv[1, ]))
                           )

## remove first row
DF.surv <- DF.surv[-1, ]

## fix ss variable naming
DF.surv <- DF.surv %>% 
  rename("ss" = "ss##1")

# prep dataframe for summary statistics calculation
DF.surv <- DF.surv %>% 
  # pivot longer
  pivot_longer(cols = contains("##"),
               names_to = c("var", "vig"),
               names_sep = "##") %>% 
  
  # extract variable name
  mutate(var = substr(x = var,
                      start = nchar(var) - 2,
                      stop = nchar(var))) %>% 
  
  # pivot wider
  pivot_wider(names_from = var,
              values_from = value) %>% 
  
  # convert columns to correct class
  mutate_at(c("awr", "mot", "opp", "bel", "pre"),
            as.numeric)


## ----------------------------------------------------------------------------------------------------------------------------
surv.sum <- DF.surv %>% 
  group_by(vig) %>% 
  summarise(m.mot = mean(mot, na.rm = T),
            m.opp = mean(opp, na.rm = T),
            m.bel = mean(bel, na.rm = T),
            m.pre = mean(pre, na.rm = T)
            ) %>% 
  ungroup()

rm(DF.surv)


## ----------------------------------------------------------------------------------------------------------------------------
# connect summary data to ES dataframe
DF <- DF %>% 
  # rename vig.1 to vig to enable join
  rename(vig = vig.1) %>% 
  
  # connect summary data to vig.1
  left_join(x = ., 
            y = surv.sum,
            by = "vig") %>% 
  
  # rename vig.1 summary columns
  rename(v1.mot = m.mot, 
         v1.opp = m.opp, 
         v1.bel = m.bel, 
         v1.pre = m.pre) %>% 
  
  # rename vig.2 to vig to prep for join
  rename(vig.1 = vig,
         vig = vig.2) %>% 
  
  # connect summary data to vig.2
  left_join(x = .,
            y = surv.sum,
            by = "vig") %>% 
  
  # rename vig.2 summary columns
  rename(v2.mot = m.mot, 
         v2.opp = m.opp, 
         v2.bel = m.bel, 
         v2.pre = m.pre) %>% 
  ungroup() %>% 
  
  # remove vestigial 
  select(-c(vig.1, vig, v1.mot : v2.pre))

rm(surv.sum)


## ----------------------------------------------------------------------------------------------------------------------------
if(!exists("sens")){
  write.csv(DF, 
            "data/metaware_data_clean.csv", 
            row.names = FALSE)
}

