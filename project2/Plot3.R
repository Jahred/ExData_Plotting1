    (library(ggplot2))

library(plyr)
library(reshape2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
baltimore <-subset(NEI,NEI$fips == "24510")
baltimoe <- transform(baltimore, year =factor(year),type=factor(type))
baltimoe <- split(baltimoe,list(baltimoe$year,baltimoe$type,drop=TRUE))
sumsPoitYear <-data.frame(sapply(baltimoe,function(x) sum (x$Emissions)))
names(sumsPoitYear) <-c("Emissions")
xlab1 <-"Year of Observation"
ylab1="Total Emissions in tons"

rn <-row.names(sumsPoitYear)
years <-as.integer(substr(rn,0,4))
dim(years)<-c(length(years),1)
sumsPoitYear<- cbind(sumsPoitYear,years)
point <-gsub("([0-9])|\\.|(\\.TRUE)","",rn)
dim(point) <-c(length(years),1)
sumsPoitYear<- cbind(sumsPoitYear,point)
sumsPoitYear<- transform(sumsPoitYear,point=factor(point))

qplot(years,Emissions,data= sumsPoitYear,color=point,geom=c("line"))
# qplot(years,Emissions,data= sumsPoitYear,color=point,geom=c("line"),facets=.~ point)
# qplot(years,Emissions,data= sumsPoitYear,color=point,geom=c("line"),facets= point ~. )


dev.copy(png,file="Plot3.png",width=480,height=480)
dev.off()
