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

## Start the plot
png(file = "plot1.png", width = 480, height = 480, units = "px")
with(mydata, hist(mydata$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power") )
dev.off()
