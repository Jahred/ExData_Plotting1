NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
sums <- vector()
j<-0L
yearsOfObservation <- unique(NEI$year)

sums <- vector()

j<-0L
yearsOfObservation <- unique(NEI$year)

for(i in yearsOfObservation){
  j<-j+1
  neiYearBaltimor <- subset(NEI,NEI$year == i & NEI$fips == "24510")
  sums[j] <- sum(neiYearBaltimor$Emissions)
}
xlab1 <-"Year of Observation"
ylab1="Total Emissions in tons"
  plotSumsPerYear <- plot(unique(NEI$year),sums,xlab=xlab1,ylab=ylab1,main="Emissions Baltimore",type = "l")
dev.copy(png,file="Plot2.png",width=480,height=480,cex.main=0.75)
dev.off()
