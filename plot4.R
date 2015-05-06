#please put this script in your working directory

#for purposes of this script you need to download following data
#https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#and unzip file household_power_consumption.txt in your working directory

#sqldf package will be used for reading data
library(sqldf)

#set sql string which is used in read.csv.sql function to read only data for 2007-02-01 and 2007-02-01
#date in file is in dd/mm/yyy format
sql_str <-"select * from file where Date = '1/2/2007' or Date = '2/2/2007'" 

#reading data
print ("reading data...")
data <- read.csv.sql("household_power_consumption.txt", sql = sql_str ,header = TRUE, sep = ";", stringsAsFactors = FALSE)

#add time to column Date and convert it into POSTIX format, so Date will contains timestamp 
data$Date<- strptime(paste(data$Date,data$Time),"%d/%m/%Y %H:%M:%S")

#creating of plot4.png
#open png graphic device
print ("open graphic device....")
png(file = "plot4.png", width = 480, height = 480)
#creating plot
print ("creating plot...")

#set parameter mfrow in order to results contains 4 plot
par(mfrow = c(2,2))
#plot in position 1,1 
plot(data$Date, data$Global_active_power, type = 'l',ylab = "Global Active Power (kilowatts)", xlab = "")
#plot in position 1,2 
plot(data$Date, data$Voltage, type = 'l',ylab = "Voltage", xlab = "Datetime")
#plot in position 2,1 
plot(data$Date,data$Sub_metering_1, type = 'l', col = "black", xlab = "", ylab = "Energy sub metering")
lines(data$Date,data$Sub_metering_2, col = "red")
lines(data$Date,data$Sub_metering_3, col = "blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col = c("black","red","blue"),lty = c(1,1,1), bty='n')
#plot in position 2,2 
plot(data$Date, data$Global_reactive_power, type = 'l',ylab = "Global_reactive_power", xlab = "Datetime")
 
#close graphic device
dev.off()

#plot with name plot4.png is now stored in working directory
print ("plot with name plot4.png is now stored in your working directory")
