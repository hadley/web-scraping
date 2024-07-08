library(rvest)

# Static site -------------------------------------------------------------

html <- read_html("https://www.forbes.com/top-colleges/")
html |> html_elements(".TopColleges2023_tableRow__3IGmk")

# WHERE IS THE DATA???

# Dynamic site ------------------------------------------------------------

html <- read_html_live("https://www.forbes.com/top-colleges/")

# Behind the scenes this runs a real live Chrome browser; you can see it
# if you want. There are also a bunch of commands you can use to simulate
# a human using the site (i.e. if you need to click buttons or type text)
html$view()

rows <- html |> html_elements(".TopColleges2023_tableRow__3IGmk")
rows

# Two alternative techniques that are less reliant on that suspicious
# random suffix
html |> html_elements('[role="row"]')
html |> html_elements('[class^="TopColleges2023_tableRow"]')

rows |> html_element(".TopColleges2023_organizationName__ZAzIv") %>% html_text()
rows |> html_element(".grant-aid") %>% html_text() |> readr::parse_number()


