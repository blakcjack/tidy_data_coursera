# CODEBOOK

**SOURCE & REFERENCE** <a name="source"></a>
======================

The source of the data set and basic reference can be found in [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

**VARIABLES USED**
==================

The variables used for this data set originally comes from the accelerometer and gyroscope 3-axial signals tAcc-XYZ and tGyro-XYZ as stated in the original data set description. For complete and detailed information about the variables, can be found at the source website attached in [source and reference section](#source).

Importantly to note that all the variables used had been normalized.

These signals were used to estimate variables of the variable vector for each pattern: '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ

tGravityAcc-XYZ

tBodyAccJerk-XYZ

tBodyGyro-XYZ

tBodyGyroJerk-XYZ

tBodyAccMag

tGravityAccMag

tBodyAccJerkMag

tBodyGyroMag

tBodyGyroJerkMag

fBodyAcc-XYZ

fBodyAccJerk-XYZ

fBodyGyro-XYZ

fBodyAccMag

fBodyAccJerkMag

fBodyGyroMag

fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value

std(): Standard deviation

**TRANSFORMATIONS**
===================

In order to get the final variables used in this tidy data from the corresponding source data, some transformations are importantly needed. To get the final data below steps are applied.

- Merge all data set as explained in the readme section.

- We need to assign the descriptive name to the features variable and meaningful activity as the activity labels.

- Get the variables that indicates the mean and standard deviation. It is named contains mean and std so we can use grep to take them out.

- Since we need the data of the mean per subject per variable, and activity, then we need to melt the data set to change the variables to be the column using `melt()` function.

- After we have each subject, activity and features as observations, we can take the mean for each of them by using `dcast()` function.

- Save the data as the tidy data set.