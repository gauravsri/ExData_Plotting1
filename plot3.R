filename <- 'exdata_data_household_power_consumption.zip'

# read from zipped input file
alldata <- read.table( unz(filename, "household_power_consumption.txt"), header=T, sep=';',
                       stringsAsFactors=F,colClasses=c("character","character",rep("numeric",7)),na.strings=c('?'))

# add new datetime column of type POSIXlt
alldata$datetime <- strptime(paste(alldata$Date,alldata$Time), format="%d/%m/%Y %H:%M:%S")

# select the desired days subset of data...
data <- alldata[alldata$datetime >= as.POSIXlt("2007-02-01") & alldata$datetime < as.POSIXlt("2007-02-03"),]

# make plot3 using png device
png("plot3.png", width=480, height=480, units="px", bg="transparent")
with(data=data[!is.na(data$Sub_metering_1),], plot(datetime,Sub_metering_1, main="", ylab='Energy sub metering', type='l',xlab=""))
with(data=data[!is.na(data$Sub_metering_2),], lines(datetime, Sub_metering_2, col='red'))
with(data=data[!is.na(data$Sub_metering_3),], lines(datetime, Sub_metering_3, col='blue'))
legend("topright",c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),lwd=2,col=c('black','red','blue'))
dev.off()
