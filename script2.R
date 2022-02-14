b <- 2
b

c <- 3
c

d <- 3.5
d

a+b

a+b+c

4/6
5*6

var1 <- c(1,2,3,4,5)
var1

var1[1]
var2<- c(1:5)


var2
var2[5]
var3 <- seq(1:5)
var3


var2[1] + var3[3]

var1+2

var4 <- var1+var2


var4 <- seq(1,10, by = 2)
var4

str1 <- "a"

str1

str2 <- "가가"

str2


str <- c("a","b","c")

str


str3 <- c("hello","worid","is","good!")
  

x <- c(1,2,3)
x

mean(x) 

max(x)

min(x)

strc <- paste("x","y")

strc <- paste0(str2,2)
strc

strc2 <- paste(str3,cllapse=",")
strc2

x_mean = mean(x)
x_mean

install.packages("ggplot2")

library(ggplot2)

x<- c(1,1,2,2,3,4,5,6,6,6,7,8,8,9,9,9,9,9,9)
x
qplot(x)

x <- c("a","a","b","c")
x


qplot(x)

mpg

qplot(data=mpg, x = hwy)
qplot(data=mpg, x = cty)
qplot(data=mpg, x = drv, y=hwy)
qplot(data=mpg, x = drv, y=hwy, geom = "line")
qplot(data=mpg, x = drv, y=hwy, geom = "boxplot")
qplot(data=mpg, x = drv, y=hwy, geom = "boxplot", colour = drv)

?qplot



#p77 문제
ab <- c(80,60,70,50,90); ab; mean(ab); abavg <- mean(ab); abavg



