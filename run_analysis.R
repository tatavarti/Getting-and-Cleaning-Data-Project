# Create one R script called run_analysis.R that does the following:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive activity names.
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

if (!require("data.table")) {
    install.packages("data.table")
}

if (!require("reshape2")) {
    install.packages("reshape2")
}

require("data.table")
require("reshape2")

# Merge the training and test sets to create one data set
##########################################################################################

x_train <- read.table(".\\UCI HAR Dataset\\train\\X_train.txt")
y_train <- read.table(".\\UCI HAR Dataset\\train\\y_train.txt")
subject_train <- read.table(".\\UCI HAR Dataset\\train\\subject_train.txt")


x_test <- read.table(".\\UCI HAR Dataset\\test\\X_test.txt")
y_test <- read.table(".\\UCI HAR Dataset\\test\\y_test.txt")
subject_test <- read.table(".\\UCI HAR Dataset\\test\\subject_test.txt")

# create 'x' data set
x_data <- rbind(x_train, x_test)

# create 'y' data set
y_data <- rbind(y_train, y_test)

# create 'subject' data set
subject_data <- rbind(subject_train, subject_test)


# Extract only the measurements on the mean and standard deviation for each measurement
##########################################################################################

features <- read.table(".\\UCI HAR Dataset\\features.txt")[, 2]
extract_features <- grepl("mean|std", features)

names(x_data) = features
x_data = x_data[, extract_features]


# Use descriptive activity names to name the activities in the data set
##########################################################################################

# Load activity labels
activity_labels <- read.table(".\\UCI HAR Dataset\\activity_labels.txt")[, 2]
y_data[, 1] = activity_labels[y_data[, 1]]
names(y_data) = "activity"


# Appropriately label the data set with descriptive variable names
###############################################################################

# correct column name
names(subject_data) = "subject"

# bind all the data in a single data set
data <- cbind(subject_data, y_data, x_data)


# Create a second, independent tidy data set with the average of each variable
# for each activity and each subject
###############################################################################
id_labels = c("subject", "activity")
data_labels = setdiff(colnames(data), id_labels)
melt_data = melt(data, id = id_labels, measure.vars = data_labels)

tidy_data = dcast(melt_data, subject + activity ~ variable, mean)

write.table(tidy_data, ".//tidy_data.txt")
