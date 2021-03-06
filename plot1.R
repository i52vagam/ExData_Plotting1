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

#Redirecting output to png file
#It's no necessary to set height, width and units to 480x480 pixels 
#because these are the default values.
#We set these values to ease the code reading
png("plot1.png", height=480, width=480,units="px")
  hist(powerConsumption.data2$Global_active_power,col="red",main="Global Active Power",
       xlab="Global Active Power (kilowatts)")
dev.off()

remove(powerConsumption.data)
remove(powerConsumption.data2)
remove(dataset.path)