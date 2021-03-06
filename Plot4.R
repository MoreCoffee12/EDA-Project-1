# This code assumes that the data file is in the working
# directory, but it was too large to include in GitHub.
data <- read.csv("household_power_consumption.txt", 
                 header = TRUE, sep = ";", 
                 stringsAsFactors = FALSE)

# Convert strings to a date
data$DateTime <- strptime(paste(data[,1], data[,2]), "%d/%m/%Y %H:%M:%S")

# Pull out data for the selected dates
dataTidy <- data[data$DateTime >= strptime("2007-02-01", "%Y-%m-%d") & 
                   data$DateTime <= strptime("2007-02-02 23:59:59","%Y-%m-%d  %H:%M:%S"),]

# Invalid data?
dataTidy <- dataTidy[-grep("?", dataTidy),]

# Convert the strings to numeric values
dataTidy$Global_active_power <- as.numeric(dataTidy$Global_active_power)
dataTidy$Sub_metering_1 <- as.numeric(dataTidy$Sub_metering_1)
dataTidy$Sub_metering_2 <- as.numeric(dataTidy$Sub_metering_2)
dataTidy$Sub_metering_3 <- as.numeric(dataTidy$Sub_metering_3)
dataTidy$Voltage <- as.numeric(dataTidy$Voltage)
dataTidy$Global_reactive_power <- as.numeric(dataTidy$Global_reactive_power)

# Create the line plot
png("plot4.png", width = 480, height = 480)

# Place all the plots on a single page
par(mfrow=c(2,2))

# Top-left plot
plot(dataTidy$DateTime,dataTidy$Global_active_power, 
     type="n",
     xlab = "", 
     ylab = "Global Active Power (kilowatts)", 
     main = "")
lines(dataTidy$DateTime,dataTidy$Global_active_power, type="l")

# Top-right plot
plot(dataTidy$DateTime,dataTidy$Voltage, 
     type="n",
     xlab = "", 
     ylab = "Voltage", 
     main = "")
lines(dataTidy$DateTime,dataTidy$Voltage, type="l")

# Bottom-left plot
plot(dataTidy$DateTime,dataTidy$Sub_metering_1, 
     type="n",
     xlab = "", 
     ylab = "Energy sub metering", 
     main = "")
lines(dataTidy$DateTime,dataTidy$Sub_metering_1, type="l")
lines(dataTidy$DateTime,dataTidy$Sub_metering_2, type="l", col="red")
lines(dataTidy$DateTime,dataTidy$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_Metering_1","Sub_Metering_2","Sub_Metering_3"))

# Bottom-right plot
plot(dataTidy$DateTime,dataTidy$Global_reactive_power, 
     type="n",
     xlab = "", 
     ylab = "Global_reactive_power", 
     main = "")
lines(dataTidy$DateTime,dataTidy$Global_reactive_power, type="l")


dev.off()
