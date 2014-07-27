#Make sure working directory is set to UCI HAR Dataset
#The first step we have to do is to read in the features and activity types into R
features      = read.table("./features.txt", col.names = c("feature_id", "feature_label"),)
activitylabel = read.table("./activity_labels.txt", col.names = c("activity_id", "activity_label"),)

#We will read in the training data
subjecttrain = read.table("./train/subject_train.txt", col.names = c("subject_id"))
Xtrain = read.table("./train/X_train.txt")
Ytrain = read.table("./train/y_train.txt", col.names = c("activity_id"))

#Next we will read in the test data
subjecttest = read.table("./test/subject_test.txt", col.names = c("subject_id"))
Xtest = read.table("./test/X_test.txt")
Ytest = read.table("./test/y_test.txt", col.names = c("activity_id"))

#Assign row numbers as id column
subjecttrain$ID <- as.numeric(rownames(subjecttrain))
Xtrain$ID <- as.numeric(rownames(Xtrain))
Ytrain$ID <- as.numeric(rownames(Ytrain))
subjecttest$ID <- as.numeric(rownames(subjecttest))
Xtest$ID <- as.numeric(rownames(Xtest))
Ytest$ID <- as.numeric(rownames(Ytest))

#Now we need to merge training data and test data
trainingdata <- merge(subjecttrain, Ytrain, all=T)
trainingdata <- merge(trainingdata, Xtrain, all=T)
testdata <- merge(subjecttest, Ytest, all=T)
testdata <- merge(testdata, Xtest, all=T)
finaldata <- rbind(trainingdata, testdata)

#Now need to extract the mean and standard deviation only
specialfeatures <- features[grepl("mean\\(\\)",features$feature_label) | grepl("std\\(\\)",features$feature_label),]

#We utilize this step to name the activities in the dataset based upon the descriptive activities
finaldata2 <- finaldata[,c(c(1,2,3), specialfeatures$feature_id+3)]
finaldata3 <- merge(finaldata2, activitylabel)

#Here we label the dataset with the activity names
specialfeatures$feature_label = gsub("\\(\\)","",specialfeatures$feature_label)
specialfeatures$feature_label = gsub("-",".", specialfeatures$feature_label)

for (i in 1:length(specialfeatures$feature_label)) {
  colnames(finaldata3)[i + 3] <- specialfeatures$feature_label[i]
}
finaldata4 = finaldata3

#This final step prepares the average for each activity and subject
remove <- c("ID", "activity_label")
finaldata5 <- finaldata4[,(names(finaldata4) %in% remove)]
compileddata <- aggregate(finaldata5, by=list(subject = finaldata5$subject_id, activity = finaldata5$activity_id), FUN=mean, na.rm=T)
remove <- c("subject", "activity")
compileddata <- compileddata[!,(names(compileddata)%in% remove)]
compileddata = merge(compileddata, activitylabel)
write.csv(file="tidydataset.csv", x= compileddata)

#From here I saved my tidy dataset as a pdf to load into the coursera home page  