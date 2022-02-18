
install.packages(c('stringr', 'hash', 'tau', 'Sejong', 'RSQLite', 'devtools'), type = "binary")
install.packages("remotes")
remotes::install_github('haven-jeon/KoNLP', upgrade = "never", INSTALL_opts=c("--no-multiarch"))

install.packages("rJava")
Sys.setenv(JAVA_HOME="C:/Program Files/Java/jre1.8.0_271/")
library(KoNLP)

useNIADic()

extractNoun('인하대학교 공학대학원 블록체인 전공입니다.')

#1
txt <- readLines(file("hiphop.txt", encoding = "UTF-8"))

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
pal <- brewer.pal(8,"Blues")
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

########################################################
#twitter <- read.csv("twitter2.csv")
#txt <- readLines(file("hiphop.txt", encoding = "UTF-8"))
twitter <- read.csv("twitter.csv",header = T, encoding = "UTF-8")

twitter <- rename(twitter,
                  no = 번호,
                  id = 계정이름,
                  date = 작성일,
                  tw = 내용)

head(twitter$tw)

twitter$tw <- str_replace(twitter$tw, "\\W", " ")

head(twitter$tw)

nouns <- extractNoun(twitter$tw)
nouns

wordcount <- table(unlist(nouns))
wordcount

df_word <- as.data.frame(wordcount, stringsAsFactors = F)

df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq)


df_word <- filter(df_word, nchar(word) >= 2)

top20 <- df_word %>%
  arrange(desc(freq)) %>%
  head(20)

top20

library(ggplot2)

order <- arrange(top20, freq)$word 

ggplot(data = top20, aes(x = word, y = freq)) +
  ylim(0, 2500) +
  geom_col() +
  coord_flip() +
  scale_x_discrete(limit = order) + # 빈도 순서 변수 기
  wordcloud(words = df_word$word, # 단어
            freq = df_word$freq, # 빈도
            min.freq = 10, # 최소 단어 빈도
            max.words = 200, # 표현 단어 수
            random.order = F, # 고빈도 단어 중앙 배치
            rot.per = .1, # 회전 단어 비율
            scale = c(6, 0.3), # 단어 크기 범위
            colors = pal) # 색상 목록

wordcloud(words = df_word$word, # 단어
          freq = df_word$freq, # 빈도
          min.freq = 10, # 최소 단어 빈도
          max.words = 200, # 표현 단어 수
          random.order = F, # 고빈도 단어 중앙 배치
          rot.per = .1, # 회전 단어 비율
          scale = c(6, 0.3), # 단어 크기 범위
          colors = pal) # 색상 목록




#############################################

kakao <- readLines(file("kakaoTalk.txt", encoding = "UTF-8"))
kakao <- kakao[0:3]

kakao<- str_replace_all(kakao,"이모티콘","")%>%
  str_replace_all('"',"")%>%
  str_replace_all("\\오후"," ")%>%
  str_replace_all("\\오전"," ")%>%
  str_replace_all("[ㄱ-ㅎ]+","")%>%
  str_replace_all("\\[0-9]+:[0-9]+\\]","")%>%
  str_replace_all("\\[|\\]","")%>%
  str_replace_all("[0-9]+","")%>%
  str_replace_all("년|월|일","")%>%
  str_replace_all("[가-힣]요","")%>%
  str_replace_all('사진',"")%>%
  str_replace_all('동영상',"")%>%
  str_replace_all('보이스톡',"")%>%
  str_replace_all('페이스톡',"")%>%
  str_replace_all('샵검색',"")%>%
  str_replace_all(':',"")

head(kakao)
nouns <- extractNoun(kakao)
wordcount <- table(unlist(nouns))

df_word <- as.data.frame(wordcount, stringsAsFactors = F)

df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq)

pal <- brewer.pal(8, "Dark2")

set.seed(1234)

wordcloud(words=df_word$word,
          freq = df_word$freq,
          min.freq = 2,
          max.words = 300,
          random.order = F,
          rot.per = .1,
          scale = c(4, 1),
          colors = pal)

##############연습
