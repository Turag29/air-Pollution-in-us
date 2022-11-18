## How have emissions from motor vehicle sources changed from 1999–2008 in 
## Baltimore City?

## loading libraries
library(tidyverse)


## Reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Filtering towards all motor Vehicle sources from SCC
temp<- str_detect(SCC$SCC.Level.Two, "Vehicles|vehicles|Motor|motor")
SCCmotor<-filter(SCC, temp) %>% select(SCC)

## Filter NEI to motor SCC code and Baltimore (fips=="24510")and group by year and form sum
NEImotor <- NEI %>% filter(SCC %in% SCCmotor$SCC & fips =="24510") %>% group_by(year) %>%  summarize(Emi=sum(Emissions))

ggplot(NEImotor) +
      geom_col(mapping=aes(x=year, y=Emi))+
      labs(x = "year", y ="sum of PM 2.5 emissions in tons")+
      labs(title="PM 2.5 Emissions in motor vehicles in Baltimore")+
      scale_x_continuous(breaks = c(1999, 2002, 2005, 2008))

ggsave("plot5.png", scale = 1.5)

## PM 2.5 emissions were decressing and nearly quartered in 9 years from 1999 to 2008