# Web scraping with rvest (NICAR 2024)

In this tutorial, you'll learn the basics of web scraping with R, using the rvest package. We'll discuss the basic structure of an HTML page, and how to find the elements your interested in with selectorgadget or the browser's developer tools. You'll then learn how to programmatically extract with rvest, turning web pages into tidy data frames.

We'll also touch on scraping multiple pages, using a combination of httr2 to downloading many pages at once, then purrr to parse them and extract the values you care about.

[Slides](rvest.pdf)

## Requirements

To run the code at home, install the following pakages:

```R
# install.packages("pak")
pak::pak(c("tidyverse", "chromote"))
```

To run the live webscraping code you'll also need a copy of chrome installed on your computer.
