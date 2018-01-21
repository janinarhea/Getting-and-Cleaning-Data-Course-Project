# (1) Check if file exists. If yes, unzip the file. Otherwise, download it.
filename <- "getdata_dataset.zip"
if(!file.exists(filename)){
        download.file(url = paste("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20Dataset.zip", 
                                  sep = ""),
                destfile = filename, mode = 'wb', cacheOK = FALSE)
}
if(!file.exists("UCI HAR Dataset")){
        unzip(filename)
}
        
# (2) Load activity labels as tables. Convert the class of activity into characters.
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])

# (3) Load features as tables. Convert the class of features as characters.
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# (4) Extract the mean and standard deviation of each measurement.
featuresWanted <- grep(".*mean.*|.*std.*", features[,2])
featuresWanted.names <- features[featuresWanted, 2]
featuresWanted.names = gsub('-mean', 'Mean', featuresWanted.names)
featuresWanted.names = gsub('-std', 'Std', featuresWanted.names)
featuresWanted.names <- gsub('[-()]','', featuresWanted.names)

# (5) Load the training datasets, training labels, and subject.
train <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresWanted]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")

# (6) Merge training dataset, activities, and subjects.
train <- cbind(trainSubjects, trainActivities, train)

# (7) Load testing datasets, testing labels, and subject.
test <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresWanted]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")

# (8) Merge testing dataset, activities, and subjects
test <- cbind(testSubjects, testActivities, test)

# (9) Merge training and testing datasets.
CombinedData <- rbind(train, test)

# (10) Label the data set with variable names.
colnames(CombinedData) <- c("subject", "activity", featuresWanted.names)

# (11) Convert activities and subjects into factors from activityLabels.
CombinedData$activity <- factor(CombinedData$activity,
                                levels = activityLabels[,1],
                                labels = activityLabels[,2])
CombinedData$subject <- as.factor(CombinedData$subject)

# (12) Convert CombinedData into a molten dataframe.
library(reshape2)
CombinedData.melted <- melt(CombinedData, id = c("subject", "activity"))

# (13) Create an independent and tidy daata set with the average of each variable for each activity and subject.
CombinedData.mean <- dcast(CombinedData.melted, subject + activity ~ variable, mean)

# (14) Upload complete data as a text file.
write.table(CombinedData.mean, file = "TidyDataSet.txt", 
            row.names = FALSE, quote = FALSE)

