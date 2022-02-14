english <- c(90,80,60,70)
english

math <- c(50,60,100,20)
math 

#데이터 프레임

df_midterm <- data.frame(english, math) ;  df_midterm
class <- c(1,1,2,2)
df_midterm <- data.frame(english,math,class); df_midterm

df_midterm$english
df_midterm$english[1]
df_midterm$math[1]
mean(df_midterm$english)
mean(df_midterm$math)
max(df_midterm$english)

df_midterm <- data.frame(english = c(90,80,60,70),
                         math = c(50,60,100,20),
                         class= c(1,1,2,2))
df_midterm

#p.88
df_p88 <- data.frame(제품 = c("사과","딸기","수박"),
                     가격 = c(1800,1500,3000),
                     판매량 = c(24,38,13) )

df_p88

mean(df_p88$가격)
mean(df_p88$판매량)

install.packages("readxl")
library(readxl)

df_exam <- read_excel("excel_exam.xlsx"); df_exam
mean(df_exam$math);mean(df_exam$english);mean(df_exam$science)



df_novar_exam <- read_excel("excel_exam_novar.xlsx", col_name = F)
df_novar_exam

df_sheet_exam <- read_excel("excel_exam_sheet.xlsx", sheet=3)
df_sheet_exam

df_csv <- read.csv("csv_exam.csv"); df_csv


df_midterm


write.csv(df_midterm, file="df_midterm.csv")

saveRDS(df_midterm, file = "df_midterm.rds")

readRDS("df_midterm.rds")
rm(df_midterm)
df_midterm
