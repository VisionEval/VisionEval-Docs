Welcome to the VisionEval User Guide. This user guide is formatted using the [bookdown](https://bookdown.org/) package. Some high-level instructions for updating the user guide are provided here for convenience, however [documentation](https://bookdown.org/yihui/bookdown/) on the bookdown website has more comprehensive instructions on how to interact with bookdown. 

## Editing Book Attributes
Key user guide attributes, such as the title, author, etc. are located and can be edited from the `index.RMD` file.

## Editting a Chapter
Each chapter has a markdown `.RMD` file. Note that the Welcome chapter, or home page, is located in the `index.RMD` file. To edit a chapter users should:

* Edit the chapter markdown `.RMD` file in the main `user_guide` directory
* Set working directory as the main `user_guide` directory
* Build the new book using the `render_book()` function

## Adding a Chapter/Editting Chapter Order
All the chapters in the user guide and the chapter order are defined in the `_bookdown.yml` file. To add a chapter users should:

* Add the chapter as a `.RMD` file in the main `user_guide` directory
* Add the chapter to `_bookdown.yml`
* Set working directory as the main `user_guide` directory
* Build the new book using the `render_book()` function

To edit the chapter order users should:

* Change the chapter numbering in the `.RMD` file name in the main `user_guide` directory
* Change the chapter numbering and order in `_bookdown.yml`
* Set working directory as the main `user_guide` directory
* Build the new book using the `render_book()` function

Additional resources:

The **bookdown** book: https://bookdown.org/yihui/bookdown/

The **bookdown** package reference site: https://pkgs.rstudio.com/bookdown
