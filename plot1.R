#produce plot #1 - sending output to png file plot1.png

#specify columns to read from datafile (no need to read all columns for this plot)
cc <- c("character","NULL","numeric","NULL","NULL","NULL","NULL","NULL","NULL")

#read data file
pc <- read.table('household_power_consumption.txt',header = TRUE,sep = ";",
                 na.strings="?", colClasses=cc)

#chop data - extracting only relevant dates. 
#Date column was read as character - no need to convert to time for this.
#Note the non-R-standard date format
pc <- pc[pc$Date=="1/2/2007" | pc$Date=="2/2/2007",]

#open png device, set plot dim to 480 x 480 px.
png(filename="plot1.png",
    width = 480,
    height= 480
    )

#draw required histogram to png file
hist(pc$Global_active_power,
     col="red",
     xlab="Global Active Power (kiowatts)",
     main = "Global Active Power"
     )
#close output device
dev.off()

