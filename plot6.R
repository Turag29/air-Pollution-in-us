## Compare emissions from motor vehicle sources in Baltimore City with emissions
## from motor vehicle sources in Los Angeles County, California 
## (fips == "06037"). Which city has seen greater changes over time in motor 
## vehicle emissions?

## loading libraries
library(tidyverse)


## Reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Filtering towards all motor Vehicle sources from SCC
temp<- str_detect(SCC$SCC.Level.Two, "Vehicles|vehicles|Motor|motor")
SCCmotor<-filter(SCC, temp) %>% select(SCC)

## Filter NEI to motor SCC code and Baltimore (fips=="24510")and and LA (fips == "06037") group by year, fips and form sum
NEIcounty <- NEI %>% filter(SCC %in% SCCmotor$SCC & (fips =="24510"|fips =="06037")) %>% group_by(year, fips, .add=T) %>%  summarize(Emi=sum(Emissions))
NEIcounty$fips[NEIcounty$fips == "24510"]<- "24510 Baltimore"
NEIcounty$fips[NEIcounty$fips == "06037"]<- "06037 LA county"

ggplot(NEIcounty) +
      geom_col(mapping=aes(x=year, y=Emi))+
      facet_wrap(vars(fips))+
      labs(x = "year", y ="sum of PM 2.5 emissions in tons")+
      labs(title="PM 2.5 Emissions in motor vehicles")+
      scale_x_continuous(breaks = c(1999, 2002, 2005, 2008))

ggsave("plot6.png", scale = 1.5)

## PM 2.5 emissions were decreasing in Baltimore and increased in LA county