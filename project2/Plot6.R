#required libraries
library(plyr)
library(ggplot2)

#read data in
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#select only interessing data
dataBaltimore <- NEI[NEI$fips == "24510",]
dataCalifornia <- NEI[NEI$fips == "06037",]

#find tho row of interest
vehiclePattern <- "*[Vv]ehicles*|(*Highway Veh *)"
vehicleRows <-grep(vehiclePattern,SCC$Short.Name)

vehicleRelatedCodes <- SCC[vehicleRows,]
vehicleRelatedCodes<-vehicleRelatedCodes$SCC

#make data more restrictive
dataBaltimore <- subset(dataBaltimore,dataBaltimore$SCC %in% vehicleRelatedCodes)
dataCalifornia <- subset(dataCalifornia,dataCalifornia$SCC %in% vehicleRelatedCodes)

#calcuate the sums per year
baltimore<-tapply(dataBaltimore$Emissions,dataBaltimore$year,sum)

#make a data frame from array
baltimore <- data.frame(year=as.integer(names(baltimore)),Emissions =as.vector(baltimore))
baltimore<-cbind(baltimore,data.frame(origin =c("baltimore","baltimore","baltimore","baltimore")))

#repeat for california
california<-tapply(dataCalifornia$Emissions,dataCalifornia$year,sum)
california<-data.frame(year=as.integer(names(california)),Emissions=as.vector(california),origin=c("california","california","california","california"))

#combine data together and transfor origin infactor variable
entireData <-rbind(baltimore,california)
entireData <- transform(entireData,origin=factor(origin))

#plot
ylab1="Total Emissions in tons"

plot6 <- ggplot(entireData,aes(x=year,y=Emissions))+geom_line(aes(color=origin))+facet_grid(. ~ origin)+labs(title="Motor Vehicle Related Emissions")+ylab(ylab1)
print(plot6)

#as png  
dev.copy(png,file="Plot6.png",width=480,height=480)
dev.off()
