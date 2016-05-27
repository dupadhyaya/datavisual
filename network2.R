#network 2 did not work
#https://plot.ly/r/network-graphs/

library(igraph)
library(plotly)

G <- read.graph("karate.gml", format = c("gml"))
L <- layout.circle(G)

#vertices and edges for the graph
vs <- V(G)
es <- as.data.frame(get.edgelist(G))

#count of vertices and edges
Nv <- length(vs)
Ne <- length(es[1]$V1)

#  node positions
Xn <- L[,1]
Yn <- L[,2]

#  draw network nodes
network <- plot_ly(type = "scatter", x = Xn, y = Yn, mode = "markers", text = vs$label, hoverinfo = "text")

#  creates shapes for edges
edge_shapes <- list()

for(i in 1:Ne) {
  v0 <- es[i,]$V1
  v1 <- es[i,]$V2
  
  edge_shape = list(
    type = "line",
    line = list(color = "#030303", width = 0.3),
    x0 = Xn[v0],
    y0 = Yn[v0],
    x1 = Xn[v1],
    y1 = Yn[v1]
  )
  
  edge_shapes[[i]] <- edge_shape
}

#  add edges to the network
network <- layout(
  network,
  title = 'Karate Network',
  shapes = edge_shapes,
  xaxis = list(title = "", showgrid = FALSE, showticklabels = FALSE, zeroline = FALSE),
  yaxis = list(title = "", showgrid = FALSE, showticklabels = FALSE, zeroline = FALSE)
)

network
