#produce plot #2 sending output to png file plot2.png

#specify columns to read from datafile (no need to read all columns for this plot)
cc <- c("character","character","numeric","NULL","NULL","NULL","NULL","NULL","NULL")

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
png(filename="plot2.png",
     width = 480,
     height= 480
     )

#generate the plot
plot(pc$Time,pc$Global_active_power,type = "l",
     xlab = "",
     ylab="Global Active Power (kilowatts)")

#close output device
dev.off()