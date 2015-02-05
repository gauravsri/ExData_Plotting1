filename <- 'exdata_data_household_power_consumption.zip'

# read from zipped input file
alldata <- read.table( unz(filename, "household_power_consumption.txt"), header=T, sep=';',
                       stringsAsFactors=F,colClasses=c("character","character",rep("numeric",7)),na.strings=c('?'))

# add new datetime column of type POSIXlt
alldata$datetime <- strptime(paste(alldata$Date,alldata$Time), format="%d/%m/%Y %H:%M:%S")

# select the desired days subset of data...
data <- alldata[alldata$datetime >= as.POSIXlt("2007-02-01") & alldata$datetime < as.POSIXlt("2007-02-03"),]

# make plot4 using png device
png("plot4.png", width=480, height=480, units="px", bg="transparent")
par(mfcol=c(2,2))

# plot2 in upper left...
with(data=data[!is.na(data$Global_active_power),], plot(datetime,Global_active_power, main="",
                                                        ylab='Global Active Power', type='l',xlab=""))
# plot3 in lower left...
with(data=data[!is.na(data$Sub_metering_1),], plot(datetime,Sub_metering_1, main="", ylab='Energy sub metering', type='l',xlab=""))
with(data=data[!is.na(data$Sub_metering_2),], lines(datetime, Sub_metering_2, col='red'))
with(data=data[!is.na(data$Sub_metering_3),], lines(datetime, Sub_metering_3, col='blue'))
legend("topright",c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       yjust=0, bty='n',lwd=2,col=c('black','red','blue'))

# new plot upper right...
with(data=data[!is.na(data$Voltage),], plot(datetime, Voltage, type='l'))

# new plot lower right...
with(data=data[!is.na(data$Global_reactive_power),], plot(datetime, Global_reactive_power, type='l'))
dev.off()
