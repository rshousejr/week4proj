The original observations from the UCI HAR Dataset were on experiments carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The script run_analysis.r does the following:

Sets the source directory to where the original dataset was downloaded and reads the data into data tables in r

Merges the test and activity data into one combined table

Assigns descriptive column names 

Extracts the mean and standard deviation for each measurement.

Creates a tidy data set with the average of each variable and writes it out to a file named finalTidySet.txt


The dataset contains the following columns:

"activityId"	"subjectId"	"timeBodyAccMagnitudeMean"	"timeBodyAccMagnitudeStdDev"	"timeGravityAccMagnitudeMean"	"timeGravityAccMagnitudeStdDev"	"timeBodyAccJerkMagnitudeMean"	"timeBodyAccJerkMagnitudeStdDev"	"timeBodyGyroMagnitudeMean"	"timeBodyGyroMagnitudeStdDev"	"timeBodyGyroJerkMagnitudeMean"	"timeBodyGyroJerkMagnitudeStdDev"	"freqBodyAccMagnitudeMean"	"freqBodyAccMagnitudeStdDev"	"freqBodyAccJerkMagnitudeMean"	"freqBodyAccJerkMagnitudeStdDev"	"freqBodyGyroMagnitudeMean"	"freqBodyGyroMagnitudeStdDev"	"freqBodyGyroJerkMagnitudeMean"	"freqBodyGyroJerkMagnitudeStdDev"	"activityType"
