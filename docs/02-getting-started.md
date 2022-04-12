# Getting Started

## Overview

The VisionEval software framework is written in the R programming language for statistical computing and graphics.  The purpose of the model system and framework is to enable models be created in a plug-and-play fashion from modules that are also distributed as R packages. A simple R script is used to implement a model by initializing the model environment and then calling modules successively.

**Video Description of Tool installation, setup, and basic usage**

This 45 minute video was recorded during a VisionEval Training at Portland State University in September 
2019:

<iframe src="https://www.youtube.com/embed/-ylFbyLfhbw?t=2203" width="672" height="400px" data-external="1"></iframe>

## Installation and Setup 

There are two paths to getting VisionEval running:

1. **Install from stand-alone Windows installer**Download a zipped folder with all dependencies include, for a specific version of R. This is the simplest way to quickly get VisionEval on your computer. This uses the installers on the [Releases](https://github.com/VisionEval/VisionEval/releases) page and further details are available on the [Downloads page of visioneval.org](https://visioneval.org/category/download.html). This currently is designed for the Windows operating system. This path is described first.

2. **Clone or fork repository** If you area a Mac/Linux user, or if you are interested in contributing to the development of VisionEval modules, models, framework, or visualizer, choose this path.   Instructions for setting up the VisionEval development environment can be found in the <a target="_blank" href="https://github.com/VisionEval/VE-Installer">VE-Installer</a> repository.

**Install for Windows**:**[Get VisionEval Here](https://github.com/VisionEval/VisionEval/releases/download/v1.0.0/VE-installer-Windows-R3.6.1.2019-07-15.zip)**

*Note: 583 Mb download! Packaged for R 3.6.1*

[See this page for other R versions, 3.4.4 - 3.6.0](https://github.com/VisionEval/VisionEval/releases/tag/v1.0.0)

After installing R 3.6.1 and downloading the VE Installer from the link above, unzip the folder to the destination folder of your choice.

The link above will download a .zip file containing the following:
 - The VisionEval framework code
 - VE-RSPM, VE-RPAT, VE-GUI, VE-State and VE-ScenarioViewer 
 - All necessary R packages

To complete the installation and start VisionEval, simply:
   - Double-click **<tt>VisionEval.bat</tt>**

## Running VisionEval 

Once you have been welcomed to VisionEval, you can follow the instructions under "Running VE Models" on the
<a href="https://github.com/VisionEval/VisionEval/wiki/Getting-Started">Getting Started</a> page.
Your destination folder contains everything you need from the VisionEval "sources" folder.

The installation also creates some convenience functions which will run the model test scenarios or start the VE GUI:
 - <tt>vegui()</tt> to start the GUI (navigate to your destination folder to find the scenario run scripts)
 - <tt>verpat()</tt> for the VERPAT test model
 - <tt>verpat(scenarios=TRUE)</tt> to run multiple scenarios in VERPAT
 - <tt>verpat(baseyear=TRUE)</tt> to run the alternate VERPAT sample scenario
 - <tt>verspm()</tt> for the VERSPM test model
 - <tt>verspm(scenarios=TRUE)</tt> to run multiple scenarios in VERSPM

## Requirements 

If the above installation steps did not succeed, ensure that you have downloaded the appropriate version of VisionEval to match the version of R that you have installed.

### R 
The current version of VisionEval is built for the latest version of R, 3.6.1.  If you currently have another version of R installed, you can go to the [GitHub release page](https://github.com/VisionEval/VisionEval/releases) to download VisionEval for R. 

You can find the <a
href="https://cran.r-project.org/bin/windows/base/" target="_blank">R 3.6.1 installer for Windows here</a>.

### RStudio (optional)
Many users find that <a href="https://www.rstudio.com/products/rstudio/#Desktop" target="_blank">RStudio</a> is a more user-friendly version of the
standard R interface.  RStudio is particularly recommended if you plan to clone and explore the
<a target="_blank" href="https://github.com/VisionEval/VE-Installer">Visioneval source code from GitHub</a>.

**See the VERPAT [tutorial](https://github.com/visioneval/VisionEval/wiki/VERPAT-Tutorial-Running-the-Model)** for more information on running models.

### Running VEGUI to then run a model 

After installing from the stand-alone installer (path 1, above), you can run the VEGUI using the helper functions `vegui()`.

### Running Multiple Scenarios of a Model
After installing from the stand-alone installer (path 1, above), you can run the multiple scenarios examples using the helper functions `verpat(scenarios = T)` and `verspm(scenarios = T)`.

After you run the multiple scenarios tests, you can explore the relationship between input scenarios and results using VEScenarioViewer.  You can try the example interactive [VERPAT](http://htmlpreview.github.io/?https://github.com/VisionEval/VisionEval/blob/master/sources/VEScenarioViewer/verpat.html) and [VERSPM](http://htmlpreview.github.io/?https://github.com/VisionEval/VisionEval/blob/master/sources/VEScenarioViewer/verspm.html) scenario viewers (visualizers) online.

See the VERPAT [tutorial](https://github.com/visioneval/VisionEval/wiki/VERPAT-Tutorial-Multiple-Scenarios) for more information regarding the visualizers.
