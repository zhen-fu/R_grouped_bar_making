### This is the most simple code to plot a grouped bar plots
list.files()
df <- read.csv("farm_sp_richness_example.txt", header = T, sep = "\t")
head(df)
library(plyr)
library(ggplot2)
split_df <-ddply(df, c("Farm_management", "Geographic_location"), 
                 summarise, N=length(species_richness), mean=mean(species_richness), 
                 sd=sd(species_richness),
                  se=sd/sqrt(N))

ggplot(split_df, aes(fill=Farm_management, y=mean, x=Geographic_location)) + 
  geom_bar(position=position_dodge(0.9), stat="identity") +
  geom_errorbar(aes(ymax = split_df$mean + split_df$se,
                    ymin = split_df$mean - split_df$se),
                    width = 0.25,
                    position = position_dodge(0.9)) +
    xlab("Farm Management") +
    ylab("Species richness") +
    scale_fill_manual(name = "Farm_managemen",
                      values = c("goldenrod2", "olivedrab4"))
