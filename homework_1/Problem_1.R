## Homework 1, problem 1

## a)

patients <-
  read.csv2(
    'https://firebasestorage.googleapis.com/v0/b/uni-sofia.appspot.com/o/data%2FCOVID19_2020_open_line_list%20-%20outside_Hubei_subset.csv?alt=media&token=919a181b-6417-45fd-9314-91497bb4b0fc',
    stringsAsFactors = FALSE
  )

## NOT: use <- consistently for assignment
patients <- patients[, 2:7] #omitting the columns we dont need
## b)
n <- nrow(patients)
str(patients)
n #the total number of patients is 1565

## c)

## NOTE: this works here, but in general take care when computing
## the minimum of non-numeric data (not only in R but in every other language).

## In this dataset dates are stored as strings and 
## your solution works because of the specific format of the dates "year-month-day"

## Use TRUE and FALSE instead of T and F

First_Date <-
  min(patients$date_confirmation, na.rm = TRUE) #First date is 15.01.2020
First_Date
Last_Date <-
  max(patients$date_confirmation, na.rm = TRUE) #Last date is 20.03.2020
Last_Date

## d)
## NOTE: Don't forget the unit of measurement: years
AverageAge <-
  mean(patients$age) #the average age of patients is 49.1828 years

## e)

MalePatients <- sum(patients$sex == "male")
MalePatients #the number of male patients is 846
FemalePatients <- sum(patients$sex != "male")
FemalePatients #the number of female patients is 719


## f)
## NOTE: don't print objects in the output you submit
## NOTE: check your figure title
## NOTE: in general, don't use color unless it encodes information.

## table(patients$sex)
barplot(
  table(patients$sex),
  col = c("lightpink3", "darkcyan"),
  ylab = "Frequency",
  # main = "Frequency distribution of COVID-19 patients"
  main = "Frequency distribution of gender"
)

## g)
Females <- patients$sex == "female"
ageFem <- patients$age[Females]
minFemAge <- min(ageFem)
## NOTE: don't forget the unit of measurement
minFemAge #the youngest female in the sample is of age 0.08333 years

## h)

## NOTE: don't forget the unit of measurement
Males <- (patients$sex == "male")
ageMale <- patients$age[Males]
maxMaleAge <- max(ageMale)
maxMaleAge #the oldest male in the sample is of age 94.5 (years)

## i)
AvgMalesAge <- mean(ageMale)
AvgMalesAge #the average male age is 49.50887
AvgFemAge <- mean(ageFem)
AvgFemAge #the average female age is 48.79914
Test <- AvgMalesAge == AvgFemAge
Test

## NOTE: compute the difference

AvgMalesAge - AvgFemAge

## j)
boxplot(
  patients$age ~ patients$country,
  xlab = "Country",
  ylab = "Age of patients",
  col = c("tan1", "steelblue2", "lightpink2"),
  main = "Distribution of patients' age among countries"
)

## QUESTION: why are the patients in China generally younger than in the other countries?

#According to the box plot in China the average age of people, getting sick is lower
#than in the US or Japan; people over 80 are outliers (for China), Surprising is the
#minimum age of people affected with Covid-19 in China, which is almost newborns, while in Japan and the US people under 10 are considered outliers;
#USA and Japan have a higher max age of people affected with the virus, and also a higher min age
