# Download
getwd()
setwd ("C:/Users/Georgiana/Documents/R/proiecte/4ExploratoryDA")
getwd()


if(!file.exists("Project1")) {
        dir.create("Project1")
}


setwd ("C:/Users/Georgiana/Documents/R/proiecte/4ExploratoryDA/Project1")


file.url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(file.url, destfile= "data.zip", method = "internal")
list.files()

dateDownloaded <- date()### record the download date
dateDownloaded

# unzip
if(!file.exists("data")){
        unzip(zipfile="C:/Users/Georgiana/Documents/R/proiecte/4ExploratoryDA/Project1/data.zip", list = FALSE, overwrite = TRUE,exdir = ".")
} 

# load data
#TextPad to take a look the data, searched to find the rows for date 1/2/2007
#use read.table with skip
#Read header and assign the header later.
#minutes in 2 years =2880

file <- "C:/Users/Georgiana/Documents/R/proiecte/4ExploratoryDA/Project1/household_power_consumption.txt"
initial<-read.table(file, header = T,sep = ";", skip=66636, nrows=2880, na="?")
header <- read.table(file, nrows = 1, header = FALSE, sep =';', stringsAsFactors = FALSE)
colnames(initial) <- unlist(header)
head(initial)
tail(initial)

# Date and Time formatting
Sys.timezone()
#[1] "Europe/Istanbul" - I am in Bucharest/Romania
initial$DateTime <- strptime(paste(initial$Date, initial$Time), format="%d/%m/%Y %H:%M:%S")
initial$Date <- as.Date(initial$Date, "%d/%m/%Y")
#str(initial) #to check format of DateTime

# Plot4 - Multiple
png(file="plot4.png", width=480,height=480)

par(mfrow = c(2, 2), mar = c(4,4,2,1))

## Top-left
## Idem plot 2
with(initial, plot(DateTime, Global_active_power, xlab="", ylab = "Global Active Power", type="l"))

## Top-right
with(initial, plot(DateTime, Voltage,xlab = "datetime", ylab = "Voltage", type="l"))

## Bottom-left;
## Idem Plot 3, but with points command, without border for legend
with(initial, plot(DateTime, Sub_metering_1, xlab="", ylab = "Energy sub metering", type="n"))
with(initial, points(DateTime, Sub_metering_1, type="l", col="black"))
with(initial, points(DateTime, Sub_metering_2, type="l", col="red"))
with(initial, points(DateTime, Sub_metering_3, type="l", col="blue"))
## Legend (without border) #bty = "n"

legend("topright", col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1,lwd = 1, bty = "n")

## Bottom-right
with(initial, plot(DateTime, Global_reactive_power,xlab ='datetime', type="l"))

dev.off()

