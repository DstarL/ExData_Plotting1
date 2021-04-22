#File name: Plot1.R
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

# Plot 1
hist(hpc$Global_active_power, col="red",
     xlab="Global Active Power (kilowatts)",
     main="Global Active Power")

dev.copy(png, file="Plot1.png")
dev.off()
