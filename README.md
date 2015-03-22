# GCleaningData
This repository contains a R script that works on raw data from a
study called "Human Activity Recognition Using Smartphones Data Set"

This data set contains multiple variables obtained by a smartphone
while the study subjects were doing several activities.

The script reads these data from a repository (test and train sets) also
reads other files that contains metadata: study subjects id's and
activity labels.

Once all this data are loaded the observations are merged and joined
whit the metadata to obtain a new data set.

From this dataset it's subsetting the information referred to the
means and standard deviations from each variable.

Grouping the dataset obtained in the last step by subject id and
activity it's possible to obtain the mean of each variable for each group. 

 
GCleaningData
