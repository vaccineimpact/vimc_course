# skeleton_Rmd

This provides a template for R practicals written using the `bookdown` package. The template provides some customised "Task" and "Solution" boxes. To see some examples on how to use this template, download or clone the repository and then compile the project. This can be done on any platform by loading the "skeleton.Rproj" file in RStudio. The "Build Book" button in the "Build" pane can be used to compile the practical. 

After the build is complete, all necessary files will be included in the `docs` folder which is made as part of the build. If you want to link the PDF document within the HTML gitbook document, then you need to compile the PDF first. After compilation, the file `index.html` contains examples on how to use the template.

## Usage

Basically a standard Bookdown template with a few tweaks. New chapters need to be in separate '.Rmd' files, where each file starts with a chapter heading as seen [here](https://bookdown.org/yihui/bookdown/usage.html). In order to use the task and solution blocks in LaTeX, you must input the order of the files into the `_bookdown.yml` file, and the first file must be called `index.Rmd` e.g.

```
rmd_files:
    html: ['index.Rmd', 'ch1.Rmd']
    latex: ['index.Rmd', 'ch1.Rmd', 'ch_appendix.Rmd']
output_dir: "docs"
```

The `latex:` path above ***must*** have `'ch_appendix.Rmd'` as its last entry. This ensures that the appendix is properly formatted for the solutions to the problems.

There are a couple of useful special blocks. A `task` block, and a `solution` block. These can be used as e.g.

````
```{task}
Here is a task written in **markdown**.
```
````

To see how this renders, please compile the template and open "docs/index.html".

You can include chunks within the `task` chunk, but you need to use double backticks *within* the chunk, and leave carriage returns around the internal chunk e.g.

````

```{task}

``{r}
x <- 2 + 2
x
``

```

````

Again, to see how this renders, please compile the template.

Be careful to have suitable carriage returns around e.g. `enumerate` or `itemize` environments inside the chunk also. For example:

````

```{task}
Here is a list:
1. item 1
2. item 2
```

```` 

will not render nicely. But

````

```{task}
Here is a list:

1. item 1
2. item 2

```

```` 

will.

The `solution` chunk works in the same way, and the numbers will follow the previous `task` chunk (so you can set tasks without solutions) e.g.

````

```{task}
Add 2 and 2 together
```

```{solution}

``{r}
2 + 2
``

```

````

### Tabbed boxed environments

Originally developed to put base R and `tidyverse` solutions side-by-side, using a `multCode = T` option to the solution box. Here the two tabs are separated by four consecutive hashes: `####`, and the `titles` option gives the tab titles (these can be set globally if preferred) e.g.

````

```{task}
Filter the `iris` data by `Species == "setosa"` and find the mean `Petal.Length`.
```

```{solution, multCode = T, titles = c("Base R", "tidyverse")}`r ''`

``{r}
## base R solution
mean(iris$Petal.Length[
    iris$Species == "setosa"])
``

####

``{r}
## tidyverse solution
iris %>% 
    filter(Species == "setosa") %>%
    select(Petal.Length) %>%
    summarise(mean = mean(Petal.Length))
``
    
```

````

Note that there is also a `multCode` chunk that does not link to task and solution boxes e.g.

````

```{multCode}

Two options: 

* Option 1

####

Two options:
    
* Option 2

```

````

The `titles` option can be set as before.

## To publish using `gh-pages`

One way to publish this online is to use the `gh-pages` branch on GitHub. **The following assumes that your source code is in the `master` branch, and that no uncommitted changes exist in the repo. You have been warned!**

Firstly, build your document, which should place all files in a `docs` folder. Then, copy the file `.nojekyll` into `docs/` (this is required to make sure figures render correctly when deployed).

**Assuming that the branch `tempBranch` does not exist**, then on the command line run:

```
git checkout master
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
git checkout master
git branch -D gh-pages tempBranch
```

