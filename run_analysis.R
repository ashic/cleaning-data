
downloadData <- function(){
    tmp <- tempfile()
    download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip', destfile=tmp)
    tmp
}


loadData <- function(file){

    x_train <- read.table(unz(file, 'UCI HAR Dataset/train/X_train.txt'))
    x_test <- read.table(unz(file, 'UCI HAR Dataset/test/X_test.txt'))
    
    y_train <- read.table(unz(file, 'UCI HAR Dataset/train/y_train.txt'))
    y_test <- read.table(unz(file, 'UCI HAR Dataset/test/y_test.txt'))
    
    subject_train <- read.table(unz(file, 'UCI HAR Dataset/train/subject_train.txt'))
    subject_test <- read.table(unz(file, 'UCI HAR Dataset/test/subject_test.txt'))
    
    features <- read.table(unz(file, "UCI HAR Dataset/features.txt"), header=F, colClasses="character")
    activities <- read.table(unz(file, "UCI HAR Dataset/activity_labels.txt"), header=F, colClasses="character")
        
    
    list(x_train = x_train, x_test = x_test, 
         y_train = y_train, y_test = y_test, 
         subject_train = subject_train, subject_test = subject_test,
         features = features,
         activities = activities)
}

mergeData <- function(l) {
    list(X = rbind(l$x_train, l$x_test), Y = rbind(l$y_train, l$y_test), S = rbind(l$subject_train, l$subject_test))
}


extract_mean_std_features = function(X, features) {
    target_features <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
    X <<- X[, target_features]
    names(X) <<- features[target_features, 2]
    names(X) <<- gsub("\\(|\\)", "", names(X))
    names(X) <<- tolower(names(X))
    X
}


f <- downloadData()
d <- loadData(f)

#1: merge into one dataset...Keeping X, Y, and S separate for now for easier column naming. Will merge later. 
#   This is to maintain the sequence of steps outlined in the question.
m <- mergeData(d)


unlink(f)