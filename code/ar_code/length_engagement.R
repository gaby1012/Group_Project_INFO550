library(labelled)
library(gtsummary)
library(lubridate)
library(chron)
library(dplyr)

here::i_am("code/ar_code/length_engagement.R")

data_filepath = Sys.getenv("ENG_PATH")

course_engagement <- read.csv(here::here(data_filepath))
#course_engagement <- read.csv("data/course_engagement.csv")
course_engagement = course_engagement %>%
  mutate(length = case_when(nchar(length) < 6 ~ paste("0:", length, sep =''), nchar(length)>=6 ~ length))
  
course_engagement$length <- round((as.numeric( chron::times(course_engagement$length))*24 )*60, digits = 2) 


#course <- course_engagement[is.na(course_engagement)] <- 0

png(file=here::here("output/linea.png"),
    width=600, height=350)
plota <- plot(course_engagement$length ~ course_engagement$unique_viewers, pch = 19, col = "lightblue")
linea <- abline(lm(course_engagement$length ~ course_engagement$unique_viewers), col = "red", lwd = 3)
dev.off()

analyzea <- lm(course_engagement$length ~ course_engagement$unique_viewers)


#Study time trends of engagement over weeks of class
#  Analyzing the tendency by doing regression as well
png(file=here::here("output/lineb.png"),
    width=600, height=350)
plotb <- plot(course_engagement$length ~ course_engagement$views, pch = 19, col = "lightblue")
lineb <- abline(lm(course_engagement$length ~ course_engagement$views), col = "red", lwd = 3)
dev.off()

analyzeb <- lm(course_engagement$length ~ course_engagement$views)



#Study time trends of engagement through each week
#  Analyzing the tendency by doing regression as well
png(file=here::here("output/linec.png"),
    width=600, height=350)
plotc <- plot(course_engagement$length ~ course_engagement$week, pch = 19, col = "lightblue")
linec <- abline(lm(course_engagement$length ~ course_engagement$week), col = "red", lwd = 3)
dev.off()

analyzec <- lm(course_engagement$length ~ course_engagement$week)




saveRDS(analyzea, file = here::here("output/analyzea.rds"))

saveRDS(analyzeb, file = here::here("output/analyzeb.rds"))

saveRDS(analyzec, file = here::here("output/analyzec.rds"))

