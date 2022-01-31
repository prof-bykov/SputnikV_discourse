# Prof.Bykov's R - SputnikV discource 

# Check your working directory

getwd()

# If necessary, set your working directory
# setwd("C:/Users/bkv/Documents/SputnikV")

# Read data into a data-frame called sputnik

sputnik <- read.table("SputnikV.txt", header = T) 

# If necessary, view data

View(sputnik)

# If necessary, view data

edit(sputnik)

# Build a simple plot

plot(sputnik$Washington_Post)

# Load ggplot2 library 

library(ggplot2)

# Build a simple plot with ggplot2

ggplot(data = sputnik, aes(x = Period, y = Washington_Post,  group = 1)) + 
  # Specifying group = 1 
  geom_point() +
  geom_line()

# Info for legend

colors <- c("Washington Post" = "black", "Washington Times" = "grey", "Novaya Gazeta" = "orange", "Parlamentskaya Gazeta" = "yellow")
 
# Final edition of simple plot

ggplot(sputnik, aes(x = Period)) +
  geom_line(aes(y = Washington_Post, color = "Washington Post"), size = 2) + 
  geom_line(aes(y = Washington_Times, color = "Washington Times"), size = 2) +
  geom_line(aes(y = Novaya_Gazeta,  color = "Novaya Gazeta"), size = 2) +
  geom_line(aes(y = Parlamentskaya_Gazeta, color = "Parlamentskaya Gazeta"), size = 2) +
  labs(x = "Time", 
       y = "Publications",
       color = "Newspapers") +
  scale_color_manual(values = colors) +
  theme(
    legend.position = c(.95, .95),
    legend.justification = c("right", "top"),
    legend.box.just = "right",
    legend.margin = margin(6, 6, 6, 6)
  )

# Saving plot in printing quality

ggsave("sputnik.jpeg", width = 20, units = "cm")