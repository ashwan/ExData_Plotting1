laBmoreVehicleEmissions <- function () {
  # Read in data
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  # Get a list of all vehicle-related SCCs
  vehicleSCC <- as.character(SCC[grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE),1])
  
  # Subset the emissions data to get only the vehicle-related ones from Baltimore and LA
  laBmoreData <- NEI[(NEI$SCC %in% vehicleSCC) & ((NEI$fips=="24510") | (NEI$fips=="06037")),]

  # Add a City column for the data
  laBmoreData[laBmoreData$fips=="24510",]$City <- "Baltimore City"
  laBmoreData[laBmoreData$fips=="06037",]$City <- "Los Angeles"
  
  # Sum emissions by year and city
  sumByYear <- aggregate(laBmoreData$Emissions, list(year = laBmoreData$year, City = laBmoreData$City), sum)
  
  # Rename the column for the sum so we don't get confused when plotting :)
  colnames(sumByYear)[3] <- "Emissions"
  
  # Barplot of total vehicle-related emissions by year, grouped by city
  # Emissions is divided by 1000 to have a clean y-axis
  ggplot(data=sumByYear, aes(x=factor(year), y=Emissions / 1000, fill=factor(year))) + 
    geom_bar(stat="identity", width=0.75) +
    facet_grid(~City) +
    labs(x = "Years") + 
    labs(y = expression(PM[2.5]*" (thousand tons)")) + 
    labs(title = "PM2.5 Vehicle emissions") +
    guides(fill=FALSE)
  ggsave("project2_plot6.png", dpi=96)
}