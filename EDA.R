require(data.table)
# install.packages('rMaps')
# require(devtools)
# install_github('ramnathv/rCharts@dev')
# require(rCharts)
# install_github('ramnathv/rMaps')
# require(rMaps)
# install.packages('leaflet')

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
str(Survey2012,list.len=300)
# Classes ‘data.table’ and 'data.frame':	1371 obs. of  193 variables:
#  $ ID Number                                                           : int  2 3 4 5 6 7 8 9 11 12 ...
#  $ Q1A Quality of life in city                                         : int  3 5 4 4 4 4 5 3 3 1 ...
#  $ Q1B Quality of public schools in city                               : int  2 9 2 3 3 2 1 1 1 1 ...
#  $ Q1C Quality of city services                                        : int  4 5 3 3 4 3 2 4 1 1 ...
#  $ Q1D Feeling of safety in Richmond                                   : int  3 4 3 2 4 3 4 4 1 1 ...
#  $ Q2A Quality of parks recreation and community programs/facilities   : int  4 9 4 4 9 5 2 4 2 9 ...
#  $ Q2B Maintenance city streets and sidewalks
# ...
#  $ Q25 50-59 years                                                     : int  0 1 0 0 0 0 0 2 0 0 ...
#  $ Q25 60-69 years                                                     : int  2 0 1 0 1 0 0 0 0 1 ...
#  $ Q25 70  years                                                       : int  0 0 0 0 1 0 0 0 0 0 ...
#  $ Q26 Children who attend public schools                              : int  2 2 2 2 2 2 2 2 1 2 ...
#  $ Q27 Actively involved neighborhood association                      : int  1 2 2 2 1 2 2 2 1 2 ...
#  $ Q28 Race                                                            : int  4 1 4 4 4 4 4 4 1 1 ...
#  $ Q28 2nd                                                             : int  NA NA NA NA NA NA NA NA NA NA ...
#  $ Q28 3rd                                                             : int  NA NA NA NA NA NA NA NA NA NA ...
#  $ Q28 4th                                                             : logi  NA NA NA NA NA NA ...
#  $ Q28 Other                                                           : chr  "" "" "" "" ...
#  $ Q29 Hispanic Latino Spanish ancestry                                : int  2 1 2 2 2 2 2 2 2 2 ...
#  $ Q30 Speak Language other than English at home                       : int  2 1 2 2 2 2 2 1 2 2 ...
#  $ Q31 Own or rent home                                                : int  2 1 1 1 1 1 1 1 1 2 ...
#  $ Q32 Best describes home                                             : int  1 1 1 1 1 1 1 1 1 1 ...
#  $ Q33 How many years lived in Richmond                                : int  5 25 32 10 23 9 16 19 18 61 ...
#  $ Q34 Annual household income                                         : int  4 9 4 4 9 4 5 5 1 3 ...
#  $ Q35 Gender                                                          : int  1 1 1 2 1 1 1 2 2 2 ...
#  $ Location 1                                                          : chr  "(37587246, -77445636)" "(37511538, -77445405)" "(37542459, -77529377)" "(37550419, -77478466)" ...
#  - attr(*, ".internal.selfref")=<externalptr>
names(Survey2012)[185]
# [1] "Q28 Other


