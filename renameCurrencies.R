# function to rename currencies scraped from 
# different Bank's websites for consistency


renameCurrencies <- function(bank, xr) {
    if(bank == "RMA") {
        xr[, 1] <- case_match(
            xr[, 1],
            c("USD") ~ "USD",
            c("GBP") ~ "GBP",
            c("EUR") ~ "EUR",
            c("JPY(100)") ~ "JPY",
            c("CHF") ~ "CHF",
            c("HKD") ~ "HKD",
            c("CAD") ~ "CAD",
            c("AUD") ~ "AUD",
            c("SGD") ~ "SGD",
            c("DKK") ~ "DKK",
            c("SEK") ~ "SEK",
            c("NOK") ~ "NOK"
        )
    } else if(bank == "BOB") {
        xr[, 1] <- case_match(
            xr[, 1],
            c("USD 50 and above") ~ "USD",
            c("USD (5,10 & 20)") ~ "USD.5.20",
            c("USD (1 & 2)") ~ "USD.12",
            c("Pound Sterling") ~ "GBP",
            c("Euro") ~ "EUR",
            c("Japanese Yen(100)") ~ "JPY",
            c("Swiss Franc") ~ "CHF",
            c("Hong Kong Dollar") ~ "HKD",
            c("Canadian Dollar") ~ "CAD",
            c("Australian Dollar") ~ "AUD",
            c("Singapore Dollar") ~ "SGD",
            c("Danish Kroner") ~ "DKK",
            c("Swedish Kroner") ~ "SEK",
            c("Norwegian Kroner") ~ "NOK"
        )
    } else {
        xr[, 1] <- case_match(
            xr[, 1],
            c("US Dollar(100 & 50)") ~ "USD",
            c("USD 50 Below (20, 10 & 5)") ~ "USD.5.20",
            c("USD 2 & 1") ~ "USD.12",
            c("Pound Sterling") ~ "GBP",
            c("Euro") ~ "EUR",
            c("Japanese Yen (100)") ~ "JPY",
            c("Swiss Franc") ~ "CHF",
            c("Hongkong Dollar") ~ "HKD",
            c("Canadian Dollar") ~ "CAD",
            c("Australian Dollar") ~ "AUD",
            c("Singapore Dollar") ~ "SGD",
            c("Danish Kroner") ~ "DKK",
            c("Swedish Kroner") ~ "SEK",
            c("Norwegian Kroner") ~ "NOK"
        )
    }
    xr # return renamed table
}
# 
# xr <- renameCurrencies("TBL", xr)
