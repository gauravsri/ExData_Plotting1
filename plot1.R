filename <- 'exdata_data_household_power_consumption.zip'

# read from zipped input file
alldata <- read.table( unz(filename, "household_power_consumption.txt"), header=T, sep=';',
                       stringsAsFactors=F,colClasses=c("character","character",rep("numeric",7)),na.strings=c('?'))

# add new datetime column of type POSIXlt
alldata$datetime <- strptime(paste(alldata$Date,alldata$Time), format="%d/%m/%Y %H:%M:%S")

# select the desired days subset of data...
data <- alldata[alldata$datetime >= as.POSIXlt("2007-02-01") & alldata$datetime < as.POSIXlt("2007-02-03"),]

# make plot1 using png device
png("plot1.png", width=480, height=480, units="px", bg="transparent")
with(data=data[!is.na(data$Global_active_power),], hist(Global_active_power,col="red", main="Global Active Power",
                                                        xlab="Global Active Power (kilowatts)"))
dev.off()
