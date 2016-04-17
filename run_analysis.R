library(reshape2)

subtest<-read.table("C:/Users/Madhuri/Desktop/R/df/test/subject_test.txt", header = FALSE)
xtest<-read.table("C:/Users/Madhuri/Desktop/R/df/test/X_test.txt", header = FALSE)
ytest<-read.table("C:/Users/Madhuri/Desktop/R/df/test/y_test.txt", header = FALSE)

subtrain<-read.table("C:/Users/Madhuri/Desktop/R/df/train/subject_train.txt", header = FALSE)
xtrain<-read.table("C:/Users/Madhuri/Desktop/R/df/train/X_train.txt", header = FALSE)
ytrain<-read.table("C:/Users/Madhuri/Desktop/R/df/train/y_train.txt", header = FALSE)

features <- read.table("C:/Users/Madhuri/Desktop/R/df/features.txt", header = FALSE)
activities <- read.table("C:/Users/Madhuri/Desktop/R/df/activity_labels.txt")

x <- rbind(xtrain, xtest)
y <- rbind(ytrain, ytest)
s <- rbind(subtrain, subtest)

names(features) <- c('id','name')
index <- grep("-mean\\(\\)|-std\\(\\)", features$name) 
x <- x[,index]
names(activities) <- c('actID', 'actName')
y[, 1] = activities[y[, 1], 2]

names(y) <- "Activity"
names(s) <- "Subject"

tidyDataSet <- cbind(s, y, x)
tidyDataFile <- "C:/Users/Madhuri/Desktop/R/df/tidy_dataset.txt"
tidyDataFileAVGtxt <- "C:/Users/Madhuri/Desktop/R/df/tidy_data.txt"

p <- tidyDataSet[, 3:dim(tidyDataSet)[2]] 
tidyDataAVGSet <- aggregate(p,list(tidyDataSet$Subject, tidyDataSet$Activity), mean)

names(tidyDataAVGSet)[1] <- "Subject"
names(tidyDataAVGSet)[2] <- "Activity"

write.table(tidyDataSet, tidyDataFile)
write.table(tidyDataAVGSet, tidyDataFileAVGtxt)
