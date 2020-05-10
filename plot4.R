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
png("plot4.png")
par(mfrow = c(2,2))
par(cex.lab=1)
par(cex.axis=1)
with(householdPowerSubset, plot(dayTime, Global_active_power, type="l",xlab ="", ylab = "Global Active Power(kilowatts)", cex.lab=0.7, cex.axis=1))
with(householdPowerSubset, plot(dayTime, as.numeric(as.character(Voltage)), type="l",xlab ="datetime", ylab = "Voltage"))
plot(householdPowerSubset$dayTime,householdPowerSubset$Sub_metering_1 ,xlab = "", ylab = "Energy sub metering", type = "n")
with(householdPowerSubset, lines(dayTime, as.numeric(as.character(Sub_metering_1))))
with(householdPowerSubset, lines(dayTime, as.numeric(as.character(Sub_metering_2)), col = "red"))
with(householdPowerSubset, lines(dayTime, as.numeric(as.character(Sub_metering_3)), col = "blue"))
legend("topright",bty = "n", lty = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black","red","blue"), cex = 0.8)
with(householdPowerSubset, plot(dayTime, as.numeric(as.character(Global_reactive_power)), type="l",xlab ="datetime", ylab = "Global_reactive_power"))
dev.off()
