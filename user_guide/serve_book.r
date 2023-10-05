if ( ! suppressWarnings(require("servr",quietly=TRUE)) ) {
  install.packages("servr", lib=dev.lib, repos="https://cloud.r-project.org", type=.Platform$pkgType )
  require("servr",quietly=TRUE)
}
if ( ! suppressWarnings(require("bookdown",quietly=TRUE)) ) {
  install.packages("bookdown", lib=dev.lib, repos="https://cloud.r-project.org", type=.Platform$pkgType )
  require("bookdown",quietly=TRUE)
}
serve_book(
  dir = ".",
  output_dir = "preview",
  preview = TRUE,
  in_session = TRUE,
  quiet = TRUE 
)
