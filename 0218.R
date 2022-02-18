
############ 0218 tis시험
###라이브러리 등록####
Sys.setenv(JAVA_HOME="C:/Program Files/Java/jre1.8.0_271/")
library(KoNLP)
library(writexl)
library(stringr)
library(dplyr)
library(wordcloud)
library(RColorBrewer)

txt <- readLines(file("president.txt", encoding = "UTF-8"))
txt <- str_replace(txt,"\\w","")
nouns <- extractNoun(txt)
nouns 

wordcount <- table(unlist(nouns))
wordcount

df_word <- as.data.frame(wordcount, stringsAsFactors = F)
head(df_word)

df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq
)

head(df_word)


df_word <- filter(df_word,nchar(word) >=2)
df_word

top20 <- df_word %>% arrange(desc(freq)) %>% head(20)
top20  
pal <- brewer.pal(11,"Spectral")
set.seed(1234)



wordcloud(words = df_word$word, freq = df_word$freq,min.freq = 2, 
          max.words = 200,random.order = F, rot.per = .1, 
          scale = c(6, 1.8),colors = pal)


##csv파일 저장
write.csv(top20,file="top20.csv")
