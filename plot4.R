# plot4.R
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

# get subset of 'coal' from SCC
coals <- SCC[grepl("Coal" , SCC$Short.Name), ]
# get 'coal' related emmissions
coalSub <- NEI[NEI$SCC %in% coals$SCC, ]

# ensure ggplot2 library is loaded
library(ggplot2)

# ggplot
gbc <- ggplot(coalSub, aes(x = factor(year), y = Emissions)) + geom_bar(stat= "identity", width = .4) + 
        xlab("year") +ylab("Coal-Related PM2.5 Emissions") + ggtitle("Total Coal-Related PM2.5 Emissions")
print(gbc)

# copy to png
dev.copy(png, file="plot#4.png", height=480, width=480)
dev.off()
