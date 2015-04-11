#
# EDA - project 1, plot4
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

#Plot 4
png(filename = "plot4.png",width = 480, height = 480)

# set 2x2 matrix and store old par for reset later
cur_par<-par(mfrow = c(2,2))

# first plot
plot(df$Global_active_power~df$datetime,type = "l",xlab="",ylab = "Global Active Power")

#second plot
with(df,plot(Voltage~datetime,type="l"))

#third plot
plot(df$Sub_metering_1~df$datetime,type="l",xlab = "", ylab = "Energy sub metering")
lines(df$Sub_metering_2~df$datetime,type="l", col="red")
lines(df$Sub_metering_3~df$datetime,type="l", col="blue")
legend("topright",names(df)[6:8], col=c("black","red","blue"), lty=1, bty="n")

#fourth plot
with(df,plot(Global_reactive_power~datetime,type="l"))

#reset parameters and close device
par(cur_par)
dev.off()