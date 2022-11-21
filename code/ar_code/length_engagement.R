library(labelled)
library(gtsummary)
library(lubridate)

here::i_am("code/ar_code/length_engagement.R")

#data_filepath = Sys.getenv("ENG_PATH")

course_engagement <- read.csv(here::here("data/course_engagement.csv"))

course_engagement2 <-read.csv(here::here("data/course_engagement.csv"))

course_engagement$length <- (as.numeric(ms(course_engagement$length)))

course_engagement$length[4] <- (as.numeric(hms(course_engagement2$length[4])))

course_engagement$length <- round(x=(course_engagement$length)/60,digits = 2)


#course <- course_engagement[is.na(course_engagement)] <- 0

# Creating the plot
plota <- plot(course_engagement$length ~ course_engagement$unique_viewers, pch = 19, col = "lightblue")

# Regression line
linea <- abline(lm(course_engagement$length ~ course_engagement$unique_viewers), col = "red", lwd = 3)

analyzea <- lm(course_engagement$length ~ course_engagement$unique_viewers)

#Study time trends of engagement over weeks of class
#  Analyzing the tendency by doing regression as well
plotb <- plot(course_engagement$length ~ course_engagement$views, pch = 19, col = "lightblue")
lineb <- abline(lm(course_engagement$length ~ course_engagement$views), col = "red", lwd = 3)
analyzeb <- lm(course_engagement$length ~ course_engagement$views)



#Study time trends of engagement through each week
#  Analyzing the tendency by doing regression as well
plotc <- plot(course_engagement$length ~ course_engagement$week, pch = 19, col = "lightblue")
linec <- abline(lm(course_engagement$length ~ course_engagement$week), col = "red", lwd = 3)
analyzec <- lm(course_engagement$length ~ course_engagement$week)


saveRDS(plota, file = here::here("output/plota.rds"))
saveRDS(linea, file = here::here("output/linea.rds"))
saveRDS(analyzea, file = here::here("output/analyzea.rds"))

saveRDS(plotb, file = here::here("output/plotb.rds"))
saveRDS(lineb, file = here::here("output/lineb.rds"))
saveRDS(analyzeb, file = here::here("output/analyzeb.rds"))

saveRDS(plotc, file = here::here("output/plotc.rds"))
saveRDS(linec, file = here::here("output/linec.rds"))
saveRDS(analyzec, file = here::here("output/analyzec.rds"))

