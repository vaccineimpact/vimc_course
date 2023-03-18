# RtutorialSkeleton

This provides a template for R practicals written using the `bookdown` package. The template provides some customised "Task" and "Solution" boxes amongst other things. To see some examples on how to use this template, see here:

[https://tjmckinley.github.io/RtutorialSkeleton/](https://tjmckinley.github.io/RtutorialSkeleton/)

You can download or clone the repository and then compile the project. This can be done on any platform by loading the "skeleton.Rproj" file in RStudio. The "Build Book" button in the "Build" pane can be used to compile the practical.

> **Note that there is an example `_build.sh` bash script that automates this process that can be used as a template.**

After the build is complete, all necessary files will be included in the `docs` folder which is made as part of the build. If you want to link the PDF document within the HTML gitbook document, then you need to compile the PDF first. After compilation, the file `index.html` contains examples on how to use the template.

## To publish using `gh-pages`

One way to publish this online is to use the `gh-pages` branch on GitHub. **The following assumes that your source code is in the `main` branch, and that no uncommitted changes exist in the repo. You have been warned!**

Firstly, build your document, which should place all files in a `docs` folder. Then, copy the file `.nojekyll` into `docs/` (this is required to make sure figures render correctly when deployed).

**Assuming that the branch `tempBranch` does not exist**, then on the command line run:

```
git checkout main
git checkout -b tempBranch
git add -f docs
git commit -m "Added docs to repo"
git subtree split --prefix docs -b gh-pages
git push origin gh-pages --force
```

At this point the page has been deployed, and can be found at `https://USERNAME.github.io/REPONAME/`, where `USERNAME` and `REPONAME` should be replaced appropriately. You can see this deployment here:

[https://tjmckinley.github.io/RtutorialSkeleton/](https://tjmckinley.github.io/RtutorialSkeleton/)

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

