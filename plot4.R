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

# 4. Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

# Create Dataset 
# Coal combustion related sources 
SCC.coal = SCC[grepl("coal", SCC$Short.Name, ignore.case=TRUE),] 
merge <- merge(x=NEI, y=SCC.coal, by='SCC') 
merge.sum <- aggregate(merge[, 'Emissions'], by=list(merge$year), sum) 
colnames(merge.sum) <- c('Year', 'Emissions') 

# Create Plot 4
png('plot4.png') 
ggplot(data=merge.sum, aes(x=Year, y=Emissions/1000)) +  
  geom_line(aes(group=1, col=Emissions)) + geom_point(aes(size=2, col=Emissions)) +  
  ggtitle(expression('Total  Coal Combustion Emissions of PM'[2.5])) +  
  ylab(expression(paste('PM', ''[2.5], ' in kilotons'))) +  
  geom_text(aes(label=round(Emissions/1000,digits=2), size=2, hjust=1.5, vjust=1.5)) +  
  theme(legend.position='none') + scale_colour_gradient(low='red', high='blue')  
dev.off()

# Answer: Coal Combustion Emission has decreased from 1999 - 2008.