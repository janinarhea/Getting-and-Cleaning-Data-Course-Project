# Code Book

Data Set
The data set used in this assignment was gathered from the accelerometers from the Samsung Galaxy S smartphone. A full description can be read in the following link: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

R Script
Below is a summary of the data processing done to create a tidy data set:
1.	Check if file exists. If yes, unzip the file. Otherwise, download it.
2.	Load activity labels as tables. Convert the class of activity into characters.
3.	Load features as tables. Convert the class of features as characters.
4.	Extract the mean and standard deviation of each measurement.
5.	Load the training datasets, training labels, and subject.
6.	Merge training dataset, activities, and subjects.
7.	Load testing datasets, testing labels, and subject.
8.	Merge testing dataset, activities, and subjects.
9.	Merge training and testing datasets.
10.	Label the data set with variable names.
11.	Convert activities and subjects into factors from activityLabels.
12.	Convert CombinedData into a molten dataframe.
13.	Create an independent and tidy daata set with the average of each variable for each activity and subject.
14.	Upload complete data as a text file.

Variables
filename – assigned for the name of zip file downloaded, which contains the raw file
activityLabels, features, featuresWanted.names, testActivities, and testSubjects – contain the data and labels that have to be extracted from the raw file 
test and train – contain the cleaned up data that will be combined into one table
CombinedData – contains all the necessary data for the final output
