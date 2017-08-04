#produce plot #4 sending output to png file plot4.png

#specify columns to read from datafile (no need to read all columns for this plot)
#here, only one column (intensity) isn't read
cc <- c("character","character","numeric","numeric","numeric","NULL","numeric","numeric","numeric")

#read data file
pc <- read.table('household_power_consumption.txt',header = TRUE,sep = ";",
                 na.strings="?", colClasses=cc)

#chop data - extracting only relevant dates. 
#Date column was read as character - no need to convert to time for this.
#Note the non-standard date format
pc <- pc[pc$Date=="1/2/2007" | pc$Date=="2/2/2007",]

#convert time to POSIXct, combining the Date and Time columns
pc$Time <- as.POSIXct(with(pc, paste(Date,Time,sep=" ")), format = "%e/%m/%Y %H:%M:%S")

#open png device, set plot dim to 480 x 480 px.
png(filename="plot4.png",
     width = 480,
     height= 480
     )

#set canvas to 2 X 2
par(mfcol=c(2,2))

#generate plot #1 (upper left)
plot(pc$Time,pc$Global_active_power,type = "l",
     xlab = "",
     ylab="Global Active Power"
     )
#generate plot #2 (lower left) in 3 steps - start with sub_metering_1, then add 2 & 3

plot(pc$Time,pc$Sub_metering_1,type = "l",
     xlab = "",
     ylab="Energy sub metering"
     )
points(pc$Time,pc$Sub_metering_2,type = "l",col='red')
points(pc$Time,pc$Sub_metering_3,type = "l",col='blue')

#add legend
legend("topright",lty=c(1,1,1),
       col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       bty="n",
       seg.len = 1,
       x.intersp = 0.5,
       y.intersp = 0.8
       )

#generate plot #3 (upper right)
plot(pc$Time,pc$Voltage,type = "l", #voltage
     xlab = "datetime",
     ylab="Voltage"
     )

#generate plot #4 (lower right)
plot(pc$Time,pc$Global_reactive_power,type = "l",
     xlab = "datetime",
     ylab="Global_reactive_power"
     )

#close output device
dev.off()

