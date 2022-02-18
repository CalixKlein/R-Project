install.packages("foreign")
install.packages(readxl)
library(foreign)
library(dplyr)
library(ggplot2)
library(readxl)

raw_welfare <- read.spss(file="Koweps_hpc10_2015_beta1.sav", to.data.frame = T)

welfare <- raw_welfare
welfare <- raw_welfare

head(welfare)
tail(welfare)
View(welfare)
dim(welfare)
str(welfare)
summary(welfare)

welfare <- rename(welfare,
                  sex = h10_g3, #성별
                  birth = h10_g4, #태어난 연도
                  marriage = h10_g10, #혼인 상태
                  religion = h10_g11, #종교
                  income = p1002_8aq1, #월급
                  code_job = h10_eco9, #직종 코드
                  code_region = h10_reg7) #지역 코드드

class(welfare$sex)
table(welfare$sex)

welfare$sex <- ifelse(welfare$sex == 9,NA,welfare$sex)
table(is.na(welfare$sex))

welfare$sex <- ifelse(welfare$sex == 1, "male","female")

welfare$sex

qplot(welfare$sex)
class(welfare$income)

summary(welfare$income)

qplot(welfare$income)

qplot(welfare$income)+xlim(0,1000)

welfare$incom <- ifelse(welfare$income %in% c(0,9999), NA, welfare$income)
table(is.na(welfare$incom))

sex_income <- welfare %>% 
  filter(!is.na(income)) %>%
  group_by(sex) %>%
  summarise(mean_income = mean(income))

sex_income

ggplot(data=sex_income,aes(x=sex,y=mean_income,fill=as.factor(sex))) + geom_col()
