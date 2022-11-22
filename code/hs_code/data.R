library(dplyr)
here::i_am(
  "code/hs_code/data.R"
)

data_filepath = Sys.getenv("ENG_PATH") 

df<-read.csv(
  here::here(data_filepath))

#df <- read.csv("data/course_engagement.csv")
df = df %>%
  mutate(length = case_when(nchar(length) < 6 ~ paste("0:", length, sep =''), nchar(length)>=6 ~ length))

df$length <- round((as.numeric( chron::times(df$length))*24 )*60, digits = 2) 


saveRDS(
  df,
  file = here::here("data/data_clean.rds")
)
