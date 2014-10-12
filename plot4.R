# subset data to the dates shown in the plots

dat_subset <- subset(dat, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

# create combined date field
combined_date <- paste(as.Date(dat_subset$Date), dat_subset$Time)

# add combined date to the subset as a POSIXct object
dat_subset$combined_date <- as.POSIXct(combined_date)

# plot the subset
hist(dat_subset$Global_active_power, main="Global Active Power",
xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

# save file as .png in the right size
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()