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
png("plot1.png", width = 480, height = 480)
hist(df$Global_active_power, breaks = 15, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
