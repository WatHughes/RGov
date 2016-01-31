require(data.table)

DataDir = '../Data/RGov'
dir();dir(DataDir)
# [1] "2012_Richmond_Community_Survey_Data.csv"
# [2] "2012_Richmond_Community_Survey_Data.json"
# [3] "Property_Assessments_Current.csv"
# [4] "Property_Assessments_Current_Downloaded_20160130.json"
# [5] "RVA_Community_Survey_2014_Data_GEO.csv"
# [6] "RVA_Community_Survey_2014_Data_GEO.json

Survey2012 = fread(paste0(DataDir,'/','2012_Richmond_Community_Survey_Data.csv'))
# In fread(paste0(DataDir, "/", "2012_Richmond_Community_Survey_Data.csv")) :
#   Bumped column 185 to type character on data row 40, field contains
#   'HISPANIC'. Coercing previously read values in this column from logical,
#   integer or numeric back to character which may not be lossless
str(Survey2012)
# Classes ‘data.table’ and 'data.frame':	1371 obs. of  193 variables:
#  $ ID Number                                                           : int  2 3 4 5 6 7 8 9 11 12 ...
#  $ Q1A Quality of life in city                                         : int  3 5 4 4 4 4 5 3 3 1 ...
#  $ Q1B Quality of public schools in city                               : int  2 9 2 3 3 2 1 1 1 1 ...
#  $ Q1C Quality of city services                                        : int  4 5 3 3 4 3 2 4 1 1 ...
#  $ Q1D Feeling of safety in Richmond                                   : int  3 4 3 2 4 3 4 4 1 1 ...
#  $ Q2A Quality of parks recreation and community programs/facilities   : int  4 9 4 4 9 5 2 4 2 9 ...
#  $ Q2B Maintenance city streets and sidewalks
names(Survey2012)[185]
# [1] "Q28 Other
