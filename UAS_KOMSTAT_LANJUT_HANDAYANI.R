#Input Library dan Dataset
library(wordcloud)

library(tm)

library(textclean)
library(tidytext)
winemag_data <- read_csv("D:/Hani/winemag_data.csv", sep=";", stringsAsFactors=TRUE)
head(winemag_data)

#Mengubah Data Frame Menjadi Data Vektor
rev<- winemag_data$description
head (rev)

##Text Cleaning
#Mengubah Kapital Menjadi Huruf Kecil
rev <- tolower(rev)
head(rev)

#Mengembalikan Kata yang disingkat Menjadi Kata Aslinya
rev <- replace_contraction(rev)
head(rev)

#Menghapus Huruf yang Bukan Kata
rev <- strip(rev)
head(rev)

#Menghapus Beberapa Kata
rev <-removeWords(rev, c("the","our","you","and","was","this","with","not","too","but","for",
                         "its","who","has","what","yet","your","out","else","more",
                         "own","are","abaut","just","because","all","etc","works","these","did","say","use","end","she","lot","can","not","for","saw","also","have","that","after",","))
head(rev)

##Membuat Word Cloud
#Mengubah Data Frame Menjadi Data Faktor
tdm <- TermDocumentMatrix(rev)
m <- as.matrix(tdm)
v <- sort(rowSums(m),decreasing = TRUE)
#Mengubah Data Faktor Menjadi Data Frame
d <- data.frame(word = names(v), freq = v)

wordcloud(d$word, d$freq,
          random.order = FALSE,
          max.words = 500,
          colors = brewer.pal(name = "Dark2",8 ))

library(caret)
library(RtextTools)
glimpse(d)
dokumen <- VCorpus(VectorSource())