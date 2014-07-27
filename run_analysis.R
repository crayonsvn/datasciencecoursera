##READ RAW DATA TO R    ==============================================================
subjectTest <- read.table(".\\UCI HAR Dataset\\test\\subject_test.txt")

labelTest <- read.table(".\\UCI HAR Dataset\\test\\y_test.txt")

dataTest <- read.table(".\\UCI HAR Dataset\\test\\x_test.txt")

subjectTrain <- read.table(".\\UCI HAR Dataset\\train\\subject_train.txt")

labelTrain <- read.table(".\\UCI HAR Dataset\\train\\y_train.txt")

dataTrain <- read.table(".\\UCI HAR Dataset\\train\\X_train.txt")

labels <- read.table(".\\UCI HAR Dataset\\activity_labels.txt")

featuresdata <- read.table(".\\UCI HAR Dataset\\features.txt")

features <- levels(featuresdata[[2]])[featuresdata[[2]]]

#MERGE & BIND DATA LISTS   ====================================================================
##TEST DATA
names(labelTest)[1] <- "label_id"

names(labels)[1] <- "id"

names(labels)[2] <- "activity"

mergedData1 = merge(labelTest,labels,by.x="label_id",by.y="id")

names(subjectTest)[1] <- "subject"

mergedData2 <- cbind(subjectTest,mergedData1)

names(dataTest)[1:561] <- features

mergedData3 <- cbind(mergedData2,dataTest)

##TRAIN DATA -------------------------------------------------------------
names(labelTrain)[1] <- "label_id"

mergedData4 = merge(labelTrain,labels,by.x="label_id",by.y="id")

names(subjectTrain)[] <- "subject"

mergedData5 <- cbind(subjectTrain,mergedData4)

names(dataTrain)[1:561] <- features

mergedData6 <- cbind(mergedData5,dataTrain)

##MERGE TEST & TRAIN DATA  ------------------------------------------------
mergedData <- rbind(mergedData6,mergedData3)

#EXTRACT MEAN & STD MEASUREMENT ===================================================================
index <- 1:561
extractFeatures <- vector("character", length=0)
for (i in index){
  if(grepl("mean\\(\\)",features[i]) | grepl("std\\(\\)",features[i])){
    extractFeatures <- c(extractFeatures, features[i])
  }
}

columns <- c("subject","activity",extractFeatures)

extractData <- mergedData[,columns]

#DESCRIPTIVE VARIABLES  ===========================================================================
cleanfeatures1 <- gsub("BodyBody", "Body", extractFeatures)
cleanfeatures2 <- gsub("tBody", "TimeBody", cleanfeatures1)
cleanfeatures3 <- gsub("tGravity","TimeGravity",cleanfeatures2)
cleanfeatures4 <- gsub("fBody","FrequencyBody",cleanfeatures3)
cleanfeatures5 <- gsub("-mean\\(\\)","Mean",cleanfeatures4)
cleanfeatures6 <- gsub("-std\\(\\)","Std",cleanfeatures5)
cleanfeatures7 <- gsub("-","",cleanfeatures6)

names(extractData)[3:68] <- cleanfeatures7

#FIND MEAN OF EACH VAR FOR EACH ACTIVITY AND EACH SUBJECT =========================================== 

library(reshape2)
extractDataMelt <- melt(extractData, id=c("subject","activity"), measure.vars=cleanfeatures7)

finalData <- dcast(extractDataMelt, subject + activity ~ variable, mean)

#WRITE FINAL DATA TO TXT FILE  ====================================================================
write.table(finalData, file=".\\UCI HAR Dataset\\finalData.txt", row.names=FALSE)