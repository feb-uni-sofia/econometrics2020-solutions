## Homework 1, problem 1

## a)

patients <- read.csv2('https://firebasestorage.googleapis.com/v0/b/uni-sofia.appspot.com/o/data%2FCOVID19_2020_open_line_list%20-%20outside_Hubei_subset.csv?alt=media&token=919a181b-6417-45fd-9314-91497bb4b0fc', stringsAsFactors = FALSE)

## b)
number_patients <- dim(patients)[1]
number_patients

## or simply:

## n <- nrow(patients)

## c)
dated_cases <- subset(patients, !is.na(date_confirmation))

first_confirmation <- dated_cases[1, "date_confirmation"]
first_confirmation

## NOTE: this relies on data being sorted by confirmation date
length_cases <- dim(dated_cases)[1]
last_confirmation <- dated_cases[length_cases, "date_confirmation"]
last_confirmation

## d)
age_patients <- patients$age
avg_age <- mean(age_patients)
avg_age

## e)
is_male <- (patients$sex == "male")

sum_females <- sum(!is_male)
sum_females

sum_males <- sum(is_male)
sum_males

## f)
freq_gender <- table(patients$sex)
freq_gender

barplot(freq_gender)
title('Sex frequency')

## g)
youngest_woman <- min(patients$age[!is_male])
youngest_woman

## h)
oldest_man <- max(patients$age[is_male])
oldest_man

## i)
male_patients <- patients$age[is_male]
avg_male <- mean(male_patients)

female_patients <- patients$age[!is_male]
avg_female <- mean(female_patients)

difference <- avg_male - avg_female
difference

## j)
boxplot(age ~ country, data = patients, horizontal = TRUE)
title('Boxplot for Age by Country')

## Interpretation: the boxplot indicates
## that patients from Japan and United States tend to 
## be older than the patients from China

## QUESTION: yes, this is indeed the case, but can you suggest why?
