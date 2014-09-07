
###############################################    question 1 ############################
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
hist(powDataTable$Global_active_power,main ="Global Active Power",col ="red",freq = TRUE, xlab = "Gloabal Active Power (Kilowatt)")
library(datasets)
dev.copy(png,file="Plot1.png")
dev.off()