Survey2014 = fread(paste0(DataDir,'/','RVA_Community_Survey_2014_Data_GEO.csv'))
# Bumped column 195 to type character on data row 38, field contains
# 'ITALIAN/IRISH/LATIN'. Coercing previously read values in this column from
# logical, integer or numeric back to character which may not be lossless; e.g.,
# if '00' and '000' occurred bef
str(Survey2014,list.len=300)
# Classes ‘data.table’ and 'data.frame':	1418 obs. of  210 variables:
#  $ Survey ID Number                        : int  1 3 4 6 7 10 11 12 13 14 ...
#  $ Q1a Quality of life in the City         : int  4 1 4 4 4 5 4 3 9 4 ...
#  $ Q1b Quality of public schools           : int  9 1 3 2 2 9 1 1 1 1 ...
#  $ Q1c Quality of City services            : int  2 2 4 3 4 4 2 2 2 1 ...
#  $ Q1d Feeling of safety in Richmond       : int  3 1 4 3 2 4 2 2 2 4 ...
#  $ Q2a Quality of parks-recreation         : int  4 2 4 4 3 5 4 4 2 4 ...
#  $ Q2b Maintenance of city streets         : int  2 1 4 2 2 3 3 2 1 1 ...
# ...
#  $ Q25 60-69 years                         : int  0 0 0 0 0 0 0 0 0 0 ...
#  $ Q25 70+ years                           : int  0 0 0 0 0 0 0 0 0 0 ...
#  $ Q26 Children attend public schools      : int  2 2 2 2 2 2 1 2 2 2 ...
#  $ Q27 Actively involved neighborhood Assoc: int  1 2 2 1 1 2 1 2 1 2 ...
#  $ Q28 Describe your race                  : int  4 1 4 4 4 4 4 4 4 4 ...
#  $ Q28 2nd                                 : int  NA NA NA NA NA 5 NA NA NA NA ...
#  $ Q28 3rd                                 : int  NA NA NA NA NA NA NA NA NA NA ...
#  $ Q28 4th                                 : int  NA NA NA NA NA NA NA NA NA NA ...
#  $ Q28 5th                                 : logi  NA NA NA NA NA NA ...
#  $ Q28 Other                               : chr  "" "" "" "" ...
#  $ Q29 Are you Hispanic Latino Spanish     : int  1 2 2 2 2 1 2 2 2 2 ...
#  $ Q30 Speak language other than English   : int  2 2 2 2 2 2 2 2 2 2 ...
#  $ Q31 Own or rent home                    : int  1 1 1 1 1 1 1 1 1 1 ...
#  $ Q32 Have internet access at home        : int  1 2 1 1 1 1 1 1 1 1 ...
#  $ Q33 Which communication method use      : int  1 9 1 1 1 1 1 1 1 1 ...
#  $ Q33 2nd                                 : int  2 NA 2 2 2 2 2 2 2 2 ...
#  $ Q33 3rd                                 : int  3 NA 3 4 3 3 3 3 4 3 ...
#  $ Q33 4th                                 : int  4 NA NA NA NA NA NA 4 NA NA ...
#  $ Q33 5th                                 : int  NA NA NA NA NA NA NA NA NA NA ...
#  $ Q33 Other                               : chr  "" "" "" "" ...
#  $ Q34 Used Mayors MPACT SeeClickFix app   : int  3 3 3 1 3 3 3 3 3 1 ...
#  $ District                                : int  1 8 4 4 1 4 5 2 2 1 ...
#  $ Zip code                                : int  23224 23234 23225 23225 23221 23225 23225 23220 23227 23226 ...
#  $ GEO NOTES                               : chr  "Inside" "Inside" "Inside" "Inside" ...
#  $ Location 1                              : chr  "(37.571118, -77.496604)" "(37.484496, -77.441099)" "(37.528943, -77.491135)" "(37.522857, -77.481074)" ...
#  - attr(*, ".internal.selfref")=<externalptr>
InCommon=data.table(s2012=tolower(names(Survey2012)),s2014=tolower(names(Survey2014)[1:193]))
head(InCommon)
InCommon[,Match:=(s2012==s2014)]
InCommon[,sum(Match)]
# 5
InCommon
#                                      s2012                                    s2014 Match
#   1:                             id number                         survey id number FALSE
#   2:           q1a quality of life in city          q1a quality of life in the city FALSE
#   3: q1b quality of public schools in city            q1b quality of public schools FALSE
#   4:          q1c quality of city services             q1c quality of city services  TRUE
#   5:     q1d feeling of safety in richmond        q1d feeling of safety in richmond  TRUE
#  ---
# 189:               q32 best describes home q27 actively involved neighborhood assoc FALSE
# 190:  q33 how many years lived in richmond                   q28 describe your race FALSE
# 191:           q34 annual household income                                  q28 2nd FALSE
# 192:                            q35 gender                                  q28 3rd FALSE
# 193:                            Location 1                                  q28 4th FALSE
# That isn't useful. So match on the first token. Note I could match more by matching the first
# 2 tokens but many of those matches are not meaningful, e.g., 2nd choice, 3rd choice, etc. don't
# necessarily match even if the QIDs match. So, match on unique first tokens. Must samecase to
# get a useful number of matches. One more complexity for the record: mixed use of space and dash
# as a token seperator.
names(Survey2012) = tolower(names(Survey2012))
qid2012 = sub(' .*','',names(Survey2012))
x = table(qid2012)
quid2012Unique = names(x)[x==1]
names(Survey2014) = tolower(names(Survey2014))
qid2014 = sub(' .*','',names(Survey2014))
y = table(qid2014)
quid2014Unique = names(y)[y==1]
MatchNames = intersect(quid2012Unique,quid2014Unique)
MatchNames = as.data.table(MatchNames)
qid2012 = data.table(ColNum=1:length(qid2012),qid2012=qid2012)
qid2014 = data.table(ColNum=1:length(qid2014),qid2014=qid2014)
Cols2012 = qid2012[MatchNames,on=c(qid2012='MatchNames')]
Cols2014 = qid2014[MatchNames,on=c(qid2014='MatchNames')]
setkey(Cols2012,ColNum)
setkey(Cols2014,ColNum)
QuestionNames=data.table(Survey2012=names(Survey2012)[Cols2012$ColNum]
                         ,Survey2014=names(Survey2014)[Cols2014$ColNum]
                         ,InitialTokenLength=nchar(Cols2012$qid2012)+2
)
QuestionNames$Survey2012 = substr(QuestionNames$Survey2012
                                  ,grepl('^q',QuestionNames$Survey2012)*QuestionNames$InitialTokenLength
                                  ,99999)
