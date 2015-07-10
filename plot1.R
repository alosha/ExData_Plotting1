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


## 1
par(mfrow = c(1,1))
hist(df2$Global_active_power2, 
     col = "red", 
     main = "Global Active Power",
     xlab = "Global Active Power (killowatts)"
)
dev.copy(png, file = "plot1.png")
dev.off()