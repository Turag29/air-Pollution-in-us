## 1 Have total emissions from PM2.5 decreased in the United States from 1999 to 
## 2008? Using the base plotting system, make a plot showing the total PM2.5 
## emission from all sources for each of the years 1999, 2002, 2005, and 2008.

## loading libraries
library(tidyverse)


## Reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##summarise data
PM25year <- NEI %>% group_by(year) %>% summarise(sum(Emissions))

## plot and save as png
barplot(PM25year$`sum(Emissions)` ~ PM25year$year, main ="Emissions of PM 2.5 in tons per year", xlab ="year", ylab ="Emissions of PM 2.5 in tons")
dev.copy(png, file = "plot1.png")
dev.off()
