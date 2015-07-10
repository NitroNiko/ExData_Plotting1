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
#Plot 2
png("./plot2.png", width = 480, height = 480)
plot(df$timestamps, df$Global_active_power, typ="l", xlab = "", ylab="Global Active Power")
dev.off()
