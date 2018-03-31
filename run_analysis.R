## Importing the data into R
features <- read.table("./UCI HAR Dataset/features.txt", header = FALSE)
Y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
Y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)
## Label the columns
column_names <- features[,2]
names(X_train) <- column_names
names(X_test) <- column_names
test_data <- cbind(Y_test,X_test)
colnames(test_data)[1] <- "activity"
train_data <- cbind(Y_train,X_train)
colnames(train_data)[1] <- "activity"
test_data <- cbind(subject_test,test_data)
colnames(test_data)[1] <- "subject"
train_data <- cbind(subject_train,train_data)
colnames(train_data)[1] <- "subject"
## Merge the training and test sets
mergeData <- rbind(test_data,train_data)
## Extract only measurements on the mean and standard deviation for each measurement
subset_data <- mergeData[,grepl("mean|std|subject|activity",names(mergeData))]
## Use descriptive activity names to name the activities in the data set
subset_data$activity[subset_data$activity == "1"] <- "Walking"
subset_data$activity[subset_data$activity == "2"] <- "Walking_Upstairs"
subset_data$activity[subset_data$activity == "3"] <- "Walking_Downstairs"
subset_data$activity[subset_data$activity == "4"] <- "Sitting"
subset_data$activity[subset_data$activity == "5"] <- "Standing"
subset_data$activity[subset_data$activity == "6"] <- "Laying"
## Label the data set with descriptive variable names
original_names <- names(subset_data)
new_names <- sub("\\-"," ",original_names)
new_names <- sub("\\()"," ",new_names)
new_names <- sub("\\-X","X",new_names)
new_names <- sub("\\-Y","Y",new_names)
new_names <- sub("\\-Z","Z",new_names)
names(subset_data) <- new_names
## Creating a second, independent tidy data set with the average of each variable for each activity and subject
library(dplyr)
final_data <- subset_data %>% group_by(activity,subject) %>% summarize_all(funs(mean))



