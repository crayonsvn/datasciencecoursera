Getting and Cleaning Data Project
=================================
Files:
-------
1. README.txt : general information & instruction
2. R script: run_analysis.R 
3. cookbook.pdf : contains desciptions of variables/column names which will be used in the final output dataset

How to run the script: 
----------------------
1. Place the script in R main directory
2. Ensure "UCI HAR Dataset" raw dataset is in R main directory too
3. Open the script in R studio
4. The script is written for Window platform. Please modify the file names in the script accordingly when you run in Mac OS
5. The script will produce finalData.txt in "UCI HAR Dataset" directory. Please ensure no such file exists.
6. Run the script

What the script does?
----------------------
1. Read raw data into R
2. Merge & bind the data lists when renaming the columns
3. Extract only Mean and Standar deviation for each measurements, i.e. column names that contain mean() or std()
4. Clean the column names, by making them more descriptive and removing unnecessary characters such as "-" and "("
5. Find mean of each variable for each activity and each subject by reshaping the data
6. Write the final data to text file



Source of the raw datasets
----------------------------
Human Activity Recognition Using Smartphones Dataset - Version 1.0
URL https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

