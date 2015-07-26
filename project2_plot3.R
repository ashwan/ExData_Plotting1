bmoreEmissionsbyType <- function () {
  # Read in data
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  # Subset to only Baltimore data
  bmoreData <- NEI[NEI$fips==24510,]
  
  library(ggplot2)
  
  sumByType <- aggregate(bmoreData$Emissions, list(type=bmoreData$type, year=bmoreData$year), sum)
  colnames(sumByType)[3] = "Emissions"
  sumByType$year <- as.factor(sumByType$year)
  
  ggplot(data=sumByType, aes(x = year, y = Emissions, fill=type)) +
    facet_wrap(~type) +
    geom_bar(stat="identity") +
    labs(x = "Years") + 
    labs(y = expression(PM[2.5] * " (tons)")) +
    labs(title= "Emissions in Baltimore City")
  ggsave("project2_plot3.png")
}