
<!-- README.md is generated from README.Rmd. Please edit that file -->

# schoolcolors <img src="man/figures/logo.png" align="right" width="120" />

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/schoolcolors)](https://CRAN.R-project.org/package=schoolcolors)
[![pkgdown build
status](https://github.com/dermcnor/schoolcolors/workflows/pkgdown/badge.svg)](https://github.com/dermcnor/schoolcolors/actions)
<!-- badges: end -->

The goal of schoolcolors is to provide palettes for all possible NCAA
schools. It is built very heavily upon the structure laid out in the
[wesanderson](https://github.com/karthik/wesanderson) package.

## WIP

This is still a Work In Progress. You can’t currently install from CRAN,
and the dev version has only a structure. There are many NCAA schools
and we would love any help that you can for populating the colors for
schools.

The method for populating a school is as follows:

1.  Find School Colors:
      - Search for a school name and color palette. This generally leads
        to a brand site or pdf for that school.
      - Only if there is no branding or web usage site, pull colors from
        [TruColor](http://www.trucolor.net/college-colors-nicknames/college-colors-nicknames-full-index/)
          - The current Institutional Colors should be used.
2.  Populate Colors:
      - Find the line with the school\_name and populate the vector with
        the Primary Colors.
      - If there are any additional colors, put them on a new vector in
        the list and order them according to secondary, tertiary,
        accent, supporting, etc.

### Example: College of William and Mary

  - Initial code
    
    ``` r
    college_of_william_and_mary = list(c())
    ```

  - Populated Colors
    
    ``` r
    college_of_william_and_mary = list(c("#115740", "#B9975B"),
                                       c("#F0B323", "#D0D3D4", "#00B388", "#CAB64B", 
                                         "#84344E", "#64CCC9", "#E56A54", "#789D4A", 
                                         "#789F90", "#5B6770", "#183028", "#00313C"))
    ```

## Installation

You can install the development version from
[GitHub](https://github.com/) by doing the following:

``` r
# install.packages("remotes")
remotes::install_github("dermcnor/schoolcolors")
```

You can install the released version of schoolcolors from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("schoolcolors")
```

## Example

This is a basic example which shows you how to solve a common problem:
Currently this is only the allocation of work for Cris and Myself

``` r
library(schoolcolors)
## basic example code
my_pal <- school_palette("college_of_william_and_mary")
as.character(my_pal)
#>  [1] "#115740" "#B9975B" "#F0B323" "#D0D3D4" "#00B388" "#CAB64B" "#84344E"
#>  [8] "#64CCC9" "#E56A54" "#789D4A" "#789F90" "#5B6770" "#183028" "#00313C"
my_pal
```

<img src="man/figures/README-example-1.png" width="100%" />

## Initial Work Assignment

``` r
library(gh)

set.seed(42)
chunk_size <- 20
schools <- split(names(school_palettes), 
                 ceiling(seq_along(school_palettes) / chunk_size))
school_num <- split(seq_along(school_palettes), 
                    ceiling(seq_along(school_palettes) / chunk_size))
assignee <- sample(c("dermcnor", "cbenge509"), 
                   size = length(schools), 
                   replace = TRUE)
reference_url <- "https://github.com/dermcnor/schoolcolors/blob/07173925ceabcefdadefe25e675dd4a7362feab9/R/school_palettes.R#"

create_issue <- function(issue_num) {
  min_school <- min(school_num[[issue_num]])
  max_school <- max(school_num[[issue_num]])
  title <- paste0("Complete Schools ", min_school, " - ", max_school)
  body <- paste0("## The following schools need to be completed:\n", 
                 paste0("- [ ] ", 
                        schools[[issue_num]], 
                        collapse = "\n"),
                 paste0("\n\n", 
                        reference_url,
                        "L", min_school + 8, "-L", max_school + 8)
                 )
  
  gh("POST /repos/dermcnor/schoolcolors/issues", 
     title = title, 
     body = body,
     assignee = assignee[[issue_num]],
     labels = array("work task"))
  Sys.sleep(5)
}

posting <- lapply(seq_along(schools), create_issue)
```
