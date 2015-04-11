#
# EDA - project 1, plot1
# 
# read data frame, add basic names.
# Only read selected records to optimize script.
df<-read.csv("household_power_consumption.txt", sep=";", skip=66636, nrow=2880, header = TRUE)
colnames(df)<-c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
# create new datetime column from Data and Time to simplify further operations
df<-cbind(as.POSIXct(paste(df$Date,df$Time,sep=" "),format="%d/%m/%Y %H:%M:%S"),df)
# Remove older Date and Time columns
drops <- c("Date","Time")
colnames(df)[1]<-"datetime"
df<-df[,!(names(df) %in% drops)]

# Plot 1
# save to PNG
png(filename = "plot1.png",width = 480, height = 480)
hist(df$Global_active_power,xlab = "Global Active Power (kilowatts)", col = "red", ylim = c(0,1300), main = "Global Active Power")
dev.off()
