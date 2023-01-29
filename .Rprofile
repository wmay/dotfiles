options(Ncpus = parallel::detectCores(), warn = 1)
# Based on the cool example at ?Startup:
local({
  # set the width from COLUMNS if set
  cols = Sys.getenv("COLUMNS")
  if (nchar(cols)) {
    cols = as.integer(cols)
    # Emacs exaggerates the number of columns available, because the last column
    # is used for the line-wrapping symbol, and that can make printing ugly
    if (nchar(Sys.getenv("INSIDE_EMACS"))) cols = cols - 1
    options(width = cols)
  }
})
