# Codebook for Getting and Cleaning Data Assignment

## Introduction
This project uses the data "Human Activity Recognition Using Smartphones Dataset Version 1.0" [1], which is available at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip . A full description is available at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

## Experiment
For full details, see above link or README.txt file within above zip file.

In summary, the data was collected from a group of 30 volunteers who performed 6 activities while wearing a smartphone on their waist. Using the phone's embedded accelerometer and gyroscope, acceleration and angular velocity data was captured.

## Data
Full details of the data in the original data set are included in the following files that can be found in the .zip file linked to above:
* README.txt
* features_info.txt
* features.

In summary,  the original data set contains over 500 variables ("features") that describe the data captured from the phone's accelerometer and gyroscope.

The additional data processing done in this project creates a new tidy dataset that describes the average of each mean and standard deviation variable from the original data set for each unique combination of activity and subject.

The data is tidy as:
* Each variable forms a column (see Variables section below for details) 
* Each observation forms a row (an observation being a unique combination of subject and activity)
* It is a single table for this observational unit

## Data Processing done in run_analysis.R
* The original data had been split into a test and training data set. Also each data set contained three files - one for the "feature" data, one for the subject ID and one for the activity (recorded by an ID number from 1 - 6). The first step was to combine all data sets into one.
* For this project, we were only interested in the measurements that were a mean or standard deviation so all variable names that contained any of "Mean", "mean" or "std" were extracted.
* The resulting columns were then named using the variable names provided in the original dataset where appropriate. However, these variable names were cleaned up by removing the non-alphanumeric characters.
* For the activity variable to be more easily understood, the activity IDs were replaced by activity descriptions as follows:
 * 1 = walking
 * 2 = walkingUp
 * 3 = walkingDown
 * 4 = sitting
 * 5 = standing
 * 6 = laying
* In order to create the final tidy data set, the resulting data was grouped by activity and subject then the mean of each variable calculated for each activity and subject grouping
* Finally, the resulting data set is output to the file "finaldata.txt"

## Variables

*activity*
* Describes the activity that the subject was performing. 
* The 6 activies were:
 * walking
 * walkingUp (walking upstairs)
 * walkingDown (walking downstairs)
 * sitting
 * standing
 * laying
    
*subjectID*
* The unique ID of the experiment volunteer.
* There were 30 volunteers and the subjectIDs take the values 1 - 30.
    
### Notes on following variables
#### Names
The names of the following varibles are taken from the original dataset and use the following nomenclature (see features_info.txt within the above .zip file for further details):
* prefix 't' - time domain signals
* prefix 'f' - frequency domain signals (produced using a Fast Fourier Transform to some signals)
* 'Body' - body signals
* 'Gravity' - gravity signals
* 'Acc' - acceleration signals
* 'Gyro' - gyroscopic signals
* 'Jerk' - Jerk signals obtained from acceleration and angular velocity
* 'Mag' - magnitude of the signals calculated using the Euclidean norm
* 'Freq' - frequency
* 'std' - standard deviation
* '-XYZ' - the 3-axial signals in the X, Y and Z directions

#### Values
In the original data set, there were a number of observations recorded for each subject while performing each activity. In the original dataset, the values had been normalised and bounded within [-1,1].  The following variables available in this data set record the average value for each unique subject and activity combination.

*tBodyAccmeanX
\n tBodyAccmeanY
tBodyAccmeanZ
tBodyAccstdX
tBodyAccstdY
tBodyAccstdZ
tGravityAccmeanX
tGravityAccmeanY
tGravityAccmeanZ
tGravityAccstdX
tGravityAccstdY
tGravityAccstdZ
tBodyAccJerkmeanX
tBodyAccJerkmeanY
tBodyAccJerkmeanZ
tBodyAccJerkstdX
tBodyAccJerkstdY
tBodyAccJerkstdZ
tBodyGyromeanX
tBodyGyromeanY
tBodyGyromeanZ
tBodyGyrostdX
tBodyGyrostdY
tBodyGyrostdZ
tBodyGyroJerkmeanX
tBodyGyroJerkmeanY
tBodyGyroJerkmeanZ
tBodyGyroJerkstdX
tBodyGyroJerkstdY
tBodyGyroJerkstdZ
tBodyAccMagmean
tBodyAccMagstd
tGravityAccMagmean
tGravityAccMagstd
tBodyAccJerkMagmean
tBodyAccJerkMagstd
tBodyGyroMagmean
tBodyGyroMagstd
tBodyGyroJerkMagmean
tBodyGyroJerkMagstd
fBodyAccmeanX
fBodyAccmeanY
fBodyAccmeanZ
fBodyAccstdX
fBodyAccstdY
fBodyAccstdZ
fBodyAccmeanFreqX
fBodyAccmeanFreqY
fBodyAccmeanFreqZ
fBodyAccJerkmeanX
fBodyAccJerkmeanY
fBodyAccJerkmeanZ
fBodyAccJerkstdX
fBodyAccJerkstdY
fBodyAccJerkstdZ
fBodyAccJerkmeanFreqX
fBodyAccJerkmeanFreqY
fBodyAccJerkmeanFreqZ
fBodyGyromeanX
fBodyGyromeanY
fBodyGyromeanZ
fBodyGyrostdX
fBodyGyrostdY
fBodyGyrostdZ
fBodyGyromeanFreqX
fBodyGyromeanFreqY
fBodyGyromeanFreqZ
fBodyAccMagmean
fBodyAccMagstd
fBodyAccMagmeanFreq
fBodyBodyAccJerkMagmean
fBodyBodyAccJerkMagstd
fBodyBodyAccJerkMagmeanFreq
fBodyBodyGyroMagmean
fBodyBodyGyroMagstd
fBodyBodyGyroMagmeanFreq
fBodyBodyGyroJerkMagmean
fBodyBodyGyroJerkMagstd
fBodyBodyGyroJerkMagmeanFreq
angletBodyAccMeangravity
angletBodyAccJerkMeangravityMean
angletBodyGyroMeangravityMean
angletBodyGyroJerkMeangravityMean
angleXgravityMean
angleYgravityMean
angleZgravityMean*

## References
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012