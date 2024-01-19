# Getting Started

## Overview

This page explains how to obtain the VisionEval software and install it, and
provides a brief overview of what to do with it after it is installed. Please
look at the Concept Primary to learn how VisionEval can support scenario
planning and help develop strategies to manage transportation system
performance.

The [Concept Primer](#concept-primer) and the [VisionEval Tutorial](#tutorial)
found later in this book contain more complete details on setting up VisionEval
models with local data, running scenarios, and extracting and analyzing results.

-   [Installation and Setup](#installation-and-setup)

-   [Workflow](#workflow-of-visioneval)

-   [Editing and Running Models](#editing-and-running-models)

-   [Getting Results](#running-and-extracting-results)

-   [Using the Walkthrough](#using-the-walkthrough)

VisionEval runs within the R Statistical Environment on any system for which R
is available. There are two paths to installing VisionEval:

1.  **Install from the stand-alone Windows installer**:

    1.  [Download a zipped
        folder](https://visioneval.org/category/download.html) from the
        VisionEval website for a specific version of R.  
        This is the simplest way to quickly get VisionEval on your computer.

2.  **Copy or clone the system code repository**:

    1.  If you area a Mac/Linux user, or if you are interested in contributing
        to the development of VisionEval modules, models, framework, or
        visualizer, choose this path.

    2.  The most recent stable release is hosted at [VisionEval on
        **GitHub**](https://visioneval.github.io). Development releases are
        available at
        [VisionEval-dev](https://visioneval/VisionEval-Dev/releases). Once you
        have downloaded or cloned one of the VisionEval repositories, you will
        need to build it before you can run it.

Detailed setup instructions on setting up the VisionEval runtime, or building VisionEval from the source code, can be
found in on the [Detailed Installation Instructions](#detailed-installation) page.

## Installation and Setup

#### Pre-requisites

You will need:

-   [R, at least version 4.1.3](https://cran.r-project.org)

-   [RStudio](https://www.rstudio.com/products/rstudio/download/)

Once you have R and RStudio installed, you can retrieve the VisionEval
installer itself. RStudio is optional. Read on for information about
how to run VisionEval within the base R GUI.

#### Installer

[Get VisionEval Here](https://visioneval.github.io/category/download.html)

*Note: 580 Mb download! Pick the version corresponding to your R installation
(4.1.3, 4.2.3, 4.3.2, etc).*

The link above will download a .zip file containing the following:

-   The VisionEval framework code and sample models

-   All necessary R packages

-   Documentation (both this book as well as API documentation)

Unzip that file into an empty folder of your choice (e.g. `C:\VisionEval`).

#### Completing the Installation

To complete the installation and start VisionEval, do this:

1.  Navigate to the folder into which you unzipped the installer:

2.  Double-click `VisionEval.Rproj`

RStudio will start, and VisionEval will load. You should see a message
similar to the following in the RStudio Console:

```
Loading VisionEval for R4.3.2
Loading required package: VEModel
Welcome to the new VisionEval!
Running in C:/VisionEval
```

If the `VisionEval.Rproj` file does not open RStudio when you double-click it,
you can start RStudio directly, then choose `File / Open Project...` and get to
the same place. By default, RStudio remembers the project you last loaded, so
having done that once you should get back to VisionEval each time you start
RStudio (unless you work on a different project).

#### Starting VisionEval Manually

If you need to start VisionEval manually for some reason, just start RStudio (or
even plain R), change into your installation folder using

-   RStudio's `Session / Set Working Directory...` menu option, or

-   In plain R, the `File / Change dir...` menu option, or the `setwd` command
    on the R command line.

Then run this instruction to start VisionEval:

```
source("VisionEval.R")
```

#### Starting VisionEval from the RGUI

RStudio is not mandatory for using VisionEval. It is also possible to run
VisionEval within the RGUI that comes with R. You will need to do that if you
have no administrative rights on your machine, since RStudio requires
administrative permissions to install.

To run without RStudio, double-click the `launch.bat` batch file (from Windows Explorer).

If you have installed R manually, you may need to set the R_HOME environment variable for `launch.bat` to work. You'll
know if that's a problem if you get a message about the wrong version or R, or a batch file message saying that R cannot
be found, or a Window briefly opens and then shuts without starting R.

To find the proper value for R_HOME, start the version of R for which you have
installed VisionEval (it should be on the Windows start menu even if you did a
non-administrative installation). Then run this R command:

```R
R.home()
```

You get a string that should look something like this:

```
[1] "C:/PROGRA~1/R/R-43~1.2"
```

You want to copy the part inside the quotes that says `C:/PROGRA~1/R/R-43~1.2`

Put that value into a
[User Environment Variable](https://learn.microsoft.com/en-us/windows/win32/shell/user-environment-variables)
called `R_HOME` or you can edit it into `launch.bat` itself by replacing the default R_HOME value in that file. Edit
`launch.bat` with a text editor (or - ugh - Notepad) and it should be reasonably obvious what to do.

If `launch.bat` is working, an RGUI instance should open and you should see the same startup message that appears in RStudio:

```
Loading VisionEval for R4.3.2
Loading required package: VEModel
Welcome to the new VisionEval!
Running in C:/VisionEval
```

## Workflow of VisionEval

VisionEval models and the underlying software framework are written in the
[R programming language](https://www.r-project.org) for statistical computing and graphics. The purpose of the model
system and framework is to enable models be created in a plug-and-play fashion from modules that are distributed as R
packages. A simple R script is used to implement a model by initializing the model environment and then calling modules
successively. Scenarios are then constructed through a set of files that provide variant model inputs for evaluation and
comparison.

To use VisionEval to evaluate scenarios, there are several elements that users
need to set up:

1.  Select and install one of the [VisionEval
    models](https://github.com/VisionEval/VisionEval/wiki/VisionEval-Models),
    customizing it as needed:

    1.  [VERSPM](https://github.com/VisionEval/VisionEval-Dev/blob/readme-dev/docs/tutorials/verspm/Main.md)
        – Regional Strategic Planning Model

    2.  [VERPAT](https://github.com/VisionEval/VisionEval/wiki/VERPAT-Tutorial-Overview)
        – Rapid Policy Analysis Tool

    3.  [VE-State](https://github.com/VisionEval/VisionEval/wiki/VE-State-Status)
        – VisionEval State-Level Model

2.  Develop a *Base Model* for the region under analysis. The Base Model
    specifies:

    1.  **Model Geography** (zone structure), reported as Marea (metropolitan
        area), AZones (county-sized), and BZones (often census-tract-sized or
        could be related to Traffic Analysis Zones in other travel demand
        models) and related configuration files

    2.  **Base and Future Years** to be evaluated for each scenario (e.g., 2019
        and 2050)

    3.  **Local Data Files** describing Base Scenario conditions in the region
        (including both observed base year data, and estimates of future year
        conditions with no scenario policies applied)

3.  Develop variant *Future Actions* and *Scenarios*, by adjusting specific
    input elements for the Future Years. VisionEval models support having many
    different scenarios. See the scenario development chapter later in this book
    for details.

4.  Run the model to process each of its scenarios.

5.  Extract or query the results for summarization and further analysis in R or
    export tabular data files to other data analysis systems.

These steps are described on other pages of this documentation.

## Editing and Running Models

As described in the [model tutorials](#visioneval-tutorials), a VisionEval Model
contains the following components:

-   Model configuration: `visioneval.cnf`

-   The model script file, typically called `run_model.R` (sometimes in a
    `/scripts` sub-folder), which describes the steps that will be performed
    when the model runs

-   Global parameters describing the model geography, preferred data units, and
    currency conversion deflators in the `/defs` sub-folder

-   Base Model Input data in the `/inputs` sub-folder

-   Pre-defined query scripts (in the `/queries` sub-folder) that can extract
    useful metrics from the model scenarios once they have run

-   Additional optional folders for the model scenarios (either as top-level
    directories or within the `/scenarios` sub-folder, which describe
    deviations from the Base Model). Scenarios may have different
    inputs or a different model script.

Once any of the model scenarios have been run, the model will also have a
`/results` sub-folder. After queries have been run or raw results extracted into
a tabular data format like `.csv`, there will be a sub-folder within `/results`
called `/output`.

See the tutorial chapters later in this book for instructions on how to set up
VisionEval for your study area. Typically, you will start by installing one of
the standard models and then adjusting `visioneval.cnf`, `/defs` and `/inputs`
to complete your Base Model. Once you have completed the Base Model, you
can add scenarios to your model (as described later) by varying a few inputs to
describe alternate future conditions.

## Running VisionEval Models

VisionEval includes a simple R command-line interface for running models and
extracting their results.

The tutorials later in this book will explain how to select and customize one of
the VisionEval models, as well as how to develop inputs and create scenarios for
your area.

Once you have received the `Welcome to the new VisionEval!` message, you can try
things out by copying or entering the following instructions into the R Console
window:

```
rspm <- installModel("VERSPM")
rspm$run()
results <- rspm$results()
results$export()
query <- rspm$query("Full-Query")
query$run()
query$export()
```

The instructions will do the following:

-   Install the sample VisionEval RSPM (Regional Strategic Planning Model)

    -   The model has data from the small Rogue Valley MPO in Oregon

    -   The model is installed in `VisionEval/models/VERSPM-base`

    -   You can re-open the model later by using this instruction;

        ```
        rspm <- openModel("VERSPM-base")
        ```

-   Run the model

    -   The results are placed in `VisionEval/models/VERSPM-base/results`

    -   The results are in a difficult internal R format, so you’ll want to
        export them into something more useful for subsequent analysis.

-   Export the model results into several files in a friendly text table format
    (.csv) that you can open with Excel or a text editor

    -   The CSV files are placed in a dated subfolder of
        `VisionEval/models/VERSPM-base/results/outputs`

    -   You can export the results into an SQLite database (created in the
        `outputs` folder) by using this export instruction:

        ```
        rspm$export("sql")
        ```

-   Run a set of basic queries to report summary model performance metrics

    -   When exported, those metrics appear in .csv files in another subfolder of
        `VisionEval/models/VERSPM-base/results/outputs`
    -   By default, the query output file has one row per metric and one column per
        model scenario.

## Using the Walkthrough

Additional features of the VisionEval R interface are somewhat systematically explored in commented R scripts located in
the VisionEval runtime `VisionEval/walkthrough` folder. The walkthrough files are most easily explored using RStudio.

Once you have seen the message "Welcome to the new VisionEval", you can set up
the walkthrough by running this instruction:

```
walkthrough()
```

The walkthrough will create a special runtime directory (within your main
runtime folder), so nothing you do while trying it out will affect any of your
"real" models, which will remain untouched in your "models" directory.

To explore any of the walkthrough scripts:

-   Open the script in the RStudio script editor by navigating in the RStudio
    "Files" pane to the VisionEval/walkthrough directory, then double-clicking
    one of the scripts.

-   Select individual lines in script editor and press "Enter" to run that line
    in the console. You should run the lines in order ("walk through them") and
    not skip any! The commented lines (starting with “\#” describe what is going
    on).

If things get messed up because you didn't run the walkthrough lines in order,
it's usually enough to back up and run the lines you skipped. If you need to,
you can reset the walkthrough by starting it like this:

```
walkthrough(reset=TRUE)
```

Be careful: the "reset=TRUE" instruction will clear the walkthrough runtime.
Anything you saved there (including outputs from running and exporting the test
models) will be lost. Your regular runtime models directory will remain
untouched.

Here is an overview of the walkthrough files and what you will learn from each
of them:

-   `00-walkthrough.R` : Master list of walkthrough scripts (nothing specific to
    run here - it's just a script listing the other scripts)

-   `01-install.R` : How to install various VisionEval model sample from the packaged
    examples

-   `02-running.R` : Running (or re-running) a VisionEval model

-   `03-extract.R` : Getting raw results (or a subset) from a VisionEval model

-   `03A-advanced-export.R` : Exporting to other file formats (SQL or Excel)

-   `04-scenarios.R` : Working with model scenarios - this is about running them,
    not setting them up

-   `05-queries.R` : How to run queries to generate summary metrics of model results
    (including sets of scenarios)
