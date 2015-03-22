features<-read.delim(file="Datos/features.txt",sep="",header=FALSE)

datosTrain<-read.delim(file="Datos/train/X_train.txt",sep="",header=FALSE)
names(datosTrain)<-features[,2]

labelsTrain<-read.delim(file="Datos/train/Y_train.txt",sep="",header=FALSE)
subjectTrain<-read.delim(file="Datos/train/subject_train.txt",sep="",header=FALSE)

datosTrain<-cbind(subjectTrain,labelsTrain,datosTrain,header=FALSE)
colnames(datosTrain)[1]<-"subject"
colnames(datosTrain)[2]<-"activity"

datosTest<-read.delim(file="Datos/Test/X_test.txt",sep="",header=FALSE)
names(datosTest)<-features[,2]

labelsTest<-read.delim(file="Datos/Test/Y_test.txt",sep="",header=FALSE)
subjectTest<-read.delim(file="Datos/Test/subject_test.txt",sep="",header=FALSE)

datosTest<-cbind(subjectTest,labelsTest,datosTest,header=FALSE)
colnames(datosTest)[1]<-"subject"
colnames(datosTest)[2]<-"activity"

datosTotal<-rbind(datosTrain,datosTest)

datosTotal$activity<-as.factor(datosTotal$activity)
levels(datosTotal$activity)<-c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")

meansAndStd<-datosTotal[,grepl("subject|activity|mean|std",names(datosTotal))]

tidy_data<-group_by(meansAndStd,subject,activity) %>% summarise_each(funs(mean))
