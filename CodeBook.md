Getting and cleaning data course project
CodeBook for peer assessments

Data site:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Data for project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

run_analysis.R script performs the following steps to clean the data:

a) Read X_train.txt, y_train.txt and subject_train.txt from "C:/Users/Max/Documents/R/Dataset" wd/folder and store them in trainData, trainLabel and trainSubject variables respectively.

b) Read X_test.txt, y_test.txt and subject_test.txt from "C:/Users/Max/Documents/R/Dataset" wd/folder and store them in testData, testLabel and testsubject variables respectively.

c) Concatenate testData to trainData to generate data frame joinData. Concatenate testLabel to trainLabel to generate data frame joinLabel. Concatenate testSubject to trainSubject to generate data frame joinSubject.

d) Read the features.txt file from "C:/Users/Max/Documents/R/Dataset" wd/folder and store the data in a variable called features. Extract the measurements on mean and standard deviation. 
This results in a 66 list on mean and standard deviation. Get subset of joinData with the 66 corresponding columns.

e) Clean the column names of the subset. Remove "()" symbols in the names.

f) Read the activity_labels.txt file from "C:/Users/Max/Documents/R/Dataset" wd/folder and store the data in a variable called activity.

g) Clean the activity names in the second column of activity. Make all names to lower cases, remove any underscore between letters, capitalize the letter immediately after underscore.

h) Transform the values of joinLabel according to the activity data frame.

i) Combine the joinSubject, joinLabel and joinData by column to get new data frame cleanData. Write the cleanData out to "data_merge.txt" file in current wd.

j) Create a second independent tidy data set with the average of each variable for each activity and each subject. 
There are 30 unique subjects and 6 unique activities, resulting in a combination of 180 variables. Calculate the mean of each unique combination (subjects and activities). 
Write the result out to "data_means.txt" file in current wd.
