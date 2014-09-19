library(plyr)


NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

coalPattern <- "(.*?) Comb (.*?) Coal(.*)"    #"*[Cc]oal*"
coalRows <-grep(coalPattern,SCC$Short.Name)
 coalRelatedCodes <- SCC[coalRows,]
coalRelatedCodes<-coalRelatedCodes$SCC
data <- subset(NEI,NEI$SCC %in% coalRelatedCodes)
#str(data)
sums<-tapply(data$Emissions,data$year,sum)

xlab1 <-"Year of Observation"
ylab1="Total Emissions in tons"
plot4 <-plot(unique(NEI$year),sums,xlab = xlab1,ylab = ylab1,type = "l",lwd=3,col="blue",main="Evolution Coal Related Emissions",cex.main=0.6)

dev.copy(png,file="Plot4.png",width=480,height=480)
dev.off()
