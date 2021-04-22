#File name: Plot2.R
#Author: David Lyons
#Description: ExData_Plotting1
#Date created: 2021-04-22
#Date last modified: 2021-04-22

library(dplyr)
library(data.table)
library(lubridate)

# Read data power data
large_temp <- fread("household_power_consumption.txt", 
                    sep=";", 
                    header=TRUE)

hpc <- filter(large_temp, Date == "1/2/2007" | 
                  Date == "2/2/2007")

rm(large_temp)

hpc$DateTime <- paste(hpc$Date, hpc$Time, sep=" ")

hpc$DateTime <- dmy_hms(hpc$DateTime)

hpc$Global_active_power <- as.numeric(hpc$Global_active_power)

# Plot 2
png("Plot2.png", width = 480, height = 480)

with(hpc, plot(DateTime,
               Global_active_power,
               xlab="",
               ylab="Global Active Power (kilowatts)",
               pch="."))

lines(hpc$DateTime, hpc$Global_active_power, pch=16)

dev.off()
