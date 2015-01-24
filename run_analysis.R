library(base)
library(utils)
library(data.table)

downloadData <- function () {
  # This function for download from the course website represent
  # data collected from the accelerometers from the Samsung Galaxy S smartphone.
  dataURL <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
  dataFile <- 'dataset.zip'
  
  download.file(dataURL, destfile = dataFile)
  unzip(dataFile)
}


readDataSet <- function (dataSetName, features, labels) {
  # This function for read data file.
  # Prepare file name.
  prefixName <- paste(dataSetName, '/', sep = '')
  
  dataFilename <- paste(prefixName, 'X_', dataSetName, '.txt', sep = '')
  dataLabel <- paste(prefixName, 'y_', dataSetName, '.txt', sep = '')
  dataSubject <- paste(prefixName, 'subject_', dataSetName, '.txt', sep = '')
  
  data <- read.table(dataFilename)[, features$index]
  names(data) <- features$name
  labelSet <- read.table(dataLabel)[, 1]
  data$label <- factor(labelSet, levels=labels$level, labels=labels$label)
  subjectSet <- read.table(dataSubject)[, 1]
  data$subject <- factor(subjectSet)
  # convert to data table
  data.table(data)
}


runAnalysis <- function () {
  dataSetPath = 'UCI HAR Dataset/'
  setwd(dataSetPath)
  # Read feature names from features.txt
  featureFile <- read.table('features.txt', col.names = c('index', 'name'))
  # Grab only  mean and standard deviation for each measurement.
  features <- subset(featureFile, grepl('-(mean|std)[(]', featureFile$name))
  
  #Read activity label from file.
  labelFile <- read.table('activity_labels.txt', col.names = c('level', 'label'))
  
  # Read train and test data set from our readDataSet function.
  trainSet <- readDataSet('train', features, labelFile)
  testSet <- readDataSet('test', features, labelFile)
  
  #Combile trainset + testset = sumSet
  sumSet <- rbind(trainSet, testSet)
  # Generate tidy data set
  tidyDataSet <- sumSet[, lapply(.SD, mean), by=list(label, subject)]
  #Rename variable names 
  names <- names(tidyDataSet)
  names <- gsub('-std', 'Std', names) # Replace `-std' by 'Std'
  names <- gsub('-mean', 'Mean', names) # Replace `-mean' by `Mean'
  names <- gsub('[()-]', '', names) # Remove the parenthesis and dashes
  names <- gsub('BodyBody', 'Body', names) # Replace `BodyBody' by `Body'
  names <- gsub('tBody', 'timeBody', names)
  names <- gsub('tGravity', 'timeGravity', names)
  names <- gsub('fBody', 'frequencyBody', names)
  names <- gsub('subject', 'volunteerID', names)
  names <- gsub('label', 'activityName', names)
  
  setnames(tidyDataSet, names)
  
  #Export data set to CSV file
  setwd('..')
  write.csv(sumSet, file = 'sumDataSet.csv', row.names = FALSE)
  write.csv(tidyDataSet, file = 'tidyDataSet.csv',row.names = FALSE, quote = FALSE)
  
  #Return tidy data set
  tidyDataSet
}
