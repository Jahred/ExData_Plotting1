
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

par(mfrow=c(2,2),mar=c(5,4,1,2))
with(powDataTable,{ 
  plota<- plot(powDataTable$Global_active_power ~ powDataTable$Date2 ,type = "l" ,ylab = "Gloabal Active Power" , xlab = "" )       
  plotb<- plot(powDataTable$Voltage ~ powDataTable$Date2 ,type = "l" ,ylab = "Voltage" , xlab = "datetime" )       
  
  plotc <- plot(powDataTable$Date2 , powDataTable$Sub_metering_1,type = "l",col="black",xlab="",ylab="Energy sub metering")
  with(plotc,lines(powDataTable$Date2,powDataTable$Sub_metering_2, col="red"))
  with(plotc,lines(powDataTable$Date2,powDataTable$Sub_metering_3, col="blue"))
  with(plotc,legend("topright",cex=0.6,bty="n",y.intersp=0.5, lty=c(1,1,1),col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3")))
  
   
plotd<- plot(powDataTable$Global_reactive_power ~ powDataTable$Date2 ,type = "l" ,ylab = "Global_reactive_power " , xlab = "datetime" )       

})

dev.copy(png,file="Plot4.png",width=480,height=480,pointsize=10)
dev.off()
