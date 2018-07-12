library(ggplot2)
library(data.table)

# https://www.economist.com/graphic-detail/2011/12/02/corrosive-corruption

df <- fread('Economist_Assignment_Data.csv',drop=1)

head(df)
pl <- ggplot(df,aes(x=CPI,y=HDI,color=Region)) + geom_point()
pl
pl <- ggplot(df,aes(x=CPI,y=HDI,color=Region)) + geom_point(size=4,shape=1)
pl
pl + geom_smooth(aes(group=1)) # https://ggplot2.tidyverse.org/reference/geom_smooth.html

pl2 <- pl + geom_smooth(aes(group=1),method ='lm',formula = y~log(x),se=FALSE,color='red')
# https://ggplot2.tidyverse.org/reference/aes_group_order.html
pl2

pl2 + geom_text(aes(label=Country))
# http://docs.ggplot2.org/current/geom_text.html

pointsToLabel <- c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                   "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                   "India", "Italy", "China", "South Africa", "Spane",
                   "Botswana", "Cape Verde", "Bhutan", "Rwanda", "France",
                   "United States", "Germany", "Britain", "Barbados", "Norway", "Japan",
                   "New Zealand", "Singapore")

pl3 <- pl2 + geom_text(aes(label = Country), color = "gray20", 
                       data = subset(df, Country %in% pointsToLabel),check_overlap = TRUE)

pl3

pl4 <- pl3 + theme_bw() 
pl4

pl5 <- pl4 + scale_x_continuous(name = "Corruption Perceptions Index, 2011 (10=least corrupt)",
                               limits = c(.9, 10.5),breaks=1:10) 
# limits:A numeric vector of length two providing limits of the scale.
# breaks: A numeric vector of positions
# https://ggplot2.tidyverse.org/reference/scale_continuous.html

pl5

pl6 <- pl5 + scale_y_continuous(name = "Human Development Index, 2011 (1=Best)",
                                limits = c(0.2, 1.0))
pl6

pl6 + ggtitle("Corruption and Human development")

# install.packages("ggthemes")
library("ggthemes")

pl6 + theme_economist()
pl6 + theme_economist_white()
pl6 + theme_gray()
