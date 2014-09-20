## Steve Anderson
## Data Science Specialization
## Exploratory Data Analysis Course
## September 21, 2014
## This R script reads course datasets and creates plots to answer the six project questions. 

## use libraries
## you must alway have library installed
## install.packages("ggplot2")
library(ggplot2) 

# The Code below (1) downloads zip file, (2) unzip its files and (3) reads data of each files
f <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", f) 
unzip(f) 
unzip1 <- unzip(f, list=TRUE)$Name[1]
unzip2 <- unzip(f, list=TRUE)$Name[2]
NEI <- readRDS(unzip2)
close
SCC <- readRDS(unzip1)
close

# 5. How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City? 

# years
NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008')) 

# Baltimore City on road dataset
Baltimore.onroad <- subset(NEI, fips == 24510 & type == 'ON-ROAD') 

# Aggregate
Baltimore.df <- aggregate(Baltimore.onroad[, 'Emissions'], by=list(Baltimore.onroad$year), sum) 
colnames(Baltimore.df) <- c('year', 'Emissions') 

# Plot 5 
png('plot5.png') 
ggplot(data=Baltimore.df, aes(x=year, y=Emissions)) + geom_bar(aes(fill=year)) + guides(fill=F) +  
  ggtitle('Total Emissions in Baltimore City of Motor Vehicle') +  
  ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position='none') +  
  geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=2)) 

dev.off() 

# Answer: Motor Vehicle Emission has decreased from 1999 - 2008.