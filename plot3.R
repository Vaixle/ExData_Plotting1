library(dplyr)
#read data table
householdPower<-read.table("./household_power_consumption.txt", sep = ";", header = TRUE)
householdPowerSubset<-subset(householdPower, householdPower$Date == "1/2/2007" | householdPower$Date == "2/2/2007")

#clear memory
rm(householdPower)

#edit date time format and Global_active_power format
householdPowerSubset$Global_active_power<- as.numeric(as.character(householdPowerSubset$Global_active_power))
householdPowerSubset$Date<- as.Date(householdPowerSubset$Date, format="%d/%m/%Y")
householdPowerSubset<-mutate(householdPowerSubset, dayTime = paste(Date, Time))
householdPowerSubset$dayTime<- strptime(householdPowerSubset$dayTime, format = "%Y-%m-%d %H:%M:%S")

# create plot
png("plot3.png")
plot(householdPowerSubset$dayTime,householdPowerSubset$Sub_metering_1 ,xlab = "", ylab = "Energy sub metering", type = "n")
with(householdPowerSubset, lines(dayTime, as.numeric(as.character(Sub_metering_1))))
with(householdPowerSubset, lines(dayTime, as.numeric(as.character(Sub_metering_2)), col = "red"))
with(householdPowerSubset, lines(dayTime, as.numeric(as.character(Sub_metering_3)), col = "blue"))
legend("topright", lty = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black","red","blue") )
dev.off()