## Of the four types of sources indicated by the type variable, which of these 
## four sources have seen decreases in emissions from 1999–2008 for Baltimore 
## City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 
## plotting system to make a plot answer this question.

## loading libraries
library(tidyverse)


## Reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##summarise data
PM25type <- NEI %>% filter(fips=="24510") %>% group_by(year, type, .add = T) %>% summarise(Emi=sum(Emissions))

## plot and save as png
ggplot(PM25type) +
      geom_col(mapping=aes(x=year, y=Emi))+
      facet_wrap(vars(type))+
      labs(x = "year", y ="sum of PM 2.5 emissions in tons")+
      labs(title="PM 2.5 Emissions in Baltimore by source type")+
      scale_x_continuous(breaks = c(1999, 2002, 2005, 2008))


ggsave("plot3.png", scale = 2)

## Answer type point increases while all other types decrease