QuestionNames$Survey2014 = substr(QuestionNames$Survey2014
                                  ,grepl('^q',QuestionNames$Survey2014)*QuestionNames$InitialTokenLength
                                  ,99999)

# Mapping
min(Survey2012$`Location 1`[Survey2012$`Location 1`!=''])
max(Survey2012$`Location 1`)
min(Survey2014$`Location 1`[Survey2014$`Location 1`!=''&Survey2014$`Location 1`!='(0, 0)'])
max(Survey2014$`Location 1`)
Survey2012[`Location 1`==''] # 5 of these
Survey2014[`Location 1`==''|`Location 1`=='(0, 0)'] # 4 and 7 of each, respectively

invisible(Survey2012[,Lat:=as.numeric(sapply(regmatches(Survey2012$`Location 1`,
                                                        regexec('[+-]?[0-9]+',Survey2012$`Location 1`))
       ,function(x) if(length(x)==0) '0' else x))/1000000])
boxplot(Survey2012[Lat!=0,Lat])
invisible(Survey2014[,Lat:=as.numeric(sapply(regmatches(Survey2014$`Location 1`,
                                                        regexec('[+-]?[0-9]+\\.[0-9]+',Survey2014$`Location 1`))
       ,function(x) if(length(x)==0) '0' else x))])
boxplot(list(Lat2012=Survey2012[Lat!=0,Lat],Lat2014=Survey2014[Lat!=0,Lat]))
invisible(Survey2012[,Long:=as.numeric(sapply(regmatches(Survey2012$`Location 1`,
                                                        regexec(' [+-]?[0-9]+',Survey2012$`Location 1`))
       ,function(x) if(length(x)==0) '0' else x))/1000000])
boxplot(Survey2012[Long!=0,Long])
invisible(Survey2014[,Long:=as.numeric(sapply(regmatches(Survey2014$`Location 1`,
                                                        regexec(' [+-]?[0-9]+\\.[0-9]+',Survey2014$`Location 1`))
       ,function(x) if(length(x)==0) '0' else x))])
boxplot(list(Long2012=Survey2012[Long!=0,Long],Long2014=Survey2014[Long!=0,Long]))

DataCenterLat = max(c(Survey2012[Lat!=0,Lat],Survey2014[Lat!=0,Lat]))+
    min(c(Survey2012[Lat!=0,Lat],Survey2014[Lat!=0,Lat]))
DataCenterLat = DataCenterLat / 2
DataCenterLong = max(c(Survey2012[Long!=0,Long],Survey2014[Long!=0,Long]))+
    min(c(Survey2012[Long!=0,Long],Survey2014[Long!=0,Long]))
DataCenterLong = DataCenterLong / 2
# From http://rmaps.github.io/blog/posts/leaflet-heat-maps/index.html
L2 <- Leaflet$new()
L2$setView(c(DataCenterLat, DataCenterLong),15)
L2$tileLayer(provider = 'MapQuestOpen.OSM')
# L2$tileLayer(provider = 'Stamen.Watercolor')
L2

