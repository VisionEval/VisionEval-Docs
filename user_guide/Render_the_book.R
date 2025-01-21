# Rendering the VisionEval user's guide
# launch from user_guide.Rproj

depends = c('bookdown', 'downlit', 'data.table', 'openxlsx', 'servr','kableExtra')

for(i in depends){
  if(!i %in% (.packages(all.available=T))){
    install.packages(i, dependencies =TRUE)
  }
}

bookdown::render_book() 

## _bookdown.yml for reference
# book_filename: "user_guide"
# new_session: true  # May want false to support rmd_files in subfolders (e.g. api, module_docs)
# before_chapter_script: _common.R
# delete_merged_file: true
# output_dir: "../docs"
# language:
#   ui:
#     chapter_name: "Chapter "
# rmd_files:
#   - index.Rmd
#   - 01-A-getting-started.Rmd
#   - 01-B-detailed-installation.Rmd
#   - 02-concept-primer.Rmd
#   - 03-tutorial.Rmd
#   - 04-inputs.Rmd
#   - 05-validation.Rmd
#   - 06-verspm.Rmd
#   - 07-vestate.Rmd
#   - 08-verpat.Rmd
#   - 09-estimation.Rmd
#   - 10-build-process.Rmd
#   - 11-api.Rmd
#   - 12-software.Rmd
#   - 20-Topic-Index.Rmd

# shell.exec(file.path(dirname(getwd()), 'docs/index.html'))
