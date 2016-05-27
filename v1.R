#install.packages("plotrix")

library(plotrix)

# Input the data labels and dates for your Gantt Chart
Ymd.format<-"%Y/%m/%d"

gantt.info<-list(labels=c("Contract Preparation","Rapid Literature Review","CITI Training","IRB Addendum & Inclusion","Data Download","Data Analysis","Data Products"),
starts=as.POSIXct(strptime(c("2014/06/01","2014/06/04","2014/06/07","2014/06/19","2014/06/29","2014/07/01","2014/07/23"),
format=Ymd.format)),
ends=as.POSIXct(strptime(c("2014/06/16","2014/06/19","2014/06/17","2014/06/29","2014/07/02","2014/07/22","2014/08/05"),
format=Ymd.format)),
priorities=c(1,4,3,2,3,2,1))

#Assign values for the set up of your Gantt Chart
months <- seq(as.Date("2014/06/01", "%Y/%m/%d"), by="month", length.out=8)
monthslab <- format(months, format="%b")

vgridpos<-as.POSIXct(months,format=Ymd.format)
vgridlab<-monthslab

colfunc <- colorRampPalette(c("red", "darkgoldenrod1"))

timeframe <- as.POSIXct(c("2014/06/01","2014/09/01"),format=Ymd.format)
# plot and save as pdf
colfunc <- colorRampPalette(c("red", "darkgoldenrod1"))
timeframe <- as.POSIXct(c("2014/06/01","2014/09/01"),format=Ymd.format)
gantt.chart(gantt.info, taskcolors=colfunc(4),xlim=timeframe, main="Gantt Chart for Fieldwork 2014",
priority.legend=TRUE,vgridpos=vgridpos,vgridlab=vgridlab,hgrid=TRUE)

# save
dev.copy(pdf, width = 8, height = 6, paper = "special")
dev.off()