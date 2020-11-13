# Tidy Data Analysis

In this repository you will find a way to perform cleaning data to get tidy data. This project is done based on Getting and Cleaning Data hold by Jhon Hopkins University x Coursera.

In order to get the tidy data, the run_analysis script did as follow.

      1. Import the data set into our environment
      2. Merging the data sets in order to generate 1 unified data sets
      3. Extracts only the measurements on the mean and standard deviation for each measurement.
      4. Uses descriptive activity names to name the activities in the data set
      5. Appropriately labels the data set with descriptive variable names
      6. From the data set generated from step 5, create a second, independent tidy data set with  the average of each variable for each activity and subject.

## How it works?

In order to get the tidy data, the script do as follow:

1. Download the data set available for the task in "<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>" using `download.file()` function and then put it inside the root of the project.

2. Exctract the file using the `zip()` function to extract the corresponding file in the project directory.

3. Using the `read.table()` to read each corresponding file.

4. Generate train and test data set by merging subject_train, y_train, and X_train and merging subject_test, y_test and X_test accordingly using `cbind()`

5. Generate single unified data set by merging train and test data set using `rbind()`.

6. Assign the descriptive variables name to activity, x data frame, and y data frame.

7. Get only features with measurements mean and standard deviation by using `grep()`.

8. Assign descriptive activity name.

9. Apply melt and dcast transformation to summarize the data into it's mean for each subject, variable, and activity.

9. generate another independent tidy data set named `tidy_data_human_activity_recognition.txt`  with  the average of each variable for each activity and subject.