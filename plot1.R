#Plot1
##Load the data into R ... text file is already located in the project directory
plotData <- read.table("./household_power_consumption.txt", sep=";", header=TRUE)
dim(plotData)
str(plotData)

##Add a combined datetime field to the table
plotData$DateTime <- paste(plotData$Date, plotData$Time, sep=" ") 

##Convert Data and Time variables to Date/Time classes
library(chron)
plotData$Date <- as.Date(plotData$Date, "%d/%m/%Y")
plotData$Time <- chron(times = plotData$Time, format = "h:m:s")

##subset to required dates 2007-02-01 and 2007-02-02
library(dplyr)
plotData <- tbl_df(plotData)
plotData2 <- subset(plotData, plotData$Date >= "2007-02-01" & Date <= "2007-02-02")
dim(plotData2)
str(plotData2)

##convert DateTime field from character using strptime
plotData3 <- plotData2
plotData3$DateTime <- strptime(plotData3$DateTime, format = "%Y-%m-%d %H:%M:%S")
str(plotData3)

##Make sure that data is in numeric format ready to start plotting
plotData3$Global_active_power <- as.numeric(levels(plotData3$Global_active_power))[plotData3$Global_active_power]
plotData3$Global_reactive_power <- as.numeric(levels(plotData3$Global_reactive_power))[plotData3$Global_reactive_power]
plotData3$Voltage <- as.numeric(levels(plotData3$Voltage))[plotData3$Voltage]
plotData3$Global_intensity <- as.numeric(levels(plotData3$Global_intensity))[plotData3$Global_intensity]
plotData3$Sub_metering_1 <- as.numeric(levels(plotData3$Sub_metering_1))[plotData3$Sub_metering_1]
plotData3$Sub_metering_2 <- as.numeric(levels(plotData3$Sub_metering_2))[plotData3$Sub_metering_2]

##Save plots to PNG file with width of 480 pixels and height of 480 pixels
png(filename = "plot1.png", width = 480, height = 480)

##Plot 1: Histogram of Global Active Power
hist(plotData3$Global_active_power,
     col="red", 
     ylim=c(0,1200),
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)"
     )