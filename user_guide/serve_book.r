# To use this script, start an R sesssion and source it.
# It will open your default browser and let you preview what the
# built book looks like. In principle, it will update just the pages
# that you make live changes to in the editor. In practice, it ends
# up frequently rebuilding everything. It's still a bit easier than
# using "Render_the_book.R" over and over.

# Do installation of missing packages into dev lib
# Should set dev library in .Renviron R_LIBS_USER
# e.g. do the following with the paths changed to your VisionEval Github built environment
# R_LIBS_USER=N:/Git-Repos/VisionEval-built/built/development/%V/ve-lib;N:/Git-Repos/VisionEval-built/dev/lib/%V
# or you can just run this script from within a loaded VisionEval development environment (start
# from Github root)

dev.lib <- grep("/dev/",.libPaths(),value=TRUE)[1]
if ( is.na(dev.lib) ) dev.lib <- .libPaths()[1]
message("Dev library is ",dev.lib)

if ( ! suppressWarnings(require("servr",quietly=TRUE)) ) {
  install.packages("servr", lib=dev.lib, repos="https://cloud.r-project.org", type=.Platform$pkgType )
  require("servr",quietly=TRUE)
}
if ( ! suppressWarnings(require("bookdown",quietly=TRUE)) ) {
  install.packages("bookdown", lib=dev.lib, repos="https://cloud.r-project.org", type=.Platform$pkgType )
  require("bookdown",quietly=TRUE)
}
if ( ! suppressWarnings(require("kableExtra",quietly=TRUE)) ) {
  install.packages("kableExtra", lib=dev.lib, repos="https://cloud.r-project.org", type=.Platform$pkgType )
  require("kableExtra",quietly=TRUE)
}
if ( ! suppressWarnings(require("openxlsx",quietly=TRUE)) ) {
  install.packages("openxlsx", lib=dev.lib, repos="https://cloud.r-project.org", type=.Platform$pkgType )
  require("openxlsx",quietly=TRUE)
}
serve_book(
  dir = ".",
  output_dir = "preview",
  preview = TRUE,
  in_session = TRUE,
  quiet = TRUE 
)
