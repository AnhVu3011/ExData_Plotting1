library("data.table")

# read data
my_data <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?")

# avoid "?"
my_data[, Global_active_power := lapply(.SD, as.numeric), 
        .SDcols = c("Global_active_power")]

# Make POSIXct date
my_data[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 2007-02-01 and 2007-02-02
subset_data <- my_data[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

# set frame
par(mfrow = c(2,2), mar = c(4, 4, 1, 1))

# Plot 1
plot(x = subset_data[, dateTime], y = subset_data[, Global_active_power], type="l", 
     xlab="", ylab="Global Active Power")

# Plot 2
plot(x= subset_data[, dateTime], y = subset_data[, Voltage], type="l", 
     xlab="datetime", ylab="Voltage")

# Plot 3
plot(x= subset_data[, dateTime], y = subset_data[, Sub_metering_1], type="l", 
     xlab="", ylab="Energy sub metering")
lines(x = subset_data[, dateTime], y = subset_data[, Sub_metering_2], col="red")
lines(x = subset_data[, dateTime], y = subset_data[, Sub_metering_3],col="blue")
legend("topright", col = c("black","red","blue")
       , c("Sub_metering_1","Sub_metering_2 ", "Sub_metering_3")
       , lty = c(1,1)
       , bty = "n"
       , cex = .3) 

# Plot 4
plot(x = subset_data[, dateTime], y = subset_data[,Global_reactive_power], type="l", 
     xlab="datetime", ylab="Global_reactive_power")