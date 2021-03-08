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

<img align="center" width="700" border=1 src="images/inputs.PNG">

The `../models/VE-State` directory contains sample input files for state of Oregon.  These can be modified or replaced to investigate the impacts of policy changes or to model a different state.  


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

## Querying results

To extract all results to .csv files, run:

```
statemod$extract()
```

On the R console, you will see messages about what tables are being extracted and where the files are being saved, e.g.:

```
Extracting data for Table Azone in Group 2010
Extracting data for Table Bzone in Group 2010
Extracting data for Table Household in Group 2010
[...]
Write output file: /models/VE-State/output/Azone_2010_1_2021-03-02_153010.csv
Write output file: /models/VE-State/output/Bzone_2010_1_2021-03-02_153010.csv
[...]
```

For a state-wide model, the `Household` and `Vehicle` tables in particular can be quite large, and this full result extraction might take several minutes. 

To extract just one field, for example DVMT at the household level for 2010 and 2040, first select just the Household table using the `tablesSelected` method:

```
statemod$tablesSelected <- 'Household'
```

Then select the `Dvmt` field:

```
statemod$fieldsSelected <- 'Dvmt'
```

Extract the result to a list of data frames for plotting, rather than to a .csv file. Some manipulation of the list can be done to put the fields in one data frame for plotting, for example:

```
hh_dvmt <- vestate$extract(saveTo = F)
hh_dvmt <- unlist(hh_dvmt)
year <- names(hh_dvmt)
year <- ifelse(grepl('2010', year), '2010', '2040')
hh_dvmt <- data.frame(year, Dvmt = hh_dvmt
```

Plot using the `ggplot2` library, for example:

```
ggplot(hh_dvmt, aes(x = Dvmt, fill = year)) + 
  geom_histogram() + 
  ylab('Number of Households') +
  ggtitle('Distribution of DVMT by VE-State for Oregon')
```

<img align="center" width="600" border=1 src="images/VEState_HH_DVMT_Distribution.png">


Other query methods are described in the [Getting Started documentation](https://github.com/VisionEval/VisionEval/wiki/Getting-Started-v2#extracting-model-results). 
 
### Scenarios

To modify a scenario, the appropriate input files are edited.  For example, to change the flat rate tax of vehicles for future [`azone_hh_veh_own_taxes.csv`](https://github.com/visioneval/VisionEval/blob/master/sources/modules/VEHouseholdVehicles/inst/module_docs/CalculateVehicleOwnCost.md#azone_hh_veh_own_taxescsv) would be modified in Excel, LibreOffice, OpenOffice, or a text editor to change the `VehOwnFlatRateFee` of year 2038.

<img align="center" width="600" border=1 src="../verspm/images/modify_input.PNG">

Create scenarios using the same steps as for [VE-RSPM]('../verspm/Running_VERSPM.md')

Return to [Tutorial](Main.md). 