# Likert Scale
# http://www.r-bloggers.com/plotting-likert-scales/

#1
set.seed(1234)
library(e1071)
probs <- cbind(c(.4,.2/3,.2/3,.2/3,.4),c(.1/4,.1/4,.9,.1/4,.1/4),c(.2,.2,.2,.2,.2))
my.n <- 100
my.len <- ncol(probs)*my.n
raw <- matrix(NA,nrow=my.len,ncol=2)
raw <- NULL
for(i in 1:ncol(probs)){
  raw <- rbind(raw, cbind(i,rdiscrete(my.n,probs=probs[,i],values=1:5)))
}

r <- data.frame( cbind(
  as.numeric( row.names( tapply(raw[,2], raw[,1], mean) ) ),
  tapply(raw[,2], raw[,1], mean),
  tapply(raw[,2], raw[,1], mean) + sqrt( tapply(raw[,2], raw[,1], var)/tapply(raw[,2], raw[,1], length) ) * qnorm(1-.05/2,0,1),
  tapply(raw[,2], raw[,1], mean) - sqrt( tapply(raw[,2], raw[,1], var)/tapply(raw[,2], raw[,1], length) ) * qnorm(1-.05/2,0,1)
))
names(r) <- c("group","mean","ll","ul")

gbar <- tapply(raw[,2], list(raw[,2], raw[,1]), length)

sgbar <- data.frame( cbind(c(1:max(unique(raw[,1]))),t(gbar)) )

sgbar.likert<- sgbar[,2:6]


#2  Diverging Stacked Bar Chart
require(grid)
require(lattice)
require(latticeExtra)
require(HH)
sgbar.likert<- sgbar[,2:6]
likert(sgbar.likert,
       main='Example Diverging Stacked Bar Chart for Likert Scale',
       sub="Likert Scale")

likert(sgbar.likert, horizontal=FALSE,
       aspect=1.5,
       main="Example Diverging Stacked Bar Chart for Likert Scale",
       auto.key=list(space="right", columns=1,
                     reverse=TRUE, padding.text=2),
       sub="Likert Scale")

likert(sgbar.likert,
       auto.key=list(between=1, between.columns=2),
       xlab="Percentage",
       main="Example Diverging Stacked Bar Chart for Likert Scale",
       BrewerPaletteName="Blues",
       sub="Likert Scale")

# 3

plot.new()
par(mfrow=c(1,1))

plot(r$group,r$mean, type="o", cex=1, col="blue", pch=16,
     ylim=c(1,5), lwd=2, ylab="Mean Value", xlab="Group"
     , main=paste("Likert Scale Mean Values Example")
     , cex.sub=.60
     , xaxt = "n", yaxt = "n");
axis(1, at=(1:3), tcl = -0.7, lty = 1, lwd = 0.8, labels=TRUE)
axis(2, at=(1:5), labels=TRUE, tcl = -0.7, lty = 1)
abline(h=c(1:5), col="grey")
lines(r$group,r$ll, col='red', lwd=2)
lines(r$group,r$ul, col='red', lwd=2)

legend("topright", c("Mean","Confidence Interval"),
       col=c('blue','red'), title="Legend",
       lty=1, lwd=2,
       inset = .05)

# Pie
my.table <- table(raw[,2][raw[,1]==1])

names(my.table) <- c("Strongly Agree","Agree","Neutral","Disagree","Strongly Disagree")
labl <- paste(names(my.table), "\n", my.table, sep="")
pie(my.table, labels=labl, main="Example Pie Chart of Likert Scale")

#Pie2
plot.new()
num.groups <- length(unique(raw[,1]))
par(mfrow=c(1,num.groups))
for(j in 1:num.groups){
  my.table <- table(raw[,2][raw[,1]==j])
  pie(my.table, labels=labl, main=paste("Example Pie Chart of\nLikert Scale Group ", j))
}

# 3d Pie
library(plotrix)
slices <- my.table
names(my.table) <- c("Strongly Agree","Agree","Neutral","Disagree","Strongly Disagree")
labl <- paste(names(my.table), "\n", my.table, sep="")
pie3D(slices,labels=labl,explode=0.1,
      main="3D Pie Chart Example")

# Grouped Chart

par(mfrow=c(1,1))
barplot(gbar, beside=T, col=cm.colors(5), main="Example Bar Chart of Counts by Group",xlab="Group",ylab="Frequency")

legend("topright", names(my.table),
       col=cm.colors(5), title="Legend",
       lty=1, lwd=15,
       inset = .1)

# Divided Bar Chart
library(ggplot2)
library(reshape2)

names(sgbar) <- c("group","Strongly Agree","Agree","Neutral","Disagree","Strongly Disagree")

mx <- melt(sgbar, id.vars=1)
names(mx) <- c("Group","Category","Percent")

ggplot(mx, aes(x=Group, y=Percent, fill=Category)) +
  geom_bar(stat="identity")
