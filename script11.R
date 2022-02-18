library(ggplot2)

mpg

ggplot(data=mpg,aes(x=displ,y=hwy)) + geom_point()+
  xlim(3,6)+
  ylim(10,30)

ggplot(data=mpg,aes(x=cty,y=hwy)) + geom_point()

str(midwest)

options(scipen = 99)
options(scipen = 0)
ggplot(data=midwest, aes(x=poptotal,y=popasian))+
  geom_point() +
  xlim(0,500000)+
  ylim(0,10000)


library(dplyr)

df_mpg <- mpg %>%
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy))

df_mpg

ggplot(data=df_mpg,aes(x=reorder(drv,-mean_hwy),y=mean_hwy))+geom_col()


ggplot(data = mpg, aes(x = hwy, fill = as.factor(hwy))) + geom_bar()

ggplot(data = mpg, aes(x = drv, fill = as.factor(drv))) + geom_bar()

df <- mpg %>%
  filter(class=="suv") %>%
  group_by(manufacturer) %>%
  summarise(mean_cty = mean(cty)) %>%
  arrange(desc(mean_cty)) %>%
  head(5)

df

ggplot(data=df,aes(x=reorder(manufacturer, -mean_cty), y=mean_cty, fill=as.factor(manufacturer)))+geom_col()


ggplot(data = mpg,aes(x=class,fill=as.factor(class))) + geom_bar()


economics

ggplot(data=economics,aes(x=date,y=unemploy)) + geom_line()
ggplot(data=economics, aes(x=date,y=psavert)) + geom_line()
ggplot(data=mpg,aes(x=drv,y=hwy))+geom_boxplot()

class_mpg <- mpg %>%
  filter(class %in% c("compact","subcompact","suv"))

ggplot(data=class_mpg,aes(x=class,y=cty))+geom_boxplot()
