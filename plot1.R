# plot1.R
#
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources
# for each of the years 1999, 2002, 2005, and 2008.
#
# Both data files have to be pre-downloaded and unzipped.
if (!file.exists("./data/summarySCC_PM25.rds")) {
        stop("Make sure you have summarySCC_PM25.rds downloaded and unzipped under ./data sub directory...")
}
if (!file.exists("./data/Source_Classification_Code.rds")) {
        stop("Make sure you have Source_Classification_code.rds downloaded and unzipped under ./data sub directory...")
}
# Test files before read

if (!exists("NEI")) {
        NEI <- readRDS("summarySCC_PM25.rds")
}
if (!exists("SCC")) {
        SCC <- readRDS("Source_Classification_Code.rds")
}

# Get the sum of PM25 for all years
totalsByYears <- tapply(NEI$Emissions, NEI$year, sum)
plot(names(totalsByYears), totalsByYears, type="b", xlab = "Year", ylab = expression("Total" ~ PM[2.5] ~"Emissions (tons)"),
     main = expression("Total US" ~ PM[2.5] ~ "Emissions by Year"), col="red")

dev.copy(png, file="plot#1.png", height=480, width=480)
dev.off()
