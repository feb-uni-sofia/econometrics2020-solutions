require('ggplot2')
require('dplyr')
require('readr')

fmt <- function(x, dec = 2) {
  sprintf(paste("%.", dec, "f", sep = ""), x)
}

fmtTable <- function(x, caption, ...) {
  isHTML <- knitr::is_html_output()

  formattedTable <- knitr::kable(
    x,
    caption = caption,
    # format=ifelse(isHTML, "html", "latex"),
    ...
  )

  if (isHTML) {
    return(formattedTable %>%
             kableExtra::kable_styling(bootstrap_options = "striped", full_width = FALSE))
  }

  formattedTable
}

