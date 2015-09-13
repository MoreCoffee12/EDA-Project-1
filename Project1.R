# This code assumes that the data file is in the working
# directory, but it was too large to include in GitHub.
data <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)

# Convert strings to a date
data[,1] <- as.Date(data[,1], "%d/%m/%Y")
