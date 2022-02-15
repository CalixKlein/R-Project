exam <- read.csv("csv_exam.csv")
exam
head(exam,10)
tail(exam)
tail(exam,10)
dim(exam)
str(exam)
summary(exam)

mpg

head(mpg)
tail(mpg)
View(mpg)
dim(mpg)
summary(mpg) 
str(mpg)

df_raw <- data.frame(var1 = c(1,2,1),
                     var2 = c(2,3,2)); df_raw
install.packages("dplyr")
library(dplyr)

df_new <- df_raw
rename(df_new,v2=var2)
rename(df_new,v1=var1)
df_new
mpg2 <- mpg

mpg2 <- head(rename(mpg2,ctiy = cty, highway = hwy))
mpg2


df <- data.frame(var1 = c(4,3,8),
                 var2 = c(2,6,1)); df

df$var_sum <- df$var1 + df$var2; df

df$var_mean <- (df$var1 + df$var2)/2; df

mpg

mpg$total <- (mpg$cty + mpg$hwy) /2; mpg
mpg$total

mpg


mean(mpg$total)
summary(mpg$total)
hist(mpg$total)
install.packages("ggplot2") 
library(ggplot2)
mpg$test <- ifelse(mpg$total>=20 ,"pass","fail"); mpg

head(mpg,20)
table(mpg$test)
qplot(mpg$test)
mpg
#dev.off() << Error in .Call.graphics(C_palette2, .Call(C_palette2, NULL)) :invalid graphics state 에러뜰때 실행

mpg$grade <- ifelse(mpg$total >= 30,"A",
                    ifelse(mpg$total>=20,"B","C")); mpg

head(mpg,30)
table(mpg$grade)
qplot(mpg$grade)


#p123 ex1~5
midwest #ex 1


midwest_p123 <- midwest
midwest_p123 <- rename(midwest_p123,total = poptotal,
                       asian = popasian); midwest_p123 #ex2

midwest_p123$total_asian_mean <-(midwest_p123$asian / midwest_p123$total)*100;  #ex3
midwest_p123

mean(midwest_p123$total_asian_mean)
qplot(midwest_p123$total_asian_mean)  #ex4
midwest_p123$total_asian_mean[1]

midwest_p123$ex4 <- ifelse(midwest_p123$total_asian_mean > 0.4872462, "large","small")
table(midwest_p123$ex4)
qplot(midwest_p123$ex4) #ex5

exam <- read.csv("cvs_exam.csv")
