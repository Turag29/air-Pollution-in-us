## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
## fips == "24510" from 1999 to 2008? Use the base plotting system to make 
## a plot answering this question.

## loading libraries
library(tidyverse)


## Reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##summarise data
PM25Balt <- NEI %>% filter(fips=="24510") %>% group_by(year) %>% summarise(sum(Emissions))

## plot and save as png
barplot(PM25Balt$`sum(Emissions)` ~ PM25Balt$year, main ="Emissions of PM 2.5 in tons per year in Baltimore", xlab ="year", ylab ="Emissions of PM 2.5 in tons")
dev.copy(png, file = "plot2.png")
dev.off()