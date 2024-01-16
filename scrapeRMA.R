# R script to scrape ### RMA ### website to extract 
# current exchange rate for BTN against USD, AUD and SGD, etc.
# 12 rates as on 26/08/2023


# load libraries, install if not available 
### already in main file


# retrieve all data from url and load into "contents"
# using read_html function from rvest package
# enclosed within error handler in case website is down

scrapeRMA <- function(){
    url <- "https://www.rma.org.bt/"
    
    tryCatch(
        contents <- read_html(url),
        error = function(e) {
            # triggerHTTPSerror("RMA")
            print("URL/Website is down.")
        }
    )
    
    table_id <- "table"
    table_data <- contents %>% 
        html_nodes(paste0("#", table_id)) %>%
        html_table(fill = TRUE)
   
    # store exchange rate into data frame and clean df
    xr <- data.frame(table_data)
    
    # check table format before renaming columns
    check1 <- names(xr) == c("CURRENCY", "Note", "Note.1", "TT", "TT.1")
    check2 <- unlist(xr[1,], use.names = FALSE) == 
        c("CURRENCY","BUY","SELL","BUY","SELL")
    
    # if table format did not change, sum of checks 1,3 should be 10
    # else, raise error via log file to trigger code revision
    
    if(sum(check1, check2) == 10)
    {
        xr <- xr[, c(1, 4:5, 2:3)]  # same column order as BOB, TBL
        names(xr) <- c("Currency", "TT.Buy", "TT.Sell", 
                       "Notes.Buy", "Notes.Sell")
        xr <- xr[-1, ]
        rownames(xr) <- NULL
    } else {
        # triggerCodeRevision("RMA")
        xr <- NULL
    }
    
    
    # rename currency names
    source("renameCurrencies.R")
    xr <- renameCurrencies("RMA", xr)
    xr    # return df to main file
}
