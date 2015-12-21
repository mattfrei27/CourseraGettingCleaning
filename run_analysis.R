#Written by Matt F. in Dec. 2015.
#Implementation of Coursera Getting and Cleaning Data Course Project

library(dplyr)

setwd('C:/Users/matt/Dropbox/Documents/coursera/getting and cleaning data/Course Project')

download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip','raw.zip')
unzip('raw.zip')



#### Step 1 ####
#Desired output is dataframe containing all data (X,Y,and subject data for both test and train).

cols <- read.table('UCI\ HAR\ Dataset/features.txt')

train.subject <- read.table('UCI\ HAR\ Dataset/train/subject_train.txt',header=FALSE,col.names=c('subject'))
train.x <- read.table('UCI\ HAR\ Dataset/train/X_train.txt',header=FALSE,col.names=cols[,2])
train.y <- read.table('UCI\ HAR\ Dataset/train/Y_train.txt',header=FALSE,col.names=c('activity'))

test.subject <- read.table('UCI\ HAR\ Dataset/test/subject_test.txt',header=FALSE,col.names=c('subject'))
test.x <- read.table('UCI\ HAR\ Dataset/test/X_test.txt',header=FALSE,col.names=cols[,2])
test.y <- read.table('UCI\ HAR\ Dataset/test/Y_test.txt',header=FALSE,col.names=c('activity'))


all.data <- rbind(cbind(train.subject,train.x,train.y),cbind(test.subject,test.x,test.y))


#### Step 2 ####
#Desired output is dataframe containing subject and Y data as well as mean and std measurement column only.

#Get the indices of the mean and standard deviation columns
mean.or.std.indices <- grep('std|mean\\.',names(all.data))
#Instructions aren't clear about whether meanFreq and angle(tBodyAccMean,gravity) should be included
#I'm going with the most restrictive definition here. 66 columns that are defined as mean and std in the readme file.
#Add subject and y variables to list of desired columns
desired.indices <- append(mean.or.std.indices,c(1,ncol(all.data)))
mean.or.std <- all.data[,desired.indices]

#### Step 3 ####
#Desired output is same as step 2 but with y column converted to descriptive labels
activities <- read.table('UCI\ HAR\ Dataset/activity_labels.txt',header=FALSE,col.names=c('activity','activity_desc'))
out3 <- merge(mean.or.std,activities)

#### Step 4 ####
#Desired output is same as step 3 but with column names more easily understood but someone less familiar with this study
out4 <- out3
cols <- names(out4)
cols <- gsub('\\.','',cols)
cols <- gsub('^f','frequency',cols)
cols <- gsub('^t','trans',cols)
cols <- tolower(cols)
names(out4) <- cols

#### Step 5 ####
#Desired output is dataframe containing mean of each measurement column in step4 for each subject, activity combination
all(complete.cases(out4)) #No missing values
out5 <- out4 %>% group_by(subject,activity,activity_desc) %>% summarise_each(funs(mean))
write.table(out5,'table5.txt',row.name=FALSE)
