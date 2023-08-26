# R script to scrape RMA, BOB, TBL website to extract current exchange rate 
# for BTN against USD, AUD and SGD
# 12 rates as on 26/08/2023


# load libraries, install if not available 
# if(!require(tidyverse)) install.packages("tidyverse")
if(!require(rvest)) {
        install.packages("rvest") 
        library(rvest)
}

if(!require(dplyr)) {
    install.packages("dplyr") 
    library(dplyr, include.only = c('case_when', 'case_match'))
    # code to load only one function from a library
    # from https://www.roelpeters.be/load-single-function-r-library/
}


# call scripts to scrape the three websites
# pass argument (URL)
# receive value --> df per site

source("scrapeRMA.R")
source("scrapeBOB.R")
source("scrapeTBL.R")

rateRMA <- scrapeRMA()
rateRMA <- cbind(rateRMA, "Src" = "RMA")
rateBOB <- scrapeBOB()
rateBOB <- cbind(rateBOB, "Src" = "BOB")
rateTBL <- scrapeTBL()
rateTBL <- cbind(rateTBL, "Src" = "TBL")

rate <- rbind(rateRMA, rateBOB, rateTBL)
rate <- cbind(rate, Date = format(Sys.Date(), "%Y%m%d"))
# View(rate)

# df1 <- merge(rateBOB, rateTBL, by = "Currency", suffixes = c(".BOB",".TBL"))
# df2 <- merge(df1, rateRMA, by = "Currency", suffixes = c(".A",".RMA"),
#              all.x = TRUE)
# View(df2)


# Save data to a CSV file
# filename <- paste0("C:/Users/Tandin Dorji/OneDrive/Documents/R-Workspace/BTN.ForEx/Rates/", format(Sys.time(), "%Y%m%d"), ".csv")
filename <- paste0("C:/Users/Tandin Dorji/OneDrive/Documents/R-Workspace/BTN.ForEx/Rates/", format(Sys.time(), "%Y%m%d-%H%M%S"), ".csv")


write.csv(rate, filename, row.names = FALSE)
rm(list=ls())
gc()
cat("\014")
# q()
