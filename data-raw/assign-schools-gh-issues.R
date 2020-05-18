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
