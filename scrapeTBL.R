# R script to scrape ### TBL ### website to extract 
# current exchange rate for BTN against USD, AUD and SGD, etc.
# 12 rates as on 26/08/2023


# load libraries, install if not available 
### already in main file


# retrieve all data from url and load into "contents"
# using read_html function from rvest package
# enclosed within error handler in case website is down

scrapeTBL <- function(){
    url <- "https://www.tbankltd.com/forex-rates"
    
    tryCatch(
        contents <- read_html(url),
        error = function(e) {
            # triggerHTTPSerror("TBL")
            print("URL/Website is down.")
        }
    )
    
    table_class <- "uk-table"
    table_data <- contents %>% 
        html_nodes(paste0(".", table_class)) %>%
        html_table(fill = TRUE)
    
    # store exchange rate into data frame and clean df
    xr <- data.frame(table_data)
    
    # check table format before renaming columns
    check1 <- names(xr) == c("Var.1", "TT", "Var.3", "Notes", "Var.5")
    check2 <- unlist(xr[1,], use.names = FALSE) == 
        c("Currencies", "Buy", "Sell", "Buy", "Sell")
    
    # if table format did not change, sum of checks 1,3 should be 9
    # else, raise error via log file to trigger code revision
    
    if(sum(check1, check2) == 9)
    {
        names(xr) <- c("Currency", "TT.Buy", "TT.Sell", 
                       "Notes.Buy", "Notes.Sell")
        xr <- xr[-1, ]
        rownames(xr) <- NULL
    } else {
        # triggerCodeRevision("TBL")
        xr <- NULL
    }
    
    
    # rename currency names
    source("renameCurrencies.R")
    xr <- renameCurrencies("TBL", xr)
    xr    # return df to main file
}