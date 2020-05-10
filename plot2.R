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
png(file = "plot2.png")
with(householdPowerSubset, plot(dayTime, Global_active_power, type="l",xlab ="", ylab = "Global Active Power(kilowatts)"))
dev.off()