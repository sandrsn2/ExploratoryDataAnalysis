download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", f) 
unzip(f) 
unzip1 <- unzip(f, list=TRUE)$Name[1]
unzip2 <- unzip(f, list=TRUE)$Name[2]
NEI <- readRDS(unzip2)
close
SCC <- readRDS(unzip1)
close

# 6.Compare emissions from motor vehicle sources in Baltimore City with emissions from motor 
# vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen 
# greater changes over time in motor vehicle emissions?

# years
NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008')) 

# Baltimore City, Maryland 
# Los Angeles County, California 
Baltimore.onroad <- subset(NEI, fips == '24510' & type == 'ON-ROAD') 
Cali.onroad <- subset(NEI, fips == '06037' & type == 'ON-ROAD') 

# Aggregate 
Baltimore.DF <- aggregate(Baltimore.onroad[, 'Emissions'], by=list(Baltimore.onroad$year), sum) 
colnames(Baltimore.DF) <- c('year', 'Emissions') 
Baltimore.DF$City <- paste(rep('MD', 4)) 

Cali.DF <- aggregate(Cali.onroad[, 'Emissions'], by=list(Cali.onroad$year), sum) 
colnames(Cali.DF) <- c('year', 'Emissions') 
Cali.DF$City <- paste(rep('CA', 4)) 

plot_data <- as.data.frame(rbind(Baltimore.DF, Cali.DF)) 

# Plot 6
png('plot6.png') 
ggplot(data=plot_data, aes(x=year, y=Emissions)) + geom_bar(aes(fill=year)) + guides(fill=F) +  
  ggtitle('Total Emissions of Motor Vehicle Sources\nLos Angeles County, CA vs. Baltimore City, MD') +  
  ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position='none') + facet_grid(. ~ City) +  
  geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=-1)) 
dev.off() 