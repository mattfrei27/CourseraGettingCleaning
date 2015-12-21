Getting and Cleaning Data: Course Project
======================

The run_analysis.R script downloads Samsung smartphone sensor data originally from the UCI machine learning repository. It has a variety of sensor measurements on subjects who performed activities such as climbing stairs and walking while the smartphone sensors recorded the movements. 

run_analysis.R also performs the tasks required for the Coursera Getting and Cleaning Data course:

* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The final output dataset has one record per subject - activity combination and has the mean of a subset of the original variables (the mean and standard deviation variables).

Explanation of analysis performed:

* Step 1: Combined training and test data sets as well as the subject and activity information
* Step 2: Select only the measurement columns from step1 that contain either mean or standard deviation measures.
* Step 3: Add a additional column that stores the description of eac of the numeric activity codes.
* Step 4: Modify original variables names by removing periods, replacing leading 'F' characters with 'frequency', replacing leading 'T' characters with 'trans', and making all variable names lowercase.
* Step 5: Group by subject and activity and take the mean of all measurement columns present in step 4.