########################################################################################################################
## Coursera Course Exploratory Data Analysis, Course Project 1, Plot 4
##
## Author: Gerd Reiss, 04/01/2015
##
##

## install necessary packages if not already done so
if (("data.table" %in% (installed.packages())) == F) {
  install.packages("data.table")
}
library(data.table)
if (("plyr" %in% (installed.packages())) == F) {
        install.packages("plyr")
}
library(plyr)


## the name of the dataset file
data_file <- "household_power_consumption.txt"

## check OS
is_windows <- .Platform$OS.type == "windows"

## download dataset file if not already done so
if (!file.exists(data_file)) {
  source_url <- "https://d396qusza40orc.cloudfront.net/exdata/household_power_consumption.zip"
  zip_file <- "household_power_consumption.zip"
  download_method <- ifelse(is_windows, "auto", "curl")
  download.file(url = source_url, method = download_method, destfile = zip_file)
  unzip(zip_file)
  ## remove unnecessary data from workspace
  remove("source_url"); remove("zip_file"); remove("download_method")
}

## read the entire dateset
full <- read.table(data_file, header = T, sep = ";", dec = ".", na.strings = c("?"), 
                   colClasses =  c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
## subset by date
data <- full[full$Date %in% c("1/2/2007","2/2/2007"), ]
## convert character columns to Date and Time class
data <- mutate(data, Time = strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"), Date = as.Date(Date))

## export plot4.png
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2, 2))
plot(data$Time, data$Global_active_power, xlab = "", ylab = "Global Active Power", type = "l")
plot(data$Time, data$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")
plot(data$Time, data$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n")
points(data$Time, data$Sub_metering_1, type = "l", col = "black")
points(data$Time, data$Sub_metering_2, type = "l", col = "red")
points(data$Time, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering 1", "Sub_metering 2", "Sub_metering 3"), bty = "n")
plot(data$Time, data$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l")
dev.off()





