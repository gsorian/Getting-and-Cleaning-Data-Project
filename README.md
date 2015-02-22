# Getting-and-Cleaning-Data-Project
Provided are script of run_analysis.R, the code book of the project

==============================================================================================================
Course Project of Getting and Cleaning Data getdata-011
Data Science Specialization Coursera
==============================================================================================================


Provided in text file data_tidy.txt is a long form tidy data set complying instructions for the project.
The data has 4 columns corresponding to (subject_id, Activity, Measurement, Value) and 11,880 observations

Subject_id corresponds to the identification of each of the 30 volunteers
Activity provides a description of the activity performed by the volunteer while performing the experiment
Measurement correspond to each of the mean and std features from the original data set.  (MeanFreq measurements
	were not considered in the project)
Value is the numerical value (averaged) for each measurements


=================================================================================================================
Explanation of Code

the code run_analysis.R performed the following tasks:
- Read the zip file from its URL
- Create new variables for the train (X,Y,subject ), test (X,Y,subject ), activity and features
- Merge train and data into one data set for: X,Y,subject.
- Find the location of Mean and Std features from the feature variable.
- Extract Mean and Std data from X, and assign name to each column of data
- Form the long form tidy data set as follows:
  1. Bind subject_id, activity, and Mean and Std Data in one agregated data frame
  2. Initialize a data frame to store tidy data
  3. Look for repeated measurements for each of the 180 combinations of subject_id (30) and activities(6)
  4. Average the Measurements (feature) and store it in 66 rows of the corresponding measurements in the tidy data set.
  5. Repeat steps iii and iv for a different subject_id and activity combination until each possible combination is performed.
- Store the tidy data set in txt file
 

