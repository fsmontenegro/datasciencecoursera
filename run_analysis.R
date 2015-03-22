## run_analysis.R
## JHU's Data Specialization - Getting and Cleaning Data - Project Assignment
## Mar 22, 2015
## Fernando Montenegro (fsmontenegro@gmail.com)
## 
## This script loads the UCI HAR Dataset and generates a new tidy dataset as 
## per the project instructions.


# Load dplyr package
library(dplyr)

curdir <- getwd()
# Set directory. It assumes the original .zip file was expanded in local directory
setwd("UCI HAR Dataset/")

# load activity labels
if(!exists("activity_labels")) {
  activity_labels <-read.table(file="activity_labels.txt")
}
 
# load features which will become column names
if (!exists("features")) {
  features <- read.table(file="features.txt")
}

# load subject data (test and train)
if (!exists("test_subjects")) {
  test_subjects<-read.table(file = "test/subject_test.txt")
}
if (!exists("train_subjects")) {
  train_subjects<-read.table(file = "train/subject_train.txt")  
}

# load measurements (test and train)
if (!exists("test_x")) {
  test_x<-read.table(file = "test/X_test.txt") 
}
if (!exists("test_y")) {
  test_y<-read.table(file = "test/y_test.txt")
}
if (!exists("train_x")) {
  train_x<-read.table(file = "train/X_train.txt")
}
if (!exists("train_y")) {
   train_y<-read.table(file = "train/y_train.txt")
}

# Create temporary test dataframe and set column names
test_df<-data.frame(test_subjects,test_y,test_x,stringsAsFactors = TRUE)
colnames(test_df)<-c("Subject","Activity",as.vector(features[,2]))

# Create temporary train dataframe and set column names
train_df<-data.frame(train_subjects,train_y,train_x,stringsAsFactors = TRUE)
colnames(train_df)<-c("Subject","Activity",as.vector(features[,2]))

# Merge test and train dataframes
df<-rbind(test_df,train_df)

# Adjust activity names on data frame as per labels 
df$Activity<-activity_labels[df$Activity,2]

# Select columns of interest as per project instructions
cols<-as.vector(features[grep("mean|std",features[,2]),2])

# Reduce main data frame to columns of interest
df<-df[,c("Subject","Activity",cols)]

# Generate new summary data frame with means for variables per subject per activity
newdf<-summarise_each(group_by(df,Subject,Activity),funs="mean")

# back to original directory
setwd(curdir)

# Write new dataset to disk
write.table(newdf,file = "tidydataset.txt", row.names = FALSE)

# return the new dataset
print(as.data.frame(newdf))