# install.packages('ggmap') # Timeout to come to grips w/the utility functions used.
data(crime, package = 'ggmap')
require(plyr)
crime_dat = ddply(crime, .(lat, lon), summarise, count = length(address))
crime_datJ = toJSONArray2(na.omit(crime_dat), json = F, names = F)
str(crime_datJ)
# List of 24251
#  $ :List of 3
#   ..$ : num 27.5
#   ..$ : num -99.5
#   ..$ : int 1
#   ..- attr(*, "na.action")=Class 'omit'  Named int 24252
#   .. .. ..- attr(*, "names")= chr "24252"
#  $ :List of 3
#   ..$ : num 29.5
#   ..$ : num -95.1
#   ..$ : int 10
#   ..- attr(*, "na.action")=Class 'omit'  Named int 24252
#   .. .. ..- attr(*, "names")= chr "24252"
# ....................
cat(rjson::toJSON(crime_datJ[1:2]))
# [[27.5071143,-99.5055471,1],[29.4836146,-95.0618715,10]]
cat(rjson::toJSON(crime_dat[1:2,]))
# {"lat":[27.5071143,29.4836146],"lon":[-99.5055471,-95.0618715],"count":[1,10]}
cd = as.matrix(crime_dat)
dimnames(cd) = NULL
cat(rjson::toJSON(cd[1:2,]))
# [27.5071143,29.4836146,-99.5055471,-95.0618715,1,10]
cdj = toJSONArray2(na.omit(crime_dat), json = T, names = F)
# chr "[\n [\n 27.507,\n-99.506,\n1 \n],\n[\n 29.484,\n-95.062,\n10 \n],\n[\n 29.522,\n-95.058,\n5 \n],\n[\n 29.522,\n-95.058,\n8 \n],"| __truncated__


Jdata2012 = data.frame(Lat=Survey2012[Lat!=0&Long!=0,Lat],Lon=Survey2012[Lat!=0&Long!=0,Long])
Jdata2012$hmVal = runif(nrow(Jdata2012),1,5)
Jdata2012 = toJSONArray2(na.omit(Jdata2012), json = F, names = F)
J2012 = rjson::toJSON(Jdata2012)
nchar(J2012)
# [1] 54206
cat(rjson::toJSON(Jdata2012[1:2]))
# [[37.587246,-77.445636,1.71286322455853],[37.511538,-77.445405,3.13835659809411]]


L2$addAssets(jshead = c(
  'http://leaflet.github.io/Leaflet.heat/dist/leaflet-heat.js'
))

# Add javascript to modify underlying chart
L2$setTemplate(afterScript = sprintf('
<script>
  var addressPoints = %s
  var heat = L.heatLayer(addressPoints).addTo(map)
</script>
', J2012
))

L2
#
save(J2012,file='J2012.rda')

SatisfactionColumn2012 = logical(ncol(Survey2012))
for(i in 1:ncol(Survey2012)){
    SatisfactionColumn2012[i] = is.numeric(unlist(Survey2012[,i,with=F]))
    if (SatisfactionColumn2012[i]){
        if (max(Survey2012[,i,with=F],na.rm=T) > 9){
            SatisfactionColumn2012[i] = F
        }
        if (min(Survey2012[,i,with=F],na.rm=T) < 1){
            SatisfactionColumn2012[i] = F
        }
    }
    if (SatisfactionColumn2012[i]){
        rows = which(Survey2012[,i,with=F] == 9)
        Survey2012[rows,i] = NA
    }
}
table(SatisfactionColumn2012)
# FALSE  TRUE
#    45   148 # hmmmm or 47 and 148??
Survey2012[,OverallSatisfaction:=rowMeans(Survey2012[,which(SatisfactionColumn2012),with=F],na.rm=T)]
# max(Survey2012[,which(SatisfactionColumn2012),with=F],na.rm=T)
# min(Survey2012[,which(SatisfactionColumn2012),with=F],na.rm=T)
Survey2012[,MapValue:=OverallSatisfaction]
Survey2012 = Survey2012[Long != 0 & Lat != 0]
dim(Survey2012) # Before above [1] 1371  196 after [1] 1366  196
table(Survey2012$OverallSatisfaction)
Survey2012[,mean(Long)] # -77.46636
Survey2012[,mean(Lat)] # 37.53813
hist(Survey2012$OverallSatisfaction,breaks=3)
Survey2012[,SatisfactionLevelGroup:=as.numeric(cut(OverallSatisfaction,3))]
table(Survey2012$SatisfactionLevelGroup)
#    1    2    3
#   77 1003  286
save(Survey2012,file='PlayApp/Survey2012.rda')
# load('PlayApp/Survey2012.rda')


# Clean it up and summarize 2014

require(data.table)
DataDir = '../Data/RGov'

Survey2014 = fread(paste0(DataDir,'/','RVA_Community_Survey_2014_Data_GEO.csv'))

invisible(Survey2014[,Lat:=as.numeric(sapply(regmatches(Survey2014$`Location 1`,
                                                        regexec('[+-]?[0-9]+\\.[0-9]+',Survey2014$`Location 1`))
       ,function(x) if(length(x)==0) '0' else x))])
invisible(Survey2014[,Long:=as.numeric(sapply(regmatches(Survey2014$`Location 1`,
                                                        regexec(' [+-]?[0-9]+\\.[0-9]+',Survey2014$`Location 1`))
       ,function(x) if(length(x)==0) '0' else x))])


