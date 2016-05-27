# http://www.r-bloggers.com/gantt-charts-in-r-using-plotly/
# Gantt Chart

library(plotly)

# Read in data
df <- read.csv("https://cdn.rawgit.com/plotly/datasets/master/GanttChart-updated.csv", stringsAsFactors = F)

# Convert to dates
df$Start <- as.Date(df$Start, format = "%m/%d/%Y")

# Sample client name
client = "Sample Client"

# Choose colors based on number of resources
cols <- RColorBrewer::brewer.pal(length(unique(df$Resource)), name = "Set3")
df$color <- factor(df$Resource, labels = cols)

# Initialize empty plot
p <- plot_ly()

# Each task is a separate trace
# Each trace is essentially a thick line plot
# x-axis ticks are dates and handled automatically

for(i in 1:(nrow(df) - 1)){
  p <- add_trace(p,
                 x = c(df$Start[i], df$Start[i] + df$Duration[i]),  # x0, x1
                 y = c(i, i),  # y0, y1
                 mode = "lines",
                 line = list(color = df$color[i], width = 20),
                 showlegend = F,
                 hoverinfo = "text",
                 
                 # Create custom hover text
                 
                 text = paste("Task: ", df$Task[i], "<br>",
                              "Duration: ", df$Duration[i], "days<br>",
                              "Resource: ", df$Resource[i]),
                 
                 evaluate = T  # needed to avoid lazy loading
  )
}


# Add information to plot and make the chart more presentable

p <- layout(p,
            
            # Axis options:
            # 1. Remove gridlines
            # 2. Customize y-axis tick labels and show task names instead of numbers
            
            xaxis = list(showgrid = F, tickfont = list(color = "#e6e6e6")),
            
            yaxis = list(showgrid = F, tickfont = list(color = "#e6e6e6"),
                         tickmode = "array", tickvals = 1:nrow(df), ticktext = unique(df$Task),
                         domain = c(0, 0.9)),
            
            # Annotations
            
            annotations = list(
              # Add total duration and total resources used
              # x and y coordinates are based on a domain of [0,1] and not
              # actual x-axis and y-axis values
              
              list(xref = "paper", yref = "paper",
                   x = 0.80, y = 0.1,
                   text = paste0("Total Duration: ", sum(df$Duration), " days<br>",
                                 "Total Resources: ", length(unique(df$Resource)), "<br>"),
                   font = list(color = "#ffff66", size = 12),
                   ax = 0, ay = 0,
                   align = "left"),
              
              # Add client name and title on top
              
              list(xref = "paper", yref = "paper",
                   x = 0.1, y = 1, xanchor = "left",
                   text = paste0("Gantt Chart: ", client),
                   font = list(color = "#f2f2f2", size = 20, family = "Times New Roman"),
                   ax = 0, ay = 0,
                   align = "left")
            ),
            
            plot_bgcolor = "#333333",  # Chart area color
            paper_bgcolor = "#333333")  # Axis area color

p
