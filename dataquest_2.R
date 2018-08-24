library(tm)
library(ggplot2)
# load data 
data <- read.csv("sample-data.csv")

#remove html tags
data$name <- gsub("<[^>]+>", "", data$name)
data$introduction <- gsub("<[^>]+>", "", data$introduction)
data$itinerary <- gsub("<[^>]+>", "", data$itinerary )
data$destination_location <- gsub("<[^>]+>", "", data$destination_location)

data$name <- gsub("[^\x20-\x7E]", "", data$name)
data$introduction <- gsub("[^\x20-\x7E]", "", data$introduction)
data$itinerary <- gsub("[^\x20-\x7E]", "", data$itinerary )
data$destination_location <- gsub("[^\x20-\x7E]", "", data$destination_location)

#get data and remove  location table
data1 <- subset(data , select = -destination_location)

#get all location and remove duplicated
location <- data$destination_location
location <- location[!duplicated(location)]

# change data to corpus
docs <- Corpus(VectorSource(data1))
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs <- tm_map(docs, toSpace, "/")
docs <- tm_map(docs, toSpace, "@")
docs <- tm_map(docs, toSpace, "\\|")
# Convert the text to lower case
docs <- tm_map(docs, content_transformer(tolower))
# Remove numbers
docs <- tm_map(docs, removeNumbers)
# Remove english common stopwords
docs <- tm_map(docs, removeWords, stopwords("english"))
# Remove your own stop word
# specify your stopwords as a character vector
docs <- tm_map(docs, removeWords, c("blabla1", "blabla2")) 
# Remove punctuations
docs <- tm_map(docs, removePunctuation)
# Eliminate extra white spaces
docs <- tm_map(docs, stripWhitespace)

# change data to termdocment
dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)

# find freq terms 
data3 <- findFreqTerms(dtm, lowfreq = 10)
#find assocs by freq terms
data4 <- findAssocs(dtm, data3, corlimit = 0.95)

data4$ayutthaya
