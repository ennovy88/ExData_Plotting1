## plot4.R

## The goal is to examine how household energy usage varies 
## over a 2-day period in February 2007 (2007-02-01 and 2007-02-02). 

## This script reads a dataset on electric power consumption and contructs 
## plot4.png, which plots global active power over time, voltage over time, 
## energy sub metering over time, and global reactive power over time.

############################################################################
## Loading and tidying the dataset on electric power consumption 
############################################################################

df <- read.table("./household_power_consumption.txt", header=TRUE, sep = ";", 
                 stringsAsFactors=FALSE)
df$Date <- as.Date(df$Date, "%d/%m/%Y")

## Extracting data on dates 2007-02-01 and 2007-02-02. 
my_df <- with(df, subset(df, Date == "2007-02-01" | Date == "2007-02-02"))

## Tidying the data frame
my_df$Time <- paste(my_df$Date, my_df$Time, sep=" ")
my_df$Time <- strptime(my_df$Time, "%Y-%m-%d %H:%M:%S")

## Converting column 3 through 8 to numeric values, since column 9 is numeric
my_df [,3:8] <- sapply(my_df[,3:8], as.numeric)

############################################################################
## Making plot4.png
############################################################################

png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow =c(2,2))
with (my_df, {  
        plot(Time, Global_active_power, ylab="Global Active Power", 
           xlab=" ", type="l")
        plot(Time, Voltage, ylab="Voltage", xlab="datetime", type="l")
        plot(Time, Sub_metering_1, type="l", ylab="Energy sub metering", xlab=" ")
          points(Time, Sub_metering_2, col="red", type="l")
          points(Time, Sub_metering_3, col="blue", type="l")
          legend ("topright", lty=1, bty="n", bg="white", col=c("black", "red", "blue"), 
                  legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Time,Global_reactive_power, xlab="datetime", type="l")
              }
      )

dev.off() 
