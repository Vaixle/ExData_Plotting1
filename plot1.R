#read data table
householdPower<-read.table("./household_power_consumption.txt", sep = ";", header = TRUE)
householdPowerSubset<-subset(householdPower, householdPower$Date == "1/2/2007" | householdPower$Date == "2/2/2007")

#clear memory
rm(householdPower)

#creat hist
png("plot1.png")
hist(as.numeric(as.character(householdPowerSubset$Global_active_power)), col = "red", main = "Global Active Power", xlab = "Global Active Power(kilowatts)")
dev.off()