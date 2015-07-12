# read in entire table
power_data <- read.table("household_power_consumption.txt", header = TRUE, sep=";", na.strings = "?")
# Cast the date and time correctly
power_data$Time <- strptime(paste(as.character(power_data$Date), as.character(power_data$Time), sep = " "), format="%d/%m/%Y %H:%M:%S")
power_data$Date <- as.Date(power_data$Date, format="%d/%m/%Y")
# Subset for only the two days we want
power_data <- subset(power_data, Date > "2007-01-31" & Date < "2007-02-03")

png(filename = "plot3.png", bg = "transparent")
with(power_data,
     {
     plot(Time, Sub_metering_1, type="l", ylab = "Energy sub metering", xlab="")
     lines(Time, Sub_metering_2, col="red")
     lines(Time, Sub_metering_3, col="blue")
     legend("topright", legend=names(power_data[c(7,8,9)]), lty=1, col=c('black', 'red', 'blue'))
     })
dev.off()