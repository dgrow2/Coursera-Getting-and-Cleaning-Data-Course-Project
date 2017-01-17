##############################
#Download and unzip the files#
##############################
if (!file.exists(".data")) {
     dir.create("C:/users/doug/dropbox/r/data")
} # checks for a data directory, and creates one if it doesn't already exist
fileURL<- "https://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip" #assigns a handle to the URL that points to the data
download.file(fileURL, destfile = "C:/Users/Doug/Dropbox/R/data.zip", method= "auto") # downloads the data folder
unzip(zipfile="C:/Users/Doug/Dropbox/r/data.zip",exdir = "data") #unzips the data folder and puts into a new folder, data

######################
#Read the Data into R#
######################

#test data
subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")
X_test<-read.table("/UCI HAR Dataset/test/X_test.txt")
Y_test<-read.table("/UCI HAR Dataset/test/y_test.txt")

#train data
subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")
X_train<-read.table("UCI HAR Dataset/train/X_train.txt")
Y_train<-read.table("UCI HAR Dataset/train/y_train.txt")

#features
features<-read.table("UCI HAR Dataset/features.txt")

#activity labels
activityLabels<-read.table("UCI HAR Dataset/activity_labels.txt")

#Assigning column names to the data
names(X_train)<- features$V2
names(Y_train)<- "ActivityID"
names(subject_train)<-"SubjectID"
names(X_test)<- features$V2
names(Y_test)<-"ActivityID"
names(activityLabels)<-c("ActivityID","ActivityType")
names(subject_test)<-"SubjectID"

##################
#Merging the data#
##################

#Merge X and Y datasets
trainData<-cbind(subject_train,Y_train, X_train)
testData<-cbind(subject_test,Y_test,X_test)

#Merging the Test and Train data sets

totalData<-rbind(testData,trainData)

##############################################################
#Extract the mean and standard deviation for each measurement#
##############################################################

#create an index of the all the columns with mean or std data
names<-names(totalData)
colIndex<-c(grep("SubjectID",names(totalData)),grep("ActivityID",names(totalData)), grep("mean",names(totalData)),grep("std",names(totalData)))

#subset your data according to your new index 
extractedData<-totalData[,colIndex]

#Merge Total data with the activity Key
finalData<-merge(activityLabels,extractedData,by.x="ActivityID", by.y="ActivityID")

####################################################
#Create a new tidy data set from the extracted data#
####################################################

#group the data by activity type and subject  and create group means
tidy<-aggregate(finalData, by=list(finalData$ActivityType,finalData$SubjectID), FUN = "mean", simplify = TRUE)

#rename groups for clarity
require(dplyr)
tidy<-rename(tidy, ActivityTypeGroup=Group.1, Subject=Group.2)
write.table(tidy,file = "TidyR",row.names = FALSE)

