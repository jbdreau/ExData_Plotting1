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
with(dat_subset, 
  {
    plot(Sub_metering_1~combined_date, type="l",
    ylab="Global Active Power (kilowatts)", xlab="")
    lines(Sub_metering_2~combined_date,col='Red')
    lines(Sub_metering_3~combined_date,col='Blue')
  })

legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2,
legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# save file as .png in the right size
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
