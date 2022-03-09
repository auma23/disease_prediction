library(tidyverse)
library(randomForest)
library(caret)
dim(Training)
data_set<-Training[,-length(Training)]
dim(data_set)
names(data_set)
data_set<-data_set %>% 
  rename(spotting_urination=`spotting_ urination`)
data_set<-data_set %>%
  rename(fluid_overload_46=fluid_overload...46)
data_set<-data_set %>%
  rename(dischromic_patches=`dischromic _patches`)
data_set<-data_set %>%
  rename(toxic_look_typhos=`toxic_look_(typhos)`)
data_set<-data_set %>%
  rename(fluid_overload_118=fluid_overload...118)
data_set<-data_set %>% 
  rename(foul_smell_of_urine=`foul_smell_of urine`)
data_set$prognosis<-factor(data_set$prognosis)
#splitting data into 70% training data and 30% test data
split1<-sample(c(rep(0,0.7*nrow(data_set)),rep(1,0.3*nrow(data_set))))
train_data<-data_set[split1==0,]
test_data<-data_set[split1==1,]

# Fit a random forest model
rf.model<-randomForest(prognosis~.,data=train_data,importance=TRUE)
rf.model
#Evaluate on the training data
print("Training data results:")
pred_train<-predict(rf.model,newdata = train_data,type = "class")
confusionMatrix(pred_train,train_data$prognosis,positive="Yes")
#Evaluate on the test data
print("Test data results:")
pred_test<-predict(rf.model,newdata = test_data,type = "class")
confusionMatrix(pred_test,test_data$prognosis,positive="Yes")
#plot the feature importance
varImpPlot(rf.model)