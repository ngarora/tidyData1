library(dplyr)

fileURL <-
"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%2OHAR%20Dataset.zip"

zipfn <- "getdata-projectfiles-UCI HAR Dataset.zip"
destdir <- "UCI HAR 
Dataset"

if (!file.exists(destdir))
{
	if (!file.exists(zipfn))
	{
		
		download.file(fileURL, destfile=zipfn)
	}
	unzip(zipfn)
}


## Read text file

raw.labels <- read.table(paste(destdir,"/activity_labels.txt",sep=""))

raw.features <- read.table(paste(destdir,"/test/subject_test.txt",sep=""),col.names=c("Subject"))

raw.test.x <- read.table(paste(destdir,"/test/x_test.txt",sep=""))

raw.test.y <- read.table(paste(destdir,"/test/y_test.txt",sep=""),col.names=c("Activity"))




dim(raw.test.subject);

dim(raw.test.x)

dim(raw.test.y)

raw.train.subject <- read.table(paste(destdir,"/train/subject_train.txt",sep=""), col.names=c("Subject"))

raw.train.x <- read.table(paste(destdir,"/train/x_train.txt",sep=""))

raw.train.y <- read.table(paste(destdir,"/train/y_train.txt",sep=""),col.names=c("Activity"))


dim(raw.test.subject);

dim(raw.test.x)

dim(raw.test.y)


raw.test <- cbind(raw.test.subject,raw.test.y,raw.test.x)


set raw.train <- cbind(raw.train.subject,raw.train.y,raw.train.x)


# merge the training and test set to create one dataset

raw.data <- rbind(raw.test, raw.train)

dim(raw.data)

activity <- tbl_bf(raw.data)

collist <- grep("[Mm]ean\\()|[Ss]td\\()",raw.features$V2)

colnames <- grep("[Mm]ean\\()|[Ss]td\\()",raw.features$V2,value=TRUE)

collist <- collist+2

collist <- c(1,2,collist)

colnames <- c("Subject","Activity",colnames)

activity$Activity <- as.character(activity$Activity)

raw.labels$V1 <- as.character(raw.labels$V1)

raw.labels$V2 <- as.character(raw.labels$V2)

for(i in 1:nrow(raw.lables))
{
	activity$Activity <- gsub(raw.labels[i,1],raw.labels[i,2],activity$Activity)
}

names(activity) <- colnames

tidy.data <- group_by(activity,Subject,Activity)

summarize_each(funs(mean))

names(tidy.data) <- colnames

## save the tidy dataset

write.table(tidy.data,"./tidydata.txt",row.name=FALSE)

## load and test

tidytest <- read.table("./tidydata.txt",header=TRUE)

dim(tidytest);

names(tidytest)
