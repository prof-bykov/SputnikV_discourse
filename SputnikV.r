# Prof.Bykov's R - SputnikV discource 
# Lab goals:
# 1. Simple plot with ggplot2 and lines
# 2. Text mining

# Check your working directory
getwd()

# If necessary, set your working directory
setwd("C:/Users/bkv/Documents/SputnikV")

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

# Textmining 

# If necessary, install packages
install.packages("NLP")
install.packages("tm")
install.packages("SnowballC")
install.packages("RColorBrewer")
install.packages("wordcloud")

# Load package packages in operating memory
library("NLP")
library("tm")
library("SnowballC")
library("RColorBrewer")
library("wordcloud")

# Check if the package has been loaded
search()

# build a corpus, which is a collection of text documents
sputnik_corpus <- Corpus(DirSource("C:/Users/bkv/Documents/SputnikV/sputnik/"))

# VectorSource specifies that the source is character vectors
myCorpus <- Corpus(VectorSource(sputnik_corpus))

# Replacespecial characters from the text with space
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
myCorpus <- tm_map(myCorpus, toSpace, "/")
myCorpus <- tm_map(myCorpus, toSpace, "@")
myCorpus <- tm_map(myCorpus, toSpace, "\\|")

# Clean the text

# Set lower case
myCorpus <- tm_map(myCorpus, tolower)
# Remove english common stopwords
myCorpus <- tm_map(myCorpus, removeWords, stopwords("russian")) 
# for english stopwords("english"))
# Remove punctuations
myCorpus <- tm_map(myCorpus, removePunctuation)
# Eliminate extra white spaces
myCorpus <- tm_map(myCorpus, stripWhitespace)

# Text stemming
myCorpus <- tm_map(myCorpus, stemDocument)

# Build a term-document matrix with function TermDocumentMatrix()
myDtm <- TermDocumentMatrix(myCorpus, control = list(minWordLength = 1))
m <- as.matrix(myDtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 100)

# Generate the Word cloud with 'wordcloud'
set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 5,
          max.words=200, random.order=FALSE, rot.per=0.25, 
          colors=brewer.pal(8, "Dark2"))
