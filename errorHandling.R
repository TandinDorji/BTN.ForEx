v <- list(1,2,4,'0',5)

for (i in v) {
    tryCatch(print(5/i), error = function(e) {
        print("Non conformabale arguments")
    })
}


# url <- "https://www.bob.bt/service-and-support/current-rate-of-exchange/"
# tryCatch(
#     contents <- read_html(url, options(timeout=30)),
#     error = function(e) {
#         print("URL/Website is down.")
#     }
# )
