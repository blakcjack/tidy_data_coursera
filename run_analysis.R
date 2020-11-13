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
df_train <- cbind(subject_train, y_train, x_train)
df_test <- cbind(subject_test, y_test, x_test)

# generating single unified dataset
df_all <- rbind(df_train, df_test)


# assigning variables names to corresponding data set
act_labels <- setNames(act_labels, c("activityid", "activityname"))
df_all <- setNames(df_all, c("subject", "activityid", as.character(feature_labels$V2)))

# get only features with measurement of mean and standard deviation
df_all_subset <- df_all[,c("subject", "activityid",grep("mean|std", names(df_all), value = TRUE))]

# give the descriptive activity labels
df_all_subset <- df_all_subset %>% 
  merge(act_labels, by ="activityid", sort = FALSE) %>% 
  select(subject, activityid, activityname, names(df_all_subset)[4]:names(df_all_subset)[ncol(df_all_subset)])

# Since we need to measure the mean of each variable for each activity and each subject,
# then we need to change those measure as rows and treat it as observations
# instead of columns and treat it as features
df_all_melted <- melt(df_all_subset, id.vars = names(df_all_subset[,1:3]), measure.vars = names(df_all_subset[,4:ncol(df_all_subset)]))

# based on the unified data, generate independent tidy data set
# with the average of each variable for each activity and subject
# the tidy data set has independent column for corresponding observations
df_tidy <- df_all_melted %>% 
  dcast(subject + activityname ~ variable, mean)

# create the text file to be uploaded
write.table(df_tidy, "./tidy_data_human_activity_recognition.txt", row.names = FALSE)
