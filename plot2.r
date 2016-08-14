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
png(file="plot2.png")
plot(rtime, powerData$Global_active_power, type="l", xlab= "", ylab = "Global Active Power (kilowatts)")
dev.off()
rm("powerData", "rtime", "getPowerData")
setwd("..")