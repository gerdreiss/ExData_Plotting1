########################################################################################################################
## Coursera Course Exploratory Data Analysis, Course Project 1, Plot 1
##
## Author: Gerd Reiss, 04/01/2015
##
##

## install necessary packages if not already done so
if (("data.table" %in% (installed.packages())) == F) {
  install.packages("data.table")
}
library(data.table)


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

## export plot1.png
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(data$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()






