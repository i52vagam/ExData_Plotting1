#Before get to work, we are going to check if we have the necessary file in the correct folder.
#If we don't have it, we will download and unzip the data file.

#file path
dataset.path <- paste(getwd(),"household_power_consumption.txt",sep = "/") 

#Checking file and getting it if necessary
if(!file.exists(dataset.path))
{
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, "exdata-data-household_power_consumption.zip", method="curl")
  unzip("exdata-data-household_power_consumption.zip")
  remove(fileURL)
} 

#Reading data
powerConsumption.data <- read.table(dataset.path,sep=";",header =  TRUE,na.strings ="?",stringsAsFactors=F)

#Subsetting data
powerConsumption.data2 <- subset(powerConsumption.data,Date=="1/2/2007" | Date=="2/2/2007")                                   

#Creating the variable dateTime
powerConsumption.data2$dateTime <- 
  strptime(paste(powerConsumption.data2$Date,powerConsumption.data2$Time), "%d/%m/%Y %H:%M:%S")

#We need to change the system local time to show the days of the week using english language
#if we are in a not english speaking country
lct <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "C")

#Redirecting output to png file
#It's no necessary to set height, width and units to 480x480 pixels 
#because these are the default values.
#We set these values to ease the code reading
png("plot3.png", height=480, width=480,units="px")
  with(powerConsumption.data2,{
       plot(dateTime,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
       lines(dateTime,Sub_metering_2,col='Red')
       lines(dateTime,Sub_metering_3,col='Blue')
       legend("topright",legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),
              col=c('black','red','blue'),lwd=1,lty=1)
       }
       )
dev.off()

#We reset the system local time again to its origin value
Sys.setlocale("LC_TIME", lct)

remove(powerConsumption.data)
remove(powerConsumption.data2)
remove(dataset.path)
remove(lct)