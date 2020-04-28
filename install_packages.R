dev_pkgs = c(
    "devtools",
    "remotes",
    "roxygen2",
    "testthat",
    "usethis"
)
util_pkgs = c(
    "bookdown",
    "DT",
    "dygraphs",
    "ggplot2",
    "jsonlite",
    "leaflet",
    "lubridate",
    "magrittr",
    "plotly",
    "reshape2",
    "rmarkdown",
    "RPostgreSQL",
    "rticles",
    "rvest",
    "shiny",
    "tidyverse"
)
stats_pkgs = c(
    "forecast",
    "mgcv",
    "prophet",
    "rjags",
    "rstan"
)
polisci_pkgs = c(
    "basicspace",
    "oc",
    "pscl",
    "wnominate"
)
install.packages(c(dev_pkgs, util_pkgs, stats_pkgs, polisci_pkgs))
