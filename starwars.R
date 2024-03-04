library(rvest)
library(tidyverse)

html <- read_html("https://rvest.tidyverse.org/articles/starwars.html")

# Find the row ------------------------------------------------------------

row <- html_elements(html, "#main section")

# Find the columns --------------------------------------------------------

row |> html_element("h2") |> html_text2()
row |> html_element("h2") |> html_attr("data-id")
row |> html_element("p") |> html_text2()
row |> html_element("span.director") |> html_text2()
row |> html_element(".crawl") |> html_text2()


# Make a tibble -----------------------------------------------------------

starwars <- tibble(
  title = row |> html_element("h2") |> html_text2(),
  episode = row |> html_element("h2") |> html_attr("data-id"),
  released = row |> html_element("p") |> html_text2(),
  director = row |> html_element("span.director") |> html_text2(),
  crawl = row |> html_element(".crawl") |> html_text2()
)

# Clean it up -------------------------------------------------------------

starwars |> mutate(
  episode = parse_integer(episode),
  released = parse_date(str_remove(released, "Released: "))
)