SatisfactionColumn2014 = logical(ncol(Survey2014))
for(i in 1:ncol(Survey2014)){
    SatisfactionColumn2014[i] = is.numeric(unlist(Survey2014[,i,with=F]))
    if (SatisfactionColumn2014[i]){
        if (max(Survey2014[,i,with=F],na.rm=T) > 9){
            SatisfactionColumn2014[i] = F
        }
        if (min(Survey2014[,i,with=F],na.rm=T) < 1){
            SatisfactionColumn2014[i] = F
        }
        if (names(Survey2014)[i] == 'District'){
            SatisfactionColumn2014[i] = F
        }
    }
    if (SatisfactionColumn2014[i]){
        rows = which(Survey2014[,i,with=F] == 9)
        Survey2014[rows,i] = NA
    }
}
table(SatisfactionColumn2014)
# FALSE  TRUE
#    54   158
Survey2014[,OverallSatisfaction:=rowMeans(Survey2014[,which(SatisfactionColumn2014),with=F],na.rm=T)]
# max(Survey2014[,which(SatisfactionColumn2014),with=F],na.rm=T)
# min(Survey2014[,which(SatisfactionColumn2014),with=F],na.rm=T)
Survey2014[,MapValue:=OverallSatisfaction]
Survey2014 = Survey2014[Long != 0 & Lat != 0] # Consider removing these before computing overall
dim(Survey2014) # Before above xyzzy after [1] 1407  213
table(Survey2014$OverallSatisfaction)
Survey2014[,mean(Long)] # -77.46732
Survey2014[,mean(Lat)] # 37.53816
hist(Survey2014$OverallSatisfaction,breaks=3)
Survey2014[,SatisfactionLevelGroup:=as.numeric(cut(OverallSatisfaction,3))]
table(Survey2014$SatisfactionLevelGroup)
#    1    2    3
#   98 1059  250
save(Survey2014,file='PlayApp/Survey2014.rda')
# load('PlayApp/Survey2014.rda')

# Find the common GPS coordinates so we can display up/down markers.

# head(Survey2012$`Location 1`)
# head(Survey2014$`Location 1`)
head(Survey2012$Lat)
head(Survey2014$Lat)
intersect(Survey2012$Lat,Survey2014$Lat)
intersect(Survey2012$Long,Survey2014$Long)
SurveyJoin = Survey2012[Survey2014,on=c(Lat='Lat',Long='Long'),nomatch=0]
dim(SurveyJoin)
# [1] 1410  409 # Default nomatch=NA
# [1]  64 409 # Inner join: nomatch=0
SurveyJoin[,SatisfactionDelta:=i.OverallSatisfaction-OverallSatisfaction]
SurveyJoin[,MapValue:=SatisfactionDelta]
# SurveyJoin$SatisfactionDelta
#  [1]  0.049677419  0.056530612 -0.198347107 -0.046757364 -0.353460160  0.073066139 -0.005378721
#  [8] -0.112203112 -0.392851664 -0.927175229  0.741715728 -0.175496285  0.592532468 -0.710851648
# [15]  0.212962963  0.168470418 -0.392896628 -0.114234327 -0.031217956 -0.952109181 -0.688308362
# [22] -0.480356525  0.371212121 -0.939519338  0.085576778  0.319987959  0.492349852  0.324739937
# [29] -0.316187739 -0.218007663 -0.281191223 -0.181646655 -0.195676275 -0.057692308 -0.186415182
# [36] -0.058302967 -0.637962963  0.272840374  0.610797828  0.451698211 -0.548817327 -0.021428571
# [43] -0.347479675 -0.085555556  0.270414064  0.215326340  0.146436782 -0.074192262  0.397849462
# [50] -0.135302198 -0.117926467 -0.167560664  0.096801790 -0.418780356 -0.256410256  0.007147265
# [57] -0.082864039 -1.600740741 -0.057801418 -0.050557074 -0.407634471 -0.336770867 -1.020447671
# [64] -0.263798701
hist(SurveyJoin$SatisfactionDelta,10)
# SurveyJoin[,SatisfactionLevelGroup:=as.numeric(cut(SurveyJoin$SatisfactionDelta,3))]
SurveyJoin[,SatisfactionLevelGroup:=(ifelse(SatisfactionDelta<(-0.3),1,ifelse(SatisfactionDelta>0.3,3,2)))]
table(SurveyJoin$SatisfactionLevelGroup)
#  1  2  3
# 18 37  9
save(SurveyJoin,file='PlayApp/SurveyJoin.rda')
# load('PlayApp/SurveyJoin.rda')
