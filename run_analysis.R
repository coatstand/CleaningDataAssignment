###############################################################################
# Script to process data as per the instructions of the Getting and Cleaning
# Data Coursera assignment.
###############################################################################
# The numbers in the comments refer to the steps in the assignment instructions.
# Note that instructions steps 3 and 4 are carried out in reverse order to
# help with readability. This does not affect the final outcome.
###############################################################################
# The output of this script is:
# A file "finaldata.txt" written to the working directory
# The following data objects:
# * finaldata = Means of each mean and standard deviation variable for each
#       subject and activity
# * alldata = Each record for the mean and standard deviation variables
# * groupeddata = alldata grouped by activity and subjectID
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

# b. Also read in the list of variable names and activity definitions which we
# will need later
variables <- read.table("UCI_HAR_Dataset/features.txt")
activities <- read.table("UCI_HAR_Dataset/activity_labels.txt")

# c. Combine the datasets into one dataset called alldata
testdata <- cbind(xtest, subjecttest, ytest)
traindata <- cbind(xtrain, subjecttrain, ytrain)
alldata <- rbind(testdata, traindata)

# d. Remove the objects no longer needed
rm(list = c("xtest", "subjecttest", "ytest", "xtrain", "subjecttrain", "ytrain",
            "testdata", "traindata"))

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

# d. Remove objects no longer needed
rm(list = c("columnnames", "variables", "meanstd"))

###
# 3. Apply descriptive activity names using factors

# a. Turn the activity column into a factor with levels and labels:
alldata$activity <- factor(alldata$activity, levels = activities[, 1],
                              labels = activities[, 2])

# b. Remove activities as no longer needed
rm(activities)

###
# 5. Create a 2nd tidy data set with the average of each variable for each
# activity and each subject

# a. Group the data by activity and subject
groupeddata <- group_by(alldata, activity, subjectID)

# b. Create the required data set
finaldata <- summarise_each(groupeddata, funs(mean))

# c. Write the final data set to the file finaldata.txt
write.table(finaldata, file = "finaldata.txt", row.names = FALSE)

#####
# END
#####