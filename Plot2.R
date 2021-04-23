#Read data only from the necessary days
power_consumption_data <- read.csv("./data/household_power_consumption.txt", 
    header = TRUE, sep = ";", nrows = 2880, skip = 66636, na.strings = c("\\?"))

#Assign readable names to data
names(power_consumption_data) <- c("Date","Time","Global_active_power","Global_reactive_power",
    "Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

#Adds column with full date and time information
library(dplyr)
power_consumption_data <- mutate(power_consumption_data, CompleteDate = as.POSIXct(paste
    (power_consumption_data$Date, power_consumption_data$Time), format=c("%d/%m/%Y %H:%M:%S")))

#Generates a plot line graphic
par(mfcol=c(1,1))
plot(power_consumption_data$CompleteDate, power_consumption_data$Global_active_power, 
     type="l", ylab="Global Active Power \\(Kilowatts\\)", xlab="")

#Copy to PNG file
dev.copy(png, file="plot2.png")

#Close the PNG device
dev.off()