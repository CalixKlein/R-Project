install.packages("foreign")
library(foreign)
library(dplyr)
library(ggplot2)
library(readxl)


raw_welfare <- read.spss(file = "Koweps_hpc10_2015_beta1.sav", 
                         to.data.frame = T)
welfare <- raw_welfare

head(welfare)
tail(welfare)
View(welfare)
dim(welfare)
str(welfare)
summary(welfare)

welfare <- rename(welfare,
                  sex = h10_g3, #성별
                  birth = h10_g4, # 태어난 연도
                  marriage = h10_g10, #혼인 상태
                  religion = h10_g11, #종교
                  income = p1002_8aq1, #월급 
                  code_job = h10_eco9, #직종 코드
                  code_region = h10_reg7) #지역 코드

class(welfare$sex)
table(welfare$sex)

table(welfare$sex)

welfare$sex <- ifelse(welfare$sex == 9,NA,welfare$sex)

table(is.na(welfare$sex))

welfare$sex <- ifelse(welfare$sex == 1, "male", "female")
table(welfare$sex)

class(welfare$income)

summary(welfare$income)


qplot(welfare$income)

summary(welfare$imcome)

welfare$income <- ifelse(welfare$income %in% c(0,9999), NA, welfare$income)

table(is.na(welfare$income))

sex_income <- welfare %>%
  filter(is.na(income)) %>%
  group_by(sex) %>%
  summarise(mean_income = mean(income))

ggplot(data = sex_income, aes(x=sex, y=mean_income)) + geom_col()


summary(welfare$birth)

table(is.na(welfare$birth))

welfare$birth <- ifelse(welfare$birth == 9999,NA, welfare$birth)

table(is.na(welfare$birth))

str(welfare)

welfare$age <- 2015 - welfare$birth + 1

summary(welfare$age)

age_income <- welfare %>% 
  filter(!is.na(income))%>%
  group_by(age) %>%
  summarise(mean_income = mean(income))

head(age_income)


ggplot(data = age_income, aes(x = age, y = mean_income))+geom_line()

welfare <- welfare %>%
  mutate(ageg = ifelse(age < 30, "young",
                       ifelse(age <= 59, "middle","old")))

table(welfare$ageg)
qplot(welfare$ageg)

ageg_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(ageg) %>%
  summarise(mean_income = mean(income))

ageg_income

ggplot(data =ageg_income,aes(x=reorder(ageg,-mean_income)
                             ,y=mean_income,
                             fill = as.factor(ageg))) +
                              geom_col()

ggplot(data=ageg_income,aes(x=ageg,y=mean_income
                            ,fill=as.factor(ageg)))+
                            geom_col() +
                            scale_x_discrete(limits=
                                               c("young",
                                                 "middle",
                                                 "old"))


sex_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(ageg, sex) %>%
  summarise(mean_income = mean(income))

sex_income


ggplot(data= sex_income, aes(x = ageg, y = mean_income,
                             fill = sex)) +
  geom_col(position= "dodge") +
  scale_x_discrete(limits = c("young", "middle","old"))



ggplot(data=age_income, aes(x=age, y=mean_income,
                            fill = age)) + 
  geom_line()


agesex_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(age,sex) %>%
  summarise(mean_income = mean(income))

head(agesex_income)


ggplot(data=agesex_income, aes(x=age, y=mean_income,
                               col=sex)) +
  geom_line()



class(welfare$code_job)

table(welfare$code_job)

list_job <- read_excel("Koweps_Codebook.xlsx",
                       col_names = T,
                       sheet = 2)

head(list_job)
dim(list_job)


welfare <- left_join(welfare, list_job, by = "code_job")

table(is.na(welfare$code_job))

welfare %>%
  filter(!is.na(welfare$code_job)) %>%
  select(code_job, job) %>%
  head(10)


job_income <- welfare %>%
  filter(!is.na(code_job) & !is.na(income)) %>%
  group_by(job) %>%
  summarise(mean_income = mean(income))

head(job_income)

top10 <- job_income %>%
  arrange(desc(mean_income)) %>%
  head(10)

top10

ggplot(data = top10, aes(x = reorder(job, mean_income),
                          y = mean_income)) +
  geom_col() +
  coord_flip()

bottom <- job_income %>%
  arrange(mean_income) %>%
  head(10)

