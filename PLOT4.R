table <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
table$Date <- as.Date(table$Date, "%d/%m/%Y")
table <- subset(table,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
table <- table[complete.cases(table),]
dateTime <- paste(table$Date, table$Time)
dateTime <- setNames(dateTime, "DateTime")
table <- table[ ,!(names(table) %in% c("Date","Time"))]
table <- cbind(dateTime, table)
tabledateTime <- as.POSIXct(dateTime)
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(table, {
     plot(Global_active_power~dateTime, type="l", 
                       ylab="Global Active Power (kilowatts)", xlab="")
     plot(Voltage~dateTime, type="l", 
                       ylab="Voltage (volt)", xlab="")
     plot(Sub_metering_1~dateTime, type="l", 
                       ylab="Global Active Power (kilowatts)", xlab="")
     lines(Sub_metering_2~dateTime,col='Red')
     lines(Sub_metering_3~dateTime,col='Blue')
     legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
                          legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
     plot(Global_reactive_power~dateTime, type="l", 
                       ylab="Global Rective Power (kilowatts)",xlab="")
   })
