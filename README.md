## Overview

We're taking a look at series of sensor readings to evaluate Human Activity Recognition in smartphones. At [the University of California, Irvine site](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) where these data are archived, the experimental process is described:

> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

We'll look at the averages (means) of the mean values for a number of key metrics as collected for each of these activities for each of the volunteers (subjects) as described below.

## Data

The full [UCI HAR Dataset] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) supplies a series of measurements from accelerator and Gyroscope 3-axial signals taken during these six activities.

### Sources
[UCI HAR Dataset] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The data consist of three-axial time domain signals (prefixed with 't') for Body, Gravity and Gyrosope acceleration and [jerk], along with absolute magnitude measurements of the same. They also cover frequency domain signals of the three-axial Body Acceleration, Body Jerk and Gyroscope measurements, along with magnitude measurements of Body Acceleration.

### Code book

As part of the study, the mean and standard deviation of these values were calculated across each of the collections. It is these mean and standard deviation measures which are the focus of this analysis as we collect their mean value for each subject for every activity. 

###### Time Series, 3-axial
- tBodyAcc - XYZ
- tGravityAcc - XYZ
- tBodyAccJerk - XYZ
- tBodyGyro - XYZ
- tBodyGyroJerk - XYZ

###### Time Series, magnitude
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag

###### Frequency Series, 3 axial
- fBodyAcc - XYZ
- fBodyAccJerk - XYZ
- fBodyGyro - XYZ

###### Frequency Series, magnitude
- fBodyAccMag

*XYZ* indicates that mean and standard deviation data are calculated along each of the three axes for the data.

## Processed Data Set

The source data are broken into a testing core and an extracted subset used for training analytical models. To focus our attention on the mean and standard deviation for the effort, we subset each collection of data to those calculated measures for each session and recombine the testing and training sets of data.

Because these data cover several sessions for each subject for each of the six kinds of activity, we then calculate the mean values of our target data for each subject for each acitivity.

The resulting data are written to tidy.txt in the local directory.

## run_analysis.R

To utilize the run_analysis.R script, source it from within R. 

    source("run_analysis.R")
  
or from the command line:

    R --no-save < run_analysis.R

The script performs the following:

1. If the UCI Human Activity Recognition set is not unzipped in the current working directory, it will 
  download a copy of that data set and unzip it locally.
2. It reads the training and testing sets of data from the unzipped location, reduce them  
  to include only the mean and standard deviation columns (identified in the source data 
  as -mean() and -std())
3. It adds columns identifying the subject, activityID and activity to each set.
4. It calculates the mean value for each observation column when grouped by subject and activity.
5. Finally, it writes the organized data to a csv file in the local directory as "tidy.txt"



[jerk]: http://en.wikipedia.org/wiki/Jerk_(physics) "Jerk is the rate of change of acceleration, just as acceleration is the rate of change of velocity and velocity is the rate of change of position."