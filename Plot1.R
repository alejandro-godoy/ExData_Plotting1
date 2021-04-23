
#Read data only from the necessary days
power_consumption_data <- read.csv("./data/household_power_consumption.txt", 
    header = TRUE, sep = ";", nrows = 2880, skip = 66636, na.strings = c("\\?"))

#Assign readable names to data
names(power_consumption_data) <- c("Date","Time","Global_active_power","Global_reactive_power",
    "Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

#Plots the data
par(mfcol=c(1,1))
hist(power_consumption_data$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")

#Copy to PNG file
dev.copy(png, file="plot1.png")

#Close the PNG device
dev.off()