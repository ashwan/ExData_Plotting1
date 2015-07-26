coalEmissions <- function () {
  # Read in data
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")

  # Get a list of all coal combustion-related SCCs  
  coalSCC <- as.character(SCC[grepl("Coal", SCC$EI.Sector),1])
  
  # Subset the emissions data to get only the coal-related ones
  coalData <- NEI[NEI$SCC %in% coalSCC,]

  # Sum emissions by year
  sumByYear <- aggregate(coalData$Emissions, list(year = coalData$year), sum)
  
  # Rename the column for the sum so we don't get confused when plotting :)
  colnames(sumByYear)[2] <- "Emissions"
  
  # Barplot of total coal-related emissions by year.
  # Emissions is divided by 1000 to have a clean y-axis
  ggplot(data=sumByYear, aes(x=factor(year), y=Emissions/1000)) + 
    geom_bar(stat="identity", fill="steelblue", width=0.5) + 
    labs(x = "Years") + 
    labs(y = expression(PM[2.5]*" (thousand tons)")) + 
    labs(title = "PM2.5 Emissions from coal combustion in the US")
  ggsave("project2_plot4.png", dpi=96)
}