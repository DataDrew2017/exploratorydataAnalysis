# exploratorydataAnalysis

### Introduction
First, the test set is read in where an observation is the results for a volunteer id (1-30)-activity (1-6) combination. The volunteer id and activity are in separate files and thus must also be read in and then column binded to the results, ultimately resulting in the test  data frame. This process is repeated for the train set, ultimately resulting in the train data frame. run_analysis.R then does the following five assignment requirements in nonsequential order, but rather ordered 1, 4, 3, 2, and 5.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Each assignment requirement is desribed in greater detail below.

### Requirement 1:
mergeddataset created by binding rows of test and train data frames.

### Requirement 4:
header vector is read and transformed, then volunteer_id and activity are appended to the beginning. It's then row bounded to mergeddataset and the header in row 1 is used to rename variables - result is completedata data frame.

### Requirement 3:
Factors values assigned to completedata$activity.

### Requirement 2:
First checks for any rows with missing data. Values in all columns other than columns 1 and 2 are converted to numeric values to enable requested computations. meanvals and sdvals computed using sapply, followed by the two being row bound for the mean_stdDev data frame.

### Requirement 5:
completedata$volunteer_id converted to numeric values before grouping by both volunteer_id and activity. summarize_each used to create groupedmeans data frame.

Finally, the resulting tidy dataset from requirement 5 is written to a text file for upload and all variables created in the interim for requirements 4, 2, and 5 are then dropped from the global environemnt, leaving only the following data frames: completedata, mean_stdDev, and groupmeans in the global environment.
