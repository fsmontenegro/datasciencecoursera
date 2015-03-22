README.md
==========

This files describes the logic behind the data manipulation performed on the UCI HAR Dataset to generate the tidy dataset as required by the course project for JHU's Data Specialization - Getting and Cleaning Data.

Assumptions:
- This script assumes the original .ZIP file has been expanded in the current directory.
- This script also assumes that the 'dplyr' package has been previously installed.

The main steps that the run_analysis.R script performs are:
- set up environment
- load all relevant files as distinct data frames
- create intermediary data frames for processing
- create final data frame using dplyr functions
- write final data frame to disk and print data frame as output

First, the dplyr package is loaded and the right current directory is set to the "UCI HAR Dataset" subdirectory.

Each relevant data file - activity_labels.txt, features.txt, subject_test.txt, subject_train.txt, X_test.txt, y_test.txt, X_train.txt, and y_train.txt - is loaded into an separate dataframe for easier processing. The script checks the existence of each dataframe prior to loading the data.

Once the individual files are loaded as independent data frames, two intermediary data frames are created using a simple concatenation of same sized data frames: one for test data and one for train data. For each of these data frames, column names are adjusted as follows:
- subject ID is coded manually as "Subject"
- activity ID is coded manually as "Activity"
- the other columns (all 561 columns from the original data sets) are labelled automatically using the name of the variables from the 'feature' dataset.

The script then creates the main data frame by row binding the test and train data frames.

As per the project requirement, the Activity levels on the data frame are rewritten using descriptions from the activity labels dataset.

As per the project requirement, the main dataset needs to be purged of the columns that are not of interest. This is done in two steps:
1- Select the specific columns by finding those that refer to 'mean' and 'std', as per the original codebook. Add to this the two columns for subject and activity.
2- Re-create the main dataset selecting only the columns from step 1.

A new data frame (newdf) is created using the dplyr functionality of grouping by Subject and Activity then summarizing remaining columns using the 'mean' function. This is the final 'tidy data set' as required by the project.

The script ends by resetting the current directory, writing the new data frame to disk - tidydataset.txt - and printing the output.

Extra
-----
To validate that the file has been properly created, it can be loaded in R Studio as follows:
```r
tidy <- read.table("tidydataset.txt",check.names = FALSE, header = TRUE)
```
