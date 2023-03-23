# Github repo for demand characteristics quantitative review
- **metaware_manuscript.Rmd**: RMarkdown version of manuscript
- **metaware_manuscript.docx**: Word version of manuscript (knitted from metaware_manuscript.Rmd)
- **r-references.bib**: List of manuscript references
- **metaware_EsProcessing.Rmd**: R code for processing the effect size (metaware_EsData_raw.xlsx) and survey (metaware_SurvData_raw.csv) data. Produces clean copies of the effect size data (metaware_data_clean.csv), survey data (metaware_survey2_clean.csv) and vignette data (metaware_vignette_clean.csv)
- **metaware_EsProcessingSens.Rmd**: R code that runs metaware_EsProcessing.Rmd with different assumed correlations (used for sensitivity analyses in metaware_manuscript.Rmd)
- **README.md**: Readme file

## data folder
- **metaware_csv_codebooks.xlsx**: contains codebooks for every .csv file used in this project
- **metaware_EsData_raw.xlsx**: contains information for record screening and effect size/moderator coding
- **metaware_SurvData_raw.csv**: contains responses to a survey where participants (1) reviewed vignettes from the meta-analysis, and (2) completed a close replication of a demand characteristics study
- **metaware_data_clean.csv**: cleaned data for meta-analysis
- **metaware_survey2_clean.csv**: contains responses to the close replication of a demand characteristic study
- **metaware_vignette_clean.csv**: contains average ratings of motivation, opportunity, and belief for each vignette reviewed in metaware_SurvData_raw.csv

### r_sensitivity folder
Contains copies of metaware_data_clean.csv where different correlations were assumed. File name convention is "metaware_data_clean_r" + assumed correlation + ".csv"

## metaware_manuscript_files folder
Contains a variety of images that are auto-saved when metaware_manuscript.Rmd is knitted.

## images folder
- **metaware_figures.drawio**: Drawio program file used to create a few manuscript figures (described below)
- **metaware_framework.png**: Image showing frameworks for conceptualizing demand effects
- **metaware_mods.pn**g: Image showing how motivation, opportunity, and belief scores were summed
- **metaware_vigs.png**: Image showing how vignettes were created

## admin folder
Contains various files used for project admin

### irb folder
- **metaware22a_IRBApproval.pdf**: Copy of IRB approval notice
- **metaware22a_eprotocol.docx**: Copy of document submitted to IRB
- **metaware22a_Debriefing.docx**: Copy of debriefing form submitted to IRB
- **metaware22a_ResearchInformationSheet.docx**: Copy of Research Information Sheet (i.e,. consent form) submitted to IRB
- **metaware22a_scenarios.csv**: Copy of vignettes provided to IRB
- **metaware22a_Survey.pdf**: Copy of survey provided to IRB

### prereg folder
Contains copies of pre-registered analysis plan in .docx and .pdf format

### survey folder
Contains copy of vignette survey and replication of demand study in .docx and .qsf (Qualtrics) format

### unpublished data folder
Contains copies of files that we used to extract unpublished information about effect sizes.

### vig folder
- **metaware_CombineVigs.Rmd**: File used to combine information about vignettes into a single csv (metaware_VigCombined.csv)
- **metaware_VigCombined.csv**: Contains vignette information used in the survey

##### vignettes subfolder
Contains a text file for each study, which contains the information needed to make the vignettes. 
- Title = title of study
- Developed by = initials of person who created first draft of file 
- Checked by = initials of person who checked the file
- Details = place where notes about the study details were kept 
- Non-control demand levels: Descriptions of all non-control levels of the demand characteristic manipulations
- Fake demand scenarios = list of fake demand scenarios used as an attention check in the survey
- Procedure = notes about the study procedure
- DVs = list of dependent variables coded
- Vignettes = Following each line starting with a #, a vignette describing the key details of the condition
