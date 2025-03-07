# Validation and Troubleshooting

Each model run will produce a time stamped `Log.txt file`. This log file is the first thing that the user should reference in troubleshooting errors. The log file should point to which input files have errors and help to define the error. If a model is not producing a log file, that indicates a more deep-rooted issue related to the model set-up, installation, or one or more packages.

Other common errors users should watch out for include:

* Files having data for years other than model run years will generate an error, files can only have data for model run years
* Consistent geography names across input files
* Input files in different modules need to be consistent
  + Zero land area for an azone location type when there are non-zero values for households in that azone location type
  + Zero land area for an azone location type when there are non-zero values for employment in that azone location type

## Validation

This section summarizes additional detail on the validation of VisionEval models with key considerations by concept. Each concept will highlight its respective model inputs and assumptions that can be changed to better match observed local patterns and trends. These outputs covered are only a handful that can be used to validate the VE model. 

### Household Synthesis and Land Use Validation

Two key metrics to validate are **population** and **income** due to the influential nature of these metrics on model results. Some additional considerations are as follows:

* The choice of geographies used in VisionEval can influence validation results. For example, if economic conditions or driver licensing rates vary significantly across the modeled area it might be a good idea to define Azones to reflect those differences. 
* The `VESimHouseholds` package processes PUMS data to derive parameters for several of its sub-modules. The default PUMS files in the `inst/extdata` folder from Oregon should be replaced with data for the area they are modeling. This is done by simply replacing the PUMS data in the `inst/extdata` folder with local data, which are then processed by several modules as part of a normal model run. This requires rebuilding the `VESimHousehold` package, more information can be found in the [Module Build Process](#ve-buildprocess) chapter.
* The average household size (`AveHhSize`) and proportion of one-person households (`Prop1PerHh`) can be set in the `azone_hhsize_targets.csv` file.
* Care should be taken to match the real dollar amount of `azone_per_cap_inc.csv` and other files with dollar values to the year specified in the file to account for inflation.
* The relative employment rate by age group by Azone can be specified to match observed differences across a metropolitan area or levels at various points of economic cycles. Lower employment rates, especially in certain age groups, should be reflected in `azone_relative_employment.csv`. The relative employment rate is relative to the average employment rate for the worker group in the PUMS data (e.g., a value of 0.5 would be entered if the employment rate for 20-29 age group in one Azone was half the employment rate for persons in that age group in the metropolitan area).
* The `VELandUse` package also uses the PUMS data, which can be further adjusted in two ways:
  * The mix of single family versus multi-family households will reflect local patterns if PUMS data for the modeled region are used instead of the default data from Oregon. See the [ insert link to the build process PUMS case study]
  * The proportion of households residing in mixed-use neighborhoods within each Bzone can optionally be set in the `bzone_urban-mixed-use_prop.csv` file. Such adjustments are subjective, as the definition of "urban mixed-use" neighborhoods [derived from the Claritas data](https://nhts.ornl.gov/2009/pub/DerivedAddedVariables2009.pdf) in the [NHTS](https://nhts.ornl.gov/) are imprecise. 

### Household Travel Behavior Validation

One key metric to validate for household travel behavior is **household DVMT**. Because VisionEval models do not have a network, users should prioritize validating household DVMT using NHTS or local household travel survey data. Users can also use Highway Statistics reports or imputed from annual HPMS estimates to validate at higher levels of geography, such as the state or metropolitan area level. 

* Care should be taken in choosing the validation targets to match model predictions. VE household travel modules predict household travel regardless of where the travel occurs within the modeled region. Therefore the results should be compared with household survey data where possible which provide similarly defined estimates. 
* Care should similarly be taken in comparing the model results with daily roadway VMT data, such as those reported in Highway Statistics reports or imputed from annual HPMS estimates. If such comparisons are made the model estimates of roadway DVMT calculated by the `CalculateRoadDvmt` module should be used for comparison (rather than HPMS data that is defined as all vehicles but only those miles on roadways within a specific geography).
* If the modeled road DVMT estimates match for the base year but not for prior years the modeled household DVMT trends should be checked against road DVMT trends. In particular, check whether reduction of DVMT (or reduction of DVMT growth rate) observed during the [Great Recession](https://en.wikipedia.org/wiki/Great_Recession) and increase in DVMT (or increase in the DVMT growth rate) afterwards are reflected in the modeled household DVMT. If not, the values in the following files should be checked and adjusted if warranted:
* There are few opportunities to adjust the parameters in the `VEHouseholdTravel` package, as most are derived from the NHTS and PUMS input data. Note that the optionally specified driver licensing rates described above can substantially affect daily household VMT. It is possible to specify the percentage of household SOV travel diverted to bicycles in the `azone_prop_sov_dvmt_diverted.csv` file to better match observed local values.
  
### Vehicles and Fuels Validation

Another important metric to validate is **vehicle ownership**, which has a strong correlation with household DVMT.

* If modeled DVMT matches validation data but fuel consumption does not (e.g. light-duty vehicle fuel consumption reported in Highway Statistics), the values in `ldv_powertrain_characteristics.csv` for current and past years can be adjusted to achieve a match. Fuel consumption may not match for several reasons such as:
  * The definition of crossover vehicles as light trucks vs. autos used in the vehicle type model does not match the average fuel consumption characteristics in the `ldv_powertrain_characteristics.csv` file.
  * The average fuel consumption characteristics in `ldv_powertrain_characteristics.csv` do not represent real world fuel economy.
* Most of the parameters in the `VEHouseholdVehicles` package are self-calibrating. However, the relative driver licensing rate by age group can be coded in the `region_hh_driver_adjust_prop.csv` file and should be used to account for the reduction in driver licensing rates among young or elderly drivers.
* Users can also use the `azone_hh_ave_veh_per_driver.csv` to reduce or increase vehicle ownership at the Azone level. It should be noted that this file inherently reduces the sensitivity of the `AdjustVehicleOwnership` module. 
* If validation data are available for commercial service vehicles, heavy trucks, and public transit vehicles changes can be made to the respective powertrain characteristics files for those vehicle types to match observed values.
* Rebuilding the `VEPowertrainsAndFuels` package is good practice. The default data inputs in the `VEPowertrainsAndFuels` package substantially affect modeled fuel consumption and vehicle emissions rates. These default inputs are contained in the `inst/extdata` folder of the source package. Note that the package needs to be built (installed) from the source package after adjustments have been made in order for the changes to have effect.  more information can be found in the [Module Build Process](#ve-buildprocess) chapter.

### Congestion and Roadway Travel Validation

* The `VETravelPerformance` package is self-calibrating. However, the user must provide several estimates used as constraints during that process:
  * Estimates of urbanized area light-duty vehicle and heavy truck VMT (`UrbanLdvDvmt` and `UrbanHvyTrkDvmt`, respectively) must be coded in the `marea_base_year_dvmt.csv` input file. 
* The user must also provide a regional estimate of heavy truck VMT (`HvyTrkDvmt`) in the `region_base_year_dvmt.csv` that is consistent with the urbanized area heavy truck VMT estimates.
+ The user should check the basis used for estimating commercial service VMT (`ComSvcDvmtGrowthBasis`) and heavy truck VMT (`HvyTrkDvmtGrowthBasis`).

## Additional Customizations

The `VESimHouseholds` and `PowertrainsAndFuels` packages are the two that should be prioritized for re-estimating with local data. Users do have the option to customize or re-estimate other model packages based on local data. Some additional packages with built-in estimation scripts are described below.

Note: For a deeper dive into how to customize packages and the various data that is available for local estimation, users should reference the [Estimation in VisionEval][Estimation in VisionEval] and [Module Build Process](#ve-buildprocess) chapters.

* **VETravelPerformance**: The [LoadDefaultRoadDvmtValues](https://github.com/VisionEval/VisionEval-Dev/blob/development-next/sources/modules/VETravelPerformance/R/LoadDefaultRoadDvmtValues.R) script pulls in datasets from the 2010 Highway Statistics reports are used to calculate state and urbanized area travel statistics as described below. A data from the Transportation Energy Databook (Edition 31) are used to calculate the ratio of commercial service vehicle DVMT with household DVMT. These datasets are in the "inst/extdata" folder of the package. Documentation for these datasets are included. Advanced users may update the datasets if desired. 

* **BudgetHouseholdDvmt**: The CES data used to estimate the BudgetHouseholdDvmt model are included in  `inst/extdata` folder of the source package in the `ces_vehicle_op-cost.csv` with documentation in `ces_vehicle_op-cost.txt`. The `ces.R` R script file contains the code used to download the raw CES dataset from the BLS website and process it to produce the dataset in the `ces_vehicle_op-cost.csv` file. CES data for the years 2003 to 2015 are used in model estimation. 2003 being the first year that the BLS included income subcategories for incomes greater than $70,000. 2015 being the last year of complete data when the model was estimated.

* **VETravelPerformance & CalculateVehicleOperatingCost**: Vehicle maintenance, repair, and tire costs as a function of the vehicle age are calculated based on data from the American Automobile Association (AAA) and the Bureau of Labor Statistics (BLS). AAA publishes reports yearly on the cost of vehicle use by vehicle type over the first 5 years of the vehicle's life. The 2017 report, a copy of which is included as the '17-0013_Your-Driving-Costs-Brochure-2017-FNL-CX-1.pdf' file in the `inst/extdata/sources` directory of this package, is used to calculate baseline MRT cost by vehicle type. Data from a BLS report, "Beyond the Numbers, Prices and Spending, Americans' Aging Autos, BLS, May 2014, Vol.3/No.9", are used to establish the relationship between MRT cost and vehicle age. A copy of the report is included as the 'americans-aging-autos.pdf' file in the `inst/extdata/sources` directory of this package. This report includes estimates of average MRT cost by vehicle age category for all household vehicles. The MRT costs by vehicle type and age are calculated as the outer product of the AAA costs by vehicle type and the BLS ratio of MRT cost by vehicle age. Since the BLS data don't distinguish between vehicle types, it is assumed that the effect of age on MRT expenses is the same for all vehicle types.

* **VETravelPerformance & CalculateVehicleOperatingCost**: [Placeholder for future development]

# Developing Scenarios

Strategic planning often requires the assessment of large numbers of future scenarios, each assessing a different combination of prioritizations, policy decisions, and constraints. 

The VEScenarios module provides the capability to quickly set up, run, and visualize large numbers of VERSPM scenarios using a baseline scenario combined with multiple changes to model inputs. 
After going to `../models/VERSPM_Scenarios` folder, you will see multiple subfolders and scripts.

![](images/multiple_scenarios.PNG){width=100%}

## VERSPM Base Model

This directory contains the inputs and R script necessary to run the base scenario, as described above.

### defs

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

### Inputs

The `inputs` folder in `VERRSPM_Scenarios` also differs from that in `VERSPM_base_model`.  In this case, there is only a single file specifying the output data tables that should be exported as CSV files in the `outputs` directory.

![](images/VERSPM_scenarios.PNG){width=100%}

##### scenario_inputs

Model scenarios are defined in terms of combinations of individual model input parameters and policy choices.  The various inputs are defined in the `scenario_inputs` folder.

Scenario inputs consist of eleven folders, one for each of a particular category of input, as described below.  All eleven folders are required.

Within each folder, there are subfolders containing input files, one per specific input. Each of the folders must contain at least one subfolder named "1", defining the input for the base scenario.  Subsequent numbered folders contain input files modifying parameters of interest, as shown in the screenshots below:

Model inputs not otherwise specified in the `scenario_inputs` directory are drawn from files in `VERSPM_base_model/defs` and `VERSPM_base_model/inputs`

![](images/VERSPM_scenarios2.PNG){width=100%}

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
  - F - Technology Mix and CI (`marea_transit_powertrain_prop.csv`) and (`region_carsvc_powertrain_prop.csv`) and (region_comsvc_powertrain_prop.csv`) : Vehicle technology mix
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
  - V - Vehicle Characteristics (`azone_hh_veh_mean_age.csv`) and (`azone_lttrk_prop`): The combination of fuel prices and vehicle travel charges to pay for roadways
    - 1 - Base
    - 2 - Light truck proportion at 35% of the fleet and the average vehicle age at 8 years

Running all of these input values will result in 10368 total scenarios, which would take days to run.  User usually does not need all the possible combinations of scenarios. 
VE-RSPM Scenarios are grouped in 5 different categories which you can modify in `category_config.json` :

* **Community Design** :  Policies that seek to enable shorter trips and alternate modes such as promotion of mixed use land use, transit service, bicycling, and parking management. ( group of L, B, P , T ) 
* **Marketing/Incentive** : Policies that improve driving efficiency such as ecodriving,and Intelligent Transportation System efforts, as well as programs that reduce auto demand such as carsharing, and home or work-based transportation demand management.( group of D, E ) 
* **Pricing : Policies** that move towards true cost pricing such as road user fees to pay for the cost of operating, maintaining and improving roads, and pay-as-you-drive (PAYD) insurance. ( C )
* **Vehicles/Fuels** : Factors representing changes to future vehicles and fuels ( group of V, F ) 
* **Income** : Context factor on the assumed growth of statewide average per capita income ( I )

Depending on how many scenarios exist in each of these five groups, total number of scenarios will be determined.

To test the multi-scenario capability in less time, reduce the number of scenario inputs by deleting some of the numbered folders, making sure to retain the "1" folder for each of the six options.
Note that if you change the directory structure in scenario_inputs, you will have to change `category_config.json` and `scenario_config.json` to match the new directory structure.

To modify the scenario inputs, the numbered subdirectories can be created or deleted. Each directory contains a single input file containing the modified model parameter.

##### Running the model for multiple scenarios

Similar to base case the model can be run in the command line. To run the model using R, run the following commands:

```
scenario_rspm <- openModel('VERSPM_Scenarios')
scenario_rspm$run()
```

After starting the run,model automatically builds scenarios by creating all possible combinations of settings found in scenario_inputs. The scenarios to run are found in the newly created scenarios directory.

![](images/scenarios.PNG){width=100%}

Each directory is essentially a copy of VERSPM_base_model, with inputs modified as specified in the scenario_inputs directory. Each scenario directory contains the results of a model run with its own inputs, datastore, and log file.

When finished, the VE-RSPM Scenario Viewer will automatically open to display the results. 

In detail, the model specified by the `run_model.R` script. In this case, the script runs four modules that create the scenarios from the inputs, runs each and combines the results.

![](images/run_model_Scenario.PNG){width=100%}

## Case Studies

### Using VisionEval to Assess Bike Network Changes
A 2020 OregonDOT-Metro-NITC research project being led by Joe Broach of Portland State University, will update VisionEval code (VE-RSPM) to enable VisionEval to respond to bike networks as perceived by differnt users. This includes the following elements.  

In the current VE-RSPM light vehicle (e.g. bicycle, electric bicycle, scooter) diversion module users specify the proportion of single-occupant vehicle (SOV) mileage diverted to light-vehicle travel in the base and future years.  Historical value can be derived from household travel surveys bike usage; future year inputs are specified through aspirational goals or exploratory processes. Methods for generating realistic bicycle diversion input have not been established, and the inputs are hard to tie to specific investment actions. The exploratory or aspirational approaches can be useful for strategic planning purposes, providing decision makers with information about what levels of SOV diversion to bicycle travel are necessary to meet identified goals, but they do not offer information about the level of infrastructure or other transportation system investments needed to achieve the given levels of bicycle diversion. 

The objective of the proposed research is to develop a new bicycle diversion module for the GreenSTEP-derived family of scenario planning models that internalizes bicycle diversion within the model by allowing users to specify changes in cycling infrastructure (and allow the model to estimate diversion), rather than assuming the outcome of cycling investments.

The research will develop new VE-RSPM modules to estimate SOV short-trip diversion, using input variables related to:
1.	Socio-demographic and other household characteristics (drawing from existing variables in the model), 
2.	Land use characteristics (again drawing from existing variables in the model), and
3.	Bicycle network characteristics.

Because VisionEval does not use an explicit network, bicycle network indicators will be used to represent the attractiveness of the bicycle facilities near the home location. The anticipated work includes pre-processors to extract bicycle network indicators from detailed bike network data, and potentially terrain data (from a digital elevation model) to capture the effects of hills on cycling propensity. Bicycle network indicators that may be included in VisionEval include the coverage, connectivity, and quality of bicycle facilities, and other measures shown in past research to have a significant relationship with cycling volumes, cycling mode share, or cycling attractiveness. 

Several pre-processors are under consideration to develop connectivity and quality of bike networks, including:  Bike Level of Traffic Stress (LTS)([see ODOT APMv2_Ch14](https://www.oregon.gov/ODOT/Planning/Documents/APMv2_Ch14.pdf)), Highway Capacity Manual Multi-Modal LOS methods ([see TRB](https://trid.trb.org/view/1326489)), and Scalable-Risk Analysis Method ([SCRAM](https://safety.fhwa.dot.gov/ped_bike/tools_solve/fhwasa17041/index.cfm)).

The following figures highlight the selected changes that the model makes to the VE-RSPM packages and modules.

![Bike Network Research](VE_PackagesModules/VERSPM_Bike.JPG){width=100%}

Note:  The project also intends to synchronize the disaggregate Bike Network assumptions with the Bike Module in Portland Metro's new Activity Based Model, where the full network, not just the aggregated metrics of VisionEval, could be utilized directly.

### User Impact
The VisionEval Bike upgrades will change both methods, inputs and outputs.  Methods will reflect the new functional form of travel by mode, and new data (updated NHTS2009 and EPA SLD land use data), leading to different outcomes for household travel by bike.  

Users will likely need to provide more detailed bike network data (for historic and forecast years) to a pre-processor to develop Bzone inputs for use in VisionEval.

### Status
The multi-agency research agreement was signed in early 2020.  The Research team anticipates the project will last roughly 12-18 months.  As with other VE research, additional efforts may be needed to implement the work within the VE codebase. 

