# Introduction
This is my final project for the Getting and Cleaning Data Coursera. Using the data set from the <a href="http://archive.ics.uci.edu/ml/">UC Irvine Machine
Learning Repository</a>, the purpose of this project was to simply collect, work with, and clean this data set. This repository contains the codebook descrbing the field names of the final tidy data set produced, and the code file that produces the tidy data set. This read me will describe the steps taken in the code file run_analysis.R.
## Importing the data
The first step was to import the data. This was achieved by using the ``read.table()`` function with ``header = FALSE`` on the following files: features.txt, y_train.txt, X_train.txt, subject_train.txt, y_test.txt, X_test.txt, and subject_test.txt. 
## Labeling the data
This was done by pulling the column names from the features.txt file and adding those names to the test and train data sets. The y_train and y_test files contained the activity id performed by the subject, so these were merged with the x_train and x_test files, respectively, and then the columns are labeled "activity." Then I merged the subject_test and subject_train (the files that contained the subject ids of the participants) with this data set and labeled them "subject."
## Merge the training and test sets
I used the ``rbind()`` function to merge the test_data and train_data sets created.
## Extract only measurements on the mean and standard deviation for each measurement
Using the ``grepl()`` function, I pulled only the columns containing mean, std, subject and activity in their names. I interpreted "only measurements on the mean" to include the measurements of mean frequency as well.
## Use descriptive activity names to name the activities in the data set
Here I assigned the activity ids (ranging from 1 through 6) to their corresponding activities: walking, walking upstairs, walking downstairs, sitting, standing, and laying.
## Label the data set with descriptive variable names
I just cleaned up the names of the columns by removing the "\\-" and "\\()" characters in the names with the ``sub()`` function.
## Create a second, independent tidy data set with the average of each variable for each activity and subject
The ``dplyr`` package is needed for this part. If you don't have this package already, use the ``install.packages()`` function. Then load this package with the commmand ``library(dplyr)``. In order to average each variable for activity and subject, I used the ``group_by()`` function and the ``summarize_all(funs(mean))`` function. Then the data was exported using the ``write.table()`` function.
