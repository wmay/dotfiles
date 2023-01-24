options(Ncpus = parallel::detectCores(),
        warn = 1)
# From the cool example at ?Startup:
local({
  # set the width from COLUMNS if set
  cols = Sys.getenv("COLUMNS")
  if(nzchar(cols)) options(width = as.integer(cols))
})
