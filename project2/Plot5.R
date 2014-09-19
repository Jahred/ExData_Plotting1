library(plyr)


NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

data <- NEI[NEI$fips == "24510",]
vehiclePattern <- "*[Vv]ehicles*|(*Highway Veh *)"
vehicleRows <-grep(vehiclePattern,SCC$Short.Name)
vehicleRelatedCodes <- SCC[vehicleRows,]
vehicleRelatedCodes<-vehicleRelatedCodes$SCC
data <- subset(data,data$SCC %in% vehicleRelatedCodes)
#str(data)
sums<-tapply(data$Emissions,data$year,sum)

xlab1 <-"Year of Observation"
ylab1="Total Emissions in tons"
plot4 <-plot(unique(NEI$year),sums,xlab = xlab1,ylab = ylab1,type = "l",lwd=3,col="blue",main="Evolution vehicle Related Emissions Baltimore city",cex.main=0.6)

dev.copy(png,file="Plot5.png",width=480,height=480)
dev.off()
