## Coursera Exploratory Data Analysis, Course Project 1
## plot3.R is a script to read in the electrical power consumption data and
## create a time series plot of submetering data

## Activate desired packages and clear global environment

library(data.table)
library(dplyr)
library(tidyverse)
library(lubridate)
library(here)
library(openxlsx)
library(datasets)

rm(list=ls(all=TRUE))

## Read in the data from the file entitled household_power_consumption.txt
## This file should be in the working directory.
## Only read in data from 2007-02-01 to 2007-02-02

colnames <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
power_data <- read.table('household_power_consumption.txt', sep = ";",header = TRUE, na.strings = "?", skip = 66636, nrow = 2880, col.names = colnames)

## Convert the date and time variables to date/time classes in R and create a new variable that combines the date and time

power_data$Date <- dmy(power_data$Date)
power_data$Time <- hms(power_data$Time)
power_data$DateTime <- power_data$Date + power_data$Time

## Specify the plot dimensions
dev.new(width=480, height=480, unit="px")

## Create the time series plot of submetering data
with(power_data, plot(DateTime, Sub_metering_1, ylab = "Energy sub metering", type = "l", xlab=""))
with(power_data, points(DateTime, Sub_metering_2, col = "red", type = "l"))
with(power_data, points(DateTime, Sub_metering_3, col = "blue", type = "l"))
legend("topright", pch =1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Copy the plot to a PNG file
dev.copy(png, file = "plot3.png")
dev.off()