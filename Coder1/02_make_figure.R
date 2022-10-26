here::i_am(
  "Coder1/02_make_figure.R"
)
library(ggplot2)


df <- readRDS(
  file = here::here("data/data_clean.rds")
)

agg_tbl<-df %>%
  group_by(topic) %>% dplyr::summarize(sum_time = sum(length))


fig<- ggplot(agg_tbl, aes(x=factor(topic), weight=sum_time,fill=topic))+
  geom_bar()+
  ggtitle("Topic vs. Time Length (min)") +
  xlab("Topic") + ylab("Time Length (min)")+theme(plot.title = element_text(hjust = 0.5))



ggsave(
  here::here("output/figure.png"),
  plot = fig,
  device = "png"
)