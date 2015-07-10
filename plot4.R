# Load a library
install.packages("dplyr")
library(dplyr)


## Read data
df <- read.table("household_power_consumption.txt", header = T, sep = ";")


# Change global parameters
par(cex.axis = 0.7)
par(cex.lab = 0.7)


## Create new variables
df$Date2 <- as.Date(df$Date, "%d/%m/%Y")
df2 <- filter(df, Date2 <= "2007-02-02" & Date2 >= "2007-02-01")
df2$DateTimestr <- paste(df2$Date, df2$Time)
df2$DateTime <- strptime(df2$DateTimestr, "%d/%m/%Y %H:%M:%S")
df2$Global_active_power2 <- as.numeric(as.character(df2$Global_active_power))
df2$Sub_metering_1 <- as.numeric(as.character(df2$Sub_metering_1))
df2$Sub_metering_2 <- as.numeric(as.character(df2$Sub_metering_2))
df2$Sub_metering_3 <- as.numeric(as.character(df2$Sub_metering_3))
df2$Voltage <- as.numeric(as.character(df2$Voltage))
df2$Global_reactive_power <- as.numeric(as.character(df2$Global_reactive_power))


## 4
par(mfrow = c(2,2))
par(mar = c(4,4,2.5,2.5))
# a
plot(df2$DateTime, df2$Global_active_power2, 
     type = "l", 
     ylab = "Global Active Power",
     xlab = "",
)
# b
plot(df2$DateTime, df2$Voltage, 
     type = "l", 
     ylab = "Voltage",
     xlab = "datetime",
)
# c
plot(x = c(df2$DateTime, df2$DateTime, df2$DateTime), 
     y = c(df2$Sub_metering_1, df2$Sub_metering_2, df2$Sub_metering_3),
     type = "n",
     ylab = "Energy sub metering",
     xlab = ""
)

lines(df2$DateTime, df2$Sub_metering_1, col = "black")
lines(df2$DateTime, df2$Sub_metering_3, col = "blue")
lines(df2$DateTime, df2$Sub_metering_2, col = "red")

legend("topright", 
       lty = 1,
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       cex = 0.6,
       bty = "n",
       inset=c(0.1,-0.05))
#d
plot(df2$DateTime, df2$Global_reactive_power, 
     type = "l", 
     ylab = "Global_reactive_power",
     xlab = "datetime",
)

dev.copy(png, file = "plot4.png")
dev.off()
