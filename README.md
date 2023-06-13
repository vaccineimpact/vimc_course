# VIMC Course Practicals

For information on how to make changes to these practical notes see [https://github.com/vaccineimpact/vimc_course/blob/main/Materials/updating/updating.pdf](https://github.com/vaccineimpact/vimc_course/blob/main/Materials/updating/updating.pdf).

The code provides a template for R practicals written using the [`bookdown`](https://bookdown.org/) package. The template provides some customised "Task" and "Solution" boxes (amongst other things). To see some examples on how to use this template, see the tutorial skeleton code linked below (or look at examples in the main code):

[https://tjmckinley.github.io/RtutorialSkeleton/](https://tjmckinley.github.io/RtutorialSkeleton/)

You can download, fork and/or clone the repository. The practicals can then be compiled on any platform by loading the `practical.Rproj` file in RStudio and clicking the "Build Book" button in the "Build" pane.

After the build is complete, all necessary files will be included in the `docs` folder which is made as part of the build. If you want to link the PDF document within the HTML gitbook document, then you need to compile the PDF first (but the "Build Book" option described above should do this automatically).

**Note**: compiling the whole repository can be time-consuming. The file `_bookdown.yml` controls which chapters are compiled, and hence commenting out certain lines will prevent certain chapters from being compiled, providing a quick way to make and check changes. Note that you always need the `index.Rmd` file to be included, and the `html` build requires `references.Rmd` to be the final file, and the `latex` build always requires the `ch_appendix.Rmd` to be the final file. You can also set `cache = TRUE` in L5 of the `_setup.Rmd` file to turn on caching. This means that after the initial compilation, chunks will not be re-run unless their code has changed in some way. Hence the practicals can be quickly recompiled after the first time through. **Warning:** caching can cause some unintended side-effects and so it is usually a good idea to turn caching off, and then recompile the whole practical before uploading any final changes to GitHub, or before deployment. To do this simply set `cache = FALSE` in `_setup.Rmd` and and then delete the `_bookdown_files` folder before re-building.

## For admin users: to publish using `gh-pages`

One way to publish this online is to use the `gh-pages` branch on GitHub. 

**Warning:** the following assumes that:

* your source code is in the `main` branch, and that no uncommitted changes exist in the repo;
* that you are compiling from a *fork* of your code as detailed [here](https://github.com/vaccineimpact/vimc_course/Materials/updating/updating.pdf), and that the central repository at [https://github.com/vaccineimpact/vimc_course](https://github.com/vaccineimpact/vimc_course) is stored in a remote called `upstream`;
* that the `main` branch is up-to-date with `upstream/main`.

Firstly, build your document, which should place all files in a `docs` folder. The `_setup.Rmd` file should automatically create a necessary file called `.nojekyll` in the `docs/` folder (this is required to make sure figures render correctly when deployed).

**Assuming that the branch `tempBranch` does not exist**, then on the command line run:

```
git checkout main
git checkout -b tempBranch
git add -f docs
git commit -m "Added docs to repo"
git subtree split --prefix docs -b gh-pages
git push upstream gh-pages --force
```

At this point the page has been deployed, and can be found at:

[https://vaccineimpact.github.io/vimc_course/](https://vaccineimpact.github.io/vimc_course/)

Next, you might want to store a copy of the `docs` folder, since the next set of `git` commands will remove it. On the command line this can be done as:

```
rm docs.zip
zip -r docs.zip docs/
```

Finally, clean up your repo:

```
git checkout main
git branch -D gh-pages tempBranch
```
