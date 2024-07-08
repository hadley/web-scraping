library(httr2)
library(rvest)

# Demo is less compelling than it might be:
# * Need some basic httr2 knowledge (talk on Wednesday)
# * Can't download then parse (https://github.com/r-lib/httr2/issues/448)
# * Need helper for absolute URL (https://github.com/r-lib/httr2/issues/449)

# First figure out how to find "next" page
url <- "http://books.toscrape.com"
html <- read_html(url)
html |> html_element(".next a") |> html_attr("href") |> url_absolute(url)

# Now wrap it into a function that takes a response and returns a request
next_request <- function(resp, req) {
  url <- resp |>
    resp_body_html() |>
    html_element(".next a") |>
    html_attr("href") |>
    url_absolute(req$url)

  request(url)
}
# And check it works
req <- request(url)
resp <- req |> req_perform()
next_request(resp, req)

# Now figure out how to get the data we want
row <- html_elements(html, ".product_pod")
row |> html_element("h3 a") |> html_attr("title")
row |> html_element(".price_color") |> html_text() |> readr::parse_number()

# And turn it in to a function
parse_page <- function(resp) {
  row <- resp |>
    resp_body_html() |>
    html_elements(".product_pod")

  tibble::tibble(
    title = row |> html_element("h3 a") |> html_attr("title"),
    price = row |> html_element(".price_color") |> html_text() |> readr::parse_number()
  )
}
parse_page(resp)

# Then we feed the "next page" function to req_perform_iterative()
# And the "get the data" function to resps_data()

pages <- req_perform_iterative(request(url), next_url, max_reqs = 50)
pages |> resps_data(parse_page)

# URL pattern -------------------------------------------------------------
# Life is much easier if we notice that the pages have a specific url pattern
# Then we can pregenerate the urls and download them all in parallel

i <- 1:100
urls <- glue::glue("http://books.toscrape.com/catalogue/page-{i}.html")
requests <- lapply(url, request)
pages <- req_perform_parallel(requests, on_error = "continue")
pages |> resps_successes() |> resps_data(parse_page)

# Here we over estimated the number of pages then used on_error = "continue" to
# skip any pages that errored. You could also scrape the total number of
# pages off of the first page and use that for more accurate request generation
