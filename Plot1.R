
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

# plot 1
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(initial$Global_active_power, col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)",
     breaks = 12, ylim = c(0, 1200))
dev.off()


