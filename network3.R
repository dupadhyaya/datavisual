# Network 3
# http://kateto.net/network-visualization
# Colors in R plots
#  data http://www.kateto.net/polnet2015

plot(x=1:10, y=rep(5,10), pch=19, cex=3, col="dark red")
points(x=1:10, y=rep(6, 10), pch=19, cex=3, col="557799")
points(x=1:10, y=rep(4, 10), pch=19, cex=3, col=rgb(.25, .5, .3))

plot(x=1:5, y=rep(5,5), pch=19, cex=12, col=rgb(.25, .5, .3, alpha=.5), xlim=c(0,6))  

par(bg="gray40")
col.tr <- grDevices::adjustcolor("557799", alpha=0.7)
plot(x=1:5, y=rep(5,5), pch=19, cex=12, col=col.tr, xlim=c(0,6)) 

colors()                          # List all named colors
grep("blue", colors(), value=T)   # Colors that have "blue" in the name

pal1 <- heat.colors(5, alpha=1)   #  5 colors from the heat palette, opaque
pal2 <- rainbow(5, alpha=.5)      #  5 colors from the heat palette, transparent
plot(x=1:10, y=1:10, pch=19, cex=5, col=pal1)

plot(x=1:10, y=1:10, pch=19, cex=5, col=pal2)

palf <- colorRampPalette(c("gray80", "dark red")) 
plot(x=10:1, y=1:10, pch=19, cex=5, col=palf(10)) 

#To add transparency to colorRampPalette, you need to use a parameter alpha=TRUE:
palf <- colorRampPalette(c(rgb(1,1,1, .2),rgb(.8,0,0, .7)), alpha=TRUE)
plot(x=10:1, y=1:10, pch=19, cex=5, col=palf(10)) 

#install.packages("RColorBrewer")
library(RColorBrewer)
display.brewer.all()

display.brewer.pal(8, "Set3")

display.brewer.pal(8, "Spectral")

display.brewer.pal(8, "Blues")

pal3 <- brewer.pal(10, "Set3") 
plot(x=10:1, y=10:1, pch=19, cex=4, col=pal3)

# Fonts
#install.packages("extrafont")
library(extrafont)

# Import system fonts - may take a while, so DO NOT run this during the workshop.
font_import() 
fonts() # See what font families are available to you now.
loadfonts(device = "win") # use device = "pdf" for pdf plot output. 

nodes <- read.csv("Dataset1-Media-Example-NODES.csv", header=T, as.is=T)
links <- read.csv("Dataset1-Media-Example-EDGES.csv", header=T, as.is=T)

library(igraph)
net <- graph.data.frame(links, nodes, directed=T)
net

library(extrafont)
plot(net, vertex.size=30)
plot(net, vertex.size=30, vertex.label.family="Arial Black" )

