Feature Selection 
=================

The features selected for this database come from the UCI HAR Dataset.

30 subjects were divided into test and train groups.  Each wore a Samsung device that measured their movements doing six ordinary activities, e.g. walking, sitting, laying, etc...  From these measurements the study derived 560 measures, including mean and standard deviation.  

Many signals (let's call these Set 1)  were used to estimate variables of the feature vector for each pattern:  

tBodyAcc-XYZ
tGravityAcc-XYZ
etc... (about 15 additional signals)


The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
etc...  (about 20 additional variables)

In other words, Set 1 are interim values. For that reason they were not included in my dataset. 

These are the mean and standard deviation fields captured in my dataset, mean_std_final4:
 
tBodyAccMag-mean()
tGravityAccMag-mean()
tBodyAccJerkMag-mean() 
tBodyGyroMag-mean()
tBodyGyroJerkMag-mean()
tBodyAccMag-std()      
tGravityAccMag-std() 
tBodyAccJerkMag-std()
tBodyGyroMag-std()     
[10] tBodyGyroJerkMag-std() 

In addition, 'Subject' and 'Activity' were bound to the data from their respective files.   Mean_std_final4 appends test and training data.  For that reason i added field 'Set' to distinguish between test and training.  Both Activty and Set use factor labels to make the output self-descriptive.
