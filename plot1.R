#importation du fichier
temp <- tempfile()
download.file("https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip",temp)
file <- unzip(temp)
unlink(temp)


#lecture et correction de la table
Electric_power_consumption  <- read.table(file, header=T, sep=";")
Electric_power_consumption$Date <- as.Date(Electric_power_consumption$Date,format="%d/%m/%Y")
power <- Electric_power_consumption[(Electric_power_consumption$Date=="2007-02-01") | (Electric_power_consumption$Date=="2007-02-02"),]
power$Global_active_power<- as.numeric(as.character(power$Global_active_power))


#histogramme
hist(power$Global_active_power, main = paste("Global Active Power"), col="red", xlab="Global Active Power (kilowatts)")
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()
