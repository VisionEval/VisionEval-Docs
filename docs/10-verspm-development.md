# Development and Installation

**NOTE: This section is the proposed location for new documentation on input development**

This section describes the installation and use of VE-RSPM.

## Installation of VisionEval and VE-RSPM

VE-RSPM and VisionEval framework are implemented in R, a statistical programming language and environment.  Both R and VisionEval are open source and freely available. For running VE-RSPM you need to follow these steps:

1. [Install R](https://cran.r-project.org/) (users are encouraged to also install [RStudio](https://www.rstudio.com/products/rstudio/download/), a free and open-source integrated development environment for R)
2. [Install VisionEval](https://visioneval.org/category/download.html)
3. Run VE-RSPM

The VisionEval installer is available [here](https://visioneval.org/category/download.html). Follow the instructions on this page carefully to install the Visioneval on your system.

## Running VE-RSPM Base Scenario

### Preparing inputs
Once VisionEval and VE-RSPM have been installed, a directory with sample data will be available at `../models/VERSPM/`. (Note `..` refers to the parent directory of the unzipped installer file). 

The `VE-RSPM` directory serves the dual purposes of providing sample data and serving as a template for local modification to other locations. 

The `../models/VERSPM/` directory contains sample input files for the Rogue Valley region in Oregon. These inputs can be modified or replaced to investigate the impacts of policy changes or to model a different region.  The folder contains multiple files and subfolders:

<img align="center" width="800" border=1 src="images/VERSPM_Folder.PNG">

`run_model.R` is the core script for running the model. It consists of calls to the modules that make up the model. The user may modify the script to call the  desired modules.

<img align="center" width="700" border=1 src="images/run_model.PNG">

The `defs` directory contains five model definition files which is introduced in [Model Definition Files](Inputs_and_Parameters.md)

<img align="center" width="700" border=1 src="images/model_definitions.PNG">

The `inputs` directory contains a number of `CSV` and `JSON` files that provide inputs for the modules. Each module specifies what input files it needs. If you would like to know 
the description of each input file and how you can change those files for your desired testing see [Inputs_and_Parameters](Inputs_and_Parameters.md/#input-files)

<img align="center" width="700" border=1 src="images/inputs.PNG">

There is complete set of test data for RVMPO which you will find out in the VERSPM_base_model folder. You can use those data to test VERRSPM run.

 the `../models/VERSPM/` directory contains sample input files for RV MPO, Oregon.  These can be modified or replaced to investigate the impacts of policy changes or to model a different region.  

To modify a scenario, the appropriate input files are edited.  For example, to change the flat rate tax of vehicles for future [`azone_hh_veh_own_taxes.csv`](https://github.com/visioneval/VisionEval/blob/master/sources/modules/VEHouseholdVehicles/inst/module_docs/CalculateVehicleOwnCost.md#azone_hh_veh_own_taxescsv) would be modified in Excel, LibreOffice, or a text editor to change the `VehOwnFlatRateFee` of year 2038

<img align="center" width="400" border=1 src="images/modify_input.PNG">

### Running the Model

There are multiple ways to run VisionEval models. VisionEval models can be run via the command line directly or using `openModel`, and can be run for one scenario or multiple scenarios in parallel. Results can be viewed in tabular form or with the interactive `VEScenarioViewer`.

1. Start R (or RStudio) and make sure your directory is set to the installer folder. The easiest way to do this is to double-click `VisionEval.Rproj`, which will be associated with RStudio if that is installed correctly.
2. You should see 'Welcome to VisionEval!' on the RStudio console. Then run the following commands:

```
rspmmod <- openModel('VERSPM')
rspmmod$run()
```

By default this will run the model in `../models/VERSPM/` directory. The default model is for the Rouge Valley (Oregon) MPO, for 2010 and 2038. 

After running the script you will see how the modules will be running in order.


The model run will take approximately 10-15 minutes. Once complete, the output are exported to `../models/VERSPM/outputs` in 3 different zone levels.


## Running VE-RSPM Multiple Scenarios

Strategic planning often requires the assessment of large numbers of future scenarios, each assessing a different combination of prioritizations, policy decisions, and constraints. 
The VEScenarios module provides the capability to quickly set up, run, and visualize large numbers of VE-RSPM scenarios using a baseline scenario combined with multiple changes to model inputs. 
After going to `../models/VERSPM_Scenarios` folder, you will see multiple subfolders and scripts.

<img align="center" width="600" border=1 src="images/multiple_scenarios.PNG">


#### VERSPM_base_model

 This directory contains the inputs and R script necessary to run the base scenario, as described above.
 
#### defs

`VE-RSPM_Scenarios/defs` directory contains the same files as the `VERSPM_base_model/defs` directory, but the `model_parameters.json` file differs between `VERSPM_base_model/defs` and`VE-RSPM_Scenarios/defs` differs in that the latter 
version contains just four parameters specifying the locations of inputs and outputs, as well as the number of processors (NWorkers) to use. The default is 4, but be sure to set this to a number appropriate to your machine.

```
[
  {
    "NAME": "ModelFolder",
    "VALUE": "VERSPM_base_model",
    "TYPE": "character",
    "UNITS": "NA",
    "PROHIBIT": "NA",
    "SIZE": 20,
    "ISELEMENTOF": ""
  },
  {
    "NAME": "ScenarioInputFolder",
    "VALUE": "scenario_inputs",
    "TYPE": "character",
    "UNITS": "NA",
    "PROHIBIT": "NA",
    "SIZE": 20,
    "ISELEMENTOF": ""
  },
  {
    "NAME" : "ScenarioOutputFolder",
    "VALUE": "scenarios",
   "TYPE": "character",
   "UNITS": "NA",
   "PROHIBIT": "NA",
   "SIZE": 20,
   "ISELEMENTOF": ""
  },
  {
    "NAME" : "NWorkers",
    "VALUE": "6",
    "TYPE" : "integer",
    "UNITS" : "NA",
    "PROHIBIT" : "c('NA', '< 0')",
    "ISELEMENTOF" : ""
  }
]
```

#### Inputs

The `inputs` folder in `VERRSPM_Scenarios` also differs from that in `VERSPM_base_model`.  In this case, there is only a single file specifying the output data tables that should be exported as CSV files in the `outputs` directory.

<img align="center" width="400" border=1 src="images/VERSPM_scenarios.PNG">

#### scenario_inputs

Model scenarios are defined in terms of combinations of individual model input parameters and policy choices.  The various inputs are defined in the `scenario_inputs` folder.

Scenario inputs consist of eleven folders, one for each of a particular category of input, as described below.  All eleven folders are required.

Within each folder, there are subfolders containing input files, one per specific input. Each of the folders must contain at least one subfolder named "1", defining the input for the base scenario.  Subsequent numbered folders contain input files modifying parameters of interest, as shown in the screenshots below:

Model inputs not otherwise specified in the `scenario_inputs` directory are drawn from files in `VERSPM_base_model/defs` and `VERSPM_base_model/inputs`

<img align="center" width="800" border=1 src="images/VERSPM_scenarios2.PNG">

The subfolder names and scenario inputs are defined as follows (input file to modify given in parentheses):

  - B - Bicycles (`azone_prop_sov_dvmt_diverted.csv`) : Network improvements, incentives, and technologies that encourage bicycling and other light-weight vehicle travel
    - 1 - Base bicycling percentage of SOV tours less than 20 miles (9.75%)
    - 2 - Increase diversion of SOV tours to 20%
  - C - Vehicle Travel Cost (`azone_hh_veh_own_taxes.csv`) and (`region_prop_externalities_paid.csv`) : Combination of fuel prices and charges to pay for roadway costs and possibly externalities
    - 1 - No change in fuel prices or increase in roadway or externality charges
    - 2 - Keep the vehicle ownership cost the same
    - 3 - Higher climate cost and pay as you drive insurance
  - D - DemandManagement (`bzone_travel_demand_mgt.csv`) : Programs to encourage less private vehicle travel
    - 1 - Baseline implementation of ITS
    - 2 - Increase the effectiveness of implementation of ITS
  - E - Driving Efficiency (`marea_operations_deployment.csv`) and (`marea_speed_smooth_ecodrive.csv`) and (`other_ops_effectiveness.csv`) : Driving efficiency by increasing implementation of ITS
    - 1 - Base
    - 2 - Increased the proportion by 10%	
  - F - Technology Mix and CI (`marea_transit_powertrain_prop.csv`) and (`region_carsvc_powertrain_prop.csv`) and (region_comsvc_powertrain_prop.csv`) : Vehicle technology mix and carbon intensity of fuels.
    - 1 - Baseline vehicle technology mix
    - 2 - Increased percentage of electric vehicles in household and commercial setting by 20%	
  - G - Fuel Price (`azone_fuel_power_cost.csv`) : Real fuel price in 2010 USD
    - 1 - Baseline fuel price
    - 2 - Double fuel price
	- 3 - Quadruple fuel price
  - I - Income (`azone_fuel_power_cost.csv`) : Real average household income in 2010 USD
    - 1 - Baseline household income
    - 2 - Income growth of 7% w.r.t reference
	- 3 - Income growth of 14% w.r.t reference
  - L - LandUse (`azone_hhsize_targets.csv`) and (`bzone_urban_du_proportions.csv`) : Distribution of population and employment by place type
    - 1 - Base, Maintain current distribution
    - 2 - LU overlaps with HHsize + Population
  - P - Parking (`bzone_parking.csv`) : The extent of paid parking and its price
    - 1 - Current extent and daily fee
    - 2 - Increase parking cost by 100% and proportion charted by 10%.
  - T - Transit (`marea_transit_service.csv`) : The extent and frequency of transit service
    - 1 - Current public transit service level
    - 2 - Double public transit service level
    - 3 - Quadruple public transit service level
  - V - Vehicle Characteristics (`azone_hh_veh_mean_age.csv`) and (`azone_lttrk_prop`): The combination of fuel prices and vehicle travel charges to pay for roadways and to pay for externalities such as carbon pricing
    - 1 - Base
    - 2 - Light truck proportion at 35% of the fleet and the average vehicle age at 8 years

Running all of these input values will result in 10368 total scenarios, which would take days to run.  User usually does not need all the possible combinations of scenarios. 
VE-RSPM Scenarios are grouped in 5 different categories which you can modify in `category_config.json` :

* **Community Design** :  Policies that seek to enable shorter trips and alternate modes such as promotion of mixed use land use, transit service, bicycling, and parking management. ( group of L, B, P , T ) 
* **Marketing/Incentive** : Policies that improve driving efficiency such as ecodriving,and Intelligent Transportation System efforts, as well as programs that reduce auto demand such as carsharing, and home or work-based transportation demand management.( group of D, E ) 
* **Pricing : Policies** that move towards true cost pricing such as road user fees to pay for the cost of operating, maintaining and improving roads, pay-as-you-drive (PAYD) insurance, and environmental impact fees such as a carbon tax. ( C )
* **Vehicles/Fuels** : Factors representing changes to future vehicles and fuels ( group of V, F ) 
* **Income** : Context factor on the assumed growth of statewide average per capita income ( I )

Depending on how many scenarios exist in each of these five groups, total number of scenarios will be determined.

To test the multi-scenario capability in less time, reduce the number of scenario inputs by deleting some of the numbered folders, making sure to retain the "1" folder for each of the six options.
Note that if you change the directory structure in scenario_inputs, you will have to change `category_config.json` and `scenario_config.json` to match the new directory structure.

To modify the scenario inputs, the numbered subdirectories can be created or deleted. Each directory contains a single input file containing the modified model parameter.

#### Running the model for multiple scenarios

Similar to base case the model can be run in the command line. To run the model using R, run the following commands:

```
scenario_rspm <- openModel('VERSPM_Scenarios')
scenario_rspm$run()
```

After starting the run,model automatically builds scenarios by creating all possible combinations of settings found in scenario_inputs. The scenarios to run are found in the newly created scenarios directory.

<img align="center" width="800" border=1 src="images/scenarios.PNG">

Each directory is essentially a copy of VERSPM_base_model, with inputs modified as specified in the scenario_inputs directory. Each scenario directory contains the results of a model run with its own inputs, datastore, and log file.

When finished, the VE-RSPM Scenario Viewer will automatically open to display the results. To find out more on exported metrics see [Performance Metrics](Performance.md)

In detail, the model specified by the `run_model.R` script. In this case, the script runs four modules that create the scenarios from the inputs, runs each and combines the results.

<img align="center" width="600" border=1 src="images/run_model_Scenario.PNG">


Return to [Tutorial](Main.md). 
