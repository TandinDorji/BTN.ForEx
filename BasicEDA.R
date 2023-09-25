library(tidyverse)
library(stringr)

files <- dir("data") %>% str_split_i(pattern = "-", i = 1)
df <- table(files) %>% as.data.frame()
str(df)
names(df) <- c("Date", "Freq")
df$Date <- as.Date(x = df$Date, format = "%Y%m%d")

df %>% 
    ggplot(aes(x = Date, y = Freq)) + 
    geom_bar(stat = "identity", aes(fill = factor(Freq))) + 
    theme_minimal() + 
    theme(
        legend.position = "n",
    ) + 
    labs(
        title = paste0(
            "Cron jobs run since automation on ",
            format(df$Date[1], "%B %d, %Y"), " (", 
            sum(df$Freq), " over ", length(df$Date)," days)")
    )
