
install.packages(c('stringr', 'hash', 'tau', 'Sejong', 'RSQLite', 'devtools'), type = "binary")
install.packages("remotes")
remotes::install_github('haven-jeon/KoNLP', upgrade = "never", INSTALL_opts=c("--no-multiarch"))

install.packages("rJava")
Sys.setenv(JAVA_HOME="C:/Program Files/Java/jre1.8.0_271/")
library(KoNLP)

useNIADic()

extractNoun('인하대학교 공학대학원 블록체인 전공입니다.')

#1
txt <- readLines("hiphop.txt")
head(txt)

#2
install.packages("stringr")
library(stringr)

txt <- str_replace(txt,"\\w"," ")  #특수문자 제거

#3
nouns <- extractNoun(txt)
nouns 

#4
wordcount <- table(unlist(nouns))
wordcount

#5
df_word <- as.data.frame(wordcount, stringsAsFactors = F)
head(df_word)

#6
library(dplyr)
df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq
                  )

head(df_word)



#7
df_word <- filter(df_word,nchar(word) >=2)
df_word

top20 <- df_word %>% arrange(desc(freq)) %>% head(20)
top20  

#1
install.packages("wordcloud")
library(wordcloud)
library(RColorBrewer)

#2
pal <- brewer.pal(8,"Dark2")
set.seed(123)

#3
wordcloud(words = df_word$word, # 단어
          freq = df_word$freq, # 빈도
          min.freq = 2, # 최소 단어 빈도
          max.words = 200, # 표현 단어 수
          random.order = F, # 고빈도 단어 중앙 배치
          rot.per = .1, # 회전 단어 비율
          scale = c(7, 0.3), # 단어 크기 범위
          colors = pal) # 색깔 목

