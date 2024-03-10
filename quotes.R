library(rvest)
library(tidyverse)

url <- "https://quotes.toscrape.com"
html <- read_html(url)

row <- html |> html_elements(".quote")

row |> html_element(".text") |> html_text2()
row |> html_element(".author") |> html_text2()
row |> html_element("span a") |> html_attr("href")
row |> html_element(".tags") |> html_text2() |> str_remove("Tags: ")

# Or, if you look carefully, you'll notice that there's a hidden element
# that contains the tags as comma separated
row |> html_elements(".tags meta") |> html_attr("content")

# What if you wanted to extract the individual tags as strings? ----------------

# Only gives the first tag
row |> html_element(".tags") |> html_element(".tag")

# Gives all the tags, but loses connection
row |> html_element(".tags") |> html_elements(".tag")

# Need to use map()/lapply()
row |>
  html_element(".tags") |>
  lapply(\(tag) tag |> html_elements(".tag") |> html_text2())

# or
row |>
  html_element(".tags") |>
  lapply(function(tag) {
    tag |> html_elements(".tag") |> html_text2()
  })
