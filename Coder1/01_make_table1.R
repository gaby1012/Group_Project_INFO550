here::i_am(
  "Coder1/01_make_table1.R"
)


df <- readRDS(
  file = here::here("data/data_clean.rds")
)

library(expss)
library(labelled)
library(knitr)
library(kableExtra)
library(reshape2)
library(dplyr)
library(magrittr)
library(tidyr)

library(plyr)

Rank=c(1,2,3,4,5)

tab1<- df[order(df$views, decreasing = TRUE),]%>%head(5)%>%
  select(video_title,views)

dnew2<- df%>% group_by(topic) %>% 
  dplyr::summarize(sum_views = sum(views),
                   .groups = 'drop')

tab2<-dnew2[order(dnew2$sum_views,decreasing = TRUE),] %>%head(5)


table_one<-cbind(Rank,tab1,tab2)
knitr::kable(table_one) %>%column_spec (1:5,border_left = T, border_right = T) %>% kable_styling()



saveRDS(
  table_one,
  file = here::here("output/table_one.rds")
)