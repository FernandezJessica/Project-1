#importation du fichier
temp <- tempfile()
download.file("https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip",temp)
file <- unzip(temp)
unlink(temp)


#lecture et correction de la table
Electric_power_consumption  <- read.table(file, header=T, sep=";")
Electric_power_consumption$Date <- as.Date(Electric_power_consumption$Date,format="%d/%m/%Y")
power <- Electric_power_consumption[(Electric_power_consumption$Date=="2007-02-01") | (Electric_power_consumption$Date=="2007-02-02"),]
power$Global_active_power<- as.numeric(as.character(power$Global_active_power))#Création de la date et heure
power$dateheure<-strptime(paste(power$Date,power$Time),format= "%Y-%m-%d %H:%M:%S")
power$Sub_metering_1<- as.numeric(as.character(power$Sub_metering_1))
power$Sub_metering_2<- as.numeric(as.character(power$Sub_metering_2))
power$Sub_metering_3<- as.numeric(as.character(power$Sub_metering_3))
power$Voltage<- as.numeric(as.character(power$Voltage))
power$Global_reactive_power<- as.numeric(as.character(power$Global_reactive_power))


par(mfrow=c(2,2))

plot(power$dateheure,power$Global_active_power, type="l", xlab="", ylab="Global Active Power")

plot(power$dateheure,power$Voltage, type="l", xlab="datetime", ylab="Voltage")

plot(power$dateheure,power$Sub_metering_1,typ='l', xlab="", ylab="Energy sub metering",col="black")
lines(power$dateheure,power$Sub_metering_2,col="red")
lines(power$dateheure,power$Sub_metering_3,col="blue")
legend("topright",col=c("black","red", "blue"), c("Sub_metering_1                  ","Sub_metering_2", "Sub_metering_3"),lty=1,c=.9,bty="n")

plot(power$dateheure,power$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()
