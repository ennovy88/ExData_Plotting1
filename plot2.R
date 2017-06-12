## plot2.R

## The goal is to examine how household energy usage varies 
## over a 2-day period in February 2007 (2007-02-01 and 2007-02-02). 

## This script reads a dataset on electric power consumption and contructs 
## plot2.png, which plots Global Active Power across time.

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
## Making plot2.png 
############################################################################

png (filename = "plot2.png", width = 480, height = 480, units = "px")
with (my_df, plot(Time,Global_active_power, 
                 ylab="Global Active Power (kilowatts)", 
                 xlab=" ", 
                 type="l")
     )
dev.off() 
