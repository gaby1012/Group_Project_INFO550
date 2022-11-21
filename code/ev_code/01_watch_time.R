library(dplyr)
library(tidyverse)
library(gtsummary)
library(ggplot2)
library(tidyverse)
library(ggplot2)
library(here)
library(dplyr)
library(ggpubr)
library(rstatix)
library(boot)
library("devtools")
library(kableExtra)
#library(ggbiplot)
library("class")
library("sjstats")
library("data.table")
library("ggiraph")
library("patchwork")
library("lubridate")

here::i_am("code/ev_code/01_watch_time.R")

data_filepath = Sys.getenv("ENG_PATH")


absolute_path <- here::here(data_filepath)
dat <- read.csv(absolute_path)

#First change length from character to datetime
typeof(dat$length)

dat$length <- as.numeric(ms(dat$length), "seconds")
dat <- na.omit(dat)

dat$TIME <- as.factor( ifelse(dat$length < mean(dat$length), "Short-Vid", "Long-Vid") )

#NOw that we have all of the data moved in let's break down what I personally need to
#contribute to this project!

#Summarize video statistics by topic:
  #average length, views total , views unique, and separate this by topic.
library(gtsummary)
SumFull <- get_summary_stats(dat, views, unique_viewers, length,
                             show = c( "mean", "sd",
                                       "median", "min", "max", "iqr"))
table1 <- SumFull %>% kbl() %>%
  kable_styling(bootstrap_options = c("striped", "hover"))
table1

table2 <- dat %>% 
  select("views", "topic", "length") %>%
  tbl_summary(by = topic) %>% 
  modify_spanning_header(c("stat_1", "stat_2") ~ "**Views and Length by Topics**") %>%
  add_overall() %>%
  add_p()
table2



barplot <-
  ggplot(dat, 
                      aes(x = reorder(topic, length), 
                          y = mean(length))) +
  geom_col(color = "black", fill="#0072B2", size = 0.5) +
  theme_minimal() +
  theme(axis.text=element_text(size = 10)) +
  labs(title = "Topic videos Broken Down by Length of Each Vdeo",
       subtitle = "Engagement Report"
  ) +
  ylab("") +
  xlab("") +
  coord_flip() +
  scale_colour_manual(values=Sys.getenv("COLOR_PALETTE"))
datrev <- dat %>%
  mutate(
    tooltip_text = paste0(toupper(topic), "\n", 
                          length)
  )
latest_bar <- ggplot(datrev, aes(x = reorder(topic, length), 
                                 y = mean(length), 
                                 tooltip = tooltip_text, data_id = topic
                                 )) + 
  geom_col_interactive(color = "black", fill="#0072B2", size = 0.5) +
  theme_minimal() +
  theme(axis.text=element_text(size = 10)) +
  labs(title = "Topic videos Broken Down by Length of Each vVdeo",
       subtitle = "Engagement Report"
  ) +
  ylab("") +
  xlab("") +
  coord_flip() + scale_colour_manual(values=Sys.getenv("COLOR_PALETTE"))

(girafe(ggobj = latest_bar, width_svg = 5, height_svg = 4))
##We can save this figure using the ggplot package as well
ggsave(
  here::here("output/EVIERscatterplot.png"),
  plot = latest_bar,
  device = "png"
)

saveRDS(table1, file = here::here("output/EVIERtable_one.rds"))
saveRDS(table2, file = here::here("output/EVIERtable_two.rds"))
