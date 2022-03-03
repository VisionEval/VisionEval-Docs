--- 
title: "VisionEval User Guide"
author: "VisionEval Pooled Fund Team"
date: "2022-03-01"
site: bookdown::bookdown_site
documentclass: book
bibliography: [book.bib, packages.bib]
# url: your book url like https://bookdown.org/yihui/bookdown
# cover-image: path to the social sharing image like images/cover.jpg
description: |
  This is a minimal example of using the bookdown package to write a book.
  The HTML output format for this example is bookdown::gitbook,
  set in the _output.yml file.
link-citations: yes
github-repo: rstudio/bookdown-demo
---

# Welcome {-}

This book contains end user documentation for the VisionEval modeling system.

## About VisionEval {-}

[insert intro text]

## How to Use this Guide {-}

This guide contains a diversity of information intended for different audiences interacting with the VisionEval system. Use the list below to try to identify what kind of user you are and the sections of this guide that will serve the best starting points.

**Decision-maker & semi-technical planner:** You are wanting to apply the VisionEval system and want a high-level overview but not the technical details.

- [Concept Primer](#intro): An overview of the concepts underlying the VisionEval modeling system, intended for a non-technical audience

**Model applier:** You are wanting to learn about the VisionEval system and implement a model application.

- [Getting Started][Getting Started]: Instructions on how to get VisionEval installed and running
- [VisionEval Models][VisionEval Models]: Technical background on VisionEval, overview of main components, and how it works
- [Concept Primer](#intro): An overview of the concepts underlying the VisionEval modeling system, intended for a non-technical audience
- Tutorials: Comprehensive tutorial materials on the [VERSPM](#verspm), [VERPAT](#verpat), and [VEState](#vestate) models

**Developer:** You are a developer or researcher and want to make contributions to the VisionEval system.

- [Developer Documentation](#developer)


```r
bookdown::serve_book()
```


