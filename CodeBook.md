#Study Design

##Information on the raw Data
The raw data for this project was obtained from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip website. It contains sensor data
recovered from smart phones related to 30 subjects who performed 6 activities.
 
 The methodology for the collection of the data in the original experiment is copied below;
 
 "The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low - Frequency components, therefore a filter with 0.3 Hz cutoff - Frequency was used. From each window, a vector of features was obtained by calculating variables from the time and - Frequency domain. See 'features_info.txt' for more details. 

###For each record it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and - Frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

###The dataset includes the following files:


- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

###Notes: 
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file."

The details of the features/variables available in these files is provided below;

"The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. 
These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. 
Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner - Frequency of 20 Hz to remove noise. 
Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth
filter with a corner - Frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ).
Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag,
tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag
, fBodyGyroJerkMag. (Note the 'f' to indicate - Frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the - Frequency component with largest magnitude
meanFreq(): Weighted average of the - Frequency components to obtain a mean - Frequency
skewness(): skewness of the - Frequency domain signal 
kurtosis(): kurtosis of the - Frequency domain signal 
bandsEnergy(): Energy of a - Frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean"

###Data Transformations to Raw Data

It is noted in the original experiment that the values for the features 'are normalized and bounded within [-1,1]' effectively removing the units of measure. This process is 
performed to allow for comparison of the features despite them initially being recorded in different units of measurement (Rate of Acceleration for Accelerometer vs
Rate of Rotation for Gyroscope)

To produce the Tidy Data file for this experiment the files provided in the raw data set were merged together to produced a single data set encompassing both the 
test and train data.

This was achieved using the following transformations
*add features.txt as column names (with R's name() function) to X_test and X_train
*add y_train as column 1 to X_train and y_test as column 1 to X_test
*add subject_train as column 1 to X_train and subject_test as column 1 X_test
*use the index value added from y_train/y_test to lookup the string description from activity_labels.txt and add this as an extra column.
*bind the two data frames together to produce a single data frame incorporating both train and test data for all observations of all variables.

From the 561 variables recorded in the raw data set only those related to measurements of the Mean or Standard deviation were extracted this included those records 
derived from the other measurements resulting in 86 variables. This was achieved by matching the variable names in the
 features.txt file with the strings 'Mean', 'mean' or 'std' using the grep() function in R 3.2.1.
 
The feature names were transformed to make them more readable by expanding abbrevations with full words using the gsub() function. The following notes from the 
features_info.txt file of the original experiment were used as guides for the expansion of t and f;

'These time domain signals (prefix 't' to denote time)
AND
(Note the 'f' to indicate - Frequency domain signals)'

The expansions applied are listed below;
 
'BodyAcc' =  ' Body Accelerometer'
'BodyGyro' = ' Body Gyroscope'
'GravityAcc' = ' Gravity Accelerometer'
'GravityGyro' = ' Gravity Gyroscope'
'Freq', ' - Frequency'
'Mag', ' Magnitude'
'f ', 'Time Domain '
't ', '- Frequency Domain '

Some additional cleanup of the names was done to remove double spaces and other minor grammatical oddities from the names and make them Syntactically accurate for R
as per the make.names() function

#Code Book
The columns in the Tidy Data set are calculated as averages of the variables described above per subject and activity and are listed below;

- Subject: Subject of the observations. Integer from 1 to 30
- Activity_Name: Name of the activity Observed. String taken from activity_labels.txt
- Time_Domain_Body_Accelerometer_Mean_X
- Time_Domain_Body_Accelerometer_Mean_Y
- Time_Domain_Body_Accelerometer_Mean_Z
- Time_Domain_Body_Accelerometer_std_X
- Time_Domain_Body_Accelerometer_std_Y
- Time_Domain_Body_Accelerometer_std_Z
- Time_Domain_Gravity_Accelerometer_Mean_X
- Time_Domain_Gravity_Accelerometer_Mean_Y
- Time_Domain_Gravity_Accelerometer_Mean_Z
- Time_Domain_Gravity_Accelerometer_std_X
- Time_Domain_Gravity_Accelerometer_std_Y
- Time_Domain_Gravity_Accelerometer_std_Z
- Time_Domain_Body_Accelerometer_Jerk_Mean_X
- Time_Domain_Body_Accelerometer_Jerk_Mean_Y
- Time_Domain_Body_Accelerometer_Jerk_Mean_Z
- Time_Domain_Body_Accelerometer_Jerk_std_X
- Time_Domain_Body_Accelerometer_Jerk_std_Y
- Time_Domain_Body_Accelerometer_Jerk_std_Z
- Time_Domain_Body_Gyroscope_Mean_X
- Time_Domain_Body_Gyroscope_Mean_Y
- Time_Domain_Body_Gyroscope_Mean_Z
- Time_Domain_Body_Gyroscope_std_X
- Time_Domain_Body_Gyroscope_std_Y
- Time_Domain_Body_Gyroscope_std_Z
- Time_Domain_Body_Gyroscope_Jerk_Mean_X
- Time_Domain_Body_Gyroscope_Jerk_Mean_Y
- Time_Domain_Body_Gyroscope_Jerk_Mean_Z
- Time_Domain_Body_Gyroscope_Jerk_std_X
- Time_Domain_Body_Gyroscope_Jerk_std_Y
- Time_Domain_Body_Gyroscope_Jerk_std_Z
- Time_Domain_Body_Accelerometer_Magnitude_Mean
- Time_Domain_Body_Accelerometer_Magnitude_std
- Time_Domain_Gravity_Accelerometer_Magnitude_Mean
- Time_Domain_Gravity_Accelerometer_Magnitude_std
- Time_Domain_Body_Accelerometer_Jerk_Magnitude_Mean
- Time_Domain_Body_Accelerometer_Jerk_Magnitude_std
- Time_Domain_Body_Gyroscope_Magnitude_Mean
- Time_Domain_Body_Gyroscope_Magnitude_std
- Time_Domain_Body_Gyroscope_Jerk_Magnitude_Mean
- Time_Domain_Body_Gyroscope_Jerk_Magnitude_std
- Frequency_Domain_Body_Accelerometer_Mean_X
- Frequency_Domain_Body_Accelerometer_Mean_Y
- Frequency_Domain_Body_Accelerometer_Mean_Z
- Frequency_Domain_Body_Accelerometer_std_X
- Frequency_Domain_Body_Accelerometer_std_Y
- Frequency_Domain_Body_Accelerometer_std_Z
- Frequency_Domain_Body_Accelerometer_Mean_- Frequency_X
- Frequency_Domain_Body_Accelerometer_Mean_- Frequency_Y
- Frequency_Domain_Body_Accelerometer_Mean_- Frequency_Z
- Frequency_Domain_Body_Accelerometer_Jerk_Mean_X
- Frequency_Domain_Body_Accelerometer_Jerk_Mean_Y
- Frequency_Domain_Body_Accelerometer_Jerk_Mean_Z
- Frequency_Domain_Body_Accelerometer_Jerk_std_X
- Frequency_Domain_Body_Accelerometer_Jerk_std_Y
- Frequency_Domain_Body_Accelerometer_Jerk_std_Z
- Frequency_Domain_Body_Accelerometer_Jerk_Mean_- Frequency_X
- Frequency_Domain_Body_Accelerometer_Jerk_Mean_- Frequency_Y
- Frequency_Domain_Body_Accelerometer_Jerk_Mean_- Frequency_Z
- Frequency_Domain_Body_Gyroscope_Mean_X
- Frequency_Domain_Body_Gyroscope_Mean_Y
- Frequency_Domain_Body_Gyroscope_Mean_Z
- Frequency_Domain_Body_Gyroscope_std_X
- Frequency_Domain_Body_Gyroscope_std_Y
- Frequency_Domain_Body_Gyroscope_std_Z
- Frequency_Domain_Body_Gyroscope_Mean_- Frequency_X
- Frequency_Domain_Body_Gyroscope_Mean_- Frequency_Y
- Frequency_Domain_Body_Gyroscope_Mean_- Frequency_Z
- Frequency_Domain_Body_Accelerometer_Magnitude_Mean
- Frequency_Domain_Body_Accelerometer_Magnitude_std
- Frequency_Domain_Body_Accelerometer_Magnitude_Mean_- Frequency
- Frequency_Domain_Body_Accelerometer_Jerk_Magnitude_Mean
- Frequency_Domain_Body_Accelerometer_Jerk_Magnitude_std
- Frequency_Domain_Body_Accelerometer_Jerk_Magnitude_Mean_- Frequency
- Frequency_Domain_Body_Gyroscope_Magnitude_Mean
- Frequency_Domain_Body_Gyroscope_Magnitude_std
- Frequency_Domain_Body_Gyroscope_Magnitude_Mean_- Frequency
- Frequency_Domain_Body_Gyroscope_Jerk_Magnitude_Mean
- Frequency_Domain_Body_Gyroscope_Jerk_Magnitude_std
- Frequency_Domain_Body_Gyroscope_Jerk_Magnitude_Mean_- Frequency
- Angle_Time_Domain_Body_Accelerometer_Mean_gravity
- Angle_Time_Domain_Body_Accelerometer_Jerk_Mean_gravity_Mean
- Angle_Time_Domain_Body_Gyroscope_Mean_gravity_Mean
- Angle_Time_Domain_Body_Gyroscope_Jerk_Mean_gravity_Mean
- Angle_X_gravity_Mean
- Angle_Y_gravity_Mean
- Angle_Z_gravity_Mean


