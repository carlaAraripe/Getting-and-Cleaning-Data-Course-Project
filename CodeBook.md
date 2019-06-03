This tidy data set was obtained from Human Activity Recognition Using Smartphones Data Set, described at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#.

Files used to prepare the tidy data set:
  'features.txt': List of all features.
  'activity_labels.txt': Links the class labels with their activity name.
  'train/X_train.txt': Training set. It has one column for each line in features.txt. 
  'train/y_train.txt': Training labels. The same number of lines than X_train.txt.
  'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. The same number of lines tham X_train.txt.
  'test/X_test.txt': Test set. It has one column for each line in features.txt.
  'test/y_test.txt': Test labels. The same number of lines than X_test.txt.
  'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. The same number of lines tham X_test.txt.

Steps to clean the data set:
  Use 'features.txt' to identify measurements on the mean and standard deviation for each measurement.
  Select from 'X_train.txt' and 'X_test.txt' only the columns corresponding to mean and standard deviation for each measurement and change name of columns to use descriptive variable names.
  Bind activity information to each mesurement using 'y_train.txt' and 'y_test.txt'.
  Bind subject information to each mesurement using 'subject_train.txt' and 'subject_test.txt'.
  Merge training and test sets to create one data set. 
  Merge activity names to te data set, using 'activity_labels.txt'. This first tidy data set was saved as 'HAR_Mean_Std.txt'.
  Create a second, independent tidy data set with the average of each variable for each activity and each subject. This second tidy data set was saved as 'HAR_Avg.txt'.
  
