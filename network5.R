# Network Layouts
# Network layouts are simply algorithms that return coordinates for each node in a network.

net.bg <- barabasi.game(80) 
V(net.bg)$frame.color <- "white"
V(net.bg)$color <- "orange"
V(net.bg)$label <- "" 
V(net.bg)$size <- 10
E(net.bg)$arrow.mode <- 0
plot(net.bg)

# calc vertices
l <- layout.circle(net.bg)
plot(net.bg, layout=l)

l <- matrix(c(1:vcount(net.bg), c(1, vcount(net.bg):2)), vcount(net.bg), 2)
plot(net.bg, layout=l)

# randomly place vertices
# Randomly placed vertices
l <- layout.random(net.bg)
plot(net.bg, layout=l)

# Circle layout
l <- layout.circle(net.bg)
plot(net.bg, layout=l)

# 3D sphere layout
l <- layout.sphere(net.bg)
plot(net.bg, layout=l)

# Force-directed layouts try to get a nice-looking graph where edges are similar in length and cross each other as little as possible. They simulate the graph as a physical system.

l <- layout.fruchterman.reingold(net.bg, repulserad=vcount(net.bg)^3,                               area=vcount(net.bg)^2.4)
par(mfrow=c(1,2),  mar=c(0,0,0,0)) # plot two figures - 1 row, 2 columns
plot(net.bg, layout=layout.fruchterman.reingold)
plot(net.bg, layout=l)

dev.off() # shut off the  graphic device to clear the two-figure configuration.

l <- layout.kamada.kawai(net.bg)
plot(net.bg, layout=l)

l <- layout.spring(net.bg, mass=.5)
plot(net.bg, layout=l)

plot(net.bg, layout=layout.lgl)

l <- layout.fruchterman.reingold(net.bg)
l <- layout.norm(l, ymin=-1, ymax=1, xmin=-1, xmax=1)

# not working
par(mfrow=c(2,2), mar=c(0,0,0,0))
plot(net.bg, rescale=F, layout=l*0.4)
plot(net.bg, rescale=F, layout=l*0.6)
plot(net.bg, rescale=F, layout=l*0.8)
plot(net.bg, rescale=F, layout=l*1.0)

#
plot(net.bg, layout=layout.lgl)

#
l <- layout.fruchterman.reingold(net.bg)
l <- layout.norm(l, ymin=-1, ymax=1, xmin=-1, xmax=1)

par(mfrow=c(2,2), mar=c(0,0,0,0))
plot(net.bg, rescale=F, layout=l*0.4)
plot(net.bg, rescale=F, layout=l*0.6)
plot(net.bg, rescale=F, layout=l*0.8)
plot(net.bg, rescale=F, layout=l*1.0)

dev.off()
#

layouts <- grep("^layout\\.", ls("package:igraph"), value=TRUE) 
# Remove layouts that do not apply to our graph.
layouts <- layouts[!grepl("bipartite|merge|norm|sugiyama", layouts)]

par(mfrow=c(3,3))

for (layout in layouts) {
  print(layout)
  l <- do.call(layout, list(net)) 
  plot(net, edge.arrow.mode=0, layout=l, main=layout) }

dev.off()

#highlights aspects of wt
hist(links$weight)
mean(links$weight)
sd(links$weight)


cut.off <- mean(links$weight) 
net.sp <- delete.edges(net, E(net)[weight<cut.off])
l <- layout.fruchterman.reingold(net.sp, repulserad=vcount(net)^2.1)
plot(net.sp, layout=l) 

E(net)$width <- 1.5
plot(net, edge.color=c("dark red", "slategrey")[(E(net)$type=="hyperlink")+1],
     vertex.color="gray40", layout=layout.circle)

net.m <- net - E(net)[E(net)$type=="hyperlink"] # another way to delete edges
net.h <- net - E(net)[E(net)$type=="mention"]

dev.off()

par(mfrow=c(1,2))
plot(net.h, vertex.color="orange", main="Tie: Hyperlink")
plot(net.m, vertex.color="lightsteelblue2", main="Tie: Mention")

l <- layout.fruchterman.reingold(net)
plot(net.h, vertex.color="orange", layout=l, main="Tie: Hyperlink")
plot(net.m, vertex.color="lightsteelblue2", layout=l, main="Tie: Mention")
