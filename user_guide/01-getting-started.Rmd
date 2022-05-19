# Getting Started

## Overview

This page explains how to obtain the VisionEval software and install it, and provides a brief tour
of how the system can used to support scenario planning, and to develop strategies to manage
transportation system performance.

The remainder of this page explains how to install VisionEval, and provides a brief overview of what
to do with it after it is installed. Complete details on setting up VisionEval models and scenarios,
running the models, and extracting and analyzing results are found later in this book. ** Links to
other pages in the book?? **

-   [Installation and Setup](#installation)
-   [Workflow](#workflow)
-   [Editing and Running Models](#editrun)
-   [Getting Results](#results)

<a name='installation'>Installation and Setup</a>
-------------------------------------------------

VisionEval runs within the R Statistical Environment on any system for which R is available. There
are two paths to installing VisionEval:

1.  **Install from the stand-alone Windows installer**:

    + **[Download a zipped folder](https://visioneval.org/category/download.html)** from the VisionEval website for a specific version of R.\
        This is the simplest way to quickly get VisionEval on your computer.
<br/><br/>

2.  **Copy, clone or 'fork' the system code repository**:

    + If you area a Mac/Linux user, or if you are interested in contributing to the development of
      VisionEval modules, models, framework, or visualizer, choose this path.

    + The most recent stable release is hosted at [VisionEval on
      **Github**](https://VisionEval/VisionEval). Development releases are available at
      [VisionEval-dev](https://VisionEval/VisionEval-Dev). Once you have downloaded or cloned one of
      the VisionEval repositories, instructions for building a runtime are found in
      `build/Building.md` (or you can locate that file in the repository to preview it).

    + Detailed instructions on obtaining the system code can be found later in this manual.

### Install for Windows

#### Pre-requisites

You will need:

   - [R, at least version 4.1.2](https://cran.r-project.org)
   - [RStudio](https://www.rstudio.com/products/rstudio/download/ "Download RStudio")

Once you have R and RStudio installed, you can retrieve the VisionEval
installer itself:

#### Installer

***[Get VisionEval Here](https://github.com/VisionEval/VisionEval-Dev/releases)***

<!-- Eventually: https://github.com/VisionEval/VisionEval/releases/download/v2.0.0/VE-installer-Windows-R4.0.3-latest.zip) -->

*Note: 530 Mb download! Packaged for R 4.1.2*

The link above will download a .zip file containing the following:

  - The VisionEval framework code and sample models
  - All necessary R packages
  - **?? Documentation (this Getting Started document) ??**

Unzip that file into an empty folder of your choice (e.g. `C:\VisionEval`).

#### Completing the Installation

After installing R 4.1.2 (or the version of R corresponding to the installer you are retrieving) and
RStudio, unzip the VisionEval installer into an empty destination folder of your choice.

To complete the installation and start VisionEval, do this:

1. Navigate to the folder into which you unzipped the installer:
2. Double-click **``VisionEval.Rproj``**

RStudio will start, and the VisionEval will load. You should see a message similar to the following
in the RStudio Console:

```
Loading VisionEval for R4.1.2
Loading required package: VEModel
Welcome to the new VisionEval!
Running in C:/VisionEval
```

If the `VisionEval.Rproj` file does not open RStudio when you double-click it,
you can start RStudio directly, then choose `File / Open Project...` and get
to the same place. By default, RStudio remembers the project you last loaded,
so having done that once you should get back to VisionEval each time you start
RStudio (unless you work on a different project).

#### Starting VisionEval Manually<a name='changedir'></a>

If you need to start VisionEval manually for some reason, just start
RStudio (or even plain R), change into your installation folder using

  - RStudio's `Session / Set Working Directory...` menu option, or
  - In plain R, the `File / Change dir...` menu option, or the `setwd` command on the R command line.

Then run this instruction to start VisionEval:

    source("VisionEval.R")

Alternatively, you can double-click `launch.bat` to start VisionEval within the standard R Graphical
User Interface (`RGUI`).

<a name='workflow'>Workflow of VisionEval</a>
---------------------------------------------

VisionEval models and the underlying software framework are written in
the [R programming language](https://www.r-project.org) for statistical
computing and graphics. The purpose of the model system and framework is
to enable models be created in a plug-and-play fashion from modules that
are distributed as R packages. A simple R script is used to implement a
model by initializing the model environment and then calling modules
successively. Scenarios are then constructed through a set of files that
provide variant model inputs for evaluation and comparison.

To use VisionEval to evaluate scenarios, there are several elements that
users need to set up:

1.  Select and install one of the [VisionEval
    models](https://github.com/VisionEval/VisionEval/wiki/VisionEval-Models),
    customizing it as needed:

    -   **[VERSPM](https://github.com/VisionEval/VisionEval-Dev/blob/readme-dev/docs/tutorials/verspm/Main.md)**
        – Regional Strategic Planning Model
    -   **[VERPAT](https://github.com/VisionEval/VisionEval/wiki/VERPAT-Tutorial-Overview)**
        – Rapid Policy Analysis Tool
    -   **[VE-State](https://github.com/VisionEval/VisionEval/wiki/VE-State-Status)**
        – VisionEval State-Level Model

    <br/>
    Instructions and tutorials for configuring these models are presented in the model-specific
    tutorials elsewhere in [this book](https://visioneval.org/book), which is your entry point to a wealth of
    documentation on the VisionEval models. 

2.  Develop a *Base Model* for the region under analysis. The Base Model specifies:
    -   **Model Geography** (zone structure), reported as Marea (metropolitan area), AZones
        (county-sized), and BZones (census-tract-sized) and related configuration files
    -   **Base and Future Years** to be evaluated for each scenario (e.g. 2019 and 2050)
    -   **Local Data Files** describing Base Scenario conditions in the region (including both
        observed base year data, and estimates of future year conditions with no scenario policies
        applied)

    <br/>

3. Develop variant *Future Actions* and *Scenarios*, by adjusting specific input elements for the
   Future Years. VisionEval models support having many different scenarios. See the scenario
   development chapter later in this book for details.

4. Run the model to process each of its scenarios

5. Extract or query the results for summarization and further analysis in R or export tabular data
   files to other data analysis systems.

Editing and Running Models
--------------------------

As described in the model tutorials, a VisionEval Model contains the following components:

- Model configuration: `visioneval.cnf`
- The model script file, typically called `run_model.R` (sometimes in a `/scripts` sub-folder), which describes the steps that
  will be performed when the model runs
- Global parameters describing the model geography, preferred data units, and currency conversion deflators in the `/defs` sub-folder
- Base Model Input data in the `/inputs` sub-folder
- Pre-defined query scripts (in the `/queries` sub-folder) that can extract useful metrics from the model scenarios once they have run
- Additional optional folders for the model scenarios (either as top-level directories or within the `/scenarios` sub-folder, which describe
  how that scenario various from the Base Model. Scenarios may have some different inputs or a different model script.

Once any of the model scenarios have been run, the model will also have a `/results` sub-folder.
After queries have been run or raw results extracted into a tabular data format like `.csv`, there
will be a sub-folder within `/results` called `/output`.

See the tutorial chapters later in this book for instructions on how to set up VisionEval for your
local area. Typically, you will start by installing one of the standard models and then adjusting
`visioneval.cnf`, `/defs` and `/inputs` to complete your local Base Model. Once you have completed
the Base Model, you can add scenarios to your model (as described later) by varying a few inputs to
describe alternate future conditions.

### End User Interface

VisionEval includes a simple R command-line interface for running models and extracting their results.

The tutorials later in this book will explain how to select and customize one of the VisionEval
models, as well as how to develop inputs and create scenarios for your area.

Once you have received the `Welcome to the new VisionEval!` message, you can try things out by
copying or entering the following instructions into the R Console window. They will install the sample
VisionEval RSPM (Regional Strategic Planning Model) with inputs for the small Rogue Valley MPO in
Oregon, run the models, dump the model results into a text table (.csv format), and run a set of
basic queries to report model performance metrics.

``` 
rspm <- installModel("VERSPM")
rspm$run()
results <- rspm$results()
results$export()
query <- rspm$query("Full-Query")
query$run()
query$export()
```

Extracting the results creates a series of `.csv` files in the `outputs` subfolder of `results`.
Extracting the query will create a table of metrics for each model year and scenario that is defined
in the model, placing that in another subfolder of `outputs`.

### Using the Walkthrough

Many additional features of VisionEval are systematically explored in commented R scripts located in
the VisionEval runtime `/walkthrough` folder. The walkthrough files are best explored using RStudio.

Here is an overview of the walkthrough files and what you will learn from each of them:

00-setup.R
: Sets up the walkthrough runtime directory

00-walkthrough.R
: Master list of walkthrough scripts (nothing specific to run here)

01-install.R
: How to install a VisionEval model sample from the packaged examples

02-running.R
: How to run a VisionEval model

03-structure.R
: The components of a VisionEval model

04-extract.R
: How to get raw results (or a subset) from a VisionEval model

05-mini-model.R
: How to build a small model programatically (extended view of structure.R)

06-model-stages.R
: The concept of model stages and how to manipulate them

07-queries.R
: How to run queries (summarizing results) on model results (including scenarios)

08-scenarios.R
: How to set model stages up as scenarios, run such a model, and examine results

09-run-parameters.R
: Understanding run parameters (model configuration settings)

10-debugging.R
: Using partial models to debug VisionEval

Once you have seen the message "Welcome to the new VisionEval", you can set up the walkthrough by
running this instruction:

```
walkthrough()
```

The walkthrough will create a special runtime directory (within your main runtime folder), so
nothing you do while trying it out will affect any of your "real" models, which will remain
untouched in your "models" directory.

To explore any of the walkthrough scripts, open them in RStudio by navigating in the RStudio "Files"
pane to the walkthrough directory, then double-clicking one of the scripts to open it in the RStudio
script editor. You then select individual lines in script editor and press "Enter" to run that line
in the console. You should run the lines in order ("walk through them") and not skip any!

If things get messed up because you didn't run the walkthrough lines in order, it's usually enough
to back up and run the lines you skipped. If you need to, you can reset the walkthrough by starting
it like this:

```
walkthrough(reset=TRUE)
```

Be careful: the "reset=TRUE" instruction will clear the walkthrough runtime. Anything you saved
there (including outputs from running and exporting the test models) will be lost. Your regular
runtime models directory will remain untouched.
