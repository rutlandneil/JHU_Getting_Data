library(data.table)
library(dplyr)
library(XML)

#sets the location of the zip file to a location in your current working directory
zipLoc<-"./getdata_projectfiles_UCI HAR Dataset.zip"

#unzips the file into a folder called UCI_HAR_Data
unzip(zipLoc)

#read in the required files from the dataset
#feature names (column labels)
featureNames<- read.table("./UCI HAR Dataset/features.txt")

#activity labels (id mapping)
activityLabels<- read.table("./UCI HAR Dataset/activity_labels.txt")

#test data
testSubjects <-read.table("./UCI HAR Dataset/test/subject_test.txt")
testActivities <-read.table("./UCI HAR Dataset/test/y_test.txt")
testReadings <-read.table("./UCI HAR Dataset/test/X_test.txt")

#training data
trainSubjects <-read.table("./UCI HAR Dataset/train/subject_train.txt")
trainActivities <-read.table("./UCI HAR Dataset/train/y_train.txt")
trainReadings <-read.table("./UCI HAR Dataset/train/X_train.txt")

#add the features as column labels for later subsetting
names(testReadings)<-featureNames[,2]
names(trainReadings)<-featureNames[,2]

#add subjects and activities to the front of the readings data sets.
testCombined<-cbind(testSubjects, testActivities,testReadings)
trainCombined<-cbind(trainSubjects, trainActivities, trainReadings)

#label the columns for Subject and Activity
names(testCombined)[1]<-"Subject"
names(testCombined)[2]<-"Activity"

names(trainCombined)[1]<-"Subject"
names(trainCombined)[2]<-"Activity"

#Join the two Combined tables together to create the master table
allCombined<-rbind(testCombined,trainCombined)

#Use subsetting to apply the index in Combined data sets to the value in activityLabels
allCombined$Activity_Name <- activityLabels[allCombined$Activity,]$V2

#subset data table so it has the columns where the name is like mean using regular
#expressions
#Mean with M added to include angle means
columns<-grep("^Activity_Name$|^Subject$|mean|std|Mean", names(allCombined))

#create a data set with only the filtered columns
filtered<-allCombined[,columns]

#rename the columns so that the activities are more descriptive
names(filtered)<-gsub('BodyAcc', ' Body Accelerometer', names(filtered), ignore.case = TRUE)
names(filtered)<-gsub('BodyGyro', ' Body Gyroscope', names(filtered), ignore.case = TRUE)

names(filtered)<-gsub('GravityAcc', ' Gravity Accelerometer', names(filtered), ignore.case = TRUE)
names(filtered)<-gsub('GravityGyro', ' Gravity Gyroscope', names(filtered), ignore.case = TRUE)

names(filtered)<-gsub('Jerk', ' Jerk', names(filtered), ignore.case = TRUE)
names(filtered)<-gsub('Mean', ' Mean', names(filtered), ignore.case = TRUE)
names(filtered)<-gsub('Freq', ' Frequency', names(filtered), ignore.case = TRUE)
names(filtered)<-gsub('Mag', ' Magnitude', names(filtered), ignore.case = TRUE)
names(filtered)<-gsub('Body Body', ' Body', names(filtered), ignore.case = TRUE)
names(filtered)<-gsub('angle', 'Angle ', names(filtered), ignore.case = TRUE)

names(filtered)<-gsub('f ', 'Frequency Domain ', names(filtered), ignore.case = TRUE)
names(filtered)<-gsub('t ', 'Time Domain ', names(filtered), ignore.case = TRUE)

#make the names syntactically correct
names(filtered)<-make.names(names(filtered))

#remove any of the periods produced from the above
names(filtered)<-gsub('\\.+', '_', names(filtered))

#remove trailing _
names(filtered)<-gsub('_$', '', names(filtered))

#Group Data by Subject and Activity name and produce a mean for each column
TidyData <- filtered %>% group_by(Subject,Activity_Name) %>% summarise_each(funs(mean))

#export tidy data
write.table(TidyData, './TidyData.txt', row.names = FALSE)