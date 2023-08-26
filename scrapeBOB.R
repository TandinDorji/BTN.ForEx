# R script to scrape ### BOB ### website to extract 
# current exchange rate for BTN against USD, AUD and SGD, etc.
# 12 rates as on 26/08/2023


# load libraries, install if not available 
### already in main file


# retrieve all data from url and load into "contents"
# using read_html function from rvest package
# enclosed within error handler in case website is down

scrapeBOB <- function(){
    url <- "https://www.bob.bt/service-and-support/current-rate-of-exchange/"
    
    tryCatch(
        contents <- read_html(url),
        error = function(e) {
            # triggerHTTPSerror("BOB")
            print("URL/Website is down.")
        }
    )
    
    table_id <- "tablepress-3"
    table_data <- contents %>% 
        html_nodes(paste0("#", table_id)) %>%
        html_table(fill = TRUE)
    
    # store exchange rate into data frame and clean df
    xr <- data.frame(table_data)
    
    # check table format before renaming columns
    check1 <- names(xr) == c("Var.1", "Var.2", "TT", "Var.4", "Notes", "Var.6")
    check2 <- unlist(xr[1,], use.names = FALSE) == 
        c("Currency", "10% Incentive Scheme (T&C) CLICK HERE", 
          "Buy", "Sell", "Buy", "Sell")
    
    # if table format did not change, sum of checks 1,3 should be 10
    # else, raise error via log file to trigger code revision
    
    if(sum(check1, check2) == 12)
    {
        names(xr) <- c("Currency", "Incentive.Rate", "TT.Buy", "TT.Sell", 
                       "Notes.Buy", "Notes.Sell")
        xr <- xr[-1, c(1, 3:6)]
        rownames(xr) <- NULL
    } else {
        # triggerCodeRevision("BOB")
        xr <- NULL
    }
    
    
    # rename currency names
    source("renameCurrencies.R")
    xr <- renameCurrencies("BOB", xr)
    xr    # return df to main file
}
