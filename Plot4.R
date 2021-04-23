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

par(mfcol=c(2,2))

#First Graph
plot(power_consumption_data$CompleteDate, power_consumption_data$Global_active_power, 
     type="l", ylab="Global Active Power \\(Kilowatts\\)", xlab="")

#Second Graph
plot(power_consumption_data$CompleteDate, power_consumption_data$Sub_metering_1, 
     type="l", ylab="Energy sub metering", xlab="")

#Second Graph: Adds the other 2 lines
lines(power_consumption_data$CompleteDate, power_consumption_data$Sub_metering_2, type="l", col="red")
lines(power_consumption_data$CompleteDate, power_consumption_data$Sub_metering_3, type="l", col="blue")

#Second Graph: Adds the legend (apologies for the small font size)
legend("topright", legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"), lty=1, bty="n", cex=0.3, inset = c(0, 0))

#Third Graph
plot(power_consumption_data$CompleteDate, power_consumption_data$Voltage, 
     type="l", ylab="Voltage", xlab="datetime")

#Fourth Graph
plot(power_consumption_data$CompleteDate, power_consumption_data$Global_reactive_power, 
     type="l", ylab="Global_reactive_power", xlab="datetime")

#Copy to PNG file
dev.copy(png, file="plot4.png")

#Close the PNG device
dev.off()