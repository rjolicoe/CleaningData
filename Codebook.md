Codebook  for the Getting and Cleaning data assignment
============

Here is the codebook for this assignment detailing the: 

Variables, the data and transformations that we utilized to clean up the data

1).  The first step that I did and placed as a comment section in the file is to make sure the working directory is set to
     the UCI HAR Dataset.  If that is not set you can change the working directory before you get started.  
     My code was written with the assumption that the working directory was changed before implementing the code. 
     
2).  Once the working directory has been established we read in the features text and the activity labels text into R. 
     I chose to read these two variables in first in that way you can utilize calling these functions later in the code.
     I determined it was easier to read these in first and then use them later.  I utilize the read.table file frequently
     in this assignment as I found it the most robust to read the text files.  I read the features text and assigned the
     variable features to it and read in the activity labels text file in next assigning it the variable activitylabel.
     
3).  Next, I read in the training data utilizing read.table("./train/...)  to access the file that the train data was
     located in.  I created three variables subjecttrain, Xtrain and Ytrain.  In subjecttrain and Ytrain it was important 
     to utilize the col.names to designate subjectid and activityid.

4).  The following step that I implemented is reading in the test data.  I used similar read.table("./test/...) to access
     the data that was in the test file.  I created the variables subjecttest, Xtest, and Ytest.  I again here had to 
     designate the col.names for subjecttrain and Ytrain to designate subjectid and activityid.
     
5).  Next, for both the variables for the training data and the test data I assigned row numbers as the the id column
     I was able to do this at the same time for all six variables, three for the train data and three for the test data.  
     
6).  Now that all data has been read in and assigned appropriate variables we can merge the data.  First I merged the 
     subjecttrain data and the Ytrain data and assigned a new variable trainingdata.  I then merged that data with the 
     Xtrain data and rename that new variable trainingdata.  I performed the same process on the test data and created
     a variable called testdata.  Once that was completed I finally use the rbind command to bind the data of
     trainingdata and testdata together.  

7).  Now I utilzed the grepl command to extract the mean and standard deviation only from the features variable.  
     I created a variable called specialfeatures and extracted mean and standard deviation on the subset 
     features$features_label.

8).  This step I utilized to name the activities in the dataset based upon descriptive activities.  Here I created
     two new variables called finaldata2 and finaldata3.  In finaldata2 I subset the columns of 1,2,3 and 
     specialfeatures$featureid+3.  
     
9).  Now once those variables have been created I can label the dataset with the activity names.  I assign the 
     names specialfeatures$feature_label to clean up the data and view appropriate spacing.  
     
10). Next, I created a for loop through the specialfeatures$features_label to run for i in 
     1:length(specialfeatures$feature_label).  Once the for loop ran successfully I assigned a new variable called
     finaldata4 = finaldata3 reflecting the transformation that finaldata3 went through during the for loop.  
     
11). Lastly I prepared the average for each activity and each subject.  I created several variables in this stage
     to move through the transformations preparing the data.  The first variable that I created was the remove variable
     which is based upon c("ID", "activitylabel").  Then I created a new variable called finaldata5 which is a 
     subset of finaldata4 where i analyzed the columns and use %in% to search for corresponding information that
     is in the remove variable to subset final data4.  
     
12). Next I created a new variable called compileddata where I utilize the aggregate function to collapse the data
     by using the BY variables and the defined function.  I utilize aggregate on finaldata5 and collapse using by=list on
     subject = finaldata5$subject_id and then activity on finaldata$5 subset on the activity id
     
13).  Then I rename the remove based upon c("subject", "activity").  From there I can look at the compileddata variable
      and look for data that is not in the remove function to rewrite.  Once that part is completed I can make a new
      compileddata variable that is created by using the merge function on (compileddata, activitylabel).  
      
14).  Now that my data is completed and "tidy" I can go ahead and utilize the write.csv function to make a csv file 
      I then used cutepdf to print my tidy dataset as a pdf so I could upload it to the coursera website.  
    
