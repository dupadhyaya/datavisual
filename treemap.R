# tree map
# http://www.inside-r.org/node/193882
# https://flowingdata.com/2010/02/11/an-easy-way-to-make-a-treemap/
  
# If your data is a hierarchy, a treemap is a good way to show all the values at once and 
# keep the structure in the visual.


#install.packages("portfolio")
library(portfolio)

data <- read.csv("http://datasets.flowingdata.com/post-data.txt")
data
map.market(id=data$id, area=data$views, group=data$category, color=data$comments, main="FlowingData Map")

# http://www.r-bloggers.com/creating-olympic-medal-treemap-visualisations-using-ots-r-libraries/


# http://www.r-bloggers.com/stacking-the-deck-against-treemaps/


#  http://www.r-bloggers.com/fumblings-with-ranked-likert-scale-data-in-r/

# http://stackoverflow.com/questions/37259483/plotting-a-tree-map-in-r-using-treemapify
install.packages('treemapify')   # NA for R3.3
library(treemapify)
# Create Random Data
country <- c("Ireland","England","France","Germany","USA","Spain")
job <- c("IT","SOCIAL","Project Manager","Director","Vice-President")

mydf <- data.frame(countries = sample(country,100,replace = TRUE),
                   career = sample(job,100,replace=TRUE),
                   participent = sample(1:100, replace = TRUE)
)

# Set Up the coords
treemap_coords <- treemapify(mydf, 
                             area="participent", 
                             fill="countries", 
                             label="career", 
                             group="countries")

# Plot the results using the Green Pallete
ggplotify(treemap_coords, 
          group.label.size.factor = 2,
          group.label.colour = "white",
          label.colour = "black",
          label.size.factor = 1) + 
  labs(title="Work Breakdown") +
  scale_colour_brewer(palette = "Greens")
