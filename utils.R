import_example_result <- function(file, redo = FALSE, vwidth = 700, vheight = 400, ...){
  file <- file.path("examples",file)
  webshot <- paste0(xfun::with_ext(file, "png"))
  if (xfun::file_exists(webshot)){
    webshot_time <- file.info(webshot)$mtime
    source_time <- file.info(file)$mtime
    if (source_time > webshot_time) redo <- TRUE
  } else {
    redo <- TRUE
  }
  if (redo){
    output <- rmarkdown::render(file, quiet = TRUE)
    webshot::webshot(url = output, file = webshot, vwidth = vwidth, vheight = vheight, ...)
  }
  knitr::include_graphics(webshot)
}
