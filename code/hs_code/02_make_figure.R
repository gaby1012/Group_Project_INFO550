here::i_am(
  "code/hs_code/02_make_figure.R"
)
library(ggplot2)
library(tidyverse)

df <- readRDS(
  file = here::here("data/data_clean.rds")
)

agg_tbl<-df %>%
  group_by(topic) %>% dplyr::summarize(sum_time = sum(length))

cp = Sys.getenv("COLOR_PALETTE")

cp_list = as.list(strsplit(cp, '\\s+')[[1]])

cp_list <- paste("#", cp_list, sep="")

fig<- ggplot(agg_tbl, aes(x=factor(topic), weight=sum_time,fill=topic))+
  geom_bar()+
  ggtitle("Topic vs. Time Length (min)") +
  xlab("Topic") + ylab("Time Length (min)") + theme(plot.title = element_text(hjust = 0.5)) + scale_fill_manual(values=cp_list)



ggsave(
  here::here("output/figure.png"),
  plot = fig,
  device = "png"
)
