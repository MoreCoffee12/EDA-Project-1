# This code assumes that the data file is in the working
# directory, but it was too large to include in GitHub.
data <- read.csv("household_power_consumption.txt", 
                 header = TRUE, sep = ";", 
                 stringsAsFactors = FALSE)

# Convert strings to a date
data[,1] <- as.Date(data[,1], "%d/%m/%Y")

# Pull out data for the selected dates
dataTidy <- data[data$Date >= as.Date("2007-02-01") & 
                   data$Date <= as.Date("2007-02-02"),]

# Invalid data?
t <- dataTidy[grep("?", dataTidy),]

# Convert the strings to numeric values
dataTidy$Global_active_power <- as.numeric(dataTidy$Global_active_power)

# Create the histogram plot
png("plot1.png", width = 480, height = 480)

hist(dataTidy$Global_active_power, 
     col = "red", 
     xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")
dev.off()
