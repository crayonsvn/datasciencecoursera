---
title: "Reproducible Research Assignment 1"
author: "Anh Le"
date: "Saturday, June 13, 2015"
output: word_document
---

**1) What is mean total number of steps taken per day?**
```{r}
data <- read.csv(".\\data\\activity.csv")
totalperday <- tapply(data$steps, data$date, sum, na.rm=TRUE)
head(totalperday)
summary(totalperday)
```
Histogram

```{r histogram1, fig.height=5, fig.width=5}
hist(totalperday, main="Total steps/days", xlab="Steps")
```

```{r}
m <- mean(totalperday)
med <- median(totalperday)
print(m)
print(med)
```
**2)What is the average daily activity pattern?**

```{r}
avgstep <- aggregate(data$steps, list(data$interval), mean, na.rm=TRUE)
head(avgstep)
tail(avgstep)
summary(avgstep)
names(avgstep[1]) <- "interval"
names(avgstep[2]) <- "avgsteps"
```

```{r timeseriesplot, fig.height=6, fig.width=6}
plot(avgstep, type="l", col="red", main="Average steps / interval", xlab="Interval", ylab="Average steps")
```

```{r}
avgstep[[2]][1]
maxavg <- max(avgstep[[2]])
len <- length(avgstep[[2]])
print(maxavg)

for(x in 1:len){
  if(avgstep[[2]][x] == maxavg) { break }
  else { x = x + 1 }
}
print(x)
```
5-min interval, on average across all the days in the dataset, contains the maximum number of steps:
```{r}
print(avgstep[[1]][x])
```
###3)Inputing missing values
The total number of missing values in the dataset:
```{r}
sum(is.na(data$steps))
```

Change NA value to the average steps of the interval, new dataset is data2
```{r}
data2 <- data

len1 <- length(data2$steps)
len2 <- length(avgstep[[1]])
for(x in 1:len1){
  if(is.na(data2$steps[x])) {
    int <- data2$interval[x]
    for(y in 1:len2){
      if(avgstep[[1]][y] == int) { break }
      else {y = y + 1}
    }
    data2$steps[x] <- avgstep[[2]][y]
  }
}

head(data2)
tail(data2)
```
Make a histogram of the total number of steps taken each day and Calculate and report the mean and median total number of steps taken per day. Do these values differ from the estimates from the first part of the assignment? What is the impact of imputing missing data on the estimates of the total daily number of steps?
In the first part of the assignment, mean1 = 9354.23 and median1 = 10395; while in the 2nd part, both mean2 and median2 = 10766.1

```{r}
totalperday2 <- tapply(data2$steps, data2$date, sum, na.rm=TRUE)
head(totalperday2)
summary(totalperday2)
```
Histogram

```{r histogram2, fig.height=5, fig.width=5}
hist(totalperday2,main="Total steps/days", xlab="Steps")
```

```{r}
m2 <- mean(totalperday2)
med2 <- median(totalperday2)
print(m2)
print(med2)
```
