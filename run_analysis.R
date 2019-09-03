


#  sorry- I know my naming conventions are bad and make the code hard to follow; need to improve on that.
#  steps:
#  1.  load the activity and subject files for both test and train and rename the columns to descriptive names;
#  2.  cbind actvity and subject; add 'Set' column to distinguish between test and train subjects. 
#  3.  load the test and train data and name the columns with names from the features file;
#  4.  cbind subject and test and then rbind to the test and train data.  this is now the fully merged raw dataset.
#  5.  Use grep to select only the columns that end in mean() or std ();
#  6.  Use Melt to to have all measures under one variable;  this is now a tidy dataset; add labels for activity and set factors
#  7.  use dcast to create the average for each measure for each subject.


library(dplyr)


##  1.  load the activity and subject files for both test and train and rename the columns to descriptive names;

st<- read.table("C:/Users/stevene/Documents/UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)

st_df<-tbl_df(st)


colnames(st_df) <- c("subject")


td<- read.table("C:/Users/stevene/Documents/UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)

td_df<-tbl_df(td)

colnames(td_df) <- c("subject")


yt<- read.table("C:/Users/stevene/Documents/UCI HAR Dataset/test/y_test.txt", sep="", header=FALSE)

yt_df<-tbl_df(yt)

colnames(yt_df) <- c("activity")



tt<- read.table("C:/Users/stevene/Documents/UCI HAR Dataset/train/y_train.txt", sep="", header=FALSE)

tt_df<-tbl_df(tt)

colnames(tt_df) <- c("activity")




#  2.  cbind actvity and subject; add 'Set' column to distinguish between test and train subjects. 

styt<-cbind(st_df,yt_df)

styt$set <-c("t")  



test_data<-cbind(styt,xt_df)
train_data<-cbind(tdtt,xtr_df)


tdtt<-cbind(td_df,tt_df)

tdtt$set <-c("p")





# 3.  load the test and train data and name the columns with names from the features file;



xt<- read.table("C:/Users/stevene/Documents/UCI HAR Dataset/test/x_test.txt", sep="", header=FALSE)

xt_df<-tbl_df(xt)

feat<- read.table("C:/Users/stevene/Documents/UCI HAR Dataset/features.txt", sep="", header=FALSE)
feat_names<-feat[1:561,2]

colnames(xt_df) <- feat_names




xtr<- read.table("C:/Users/stevene/Documents/UCI HAR Dataset/train/x_train.txt", sep="", header=FALSE)

xtr_df<-tbl_df(xtr)

feat<- read.table("C:/Users/stevene/Documents/UCI HAR Dataset/features.txt", sep="", header=FALSE)
feat_names<-feat[1:561,2]

colnames(xtr_df) <- feat_names


#  4.  cbind subject and test and then rbind to the test and train data.  this is now the fully merged raw dataset.



test_data<-cbind(styt,xt_df)
train_data<-cbind(tdtt,xtr_df)

tdtt<-cbind(td_df,tt_df)

test_train_combined= rbind(test_data,train_data)



#5.  Use grep to select only the columns that end in mean() or std ();

mymean<-test_train_combined[,grepl("mean\\(\\)", colnames(test_train_combined))]
mystd<-test_train_combined[,grepl("std\\(\\)", colnames(test_train_combined))]
mean_std<-cbind(mymean,mystd)


mean_std_final<-cbind(test_train_combined[,1:3],mean_std)

mean_std_final2<-mean_std_final[,!grepl("^f", colnames(mean_std_final))]

mean_std_final3<-mean_std_final2[,!grepl("X$|Y$|Z$", colnames(mean_std_final2))]




#  6.  Use Melt to to have all measures under one variable;  this is now a tidy dataset; add labels for activity and set factors


mean_std_final4<-melt(mean_std_final3,id.vars =c("subject","activity","set"))


mean_std_final4$activity<-factor(mean_std_final4$activity,labels = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")))

mean_std_final4$set<-factor(mean_std_final4$set,labels = c("TRAINING", "TEST"))




#  7.  use dcast to create the average for each measure for each subject.

sub_mean<-dcast(mean_std_final4,subject ~ variable,mean)




######  validation: Get detail for a random subject and see if the data makes sense.   I chose subject 25 and the observations for LAYING and SITTING

mean_std_final4[grepl(25,mean_std_final4$subject)& grepl("LAYING|SITTING",mean_std_final4$activity),]

##  result was 1308 rows.  I believe this is a  reasonable amount given that 560 measures were compressed into the Variables column.









