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
plot(x = subset_data[, dateTime]
     , y = subset_data[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")