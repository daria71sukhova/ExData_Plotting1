## Draw Global Activ Power histogram

library(sqldf)

filename <- "household_power_consumption.zip"
file <- "household_power_consumption.txt"
quiery <- "select * from file where Date = '1/2/2007' or Date = '2/2/2007'"

# Download and unzip the archive
if(!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, filename, method = "curl")
}

if(!file.exists(file)){
  unzip(filename)
}

# Extract essential lines from _file_ and make the data frame
data <- read.csv.sql(file, sql = quiery, header = TRUE, sep = ";" )

# Convert Date and Time variables to Date/Time classes
dt <- paste(data$Date, data$Time)
data$Time <- strptime(dt, "%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date, "%d/%m/%Y")

# Construct _GlobalActiv Power_ histogram
png("plot2.png")
plot(data$Time, data$Global_active_power, type="l", xlab="", ylab = "Global Active Power (kilowatts)")
dev.off()

