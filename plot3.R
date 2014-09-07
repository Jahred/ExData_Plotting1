
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

with(powDataTable,plot(Date2,Sub_metering_1,type = "l",col="black",xlab="",ylab="Energy sub metering"))
with(lines(powDataTable$Date2,powDataTable$Sub_metering_2, col="red"))
with(lines(powDataTable$Date2,powDataTable$Sub_metering_3, col="blue"))
#with(subset(powDataTable,Sub_metering== Sub_metering_3),line(Date2,Sub_metering,col="green"))
legend("topright",cex=0.6,lty=c(1,1,1),col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.copy(png,file="Plot3.png",width=480,height=480)
dev.off()
