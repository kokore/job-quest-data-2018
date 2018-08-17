library(tm)
library(SnowballC)
library(wordcloud)
library(ggplot2)
library(RColorBrewer)

data <- read.csv("sample-data.csv")
data <- data.frame(data)

data.Corpus<-Corpus(VectorSource(data$destination_location))

data.Clean<-tm_map(data.Corpus, PlainTextDocument)
data.Clean<-tm_map(data.Corpus,tolower)
data.Clean<-tm_map(data.Clean,removeNumbers)
data.Clean<-tm_map(data.Clean,removeWords,stopwords("english"))
data.Clean<-tm_map(data.Clean,removePunctuation)
data.Clean<-tm_map(data.Clean,stripWhitespace)
data.Clean<-tm_map(data.Clean,stemDocument)

wordcloud(data.Clean,max.words = 200,random.color = TRUE,random.order=FALSE)