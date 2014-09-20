## Steve Anderson
## Data Science Specialization
## Exploratory Data Analysis Course
## September 21, 2014
## This R script reads course datasets and creates plots to answer the six project questions. 

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

# 1.Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all 
# sources for each of the years 1999, 2002, 2005, and 2008.

# Subset or filter dataset down to only include emissions from years 1999, 2002, 2005, and 2008.
# But there should not be needed but subset it just in case
sub_data <- subset(NEI, subset=(year == "1999" | year == "2002" | year == "2005" | year == "2008"))

# Aggregate the data that will be plotted
sum_plot_data <- aggregate(sub_data[c("Emissions")], list(year = sub_data$year), sum) 

# Create Plot 1
png(filename='plot1.png')
plot(sum_plot_data$year,sum_plot_data$Emissions, type="l", main="Total Emissions from PM2.5 in the US", ylab="Emissions (PM2.5)", xlab="Year")
dev.off()

# Answer: Yes. total emissions from PM2.5 has decreased in the United States from 1999 to 2008.

