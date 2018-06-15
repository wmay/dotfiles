basic_packages = c(
    'tidyverse',
    "devtools", "roxygen2", # package development tools
    "rmarkdown", 'rticles', # generate PDFs
    ## "rstan", "rjags", # Bayesian modeling
    ## "testthat", # unit testing
    ## "shiny", # web server
    "pscl", "basicspace", "wnominate", "rsunlight" # poli sci
)
install.packages(basic_packages)

# gEcon
## install.packages(c("Matrix", "MASS", "nleqslv", "Rcpp"))
# download package from here:
# http://gecon.r-forge.r-project.org/download.html
# install with `R CMD INSTALL gEcon_x.x.x.tar.gz`

# Bayesian Macroeconomics in R
## install.packages(c("RcppArmadillo", "ggplot2", "doParallel"))
## library(devtools)
## install_github("kthohr/BMR")
