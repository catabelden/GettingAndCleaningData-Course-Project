# Getting and Cleaning Data Project John Hopkins Coursera
# Author: Catharina Belden

#########################################################################################################################################################
# STEPS*:
# Step 1 - Merge the training and the test sets to create one data set                                                                                  # 
# Step 2 - Extract only the measurements on the mean and standard deviation for each measurement                                                        #              
# Step 3 - Uses descriptive activity names to name the activities in the data set                                                                       #
# Step 4 - Appropriately labels the data set with descriptive variable names                                                                            #
# Step 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject#
#########################################################################################################################################################
#*NOTE: the steps where not made in cronological order but rather in order of simplicity.

library(plyr)
library(data.table)

# downlaod and read general data
        activity_labels <- fread("UCI HAR Dataset (Project)/activity_labels.txt", col.names = c("classLabels", "activityName"))
        features <- fread("UCI HAR Dataset (Project)/features.txt", col.names = c("index", "featureName"))
        
        # Step 2 - Extract only the measurements on the mean and standard deviation for each measurement           
        features_step <- grep("(mean|std)\\(\\)", features$featureName) 
        features_wanted<- features[features_step, featureName]
        features_wanted <- gsub("\\()", "", features_wanted)  #66 features with mean or standard deviation

# downlaod and read training data
        training_set <- fread("UCI HAR Dataset (Project)/train/X_train.txt")              
        training_set <- training_set[, features_step, with = FALSE]                       
        data.table::setnames(training_set, colnames(training_set), features_wanted)   ### Step 2 ### 
        training_labels <- read.table("UCI HAR Dataset (Project)/train/y_train.txt", col.names = "Activity")       
        subject_train <- read.table("UCI HAR Dataset (Project)/train/subject_train.txt", col.names = "SubjectNum")

# merge all training data into one training dataset.
training_set <- cbind(subject_train, training_labels, training_set)

# read test data
        test_set <- fread("UCI HAR Dataset (Project)/test/X_test.txt")                                       
        test_set <- test_set[, features_step, with = FALSE]
        data.table::setnames(test_set, colnames(test_set), features_wanted)   ### Step 2 ### 
        test_labels <- fread("UCI HAR Dataset (Project)/test/y_test.txt", col.names = "Activity") 
        subject_test <- fread("UCI HAR Dataset (Project)/test/subject_test.txt", col.names = "SubjectNum")

# merge all test data into one test dataset.
test_set <- cbind(subject_test, test_labels, test_set)

# Step 1 - Merge the training and the test sets to create one data set
dataset <- rbind(training_set, test_set)

# Step 3 - Uses descriptive activity names to name the activities in the data set
dataset[["Activity"]] <- factor(dataset$Activity, levels = activity_labels[["classLabels"]], labels = activity_labels[["activityName"]])

# Step 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
dataset %>% 
        group_by(SubjectNum, Activity) %>%
        summarise_all(mean)

# tidy data of step 5
data.table::fwrite(x = dataset, file = "tidyData.csv")