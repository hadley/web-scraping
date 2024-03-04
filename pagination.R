library(httr2)
library(rvest)

# Demo is less compelling than it might be:
# * Need some basic httr2 knowledge (talk this afternoon)
# * Can't download then parse (https://github.com/r-lib/httr2/issues/448)
# * Need helper for absolute URL (https://github.com/r-lib/httr2/issues/449)

# First figure out how to find "next" page
url <- "http://books.toscrape.com"
html <- read_html(url)
html |> html_element(".next a") |> html_attr("href") |> url_absolute(url)

# Now wrap it into a function that takes a response and returns a request
next_url <- function(resp, req) {
  url <- resp |>
    resp_body_html() |>
    html_element(".next a") |>
    html_attr("href") |>
    url_absolute(req$url)

  request(url)
}

# Now figure out how to get the data we want
row <- html_elements(html, ".product_pod")
row |> html_element("h3 a") |> html_attr("title")
row |> html_element(".price_color") |> html_text() |> parse_number()

# And turn it in to a function
parse_page <- function(resp) {
  row <- resp |>
    resp_body_html() |>
    html_elements(".product_pod")

  tibble(
    title = row |> html_element("h3 a") |> html_attr("title"),
    price = row |> html_element(".price_color") |> html_text() |> parse_number()
  )
}

# Then we feed the "next page" function to req_perform_iterative()
# And the "get the data" function to resps_data()

pages <- req_perform_iterative(request(url), next_url, max_reqs = 10)
pages |> resps_data(parse_page)
