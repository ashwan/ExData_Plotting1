bmoreVehicleEmissions <- function () {
  # Read in data
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")

  # Get a list of all vehicle-related SCCs
  vehicleSCC <- as.character(SCC[grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE),1])
  
  # Subset the emissions data to get only the vehicle-related ones from Baltimore
  bmoreData <- NEI[(NEI$SCC %in% vehicleSCC) & (NEI$fips==24510),]

  # Sum emissions by year
  sumByYear <- aggregate(bmoreData$Emissions, list(year = bmoreData$year), sum)
  
  # Rename the column for the sum so we don't get confused when plotting :)
  colnames(sumByYear)[2] <- "Emissions"
  
  # Barplot of total coal-related emissions by year.
  # Emissions is divided by 1000 to have a clean y-axis
  ggplot(data=sumByYear, aes(x=factor(year), y=Emissions)) + 
    geom_bar(stat="identity", fill="steelblue", width=0.5) + 
    labs(x = "Years") + 
    labs(y = expression(PM[2.5]*" (tons)")) + 
    labs(title = "PM2.5 Vehicle emissions in Baltimore City")
  ggsave("project2_plot5.png", dpi=96)
}