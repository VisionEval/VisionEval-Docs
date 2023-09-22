# Rendering the VisionEval user's guide
# launch from user_guide.Rproj

depends = c('bookdown', 'downlit', 'data.table', 'openxlsx')

for(i in depends){
  if(!i %in% (.packages(all.available=T))){
    install.packages(i, dependencies =TRUE)
  }
}

bookdown::render_book() 

shell.exec(file.path(dirname(getwd()), 'docs/index.html'))
