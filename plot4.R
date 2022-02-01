library(dplyr) 



#####################################
## DOWNLOAD AND UNZIP DATA
dir.create("./data", showWarnings = FALSE)

downloadURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"  ## URL for downloading data
downloadFile <- "./data/household_power_consumption.zip"  ## file directory for placing downloaded the zipped file
householdFile <- "./data/household_power_consumption.txt"  ## file directory for placing the unzipped file

if(!file.exists(householdFile)) {
    download.file(downloadURL, downloadFile, method = "curl")
    unzip(downloadFile, exdir = "./data")
}


#####################################
## LOAD AND FILTER DATA BY THE PROPER DATE
df <- read.table(householdFile, sep = ";", header = TRUE, na.strings = "?")

## convert the Date variables to Date classes
df$Date <- as.Date(df$Date, format="%d/%m/%Y", tz = "GMT")

## filter data having dates between 2007-02-01 and 2007-02-02
startDate <- as.Date("2007-02-01", format="%Y-%m-%d", tz = "GMT")
endDate <- as.Date("2007-02-02", format="%Y-%m-%d", tz = "GMT")
df <- df[df$Date >= startDate, ]
df <- df[df$Date <= endDate, ]

## convert the Time variables to Time classes
df$Time <- strptime(paste(df$Date, df$Time, sep=" "), format = "%Y-%m-%d %H:%M:%S", tz = "GMT")


#####################################
## PLOT AND SAVE
png("plot4.png", width = 480, height = 480)

par(mfrow = c(2, 2))

## plot[1, 1]
plot(df$Time, df$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

## plot[1, 2]
plot(df$Time, df$Voltage, type = "l", xlab = "datetime", ylab = "Global Active Power (kilowatts)")

## plot[2, 1]
plot(df$Time, df$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(df$Time, df$Sub_metering_2, type = "l", col = "red")
lines(df$Time, df$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty =  1, bty = "n")

## plot[2, 2]
plot(df$Time, df$Global_reactive_power, type = "l", xlab = "", ylab = "Global_reactive_power")

dev.off()
