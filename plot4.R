# Coursera Exploratory Data first course project
#data taken from: https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption
library(lubridate)
data.head <- read.csv2("./household_power_consumption.txt", nrows=2, header=T, dec = ".", sep = ";")
HL <- colnames(data.head)

start <- as.numeric((dmy("1-2-2007") - dmy("16-12-2006"))*24*60)-(17*60+24)
data <- read.csv2(file = "./household_power_consumption.txt",
                  colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"),
                  header=T, dec = ".", sep = ";", na.strings = "?", skip = start, nrows = 2*24*60)
colnames(data) <- HL

# Formating timestamps
data$timestamps <- paste(data$Date, data$Time)
data$timestamps <- as.POSIXct(data$timestamps, format = "%d/%m/%Y %H:%M:%S")

# Start the Plotting
df <- data
#Plot 4
png("./plot4.png", width = 480, height = 480)
opar <- par(no.readonly=T)
par(mfrow=c(2,2))
plot(df$timestamps, df$Global_active_power, typ="l", xlab = "", ylab="Global Active Power")
plot(df$timestamps, df$Voltage, typ="l", ylab="Voltage", xlab = "datetime")
plot(df$timestamps, df$Sub_metering_1, typ="l", xlab = "", ylab="Energy sub metering", col="black")
lines(df$timestamps, df$Sub_metering_2, typ="l", col="red")
lines(df$timestamps, df$Sub_metering_3, typ="l", col="blue")
legend(x = "topright",legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=c(1,1,1))
plot(df$timestamps, df$Global_reactive_power, typ="l", xlab = "datetime", , ylab="Global_reactive_power")
par(opar)
dev.off()
