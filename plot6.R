# plot6.R
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

# Get subset of Baltimore and type is 'ON-ROAD'
baltimore <- subset(NEI, NEI$fips == "24510" & NEI$type == "ON-ROAD")
# Get sums of all years for Baltimore with type and change fips to city name
bcTotals <- aggregate(Emissions ~ year + fips, baltimore, sum)
bcTotals$fips <- "Baltimore"
# Get subset of LA and type is 'ON-ROAD'
LA <- subset(NEI, NEI$fips == "06037" & NEI$type == "ON-ROAD")
# Get sums of all years for Baltimore with type and change fipts to city name
laTotals <- aggregate(Emissions ~ year + fips, LA, sum)
laTotals$fips <- "Los Angeles"

# combine both cities
combined <- rbind(bcTotals, laTotals)

# ensure ggplot2 library is loaded
library(ggplot2)

# ggplot
gbc <- ggplot(combined, aes(year, Emissions, color = fips))
gbc <- gbc + geom_line() + ylim(-100, 5500) +
        xlab("year") +
        ylab(expression('Total PM'[2.5]*" Emissions")) +
        ggtitle('Total Emissions from motor vihecle (type is ON-ROAD)\nBaltimore City, Maryland vs Los Angeles, California\n from 1999 to 2008')
print(gbc)

# copy to png
dev.copy(png, file="plot#6.png", height=480, width=480)
dev.off()
