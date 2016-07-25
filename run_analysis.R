###############################################################################
# Script to process data as per the instructions of the Getting and Cleaning
# Data Coursera assignment.
###############################################################################
# The numbers in the comments refer to the steps in the assignment instructions.
# Note that instructions steps 3 and 4 are carried out in reverse order to
# help with readability. This does not affect the final outcome.
###############################################################################

library(dplyr)

###
# 1. Merge the training and test data sets to create one data set

# a. Read in the datasets
xtest <- read.table("UCI_HAR_Dataset/test/X_test.txt")
ytest <- read.table("UCI_HAR_Dataset/test/y_test.txt")
subjecttest <- read.table("UCI_HAR_Dataset/test/subject_test.txt")
xtrain <- read.table("UCI_HAR_Dataset/train/X_train.txt")
ytrain <- read.table("UCI_HAR_Dataset/train/y_train.txt")
subjecttrain <- read.table("UCI_HAR_Dataset/train/subject_train.txt")

# b. And the list of variable names which we will need later
variables <- read.table("UCI_HAR_Dataset/features.txt")

# c. Combine the datasets into one dataset called alldata
testdata <- cbind(xtest, subjecttest, ytest)
traindata <- cbind(xtrain, subjecttrain, ytrain)
alldata <- rbind(testdata, traindata)

###
# 2. Extract only mean and standard deviation (std) measurements

# a. Work out which variable IDs are for mean or std measurements
meanstd <- grep("[Mm]ean|std", variables[, 2])
# b. Extract the approprate columns from alldata (alldata contains 563
# variables so the subject and activity data is in columns 562 and 563)
alldata <- alldata[, c(meanstd, 562:563)]

###
# 4. Appropriately label the data set with descriptive variable names
#  Note - this step is done prior to step 3 as listed in the assignment in
#  order to use the variable names in step 3 for readability

# a. Extract the appropriate variable names from features.txt
columnnames <- as.character(variables[meanstd, 2])

# b. Remove the parentheses, commas and hyphens from the variable names so that
# we are left with clean, alphanumeric variable names
columnnames <- gsub("\\(|\\)|,|-", "", columnnames)

# c. Label the dataset with these variable names and include names for the
# subject ID and activity variables
names(alldata) <- c(columnnames, "subjectID", "activity")

###
# 3. Apply descriptive activity names

# a. Extract a dataset for each activity and apply the descriptive name
walking <- filter(alldata, activity == 1) %>%
    mutate(activity = "walking")
walkingup <- filter(alldata, activity == 2) %>%
    mutate(activity = "walkingUp")
walkingdown <- filter(alldata, activity == 3) %>%
    mutate(activity = "walkingDown")
sitting <- filter(alldata, activity == 4) %>%
    mutate(activity = "sitting")
standing <- filter(alldata, activity == 5) %>%
    mutate(activity = "standing")
laying <- filter(alldata, activity == 6) %>%
    mutate(activity = "laying")

# b. Combine the activity datasets back into a single dataset
alldata <- rbind(walking, walkingup, walkingdown, sitting, standing, laying)

###
# 5. Create a 2nd tidy data set with the average of each variable for each
# activity and each subject

# a. Group the data by activity and subject
groupeddata <- group_by(alldata, activity, subjectID)

