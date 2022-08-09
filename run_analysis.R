# This script will do the following: steps on the UCI HAR Dataset 

# 1. set the working directory to a location where the file "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#    was downloaded and unzipped
# 2. Merge the training and the test sets to create one merged data set.
# 3. Extract measurements on the mean and standard deviation 
# 4. Add descriptive names to the data sets
# 5. Create a tidy data set with the average of each variable  


# Clean up workspace
rm(list=ls())

# 1. Merge the training and the test sets in one data set.

#set working directory to the location where the UCI HAR Dataset was unzipped
setwd("~/Library/Mobile Documents/com~apple~CloudDocs/DataScience/Getting.and.Cleaning.Data.Course/Week4/Project")

# Read in the data from files
features     = read.table('./features.txt',header=FALSE) 
activityType = read.table('./activity_labels.txt',header=FALSE) 
subjectTrain = read.table('./train/subject_train.txt',header=FALSE) 
xTrain       = read.table('./train/x_train.txt',header=FALSE)
yTrain       = read.table('./train/y_train.txt',header=FALSE)

# Assigin column names
colnames(yTrain)        = "activityId"
colnames(activityType)  = c('activityId','activityType')
colnames(xTrain)        = features[,2]
colnames(subjectTrain)  = "subjectId"

# Merge yTrain, subjectTrain, and xTrain, which can be bound sequentially rather than joined by a particular id column
trainingData = cbind(yTrain,subjectTrain,xTrain)

# Read in the test data
subjectTest = read.table('./test/subject_test.txt',header=FALSE); #imports subject_test.txt
xTest       = read.table('./test/x_test.txt',header=FALSE); #imports x_test.txt
yTest       = read.table('./test/y_test.txt',header=FALSE); #imports y_test.txt

# Assign column names 
colnames(subjectTest) = "subjectId"
colnames(yTest)       = "activityId"
colnames(xTest)       = features[,2] 

# Made second local change
# Merge the xTest, yTest and subjectTest data
testData = cbind(yTest,subjectTest,xTest)


# Combine training and test data to create a final data set using rbind
mergedTrainingTest = rbind(trainingData,testData)

# Create a vector of column names from the mergedTrainingTest data set, which will be used
# to extract mean() & stddev()
colNames  = colnames(mergedTrainingTest) 

# 2. Extract mean and standard deviation for each measurement. 
# Meanwhile I made this first change locally and committed

# Make vector that contains TRUE for the ID, mean() & stddev() columns so subsequent statements can select just those values
meanAndStddevVectors = (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames))

# Subset mergedTrainingTest table based on the meanAndStddevVectors to keep only those columns
mergedTrainingTest = mergedTrainingTest[meanAndStddevVectors==TRUE]

# 3. Name the activities in the data set by seting them with the acitivityType table 
mergedTrainingTest = merge(mergedTrainingTest,activityType,by='activityId',all.x=TRUE)

# Updatie the colNames vector with the new column names post-merge
colNames  = colnames(mergedTrainingTest)

# 4. Add activity names. 

for (i in 1:length(colNames)) 
{
    colNames[i] = gsub("\\()","",colNames[i])
    colNames[i] = gsub("-std$","StdDev",colNames[i])
    colNames[i] = gsub("-mean","Mean",colNames[i])
    colNames[i] = gsub("^(t)","time",colNames[i])
    colNames[i] = gsub("^(f)","freq",colNames[i])
    colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
    colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
    colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
    colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
    colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
    colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
    colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
}

# Add column names to the mergedTrainingTest
colnames(mergedTrainingTest) = colNames

# 5. Create the final, tidy data set 

mergedWithoutActNames  = mergedTrainingTest[,names(mergedTrainingTest) != 'activityType']

# Summarizing the mergedWithoutActNames table to include mean of each activity/subject combo
finalTidySet    = aggregate(mergedWithoutActNames[,names(mergedWithoutActNames) != c('activityId','subjectId')],by=list(activityId=mergedWithoutActNames$activityId,subjectId = mergedWithoutActNames$subjectId),mean)

# Merging the finalTidySet with activityType to include descriptive acitvity names
finalTidySet    = merge(finalTidySet,activityType,by='activityId',all.x=TRUE)

# Export the finalTidySet set 
write.table(finalTidySet, './finalTidySet.txt',row.names=TRUE,sep='\t')