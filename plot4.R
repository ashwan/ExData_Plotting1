# read in entire table
power_data <- read.table("household_power_consumption.txt", header = TRUE, sep=";", na.strings = "?")
# Cast the date and time correctly
power_data$Time <- strptime(paste(as.character(power_data$Date), as.character(power_data$Time), sep = " "), format="%d/%m/%Y %H:%M:%S")
power_data$Date <- as.Date(power_data$Date, format="%d/%m/%Y")
# Subset for only the two days we want
power_data <- subset(power_data, Date > "2007-01-31" & Date < "2007-02-03")

png(filename = "plot4.png", bg = "transparent")
par(mfrow=c(2,2))
with(power_data,
     {
       plot(Time, Global_active_power, type = "l", main = "", ylab = "Global Active Power", xlab = "")
       plot(Time, Voltage, type="l", xlab="datetime")
       plot(Time, Sub_metering_1, type="l", ylab = "Energy sub metering", xlab="")
       lines(Time, Sub_metering_2, col="red")
       lines(Time, Sub_metering_3, col="blue")
       legend("topright", bty="n", legend=names(power_data[c(7,8,9)]), lty=1, col=c('black', 'red', 'blue'))
       plot(Time, Global_reactive_power, type="l", xlab="datetime")
     })
dev.off()