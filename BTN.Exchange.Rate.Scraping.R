# R script to scrape BOB website to extract current exchange rate 
# for BTN against USD, AUD and SGD


# load libraries, install if not available 
# if(!require(tidyverse)) install.packages("tidyverse")
if(!require(rvest)) {
        install.packages("rvest") 
        library(rvest)
}


# retrieve all data from url and load into "contents"
# using read_html function from rvest package
url <- "https://www.bob.bt/service-and-support/current-rate-of-exchange/"
contents <- read_html(url)


table_id <- "tablepress-3"
table_data <- contents %>% html_nodes(paste0("#", table_id)) %>% html_table(fill = TRUE)

# Print the table data
print(table_data)
xr <- data.frame(table_data)
names(xr) <- c("Currency", "10.Percent.Incentive.Rate", 
               "TT.Buy", "TT.Sell", "Notes.Buy", "Notes.Sell")
xr <- xr[-1, ]
rownames(xr) <- NULL


# Save data to a CSV file
# filename <- paste0("C:/Users/Tandin Dorji/OneDrive/Documents/R-Workspace/BTN.ForEx/Rates/", format(Sys.time(), "%Y%m%d"), ".csv")
filename <- paste0("C:/Users/Tandin Dorji/OneDrive/Documents/R-Workspace/BTN.ForEx/Rates/", format(Sys.time(), "%Y%m%d-%H%M%S"), ".csv")


write.csv(xr, filename, row.names = FALSE)
rm(list=ls())
gc()
cat("\014")
# q()
