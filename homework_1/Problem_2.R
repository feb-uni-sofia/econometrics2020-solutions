## Homework 1, problem 2

## a)

wines <- read.csv(file='https://s3.eu-central-1.amazonaws.com/sf-timeseries/data/wine.csv')

## b)

wines <- within(wines, {
  Price <- exp(LogPrice)
})

## c)

## d)

## e)

## f)

## g)

## h)

## i)

## j)
