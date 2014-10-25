#Step1. Merge the training and the test sets to create one data set
#setwd("C:/Users/Max/Documents/R/Dataset")
#train data
trainData <- read.table("C:/Users/Max/Documents/R/Dataset/train/X_train.txt")
dim(trainData) #7352*561
trainLabel <- read.table("C:/Users/Max/Documents/R/Dataset/train/y_train.txt")
dim(trainLabel) #7352*1
trainSubject <- read.table("C:/Users/Max/Documents/R/Dataset/train/subject_train.txt")
dim(trainSubject) #7352*1
#test data
testData <- read.table("C:/Users/Max/Documents/R/Dataset/test/X_test.txt")
dim(testData) #2947*561
testLabel <- read.table("C:/Users/Max/Documents/R/Dataset/test/y_test.txt")
dim(testLabel) #2947*1
testSubject <- read.table("C:/Users/Max/Documents/R/Dataset/test/subject_test.txt")
dim(testSubject) #2947*1
#join Data
joinData <- rbind(trainData, testData)
dim(joinData) #10299*561
#join Label
joinLabel <- rbind(trainLabel, testLabel)
dim(joinLabel) #10299*1
#join trainSubject and trainTest
joinSubject <- rbind(trainSubject, testSubject)
dim(joinSubject) #10299*1

#Step2. Extract only the measurement on the mean and stand deviation for
#each measurement
features <- read.table("C:/Users/Max/Documents/R/Dataset/features.txt")
dim(features) #561*2
meanStd <- grep("mean\\(\\)|std\\(\\)", features[, 2])
length(meanStd) #66 list on mean and std
joinData <- joinData[, meanStd]
dim(joinData) #10299*66
names(joinData) <- gsub("\\(\\)", "", features[meanStd, 2]) #remove ()

#Step3. Uses descriptive activity names to name the activities in the data set
activity <- read.table("C:/Users/Max/Documents/R/Dataset/activity_labels.txt")
activity[,2] <- tolower(gsub("_","", activity[,2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityLabel <- activity[joinLabel[, 1], 2]
joinLabel[, 1] <- activityLabel
names(joinLabel) <- "activity"

#Step4. Appropriately labels the data set with descriptive variable names
names(joinSubject) <- "subject"
cleanData <- cbind(joinSubject, joinLabel, joinData)
dim(cleanData) #10299*563
write.table(cleanData, "data_merge.txt")

#Step5. Create a second, independent tidy data set with average of 
#each variable for each activity and each subject
subjectLen <- length(table(joinSubject)) # 30
activityLen <- dim(activity)[1] # 6
columnLen <- dim(cleanData)[2]
result <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) 
result <- as.data.frame(result)
colnames(result) <- colnames(cleanData)
row <- 1
for(i in 1:subjectLen) {
  for(j in 1:activityLen) {
    result[row, 1] <- sort(unique(joinSubject)[, 1])[i]
    result[row, 2] <- activity[j, 2]
    subject1 <- i == cleanData$subject
    activity1 <- activity[j, 2] == cleanData$activity
    result[row, 3:columnLen] <- colMeans(cleanData[subject1&activity1, 3:columnLen])
    row <- row + 1
  }
}
dim(result) #180*68
write.table(result, "data_means.txt") 

