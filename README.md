# Lecture notes

These lecture notes use the [RtutorialSkeleton/](https://tjmckinley.github.io/RtutorialSkeleton/) templates, but still with some LaTeX specific pieces of code (so won't compile into HTML slides currently). These are mostly around font sizing and the use of `only<>`.

Will aim to amend in a future revision of the skeleton template.

In each `lecture*` folder there is an `R` directory containing R scripts that need to be run in order to create the plots for the slides. Then, e.g.

```
./compile.sh -p lecture1/ -f L1_IntroToStats -b 1
```

will compile beamer slides. The `-c 0` argument can also be used in order to keep the log files in case of errors. The `-h 1` argument creates handout.

Finally, 

```
./compileall.sh
```

will create one uber-set of handouts.

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

