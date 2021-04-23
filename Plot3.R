#Read data only from the necessary days
power_consumption_data <- read.csv("./data/household_power_consumption.txt", 
    header = TRUE, sep = ";", nrows = 2880, skip = 66636, na.strings = c("\\?"))

#Assign readable names to data
names(power_consumption_data) <- c("Date","Time","Global_active_power","Global_reactive_power",
    "Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

#Adds column with full date and time information
library(dplyr)
power_consumption_data <- mutate(power_consumption_data, CompleteDate = as.POSIXct(paste(
      power_consumption_data$Date, power_consumption_data$Time), format=c("%d/%m/%Y %H:%M:%S")))

#Generates the sub_metering_1 plot line
par(mfcol=c(1,1))
plot(power_consumption_data$CompleteDate, power_consumption_data$Sub_metering_1, 
     type="l", ylab="Energy sub metering", xlab="")

#Adds the other 2 lines
lines(power_consumption_data$CompleteDate, power_consumption_data$Sub_metering_2, type="l", col="red")
lines(power_consumption_data$CompleteDate, power_consumption_data$Sub_metering_3, type="l", col="blue")

#Adds the legend
legend("topright", legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"), lty=1, cex=0.75)

#Copy to PNG file
dev.copy(png, file="plot3.png")

#Close the PNG device
dev.off()