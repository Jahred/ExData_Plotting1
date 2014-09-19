NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
sums <- vector()
j<-0L
yearsOfObservation <- unique(NEI$year)
for(i in yearsOfObservation){
  j<-j+1
  neiYear <- subset(NEI,NEI$year == i)
  sums[j] <- sum(neiYear$Emissions)
}
xlab1 <-"Year of Observation"
ylab1="Total Emissions in tons"
fit <- lm(yearsOfObservation ~sums)
abline(fit,lwd = 2,col ="green")
plotSumsPerYear <- plot(unique(NEI$year),sums,xlab=xlab1,ylab=ylab1,main="Decreasing Emissions",type="l")
dev.copy(png,file="Plot1.png",width=480,height=480)
dev.off()
