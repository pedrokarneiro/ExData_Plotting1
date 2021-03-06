##################################################################################
#                            A T E N T I O N !!!                                 #
#                            ===================                                 #
# Please, first set your current working directory to the current file location. #
# E.g.: > setwd("C:/Users/Pedro/Documents/Coursera/R_Work/ExploratoryDA")        #
##################################################################################
# Clearing memory for calculation safety...
rm(list=ls())

# Downloading and Unzipping data...
if(!file.exists("household_power_consumption.txt")) {
  message("Downloading zip file...")
  myZipFile <- tempfile()
  download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", myZipFile)
  message("Unzipping file...")
  myFile <- unzip(myZipFile)
  unlink(myZipFile)
} else {
  myFile <- "household_power_consumption.txt"
}

# Getting the full dataset...
# Is was not possible to have success when generating the plot by using the
# method used in plot1.R to read the file (only the 2 days), so I'll need to
# read the whole file here and then subset it in order to be able to convert the dates.
message("Reading file contents in full. PLEASE WAIT...")
fullDF <- read.csv("household_power_consumption.txt", header = T, sep = ';', 
                      na.strings = "?", nrows = 2075259, check.names = F, 
                      stringsAsFactors = F, comment.char = "", quote = '\"')
fullDF$Date <- as.Date(fullDF$Date, format = "%d/%m/%Y")

# Subsetting the data...
message("Subsetting the data...")
powerDF <- subset(fullDF, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(fullDF)                     # Removing the fullDF from memory...

# Converting the dates into DateTime...
message("Converting the dates into DateTime...")
myDateTime <- paste(as.Date(powerDF$Date), powerDF$Time)
powerDF$Datetime <- as.POSIXct(myDateTime)

# Setting 4 displays per container, margins and outer margins...
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))

# Generating Plot 4...
doPlot <- function(x) {
  message("Generating plot...")                                           # Message saying the plot is on its way...
#   with(x, {
#     plot(Sub_metering_1 ~ Datetime, type = "l"
#          , ylab = "Global Active Power (kilowatts)", xlab = "")
#     lines(Sub_metering_2 ~ Datetime, col = 'Red')
#     lines(Sub_metering_3 ~ Datetime, col = 'Blue')
#     })
#   legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2,
#          legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) # Generating the graphic...

# Generating the graphics...
  with(x, {
    # Plot 1...
    plot(Global_active_power ~ Datetime, type = "l", ylab = "Global Active Power", xlab = "")
    # Plot 2...
    plot(Voltage ~ Datetime, type = "l", ylab = "Voltage", xlab = "datetime")
    # Plot 3...
    plot(Sub_metering_1 ~ Datetime, type = "l", ylab = "Energy sub metering", xlab = "")
    lines(Sub_metering_2 ~ Datetime, col = 'Red')
    lines(Sub_metering_3 ~ Datetime, col = 'Blue')
    legend("topright"
           , col=c("black","red","blue")
           , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
           , bty="n"
           , lty=c(1,1)
           , lwd=c(1,1))
# Plot 4...
    plot(Global_reactive_power ~ Datetime, type = "l", ylab = "Global_rective_power", xlab = "datetime")
    })
  message("Copying plot to PNG file format...")                            # More messaging...
  dev.copy(png, file="plot4.png", width=480, height=480)                   # Copying plot to PNG file format...
  dev.off()                                                                # Disconnecting from PNG output device...
  message("******************************************************************************")
  message("File Plot4.png saved in ", getwd())                             # Message saying where I've placed the PNG file.
  message("******************************************************************************")
}

doPlot(powerDF)
