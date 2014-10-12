# read power.txt into R object "dat"

dat <- read.csv("~/Downloads/power.txt", header=TRUE, sep=';', na.strings="?")

# convert dat$Date column from Character to Date class

dat$Date <- as.Date(dat$Date, format="%d/%m/%Y")

# subset data to the dates shown in the plots
dat_subset <- subset(dat, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

# create combined date field
combined_date <- paste(as.Date(dat_subset$Date), dat_subset$Time)

# add combined date to the subset as a POSIXct object
dat_subset$combined_date <- as.POSIXct(combined_date)

# plot the subset
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(dat_subset, {
  plot(Global_active_power~combined_date, type="l",
    ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~combined_date, type="l",
    ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~combined_date, type="l",
    ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~combined_date,col='Red')
  lines(Sub_metering_3~combined_date,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
    legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~combined_date, type="l",
    ylab="Global Rective Power (kilowatts)",xlab="")
})

# save file as .png in the right size
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()