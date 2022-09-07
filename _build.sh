#!/bin/sh

Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::pdf_book')"
Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::gitbook')"

## copy nojekyll file and data
cp .nojekyll docs
cp data/Rubella-UK.csv docs
cp ../lectures/lecturenotes.pdf docs
