totalEmissionsPerYear <- function () {
  # Read in data
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  # Set PNG output file
  png(filename = "project2_plot1.png")
  
  # Sum all emissions by year (this returns a vector of the sums with the years as names)
  totalEmissions <- tapply(NEI$Emissions, NEI$year, sum, simplify = TRUE)
  
  # Bar plot in millions so the y-axis looks clean
  barplot(totalEmissions / 1000000, 
  			xlab = "Years",
  			ylab = "PM2.5 Emissions (in megatons)",
  			main = "Total PM2.5 Emissions from all US Sources")
  dev.off()
}