library(dplyr)

## create a temporary directory 
td = tempdir()
## create the placeholder file
tf = tempfile(tmpdir=td, fileext=".zip")

## download file 
linkZF <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(linkZF, destfile = tf, method = "libcurl")
## get file names in zipfile
fNames <- unzip(tf, list=TRUE)$Name
## unzip only the files we will need
nddFiles <- fNames[grep("Inertial",fNames, invert=TRUE)]
unzip(zipfile=tf, files=nddFiles, exdir=td)

## set working directory to temporary directory
wd <- getwd()
setwd(td)

## read feature names in features.txt
nmFeatures <- read.table(nddFiles[2], stringsAsFactors=FALSE)
## create a column in nmFeatures to match column names in others data frames (from x_test.txt and x_train.txt)
nmFeatures <- mutate(nmFeatures,strCol=paste0("V",V1))
## identify mean and standard deviation feature names in nmFeatures$V2
colStdMean <- grep("std\\(\\)|mean\\(\\)",nmFeatures$V2)

## read X_test.txt (results from test set)
x_data <- read.table(nddFiles[7])
## eliminate columns that are diferent from mean and standard deviation
x_data <- select(x_data, nmFeatures$strCol[colStdMean])
## set column names in x_data as descriptive feature names
names(x_data) <- nmFeatures$V2[colStdMean]
## read Y_test.txt (corresponding activities in results from test set)
y_data <- read.table(nddFiles[8])
names(y_data) <- "actCode"
## read subject_test.txt (corresponding subjects in results from test set)
sbj_data <- read.table(nddFiles[6])
names(sbj_data) <- "subject"

## bind results with corresponding activities and subjects (from test set)
resTest <- cbind(y_data,cbind(sbj_data,x_data))

## read X_train.txt (results from train set)
x_data <- read.table(nddFiles[11])
## eliminate columns that are diferent from mean and standard deviation
x_data <- select(x_data, nmFeatures$strCol[colStdMean])
## set column names in x_data as descriptive feature names
names(x_data) <- nmFeatures$V2[colStdMean]
## read Y_train.txt (corresponding activities in results from train set)
y_data <- read.table(nddFiles[12])
names(y_data) <- "actCode"
## read subject_train.txt (corresponding subjects in results from train set)
sbj_data <- read.table(nddFiles[10])
names(sbj_data) <- "subject"

## bind results with corresponding activities and subjects (from train set)
resTrain <- cbind(y_data,cbind(sbj_data,x_data))
rm(x_data)
rm(y_data)
rm(sbj_data)

## merge train and test data sets
resData <- rbind(resTest,resTrain)

## read activity names in activity_labels.txt
nmActiv <- read.table(nddFiles[1], stringsAsFactors=FALSE)
names(nmActiv) <- c("actCode", "activityName")

## merge activity names in resData data frame
resData <- merge(nmActiv, resData)

## eliminate column actCode from resData
resData <- select(resData, -actCode)

## write tidy data set resData 
setwd(wd)
write.table(resData, file="HAR_Mean_Std.txt", row.names=FALSE)

## create avg data set with the average of each variable for each activity and each subject
avgData <- resData %>% group_by(activityName,subject) %>% summarise_all(mean)

## write tidy data set avgData 
write.table(avgData, file="HAR_Avg.txt", row.names=FALSE)
