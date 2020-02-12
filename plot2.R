library(dplyr)

### Zip is downloaded and unziped ###

files<-"datasethousehold.zip"

if (!file.exists(files)){
  Url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(Url, files, method="curl")
}  
if (!file.exists("household_power_consumption.txt")) { 
  unzip(files) 
}

### Read the txt file. With na.strings we make that "?" is missing values ###

household <- read.table("household_power_consumption.txt", sep = ";", dec = ".", header = TRUE, na.strings = "?")

### Make the Date column a date class object ###

household$Date<-as.Date(household$Date, "%d/%m/%Y")

### Subsetting the dataset for having the two days requiere ###

household<-subset(household, Date=='2007-02-02' | Date=='2007-02-01')

### We create a new variable call "Fecha" that contains the paste of the date plus the time ###

Fecha <- paste(household$Date, " ", household$Time)

### Formating the new variable for having a POSIXlt class object ###

Fecha <- strptime(Fecha, "%Y-%m-%d   %H:%M:%S")

### Adding the Fecha variable to the end of the household dataset ###

household<-cbind(household, Fecha)

### Plot 2 ###

plot(household$Fecha, household$Global_active_power, type = "l", xlab = "", ylab="Global Active Power (kilowatts)" )        

### Coping the plot 2 to a png file and then closing the dev ###

dev.copy(png, file = "plot2.png")
dev.off()
