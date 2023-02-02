options(Ncpus = parallel::detectCores(), warn = 1)
# Based on the cool example at ?Startup:
local({
  # set CRAN mirror
  r = getOption("repos")
  r["CRAN"] = "https://cloud.r-project.org"
  options(repos = r)
  # set the width from COLUMNS if set
  cols = Sys.getenv("COLUMNS")
  if (nzchar(cols)) options(width = as.integer(cols))
})
