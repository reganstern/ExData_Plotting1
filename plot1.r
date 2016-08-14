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
png(file="plot1.png")
hist(powerData$Global_active_power, col = "red", xlab="Global Active Power (kilowatts)", 
     main = "Global Active Power")
dev.off()
rm("powerData", "getPowerData")
setwd("..")