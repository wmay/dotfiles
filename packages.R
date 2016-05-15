basic_packages = c(
    "rvest", # web scraper
    "pbapply", "beepr", # progress bars and helpful beeps
    "dplyr", "reshape2", "lubridate", "stringr", # data munging
    "haven", "jsonlite", # data sources
    "ggplot2", "scales", # nice graphs
    "devtools", "roxygen2", # package development tools
    "rmarkdown", # generate PDFs
    "rstan", "rjags", # Bayesian modeling
    "testthat", # unit testing
    "snow", "foreach", # parallel computing
    "shiny", # web server
    "data.table", # large data
    "pscl", "basicspace", "wnominate", "rsunlight",
    "MCMCpack", "emIRT", # politics
    "quantmod", "vars", # economics
    "car", "plm", "forecast", # econometrics
    "twitteR", # social media
    "igraph", # network analysis
    "sp", "spdep", "rgdal", # spatial tools
    "ggmap", "maptools", "choroplethr", # maps
    "pracma", "modeest", # numerical methods
    "RMySQL", "RPostgreSQL", "RSQLite", # databases
    "neuralnet", "caret", # machine learning
    "yuima" # stochastic differential equations
)
install.packages(basic_packages)

for_topic_modeling = c("tm", "slam", "topicmodels", "SnowballC")
install.packages(for_topic_modeling,
                 repos="http://cran.us.r-project.org")

# gEcon
install.packages(c("Matrix", "MASS", "nleqslv", "Rcpp"))
# download package from here:
# http://gecon.r-forge.r-project.org/download.html
# install with `R CMD INSTALL gEcon_x.x.x.tar.gz`

# Bayesian Macroeconomics in R
install.packages(c("RcppArmadillo", "ggplot2", "doParallel"))
library(devtools)
install_github("kthohr/BMR")
