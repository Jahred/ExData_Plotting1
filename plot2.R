
###############################################    question 2 ############################
dataFile <- "household_power_consumption.txt"


Sys.setlocale("LC_TIME",locale = "en_US")
regex <- "^([1-2]/2/2007)"

readAffectedData <- function(filename,regex) {
  template <- read.table(filename,header=TRUE, sep=";",nrow=-1,na.string="?")
  namesInTable <- names(template)
  sourcefile=file(filename,"r")
  dataTable=read.table(text = grep(regex,readLines(sourcefile),value=TRUE),header=FALSE, sep=";")
  close(sourcefile)
  names(dataTable)=namesInTable
   dataTable
}
 
powDataTable <- readAffectedData(dataFile,regex)
library(stringr)
fmt ="%d/%m/%Y %H:%M:%S"
powDataTable$Date2 <- as.POSIXct(strptime(paste(powDataTable$Date,powDataTable$Time),fmt))
plot2<- plot(powDataTable$Global_active_power ~ powDataTable$Date2 ,type = "l" ,ylab = "Gloabal Active Power (Kilowatts)" , xlab = "" )       
dev.copy(png,file="Plot2.png")
dev.off()
