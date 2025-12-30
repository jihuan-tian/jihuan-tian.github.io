---
layout: post
title: Use filter-repo to delete large files which are refused by GitHub
date: 2025-09-12
categories: [computer]
tags: [Git]
mathjax: false
---

**Phenomenon** Pushing my local HierBEM Git repository to GitHub is refused because there are files larger than 100 MB in the history commits.

**Solution**

1.  Install the Debian package `git-filter-repo`.

2.  Clone the repository from my local Gitlab.
    
    In the cloned folder, there are only raw Git data, without the working tree. This is because the option `--mirror` implies `--bare` and `--bare` implies `--no-checkout`.

3.  Search files in the repository that are larger than 50 MB
    
    ```bash
    git rev-list --objects --all | git cat-file --batch-check='%(objectname) %(objecttype) %(objectsize) %(rest)' | awk '$3 > 50*1024*1024 {print $1, $3/1024/1024 "MB", $4}' | sort -k2 -nr
    ```
    
    At the moment, there are three large files:
    
    ```text
    8ca8f0088f79eae49e2d69f4a63116a4ce6f7a26 576.983MB tests/laplace-bem-dirichlet-full-matrix/laplace-bem-dirichlet-full-matrix.output
    7a364f1c6b88f07b45bbd4e4fcf1555d2c1e052f 576.983MB tests/laplace-bem-dirichlet-full-matrix/laplace-bem-dirichlet-full-matrix.output
    e8f296b9455d0affa5c9cf063fa4c39faee640e6 384.921MB tests/units/hmatrix-build-from-aca/hmatrix-build-from-aca.output
    af843293ba7fec7dec3b2a3a9a9ae4f7db8e94d8 384.921MB tests/units/hmatrix-build-from-aca-smp/hmatrix-build-from-aca-smp.output
    ```
4.  Filter out the large files from history.
    
    ```bash
    git filter-repo --path tests/laplace-bem-dirichlet-full-matrix/laplace-bem-dirichlet-full-matrix.output --path tests/units/hmatrix-build-from-aca/hmatrix-build-from-aca.output --path tests/units/hmatrix-build-from-aca-smp/hmatrix-build-from-aca-smp.output --invert-paths 
    ```
    
    After running this command, the map from old commit hashes to new ones are stored in the file `filter-repo/commit-map`.

{{ "2025-09-12-use-filter-repo-to-delete-large-files-which-are-refused-by-github" | backlink }}
