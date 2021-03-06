## Original Data

- [source](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 
- [description](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Data Transformation Steps

The `run_analysis.R` script carries out the following:

1. Download the source file into the current working directory if it is not already present.
	- This is carried out by the downloadData() helper function.
2. Load the data from inside the zip file:
    1. The training and test data for the measurements (X), the activities (Y) and subjects (S) are loaded from the train and test folders.
    2. The features are loaded from features.txt from the root folder.
    3. The activity labels are loaded from activity\_labels.txt from the root folder.
    4. The loading is carried out by loadData(), which takes a handle to the zip file, and returns a list containing 8 data frames (corresponding to train and test data for X, Y, and S, and features and activities).
3. The training and test data for X, Y and S are merged. 
	- This is done via the mergeData() function which takes in the list from step 2 and returns a new list with three data frames - X, Y and S.
	- After the merged list is got, the six columns corresponding to X, Y and S data frames in the original list are discarded to save memory.
4. Measurements that are not means or standard deviations are filtered out of X.
	- This is done via the extract\_mean\_std\_features() function. This takes in the measurements data frame and the features data frame, and returns a new data frame with only the relevant features.
	- The target features are identified as those with -mean() or -std() in their names. This is done via grepping with the pattern <code>"-mean\\(\\)|-std\\(\\)"</code> on the second column of the features data frame.
	- This function also adjusts the column names to be the lowercased feature name stripped of '(' and ')'s.
5. The activity names are applied.
	- This is done via the apply\_activity\_names() function. This takes in the activity indices (Y) and the activities data frame, and returns a matrix with the activity labels.
	- The new matrix has a single column, and the name "activity" is applied to that column.
	- The returned matrix is used as the new activities matrix (Y).
	- Once this is done, the initially loaded list is discarded as it is no longer needed.
6. The name "subject" is applied to the single column of the subjects data frame.
7. The first tidy data frame is got by combining the subjects, activities, and measurements frames. 
	- This is done using cbind.
	- The first column of the resulting frame represents the subject, the second the activity and the remaining columns represent the corresponding measurements.
	- The tidy dataset has 10299 rows and 68 columns.
8. This first tidy data frame is written to "tidy.txt" using write.csv.
9. The tidy data set is melted using the first two columns as the identity. 
10. The melted data is aggregated  by "mean" for each subject and identity.
	- The aggregated data frame has 180 rows and 68 columns - the first two representing subject and activity, and the remaining ones holding the average or each mean / std measure got that particular subject-activity pair.
11. The aggregated data frame is written out to "tidy2.txt" as the second output.

## Variable Descriptions

The output data is got by transforming data in the input zip source file mentioned in the Original Data section. The source has a file called "features_info.txt" in the root folder. This describes the variables in detail. Here is a subsection of the description:

>The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

>Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

>Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).

>These signals were used to estimate variables of the feature vector for each pattern: '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

>The set of variables that were estimated from these signals are:
- mean(): Mean value
- std(): Standard deviation

There are 66 features in the source that correspond to means and standard deviations. The output files both have 68 columns - 1 for subject, 1 for activity, and the remaining 66 columns corresponding to the 66 mean and standard deviation features. 

### tidy.txt
- This file holds all the measurements of the 66 features for each subject and activity.

###tidy2.txt
- This file holds the averages for each mean / standard deviation measurement for each subject-activity pair.

## Data Columns

1. subject
2. activity
3. tbodyacc.mean.x
4. tbodyacc.mean.y
5. tbodyacc.mean.z
6. tbodyacc.std.x
7. tbodyacc.std.y
8. tbodyacc.std.z
9. tgravityacc.mean.x
10. tgravityacc.mean.y
11. tgravityacc.mean.z
12. tgravityacc.std.x
13. tgravityacc.std.y
14. tgravityacc.std.z
15. tbodyaccjerk.mean.x
16. tbodyaccjerk.mean.y
17. tbodyaccjerk.mean.z
18. tbodyaccjerk.std.x
19. tbodyaccjerk.std.y
20. tbodyaccjerk.std.z
21. tbodygyro.mean.x
22. tbodygyro.mean.y
23. tbodygyro.mean.z
24. tbodygyro.std.x
25. tbodygyro.std.y
26. tbodygyro.std.z
27. tbodygyrojerk.mean.x
28. tbodygyrojerk.mean.y
29. tbodygyrojerk.mean.z
30. tbodygyrojerk.std.x
31. tbodygyrojerk.std.y
32. tbodygyrojerk.std.z
33. tbodyaccmag.mean
34. tbodyaccmag.std
35. tgravityaccmag.mean
36. tgravityaccmag.std
37. tbodyaccjerkmag.mean
38. tbodyaccjerkmag.std
39. tbodygyromag.mean
40. tbodygyromag.std
41. tbodygyrojerkmag.mean
42. tbodygyrojerkmag.std
43. fbodyacc.mean.x
44. fbodyacc.mean.y
45. fbodyacc.mean.z
46. fbodyacc.std.x
47. fbodyacc.std.y
48. fbodyacc.std.z
49. fbodyaccjerk.mean.x
50. fbodyaccjerk.mean.y
51. fbodyaccjerk.mean.z
52. fbodyaccjerk.std.x
53. fbodyaccjerk.std.y
54. fbodyaccjerk.std.z
55. fbodygyro.mean.x
56. fbodygyro.mean.y
57. fbodygyro.mean.z
58. fbodygyro.std.x
59. fbodygyro.std.y
60. fbodygyro.std.z
61. fbodyaccmag.mean
62. fbodyaccmag.std
63. fbodybodyaccjerkmag.mean
64. fbodybodyaccjerkmag.std
65. fbodybodygyromag.mean
66. fbodybodygyromag.std
67. fbodybodygyrojerkmag.mean
68. fbodybodygyrojerkmag.std


