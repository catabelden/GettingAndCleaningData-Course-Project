# GettingAndCleaningData-Course-Project
## Introduction
This is the final project of the JHU Coursera class on "Getting and cleaning data". The purpose of this project was to demonstrate my ability to collect, work with, and clean a data set. The final product is a tidy set.

## Course Project:
I created an R script called run_analysis.R that does the following:

0. Donwloads and reads the data
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The relevant source code is in run_analysis.R. The data that this script uses is also included in this repository. You may run the data analysis by loading the run_analysis.R source file and running the function

run_analysis()
