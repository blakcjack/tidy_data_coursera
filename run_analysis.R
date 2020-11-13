# This script is used to generate the tidy data based on tidy data coursera task
# This script will run some tasks in order to generate the tidy data.

# First we will load some libraries needed
# Since the course didn't specify the library used, we can use any favorite library to work with
# Here I use tidyverse approach and all the libraries coressponding to it to get the tidy data.
library(dplyr)
library(lubridate)
library(zip)
library(reshape2)

# put the file url here
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Download the file
# Check the existence of the file first
if (!file.exists("./getdata_projectfiles_UCI HAR Dataset.zip")) {
  download.file(fileUrl, "./getdata_projectfiles_UCI HAR Dataset.zip")
}

# Extract the file
# Check if the extracted file exist
if (!dir.exists("./UCI HAR Dataset")){
  unzip("./getdata_projectfiles_UCI HAR Dataset.zip")
}

# read the main files for train and test files
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# Get the features label
feature_labels <- read.table("./UCI HAR Dataset/features.txt")

# Get the activity labels
act_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

# merging data set
df_x <- rbind(x_train, x_test)
df_y <- rbind(y_train, y_test)
df_subject <- rbind(subject_train, subject_test)

# assigning variables names to corresponding data set
act_labels <- setNames(act_labels, c("activityid", "activityname"))
df_x <- setNames(df_x, feature_labels$V2)
df_y <- setNames(df_y, "activityid")
subject <- setNames(df_subject, "subject")

# get only features with measurement of mean and standard deviation
df_x_subset <- df_x[,grep("mean|std", names(df_x))]

# use descriptive activity name
df_y <- df_y %>% merge(act_labels, by = "activityid", sort = FALSE)

# generating single unified dataset
df_all <- cbind(subject, df_y, df_x_subset)

# Since we need to measure the mean of each variable for each activity and each subject,
# then we need to change those measure as rows and treat it as observations
# instead of columns and treat it as features
df_all_melted <- melt(df_all, id.vars = names(df_all[,1:3]), measure.vars = names(df_all[,4:ncol(df_all)]))

# based on the unified data, generate independent tidy data set
# with the average of each variable for each activity and subject
# the tidy data set has independent column for corresponding observations
df_tidy <- df_all_melted %>% 
  dcast(subject + activityname ~ variable, mean)

# create the text file to be uploaded
write.table(df_tidy, "./tidy_data_human_activity_recognition.txt", row.names = FALSE)