# b. Create the required data set
finaldata <- summarise(groupeddata,
                       tBodyAccmeanX = mean(tBodyAccmeanX),
                       tBodyAccmeanY = mean(tBodyAccmeanY),
                       tBodyAccmeanZ = mean(tBodyAccmeanZ),
                       tBodyAccstdX = mean(tBodyAccstdX),
                       tBodyAccstdY = mean(tBodyAccstdY),
                       tBodyAccstdZ = mean(tBodyAccstdZ),
                       tGravityAccmeanX = mean(tGravityAccmeanX),
                       tGravityAccmeanY = mean(tGravityAccmeanY),
                       tGravityAccmeanZ = mean(tGravityAccmeanZ),
                       tGravityAccstdX = mean(tGravityAccstdX),
                       tGravityAccstdY = mean(tGravityAccstdY),
                       tGravityAccstdZ = mean(tGravityAccstdZ),
                       tBodyAccJerkmeanX = mean(tBodyAccJerkmeanX),
                       tBodyAccJerkmeanY = mean(tBodyAccJerkmeanY),
                       tBodyAccJerkmeanZ = mean(tBodyAccJerkmeanZ),
                       tBodyAccJerkstdX = mean(tBodyAccJerkstdX),
                       tBodyAccJerkstdY = mean(tBodyAccJerkstdY),
                       tBodyAccJerkstdZ = mean(tBodyAccJerkstdZ),
                       tBodyGyromeanX = mean(tBodyGyromeanX),
                       tBodyGyromeanY = mean(tBodyGyromeanY),
                       tBodyGyromeanZ = mean(tBodyGyromeanZ),
                       tBodyGyrostdX = mean(tBodyGyrostdX),
                       tBodyGyrostdY = mean(tBodyGyrostdY),
                       tBodyGyrostdZ = mean(tBodyGyrostdZ),
                       tBodyGyroJerkmeanX = mean(tBodyGyroJerkmeanX),
                       tBodyGyroJerkmeanY = mean(tBodyGyroJerkmeanY),
                       tBodyGyroJerkmeanZ = mean(tBodyGyroJerkmeanZ),
                       tBodyGyroJerkstdX = mean(tBodyGyroJerkstdX),
                       tBodyGyroJerkstdY = mean(tBodyGyroJerkstdY),
                       tBodyGyroJerkstdZ = mean(tBodyGyroJerkstdZ),
                       tBodyAccMagmean = mean(tBodyAccMagmean),
                       tBodyAccMagstd = mean(tBodyAccMagstd),
                       tGravityAccMagmean = mean(tGravityAccMagmean),
                       tGravityAccMagstd = mean(tGravityAccMagstd),
                       tBodyAccJerkMagmean = mean(tBodyAccJerkMagmean),
                       tBodyAccJerkMagstd = mean(tBodyAccJerkMagstd),
                       tBodyGyroMagmean = mean(tBodyGyroMagmean),
                       tBodyGyroMagstd = mean(tBodyGyroMagstd),
                       tBodyGyroJerkMagmean = mean(tBodyGyroJerkMagmean),
                       tBodyGyroJerkMagstd = mean(tBodyGyroJerkMagstd),
                       fBodyAccmeanX = mean(fBodyAccmeanX),
                       fBodyAccmeanY = mean(fBodyAccmeanY),
                       fBodyAccmeanZ = mean(fBodyAccmeanZ),
                       fBodyAccstdX = mean(fBodyAccstdX),
                       fBodyAccstdY = mean(fBodyAccstdY),
                       fBodyAccstdZ = mean(fBodyAccstdZ),
                       fBodyAccmeanFreqX = mean(fBodyAccmeanFreqX),
                       fBodyAccmeanFreqY = mean(fBodyAccmeanFreqY),
                       fBodyAccmeanFreqZ = mean(fBodyAccmeanFreqZ),
                       fBodyAccJerkmeanX = mean(fBodyAccJerkmeanX),
                       fBodyAccJerkmeanY = mean(fBodyAccJerkmeanY),
                       fBodyAccJerkmeanZ = mean(fBodyAccJerkmeanZ),
                       fBodyAccJerkstdX = mean(fBodyAccJerkstdX),
                       fBodyAccJerkstdY = mean(fBodyAccJerkstdY),
                       fBodyAccJerkstdZ = mean(fBodyAccJerkstdZ),
                       fBodyAccJerkmeanFreqX = mean(fBodyAccJerkmeanFreqX),
                       fBodyAccJerkmeanFreqY = mean(fBodyAccJerkmeanFreqY),
                       fBodyAccJerkmeanFreqZ = mean(fBodyAccJerkmeanFreqZ),
                       fBodyGyromeanX = mean(fBodyGyromeanX),
                       fBodyGyromeanY = mean(fBodyGyromeanY),
                       fBodyGyromeanZ = mean(fBodyGyromeanZ),
                       fBodyGyrostdX = mean(fBodyGyrostdX),
                       fBodyGyrostdY = mean(fBodyGyrostdY),
                       fBodyGyrostdZ = mean(fBodyGyrostdZ),
                       fBodyGyromeanFreqX = mean(fBodyGyromeanFreqX),
                       fBodyGyromeanFreqY = mean(fBodyGyromeanFreqY),
                       fBodyGyromeanFreqZ = mean(fBodyGyromeanFreqZ),
                       fBodyAccMagmean = mean(fBodyAccMagmean),
                       fBodyAccMagstd = mean(fBodyAccMagstd),
                       fBodyAccMagmeanFreq = mean(fBodyAccMagmeanFreq),
                       fBodyBodyAccJerkMagmean = mean(fBodyBodyAccJerkMagmean),
                       fBodyBodyAccJerkMagstd = mean(fBodyBodyAccJerkMagstd),
                       fBodyBodyAccJerkMagmeanFreq = mean(fBodyBodyAccJerkMagmeanFreq),
                       fBodyBodyGyroMagmean = mean(fBodyBodyGyroMagmean),
                       fBodyBodyGyroMagstd = mean(fBodyBodyGyroMagstd),
                       fBodyBodyGyroMagmeanFreq = mean(fBodyBodyGyroMagmeanFreq),
                       fBodyBodyGyroJerkMagmean = mean(fBodyBodyGyroJerkMagmean),
                       fBodyBodyGyroJerkMagstd = mean(fBodyBodyGyroJerkMagstd),
                       fBodyBodyGyroJerkMagmeanFreq = mean(fBodyBodyGyroJerkMagmeanFreq),
                       angletBodyAccMeangravity = mean(angletBodyAccMeangravity),
                       angletBodyAccJerkMeangravityMean = mean(angletBodyAccJerkMeangravityMean),
                       angletBodyGyroMeangravityMean = mean(angletBodyGyroMeangravityMean),
                       angletBodyGyroJerkMeangravityMean = mean(angletBodyGyroJerkMeangravityMean),
                       angleXgravityMean = mean(angleXgravityMean),
                       angleYgravityMean = mean(angleYgravityMean),
                       angleZgravityMean = mean(angleZgravityMean))

# c. Write the final data set to the file finaldata.txt
write.table(finaldata, file = "finaldata.txt", row.names = FALSE)

#####
# END
#####