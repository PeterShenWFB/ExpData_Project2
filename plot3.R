# plot3.R
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

# Get subset of Baltimore
baltimore <- subset(NEI, NEI$fips == "24510")
# Get sums of all years for Baltimore with type
bcTotals <- aggregate(Emissions ~ year + type, baltimore, sum)

# ensure ggplot2 library is loaded
library(ggplot2)

# ggplot
gbc <- ggplot(bcTotals, aes(year, Emissions, color = type))
gbc <- gbc + geom_line() +
        xlab("year") +
        ylab(expression('Total PM'[2.5]*" Emissions")) +
        ggtitle('Total Emissions in Baltimore City, Maryland from 1999 to 2008')
print(gbc)

# copy to png
dev.copy(png, file="plot#3.png", height=480, width=480)
dev.off()
