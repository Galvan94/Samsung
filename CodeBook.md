# Following the project instructions the run_analysis.r script create a finalData dataframe with the mean relationship between activity and subject.

## The firs 2 lines include the required libraries:

library(dplyr) <- to perform sql sentences and make easier cleaning data

library(data.table) <- to use fread function to read the files contained in ucidataset folder


## Reading data

features <- read the features file assigning column names

activities <- read the activities values from activity_labels file 

subject_test <- getting the subjects from the test folder

subject_train <- getting the subjects from the training folder

x_test <- getting the x values from the test file

x_train <- getting the x values from the train file

y_test <- getting the y values from the test file

y_train <- getting the y  values from the train file


## Tidy data

X <- merge data corresponding to X values in order to get 100% of observations in one variable

Y <- merge data corresponding to Y values in order to get 100% of observations in one variable

subject <- merge data corresponding to subject values in order to get 100% of observations in one variable

completeData <- merge complete data from X, Y and subject observations


## Transform data

mean_std_data <- select from the completeData variable just the observations which contain "mean" and "std" values

Then modify the variable names in order to make them more descriptive.

finalData <- finally from mean_std_data get the average of each variable for each activity and each subject

The last part create the file "finalData.txt" with the complete observations from finalData variable

