# R script to scrape RMA, BOB, TBL website to extract current exchange rate 
# for BTN against USD, AUD and SGD
# 12 rates as on 26/08/2023


### revised on 16 September, 2023
# Added code for error handling HTTPS error, when website is down
# Created new main file (BTN.Exchange ... ) and scrapeBanks_2 files
# to run in parallel with the older cron job for safety


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

source("scrapeRMA2.R")
source("scrapeBOB2.R")
source("scrapeTBL2.R")

rateRMA <- scrapeRMA2()
rateBOB <- scrapeBOB2()
rateTBL <- scrapeTBL2()

rate <- rbind(rateRMA, rateBOB, rateTBL)
rate <- cbind(rate, Date = format(Sys.Date(), "%Y%m%d"))
# View(rate)


filename <- paste0("data/", format(Sys.time() + 10*60*60, "%Y%m%d-%H%M%S"), "_new.csv")
# saving file with time in AEST so that it is easier to read and check cron job success daily around noon AEST
# added_new suffix to differentiate the file scraped with new code with error handling
# for website error

write.csv(rate, filename, row.names = FALSE)
rm(list=ls())
gc()
cat("\014")
# q()