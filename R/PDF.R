PDF <- function(file, ..., width=7, height=7) {
  #' start pdf if non-interactive
  #' saves some global variable to be used by mysimtools::dev.copy2pdf()
  if(!interactive()) pdf(file=file, ..., width=width, height=height)
  assign(".pdf.file", file, envir=.GlobalEnv)
  assign(".pdf.height", height, envir=.GlobalEnv)
  assign(".pdf.width", width, envir=.GlobalEnv)
}