## Across the United States, how have emissions from coal combustion-related 
## sources changed from 1999–2008?

## loading libraries
library(tidyverse)


## Reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Filtering towards all coal sources from SCC
temp<- str_detect(SCC$Short.Name, "Coal|coal")
SCCcoal<-filter(SCC, temp) %>% select(SCC)

## Filter NEI to coal SCC code and group by year and form sum
NEICoal <- NEI %>% filter(SCC %in% SCCcoal$SCC) %>% group_by(year) %>%  summarize(Emi=sum(Emissions))

ggplot(NEICoal) +
      geom_col(mapping=aes(x=year, y=Emi))+
      labs(x = "year", y ="sum of PM 2.5 emissions in tons")+
      labs(title="PM 2.5 Emissions in USA by coal sources")+
      scale_x_continuous(breaks = c(1999, 2002, 2005, 2008))

ggsave("plot4.png", scale = 1.5)