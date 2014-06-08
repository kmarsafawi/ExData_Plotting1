###################################################################################
## Loading the desired data
## This portion is fixed for all the plots of this exercise
###################################################################################
## Pointing to the correct local directory
setwd("C:\\Repo1")

## Generating new filtered file through connection
## to avoid excesive memory loads.
all_data <- file("household_power_consumption.txt", "r")
cat(grep("(^Date)|(^[1|2]/2/2007)",readLines(all_data), value=TRUE),
    sep="\n", file="desired_data.txt")
close(all_data)

## Read the newly generated data
mydata <- read.table("desired_data.txt", sep = ";", header = TRUE)

###################################################################################
## Plotting
###################################################################################
png(file = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2, 2))

## Convert dates
dates <- as.Date(mydata$Date, "%d/%m/%Y")

## Append Dates to Time, Then convert to POSIX
datetime_chr <- paste(dates, mydata$Time)
datetime <- strptime(datetime_chr, "%F %T")

## Get the character vector of the Day names
dateday_chr <- strftime(datetime, "%a")

## Prepare the final dataset -- appending the rest of data
final <- data.frame(datetime, dateday_chr, mydata[, 3:9], row.names = NULL)

## Plotting...
## Top left Graph
with(final, plot(datetime, Global_active_power, xlab = "", ylab = "Global Active Power", type = "l"))

## Top right Graph
with(final, plot(datetime, Voltage, xlab = "datetime", type = "l"))

## Bottom left Graph
with(final, plot(datetime, Sub_metering_1, col="black" , xlab = "", ylab = "Energy sub metering", type = "l"))
with(final, lines(datetime, Sub_metering_2, col="red" ,  type = "l"))
with(final, lines(datetime, Sub_metering_3, col="blue" , type = "l"))
legend("topright" , bty="n", lty = c(1, 1, 1), col=c("black","blue", "red"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Bottom right Graph
with(final, plot(datetime, Global_reactive_power, xlab = "datetime", type = "l"))
dev.off()

