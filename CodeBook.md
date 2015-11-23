### Data Set Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.


### Transformation details

The script run_analysis.R performs the steps described in the course project's definition.

First, training and test data for X, Y and Subject data were read. Then 'X' train and test data merged, 'Y' train and test data merged and similarly 'subject' train and test is merged.

Then, x data is given the descriptive names using features.txt. Then, only those columns with the mean and standard deviation measures are taken from the whole dataset.

As activity data is addressed with values 1:6, we take the activity names and IDs from activity_labels.txt and they are substituted in the dataset.

On the whole dataset, those columns with vague column names are corrected.

Finally, we generate a new dataset with all the average measures for each subject and activity type (30 subjects * 6 activities = 180 rows). The output file is called tidy_data.txt, and uploaded to this repository.
Variables

x_train, y_train, x_test, y_test, subject_train and subject_test contain the data from the downloaded files.

x_data, y_data and subject_data is the merge of previous datasets for further analysis.

features contains the correct names for the x_data dataset, which are applied to the column names of x_data.

A similar approach is taken with activity names through the activities variable.

data merges x_data, y_data and subject_data in a big dataset.

Finally, tidy_data contains the relevant averages which will be later stored in a .txt file. melt() from the reshape2 package is used to melt the data frame and then dcast() is used to create the tidy_data from with averages.
