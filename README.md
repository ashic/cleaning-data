cleaning-data
=============

This is the course project undertaken as part of the "Getting and Cleaning Data" course (in the Data Science specialisation)  at Coursera. 

##The Project
run\_analysis.R is the main script. It exposes a function called run\_analysis() that does the heavy lifting. It downloads the input zip file, stores it in a temporary location, loads the required data into memory from inside the zip file, processes the data, and outputs two files (tidy.txt and tidy2.txt) in the current working directory. During processing, it uses the reshape2 library, which it installs if needed. The script runs on both Windows and Linux, and has been tested on Windows 8.1 64 bit and Ubuntu 14.04 64 bit.

## Original data:

- [source](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 
- [description](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

##Running the script
- Load the script run\_analysis.R
- Call the function run\_analysis.R
- The output is two files tidy.txt and tidy2.txt

##Output
The files are stored in csv format, and can be loaded into data frames with read.csv. They are output to the current working directory.

###tidy.txt
This file contains the input data filtered to mean and standard deviation measures, and listed along with the relevant subject and activity name. 
###tidy2.txt
This file contains the average of each measure for each activity and each subject present in the input.

##Assumptions
- The script has access to the internet to download the input file.
- For each dataset:
	- Measurements for X are in the X_train.txt and X_test.txt files.
	- Measurements for Y are in the y_train.txt and y_test.txt files.
	- Measurements for S are in the subject_train.txt and subject_test.txt files.
	- Here, X, Y and S represents the measurements, the activities and the subjects respectively.
	- The training set files are in the "UCI HAR Dataset/train" directory.
	- The test files are in the "UCI HAR Dataset/test" directory.
	- Inertial Signals directories are ignored.
- Activity codes and their labels are in a file named activity_labels.txt, and Y initially holds indices to these labels.
- A file called features.txt hold an ordered list of labels for each measurement in X. The columns in X correspond to the ordering in this file.
- As part of processing, only columns representing mean and standard deviation are considered. Measurements are considered to be a mean or standard deviation measurement if they have "-mean()" or "-std()" in their names. Other measurements are ignored, and this includes features like "meanFreq".

##Notes
- The script will download the input zip files in each run.
- reshape2 is used, and will be automatically installed if not already present.
- The input file download tries to use the default method of download.file. If this fails, it reverts to using the 'wget' method of download.file. This ensures the file download succeeds in both Windows and Linux.
