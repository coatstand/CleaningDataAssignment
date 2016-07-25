# CleaningDataAssignment

This repo contains my submission for the Cousera "Getting and Cleaning Data" course assignment.

## Files
* README.md
* codebook.md: Explains the data processing done and variables included in the resulting data file
* run_analysis.R: The script that performs the data processing described in codebook.md and creates the resulting data file.

## Creating the tidy data file
To create the data file:

1. Download and extract the data https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip [1]
2. Rename the "UCI HAR Dataset" directory to "UCI_HAR_Dataset"
3. Download the run_analysis.R file from this repository and save in the same directory as the "UCI_HAR_Dataset" directory
4. Run the run_analysis.R script
5. The new tidy data file will be created as "finaldata.txt"

## Reading in the data file
If the data file is stored in your working directory, it can be read in to R using the code:

`data <- read.table("finaldata.txt", header = TRUE)`

## References
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012