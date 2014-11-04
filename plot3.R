# Check to see if the project data file (household_power_consumption.txt) exists...
if (!file.exists("household_power_consumption.txt"))
{
  message("exdata-data-household_power_consumption directory does NOT exist; downloading now...")
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "exdata-data-household_power_consumption.zip")
  unzip("exdata-data-household_power_consumption.zip")
}

# Read from the file... (already know which rows we want, representing Feb 1-2, 2007)...
data <- read.csv("household_power_consumption.txt", 
                 header=FALSE, sep=";", skip=66637, nrows=2880, 
                 col.names=c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))


# Add a column for the full datetime of the reading...
data$mydatetime <- strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")

# Plot 3...
png(filename="plot3.png", width=480, height=480)
plot(data$mydatetime, data$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
lines(data$mydatetime, data$Sub_metering_1, col="Black")
lines(data$mydatetime, data$Sub_metering_2, col="Red")
lines(data$mydatetime, data$Sub_metering_3, col="Blue")
legend("topright", lty=1, col=c("Black", "Red", "Blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()