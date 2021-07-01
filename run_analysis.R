#Importing the data frames
X_train <- fread("X_train.txt")
X_test <- fread("X_test.txt")
y_train <- fread("y_train.txt")
y_test <- fread("y_test.txt")
subject_train <- fread("subject_train.txt")
subject_test <- fread("subject_test.txt")

#Creating complete train and test sets
train <- data.frame(subject_train,y_train,X_train)
test <- data.frame(subject_test,y_test,X_test)

#Merging train and test into complete dataset
complete_df <- rbind(train,test)

#Getting the means
colMeans(complete_df[,1:562])


#Getting the SDs
colSds(as.matrix(complete_df[,1:562]))

# Labelling the activities with the descriptive names:
df <- data.frame()
for (i in 1:nrow(complete_df)){
if(complete_df[i,2] == 1){
  label <- "Walking"
} else if(complete_df[i,2] == 2){
  label <- "Walking upstairs"
} else if(complete_df[i,2] == 3){
  label <- "Walking downstairs"
} else if(complete_df[i,2] == 4){
  label <- "standing"
} else if(complete_df[i,2] == 5){
  label <- "sitting"
} else if(complete_df[i,2] == 6){
  label <- "laying"
}
df[i,1] <- label
}

complete_df <- data.frame(df,complete_df)
   
#Inserting the column names
labels <- fread("features.txt")
for (i in 1:nrow(labels)){
colnames(complete_df)[i+3] <- labels[i,2]
}
colnames(complete_df)[1]<- "descriptive_activity"
colnames(complete_df)[2]<- "number_subject"
colnames(complete_df)[3]<- "number_activity"

#Creating the other DF
agg_df <- aggregate.data.frame(complete_df[,2:564],complete_df[c("number_subject", "descriptive_activity")],mean)


#Exporting the aggregate dataset
write.table(agg_df,"agg.txt",row.name = FALSE)
