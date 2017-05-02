## Read and combine test data
# test data of 561 attributes
testset <- read.table("UCI HAR Dataset/test/X_test.txt")
# y_test = corresponding activity of 6
testactivity <- read.table("UCI HAR Dataset/test/y_test.txt")
# subject_test = corresponding volunteer id of 30
test_id <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(test_id, testactivity, testset)

## Read and combine train data
# train data of 561 attributes
trainset <- read.table("UCI HAR Dataset/train/X_train.txt")
# y_train = corresponding activity of 6
trainactivity <- read.table("UCI HAR Dataset/train/y_train.txt")
# subject_train = corresponding volunteer id of 30
train_id <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(train_id, trainactivity, trainset)

## Requirement 1 - "Merges the training and the test sets to create one data set."
mergeddataset <- rbind(test, train)

## Requirement 4 - "Appropriately labels the data set with descriptive variable names."
header <- t(read.table("UCI HAR Dataset/features.txt"))
# Second row contains character values of variable names
header <- header[2,]
# Add volunteer_id and activity to header since corresponding columns previously added to dataset
header <- c("volunteer_id", "activity", header)
# Bind variable names to respective columns, assign first row as header, then drop first row
completedata <- rbind(header, mergeddataset)
colnames(completedata) = completedata[1, ]
completedata = completedata[-1, ]

## Requirement 3 - "Uses descriptive activity names to name the activities in the data set."
completedata$activity <- as.factor(completedata$activity)
levels(completedata$activity) <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")

## Requirement 2 - "Extracts only the measurements on the mean and standard deviation for each measurement."
# Check for missing values
sum(!complete.cases(completedata))
# Convert values in columns 3 onwards to numeric to allow computations
completedata[ ,3:563] <- as.numeric(as.matrix(completedata[ ,3:563]))
meanvals <- sapply(completedata[ ,3:563], mean)
sdvals <- sapply(completedata[ ,3:563], sd)
mean_stdDev <- rbind(meanvals, sdvals)

## Requirement 5 - "From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject."
library(dplyr)
completedata$volunteer_id <- as.numeric(completedata$volunteer_id)
# Below code remidies error message concerning duplicated column names
names(completedata) <- make.unique(names(completedata))
groups <- group_by(completedata, volunteer_id, activity)
groupedmeans <- summarize_each(groups, funs(mean))

# Write to table
write.table(groupedmeans, file = "peerassignment.txt", row.names = FALSE)
# Global environment clean-up
rm(test, test_id, testactivity, testset, train, train_id, trainactivity, trainset, header, meanvals, sdvals, groups)