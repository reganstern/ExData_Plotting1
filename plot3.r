getPowerData <- function(){
        file <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        temp <- tempfile()
        download.file(file, temp)
        power <- fread(unzip(temp), na.strings = "?") %>% subset(Date == "1/2/2007" | Date == "2/2/2007")
        unlink(temp)
        return(power)
}


if(!dir.exists("./data")){
        dir.create("./data")
}
setwd("./data")

powerData <- getPowerData()
rtime <- strptime(paste(powerData$Date,powerData$Time), "%d/%m/%Y %H:%M:%S")
png(file="plot3.png")
plot(rtime,powerData$Sub_metering_1, type="l", ylab = "Energy sub metering", xlab = "")
points(rtime,powerData$Sub_metering_2, type="l", col="red")
points(rtime,powerData$Sub_metering_3, type="l", col="blue")
legend("toprigh", pch = "---", col=c("black", "red", "blue"), 
         legend=c("Sub_meter_1", "Sub_meter_2", "Sub_meter_3"))
dev.off()
rm("powerData", "rtime", "getPowerData")
setwd("..")