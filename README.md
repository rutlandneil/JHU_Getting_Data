# JHU_Getting_Data
Repository to store the Course Project files for the Getting and Cleaning Data Module of JHU Data Science Specialisation on Coursera

This repository stores the files required to answer the Course project for the Getting and Cleaning data unit of the Coursera Data Scientist Specialisation.

The files contained here will allow you to take the raw data set provided for the task and recreate the Tidy Data set shown in TidyData.csv

##Files included in this repository

In this repository there are 5 files;

- getdata_projectfiles_UCI HAR Dataset.zip
- README.md
- CodeBook.md
- run_analysis.R
- TidyData.txt

##Instructions

1. Download the raw data set getdata_projectfiles_UCI HAR Dataset.zip in this repository into your R Studio working directory.
2. Run the script run_analysis.R on R version 3.2.1 (2015-06-18) 

This step will extract the raw data files into a folder called UCI HAR Dataset in your working directory and apply a number of transformations to it that produce the 
Tidy data set.

For more detail on the transformations made to the raw data see CodeBook.md in this repository

The output from run_Analysis.R will be the Tidy Data set

Each row of the Tidy data set represents a subject and activity along with the mean figure for the observations extracted.

3. To view the tidy data set in R run the following code in R Studio on R Version 3.2.1
data <- read.table("./TidyData.txt', header = TRUE)
    View(data)

