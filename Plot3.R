#File name: Plot3.R
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

# Plot 3
hpc$Sub_metering_1 <- as.numeric(hpc$Sub_metering_1)
hpc$Sub_metering_2 <- as.numeric(hpc$Sub_metering_2)
hpc$Sub_metering_3 <- as.numeric(hpc$Sub_metering_3)

with(hpc, plot(DateTime,
               Sub_metering_1,
               xlab="",
               ylab="Energy sub metering",
               pch="."))

lines(hpc$DateTime, hpc$Sub_metering_1, pch=16, col="black")
lines(hpc$DateTime, hpc$Sub_metering_2, pch=16, col="red")
lines(hpc$DateTime, hpc$Sub_metering_3, pch=16, col="blue")

legend("topright", col=c("black","red","blue"),
       lty=1,
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.copy(png, file="Plot3.png")
dev.off()


