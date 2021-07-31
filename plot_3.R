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

# plot
plot(subset_data[, dateTime], subset_data[, Sub_metering_1], type="l", xlab="", 
     ylab="Energy sub metering")
lines(subset_data[, dateTime], subset_data[, Sub_metering_2],col="red")
lines(subset_data[, dateTime], subset_data[, Sub_metering_3],col="blue")
legend("topright", col = c("black","red","blue"), cex = 0.5, 
       c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
       lty = c(1,1), lwd = c(1,1))