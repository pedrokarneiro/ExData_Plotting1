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

# Loading data only for the 2 days specified...
message("Reading file contents (loading data only for the 2 days specified). PLEASE WAIT...")
powerDF <- read.table(text = grep("^[1,2]/2/2007"
                                , readLines(myFile)
                                , value = TRUE)
                    , col.names = c("Date", "Time", "Global_active_power"
                                    , "Global_reactive_power", "Voltage", "Global_intensity"
                                    , "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
                    , sep = ";"
                    , header = TRUE)

# Setting one display per container...
par(mfrow=c(1,1))

# Generating Plot 1...
doPlot <- function(x) {
  message("Generating plot...")                          # Message saying the plot is on its way...
  hist(x$Global_active_power
       , main = paste("Global Active Power")
       , col="red"
       , xlab="Global Active Power (kilowatts)")         # Generating the graphic...
  message("Copying plot to PNG file format...")          # More messaging...
  dev.copy(png, file="plot1.png", width=480, height=480) # Copying plot to PNG file format...
  dev.off()                                              # Disconnecting from PNG output device...
  message("******************************************************************************")
  message("File Plot1.png saved in ", getwd())           # Message saying where I've placed the PNG file.
  message("******************************************************************************")
  
}

doPlot(powerDF)
