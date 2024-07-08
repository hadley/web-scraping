# Web scraping with rvest (UseR 2024)

In this tutorial, you'll learn the basics of web scraping with R, using the rvest package. We'll discuss the basic structure of an HTML page, and how to find the elements your interested in with selectorgadget or the browser's developer tools. You'll then learn how to programmatically extract with rvest, turning web pages into tidy data frames.

Bonus content includes scraping multiple pages (with rvest and httr2), scraping dynamic sites where content is generated with JavaScript, extracting data from unofficial APIs, and some hints on using LLMs.

[Slides](rvest.pdf)

## Requirements

To run the code at home, install the following pakages:

```R
# install.packages("pak")
pak::pak(c("tidyverse", "chromote"))
```

To run the live web-scraping code you'll also need a copy of [Chrome](https://www.google.com/chrome/) installed on your computer.
