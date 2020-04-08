## Homework 1, problem 1

## a)

patients <- read.csv2('https://firebasestorage.googleapis.com/v0/b/uni-sofia.appspot.com/o/data%2FCOVID19_2020_open_line_list%20-%20outside_Hubei_subset.csv?alt=media&token=919a181b-6417-45fd-9314-91497bb4b0fc', stringsAsFactors = FALSE)

## b)
## NOTE: use <- consistently
number_patients <-  nrow(patients)
number_patients
## c)
first_confirmation <- patients[1, "date_confirmation"]
first_confirmation
patients2 <- subset(patients, !is.na(date_confirmation))
number_patients2 <- dim(patients2)[1]
last_confirmation <- patients2[number_patients2, "date_confirmation"]
##d)
age_column <- patients$age
avg_age <- mean(age_column)
## e)

female <- (patients$sex == "female")
all_females <- sum(female)
all_females
male <- (patients$sex == "male")
all_males <- sum(male)
all_males

## f)
frequency_gender <- table(patients$sex)
frequency_gender
barplot(frequency_gender)
title('Sex frequency chart')

## g)
lowest_age_of_woman <-  min(patients$age[female])
lowest_age_of_woman

## h)
age_of_oldest_man <-  max(patients$age[male])
age_of_oldest_man

## i)
male_ages <-  patients$age[male]
avg_male_age <- mean(male_ages)

female_ages <- patients$age[female]
avg_female_age <- mean(female_ages)

difference <- avg_male_age - avg_female_age
difference

## j)
boxplot(age ~ country, data = patients, horizontal = TRUE)
title('Boxplot for Age by Country')

## NOT: bravo!
## The age of patients in Japan and the US is higher because the population is generally older than in China.
