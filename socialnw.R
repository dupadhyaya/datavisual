# social network data http://www.ats.ucla.edu/stat/r/faq/snplot.htm
# manage and plot social network data
x <- read.table("http://www.ats.ucla.edu/stat/data/mat25.txt", header = FALSE)
head(x)

network <- as.matrix(x)
g1 <- graph.adjacency(network)
# compute betweenness
(b1 <- betweenness(g1, directed = FALSE))

# compute closeness
(c1 <- closeness(g1, mode = "out"))

# compute degree
(d1 <- degree(g1, mode = "out"))

#
xlist <- read.graph("http://www.ats.ucla.edu/stat/data/elist1.txt", format = "edgelist")
str(xlist)

#

xlist.8un <- read.graph("http://www.ats.ucla.edu/stat/data/elist1.txt", format = "edgelist",
                        n = 8, directed = FALSE)
plot.igraph(xlist)

g2 <- graph(c(1, 2, 2, 3, 2, 4, 2, 5, 4, 6, 5, 7, 7, 5))
str(g2)
plot.igraph(g2)