ggplot(data = bottom, aes(x=reorder(job,-mean_income),
                          y=mean_income)) +
  geom_col() +
  coord_flip()


job_male <- welfare %>%
  filter(!is.na(job)& sex == "male") %>%
  group_by(job)%>%
  summarise(n = n())%>%
  arrange(desc(n)) %>%
  head(10)

job_male

job_female <-welfare %>%
  filter(!is.na(job)& sex=="female") %>%
  group_by(job) %>%
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
  head(10)

job_female

ggplot(data= job_female,aes(x=reorder(job,n), y=n))+
  geom_col()+
coord_flip()

class(welfare$religion)

table(welfare$religion)

welfare$religion <- ifelse(welfare$religion== 1,"yes","no")

table(welfare$religion)

qplot(welfare$religion)
class(welfare$marriage)

table(welfare$marriage)
welfare$group_marriage <- ifelse(welfare$marriage == 1,
                                 "marriage",
                                 ifelse(welfare$marriage==3,
                                        "divorce",NA))

table(welfare$group_marriage)
table(is.na(welfare$group_marriage))
qplot(welfare$group_marriage)

religion_marriage <- welfare %>%
  filter(!is.na(welfare$group_marriage)) %>%
  group_by(religion,group_marriage) %>%
  summarise(n = n()) %>%
  mutate(tot_group = sum(n)) %>%
  mutate(pct = round(n/tot_group * 100,1))

religion_marriage

divorce <- religion_marriage %>%
  filter(group_marriage == "divorce") %>%
  select(religion, pct)

divorce


ggplot(data = divorce, aes(x = religion, y = pct)) + geom_col()

ageg_marriage <- welfare %>%
  filter(!is.na(group_marriage)) %>%
  group_by(ageg,group_marriage) %>%
  summarise(n = n()) %>%
  mutate(tot_group = sum(n)) %>%
  mutate(pct = round(n/tot_group*100,1))

ageg_marriage


#count() 활용
ageg_marriage <- welfare %>%
  filter(!is.na(group_marriage)) %>%
  count(ageg,group_marriage) %>%
  group_by(ageg,group_marriage) %>%
  mutate(pct = round(n/sum(n)*100,1))

ageg_marriage

ageg_divoce <- ageg_marriage %>%
  filter(ageg != "young" & group_marriage == "divorce") %>%
  select(ageg,pct)

ageg_divoce

ggplot(data=ageg_divoce, aes(x = ageg, y = pct))+geom_col()


ageg_religion_marriage <- welfare %>%
  filter(ageg!="young" & !is.na(group_marriage)) %>%
  group_by(ageg,religion, group_marriage) %>%
  summarise(n = n()) %>%
  mutate(tot_group = sum(n)) %>%
  mutate(pct = round(n/tot_group*100,1))

ageg_religion_marriage  

ggplot(data=ageg_religion_marriage, aes(x = ageg, y = tot_group)) + geom_col()


class(welfare$code_region)
table(welfare$code_region)

list_region <- data.frame(code_region = c(1:7),
                          region = c("서울",
                                     "수도권(인천/경기)",
                                     "부산/경남/울산",
                                     "대구/경북",
                                     "대전/충남",
                                     "강원/충북",
                                     "광주/전남/전북/제주도"))
list_region

welfare <- left_join(welfare,list_region)

welfare %>%
  select(code_region, region) %>%
  head(20)

region_ageg <- welfare %>%
  group_by(region,ageg) %>%
  summarise(n = n()) %>%
  mutate(tot_group = sum(n)) %>%
  mutate(pct = round(n/tot_group * 100, 2))

head(region_ageg)

ggplot(data = region_ageg, aes(x = region, y = pct, fill = ageg)) +
  geom_col() +
  coord_flip()

class(region_ageg_$ageg)
list_order_old <- region_ageg %>%
  filter(ageg == "old") %>%
  arrange(pct)

list_order_old

order <- list_order_old$region

ggplot(data = region_ageg, aes(x = region, y = pct, fill = ageg)) +
  geom_col() +
  coord_flip() +
  scale_x_discrete(limits=order)


region_ageg$ageg <- factor(region_ageg$ageg, level = c("old","middle","young"))

class(region_ageg$ageg)

ggplot(data=region_ageg, aes(x = region, y = pct, fill = ageg)) +
  geom_col() +
  coord_flip() +
  scale_x_discrete(limits=order)
