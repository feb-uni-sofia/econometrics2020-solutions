## Homework 1, problem 1

## a)

patients <-
  read.csv2(
    'https://firebasestorage.googleapis.com/v0/b/uni-sofia.appspot.com/o/data%2FCOVID19_2020_open_line_list%20-%20outside_Hubei_subset.csv?alt=media&token=919a181b-6417-45fd-9314-91497bb4b0fc',
    stringsAsFactors = FALSE
  )

## b) 1565

nrow(patients)

## c) 2020-01-15, NA

## NOTE: this relies on the dataset being sorted by confirmation date.
## THis is more complicated that intended: simply open the table
## sort it by confirmation date (ascending, then descending) and look up the values

patients[1, "date_confirmation"]


patients[nrow(patients), "date_confirmation"]

## d) average age of patients is 49.1828 (years)

mean(patients$age)

## e) female 719 male   846

table(patients$sex)

## f)
freqsex <- table(patients$sex)
freqsex

barplot(freqsex)
title('Sex distribution')

## g)  the youngest woman is 0.8333 (years old)

iswoman <- patients$sex == "female"
agewoman <- patients$age[iswoman]
youngestwoman <- min(agewoman)

## h) the oldest man is 94.5 years old

ageman <- patients$age[!iswoman]
oldestman <- max(ageman)

## i) average age of men is greater with 0.7097 years that the avg age of women

avgageofwoman <- mean(agewoman)
avgageofman <- mean(ageman)

agedifference <- avgageofwoman - avgageofman

## j) 
boxplot(age ~ country, data = patients, horizontal = TRUE)
title('Boxplot for Age by Country')


## QUESTION: why are the patients in China generally younger than in the other countries?

##The youngest patient in China is 0.8333 years old, 50% of the patients are younger than 44, About a quarter are
##younger than 33, and about a quarter older than 56. The oldest in China is 96 years old.


##The youngest patient in Japan is 3 years old, 50% of the patients are younger than 54.50, About a quarter are
##younger than 44.50, and about a quarter older than 64.50. The oldest in Japan is 94.50 years old.


##The youngest patient in USA is 4.50 years old, 50% of the patients are younger than 54.50, About a quarter are
##younger than 41, and about a quarter older than 65. The oldest in USA is 94.50 years old.
