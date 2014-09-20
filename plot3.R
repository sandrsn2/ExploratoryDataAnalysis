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

# 3.Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
# variable, which of these four sources have seen decreases in emissions from 1999-2008 for 
# Baltimore City? Which have seen increases in emissions from 1999-2008? Use the ggplot2 
# plotting system to make a plot answer this question.

# Subset or filter dataset down to only include emissions from years 1999, 2002, 2005, and 2008.
# But there should not be needed but subset it just in case
sub_data <- subset(NEI, subset=(fips == "24510"))

# Aggregate the data that will be plotted
sum_plot_data <- aggregate(sub_data[c("Emissions")], list(year = sub_data$year), sum) 

# Create Plot 3
png(filename='plot3.png', width=800, height=500, units='px')
ggplot(data = sub_data, aes(x = year, y=log(Emissions))) + facet_grid(. ~ type) + guides(fill = F) + 
  geom_boxplot(aes(fill = type)) + stat_boxplot(geom = 'errorbar') + 
  ylab(expression(paste('Log', ' of PM'[2.5], ' Emissions'))) + xlab('Year') +  
  ggtitle('Emissions per Type in Baltimore City, Maryland') + 
  geom_jitter(alpha = 0.10) 
dev.off()
