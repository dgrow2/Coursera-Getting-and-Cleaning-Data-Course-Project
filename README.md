# Coursera-Getting-and-Cleaning-Data-Course-Project
Final assignment for the Getting and Cleaning Data Course from Coursera
README.md

There are 4 files associated with this data set"
1.)run_analysis.R is the R script that renders the analysis
2.)tidy.txt contains the results from run_analysis.R
3.)A README.md file that describes the analysis
4.)A CodeBook.md describes the variables in the data set

The run_analysis.R script creates a tidy data set from the data gathered by the UCI Machine Learning Repository
on Human Activity. The raw data consists of the readings collected from accellerometers housed within the
Samsun Galaxy S phone,which were carried by the subjects as they performed various tasks.

The data were partitioned among 6 different files that are all downloaded from the UCI website and read into data
tables in R during the implementation of the script:

note: paticipants were initially divided into two groups a training set and test set
More detailed information on the raw data set can be found at
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

1.) Subject_test = subject test data file which contains data on which subjects were in the test set

2.) X_test = contains the data on from the accelerometers during different activities. Each row is a different
activity or subject

3.) Y_test= the key to say what activity id each participant should be assigned to each row in x_test data set

4.) subject_train= list of subjects that were in the training data set

5.) X_train= data from the accelermoters from the training set group

6.) Y_train= list of activity ids for the training set group

7.) Features= a description of the the source of the accelleromter data

8.) activity lables= a key describing what activity ID is assigned to a particular activity.

After the data is read into R, the data are merged using the following actions:
	The sources of the accelleromter data are assigned as the column names do the accellerometer data
	The column name of the activity ids is changed to "ActivityID"
	The column name of the subject id data is changed "SubjectID"
	The SubjectID and ActivityID data are added as new columns to the data set containing the accellerometer data
	The training data and the test data are then merged to one data set. 

Any column containing mean or average standard deviation data is then extracted into a new data frame along with the
corresponding subjectIDs and Activity IDS

This new data table is merged with the activity labels data table, so each row as an activity label associated
with its acitivityID.


Finally, this data is grouped by the activity type and the subject, giving the data a tidy structure.
