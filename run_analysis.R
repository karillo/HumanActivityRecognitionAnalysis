### Download and extract Dataset
if(!file.exists("./UCI HAR Dataset")){
  path <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  zipfile <- 'UCI HAR Dataset.zip'
  download.file(path, destfile=zipfile, method="curl", extra=c('--silent', '-w "[%{filename_effective}] Size:%{size_download} Speed:%{speed_download} Time:%{time_connect} Elapsed%{time_total}\n"'))
  unzip(zipfile)
}

### Identify Activities and Features (and the subset of mean() and std() features)
labels.activity <- read.delim("UCI HAR Dataset/activity_labels.txt", header=FALSE, sep=" ", col.names=c('activityID','activity'))
labels.features <- read.delim("UCI HAR Dataset/features.txt", header=FALSE, sep=" ", col.names=c('featureID','feature'))
subset.features <- labels.features[grepl('-(mean|std)\\(\\)', labels.features$feature),]

### Load an individual set of data and return only the columns of interest
load.set <- function(set){
  ## Assert files exist
  dir <- file.path("UCI HAR Dataset",set)
  file.subject <- file.path(dir, paste("subject_",set,".txt",sep=""))
  file.activity <- file.path(dir, paste("y_",set,".txt",sep=""))
  file.observations <- file.path(dir, paste("X_",set,".txt",sep=""))
  stopifnot(file.exists(dir), file.exists(file.subject), file.exists(file.activity), file.exists(file.observations))
  
  ### Read from disk and set column names correctly
  subjects <- read.delim(file.subject, header=FALSE, sep=" ", col.names=c('subject'))
  activities  <- read.delim(file.activity, header=FALSE, sep=" ", col.names=c('activityID'))
  observations <- read.table(file.observations, col.names=labels.features$feature, colClasses=c("numeric"))
  
  ### Combine sources and return only those observations (mean() and std()) we're interested in.
  return( cbind(subjects, activities, observations[, subset.features$featureID]))
}

### Combine sets and add readable activity labels
combined <- rbind(load.set("train"), load.set("test"))
combined <- merge(labels.activity, combined)

### Determine mean for each subject/activity combination
require(reshape2)
melted <- melt(combined,id=c("subject","activity", "activityID"))
tidy <- dcast(melted, subject + activity ~ variable, mean)

### Save the tidy file
write.csv(tidy, file="tidy.txt", row.names=FALSE)
