#File name: Plot4.R
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
hpc$Global_reactive_power <- as.numeric(hpc$Global_reactive_power)
hpc$Voltage <- as.numeric(hpc$Voltage)
hpc$Sub_metering_1 <- as.numeric(hpc$Sub_metering_1)
hpc$Sub_metering_2 <- as.numeric(hpc$Sub_metering_2)
hpc$Sub_metering_3 <- as.numeric(hpc$Sub_metering_3)

png("Plot4.png", width = 480, height = 480)

par(mfrow=c(2,2),mar=c(4,4,2,1),oma=c(0,0,2,0))
# top left
with(hpc, plot(DateTime,
               Global_active_power,
               xlab="",
               ylab="Global Active Power",
               pch="."))
lines(hpc$DateTime, hpc$Global_active_power, pch=16)

# top right
with(hpc, plot(DateTime,
               Voltage,
               xlab="datetime",
               ylab="Voltage",
               pch="."))
lines(hpc$DateTime, hpc$Voltage, pch=16)

# bottom left
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

# bottom right
with(hpc, plot(DateTime,
               Global_reactive_power,
               xlab="datetime",
               ylab="Global reactive power",
               pch="."))
lines(hpc$DateTime, hpc$Global_reactive_power, pch=16)

dev.off()
