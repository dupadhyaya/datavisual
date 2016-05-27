#network  Not working Properly
#http://kateto.net/network-visualization
# Install Packages
install.packages(c("igraph","network","sna","ndtv"))

# data set
nodes <- read.csv("Dataset1-Media-Example-NODES.csv", header=T, as.is=T)
links <- read.csv("Dataset1-Media-Example-EDGES.csv", header=T, as.is=T)

head(nodes)
head(links)
nrow(nodes); length(unique(nodes$id))
nrow(links); nrow(unique(links[,c("from", "to")]))

links <- aggregate(links[,3], links[,-3], sum)
links <- links[order(links$from, links$to),]
colnames(links)[4] <- "weight"
rownames(links) <- NULL


#DATASET 2: matrix

nodes2 <- read.csv("Dataset2-Media-User-Example-NODES.csv", header=T, as.is=T)
links2 <- read.csv("Dataset2-Media-User-Example-EDGES.csv", header=T, row.names=1)
#Examine the data:

head(nodes2)
head(links2)
# We can see that links2 is an adjacency matrix for a two-mode network:

links2 <- as.matrix(links2)
dim(links2)
dim(nodes2)

#Network visualization: first steps with igraph
library(igraph)

net <- graph.data.frame(links, nodes, directed=T)
net


# Colors 
plot(x=1:10, y=rep(5,10), pch=19, cex=3, col="dark red")
points(x=1:10, y=rep(6, 10), pch=19, cex=3, col="557799")
points(x=1:10, y=rep(4, 10), pch=19, cex=3, col=rgb(.25, .5, .3))

