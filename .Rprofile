options(Ncpus = parallel::detectCores(), warn = 1)
# Based on the cool example at ?Startup:
local({
  # set CRAN mirror. See
  # https://packagemanager.rstudio.com/client/#/repos/2/overview
  options(repos = c(posit = 'https://packagemanager.rstudio.com/cran/__linux__/jammy/latest'))
  # Get linux binary packages. See
  # https://docs.posit.co/rspm/admin/serving-binaries/#binary-user-agents
  options(HTTPUserAgent = sprintf("R/%s R (%s)", getRversion(),
                                  paste(getRversion(), R.version["platform"],
                                        R.version["arch"], R.version["os"])))
  # set the width from COLUMNS if set
  cols = Sys.getenv('COLUMNS')
  if (nzchar(cols)) options(width = as.integer(cols))
})

if (interactive()) {
  local({
    # Suggest updating packages periodically
    update_log = path.expand('~/.Rupdatelog.rds')
    update_interval = 14
    update_needed = !file.exists(update_log) ||
      Sys.Date() - readRDS(update_log) > update_interval
    if (update_needed) {
      if (nzchar(Sys.getenv('INSIDE_EMACS'))) {
        # I can't answer prompts from here in emacs
        message(
"**Consider updating packages.** To update, run
update.packages(ask = 'graphics')
saveRDS(Sys.Date(), path.expand('~/.Rupdatelog.rds'))
"
        )
      } else {
        utils::update.packages(ask = 'graphics', instlib = .libPaths()[1])
        saveRDS(Sys.Date(), update_log)
      }
    }
  })
}
