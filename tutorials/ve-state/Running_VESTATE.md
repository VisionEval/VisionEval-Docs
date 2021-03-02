# VE-State Software Execution
----

This section describes the installation and use of VE-State.

## Installation of VisionEval and VE-State

VE-State and VisionEval framework are implemented in R, a statistical programming language and environment.  Both R and VisionEval are open source and freely available. For running VE-State you need to follow these steps:

1. [Install R](https://cran.r-project.org/) (users are encouraged to also install [RStudio](https://www.rstudio.com/products/rstudio/download/), a free and open-source integrated development environment for R)
2. [Install VisionEval](https://visioneval.org/category/download.html)
3. Run VE-State

The VisionEval installer is available [here](https://visioneval.org/category/download.html). Follow the instructions on this page carefully to install the VisionEval on your system.


## In Brief: Running VE-State Base Scenario

See the VisionEval [Getting Started documentation](https://github.com/VisionEval/VisionEval/wiki/Getting-Started-v2) for an overview of the framework methods for running models and querying results.

1. Double-click `VisionEval.Rproj` in the location where you installed VisionEval. This will launch RStudio.
2. Enter `statemod <- openModel('VE-State')`
3. Enter `statemod$run()`

<img align="center" width="600" border=1 src="images/run_VE-State.PNG">

## In Detail: Running VE-State Base Scenario


### Preparing inputs
Once VisionEval and VE-State have been installed, a directory with sample data will be available at `../models/VE-State/`. (Note `..` refers to the parent directory of the unzipped installer file). 

The `VE-State` directory serves the dual purposes of providing sample data and serving as a template for local modification to other locations. 

The `../models/VE-State/` directory contains sample input files for Oregon. These inputs can be modified or replaced to investigate the impacts of policy changes or to model a different state.  The folder contains multiple files and subfolders:

<img align="center" width="500" border=1 src="images/vestate.PNG">

`run_model.R` is the core script for running the model. It consists of calls to the modules that make up the model. The user may modify the script to call the  desired modules.

<img align="center" width="800" border=1 src="images/run_model.PNG">

The `defs` directory contains five model definition files which is introduced in [Model Definition Files](Inputs_and_Parameters.md)

The `inputs` directory contains a number of `CSV` and `JSON` files that provide inputs for the modules. Each module specifies what input files it needs. If you would like to know 
the description of each input file and how you can change those files for your desired testing see [Inputs_and_Parameters](Inputs_and_Parameters.md/#input-files)

<img align="center" width="800" border=1 src="images/inputs.PNG">

There is complete set of test data for RVMPO which you will find out in the Test1 folder. You can use those data to test VERRSPM run.

 the `../models/VE-State` directory contains sample input files for state of Oregon.  These can be modified or replaced to investigate the impacts of policy changes or to model a different state.  

To modify a scenario, the appropriate input files are edited.  For example, to change the flat rate tax of vehicles for future [`azone_hh_veh_own_taxes.csv`](link) would be modified in Excel, OpenOffice, or a text editor to change the `VehOwnFlatRateFee` of year 2038.

<img align="center" width="600" border=1 src="../verspm/images/modify_input.PNG">

### Running the Model

There are multiple ways to run VisionEval models. VisionEval models can be run via the command line directly or using `openModel`, and can be run for one scenario or multiple scenarios in parallel. Results can be viewed in tabular form or with the interactive `VEScenarioViewer`.

1. Start R (or RStudio) and make sure your directory is set to the installer folder. The easiest way to do this is to double-click `VisionEval.Rproj`, which will be associated with RStudio if that is installed correctly.
2. You should see 'Welcome to VisionEval!' on the RStudio console. Then run the following commands:

```
statemod <- openModel('VE-State')
statemod$run()
```

By default this will run the model in `../models/VE-State/` directory. The default model is for Oregon, for 2010 and 2040. 

After running the script you will see how the modules will be running in order.


The model run will take approximately 45 minutes. Once complete, the output are exported to `../models/VE-State/outputs` in 3 different zone levels.

# TODO
 - Steps to query results
 - Steps to describe creating scenarios
 - Steps to use Scenario Viewer 

Return to [Tutorial](Main.md). 