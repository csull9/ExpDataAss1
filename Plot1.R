## Read data and subset 2007-02-01 and 2007-02-02 

consumption <- read.csv("household_power_consumption.txt", sep=";")
consumption[,1] <- as.Date(consumption[,1], "%d/%m/%Y")
consumption <- consumption[which(as.numeric(format(consumption$Date,"%Y")) == 2007),]
consumption <- consumption[which(as.numeric(format(consumption$Date,"%m")) == 2),]
consumption <- consumption[which(as.numeric(format(consumption$Date,"%d")) < 3),]

## Plot 1 
consumption[,3] <- as.numeric(as.character(consumption[,3]))
png(filename = "plot1.png")
hist(consumption$Global_active_power, col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.off()