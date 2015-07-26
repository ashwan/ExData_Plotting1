bmoreEmissionsPerYear <- function () {
  # Read in data
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  # Subset to only Baltimore data
  bmoreData <- NEI[NEI$fips==24510,]
  
  # Set PNG output file
  png(filename = "project2_plot2.png")
  
  # Sum all emissions by year (this returns a vector of the sums with the years as names)
  totalEmissions <- tapply(bmoreData$Emissions, bmoreData$year, sum, simplify = TRUE)
  
  barplot(totalEmissions, 
          xlab = "Years",
          ylab = "PM2.5 Emissions (tons)",
          main = "Total PM2.5 Emissions from Baltimore City sources")
  dev.off()
}