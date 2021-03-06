# read in entire table
power_data <- read.table("household_power_consumption.txt", header = TRUE, sep=";", na.strings = "?")
# Cast the date and time correctly
power_data$Time <- strptime(paste(as.character(power_data$Date), as.character(power_data$Time), sep = " "), format="%d/%m/%Y %H:%M:%S")
power_data$Date <- as.Date(power_data$Date, format="%d/%m/%Y")
# Subset for only the two days we want
power_data <- subset(power_data, Date > "2007-01-31" & Date < "2007-02-03")

# Plot a histogram of Global active power with the bar color as red. Save to PNG
png(filename = "plot1.png", bg = "transparent")
hist(power_data$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()