##code Project Getting and Cleaning Data
##Download data
  temp <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",temp)
##Assign variables names to the data
  ##test folder
  data_x_test <- read.table(unz(temp, "UCI HAR Dataset/test/X_test.txt"))
  data_y_test <- read.table(unz(temp, "UCI HAR Dataset/test/y_test.txt"))
  subject_test<- read.table(unz(temp, "UCI HAR Dataset/test/subject_test.txt"))
  ##train folder                          
  data_x_train <- read.table(unz(temp, "UCI HAR Dataset/train/X_train.txt"))
  data_y_train <- read.table(unz(temp, "UCI HAR Dataset/train/y_train.txt"))
  subject_train<- read.table(unz(temp, "UCI HAR Dataset/train/subject_train.txt"))
  ##features and subjects
  activity_label <- read.table(unz(temp, "UCI HAR Dataset/activity_labels.txt"))
  features <- read.table(unz(temp, "UCI HAR Dataset/features.txt"))
                           
##Unlink temporary file from zip file
unlink(temp)

## merge data sets
  data_x<-rbind(data_x_test,data_x_train)
  data_y<-rbind(data_y_test,data_y_train)
  subject<-rbind(subject_test,subject_train)

#Extract Mean and Std variables
#find mean and std matches
  
  mean_index<-grep("mean()",features[,2],fixed=TRUE)
  std_index<-grep("std()",features[,2],fixed=TRUE)
  variable_index<-c(mean_index,std_index)
  variable_index<-sort(variable_index)

## extract variable names and data
  
  names_variables<-features[variable_index,2]
  data_extracted_x<-data_x[,variable_index]
  
##data tidy (long form)
    
    #assign names to columns
    colNames<-c("Subject_id", "Activity", "Measurement", "Value")
    #aggregate data of subject, activity and measurements     
    data_agregate<-cbind(subject,activity[data_y[,1]],data_extracted_x)
    names_variables<-as.character(names_variables)
    names(data_agregate)<-c("Subject_id", "Activity",names_variables)
    
    #Construct a tidy data set
    #assign names to columns
    colNames<-c("Subject_id", "Activity", "Measurement", "Value")
    ##obtain the average of measurements for repeated activity and subject
   
    data_tidy<-data.frame()
    for( a in 1:6)
      for( id in 1:30)
      {
        subset.data_agregate<-subset(data_agregate,Activity==activity[a] & Subject_id==as.integer(id))
        average_meas<-colMeans(subset.data_agregate[,3:dim(data_agregate)[2]])
        data_average<-data.frame(as.integer(id),activity[a],names_variables,average_meas)
        data_tidy<-rbind(data_tidy,data_average)
        
        
      }
    
        
    names(data_tidy)<-colNames

# Write the txt file with the tidy data set
  
      write.table(data_tidy,"~/R/project getting and cleaning data/data_tidy.txt",sep="\t",row.names=FALSE)
  
