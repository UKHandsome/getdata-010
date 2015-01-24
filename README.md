Codebook
==============================================================

## 1.Introduction
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

 A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

## 2.Our goal
	Goal is an independent tidy data set with the average of each variable for each activity and each subject.

## 3.How we process data
	1. We merge training and test data set via custom function "readDataSet". And combine files with rbind.
	2. Extracts mean and standard deviation for each measurement. (Grep mean,std).
	3. Use activity names from file "activity_labels.txt".
	4. Replace column names with descriptive variable names.
	5. Export tidy data set with the average of each variable for each activity and each subject.

	Let me show you some examples of variable names.
	
	Merge data set             	Tidy data set
 	-----------------------------------------------
 	subject				volunteerID
 	labe				activityName
 	tBodyAcc-mean()-		timeBodyAccMeanX
 	tGravityAcc-mean()-		timeGravityAccMeanY
 	fBodyAcc-mean()-		frequencyBodyAccMeanZ

