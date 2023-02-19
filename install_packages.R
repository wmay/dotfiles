#!/usr/bin/Rscript

dev_pkgs = c(
    "devtools",
    "pkgdown",
    "remotes",
    "roxygen2",
    "testthat",
    "tinytest",
    "usethis"
)
util_pkgs = c(
    "BiocManager",
    "bookdown",
    "DT",
    "dygraphs",
    "ggplot2",
    "jsonlite",
    "leaflet",
    "lubridate",
    "magrittr",
    "plotly",
    "rmarkdown",
    # "RPostgreSQL",
    "RSQLite",
    "rticles",
    "rvest",
    "shiny",
    "tidyverse"
)
stats_pkgs = c(
    "forecast",
    "mgcv",
    # "prophet",
    "rjags",
    # "rstan" # requires special compilation flags
)
polisci_pkgs = c(
    "basicspace",
    "oc",
    "pscl",
    "wnominate"
)
install.packages(c(dev_pkgs, util_pkgs, stats_pkgs, polisci_pkgs))

bioc_pkgs = c('graph', 'Rgraphviz')
BiocManager::install(bioc_pkgs)

# see https://github.com/stan-dev/rstan/wiki/Installing-RStan-from-Source#linux
# https://github.com/stan-dev/rstan/wiki/Configuring-C-Toolchain-for-Linux
install_rstan = function() {
  makevars = tempfile()
  writeLines(c('CXX14FLAGS=-O3 -march=native -mtune=native -fPIC', 'CXX14=g++'),
             makevars)
  # not sure this is a good idea due to high memory usage
  # Sys.setenv(MAKEFLAGS = paste0('-j', options('Ncpus')[[1]]))
  Sys.setenv(R_MAKEVARS_USER = makevars)
  on.exit({
    Sys.unsetenv('R_MAKEVARS_USER')
    # Sys.unsetenv('MAKEFLAGS')
    file.remove(makevars)
  })
  try(remove.packages('rstan'))
  try(remove.packages('StanHeaders'))
  if (file.exists('.RData')) file.remove('.RData')
  install.packages('rstan', Ncpus = 1)
}
install_rstan()
