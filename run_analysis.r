library(dplyr)
library(data.table)

features <- fread("ucidataset/features.txt",col.names = c("id","feature"))
activities <- fread("ucidataset/activity_labels.txt",col.names = c("id","activity"))
subject_test <- fread("ucidataset/test/subject_test.txt",col.names = c("subject"))
subject_train <- fread("ucidataset/train/subject_train.txt",col.names = c("subject"))
x_test <- fread("ucidataset/test/X_test.txt",col.names = features$feature)
x_train <- fread("ucidataset/train/X_train.txt",col.names = features$feature)
y_test <- fread("ucidataset/test/y_test.txt",col.names = c("activity"))
y_train <- fread("ucidataset/train/y_train.txt",col.names = c("activity"))

X <- rbind(x_test,x_train)
Y <- rbind(y_test,y_train)
subject <- rbind(subject_test,subject_train)
completeData <- cbind(X,Y,subject)

mean_std_data <- completeData %>% select(subject,activity,contains("mean"),contains("std"))

mean_std_data$activity <- activities[mean_std_data$activity,"activity"]

names(mean_std_data) <- gsub("^t","time",names(mean_std_data))
names(mean_std_data) <- gsub("^f","frequency",names(mean_std_data))
names(mean_std_data) <- gsub("-mean()","Mean",names(mean_std_data))
names(mean_std_data) <- gsub("-meanFreq()","MeanFrequency",names(mean_std_data))
names(mean_std_data) <- gsub("-std()","std",names(mean_std_data))
names(mean_std_data) <- gsub("Acc","Acceleration",names(mean_std_data))
names(mean_std_data) <- gsub("Gyro","Gyroscope",names(mean_std_data))
names(mean_std_data) <- gsub("Mag","Magnitude",names(mean_std_data))
names(mean_std_data) <- gsub("\\(\\)","",names(mean_std_data))
names(mean_std_data) <- gsub("-","",names(mean_std_data))
names(mean_std_data) <- gsub("\\(",".",names(mean_std_data))
names(mean_std_data) <- gsub(",",".",names(mean_std_data))
names(mean_std_data) <- gsub("\\)","",names(mean_std_data))

finalData <- mean_std_data %>% group_by(subject,activity) %>% summarise_all(mean)

write.table(finalData,"finalData.txt",row.names = FALSE)