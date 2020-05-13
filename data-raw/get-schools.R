library(rvest)
library(dplyr)

pages <- 0:23
ncaa_url <- "https://www.ncaa.com/schools-index/"
html <- read_html(ncaa_url)

parse_schools <- function(page) {
  new_url <- paste0(ncaa_url, page)
  read_html(new_url) %>%
    html_node("table") %>%
    html_table() %>%
    select(-1) %>%
    mutate(Name = if_else(Name == "", Schools, Name)) %>%
    .$Name %>%
    tolower() %>%
    gsub(" |-", "_", .) %>%
    gsub("[&.,()']", "", .) %>%
    gsub('(_)\\1+', '\\1', .)
}

schools <- unlist(lapply(pages, parse_schools))

cat(paste(schools[1:500], "=", "c()"), sep = ",\n")

cat(paste(schools[501:1159], "=", "c()"), sep = ",\n")
