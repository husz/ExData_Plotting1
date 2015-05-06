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

#creating of plot1.png
#open png graphic device
print ("open graphic device....")
png(file = "plot1.png", width = 480, height = 480)
#make histogram
print ("creating histogram...")
hist( data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
#close graphic device
dev.off()

#histogram with name plot1.png is now stored in working directory
print ("histogram with name plot1.png is now stored in your working directory")

