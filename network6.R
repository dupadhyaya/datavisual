# Load package
library(igraph)

# Make up data
relations <- data.frame(from=c("Bob", "Cecil", "Cecil", "David", "David", "Esmeralda"),
                        to=c("Alice", "Bob", "Alice", "Alice", "Bob", "Alice"),
                        weight=c(4,5,5,2,1,1))
# Alternatively, you could read in the data from a similar CSV file as follows:
# relations <- read.csv("relations.csv")

# Load (DIRECTED) graph from data frame 
g <- graph.data.frame(relations, directed=TRUE)

# Plot graph
plot(g, edge.width=E(g)$weight)
