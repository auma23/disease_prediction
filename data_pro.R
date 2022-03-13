library(tidyverse)
library(randomForest)
view(Training)
head(Training)
dim(Training)
glimpse(Training)
names(Training)
table(Training$prognosis)
dplyr::filter(Training,Training$prognosis=="AIDS")
train_set<-Training[!complete.cases(Training),]
train_set<-train_set[,-length(train_set)]
dim(train_set)
unique(train_set$prognosis)
test_set<-Testing[,-length(Testing)]
rf<-randomForest(prognosis~.,data=train_set)
train_set$prognosis<-factor(train_set$prognosis)
class(train_set$prognosis)
glimpse(test_set)
test_set = subset(test_set, select = -c(`spotting_ urination`) )
names(test_set)
rename_with(test_set, "spotting_ urination" = spotting_urination)
test_set <- test_set %>%
  rename(`spotting_urination` = `spotting_ urination` )           
rf<-randomForest(prognosis~.,data=train_set)
train_set <- train_set %>%
  rename(`foul_smell_of_urine` = `foul_smell_of urine` )
train_set <- train_set %>%
  rename( `toxic_look_typhos` = `toxic_look_(typhos)` )
train_set <- train_set %>%
  rename( `dischromic_patches` = `dischromic _patches` )
importance(rf)
dim(train_set)
train_set<- train_set %>%
  rename(`spotting_urination` = `spotting_ urination`)
names(train_set)
