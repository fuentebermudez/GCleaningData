library(dplyr)

#This code loads the names from the variables in the 561 variables vector read from raw data and also
#the activity labels and subjectId's.
features<-read.delim(file="Datos/features.txt",sep="",header=FALSE)
labelsTest<-read.delim(file="Datos/Test/Y_test.txt",sep="",header=FALSE)
subjectTest<-read.delim(file="Datos/Test/subject_test.txt",sep="",header=FALSE)
labelsTrain<-read.delim(file="Datos/train/Y_train.txt",sep="",header=FALSE)
subjectTrain<-read.delim(file="Datos/train/subject_train.txt",sep="",header=FALSE)

#Here we load the data from the Train set and the variables names are assigned
datosTrain<-read.delim(file="Datos/train/X_train.txt",sep="",header=FALSE)
names(datosTrain)<-features[,2]

#Merging the activiti labels and Subject's ID to the data set
datosTrain<-cbind(subjectTrain,labelsTrain,datosTrain,header=FALSE)
colnames(datosTrain)[1]<-"subject"
colnames(datosTrain)[2]<-"activity"

#The same process is applied to the test set.
datosTest<-read.delim(file="Datos/Test/X_test.txt",sep="",header=FALSE)
names(datosTest)<-features[,2]
datosTest<-cbind(subjectTest,labelsTest,datosTest,header=FALSE)
colnames(datosTest)[1]<-"subject"
colnames(datosTest)[2]<-"activity"

#Merging test and train observations
datosTotal<-rbind(datosTrain,datosTest)

#Here we change the activity code for his description.It's needed to transform activity column from character
#to factor type before we can use the levels function.
datosTotal$activity<-as.factor(datosTotal$activity)
levels(datosTotal$activity)<-c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")

#Using regular expressions it's obtained the columns that contains the means and the standard deviations from
#the variables.
meansAndStd<-datosTotal[,grepl("subject|activity|mean|std",names(datosTotal))]

#Finally it's obtained the desired dataset grouping by subject and activity and applying the mean function to
#each variable.
tidy_data<-group_by(meansAndStd,subject,activity) %>% summarise_each(funs(mean))
