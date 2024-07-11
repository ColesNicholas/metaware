# Github repo for demand characteristics quantitative review
- **metaware_manuscript.Rmd**: RMarkdown version of manuscript
- **metaware_manuscript.docx**: Word version of manuscript (knitted from metaware_manuscript.Rmd)
- **r-references.bib**: List of manuscript references
- **metaware_DataProcessing.Rmd**: R code for processing the effect size (metaware_EsData_raw.xlsx) and survey (metaware_SurvData_raw.csv) data. Produces clean copies of the effect size data (metaware_meta_clean.csv) and replication study data (metaware_replication_clean.csv) and vignette data (metaware_vignette_clean.csv). Also exports vignette-specific averages of participant ratings (surv.sum.csv) and aggregated estimates of the reliability of these ratings (vig.surv1.rel.rds and vis.gusrfull.el.rds)
- **metaware_DataProcessingSens.Rmd**: R code that runs metaware_EsProcessing.Rmd with different assumed correlations (used for sensitivity analyses in metaware_manuscript.Rmd)
- **metaware_FileOrganizationHelper.png**: Image explaining how the most essential files interface in order to create the final manuscript
- **README.md**: Readme file
- **sessionInfo.txt**: sessionInfo for the R code used in the project

## data folder
- **metaware_csv_codebooks.xlsx**: contains codebooks for every major .csv file used in this project
- **metaware_EsData_raw.xlsx**: contains information for record screening, effect size/moderator, and quality coding
- **metaware_SurvData_raw.csv**: contains responses to a survey where participants (1) reviewed vignettes from the meta-analysis, and (2) completed a close replication of a demand characteristics study
- **metaware_SurvData2_raw.csv**: contains responses to a follow-up survey where participants reviewed vignettes from the meta-analysis
- **metaware_meta_clean.csv**: cleaned data for meta-analysis
- **metaware_replication_clean.csv**: contains responses to the close replication of a demand characteristic study

### r_sensitivity folder
Contains copies of metaware_data_clean.csv where different correlations were assumed. File name convention is "metaware_metaa_clean_r" + assumed correlation + ".csv"

## metaware_manuscript_files folder
Contains a variety of images that are auto-saved when metaware_manuscript.Rmd is knitted.

## images folder
- **metaware_figures.drawio**: Drawio program file used to create a couple manuscript figures (described below)
- **metaware_PRISMA.png** PRISMA flowchart showing literature search details
- **metaware_vigs.png**: Image showing how vignettes were created
- **PRISMA.R** R file used to compile information for the PRISMA flowchart

## output folder
Contains a few pieces of useful output
-**surv.sum.csv**: vignette-specific (vig) averages of the extent to which participants correctly identified the communicated hypothesis (m.att), indicated that they would be motivated (m.mot) and able (m.opp) to adjust responses, believed the hypothesized effect would occur (m.bel), and predicted that other participants would respond to the demand cues  (m.pre)
-**vig.surv1.rel.rds**: List of intraclass correlation values for participant ratings of the extent to which they would be motivated (mot) and able (opp) to adjust responses, believed the hypothesized effect would occur (bel), and predicted that other participants would respond to the demand cues (pre). Values are only for participants who completed the first wave of data collection
-**vig.survfull.rel.rds**: Similar file to vig.surv1.rel.rds -- except it includes data from all participants

## admin folder
Contains various files used for project admin

### irb folder
- **metaware22a_IRBApproval.pdf**: Copy of IRB approval notice for studies 2 and 3
- **metaware22a_eprotocol.docx**: Copy of document submitted to IRB for studies 2 and 3
- **metaware22a_Debriefing.docx**: Copy of debriefing form submitted to IRB for studies 2 and 3
- **metaware22a_ResearchInformationSheet.docx**: Copy of Research Information Sheet (i.e,. consent form) submitted to IRB for studies 2 and 3
- **metaware22a_scenarios.csv**: Copy of vignettes provided to IRB
- **metaware22a_Survey.pdf**: Copy of survey provided to IRB

### prereg folder
Contains copies of pre-registered analysis plan in .docx and .pdf format

### search_details
- **metaware_OriginalSearch.xls**: exported results for original literature search
- **metaware_EsData_raw_041724.xlsx**: backup of the raw meta-analysis data from 041724 -- i.e., before an expanded search was performed based on reviewer feedback. This file contains a number of errors that were later fixed (e.g., lack of screening labels), but is retained for record keeping.
- **metaware_ExpandedSearch_OldTerms_041724.xls**: exported results from expanded literature search, using the same terms as the original literature search
- **metaware_ExpandedSearch_OldTerms_041724.xls**: exported results from expanded literature search, using the same terms as the original literature search
- **metaware_ExpandedSearch_NewTerms_041724.xls**: exported results from expanded literature search, using a new set of search terms
- **metaware_EsData_raw_updated.csv**: Updated literature search results. After extensive screening and coding, this file eventually becomes metaware_ESData.raw.xlsx (located in the data folder)

### survey folder
Contains copy of vignette survey and replication of demand study in .docx and .qsf (Qualtrics) format.
- **metaware_survey1**: original survey where participants (1) reviewed vignettes from the meta-analysis, and (2) completed a close replication of a demand characteristics study
- **metaware_survey2**: follow-up survey with an additional set of participants who only reviewed vignettes from the meta-analysis

### unpublished data folder
Contains a list of files that we used to extract unpublished information about effect sizes. List may be somewhat incomplete due to substandard file management, but we organized what we could find

### vig folder
- **metaware_CombineVigs.Rmd**: File used to combine information about vignettes into a single csv (metaware_VigCombined.csv)
- **metaware_VigCombined.csv**: Contains vignette information used in the survey
- **metaware_AssessVigProgress.Rmd**: File used to plan sample size for second wave of vignette data collection

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
