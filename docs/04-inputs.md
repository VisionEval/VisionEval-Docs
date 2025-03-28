# Model Inputs



Once a VisionEval model has been installed, a directory with sample data will be available within the model directory (e.g., `../models/VERSPM/` where `..` refers to the parent directory of the unzipped installer file). See VisionEval walkthrough files for instructions on installng sample models.

The model directory serves the dual purposes of providing sample data and a template for local modification to other locations. 

The default VERSPM directory contains sample input files for the Rogue Valley region in Oregon, while the default VE-State directory contains sample input files for the State of Oregon. These inputs will be modified or replaced to investigate the impacts of policy changes or to model a different region.

## Standard Model Structure {#model-structure}

VisionEval models all have a standard structure, which can be customized. The typical structure is described here.

The `visioneval.cnf` in the model directory defines the model's structure. It is introducted in [Model Configuration](#visioneval-cnf).

The `defs` directory contains three model definition files which are introduced in [Set-Up Inputs](#defs) section.

The `inputs` directory contains a number of `CSV` and `JSON` files that provide inputs for the modules. Each module specifies what input files it needs. The majority of input files are `CSV` formatted text files. The names of the file identify the geography level for the input data. For example, `azone_hh_pop_by_age.csv` is the input for household population by age, and should have data at the Azone level. Each input file has:

* **Field names** identifying dataset names
* **Year** field when inputs vary by model year
* **Geo** field when inputs vary by geography

Field names can also have modifiers, such as the year that money values are denominated in (e.g. 2010) or magnitude multiplier for large numbers (e.g. 1e3). Input specifications, which can be located in the source code for each module as well as the module documentation, can be referenced when users are unsure of the input data type, units, and any prohibited values. In formatting input files, users should pay attention to the following:

* Need values for every combination of year and geography
* Field names must exactly match specifications
* Values must match specification data type and not contain any prohibited values 
* No data for years other than model run years
* No data for areas other than those defined in geo.csv file

The rest of this section will contain generalized best practices for input development applicable to all VisionEval models and go into the details of inputs for each model. 

## Model Configuration (`visioneval.cnf`) {#visioneval-cnf}

This file contains parameters that define key attributes of the model and its computational stages and scenarios. This file can be in YAML format (typical) or JSON (for backward compatibility - it replaces `run_parameters.json` in older versions of VisionEval). Certain elements of `visioneval.cnf` need to be modified by the user to specify the model base year and run years. A more detailed description of the file is not currently available (but will appear soon). The typical contents of `visioneval.cnf` are as follows:

```yaml
# Model-wide description
Model          : VE-State 3.0
Region         : Oregon                     # Change to your local area
State          : OR                         # Change to your local area
BaseYear       : 2010                       # Change to your model's base year
Script         : run_model.R

# Model Stages and Scenarios
ModelStages:
  base-year-2010:                           # Change base year stage name
    Years : [2010]                          # Change 2010 to your model's base year
    Description : Oregon Base Year 2010     # Change to correct description
  future-year-2040:
    StartFrom : base-year-2010              # Change to be consistent with base year stage name
    Years : [2040]                          # Change 2040 to your model's future year
    Description : Oregon Future Year 2040   # Change to correct description
```

See the separate scenarios section (under construction) to learn how to set scenarios up efficiently within models.

With this standard setup, model results will be generated in folder called `results`, and the model stages will each generate their outputs into a sub-folder of `results` named after the stage.

The model directory structure will look like the following, though the `results` directory won't exist until you run the model:

```
VE-State-years # or whatever your model is called in the `models` folder
-- defs
   -- deflators.csv
   -- geo.csv
   -- units.csv
-- inputs
   ... all the `.csv` files plus `model_parameters.json` used in the model
-- results
   -- base-year-2010
      -- Datastore
         -- ... (Subfolders and files with the model outputs)
      -- Log_<run_date>....txt (model run notices, including warnings and errors)
      -- ModelState.Rda
   -- future-year-2040
      -- Datastore (folder)
      -- Log_<run_date>....txt
      -- ModelState.Rda
-- scripts
   -- run_model.R
-- visioneval.cnf
```

## Model Script {#run_model_script}

The `scripts` folder contains one or more model scripts describing the sequence of VisionEval modules that the model will run to genereate its outputs. Typically, there will be one script called `run_model.R` but the name can be changed in `visioneval.cnf`.

Here is the standard `run_model.R` script for the VERSPM model. Generally, the script won't be changed except for debugging purposes. One reason to change the script might be to use a locally customized package with a different name (e.g. `VEMyPowertrainsAndFuels` versus `VEPowertrainsAndFuels`).

```
for(Year in getYears()) {
  runModule("CreateHouseholds",                "VESimHouseholds",       RunFor = "AllYears",    RunYear = Year)
  runModule("PredictWorkers",                  "VESimHouseholds",       RunFor = "AllYears",    RunYear = Year)
  runModule("AssignLifeCycle",                 "VESimHouseholds",       RunFor = "AllYears",    RunYear = Year)
  runModule("PredictIncome",                   "VESimHouseholds",       RunFor = "AllYears",    RunYear = Year)
  runModule("PredictHousing",                  "VELandUse",             RunFor = "AllYears",    RunYear = Year)
  runModule("LocateEmployment",                "VELandUse",             RunFor = "AllYears",    RunYear = Year)
  runModule("AssignLocTypes",                  "VELandUse",             RunFor = "AllYears",    RunYear = Year)
  runModule("Calculate4DMeasures",             "VELandUse",             RunFor = "AllYears",    RunYear = Year)
  runModule("CalculateUrbanMixMeasure",        "VELandUse",             RunFor = "AllYears",    RunYear = Year)
  runModule("AssignParkingRestrictions",       "VELandUse",             RunFor = "AllYears",    RunYear = Year)
  runModule("AssignDemandManagement",          "VELandUse",             RunFor = "AllYears",    RunYear = Year)
  runModule("AssignCarSvcAvailability",        "VELandUse",             RunFor = "AllYears",    RunYear = Year)
  runModule("AssignTransitService",            "VETransportSupply",     RunFor = "AllYears",    RunYear = Year)
  runModule("AssignRoadMiles",                 "VETransportSupply",     RunFor = "AllYears",    RunYear = Year)
  runModule("AssignDrivers",                   "VEHouseholdVehicles",   RunFor = "AllYears",    RunYear = Year)
  runModule("AssignVehicleOwnership",          "VEHouseholdVehicles",   RunFor = "AllYears",    RunYear = Year)
  runModule("AssignVehicleType",               "VEHouseholdVehicles",   RunFor = "AllYears",    RunYear = Year)
  runModule("CreateVehicleTable",              "VEHouseholdVehicles",   RunFor = "AllYears",    RunYear = Year)
  runModule("AssignVehicleAge",                "VEHouseholdVehicles",   RunFor = "AllYears",    RunYear = Year)
  runModule("CalculateVehicleOwnCost",         "VEHouseholdVehicles",   RunFor = "AllYears",    RunYear = Year)
  runModule("AdjustVehicleOwnership",          "VEHouseholdVehicles",   RunFor = "AllYears",    RunYear = Year)
  runModule("CalculateHouseholdDvmt",          "VEHouseholdTravel",     RunFor = "AllYears",    RunYear = Year)
  runModule("CalculateAltModeTrips",           "VEHouseholdTravel",     RunFor = "AllYears",    RunYear = Year)
  runModule("CalculateVehicleTrips",           "VEHouseholdTravel",     RunFor = "AllYears",    RunYear = Year)
  runModule("DivertSovTravel",                 "VEHouseholdTravel",     RunFor = "AllYears",    RunYear = Year)
  runModule("CalculateCarbonIntensity",        "VEPowertrainsAndFuels", RunFor = "AllYears",    RunYear = Year)
  runModule("AssignHhVehiclePowertrain",       "VEPowertrainsAndFuels", RunFor = "AllYears",    RunYear = Year)
  for (i in 1:2) {
    runModule("CalculateRoadDvmt",             "VETravelPerformance",   RunFor = "AllYear",    RunYear = Year)
    runModule("CalculateRoadPerformance",      "VETravelPerformance",   RunFor = "AllYears",    RunYear = Year)
    runModule("CalculateMpgMpkwhAdjustments",  "VETravelPerformance",   RunFor = "AllYears",    RunYear = Year)
    runModule("AdjustHhVehicleMpgMpkwh",       "VETravelPerformance",   RunFor = "AllYears",    RunYear = Year)
    runModule("CalculateVehicleOperatingCost", "VETravelPerformance",   RunFor = "AllYears",    RunYear = Year)
    runModule("BudgetHouseholdDvmt",           "VETravelPerformance",   RunFor = "AllYears",    RunYear = Year)
    runModule("BalanceRoadCostsAndRevenues",   "VETravelPerformance",   RunFor = "AllYears",    RunYear = Year)
  }
  runModule("CalculateComEnergyAndEmissions",   "VETravelPerformance",   RunFor = "AllYears",    RunYear = Year)
  runModule("CalculatePtranEnergyAndEmissions", "VETravelPerformance",   RunFor = "AllYears",    RunYear = Year)
}
```

## Set-up Inputs {#defs}
The set-up inputs are those in the `defs` directory. The `geo.csv` file will need to set up to represent the model geography. `deflators.csv` may need to be adjusted to ensure that all years prior to the model base year are present. `units.csv` typically will not need to be adjusted.

- [deflators.csv](#deflators.csv)
- [geo.csv](#geo.csv)
- [units.csv](#units.csv)

### deflators.csv
This file defines the annual deflator values, such as the consumer price index, that are used to convert currency values between different years for currency denomination. This file does not need to be modified unless the years for which the dollar values used in the input dataset is not contained in this file. The format of the file is as follows:

|              Year          |             Value          |
|----------------------------|----------------------------|
|              1999          |             172.6          |
|              2000          |             178.0          |
|              2001          |             182.4          |
|              ...           |             ...            |
|              2010          |             218.344        |
|              ...           |             ...            |
|              2015          |             244.19         |
|              ...           |             ...            |
|              2020          |             271.52         |
|              2021          |             277.34         |
### geo.csv

This file describes all of the geographic relationships for the model and the names of geographic entities in a CSV formatted text file. The Azone, Bzone, and Marea names should remain consistent with the input data. More information on developing this file and VisionEval model geographic relationships can be found [here](#geography). The format of the file is as follows:

| Azone       | Bzone          | Czone      | Marea      |
| ----------- | -------------- | ---------- | ---------- |
| RVMPO       | D410290001001  | NA         | RVMPO      |
| RVMPO       | D410290001002  | NA         | RVMPO      |
| RVMPO       | D410290002011  | NA         | RVMPO      |
| RVMPO       | D410290002012  | NA         | RVMPO      |
| RVMPO       | D410290002013  | NA         | RVMPO      |
| RVMPO       | D410290002021  | NA         | RVMPO      |
| RVMPO       | D410290002022  | NA         | RVMPO      |
| RVMPO       | D410290002023  | NA         | RVMPO      |
| RVMPO       | D410290002031  | NA         | RVMPO      |
| RVMPO       | D410290002032  | NA         | RVMPO      |
| RVMPO       | D410290002033  | NA         | RVMPO      |
| RVMPO       | D410290003001  | NA         | RVMPO      |
| RVMPO       | ...            | NA         | RVMPO      |

### units.csv

This file describes the default units to be used for storing complex data types in the model. This file should NOT be modified by the user. The VisionEval model system keeps track of the types and units of measure of all data that is processed. More details about the file and structure can be found [here](#data-types-units-and-currency-deflators). The format of the file is as follows:

| Type       | Units |
| ---------- | ----- |
| currency   | USD   |
| distance   | MI    |
| area       | SQMI  |
| mass       | KG    |
| volume     | GAL   |
| time       | DAY   |
| energy     | GGE   |
| people     | PRSN  |
| vehicles   | VEH   |
| trips      | TRIP  |
| households | HH    |
| employment | JOB   |
| activity   | HHJOB |

## Inputs by Concept

This section covers generalized inputs by concepts shared by all VisionEval models. Best practices for inputs by concepts are also discussed. To learn about the specific inputs used by each model skip ahead to the following sections:

* [VERSPM inputs](#verspm-inputs)
* [VE-State inputs](#vestate-inputs)

### Household Synthesis Inputs 

The demographic and land use inputs are those related to population, employment, and income that result in the [household synthesis](#household-synthesis-and-land-use). VisionEval takes user input statewide population by age group, assembles them into households with demographic attributes ([<span style="color:green">lifecycle category</span>](#lifecycle), per capita income). 

* **Pool of available households.** Modelwide, [<span style="color:green">Census PUMS</span>](#census-pums) data represents actual households and representative mix of household composition and demographics for your area it is built into the code. Note that users must rebuild the VESimHousehold package to use local PUMS data as Oregon data is the default, see the chapter on [Estimation in VisionEval][Estimation in VisionEval] for instructions on how to rebuild packages.

* **Population by age control totals.** For population inputs, VisionEval models distinguish between the [<span style="color:green">regular household population</span>](#regular-households) and [<span style="color:green">group quarter population</span>](#non-institutional-group-quarters) due to distinct differences in travel behaviors.  Zone-level inputs for (1) regular households and (2) group quarters households (can be 0) include population by [<span style="color:green">age group</span>](#age-group) and average per capita income. Base year totals for the household population can be obtained from Census. Future year forecasts  should be consistent with but may need to be extrapolated beyond adopted regional plans (e.g., RTP, County and City TSPs). Some local governments may have detailed age information generated as part of a Housing Needs Analysis completed for the Periodic Review of the local Comprehensive Plan. If not, future population by age can apply ratios from the base year model set-up. Group quarters population data is best obtained from the university administration, by age if possible.  Group quarters can be approximated from enrollment data by class year. All other group quarters data (e.g., income) are difficult to obtain but not of paramount importance to the model, simplifying assumptions are often required. Per capita income can be obtained from either the Census or Bureau of Economic Analysis. Since the model accounts for inflation, future income can remain the same in future years, or adjusted based on local plans. 

* **Optional household adjustments.** (Optional) constraints on regular households include average household size and proportion of single-person households, adjustments to [<span style="color:green">licensure rate</span>](#licensure-rate) for driving age persons. Household size values can be obtained from the Census and licensure data can be obtained from the state DMV.

* **Employment.** VERSPM employment inputs require [<span style="color:green">employment by type</span>](#employment-type) in each model year by Bzone. VE-State requires workers by [<span style="color:green">location type</span>](#location-type) (Optional) constraints on aggregated [<span style="color:green">employment rate</span>](#employment-rate) for working age persons by Azone. 

### Land Use Inputs

Once households are synthesised, VisionEval allocates them to Bzone-level dwelling units inputs. Separately Bzones are attributed with employment and land use attributes ([<span style="color:green">location type</span>](#location-type), [<span style="color:green">built form ‘D’ values</span>](#buit-form-measures), [<span style="color:green">mixed use</span>](#urban-mixed-use), [<span style="color:green">employment by type</span>](#employment-type)). Household members are identified as workers and/or drivers and number of household vehicles are estimated. Each home and work location is tied to a specific Bzone with its associated attributes. Additionally, some local policies are land use based.

* **Dwelling units.** Numbers of [<span style="color:green">dwelling units by type</span>](#dwelling-unit-type) in each model year and proportions of each in each [<span style="color:green">development type</span>](#development-type). Income quartiles tied to households in dwelling units help VisionEval assign households to a compatible Bzone location. The base year dwelling unit data can sourced from either the Census or an available travel demand model. Future year dwelling units can be obtained from local Comprehensive Plans. Adjustments may be needed to count only occupied units, and occupancy rates can be obtained from Census block group data, as a starting point. Base and future year dwelling unit counts should be consistent with household assumptions in the region’s travel demand model.

* **Land use.** Inputs set the total developable land area, by [<span style="color:green">development type</span>](#development-type). VERSPM also requires its location (centroid latitude-longitude) for spatially linking to source data, and input assumptions on the [<span style="color:green">built form measures</span>](#buit-form-measures). These inputs can change by model run year. Some land use data use [EPA Smart Location Database](https://www.epa.gov/smartgrowth/smart-location-mapping) (SLD) data. Geospatial SLD data can be downloaded at the block group level and extrapolated to other geographies if needed using just used the EPA block group data.
  
* **Land use-household linkages.** VisionEval assigns a Bzone to each household's home and to each household worker's work location, with the associated Bzone attributes. The VisionEval-calculated [<span style="color:green">urban mixed use</span>](#urban-mixed-use) designation of the Bzone can optionally be modified by input targets on the proportion of households assigned that designation in each Bzone  in this process.
  * **Note:**  Input files must be consistent.  This includes: (1) land area must be specified for each azone location type that has households or employment assigned to it; (2) dwelling units must be a reasonable match with population (divided by household size); (3) shares of jobs within each Azone must sum to 1 for all Azones in the Marea.

#### Defining “Location Type” (metro, town, rural)

One method is to define land in MPO boundaries to be **metro**, for urban areas smaller than MPOs, land inside their UGB is a **town**. Everything else is **rural**. Note that if you want to further refine within the MPO, place types can identify low density areas that you might consider “rural” and areas that less accessible/more isolated (don’t have access to broader transit service) as “town”. Some states have official population forecasts done for each urban area that helps with the population inputs. Users can also use LEHD where we used the boundaries identified above to designate location types, and then used LEHD to calculate worker flows between county home location-to-work LocType (any county).

An alternative method is to use the [Census Urban and Rural Classification](https://www.census.gov/programs-surveys/geography/guidance/geo-areas/urban-rural/2010-urban-rural.html). The Census Urban and Rural Classification distinguishes between two types of urban areas: 

*	Urbanized Areas (UAs) of 50,000 or more people are defined as **metro**
*	Urban Clusters (UCs) of at least 2,500 and less than 50,000 people are defined as **town**
* Everything else is **rural**

**NOTE: the 2020 Census has removed the Urban Cluster specification. 

#### Defining "Area Type" (center, inner, outer, fringe)

“Area Type” is based on a mix of activity density levels and destination accessibility levels, as discussed in the [documentation](http://htmlpreview.github.io/?https://github.com/VisionEval/VisionEval/blob/master/sources/modules/VESimLandUse/inst/module_docs/analyze_3Ds.html) discussing the VE-State EAP-SLD-based Bzone synthesis.  

ODOT develops place types using data from local travel demand models, specifically TAZs within MPOs (Mareas). Area type VisionEval inputs are generated using population and employment data by TAZ using the below calculations. By using local travel model TAZ data which has base and future population and employment, users can create a future version of these variables and thus the VE-State area type inputs we calculate cover different areas over time: 

* **Activity Density** = TAZ-level (population [households and qroup quarter units] + employment / 2.5) / unprotected acres [with parks and water removed). SLD variable D1B is roughly the same.
* **Destination Accessibility** = TAZ-level as shown below.  There’s not an equivalent SLD attribute, but some of the D5 attributes are similar.
  * (D5) Harmonic mean of employment within 2 miles and population within 5 miles (2 * TotEmp_InDist2mi * Pop_InDist5mi) / (TotEmp_InDist2mi + Pop_InDist5mi). 
  * Levels:  VL = 0 - 2e3, L = 2e3 - 1e4, M = 1e4 - 5e4, H = 5e4+.
* **Design** = SLD variable D3bpo4

### Household Travel Behavior Inputs {#travel-behavior-inputs}

Many of the inputs relating to household multi-modal travel are those that also can serve as policy levers to be tested in multi-run scenario exercises. Users should work with stakeholders to refine these values and finalize reference scenario inputs that reflect financially constrained adopted plans in their area. These discussions with local staff also start to define more/less ambitious scenarios to include in the multi-run scenario modeling.

* **Transport supply (Mareas only)** Unlike traditional travel demand models, VisionEval does not have a roadway network. The inputs for transportation supply define roadway capacity in terms of lane miles of arterials and freeways and [<span style="color:green">transit service miles</span>](#transit-service-miles) (annual revenue service miles) for each [<span style="color:green">transit service mode</span>](#transit-service-modes)) for the urbanized area portion of each Marea by model run year. A separate Bzone-level input sets neighborhood transit accessibility or [<span style="color:green">Transit D</span>](#transit-d). For lane-miles in the model area, HPMS is the standard source. Users can use use the lane-length values as lane-mile inputs, aggregating as follows:
  * Fwys = "Interstate "& "Other Freeways & Expressways"
  * Arterials = "Other Principal Arterial" & "Minor Arterial" 
  * Major/Minor collectors and local streets are not included

* **Personal short trips/alternative modes.**  VisionEval inputs define policies for transit, bike and walk modes. These include transit service levels and transit accessibility ([<span style="color:green">Transit D</span>](#transit-d)) per transit supply above. Biking trips are defined by the proportion of [<span style="color:green">short-trip SOV diversion</span>](#sov-diversion) (20 miles or less round-trip). Walk while walk trips are dependent upon [<span style="color:green">mixed-use</span>](#mixed-use) development and [<span style="color:green">built form design and measures</span>](#buit-form-measures). 

* **Travel demand management (TDM).** Each household is assigned as a participant or not in a number of travel demand management programs (e.g. employee commute options program, individualized marketing) based on policy assumptions about the degree of deployment of those programs and the household characteristics. Individual households are also identified as candidate participants for car sharing programs based on their household characteristics and input assumptions on the market penetration of car sharing vehicles.  
  * **Workplace TDM Programs.** Level of deployment assumptions for TDM (at work and home locations) lead to reduced VMT, diverting travel to other modes.  Car Sharing reduces VMT through changes in auto ownership and per mile costs. Employee commute options (ECO) programs are work-based travel demand management programs. They may include transportation coordinators, employer-subsidized transit passes, bicycle parking, showers for bicycle commuters, education and promotion, carpool and vanpool programs, etc. The default assumption is that that ECO programs reduce the average commute DVMT of participating households by 5.4%. Users can modify this value but it requires [rebuilding](#ve-buildprocess) the [VELandUse](https://github.com/VisionEval/VisionEval-Dev/tree/development-next/sources/modules/VELandUse) package for VERSPM or [VESimLandUse](https://github.com/VisionEval/VisionEval-Dev/tree/development-next/sources/modules/VESimLandUse) for VE-State. It is assumed that all work travel of the household will be reduced by this percentage if any working age persons are identified as ECO participants. The proportion of employees participating in ECO programs is a policy input at the Bzone-level in VERSPM and either the Azone or Marea level in VE-State.  The input assumes workers participate in a strong employee commute options programs (e.g., free transit pass, emergency ride home, bike rider facilities, etc.).  
  * **Individualized Marketing TDM Programs.** Individualized marketing (IM) programs are travel demand management programs focused on individual households in select neighborhoods. IM programs involve individualized outreach to households that identify residents’ travel needs and ways to meet those needs with less vehicle travel. Customized to the neighborhood, IM programs work best in locations where a number of travel options are available. VisionEval assumes that households participating in an IM program reduce their DVMT by 9% based on studies done in the Portland area. Users can modify this value but it requires [rebuilding](#ve-buildprocess) the [VELandUse](https://github.com/VisionEval/VisionEval-Dev/tree/development-next/sources/modules/VELandUse) package or [VESimLandUse](https://github.com/VisionEval/VisionEval-Dev/tree/development-next/sources/modules/VESimLandUse) for VE-State. IM programs target work as well as non-work travel and produce larger reductions than ECO work-based programs. Only the IM reduction is used for households that are identified as participating in both ECO and IM programs. The VisionEval input for IM programs include an overall assumption for the percentage of households participating in an IM program.  A minimum population density of 4,000 persons per square mile necessary to implement a successful IM program and the requirement that the household reside an [<span style="color:green">urban mixed use</span>](#urban-mixed-use) Bzone. The number of households identified as participating is the minimum of the number needed to meet the program goal or the number of qualifying households.

* **Parking.** Parking in VisionEval is defined by parking supply and [<span style="color:green">parking restrictions</span>](#parking-restrictions), including [<span style="color:green">parking costs</span>](#parking-costs). 

### model_parameters.json
This input file contains global parameters for a particular model configuration that may be used by multiple modules. A more detailed description of the file and its structure can be found [here](https://github.com/visioneval/VisionEval/blob/master/api/model_system_design.md#61-model-directory-structure). The source of the default $16/hr in 2010$ was derived from a Nov 2014 Oregon DOT Report: ["The Value of Travel-Time: Estimates of the Hourly Value of Time for Vehicles in Oregon"](https://www.oregon.gov/ODOT/Data/Documents/Value-of-Travel-Time-for-Vehicles.pdf).  Note the input looks for the dollars in the year of the base model.

The format of this file is as follows:

```json
[
  {"NAME": "ValueOfTime", 
   "VALUE": "16", 
   "TYPE": "double", 
   "UNITS": "base cost year dollars per hour"
  }
]
```

### Vehicle, Fuels and Emissions Inputs {#vehicle-inputs}

Vehicle and fuel technology are expected to change significantly during the next several decades as vehicles turn-over and the newer fleets are purchased. The characteristics of the fleet of new cars and trucks are influenced by federal CAFÉ standards as well as state energy policies and promotions. Local areas can contribute through decisions about the light-duty fleet used by local transit agencies and by assisting in deployment of electric vehicle charging stations and their costs in work and home locations, but otherwise have less influence on the characteristics of the future vehicle fleet, including auto, light truck, and heavy truck vehicles. As a consequence, the VisionEval inputs on vehicle and fuel technology are largely specified modelwide at the [<span style="color:green">region</span>](#region) level. These inputs can be used to assess the impacts of changing vehicle [<span style="color:green">powertrains</span>](#powertrain) and fuels on energy use and GHG emissions in the model area. The key local contribution to these inputs is the bus powertrain and fuels inputs, which are defined by [<span style="color:green">metropolitan area (Marea)</span>](#metropolitan-area) although defaults can be used if no additional local data is available. These variables are briefly summarized below.

* **Powertrains.** Several input files specify vehicle attributes and fuel economy for autos, light trucks, heavy truck, and transit vehicles. User inputs modify vehicle powetrains for commercial service vehicles, car service vehicles, transit vehicles, and heavy trucks. Changing the powertrain mix of household vehicles involves [rebuilding](#ve-buildprocess) the [VEPowertrainsAndFuels](https://github.com/VisionEval/VisionEval-Dev/tree/development-next/sources/modules/VVEPowertrainsAndFuels) package. Four vehicle powertrain types are modeled: 
  * ICE - Internal Combustion Engines  having no electrical assist; 
  * HEV - Hybrid-Electric Vehicles  where all motive power is generated on-board; 
  * PHEV - Plug-in Hybrid Electric Vehicles where some motive power comes from charging an on-board battery from external power supplies; 
  * EV - Electric Vehicles where all motive power comes from charging an on-board battery from external power supplies. 

* **Household owned vehicles.** Household vehicle characteristics are defined by Azone and model run year to account for regional trends. Characteristics include the passanger fleet share by [<span style="color:green">vehicle type</span>](#vehicle-type) (light truck or auto) and average [<span style="color:green">vehicle age</span>](#vehicle-age). The purpose of these inputs is to allow scenarios to be developed which test faster or slower turn-over of the vehicle fleet or test fleets mixes in terms of passenger autos and light trucks or SUVs, both of which impact fuel economy. Users also define the availability of residential electric vehicle charging stations at the Azone level by [<span style="color:green">dwelling unit type</span>](#dwelling-unit-type) and model run year. Vehicle type and age characteristics combine with powertrain sales by year defined in the [VEPowertrainsAndFuels](https://github.com/VisionEval/VisionEval-Dev/tree/development-next/sources/modules/VVEPowertrainsAndFuels) package. Each powertrain in each year has an associated fuel efficiency and power efficiency assumptions for PHEVs (MPG for PHEVs in charge-sustaining mode). For EVs and PHEVs, battery range is specified. Note that the actual EV-HEV split depends on whether enough households have their 95Th percentile daily travel within the EV battery range 

* **Car service vehicles.** Car services are a specific mode used in VisionEval models treated as vehicles available to the household. Car services can be considered a synonym for popular ride-sharing services provided by mobility-as-a-service (MaaS) companies. VisionEval distinguishes between two levels of car service, categorized as “high” or “low” level service. A high car service level is one that has vehicle access times (time to walk between car and origin or final destination) that are competitive with private car use. High level of car service is considered to increase household car availability similar to owning a car. Users can define the [<span style="color:green">car service substitution probability</span>](#car-service-substitution) by [<span style="color:green">vehicle type</span>](#vehicle-type). Low level car service, approximates current taxi service does not have competitive access time and is not considered as increasing household car availability. Users can define different attributes for each level of car service. Users can define several characteristcs of car service by level, including cost per mile by [<span style="color:green">car service level</span>](#car-service-level), average age of car service vehicles, and limits on household  [<span style="color:green">car service substitution probability</span>](#car-service-substitution) for owned vehicles. Region-level inputs on [<span style="color:green">powertrain</span>](#powertrain) mix by model (not sales) year and (optional) region-wide composite fuel carbon intensity. 

See the section on [Pricing, Household Costs & Budgets](#pricing-inputs) inputs for more information on car service levels, geographic coverage, and fees. See the [Vehicles, Fuels & Emissions](#vehicle-inputs) inputs section for more information on defining the car service fleet [<span style="color:green">powertrain</span>](#powertrain) characteristics.   

* **Transit.** Transit vehicles characteristics are defined by Marea and model run year for [<span style="color:green">transit vehicle type</span>](#transit-vehicle-type)(van, bus, rail), including [<span style="color:green">powertrain</span>](#powertrain) mix by model (not sales) year and optional detail on fuel-biofuel shares.  Users can also optionally define region-wide composite fuel carbon intensity by [<span style="color:green">transit vehicle types</span>](#transit-vehicle-type).

* **Freight vehicles (heavy trucks and commercial service).** [<span style="color:green">Commercial service vehicle</span>](#commercial-service) vehicle characteristics are defined by Azone and model run year, including [<span style="color:green">vehicle type</span>](#vehicle-type) shares and average vehicle age. (optional) Region-wide composite fuel carbon intensity by vehicle type. [<span style="color:green">Heavy truck</span>](#heavy-truck) vehicle characteristics are region-level, including [<span style="color:green">powertrain</span>](#powertrain) mix and composite fuel carbon intensity by model (not sales) year.

* **Electric carbon intensity.** Since electricity generation varies by locality, users can define the electricity [<span style="color:green">carbon intensity</span>](#carbon-intensity) at the Azone-level. This impacts GHG emission rates (in average pounds of CO2 equivalents generated per kilowatt hour of electricity consumed by the end user) by local area.

* **Fuel input options**. Three options are available for fuel assumptions. The choices are outlined in the table and options described below. User choice of option can vary by [<span style="color:green">vehicle group</span>](#vehicle-group) and where applicable, [<span style="color:green">vehicle type</span>](#vehicle-type):
1. Default package datasets.  These may represent federal or statewide fuel policies that apply to all metropolitan areas and all vehicle groups in the model (e.g., state ethanol regulations). NAs would be placed in all user input files. 
2. Detailed fuel and biofuel inputs. Values for the proportions of fuels types (gasoline, diesel, compressed natural gas), as well as fuel blend proportions (gasoline blended with ethanol, biodiesel blended with diesel, renewable natural gas is blended with natural gas). A third assumption specifies the carbon_intenaity of the fuels (input or default). For example, heavy trucks can be set to 95% diesel, 5% natural gas, with diesel having a 5% biodiesel blend. 
3. Composite carbon intensity. This option simplifies the process of modeling emissions policies, particularly low carbon fuels policies by bypasses the need to specify fuel types and biofuel blends. Average carbon intensity by vehicle group and if applicable, vehicle type is specified directly. These inputs, if present and not 'NA', supercede other transit inputs. 
  * Note:  Given that transit agencies in different metropolitan areas may have substantially different approaches to using biofuels, transit vehicles have the option of region or metropolitan area specifications for Options (1) and (2).  
  * Note: The proportions in option (2) do not represent volumetric proportions (e.g. gallons), they represent energy proportions (e.g. gasoline gallon equivalents) or DVMT proportions.
  * Note:  Individual vehicles are modeled for households. Other groups vehicle and fuel attributes apply to VMT.  As a result, PHEVs in all but household vehicles should be split into miles driven in HEVs and miles in EVs.

|Vehicle Group|Vehicle Types|Powertrain Options|Veh Inputs|Fuel Options|Fuel input options|
|----|--------|-------|----------|----------|----------|
|Household|automobile, light truck|ICE, HEV, PHEV, EV|(default veh mix), age, %LtTrk|gas/ethanol, diesel/biodiesel, CNG/RNG|default, region composite|
|Car Service|automobile, light truck|ICE, HEV, EV|veh mix, age (HH veh mix)|gas/ethanol, diesel/biodiesel, CNG/RNG|default, region composite|
|Commercial Service|automobile, light truck|ICE, HEV, EV|veh mix, age, %LtTrk|gas/ethanol, diesel/biodiesel, CNG/RNG|default, region composite|
|Heavy Truck|heavy truck|ICE, HEV, EV|veh mix|gas/ethanol, diesel/biodiesel, CNG/LNG|default, region composite|
|Public Transit|van, bus, rail|ICE, HEV, EV|veh mix|gas/ethanol, diesel/biodiesel, CNG/RNG|default, fuel/biofuel mix, marea or region composite|

### Pricing, Household Costs & Budget Inputs {#pricing-inputs}

Most of these will be state-led actions and thus reflect the state policies of the modeled area.

* **Per mile vehicle out-of-pocket costs.**  Several inputs define the per mile costs used in calculating household [<span style="color:green">vehicle operating costs</span>](#vehicle-operating-costs) that may be limited by the household's income-based maximum annual travel budget. These inputs include those defining energy costs, [<span style="color:green">car service</span>](#car-service) fees, and fees to recover road and social costs, as noted below. 

* **Energy costs.** Unit cost of energy to power household vehicles, both fuel (cost per gallon) and electricity (cost per kilowatt-hour). 

* **Car service fees.** If car service is used by a household, the per mile fees paid for that service, outside of energy costs. Car service characteristics cost per mile by [[<span style="color:green">car service level</span>](#car-service-level)  by Azone and model run year.

* **Road cost recovery VMT fee.** Inputs include a fuel tax or levying a fuel-equivalent tax on travel by some/all electric vehicles (PevSurchgTaxProp), for their use of roads in lieu of gas purchases. User can also directly specify a VMT (mileage) fee, to further recover road costs, or optionally flag VisionEval to iteratively estimate the VMT fee to fully recover user-defined road costs incurred by household VMT.  

* **Social cost recovery.**  (Optional) Inputs allow per mile fee to cover social costs or externalities, not recovered in this way today, but instead incur costs elsewhere in the economy (e.g., safety, health).  This is the cost imposed on society and future generations, not the cost to the vehicle user. This requires assumptions on the cost incurred from these externalities (per mile, per gallon) and the proportion to be paid by drivers as a per mile fee (varies by vehicle powertrain).  The Social Externality costs are specified in the VETravelPerformance package External Data files. The values are in 2010$. [Click here](https://github.com/RSGInc/VisionEval-Dev/blob/development-next/sources/modules/VETravelPerformance/inst/module_docs/CalculateVehicleOperatingCost.md#social-costs) for additional detailed explanation of on the way the costs are used in the model. [See the PDF](media/STS_White_Paper_on_External_Costs_9-21-2011.pdf) for externality research.

* **Per mile time-equivalent costs.** Users can define the [<span style="color:green">value of time</span>](#value-of-time), which is included in [<span style="color:green">vehicle operating costs</span>](#vehicle-operating-costs) calculations. The model calculates travel time (model-calculated), which includes time to access vehicle on both ends of trip (between vehicle parking location and origin or end destination), multiplied by value of time.

* **Annual vehicle ownership costs.** [<span style="color:green">Vehicle ownership cost</span>](#vehicle-operating-costs) inputs are defined at the Azone-level by year. These inputs include annual vehicle fees (flat fee and/or tax on vehicle value), [<span style="color:green">pay-as-you-drive (PAYD)</span>](#pay-as-you-drive) insurance participation rates, residential parking limitations and fees, that are combined with model-estimated ownership costs (financing, depreciation, insurance).

* **Congestion Fees.** [<span style="color:green">Congestion fees</span>](#congestion-fees) are defined by Marea. The input is the average amount paid per mile in congestion pricing fee. The congestion fees are specified for each of the congestion bands in the model for both Arterial Congestion Fees and Freeway Congestion Fees. 

### Congestion Inputs {#congestion-inputs}

* **Base year VMT.** Users provide can provide base year VMT (for both light-duty vehicles and heavy trucks) or use the model default by using a state/UzaLookup. Users also select a growth basis for heavy trucks of either population or income and for commercial service VMT (population, income, or household VMT). Users also provide the DVMT split of light-duty vehicles, heavy trucks, and buses on urban roads by [<span style="color:green">road class</span>](#road-class). Values for UzaNameLookup must be present in the list provided in the [module documentation](https://github.com/VisionEval/VisionEval-Dev/blob/development-next/sources/modules/VETravelPerformance/inst/module_docs/Initialize.md), otherwise user inputs must specify the data directly.

* **ITS-Operational Policies.** Users define the proportion of VMT by [<span style="color:green">road class</span>](#road-class) affected by standard ITS-Operation policies on freeways and arterials. Another optional input can define additional operations effects, providing flexibility for future user-defined freeway and arterial operations program coverage and  effectiveness. These programs reduce delay. The specific ITS programs available in the model are the following:
  * **Freeway ramp metering** - Metering freeways can reduce delay by keeping mainline vehicle density below unstable levels. It creates delay for vehicles entering the freeway, but this is typically more than offset by the higher speeds and postponed congestion on the freeway facility. The Urban Mobility Report cites a delay reduction of 0 to 12%, with an average of 3%, for 25 U.S. urban areas with ramp metering.  Only urban areas with Heavy, Severe, and Extreme freeway congestion can benefit from ramp metering in RSPM
  * **Freeway incident management** - Incident Response programs are designed to quickly detect and remove incidents which impede traffic flow. The UMR study  reports incident-related freeway delay reductions of 0 to 40%, with an average of 8%, for the 79 U.S. urban areas with incident response programs. This reflects the combined effects of both service patrols to address the incidents and surveillance cameras to detect the incidents. Effects were seen in all sizes of urban area, though the impacts were greater in larger cities. 
  * **Arterial access management** – Access management on arterials can increase speeds by reducing the number of enter/exit points on the arterial and reduce crashes by reducing conflict points. Although improvements such as raised medians can reduce throughput by causing turning queue spillback during heavy congestion, other types of access management, such as reduced business ingress/egress points, show consistent benefits system-wide.
  * **Arterial signal coordination** – Traffic signal coordination, particularly for adaptive traffic signals, can reduce arterial delay by increasing throughput in peak flow directions. UMR and other analysis estimates delay reductions of up to 6-9% due to signal coordination, with more potential savings from more sophisticated control systems. An average arterial delay savings was found to be about 1%.
  * **Other ops programs** – A separate input that gives users the ability to accommodate future enhancements.  Further research and significant program investment would be needed to justify benefits in these enhanced ITS programs.

* **Speed smoothing programs.** Proportion of VMT by [<span style="color:green">road class</span>](#road-class) covered by ITS [<span style="color:green">speed smoothing</span>](#speed-smoothing), and [<span style="color:green">Eco-drive programs</span>](#ecodrive). These programs reduce vehicle accelerations and decelerations, but do not affect delay. 
  * **Speed smoothing programs** - Insufficient aggregate performance data is available for a number of other current and future ITS/operations strategies.  These include: speed limit reductions, speed enforcement, and variable speed  limits that reduce the amount of high-speed freeway travel; advanced signal optimization techniques that reduce stops and starts on arterials; and truck/bus-only lanes that can move high-emitting vehicles through congested areas at improved efficiency. Literature review of fuel efficiency improvements found that speed smoothing policies could only reasonably achieve a portion of the theoretical maximum of 50%, which is the ratio applied to the user input of full deployment (input of 1=100%).
  * **Eco-drive programs** Eco-driving involves educating motorists on how to drive in order to reduce fuel consumption and cut emissions. Examples of eco-driving practices include avoiding rapid starts and stops, matching driving speeds to synchronized traffic signals, and avoiding idling. Practicing eco-driving also involves keeping vehicles maintained in a way that reduces fuel consumption such as keeping tires properly inflated and reducing aerodynamic drag. In RSPM, fuel economy benefits of improved vehicle maintenance are included in the eco-driving benefit. A default 19% improvement in vehicle fuel economy is assumed. Vehicle operations and maintenance programs (e.g. eco-driving) based on policy assumptions about the degree of deployment of those programs and the household characteristics.  Vehicle operating programs (eco-driving) reduces emissions per VMT at a max of 33% for freeways and 21% for arterials for full deployment (input of 1=100%).

## VERSPM Input Files {#verspm-inputs}

This section details the specific VERSPM input files.

* [**azone_carsvc_characteristics.csv**](#verspm-azone_carsvc_characteristics.csv): This file specifies the different characteristics for high and low car service level and is used in the [CreateVehicleTable](#verspm-createvehicletable) and [AssignVehicleAge](#verspm-assignvehicleage) modules. 

* [**azone_charging_availability.csv**](#verspm-azone_charging_availability.csv) This file has data on proportion of different household types who has EV charging available  and is used in the [AssignHHVehiclePowertrain](#verspm-assignhhvehiclepowertrain) module.          

* [**azone_electricity_carbon_intensity.csv**](#verspm-azone_electricity_carbon_intensity.csv) <span style="color:red">(optional)</span> This file is used to specify the carbon intensity of electricity and is only needed if user wants to modify the values). The file is used in [Initialize (VEPowertrainsAndFuels)](Modules_and_Outputs.md/#initialize-vepowertrainsandfuels
) and [CalculateCarbonIntensity](#verspm-calculatecarbonintensity) modules.      

* [**azone_fuel_power_cost.csv**](#verspm-azone_fuel_power_cost.csv) This file supplies data for retail cost of fuel and electricity and is used in the [CalculateVehicleOperatingCost](#verspm-calculatevehicleoperatingcost) module.         

* [**azone_gq_pop_by_age.csv**](#verspm-azone_gq_pop_by_age.csv): This file contains group quarters population estimates/forecasts by age and is used in the [CreateHouseholds](#verspm-createhouseholds) module.                    
* [**azone_hh_pop_by_age.csv**](#verspm-household-population-azone_hh_pop_by_age.csv) This file contains population estimates/forecasts by age and is used in the [CreateHouseholds](#verspm-createhouseholds) module. 

* [**azone_hh_veh_mean_age.csv**](#verspm-azone_hh_veh_mean_age.csv) This file provides inputs for mean auto age and mean light truck age and is used in the [AssignVehicleAge](#verspm-assignvehicleage) module.

* [**azone_hh_veh_own_taxes.csv**](#verspm-azone_hh_veh_own_taxes.csv) This file provides inputs for flat fees/taxes (i.e. annual cost per vehicle) and ad valorem taxes (i.e. percentage of vehicle value paid in taxes). The file is used in [CalculateVehicleOwnCost](#verspm-calculatevehicleowncost) module.             
* [**azone_hhsize_targets.csv**](#verspm-azone_hhsize_targets.csv): This file contains the household specific targets and is used in [CreateHouseholds](#verspm-createhouseholds) module.            

* [**azone_lttrk_prop.csv**](#verspm-azone_lttrk_prop.csv) This file specifies the light truck proportion of the vehicle fleet and is used in [AssignVehicleType](#verspm-assignvehicletype) module.

* [**azone_payd_insurance_prop.csv**](#verspm-azone_payd_insurance_prop.csv) This file provides inputs on the proportion of households having PAYD (pay-as-you-drive) insurance and is used in the [CalculateVehicleOwnCost](#verspm-calculatevehicleowncost) module.               

* [**azone_per_cap_inc.csv**](#verspm-azone_per_cap_inc.csv) This file contains information on regional average per capita household and group quarters income in year 2010 dollars and is used in the [PredictIncome](#verspm-predictincome) module.                 

* [**azone_prop_sov_dvmt_diverted.csv**](#verspm-azone_prop_sov_dvmt_diverted.csv) This file provides inputs for a goal for diverting a portion of SOV travel within a 20-mile tour distance and is used in the [DivertSovTravel](#verspm-divertsovtravel) module.            

* [**azone_relative_employment.csv**](#verspm-azone_relative_employment.csv): This file contains ratio of workers to persons by age and is used in the [PredictWorkers](#verspm-predictworkers) module. 

* [**azone_veh_use_taxes.csv**](#verspm-azone_veh_use_taxes.csv) This file supplies data for vehicle related taxes and is used in the [CalculateVehicleOperatingCost](#verspm-calculatevehicleoperatingcost) module.         

* [**azone_vehicle_access_times.csv**](#verspm-azone_vehicle_access_times.csv) This file supplies data for vehicle access and egress time and is used in the [CalculateVehicleOperatingCost](#verspm-calculatevehicleoperatingcost) module.        

* [**bzone_transit_service.csv**](#verspm-bzone_transit_service.csv) This file supplies the data on relative public transit accessibility and is used in the [AssignTransitService](#verspm-assigntransitservice) module.                    

* [**bzone_carsvc_availability.csv**](#verspm-bzone_carsvc_availability.csv) This file contains the information about level of car service availability and is used in the [AssignCarSvcAvailability](#verspm-assigncarsvcavailability) module. 

* [**bzone_dwelling_units.csv**](#verspm-dwelling-units-bzone_dwelling_units.csv): This file contains the number single-family, multi-family and group-quarter dwelling units and is used in the [PredictHousing](#verspm-predicthousing) module.                    

* [**bzone_employment.csv**](#verspm-bzone_employment.csv): This file contains the total, retail and service employment by zone and is used in the [LocateEmployment](#verspm-locateemployment) module.

* [**bzone_hh_inc_qrtl_prop.csv**](#verspm-household-proportion-by-income-bzone_hh_inc_qrtl_prop.csv) This file contains the proportion of households in 1st, 2nd, 3rd, and 4th quartile of household income and is used in the [PredictHousing](#verspm-verspm-predicthousing) module.                  

* [**bzone_lat_lon.csv**](#verspm-bzone_lat_lon.csv) This file contains the latitude and longitude of the centroid of the zone and is used in the [LocateEmployment](#verspm-locateemployment) module.                     
* [**bzone_network_design.csv**](#verspm-bzone_network_design.csv) This file contains the intersection density in terms of pedestrian-oriented intersections having four or more legs per square mile and is used in the [Calculate4DMeasures](#verspm-calculate4dmeasures) module. 

* [**bzone_parking.csv**](#verspm-bzone_parking.csv) This file contains the parking information and is used in the [AssignParkingRestrictions](#verspm-assignparkingrestrictions) module.            

* [**bzone_travel_demand_mgt.csv**](#verspm-bzone_travel_demand_mgt.csv) This file contains the information about workers and households participating in demand management programs and is used in the [AssignDemandManagement](#verspm-assigndemandmanagement) module. 

* [**bzone_unprotected_area.csv**](#verspm-bzone_unprotected_area.csv) This file contains the information about unprotected (i.e., developable) area within the zone and is used in the [Calculate4DMeasures](#verspm-calculate4dmeasures) module.

* [**bzone_urban-mixed-use_prop.csv**](#verspm-bzone_urban-mixed-use_prop.csv) This file contains the target proportion of households located in mixed-used neighborhoods in zone and is used in the [CalculateUrbanMixMeasure](#verspm-calculateurbanmixmeasure) module.

* [**bzone_urban-town_du_proportions.csv**](#verspm-bzone_urban-town_du_proportions.csv) This file contains proportion of Single-Family, Multi-Family and Group Quarter dwelling units within the urban portion of the zone and is used in the [AssignLocTypes](#verspm-assignloctypes) module.         

* [**marea_base_year_dvmt.csv**](#verspm-marea_base_year_dvmt.csv) <span style="color:red">(optional)</span> This file is used to specify to adjust the DVMT growth factors and is only needed if user wants to modify the values. The file is used in the [Initialize (VETravelPerformance)](#verspm-initialize-vetravelperformance), [CalculateBaseRoadDvmt](#verspm-calculatebaseroaddvmt) and [CalculateFutureRoadDvmt](#verspm-calculatefutureroaddvmt) modules.

* [**marea_congestion_charges.csv**](#verspm-marea_congestion_charges.csv) <span style="color:red">(optional)</span> This file is used to specify the charges of vehicle travel for different congestion levels. The file is used in the [Initialize (VETravelPerformance)](#verspm-initialize-vetravelperformance) and [CalculateRoadPerformance](#verspm-calculateroadperformance) modules.               

* [**marea_dvmt_split_by_road_class.csv**](#verspm-marea_dvmt_split_by_road_class.csv) <span style="color:red">(optional)</span> This file is used to specify the DVMT split for different road classes. The file is used in the [Initialize (VETravelPerformance)](#verspm-initialize-vetravelperformance) and [CalculateBaseRoadDvmt](#verspm-calculatebaseroaddvmt) modules.         

* [**marea_lane_miles.csv**](#verspm-marea_lane_miles.csv) This file contains inputs on the numbers of freeway lane-miles and arterial lane-miles and is used in the [AssignRoadMiles](#verspm-assignroadmiles) module.                   

* [**marea_operations_deployment.csv**](#verspm-marea_operations_deployment.csv) <span style="color:red">(optional)</span> This file is used to specify the proportion of DVMT affected by operations for different road classes. The file is used in the [Initialize (VETravelPerformance)](#verspm-initialize-vetravelperformance) and [CalculateRoadPerformance](#verspm-calculateroadperformance) modules.        

* [**marea_speed_smooth_ecodrive.csv**](#verspm-marea_speed_smooth_ecodrive.csv) This input file supplies information of deployment of speed smoothing and ecodriving by road class and vehicle type and is used in the [CalculateMpgMpkwhAdjustments](#verspm-calculatempgmpkwhadjustments) module.   

* [**marea_transit_ave_fuel_carbon_intensity.csv**](#verspm-marea_transit_ave_fuel_carbon_intensity.csv) <span style="color:red">(optional)</span> This file is used to specify the average carbon intensity of fuel used by transit. The file is used in the [Initialize (VETravelPerformance)](#verspm-initialize-vetravelperformance) module. 

* [**marea_transit_biofuel_mix.csv**](#verspm-marea_transit_biofuel_mix.csv) <span style="color:red">(optional)</span> This file is used to specify the biofuel used by transit. The file is used in the [Initialize (VETravelPerformance)](#verspm-initialize-vetravelperformance) and [CalculateCarbonIntensity](#verspm-calculatecarbonintensity) modules.             

* [**marea_transit_fuel.csv**](#verspm-marea_transit_fuel.csv) <span style="color:red">(optional)</span> This file is used to specify the transit fuel proportions. The file is used in the [Initialize (VETravelPerformance)](#verspm-initialize-vetravelperformance) and [CalculateCarbonIntensity](#verspm-calculatecarbonintensity) modules.                  

* [**marea_transit_powertrain_prop.csv**](#verspm-marea_transit_powertrain_prop.csv) <span style="color:red">(optional)</span> This file is used to specify the mixes of transit vehicle powertrains. The file is used in the [Initialize (VETravelPerformance)](#verspm-initialize-vetravelperformance) and [CalculatePtranEnergyAndEmissions](#verspm-calculateptranenergyandemissions)  modules. 

* [**marea_transit_service.csv**](#verspm-marea_transit_service.csv) This file contains annual revenue-miles for different transit modes for metropolitan area and is used in the [AssignTransitService](#verspm-assigntransitservice) module.                   

* [**other_ops_effectiveness.csv**](#verspm-other_ops_effectiveness.csv) <span style="color:red">(optional)</span> This file is used to specify the delay effects of operations in different road classes and is only needed if user wants to modify the values. The file is used in the [Initialize (VETravelPerformance)](#verspm-initialize-vetravelperformance) and [CalculateRoadPerformance](#verspm-calculateroadperformance) modules. 

* [**region_ave_fuel_carbon_intensity.csv**](#verspm-region_ave_fuel_carbon_intensity.csv) <span style="color:red">(optional)</span> This file is used to specify the average carbon density for different vehicle types and is optional (only needed if user wants to modify the values). The file is used in the [Initialize (VETravelPerformance)](#verspm-initialize-vetravelperformance) and [CalculateCarbonIntensity](#verspm-calculatecarbonintensity) modules.       

* [**region_base_year_hvytrk_dvmt.csv**](#verspm-region_base_year_hvytrk_dvmt.csv) <span style="color:red">(optional)</span> This file is used to specify the heavy truck dvmt for base year. The file is used in the [Initialize (VETravelPerformance)](#verspm-initialize-vetravelperformance), [CalculateBaseRoadDvmt](#verspm-calculatebaseroaddvmt) and [CalculateFutureRoadDvmt](#verspm-calculatefutureroaddvmt) modules.            

* [**region_carsvc_powertrain_prop.csv**](#verspm-region_carsvc_powertrain_prop.csv) <span style="color:red">(optional)</span> This file is used to specify the powertrain proportion of car services. The file is used in the [Initialize (VETravelPerformance)](#verspm-initialize-vetravelperformance), [AssignHhVehiclePowertrain](#verspm-assignhhvehiclepowertrain) and [AdjustHhVehicleMpgMpkwh](#verspm-adjusthhvehiclempgmpkwh) modules.                    

* [**region_comsvc_lttrk_prop.csv**](#verspm-region_comsvc_lttrk_prop.csv) This file supplies data for the light truck proportion of commercial vehicles and is used in the [CalculateComEnergyAndEmissions](#verspm-calculateptranenergyandemissions) module.       

* [**region_comsvc_powertrain_prop.csv**](#verspm-region_comsvc_powertrain_prop.csv) <span style="color:red">(optional)</span> This file is used to specify the powertrain proportion of commercial vehicles. The file is used in the [Initialize (VEPowertrainsAndFuels)](#verspm-initialize-vepowertrainsandfuels)
) and [CalculateComEnergyAndEmissions](#verspm-calculateptranenergyandemissions) modules. 
* [**region_hh_driver_adjust_prop.csv**](#region_hh_driver_adjust_prop.csv) <span style="color:red">(optional)</span> This file specifies the relative driver licensing rate relative to the model estimation data year and is used in the [AssignDrivers](#verspm-assigndrivers) module. 

* [**region_hvytrk_powertrain_prop.csv**](#verspm-region_hvytrk_powertrain_prop.csv) <span style="color:red">(optional)</span> This file is used to specify the powertrain proportion of heavy duty trucks. The file is used in the [Initialize (VEPowertrainsAndFuels)](#verspm-initialize-vepowertrainsandfuels)
) and [CalculateComEnergyAndEmissions](#verspm-calculateptranenergyandemissions) modules.

* [**region_prop_externalities_paid.csv**](#verspm-region_prop_externalities_paid.csv) This file supplies data for climate change and other social costs and is used in the [CalculateVehicleOperatingCost](#verspm-calculatevehicleoperatingcost) module. 

### azone_carsvc_characteristics.csv {#verspm-azone_carsvc_characteristics.csv}
This file specifies the different characteristics for high and low car service levels by `Azone`. More information on car service can be found here(placeholder). Changing this input is *optional* and using the default input values is standard practice. 

- **HighCarSvcCost**: Average cost in dollars per mile for travel by high service level car service exclusive of the cost of fuel, road use taxes, and any other social costs charged to vehicle use
- **LowCarSvcCost**: Average cost in dollars per mile for travel by low service level car service exclusive of the cost of fuel, road use taxes, and any other social costs charged to vehicle use
- **AveCarSvcVehicleAge**: Average age of car service vehicles in years
- **LtTrkCarSvcSubProp**: The proportion of light-truck owners who would substitute a less-costly car service option for owning their light truck
- **AutoCarSvcSubProp**: The proportion of automobile owners who would substitute a less-costly car service option for owning their automobile

Here is a snapshot of the file:

| Geo | Year | HighCarSvcCost.2010 | LowCarSvcCost.2010 | AveCarSvcVehicleAge | LtTrkCarSvcSubProp | AutoCarSvcSubProp |
| :--- | :----: | :----: | :----: | :----: | :----: | :----: |
| RVMPO | 2010 | 1 | 3 | 3 | 0.75 | 1 |
| RVMPO | 2038 | 1 | 3 | 3 | 0.75 | 1 |

### azone_charging_availability.csv {#verspm-azone_charging_availability.csv}
This input file supplies data on proportion of different household types with plug-in electric vehicle (PEV) charging available by `Azone`.

- **PropSFChargingAvail**: Proportion of single-family dwellings in Azone that have PEV charging facilities installed or able to be installed
- **PropMFChargingAvail**: Proportion of multifamily dwelling units in Azone that have PEV charging facilities available
- **PropGQChargingAvail**: Proportion of group quarters dwelling units in Azone that have PEV charging facilities available

Here is a snapshot of the file:	


|Geo   | Year | PropSFChargingAvail | PropMFChargingAvail | PropGQChargingAvail |
|:-----|:----:|:-------------------:|:-------------------:|:-------------------:|
|RVMPO | 2010 |          1          |         0.0         |          0          |
|RVMPO | 2038 |          1          |         0.2         |          0          |



### azone_electricity_carbon_intensity.csv {#verspm-azone_electricity_carbon_intensity.csv}

This input file specifies the carbon intensity of electricity by `Azone`. This input file is OPTIONAL and is only needed if the user wants to modify the carbon intensity of electricity.

* **ElectricityCI**: Carbon intensity of electricity at point of consumption (grams CO2e per megajoule)

Here is a snapshot of the file:

| Geo | Year | ElectricityCI |
| :--- | :----: | :----: |
| RVMPO | 2010 | 153 |
| RVMPO | 2038 | 23 |

### azone_fuel_power_cost.csv {#verspm-azone_fuel_power_cost.csv}
This file supplies data for retail cost of fuel and electricity by `Azone`. This input can be developed using local history or querying the Energy Information Administration (EIA) for historical [gasoline and diesel](https://www.eia.gov/petroleum/) and [power](https://www.eia.gov/electricity/) prices. 

* **FuelCost**:Retail cost of fuel per gas gallon equivalent in dollars (before taxes are added)
* **PowerCost**: Retail cost of electric power per kilowatt-hour in dollars (before taxes are added)
  

Here is a snapshot of the file:

| Geo | Year | FuelCost.2005 | PowerCost.2005 |
| :--- | :----: | :----: | :----: |
|RVMPO | 2010 | 2.43 | 0.08 |
|RVMPO | 2038 | 5.75 | 0.208 |

### azone_gq_pop_by_age.csv {#verspm-azone_gq_pop_by_age.csv}
This file contains group quarters population estimates/forecasts by age for each of the base and future years. The file format includes number of persons within the following six age categories:

* 0-14
* 15-19
* 20-29
* 30-54
* 55-64
* 65 Plus

Group quarters are distinguished between two types: institutional and non-institutional. Institutional group quarter populations are those in correctional facilities or nursing homes. Non-institutional group quarters include college dormitories, military barracks, group homes, missions, or shelters. Only non-institutional group quarters are included in the modeled population, given the assumption that institutional group quarters populations do not account for much, if any, travel. Base year data for group quarter populations can be sourced from the Census.

Here is a snapshot of the file:
<div style="border: 0px;overflow-x: scroll; width:100%; "><table class="table" style="margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> Geo </th>
   <th style="text-align:right;"> Year </th>
   <th style="text-align:right;"> GrpAge0to14 </th>
   <th style="text-align:right;"> GrpAge15to19 </th>
   <th style="text-align:right;"> GrpAge20to29 </th>
   <th style="text-align:right;"> GrpAge30to54 </th>
   <th style="text-align:right;"> GrpAge55to64 </th>
   <th style="text-align:right;"> GrpAge65Plus </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> RVMPO </td>
   <td style="text-align:right;"> 2010 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 666 </td>
   <td style="text-align:right;"> 382 </td>
   <td style="text-align:right;"> 66 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RVMPO </td>
   <td style="text-align:right;"> 2038 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 666 </td>
   <td style="text-align:right;"> 382 </td>
   <td style="text-align:right;"> 66 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
</tbody>
</table></div>




### azone_hh_pop_by_age.csv {#verspm-azone_hh_pop_by_age.csv}
This file contains population estimates/forecasts by age for each of the base and future years. The file format includes number of persons within six age groups:

* 0-14
* 15-19
* 20-29
* 30-54
* 55-64
* 65 Plus
  

Base year data for population by age category can be sourced from the Census. Future year data must be developed by the user; in many regions population forecasts are available from regional or state agencies such as population data centers, universities, metropolitan planning organizations, or similar agencies.

Here is a snapshot of the file:

| Geo | Year | Age0to14 | Age15to19 | Age20to29 | Age30to54 | Age55to64 | Age65Plus |
| :--- | :----: | :----: | :----: | :----: | :----: | :----: | :----: |
| RVMPO | 2010 | 30193 | 10970 | 20557 | 52327 | 24840 | 29240 |
| RVMPO | 2038 | 39759 | 12781 | 24972 | 75984 | 27563 | 66139 |

### azone_hh_veh_mean_age.csv {#verspm-azone_hh_veh_mean_age.csv}
This file provides inputs for mean auto age and mean light truck age by `Azone`. The user can develop this file using State DMV data.

* **AutoMeanAge**: Mean age of automobiles owned or leased by households.
* **LtTrkMeanAge**: Mean age of light trucks owned or leased by households.

Here is a snapshot of the file:


|Geo   | Year | AutoMeanAge | LtTrkMeanAge |
|:-----|:----:|:-----------:|:------------:|
|RVMPO | 2010 |    10.8     |     10.5     |
|RVMPO | 2038 |    12.0     |     12.0     |



### azone_hh_veh_own_taxes.csv {#verspm-azone_hh_veh_own_taxes.csv}
This file provides inputs for flat fees/taxes (i.e. annual cost per vehicle) and ad valorem taxes (i.e. percentage of vehicle value paid in taxes).

* **VehOwnFlatRateFee**: Annual flat rate tax per vehicle in dollars
* **VehOwnAdValoremTax**: Annual proportion of vehicle value paid in taxes
  

Here is a snapshot of the file:


|Geo   | Year | VehOwnFlatRateFee.2015 | VehOwnAdValoremTax |
|:-----|:----:|:----------------------:|:------------------:|
|RVMPO | 2010 |           50           |        0.00        |
|RVMPO | 2038 |           0            |        0.01        |



### azone_hhsize_targets.csv {#verspm-azone_hhsize_targets.csv}
This file contains the household-specific targets for the population synthesizer. This file contains two attributes:

* **AveHhSize**: Average household size for non-group quarters households
* **Prop1PerHh**: Proportion of non-group quarters households having only one person

Household size data for the base year can be sourced from the Census. 

Here is a snapshot of the file:

| Geo | Year | AveHhSize | Prop1PerHh |
| :--- | :----: | :----: | :----: |
| RVMPO | 2010 | NA | 0.3 |
| RVMPO | 2038 | NA | NA |

### azone_lttrk_prop.csv {#verspm-azone_lttrk_prop.csv}

This file specifies the light truck proportion of the vehicle fleet. The user can be developed from local registration data. Alternatively, if MOVES is available for the model region, this input can be calculated from the MOVES vehicle population data (SourceTypeYear). The vehicle types used in MOVES (SourceType) correspond with the two categories of passenger vehicles used in VisionEval: MOVES SourceType 21, Passenger Car, is equivalent to autos in VisionEval and MOVES Source Type 31, Passenger Truck, is equivalent to light trucks.

* **LtTrkProp**: Proportion of household vehicles that are light trucks (pickup, SUV, van).
  

Here is a snapshot of the file:


|Geo   | Year | LtTrkProp |
|:-----|:----:|:---------:|
|RVMPO | 2010 |   0.45    |
|RVMPO | 2038 |   0.34    |



### azone_payd_insurance_prop.csv {#verspm-azone_payd_insurance_prop.csv}
This file provides inputs on the proportion of households having PAYD insurance.

* **PaydHhProp**: Proportion of households in the Azone who have pay-as-you-drive insurance for their vehicles
  

Here is a snapshot of the file:


|Geo   | Year | PaydHhProp |
|:-----|:----:|:----------:|
|RVMPO | 2010 |    0.01    |
|RVMPO | 2038 |    0.50    |



### azone_per_cap_inc.csv {#verspm-azone_per_cap_inc.csv}

This file contains information on regional average per capita household (`HHIncomePC`) and group quarters (`GQIncomePC`) income by forecast year in year 2010 dollars. The data can be obtained from the U.S. Department of Commerce Bureau of Economic Analysis for the current year or from regional or state sources for forecast years. In order to use current year dollars just replace 2010 in column labels with current year. For example, if the data is obtained in year 2015 dollars then the column labels in the file shown below will become `HHIncomePC.2015` and `GQIncomePC.2015`. 

Here is a snapshot of the file:


|Geo   | Year | HHIncomePC.2010 | GQIncomePC.2010 |
|:-----|:----:|:---------------:|:---------------:|
|RVMPO | 2010 |      32164      |      7500       |
|RVMPO | 2038 |      43334      |      10000      |



### azone_prop_sov_dvmt_diverted.csv {#verspm-azone_prop_sov_dvmt_diverted.csv}

This file provides inputs for a goal for diverting a portion of SOV travel within a 20-mile tour distance (round trip distance). The user can use  local household travel survey data (if available) to develop this input.

* **PropSovDvmtDiverted**: Goals for the proportion of household DVMT in single occupant vehicle tours with round-trip distances of 20 miles or less be diverted to bicycling or other slow speed modes of travel
  

Here is a snapshot of the file:


|Geo   | Year | PropSovDvmtDiverted |
|:-----|:----:|:-------------------:|
|RVMPO | 2010 |        0.04         |
|RVMPO | 2038 |        0.80         |



### azone_relative_employment.csv {#verspm-azone_relative_employment.csv}

This file contains the ratio of workers to persons by age cohort in the model year relative to the model estimation data year. This file contains five age cohorts:

* **RelEmp15to19**: Ratio of workers to persons age 15 to 19 in model year versus in estimation data year
* **RelEmp20to29**: Ratio of workers to persons age 20 to 29 in model year versus in estimation data year
* **RelEmp30to54**: Ratio of workers to persons age 30 to 54 in model year versus in estimation data year
* **RelEmp55to64**: Ratio of workers to persons age 55 to 64 in model year versus in estimation data year
* **RelEmp65Plus**: Ratio of workers to persons age 65 or older in model year versus in estimation data year

Setting a value of 1 assumes that the ratio of workers to persons is consistent with estimation data for that specific age cohort.

Here is a snapshot of the file:
<div style="border: 0px;overflow-x: scroll; width:100%; "><table class="table" style="margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> Geo </th>
   <th style="text-align:center;"> Year </th>
   <th style="text-align:center;"> RelEmp15to19 </th>
   <th style="text-align:center;"> RelEmp20to29 </th>
   <th style="text-align:center;"> RelEmp30to54 </th>
   <th style="text-align:center;"> RelEmp55to64 </th>
   <th style="text-align:center;"> RelEmp65Plus </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> RVMPO </td>
   <td style="text-align:center;"> 2010 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RVMPO </td>
   <td style="text-align:center;"> 2038 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
</tbody>
</table></div>



### azone_veh_use_taxes.csv {#verspm-azone_veh_use_taxes.csv}

This file supplies data for vehicle taxes related to [auto operating costs](#auto-operating-cost)

* **FuelTax**:Tax per gas gallon equivalent of fuel in dollars
* **VmtTax**: Tax per mile of vehicle travel in dollars
* **PevSurchgTaxProp**: Proportion of equivalent gas tax per mile paid by hydrocarbon fuel consuming vehicles to be charged to plug-in electric vehicles per mile of travel powered by electricity

Here is a snapshot of the file:	

| Geo   | Year | FuelTax.2005 | VmtTax.2005 | PevSurchgTaxProp |
| ----- | ---- | ------------ | ----------- | ---------------- |
| RVMPO | 2010 | 0.424        | 0           | 0                |
| RVMPO | 2038 | 0.484        | 0           | 0                |

### azone_vehicle_access_times.csv {#verspm-azone_vehicle_access_times.csv}

This file supplies data for vehicle access and eagress time.

* **OwnedVehAccessTime**:Average amount of time in minutes required for access to and egress from a household-owned vehicle for a trip
* **HighCarSvcAccessTime**: Average amount of time in minutes required for access to and egress from a high service level car service for a trip
* **LowCarSvcAccessTime**: Average amount of time in minutes required for access to and egress from a low service level car service for a trip
  

Here is a snapshot of the file:	

| Geo   | Year | OwnedVehAccessTime | HighCarSvcAccessTime | LowCarSvcAccessTime |
| ----- | ---- | ------------------ | -------------------- | ------------------- |
| RVMPO | 2010 | 5                  | 10                   | 45                  |
| RVMPO | 2038 | 5                  | 10                   | 45                  |

### bzone_transit_service.csv {#verspm-bzone_transit_service.csv}

This file supplies the data on relative public transit accessibility at the `Bzone` level. The data to inform this input can be sourced from the EPA's [Smart Location Database](https://www.epa.gov/smartgrowth/smart-location-database-technical-documentation-and-user-guide).

* **D4c**: Aggregate frequency of transit service within 0.25 miles of block group boundary per hour during evening peak period (Ref: EPA 2010 Smart Location Database)
  

Here is a snapshot of the file:


|Geo           | Year | D4c |
|:-------------|:----:|:---:|
|D410290014002 | 2010 |  0  |
|D410290013012 | 2010 |  0  |
|D410290014001 | 2010 |  0  |
|D410290014003 | 2010 |  0  |
|D410290013021 | 2010 |  0  |



### bzone_carsvc_availability.csv {#verspm-bzone_carsvc_availability.csv}

This file contains the information about level of car service availability and contains a value of either `Low` or `High` for `Bzones`. `High` means car service access is competitive with household owned car and will impact household vehicle ownership; `Low` is not competitive and will not impact household vehicle ownership.

Here is a snapshot of the file:


|Geo           | Year | CarSvcLevel |
|:-------------|:----:|:-----------:|
|D410290014002 | 2010 |     Low     |
|D410290013012 | 2010 |     Low     |
|D410290014001 | 2010 |     Low     |
|D410290014003 | 2010 |     Low     |
|D410290013021 | 2010 |     Low     |



### bzone_dwelling_units.csv {#verspm-bzone_dwelling_units.csv}

This file contains the number single-family dwelling units (`SFDU`), multifamily dwelling units (`MFDU`) and group-quarter dwelling units (`GQDU`) by `Bzone` for each of the base and future years. Data for the base year for single-family and multifamily dwelling units can be sourced from Census housing data with information on units in structure, with multifamily dwelling units defined as any structures with 2-or-more units. For group quarters, unless more detailed local data is available, Census data for non-institutionalized group quarter population can serve as a proxy for dwelling units assuming a `1:1` ratio of dwelling unit per GQ population.

Here is a snapshot of the file:


|Geo           | Year | SFDU | MFDU | GQDU |
|:-------------|:----:|:----:|:----:|:----:|
|D410290014002 | 2010 | 559  |  0   |  0   |
|D410290013012 | 2010 |  79  |  8   | 523  |
|D410290014001 | 2010 | 1398 | 180  |  0   |
|D410290014003 | 2010 | 1385 | 172  |  0   |
|D410290013021 | 2010 | 271  |  0   |  0   |



### bzone_employment.csv {#verspm-bzone_employment.csv}

This file contains the total, retail and service employment by zone for each of the base and future years. Employment categorizations are from the Environmental Protection Agency's (EPA) [Smart Location Database](https://www.epa.gov/smartgrowth/smart-location-database-technical-documentation-and-user-guide) 5-tier employment classification. 

* **TotEmp**: Total number of jobs in zone
* **RetEmp**: Number of jobs in retail sector in zone (Census LEHD: CNS07)
* **SvcEmp**: Number of jobs in service sector in zone (Census LEHD: CNS12 + CNS14 + CNS15 + CNS16 + CNS19)
  

Here is a snapshot of the file:


|Geo           | Year | TotEmp | RetEmp | SvcEmp |
|:-------------|:----:|:------:|:------:|:------:|
|D410290014002 | 2010 |  403   |  262   |   96   |
|D410290013012 | 2010 |  1382  |   73   |  880   |
|D410290014001 | 2010 |  271   |   12   |  172   |
|D410290014003 | 2010 |  609   |   66   |  413   |
|D410290013021 | 2010 |   49   |   1    |   41   |



### bzone_hh_inc_qrtl_prop.csv {#verspm-bzone_hh_inc_qrtl_prop.csv}
This file contains the proportion of `Bzone` non-group quarters households by quartile of `Azone` household income category for each of the base and future years. The total for each `Bzone` should sum to `1`. 

Here is a snapshot of the file:


|Geo           | Year | HhPropIncQ1 | HhPropIncQ2 | HhPropIncQ3 | HhPropIncQ4 |
|:-------------|:----:|:-----------:|:-----------:|:-----------:|:-----------:|
|D410290014002 | 2010 |    0.12     |    0.54     |    0.26     |    0.54     |
|D410290013012 | 2010 |    0.00     |    0.32     |    0.36     |    0.32     |
|D410290014001 | 2010 |    0.24     |    0.16     |    0.26     |    0.16     |
|D410290014003 | 2010 |    0.16     |    0.19     |    0.36     |    0.19     |
|D410290013021 | 2010 |    0.29     |    0.29     |    0.15     |    0.29     |



### bzone_lat_lon.csv {#verspm-bzone_lat_lon.csv}
This file contains the latitude and longitude of the centroid of each Bzone.

Here is a snapshot of the file:


|Geo           | Year | Latitude | Longitude |
|:-------------|:----:|:--------:|:---------:|
|D410290014002 | 2010 | 42.48657 | -122.8014 |
|D410290013012 | 2010 | 42.44259 | -122.8461 |
|D410290014001 | 2010 | 42.46010 | -122.7925 |
|D410290014003 | 2010 | 42.47673 | -122.8008 |
|D410290013021 | 2010 | 42.37304 | -122.7793 |



### bzone_network_design.csv {#verspm-bzone_network_design.csv}

This file contains values for `D3bpo4`, a measure for intersection density determined by the number of pedestrian-oriented intersections having four or more legs per square mile. The data to inform this input can be sourced from the EPA's [Smart Location Database](https://www.epa.gov/smartgrowth/smart-location-database-technical-documentation-and-user-guide).

Here is a snapshot of the file:


|Geo           | Year |   D3bpo4   |
|:-------------|:----:|:----------:|
|D410290014002 | 2010 | 0.2618757  |
|D410290013012 | 2010 | 0.4830901  |
|D410290014001 | 2010 | 1.8038130  |
|D410290014003 | 2010 | 18.9766301 |
|D410290013021 | 2010 | 0.1013039  |



### bzone_parking.csv {#verspm-bzone_parking.csv}

This file contains the parking information by `Bzone` for each of the base and future years. Users should use available local data on parking availability, costs, and program participation to develop this input.

* **PkgSpacesPerSFDU**: Average number of free parking spaces available to residents of single-family dwelling units
* **PkgSpacesPerMFDU**: Average number of free parking spaces available to residents of multifamily dwelling units
* **PkgSpacesPerGQ**: Average number of free parking spaces available to group quarters residents
* **PropWkrPay**: Proportion of workers who pay for parking
* **PropCashOut**: Proportions of workers paying for parking in a cash-out-buy-back program
* **PkgCost**: Average daily cost for long-term parking (e.g. paid on monthly basis)
  

Here is a snapshot of the file:


|Geo           | Year | PkgSpacesPerSFDU | PkgSpacesPerMFDU | PkgSpacesPerGQ | PropWkrPay | PropCashOut | PkgCost.2010 |
|:-------------|:----:|:----------------:|:----------------:|:--------------:|:----------:|:-----------:|:------------:|
|D410290014002 | 2010 |        3         |       1.5        |       0        |     0      |      0      |      0       |
|D410290013012 | 2010 |        4         |       4.0        |       0        |     0      |      0      |      0       |
|D410290014001 | 2010 |        4         |       4.0        |       0        |     0      |      0      |      0       |
|D410290014003 | 2010 |        4         |       4.0        |       0        |     0      |      0      |      0       |
|D410290013021 | 2010 |        4         |       4.0        |       0        |     0      |      0      |      0       |



### bzone_travel_demand_mgt.csv {#verspm-bzone_travel_demand_mgt.csv}

This file contains the information about workers and households participating in demand management programs. Users should use available local data on travel demand management programs to develop this input. 

* **EcoProp**: Proportion of workers working in `Bzone` who participate in strong employee commute options program (can also be used to approximate the impacts of teleworking)
* **ImpProp**: Proportion of households residing in `Bzone` who participate in strong individualized marketing program

Here is a snapshot of the file:


|Geo           | Year | EcoProp | ImpProp |
|:-------------|:----:|:-------:|:-------:|
|D410290014002 | 2010 |   0.0   |   0.0   |
|D410290013012 | 2010 |   0.2   |   0.4   |
|D410290014001 | 2010 |   0.2   |   0.4   |
|D410290014003 | 2010 |   0.0   |   0.0   |
|D410290013021 | 2010 |   0.0   |   0.0   |



### bzone_unprotected_area.csv {#verspm-bzone_unprotected_area.csv}

This file contains the information about unprotected (i.e., developable) area within the zone. 

* **UrbanArea**: Area that is `Urban` and unprotected (i.e. developable) within the zone (Acres)
* **TownArea**: Area that is `Town` and unprotected within the zone (Acres)
* **RuralArea**: Area that is `Rural` and unprotected within the zone (Acres)

Here is a snapshot of the file:


|Geo           | Year |  UrbanArea  | TownArea | RuralArea  |
|:-------------|:----:|:-----------:|:--------:|:----------:|
|D410290014002 | 2010 | 298.6487137 |    0     | 4996.11876 |
|D410290013012 | 2010 | 830.6009450 |    0     | 384.80922  |
|D410290014001 | 2010 | 983.1506646 |    0     | 3699.94017 |
|D410290014003 | 2010 | 439.2145619 |    0     |  90.86259  |
|D410290013021 | 2010 |  0.3548548  |    0     | 6212.57640 |



### bzone_urban-town_du_proportions.csv {#verspm-bzone_urban-town_du_proportions.csv}

This file contains proportion of SF, MF and GQ dwelling units within the urban portion of the zone. 

* **PropUrbanSFDU**: Proportion of single family dwelling units located within the urban portion of the zone
* **PropUrbanMFDU**: Proportion of multi-family dwelling units located within the urban portion of the zone
* **PropUrbanGQDU**: Proportion of group quarters accommodations located within the urban portion of the zone
* **PropTownSFDU**: Proportion of single family dwelling units located within the town portion of the zone
* **PropTownMFDU**: Proportion of multi-family dwelling units located within the town portion of the zone
* **PropTownGQDU**: Proportion of group quarters accommodations located within the town portion of the zone
  

Here is a snapshot of the file:


|Geo           | Year | PropUrbanSFDU | PropUrbanMFDU | PropUrbanGQDU | PropTownSFDU | PropTownMFDU | PropTownGQDU |
|:-------------|:----:|:-------------:|:-------------:|:-------------:|:------------:|:------------:|:------------:|
|D410290014002 | 2010 |   0.4686941   |       1       |       1       |      0       |      0       |      0       |
|D410290013012 | 2010 |   0.8860759   |       1       |       1       |      0       |      0       |      0       |
|D410290014001 | 2010 |   0.8626609   |       1       |       1       |      0       |      0       |      0       |
|D410290014003 | 2010 |   0.9906137   |       1       |       1       |      0       |      0       |      0       |
|D410290013021 | 2010 |   0.0147601   |       1       |       1       |      0       |      0       |      0       |



### marea_base_year_dvmt.csv {#verspm-marea_base_year_dvmt.csv}

This input file is OPTIONAL. It is only needed if the user wants to modify the adjust dvmt growth factors from base year in by Marea

* **UrbanLdvDvmt**: Average daily vehicle miles of travel on roadways in the urbanized portion of the Marea by light-duty vehicles during the base year
* **UrbanHvyTrkDvmt**: Average daily vehicle miles of travel on roadways in the urbanized portion of the Marea by heavy trucks during he base year

Here is a snapshot of the file:	


|Geo   | UzaNameLookup | UrbanLdvDvmt | UrbanHvyTrkDvmt |
|:-----|:-------------:|:------------:|:---------------:|
|RVMPO |  Medford/OR   |      NA      |       NA        |



### marea_congestion_charges.csv {#verspm-marea_congestion_charges.csv}

This input file is OPTIONAL. It is only needed if the user wants to add a congestion charge policy for vehicle travel using different congestion levels and roadway classes.

* **FwyNoneCongChg**: Charge per mile (U.S. dollars) of vehicle travel on freeways during periods of no congestion
* **FwyModCongChg**: Charge per mile (U.S. dollars) of vehicle travel on freeways during periods of moderate congestion
* **FwyHvyCongChg**: Charge per mile (U.S. dollars) of vehicle travel on freeways during periods of heavy congestion
* **FwySevCongChg**: Charge per mile (U.S. dollars) of vehicle travel on freeways during periods of severe congestion
* **FwyExtCongChg**: Charge per mile (U.S. dollars) of vehicle travel on freeways during periods of extreme congestion
* **ArtNoneCongChg**: Charge per mile (U.S. dollars) of vehicle travel on arterials during periods of no congestion
* **ArtModCongChg**: Charge per mile (U.S. dollars) of vehicle travel on arterials during periods of moderate congestion
* **ArtHvyCongChg**: Charge per mile (U.S. dollars) of vehicle travel on arterials during periods of heavy congestion
* **ArtSevCongChg**: Charge per mile (U.S. dollars) of vehicle travel on arterials during periods of severe congestion
* **ArtExtCongChg**: Charge per mile (U.S. dollars) of vehicle travel on arterials during periods of extreme congestion

Here is a snapshot of the file:	


|Geo   | Year | FwyNoneCongChg.2010 | FwyModCongChg.2010 | FwyHvyCongChg.2010 | FwySevCongChg.2010 | FwyExtCongChg.2010 | ArtNoneCongChg.2010 | ArtModCongChg.2010 | ArtHvyCongChg.2010 | ArtSevCongChg.2010 | ArtExtCongChg.2010 |
|:-----|:----:|:-------------------:|:------------------:|:------------------:|:------------------:|:------------------:|:-------------------:|:------------------:|:------------------:|:------------------:|:------------------:|
|RVMPO | 2010 |          0          |         0          |         0          |        0.0         |        0.0         |          0          |         0          |         0          |         0          |         0          |
|RVMPO | 2038 |          0          |         0          |         0          |        0.1         |        0.2         |          0          |         0          |         0          |         0          |         0          |



###  marea_dvmt_split_by_road_class.csv {#verspm-marea_dvmt_split_by_road_class.csv}

DVMT Split by Road Class This input file is OPTIONAL. It is only needed if the user wants to modify the dvmt split for different road classes. This data can be derived from the FHWA [Highway Statistics](https://www.fhwa.dot.gov/policyinformation/statistics.cfm) data. 

* **LdvFwyArtDvmtProp**: Proportion of light-duty daily vehicle miles of travel in the urbanized portion of the Marea occurring on freeway or aerial roadways
* **LdvOthDvmtProp**: Proportion of light-duty daily vehicle miles of travel in the urbanized portion of the Marea occurring on other roadways
* **HvyTrkFwyDvmtProp**: Proportion of heavy truck daily vehicle miles of travel in the urbanized portion of the Marea occurring on freeways
* **HvyTrkArtDvmtProp**: Proportion of heavy truck daily vehicle miles of travel in the urbanized portion of the Marea occurring on arterial rdways
* **HvyTrkOthDvmtProp**: Proportion of heavy truck daily vehicle miles of travel in the urbanized portion of the Marea occurring on other roadways
* **BusFwyDvmtProp**: Proportion of bus daily vehicle miles of travel in the urbanized portion of the Marea occurring on freeways
* **BusArtDvmtProp**: Proportion of bus daily vehicle miles of travel in the urbanized portion of the Marea occurring on arterial roadways
* **BusOthDvmtProp**: Proportion of bus daily vehicle miles of travel in the urbanized portion of the Marea occuring on other roadways

Here is a snapshot of the file:	


|Geo   | LdvFwyDvmtProp | LdvArtDvmtProp | LdvOthDvmtProp | HvyTrkFwyDvmtProp | HvyTrkArtDvmtProp | HvyTrkOthDvmtProp | BusFwyDvmtProp | BusArtDvmtProp | BusOthDvmtProp |
|:-----|:--------------:|:--------------:|:--------------:|:-----------------:|:-----------------:|:-----------------:|:--------------:|:--------------:|:--------------:|
|RVMPO |   0.2632296    |    0.47739     |   0.2593804    |                   |                   |                   |       0        |   0.6962986    |   0.3037014    |



### marea_lane_miles.csv {#verspm-marea_lane_miles.csv}

This file contains inputs on the numbers of freeway lane-miles and arterial lane-miles by `Marea` and year. The data to develop this input can be sourced from the FHWA Highway Performance Monitoring System (HPMS), using either the HPMS geospatial data or Highway Statistics, or the State DOT. 

* **FwyLaneMi**: Lane-miles of roadways functionally classified as freeways or expressways in the urbanized portion of the metropolitan area
* **ArtLaneMi**: Lane-miles of roadways functionally classified as arterials (but not freeways or expressways) in the urbanized portion of the metropolitan area

Here is a snapshot of the file:


|Geo   | Year | FwyLaneMi | ArtLaneMi |
|:-----|:----:|:---------:|:---------:|
|RVMPO | 2010 |    91     |    356    |
|RVMPO | 2038 |    97     |    371    |



### marea_operations_deployment.csv {#verspm-marea_operations_deployment.csv}

This input file is OPTIONAL. It is only needed if the user wants to modify the proportion of DVMT affected by operations for different road classes. 

* **RampMeterDeployProp**: Proportion of freeway DVMT affected by ramp metering deployment
* **IncidentMgtDeployProp**: Proportion of freeway DVMT affected by incident management deployment
* **SignalCoordDeployProp**: Proportion of arterial DVMT affected by signal coordination deployment
* **AccessMgtDeployProp**: Proportion of arterial DVMT affected by access management deployment
* **OtherFwyOpsDeployProp**: Proportion of freeway DVMT affected by deployment of other user-defined freeway operations measures
* **OtherArtOpsDeployProp**: Proportion of arterial DVMT affected by deployment of other user-defined arterial operations measures

Here is a snapshot of the file:	


|Geo   | Year | RampMeterDeployProp | IncidentMgtDeployProp | SignalCoordDeployProp | AccessMgtDeployProp | OtherFwyOpsDeployProp | OtherArtOpsDeployProp |
|:-----|:----:|:-------------------:|:---------------------:|:---------------------:|:-------------------:|:---------------------:|:---------------------:|
|RVMPO | 2010 |        0.00         |         0.50          |         0.50          |        0.00         |           0           |           0           |
|RVMPO | 2038 |        0.95         |         0.95          |         0.95          |        0.24         |           0           |           0           |



### marea_speed_smooth_ecodrive.csv {#verspm-marea_speed_smooth_ecodrive.csv}

This input file supplies information of deployment of speed smoothing and ecodriving by road class and vehicle type.

* **FwySmooth**:Fractional deployment of speed smoothing traffic management on freeways, where 0 is no deployment and 1 is the full potential fuel savings
* **ArtSmooth**: Fractional deployment of speed smoothing traffic management on arterials, where 0 is no deployment and 1 is the full potential fuel savings
* **LdvEcoDrive**: Eco-driving penetration for light-duty vehicles; the fraction of vehicles from 0 to 1
* **HvyTrkEcoDrive**: Eco-driving penetration for heavy-duty vehicles; the fraction of vehicles from 0 to 1
  

Here is a snapshot of the file:	

| Geo   | Year | FwySmooth | ArtSmooth | LdvEcoDrive | HvyTrkEcoDrive |
| ----- | ---- | --------- | --------- | ----------- | -------------- |
| RVMPO | 2010 | 0.2       | 0.1       | 0.2         | 0.05           |
| RVMPO | 2038 | 0.4       | 0.2       | 0.4         | 0.2            |

### marea_transit_ave_fuel_carbon_intensity.csv {#verspm-marea_transit_ave_fuel_carbon_intensity.csv}

This input file is OPTIONAL. It is only needed if the user wants to modify the average carbon intensity of fuel used by transit.

* **TransitVanFuelCI**: Average carbon intensity of fuel used by transit vans (grams CO2e per megajoule)
* **TransitBusFuelCI**: Average carbon intensity of fuel used by transit buses (grams CO2e per megajoule)
* **TransitRailFuelCI**: Average carbon intensity of fuel used by transit rail vehicles (grams CO2e per megajoule)

Here is a snapshot of the file:


|Geo   | Year | TransitVanFuelCI | TransitBusFuelCI | TransitRailFuelCI |
|:-----|:----:|:----------------:|:----------------:|:-----------------:|
|RVMPO | 2010 |      90.38       |        NA        |        NA         |
|RVMPO | 2038 |      72.30       |        NA        |        NA         |



### marea_transit_biofuel_mix.csv {#verspm-marea_transit_biofuel_mix.csv}

This input file is OPTIONAL. It is only needed if the user wants to modify the biofuel used by transit services.

* **TransitEthanolPropGasoline**: Ethanol proportion of gasoline used by transit vehicles
* **TransitBiodieselPropDiesel**: Biodiesel proportion of diesel used by transit vehicles
* **TransitRngPropCng**: Renewable natural gas proportion of compressed natural gas used by transit vehicles

    

Here is a snapshot of the file:


|Geo   | Year | TransitEthanolPropGasoline | TransitBiodieselPropDiesel | TransitRngPropCng |
|:-----|:----:|:--------------------------:|:--------------------------:|:-----------------:|
|RVMPO | 2010 |            0.1             |            0.05            |         0         |
|RVMPO | 2038 |            0.1             |            0.05            |         0         |



### marea_transit_fuel.csv {#verspm-marea_transit_fuel.csv}

This input file is OPTIONAL. It is only needed if the user wants to modify the transit fuels proportions.

* **VanPropDiesel**: Proportion of non-electric transit van travel powered by diesel
* **VanPropGasoline**: Proportion of non-electric transit van travel powered by gasoline
* **VanPropCng**: Proportion of non-electric transit van travel powered by compressed natural gas
* **BusPropDiesel**: Proportion of non-electric transit bus travel powered by diesel
* **BusPropGasoline**: Proportion of non-electric transit bus travel powered by gasoline
* **BusPropCng**: Proportion of non-electric transit bus travel powered by compressed natural gas
* **RailPropDiesel**: Proportion of non-electric transit rail travel powered by diesel
* **RailPropGasoline**: Proportion of non-electric transit rail travel powered by gasoline

Here is a snapshot of the file:


|Geo   | Year | VanPropDiesel | VanPropGasoline | VanPropCng | BusPropDiesel | BusPropGasoline | BusPropCng | RailPropDiesel | RailPropGasoline |
|:-----|:----:|:-------------:|:---------------:|:----------:|:-------------:|:---------------:|:----------:|:--------------:|:----------------:|
|RVMPO | 2010 |       0       |        1        |     0      |      0.2      |        0        |    0.8     |       1        |        0         |
|RVMPO | 2038 |       0       |        1        |     0      |      0.2      |        0        |    0.8     |       1        |        0         |



### marea_transit_powertrain_prop.csv {#verspm-marea_transit_powertrain_prop.csv}

This input file is OPTIONAL. It is only needed if the user wants to modify the mixes of transit vehicle powertrains.

* **VanPropIcev**: Proportion of transit van travel using internal combustion engine powertrains
* **VanPropHev**: Proportion of transit van travel using hybrid electric powertrains
* **VanPropBev**: Proportion of transit van travel using battery electric powertrains
* **BusPropIcev**: Proportion of transit bus travel using internal combustion engine powertrains 
* **BusPropHev**: Proportion of transit bus travel using hybrid electric powertrains
* **BusPropBev**: Proportion of transit bus travel using battery electric powertrains
* **RailPropIcev**: Proportion of transit rail travel using internal combustion engine powertrains
* **RailPropHev**: Proportion of transit rail travel using hybrid electric powertrains
* **RailPropEv**: Proportion of transit rail travel using electric powertrains

Here is a snapshot of the file:


|Geo   | Year | VanPropIcev | VanPropHev | VanPropBev | BusPropIcev | BusPropHev | BusPropBev | RailPropIcev | RailPropHev |RailPropEv |
|:-----|:----:|:-----------:|:----------:|:----------:|:-----------:|:----------:|:----------:|:------------:|:-----------:|:----------|
|RVMPO | 2010 |      1      |     0      |     0      |      1      |     0      |     0      |      0       |      0      |1          |
|RVMPO | 2038 |      1      |     0      |     0      |      1      |     0      |     0      |      0       |      0      |1          |



### marea_transit_service.csv {#verspm-marea_transit_service.csv}

This file contains annual revenue-miles for different transit modes for metropolitan area. Data to develop this input can be sourced from the Federal Transit Administration NTD.

* **DRRevMi**: Annual revenue-miles of demand-responsive public transit service
* **VPRevMi**: Annual revenue-miles of van-pool and similar public transit service
* **MBRevMi**: Annual revenue-miles of standard bus public transit service
* **RBRevMi**: Annual revenue-miles of rapid-bus and commuter bus public transit service
* **MGRevMi**: Annual revenue-miles of monorail and automated guideway public transit service
* **SRRevMi**: Annual revenue-miles of streetcar and trolleybus public transit service
* **HRRevMi**: Annual revenue-miles of light rail and heavy rail public transit service
* **CRRevMi**: Annual revenue-miles of commuter rail, hybrid rail, cable car, and aerial tramway public transit service
  

Here is a snapshot of the file:


|Geo   | Year | DRRevMi | VPRevMi | MBRevMi | RBRevMi | MGRevMi | SRRevMi | HRRevMi | CRRevMi |
|:-----|:----:|:-------:|:-------:|:-------:|:-------:|:-------:|:-------:|:-------:|:-------:|
|RVMPO | 2010 | 382639  |    0    | 607922  |    0    |    0    |    0    |    0    |    0    |
|RVMPO | 2038 | 2381995 |    0    | 3580237 |    0    |    0    |    0    |    0    |    0    |



### other_ops_effectiveness.csv {#verspm-other_ops_effectiveness.csv}

This input file is OPTIONAL. It is only needed if the user wants to modify the other delay effects of operations in different road classes

* **Level**: Congestion levels: None = none, Mod = moderate, Hvy = heavy, Sev = severe, Ext = extreme
* **Art_Rcr**: Percentage reduction of recurring arterial delay that would occur with full deployment of other user-defined arterial operations measures
* **Art_NonRcr**: Percentage reduction of non-recurring arterial delay that would occur with full deployment of other user-defined arterial operations measures
* **Fwy_Rcr**: Percentage reduction of recurring freeway delay that would occur with full deployment of other user-defined freeway operations measures
* **Fwy_NonRcr**: Percentage reduction of non-recurring freeway delay that would occur with full deployment of other user-defined freeway operations measures
  

Here is a snapshot of the file:	


|Level | Art_Rcr | Art_NonRcr | Fwy_Rcr | Fwy_NonRcr | AccessMgtDeployProp | OtherFwyOpsDeployProp | OtherArtOpsDeployProp |
|:-----|:-------:|:----------:|:-------:|:----------:|:-------------------:|:---------------------:|:---------------------:|
|None  |    0    |     0      |    0    |     0      |          0          |           0           |           0           |
|Mod   |    0    |     0      |    0    |     0      |          0          |           0           |           0           |
|Hvy   |    0    |     0      |    0    |     0      |          0          |           0           |           0           |
|sev   |    0    |     0      |    0    |     0      |          0          |           0           |           0           |
|Ext   |    0    |     0      |    0    |     0      |          0          |           0           |           0           |



### region_ave_fuel_carbon_intensity.csv {#verspm-region_ave_fuel_carbon_intensity.csv}

This input file is OPTIONAL. It is only needed if the user wants to modify the average carbon density for different vehicle types for the model region.

* **HhFuelCI**: Average carbon intensity of fuels used by household vehicles (grams CO2e per megajoule)
* **CarSvcFuelCI**: Average carbon intensity of fuels used by car service vehicles (grams CO2e per megajoule)
* **ComSvcFuelCI**: Average carbon intensity of fuels used by commercial service vehicles (grams CO2e per megajoule)
* **HvyTrkFuelCI**: Average carbon intensity of fuels used by heavy trucks (grams CO2e per megajoule)
* **TransitVanFuelCI**: Average carbon intensity of fuels used by transit vans (grams CO2e per megajoule)
* **TransitBusFuelCI**: Average carbon intensity of fuels used by transit buses (grams CO2e per megajoule)
* **TransitRailFuelCI**: Average carbon intensity of fuels used by transit rail vehicles (grams CO2e per megajoule)

Here is a snapshot of the file:	


|Geo   | Year | HhFuelCI | CarSvcFuelCI | ComSvcFuelCI | HvyTrkFuelCI | TransitVanFuelC | TransitBusFuelC | TransitRailFuel |
|:-----|:----:|:--------:|:------------:|:------------:|:------------:|:---------------:|:---------------:|:---------------:|
|RVMPO | 2010 |  90.23   |    90.23     |    90.23     |      NA      |       NA        |       NA        |       NA        |
|RVMPO | 2038 |  72.30   |    72.30     |    72.30     |      NA      |       NA        |       NA        |       NA        |



### region_base_year_dvmt.csv {#verspm-region_base_year_dvmt.csv}

This input file is OPTIONAL. It is only needed if the user wants to adjust heavy truck DVMT for base year

* **HvyTrkDvmtGrowthBasis**: Factor used to grow heavy truck DVMT from base year value
* **HvyTrkDvmt**: Average daily vehicle miles of travel on roadways in the region by heavy trucks during he base year
* **HvyTrkDvmtUrbanProp**: Proportion of Region heavy truck daily vehicle miles of travel occurring on urbanized area roadways
  

Here is a snapshot of the file:	


|StateAbbrLookup | HvyTrkDvmtGrowthBasis | HvyTrkDvmt | ComSvcDvmtGrowthBasis |
|:---------------|:---------------------:|:----------:|:---------------------:|
|                |        Income         |     NA     |      Population       |



### region_carsvc_powertrain_prop.csv {#verspm-region_carsvc_powertrain_prop.csv}

This input file is OPTIONAL. It is only needed if the user wants to modify the powertrain proportion of car services.

* **CarSvcAutoPropIcev**: Proportion of car service automobile travel powered by internal combustion engine powertrains
* **CarSvcAutoPropHev**: Proportion of car service automobile travel powered by hybrid electric powertrains
* **CarSvcAutoPropBev**: Proportion of car service automobile travel powered by battery electric powertrains
* **CarSvcLtTrkPropIcev**: Proportion of car service light truck travel powered by internal combustion engine powertrains
* **CarSvcLtTrkPropHev**: Proportion of car service light truck travel powered by hybrid electric powertrains
* **CarSvcLtTrkPropBev**: Proportion of car service light truck travel powered by battery electric powertrains
  

Here is a snapshot of the file:	


|Geo   | Year | CarSvcAutoPropIcev | CarSvcAutoPropHev | CarSvcAutoPropBev | CarSvcLtTrkPropIce | CarSvcLtTrkPropHev | CarSvcLtTrkPropBev |
|:-----|:----:|:------------------:|:-----------------:|:-----------------:|:------------------:|:------------------:|:------------------:|
|RVMPO | 2010 |       0.990        |       0.010       |       0.000       |       1.0000       |       0.0000       |       0.0000       |
|RVMPO | 2038 |       0.441        |       0.528       |       0.031       |       0.5335       |       0.4572       |       0.0093       |



### region_comsvc_lttrk_prop.csv {#verspm-region_comsvc_lttrk_prop.csv}

This file supplies data for the light truck proportion of commercial vehicles for the region.

* **ComSvcLtTrkProp**: Regional proportion of commercial service vehicles that are light trucks

Here is a snapshot of the file:	

| Year | ComSvcLtTrkProp |
| ---- | --------------- |
| 2010 | 0.51            |
| 2038 | 0.51            |

### region_comsvc_powertrain_prop.csv {#verspm-region_comsvc_powertrain_prop.csv}

This input file is OPTIONAL. It is only needed if the user wants to modify the powertrain proportion of commercial vehicles.

* **ComSvcAutoPropIcev**: Proportion of commercial service automobile travel powered by internal combustion engine powertrains
* **ComSvcAutoPropHev**: Proportion of commercial service automobile travel powered by hybrid electric powertrains
* **ComSvcAutoPropBev**: Proportion of commercial service automobile travel powered by battery electric powertrains
* **ComSvcLtTrkPropIcev**: Proportion of commercial service light truck travel powered by internal combustion engine powertrains
* **ComSvcLtTrkPropHev**: Proportion of commercial service light truck travel powered by hybrid electric powertrains
* **ComSvcLtTrkPropBev**: Proportion of commercial service light truck travel powered by battery electric powertrainss

Here is a snapshot of the file:	


|Geo   | Year | ComSvcAutoPropIcev | ComSvcAutoPropHev | ComSvcAutoPropBev | ComSvcLtTrkPropIcev | ComSvcLtTrkPropHev | ComSvcLtTrkPropBev |
|:-----|:----:|:------------------:|:-----------------:|:-----------------:|:-------------------:|:------------------:|:------------------:|
|RVMPO | 2010 |       0.990        |       0.010       |       0.000       |       1.0000        |       0.0000       |       0.0000       |
|RVMPO | 2038 |       0.441        |       0.528       |       0.031       |       0.5335        |       0.4572       |       0.0093       |



### region_hh_driver_adjust_prop.csv {#verspm-region_hh_driver_adjust_prop.csv}

This file is OPTIONAL and can be used to adjust the estimate of household drivers by age cohort. The file specifies the relative driver licensing rate relative to the model estimation data year in order to account for observed or projected changes in licensing rates.

* **Drv15to19AdjProp**: Target proportion of unadjusted model number of drivers 15 to 19 years old (`1` = no adjustment)
* **Drv20to29AdjProp**: Target proportion of unadjusted model number of drivers 20 to 29 years old (`1` = no adjustment)
* **Drv30to54AdjProp**: Target proportion of unadjusted model number of drivers 30 to 54 years old (`1` = no adjustment)
* **Drv55to64AdjProp**: Target proportion of unadjusted model number of drivers 55 to 64 years old (`1` = no adjustment)
* **Drv65PlusAdjProp**: Target proportion of unadjusted model number of drivers 65 or older (`1` = no adjustment)
  

Here is a snapshot of the file:


|Year | DrvPerPrsn15to19 | Drv20to29AdjProp | Drv30to54AdjProp | Drv55to64AdjProp | Drv65PlusAdjProp |
|:----|:----------------:|:----------------:|:----------------:|:----------------:|:----------------:|
|2010 |    0.8174609     |    0.9466447     |    0.9466447     |    0.9900000     |    0.9349951     |
|2038 |    0.9091840     |    0.9091840     |    0.9091840     |    0.9508236     |    0.8979954     |



### region_hvytrk_powertrain_prop.csv {#verspm-region_hvytrk_powertrain_prop.csv}

This input file is OPTIONAL. It is only needed if the user wants to modify the powertrain proportion of heavy duty trucks.

* **HvyTrkPropIcev**: Proportion of heavy truck travel powered by internal combustion engine powertrains
* **HvyTrkPropHev**: Proportion of heavy truck travel powered by hybrid electric powertrains
* **HvyTrkPropBev**: Proportion of heavy truck travel powered by battery electric powertrains
		

Here is a snapshot of the file:	


|Geo   | Year | HvyTrkPropIcev | HvyTrkPropHev | HvyTrkPropBev |
|:-----|:----:|:--------------:|:-------------:|:-------------:|
|RVMPO | 2010 |      1.0       |      0.0      |      0.0      |
|RVMPO | 2038 |      0.4       |      0.4      |      0.2      |



### region_co2e_costs.csv {#verspm-region_co2e_costs.csv}

This is an OPTIONAL file. The input accounts for the environmental and social cost of CO2e emissions per metric ton. The Unit can be defined, but default is USD. The year of the USD is based on the model year.  [[More details here on the GitHub site](https://github.com/VisionEval/VisionEval/blob/master/sources/modules/VETravelPerformance/inst/module_docs/CalculateVehicleOperatingCost.md#region_co2e_costscsv)]

* **CO2eCost**: Cost of CO2e emissions per metric ton.

### region_prop_externalities_paid.csv {#verspm-region_prop_externalities_paid.csv}

Proportional external costs for the region  (This file supplies data for climate change and other social costs.

* **PropClimateCostPaid**: Proportion of climate change costs paid by users (i.e. ratio of carbon taxes to climate change costs
* **PropOtherExtCostPaid**: Proportion of other social costs paid by users

Here is a snapshot of the file:	

| Year | PropClimateCostPaid | PropOtherExtCostPaid |
| ---- | ------------------- | -------------------- |
| 2038 | 1                   | 0.5                  |
| 2010 | 0                   | 0                    |

### region_road_cost.csv (TO DO) {#verspm-region_road_cost.csv}

| Year | RoadBaseModCost.2005 | RoadPresOpMaintCost.2005 | RoadOtherCost.2005 | FwyLnMiCost.2005.1e3 | ArtLnMiCost.2005.1e3 | HvyTrkPCE |
| ---- | -------------------- | ------------------------ | ------------------ | -------------------- | -------------------- | --------- |
| 2010 | 0.004                | 0.01                     | 0.015              | 4900                 | 1800                 | 3         |
| 2038 | 0.004                | 0.01                     | 0.015              | 4900                 | 1800                 | 3         |

## VE-State Input Files {#vestate-inputs}

* [**azone_carsvc_characteristics.csv**](#vestate-azone_carsvc_characteristics.csv) This file specifies the different characteristics for high and low car service level and is used in the [CreateVehicleTable](#vestate-createvehicletable) and [AssignVehicleAge](#vestate-assignvehicleage) modules. 

* [**azone_charging_availability.csv**](#vestate-azone_charging_availability.csv) This file has data on proportion of different household types who has EV charging available  and is used in the [AssignHHVehiclePowertrain](#vestate-assignhhvehiclepowertrain) module.          

* [**azone_electricity_carbon_intensity.csv**](#vestate-azone_electricity_carbon_intensity.csv) This file is used to specify the carbon intensity of electricity and is optional (only needed if user wants to modify the values). The file is used in [Initialize (VEPowertrainsAndFuels)](#vestate-initialize-vepowertrainsandfuels) and [CalculateCarbonIntensity](#vestate-calculatecarbonintensity) modules.      

* [**azone_fuel_power_cost.csv**](azone_fuel_power_cost.csv) This file supplies data for retail cost of fuel and electricity and is used in the [CalculateVehicleOperatingCost](#vestate-calculatevehicleoperatingcost) module.    

* [**azone_gq_pop_by_age.csv**](azone_gq_pop_by_age.csv) This file contains group quarters population estimates/forecasts by age and is used in the [CreateHouseholds](#vestate-createhouseholds) module.                    

* [**azone_gq_pop-prop_by_area-type.csv**](#vestate-azone_gq_pop-prop_by_area-type.csv) This file provides the proportions for groupquarters in different area types and is used in the [Initialize](#vestate-initialize) module.   

* [**azone_hh_loc_type_prop.csv**](#vestate-azone_hh_loc_type_prop.csv) This file provides the proportions for households residing in the metropolitan, towns and rural part of the Azone and is used in the [Initialize](#vestate-initialize) module.                    

* [**azone_hh_pop_by_age.csv**](#vestate-azone_hh_pop_by_age.csv) This file contains population estimates/forecasts by age and is used in the [CreateHouseholds](#vestate-createhouseholds) module.                  

* [**azone_hh_veh_mean_age.csv**](#vestate-azone_hh_veh_mean_age.csv) This file provides inputs for mean auto age and mean light truck age and is used in the [AssignVehicleAge](#vestate-assignvehicleage) module.     

* [**azone_hh_veh_own_taxes.csv**](#vestate-azone_hh_veh_own_taxes.csv) This file provides inputs for flat fees/taxes (i.e. annual cost per vehicle) and ad valorem taxes (i.e. percentage of vehicle value paid in taxes). The file is used in 
[CalculateVehicleOwnCost](#vestate-calculatevehicleowncost) module.  

* [**azone_hhsize_targets.csv**](#vestate-azone_hhsize_targets.csv) This file contains the household specific targets and is used in [CreateHouseholds](#vestate-createhouseholds) module.          

* [**azone_loc_type_land_area.csv**](#vestate-vestate-azone_loc_type_land_area.csv) This file provides land area data for different area types and is used in [Initialize](#vestate-initialize) module.                  

* [**azone_lttrk_prop.csv**](#vestate-azone_lttrk_prop.csv) This file specifies the light truck proportion of the vehicle fleet and is used in [AssignVehicleType](#vestate-assignvehicletype) module. 

* [**azone_payd_insurance_prop.csv**](#vestate-azone_payd_insurance_prop.csv) This file provides inputs on the proportion of households having PAYD (pay-as-you-drive) insurance and is used in the [CalculateVehicleOwnCost](#vestate-calculatevehicleowncost) module.               

* [**azone_per_cap_inc.csv**](#vestate-azone_per_cap_inc.csv) This file contains information on regional average per capita household and group quarters income in year 2010 dollars and is used in the [PredictIncome](#vestate-predictincome) module.                 

* [**azone_prop_sov_dvmt_diverted.csv**](#vestate-azone_prop_sov_dvmt_diverted.csv) This file provides inputs for a goal for diverting a portion of SOV travel within a 20-mile tour distance and is used in the [DivertSovTravel](#vestate-divertsovtravel) module.            

* [**azone_relative_employment.csv**](#vestate-azone_relative_employment.csv) This file contains ratio of workers to persons by age and is used in the [PredictWorkers](#vestate-predictworkers) module. 

* [**azone_veh_use_taxes.csv**](#vestate-azone_veh_use_taxes.csv) This file supplies data for vehicle related taxes and is used in the [CalculateVehicleOperatingCost](#vestate-calculatevehicleoperatingcosts) module. 

* [**azone_vehicle_access_times.csv**](#vestate-azone_vehicle_access_times.csv) This file supplies data for vehicle access and egress time and is used in the [CalculateVehicleOperatingCost](#vestate-calculatevehicleoperatingcost) module.              

* [**azone_wkr_loc_type_prop**](#vestate-azone_wkr_loc_type_prop) This file provides the proportions for workers residing in Azone who works in the metropolitan, towns and rural part of the Azone and is used in [Initialize](#vestate-initialize) module.              

* [**marea_base_year_dvmt.csv**](#vestate-marea_base_year_dvmt.csv) This file is used to specify to adjust the DVMT growth factors and is optional (only needed if user wants to modify the values). The file is used in the [Initialize (VETravelPerformance)](#vestate-initialize-vetravelperformance), [CalculateBaseRoadDvmt](#vestate-calculatebaseroaddvmt) and [CalculateFutureRoadDvmt](#vestate-calculatefutureroaddvmt) modules.

* [**marea_carsvc_availability.csv**](#vestate-marea_carsvc_availability.csv) This file has the data for activity proportions which are served by car services and is used in the [Initialize (AssignCarSvcAvailability)](#vestate-assigncarsvcavailability)

* [**marea_congestion_charges.csv**](#vestate-marea_congestion_charges.csv) This file is used to specify the charges of vehicle travel for different congestion levels and is optional. The file is used in the [Initialize (VETravelPerformance)](#vestate-initialize-vetravelperformance) and [CalculateRoadPerformance](#vestate-calculateroadperformance) modules.               

* [**marea_dvmt_split_by_road_class.csv**](#vestate-marea_dvmt_split_by_road_class.csv) This file is used to specify the dvmt split for different road classes and is optional. The file is used in the [Initialize (VETravelPerformance)](#vestate-initialize-vetravelperformance) and [CalculateBaseRoadDvmt](#vestate-calculatebaseroaddvmt) modules.         

* [**marea_d3bpo4_adj.csv**](#vestate-marea_d3bpo4_adj.csv) This file provides the D3bpo4 value for urban, town and rural areas from the EPA 2010 Smart Location Database and is used in the [Simulate4DMeasures](#vestate-simulate4dmeasures) 

* [**marea_lane_miles.csv**](#vestate-marea_lane_miles.csv) This file contains inputs on the numbers of freeway lane-miles and arterial lane-miles and is used in the [AssignRoadMiles](#vestate-assignroadmiles) module.                   

* [**marea_mix_targets.csv**](#vestate-marea_mix_targets.csv) This file represents Marea target for proportion of households located in mixed-use neighborhoods (or NA if no target) and is used in the [SimulateUrbanMixMeasure](#vestate-simulateurbanmixmeasure) module.                   

* [**marea_operations_deployment.csv**](#vestate-marea_operations_deployment.csv) This file is used to specify the proportion of dvmt affected by operations for different road classes and is optional. The file is used in the [Initialize (VETravelPerformance)](#vestate-initialize-vetravelperformance) and [CalculateRoadPerformance](#vestate-calculateroadperformance) modules.        

* [**marea_parking-avail_by_area-type.csv**](#vestate-marea_parking-avail_by_area-type.csv) This file has the data for average number of parking spots available to households and is used in the [AssignParkingRestrictions](#vestate-assignparkingrestrictions)   

* [**marea_parking-cost_by_area-type.csv**](#vestate-marea_parking-cost_by_area-type.csv) This file has the data related to parking costs and population proportions paying the parking costs and is used in the [AssignParkingRestrictions](#vestate-assignparkingrestrictions) 

* [**marea_speed_smooth_ecodrive.csv**](#vestate-marea_speed_smooth_ecodrive.csv) This input file supplies information of deployment of speed smoothing and ecodriving by road class and vehicle type and is used in the [CalculateMpgMpkwhAdjustments](#calculatempgmpkwhadjustments) module.          

* [**marea_transit_ave_fuel_carbon_intensity.csv**](#vestate-marea_transit_ave_fuel_carbon_intensity.csv) This file is used to specify the average carbon intensity of fuel used by transit and is optional. The file is used in the [Initialize (VETravelPerformance)](#vestate-initialize-vetravelperformance) module. 

* [**marea_transit_biofuel_mix.csv**](#vestate-marea_transit_biofuel_mix.csv) This file is used to specify the biofuel used by transit and is optional. The file is used in the [Initialize (VETravelPerformance)](#vestate-initialize-vetravelperformance) and [CalculateCarbonIntensity](#vestate-calculatecarbonintensity) modules.             

* [**marea_transit_fuel.csv**](#vestate-marea_transit_fuel.csv) This file is used to specify the transit fuel proportions and is optional. The file is used in the [Initialize (VETravelPerformance)](#vestate-initialize-vetravelperformance) and [CalculateCarbonIntensity](#vestate-calculatecarbonintensity) modules.                      

* [**marea_transit_powertrain_prop.csv**](#vestate-marea_transit_powertrain_prop.csv) This file is used to specify the mixes of transit vehicle powertrains and is optional. The file is used in the [Initialize (VETravelPerformance)](#vestate-initialize-vetravelperformance) and [CalculatePtranEnergyAndEmissions](#vestate-calculateptranenergyandemissions) modules.     

* [**marea_transit_service.csv**](#vestate-marea_transit_service.csv) This file contains annual revenue-miles for different transit modes for metropolitan area and is used in the [AssignTransitService](#vestate-assigntransitservice) module.                   

* [**marea_travel-demand-mgt_by_area-type.csv**](#vestate-marea_travel-demand-mgt_by_area-type.csv) This file has the data for proportions participating in demand management programs and is used in the [AssignDemandManagement](#vestate-assigndemandmanagement) module.                   

* [**marea_uza_profile_names.csv**](#vestate-marea_uza_profile_names.csv) This file provides the name of a specific urbanized area for the urbanized area profile to use in SimBzone creation and is used in the [Initialize](#vestate-initialize) module.

* [**other_ops_effectiveness.csv**](#vestate-other_ops_effectiveness.csv) This file is used to specify the delay effects of operations in different road classes and is optional (only needed if user wants to modify the values). The file is used in the [Initialize (VETravelPerformance)](#vestate-initialize-vetravelperformance) and [CalculateRoadPerformance](#vestate-calculateroadperformance) modules. 

* [**region_ave_fuel_carbon_intensity.csv**](#vestate-region_ave_fuel_carbon_intensity.csv) This file is used to specify the average carbon density for different vehicle types and is optional (only needed if user wants to modify the values). The file is used in the [Initialize (VETravelPerformance)](#vestate-initialize-vetravelperformance) and [CalculateCarbonIntensity](#vestate-calculatecarbonintensity) modules.       

* [**region_base_year_hvytrk_dvmt.csv**](#vestate-region_base_year_hvytrk_dvmt.csv) This file is used to specify the heavy truck dvmt for base year and is optional. The file is used in the [Initialize (VETravelPerformance)](#vestate-initialize-vetravelperformance), [CalculateBaseRoadDvmt](#vestate-calculatebaseroaddvmt) and [CalculateFutureRoadDvmt](#vestate-calculatefutureroaddvmt)  modules.            

* [**region_carsvc_powertrain_prop.csv**](#vestate-region_carsvc_powertrain_prop.csv) This file is used to specify the powertrain proportion of car services and is optional. The file is used in the [Initialize (VETravelPerformance)](#vestate-initialize-vetravelperformance), [AssignHhVehiclePowertrain](#vestate-assignhhvehiclepowertrain) and [AdjustHhVehicleMpgMpkwh](#vestate-adjusthhvehiclempgmpkwh) modules.

* [**region_comsvc_lttrk_prop.csv**](#vestate-region_comsvc_lttrk_prop.csv) This file supplies data for the light truck proportion of commercial vehicles and is used in the [CalculateComEnergyAndEmissions](#vestate-calculatecomenergyandemissions) module.   

* [**region_comsvc_powertrain_prop.csv**](#vestate-region_comsvc_powertrain_prop.csv) This file is used to specify the powertrain proportion of commercial vehicles and is optional. The file is used in the [Initialize (VEPowertrainsAndFuels)](#vestate-initialize-vepowertrainsandfuels) and [CalculateComEnergyAndEmissions](#vestate-calculatecomenergyandemissions) modules.   

* [**region_comsvc_veh_mean_age.csv**](#vestate-region_comsvc_veh_mean_age.csv) This input file contains average age of commercial service vehicles and is used in the [CalculateComEnergyAndEmissions](#vestate-calculatecomenergyandemissions) module.     

* [**region_hh_driver_adjust_prop.csv**](#vestate-region_hh_driver_adjust_prop.csv) This file specifies the relative driver licensing rate relative to the model estimation data year and is used in the [AssignDrivers](#vestate-assigndrivers) module. 

* [**region_hvytrk_powertrain_prop.csv**](#vestate-region_hvytrk_powertrain_prop.csv) This file is used to specify the powertrain proportion of heavy duty trucks and is optional. The file is used in the [Initialize (VEPowertrainsAndFuels)](#vestate-initialize-vepowertrainsandfuels) and [CalculateComEnergyAndEmissions](#vestate-calculatecomenergyandemissions) modules.

* [**region_prop_externalities_paid.csv**](#vestate-region_prop_externalities_paid.csv) This file supplies data for climate change and other social costs and is used in the [CalculateVehicleOperatingCost](#vestate-calculatevehicleoperatingcost) module. 

* [**region_road_cost.csv**](#vestate-region_road_cost.csv) This file supplies data for different types of road costs and is used in the [BalanceRoadCostsAndRevenues](#vestate-balanceroadcostsandrevenues) module. 

### azone_carsvc_characteristics.csv {#vestate-azone_carsvc_characteristics.csv}

This file specifies the different characteristics for high and low car service levels

* **HighCarSvcCost**: Average cost in dollars per mile for travel by high service level car service
* **LowCarSvcCost**: Average cost in dollars per mile for travel by low service level car service
* **AveCarSvcVehicleAge**: Average age of car service vehicles in years
* **LtTrkCarSvcSubProp**: The proportion of light-truck owners who would substitute a less-costly car service option for owning their light truck
* **AutoCarSvcSubProp**: The proportion of automobile owners who would substitute a less-costly car service option for owning their automobile

Here is a snapshot of the file:

<img align="center" width="800" border=1 src="images/azone_carsvc_characteristics.PNG">

### azone_charging_availability.csv {#vestate-azone_charging_availability.csv}

This input file supplies data on proportion of different household types who has available charging 

* **PropSFChargingAvail**: Proportion of single-family dwellings in Azone that have PEV charging facilties installed or able to be installed
* **PropMFChargingAvail**: Proportion of multi-family dwelling units in Azone that have PEV charging facilities available
* **PropGQChargingAvail**: Proportion of group quarters dwelling units in Azone that have PEV charging facilities available
  

Here is a snapshot of the file:	

<img align="center" width="500" border=1 src="images/azone_charging_availability.PNG">

### azone_electricity_carbon_intensity.csv {#vestate-azone_electricity_carbon_intensity.csv}

This input file is OPTIONAL. It is only needed if the user wants to modify the carbon intensity of electricity.

* **ElectricityCI**: Carbon intensity of electricity at point of consumption (grams CO2e per megajoule)

Here is a snapshot of the file:

<img align="center" width="200" border=1 src="images/azone_electricity_carbon_intensity.PNG">

### azone_fuel_power_cost.csv {#vestate-azone_fuel_power_cost.csv} 

This file supplies data for retail cost of fuel and electricity

* **FuelCost**:Retail cost of fuel per gas gallon equivalent in dollars
* **PowerCost**: Retail cost of electric power per kilowatt-hour in dollars
  

Here is a snapshot of the file:	

 <img align="center" width="400" border=1 src="images/azone_fuel_power_cost.PNG">

### azone_gq_pop_by_age.csv {#vestate-azone_gq_pop_by_age.csv}

This file contains group quarters population estimates/forecasts by age for each of the base and future years. The file format includes number of persons within the following six age categories:

   * 0-14
   * 15-19
   * 20-29
   * 30-54
   * 55-64
   * 65 Plus

Here is a snapshot of the file:

<img align="center" width="800" border=1 src="images/azone_gq_pop_by_age.PNG">

### azone_gq_pop-prop_by_area-type.csv {#vestate-azone_gq_pop-prop_by_area-type.csv} 

This file provides the proportions for groupquarters in different [area types](model-inputs.html#land-use-inputs). These proportions should add up to 1 in any Azone zone that has non-zero groupquarters population.
If the file contains NA values, it will be ignored and groupquarters population will be distributed equally among the simulated Bzones.

* **PropGQPopCenter**: Proportion of groupquarters population in center area type
* **PropGQPopInner**: Proportion of groupquarters population in inner area type
* **PropGQPopOuter**: Proportion of groupquarters population in outer area type
* **PropGQPopFringe**: Proportion of groupquarters population in fringe area type

### azone_hh_loc_type_prop.csv {#vestate-azone_hh_loc_type_prop.csv}

This file provides the proportions for households residing in the metropolitan, towns and rural part of the Azone

* **PropMetroHh**: Proportion of households residing in the metropolitan (i.e. urbanized) part of the Azone
* **PropTownHh**: Proportion of households residing in towns (i.e. urban-like but not urbanized) in the Azone
* **PropRuralHh**: Proportion of households residing in rural (i.e. not urbanized or town) parts of the Azone

Here is a snapshot of the file:

<img align="center" width="400" border=1 src="images/hh_loc_type.PNG">   

### azone_hh_pop_by_age.csv {#vestate-azone_hh_pop_by_age.csv}

This file contains population estimates/forecasts by age for each of the base and future years. The file format includes number of persons within six age groups:

* 0-14
* 15-19
* 20-29
* 30-54
* 55-64
* 65 Plus

Here is a snapshot of the file:

<img align="center" width="800" border=1 src="images/azone_hh_pop_by_age.PNG">

### azone_hh_veh_mean_age.csv {#vestate-azone_hh_veh_mean_age.csv}

This file provides inputs for mean auto age and mean light truck age by Azone.

* **AutoMeanAge**: Mean age of automobiles owned or leased by households.
* **LtTrkMeanAge**: Mean age of light trucks owned or leased by households.

Here is a snapshot of the file:

<img align="center" width="400" border=1 src="images/azone_hh_veh_mean_age.PNG">

### azone_hh_veh_own_taxes.csv {#vestate-azone_hh_veh_own_taxes.csv} 

This file provides inputs for flat fees/taxes (i.e. annual cost per vehicle) and ad valorem taxes (i.e. percentage of vehicle value paid in taxes).

* **VehOwnFlatRateFee**: Annual flat rate tax per vehicle in dollars
* **VehOwnAdValoremTax**: Annual proportion of vehicle value paid in taxes
  

Here is a snapshot of the file:

<img align="center" width="500" border=1 src="images/azone_hh_veh_own_taxes.PNG">

### azone_hhsize_targets.csv {#vestate-azone_hhsize_targets.csv}

Rhis file contains the household-specific targets for the population synthesizer. This file contains two attributes: 

* **AveHhSize**: Average household size for non-group quarters households
* **Prop1PerHh**: Proportion of non-group quarters households having only one person

Here is a snapshot of the file:

<img align="center" width="400" border=1 src="images/azone_hhsize_targets.PNG">

### azone_loc_type_land_area.csv {#vestate-azone_loc_type_land_area.csv}

This file provides land area data for different area types

* **MetroLandArea**: Land area (excluding large water bodies and large tracts of undevelopable land) in the metropolitan (i.e. urbanized) portion of the Azone
* **TownLandArea**: Land area (excluding large water bodies and large tracts of undevelopable land) in towns (i.e. urban-like but not urbanized) in the Azone
* **RuralAveDensity**: Average activity density (households and jobs per acre) of rural (i.e. not metropolitan or town) portions of the Azone not including large waterbodies or large tracts of agricultural lands, forest lands, or otherwise protected lands

Here is a snapshot of the file:

<img align="center" width="400" border=1 src="images/land_area.PNG">

### azone_lttrk_prop.csv {#vestate-azone_lttrk_prop.csv}

This file specifies the light truck proportion of the vehicle fleet.

* **LtTrkProp**: Proportion of household vehicles that are light trucks (pickup, SUV, van).
  

Here is a snapshot of the file:

<img align="center" width="300" border=1 src="images/azone_lttrk_prop.PNG">

### azone_payd_insurance_prop.csv {#vestate-}

This file provides inputs on the proportion of households having PAYD insurance.

* **PaydHhProp**: Proportion of households in the Azone who have pay-as-you-drive insurance for their vehicles
  

Here is a snapshot of the file:

<img align="center" width="300" border=1 src="images/azone_payd_insurance_prop.PNG">

### azone_per_cap_inc.csv {#vestate-azone_per_cap_inc.csv}

This file contains information on regional average per capita household (`HHIncomePC`) and group quarters (`GQIncomePC`) income by forecast year in year 2010 dollars. The data can be obtained from the U.S. Department of Commerce Bureau of Economic Analysis for the current year or from regional or state sources for forecast years. In order to use current year dollars just replace 2010 in column labels with current year. For example, if the data is obtained in year 2015 dollars then the column labels in the file shown below will become `HHIncomePC.2015` and `GQIncomePC.2015`. 

Here is a snapshot of the file:

<img align="center" width="400" border=1 src="images/azone_per_cap_inc.PNG">

### azone_prop_sov_dvmt_diverted.csv {#vestate-azone_prop_sov_dvmt_diverted.csv} 

This file provides inputs for a goal for diverting a portion of SOV travel within a 20-mile tour distance (round trip distance).

* **PropSovDvmtDiverted**: Goals for the proportion of household DVMT in single occupant vehicle tours with round-trip distances of 20 miles or less be diverted to bicycling or other slow speed modes of travel
  

Here is a snapshot of the file:

<img align="center" width="400" border=1 src="images/azone_prop_sov_dvmt_diverted.PNG">

### azone_relative_employment.csv {#vestate-azone_relative_employment.csv}

This file contains the ratio of workers to persons by age cohort in the model year relative to the model estimation data year. This file contains five age cohorts:

* **RelEmp15to19**: Ratio of workers to persons age 15 to 19 in model year versus in estimation data year
* **RelEmp20to29**: Ratio of workers to persons age 20 to 29 in model year versus in estimation data year
* **RelEmp30to54**: Ratio of workers to persons age 30 to 54 in model year versus in estimation data year
* **RelEmp55to64**: Ratio of workers to persons age 55 to 64 in model year versus in estimation data year
* **RelEmp65Plus**: Ratio of workers to persons age 65 or older in model year versus in estimation data year

Here is a snapshot of the file:

<img align="center" width="800" border=1 src="images/azone_relative_employment.PNG">

### azone_veh_use_taxes.csv {#vestate-azone_veh_use_taxes.csv}

This file supplies data for vehicle related taxes

* **FuelTax**:Tax per gas gallon equivalent of fuel in dollars
* **VmtTax**: Tax per mile of vehicle travel in dollars
* **PevSurchgTaxProp**: Proportion of equivalent gas tax per mile paid by hydrocarbon fuel consuming vehicles to be charged to plug-in electric vehicles per mile of travel powered by electricity

Here is a snapshot of the file:	

<img align="center" width="400" border=1 src="images/azone_veh_use_taxes.PNG">

### azone_vehicle_access_times.csv {#vestate-azone_vehicle_access_times.csv}

This file supplies data for vehicle access and eagress time.

* **OwnedVehAccessTime**:Average amount of time in minutes required for access to and egress from a household-owned vehicle for a trip
* **HighCarSvcAccessTime**: Average amount of time in minutes required for access to and egress from a high service level car service for a trip
* **LowCarSvcAccessTime**: Average amount of time in minutes required for access to and egress from a low service level car service for a trip
  

Here is a snapshot of the file:	

<img align="center" width="500" border=1 src="images/azone_vehicle_access_times.PNG">

### azone_wkr_loc_type_prop.csv {#vestate-azone_wkr_loc_type_prop}

This file provides the proportions for workers residing in Azone who works in the metropolitan, towns and rural part of the Azone

* **PropWkrInMetroJobs**: Proportion of workers residing in the Azone who work at jobs in the metropolitan (i.e. urbanized) area associated with the Azone
* **PropWkrInTownJobs**: Proportion of workers residing in the Azone who work at jobs in towns (i.e. urban-like but not urbanized) in the Azone
* **PropWkrInRuralJobs**: Proportion of workers residing in the Azone who work at jobs in rural (i.e. not urbanized or town) parts of the Azone
* **PropMetroJobs**: Proportion of the jobs of the metropolitan area that the Azone is associated with that are located in the metropolitan portion of the Azone
  

Here is a snapshot of the file:

<img align="center" width="400" border=1 src="images/wrk_loc_prop.PNG">

### marea_base_year_dvmt.csv {#vestate-marea_base_year_dvmt.csv}

This input file is OPTIONAL. It is only needed if the user wants to modify the adjust dvmt growth factors from base year in by Marea

* **ComSvcDvmtGrowthBasis**: Factor used to grow commercial service vehicle DVMT in Marea from base year value
* **HvyTrkDvmtGrowthBasis**: Factor used to grow heavy truck DVMT from base year value
* **UrbanLdvDvmt**: Average daily vehicle miles of travel on roadways in the urbanized portion of the Marea by light-duty vehicles during the base year
* **UrbanHvyTrkDvmt**: Average daily vehicle miles of travel on roadways in the urbanized portion of the Marea by heavy trucks during he base year

Here is a snapshot of the file:	

<img align="center" width="800" border=1 src="images/marea_base_year_dvmt.PNG">

### marea_carsvc_availability.csv {#vestate-marea_carsvc_availability.csv}

This file has the data for acitivity proportions which are served by car services

* **CenterPropHighCarSvc**: Proportion of activity in center area type that is served by high level car service (i.e. service competitive with household owned car)
* **InnerPropHighCarSvc**: Proportion of activity in inner area type that is served by high level car service (i.e. service competitive with household owned car)
* **OuterPropHighCarSvc**: Proportion of activity in outer area type that is served by high level car service (i.e. service competitive with household owned car)
* **FringePropHighCarSvc**: Proportion of activity in fringe area type that is served by high level car service (i.e. service competitive with household owned car)

Here is a snapshot of the file:

<img align="center" width="500" border=1 src="images/car_service.PNG">

### marea_congestion_charges.csv {#vestate-marea_congestion_charges.csv}

This input file is OPTIONAL. It is only needed if the user wants to modify the charges of vehicle travel for different congestion levels

* **FwyNoneCongChg**: Charge per mile (U.S. dollars) of vehicle travel on freeways during periods of no congestion
* **FwyModCongChg**: Charge per mile (U.S. dollars) of vehicle travel on freeways during periods of moderate congestion
* **FwyHvyCongChg**: Charge per mile (U.S. dollars) of vehicle travel on freeways during periods of heavy congestion
* **FwySevCongChg**: Charge per mile (U.S. dollars) of vehicle travel on freeways during periods of severe congestion
* **FwyExtCongChg**: Charge per mile (U.S. dollars) of vehicle travel on freeways during periods of extreme congestion
* **ArtNoneCongChg**: Charge per mile (U.S. dollars) of vehicle travel on arterials during periods of no congestion
* **ArtModCongChg**: Charge per mile (U.S. dollars) of vehicle travel on arterials during periods of moderate congestion
* **ArtHvyCongChg**: Charge per mile (U.S. dollars) of vehicle travel on arterials during periods of heavy congestion
* **ArtSevCongChg**: Charge per mile (U.S. dollars) of vehicle travel on arterials during periods of severe congestion
* **ArtExtCongChg**: Charge per mile (U.S. dollars) of vehicle travel on arterials during periods of extreme congestion

Here is a snapshot of the file:	

<img align="center" width="1500" border=1 src="images/marea_congestion_charges.PNG">

### marea_dvmt_split_by_road_class.csv {#vestate-marea_dvmt_split_by_road_class.csv}

This input file is OPTIONAL. It is only needed if the user wants to modify the dvmt split for different road classes.

* **LdvFwyArtDvmtProp**: Proportion of light-duty daily vehicle miles of travel in the urbanized portion of the Marea occurring on freeway or arterial roadways
* **LdvOthDvmtProp**: Proportion of light-duty daily vehicle miles of travel in the urbanized portion of the Marea occurring on other roadways
* **HvyTrkFwyDvmtProp**: Proportion of heavy truck daily vehicle miles of travel in the urbanized portion of the Marea occurring on freeways
* **HvyTrkArtDvmtProp**: Proportion of heavy truck daily vehicle miles of travel in the urbanized portion of the Marea occurring on arterial roadways
* **HvyTrkOthDvmtProp**: Proportion of heavy truck daily vehicle miles of travel in the urbanized portion of the Marea occurring on other roadways
* **BusFwyDvmtProp**: Proportion of bus daily vehicle miles of travel in the urbanized portion of the Marea occurring on freeways
* **BusArtDvmtProp**: Proportion of bus daily vehicle miles of travel in the urbanized portion of the Marea occurring on arterial roadways
* **BusOthDvmtProp**: Proportion of bus daily vehicle miles of travel in the urbanized portion of the Marea occuring on other roadways

Here is a snapshot of the file:	

<img align="center" width="1200" border=1 src="images/marea_dvmt_split_by_road_class.PNG">

### marea_d3bpo4_adj.csv {#vestate-marea_d3bpo4_adj.csv}

This file provides the D3bpo4 value for urban, town and rural areas from the EPA 2010 Smart Location Database

* **UrbanD3bpo4Adj**: Proportion of base urban D3bpo4 value as tabulated from the EPA 2010 Smart Location Database for the urbanized portion of the marea
* **TownD3bpo4Adj**: Proportion of base town D3bpo4 value as tabulated from the EPA 2010 Smart Location Database for towns
* **RuralD3bpo4Adj**: Proportion of base town D3bpo4 value as tabulated from the EPA 2010 Smart Location Database for rural areas

Here is a snapshot of the file:

<img align="center" width="400" border=1 src="images/d3.PNG">   

### marea_lane_miles.csv {#vestate-marea_lane_miles.csv}

This file contains inputs on the numbers of freeway lane-miles and arterial lane-miles by `Marea` and year.

* **FwyLaneMi**: Lane-miles of roadways functionally classified as freeways or expressways in the urbanized portion of the metropolitan area
* **ArtLaneMi**: Lane-miles of roadways functionally classified as arterials (but not freeways or expressways) in the urbanized portion of the metropolitan area

Here is a snapshot of the file:

<img align="center" width="400" border=1 src="images/marea_lane_miles.PNG">

### marea_mix_targets.csv {#vestate-marea_mix_targets.csv}

This file represents Marea target for proportion of households located in mixed-use neighborhoods (or NA if no target)

* **UrbanMixProp**: Marea target for proportion of households located in mixed-use neighborhoods (or NA if no target)

Here is a snapshot of the file:

<img align="center" width="400" border=1 src="images/mix.PNG">   

### marea_operations_deployment.csv {#vestate-marea_operations_deployment.csv}

This input file is OPTIONAL. It is only needed if the user wants to modify the proportion of dvmt affected by operations for different road classes.

* **RampMeterDeployProp**: Proportion of freeway DVMT affected by ramp metering deployment
* **IncidentMgtDeployProp**: Proportion of freeway DVMT affected by incident management deployment
* **SignalCoordDeployProp**: Proportion of arterial DVMT affected by signal coordination deployment
* **AccessMgtDeployProp**: Proportion of arterial DVMT affected by access management deployment
* **OtherFwyOpsDeployProp**: Proportion of freeway DVMT affected by deployment of other user-defined freeway operations measures
* **OtherArtOpsDeployProp**: Proportion of arterial DVMT affected by deployment of other user-defined arterial operations measures

Here is a snapshot of the file:	

<img align="center" width="1200" border=1 src="images/marea_operations_deployment.PNG">

### marea_parking-avail_by_area-type.csv {#vestate-marea_parking-avail_by_area-type.csv}

This file has the data for avereage number of parkings available to households

* **CenterPkgSpacesPerSFDU**: Average number of free parking spaces available to residents of single-family dwelling units in center area type
* **InnerPkgSpacesPerSFDU**: Average number of free parking spaces available to residents of single-family dwelling units in inner area type
* **OuterPkgSpacesPerSFDU**: Average number of free parking spaces available to residents of single-family dwelling units in outer area type
* **CenterPkgSpacesPerMFDU**: Average number of free parking spaces available to residents of multifamily dwelling units in center area type
* **InnerPkgSpacesPerMFDU**: Average number of free parking spaces available to residents of multifamily dwelling units in inner area type
* **OuterPkgSpacesPerMFDU**: Average number of free parking spaces available to residents of multifamily dwelling units in outer area type
* **CenterPkgSpacesPerGQ**: Average number of free parking spaces available to group quarters residents in center area type
* **InnerPkgSpacesPerGQ**: Average number of free parking spaces available to group quarters residents in inner area type
* **OuterPkgSpacesPerGQ**: Average number of free parking spaces available to group quarters residents in outer area type

Here is a snapshot of the file:

<img align="center" width="800" border=1 src="images/park_availablity.PNG">   

### marea_parking-cost_by_area-type.csv {#vestate-marea_parking-cost_by_area-type.csv}

This file has the data related to parking costs and population proportions paying the parking costs

* **CenterPropWkrPay**: Proportion of workers who pay for parking in center area type
* **InnerPropWkrPay**: Proportion of workers who pay for parking in inner area type
* **OuterPropWkrPay**: Proportion of workers who pay for parking in outer area type
* **CenterPropCashOut**: Proportions of workers paying for parking in a cash-out-buy-back program in center area type
* **InnerPropCashOut**: Proportions of workers paying for parking in a cash-out-buy-back program in inner area type
* **OuterPropCashOut**: Proportions of workers paying for parking in a cash-out-buy-back program in outer area type
* **CenterPkgCost**: Average daily cost for long-term parking (e.g. paid on monthly basis) in center area type
* **InnerPkgCost**: Average daily cost for long-term parking (e.g. paid on monthly basis) in inner area type
* **OuterPkgCost**: Average daily cost for long-term parking (e.g. paid on monthly basis) in outer area type

Here is a snapshot of the file:

<img align="center" width="800" border=1 src="images/park_cost.PNG"> 

### marea_speed_smooth_ecodrive.csv {#vestate-marea_speed_smooth_ecodrive.csv}

This input file supplies information of deployment of speed smoothing and ecodriving by road class and vehicle type

* **FwySmooth**:Fractional deployment of speed smoothing traffic management on freeways, where 0 is no deployment and 1 is the full potential fuel savings
* **ArtSmooth**: Fractional deployment of speed smoothing traffic management on arterials, where 0 is no deployment and 1 is the full potential fuel savings
* **LdvEcoDrive**: Eco-driving penetration for light-duty vehicles; the fraction of vehicles from 0 to 1
* **HvyTrkEcoDrive**: Eco-driving penetration for heavy-duty vehicles; the fraction of vehicles from 0 to 1
  

Here is a snapshot of the file:	

<img align="center" width="600" border=1 src="images/marea_speed_smooth_ecodrive.PNG">

### marea_transit_ave_fuel_carbon_intensity.csv {#vestate-marea_transit_ave_fuel_carbon_intensity.csv}

This input file is OPTIONAL. It is only needed if the user wants to modify the average carbon intensity of fuel used by transit.

* **TransitVanFuelCI**: Average carbon intensity of fuel used by transit vans (grams CO2e per megajoule)
* **TransitBusFuelCI**: Average carbon intensity of fuel used by transit buses (grams CO2e per megajoule)
* **TransitRailFuelCI**: Average carbon intensity of fuel used by transit rail vehicles (grams CO2e per megajoule)

Here is a snapshot of the file:

<img align="center" width="400" border=1 src="images/marea_transit_ave_fuel_carbon_intensity.PNG">

### marea_transit_biofuel_mix.csv {#vestate-marea_transit_biofuel_mix.csv} 

This input file is OPTIONAL. It is only needed if the user wants to modify the biofuel used by transit services.

* **TransitEthanolPropGasoline**: Ethanol proportion of gasoline used by transit vehicles
* **TransitBiodieselPropDiesel**: Biodiesel proportion of diesel used by transit vehicles
* **TransitRngPropCng**: Renewable natural gas proportion of compressed natural gas used by transit vehicles

Here is a snapshot of the file:

<img align="center" width="600" border=1 src="images/marea_transit_biofuel_mix.PNG">
			

### marea_transit_fuel.csv {#vestate-marea_transit_fuel.csv}

This input file is OPTIONAL. It is only needed if the user wants to modify the transit fuels proportions.

* **VanPropDiesel**: Proportion of non-electric transit van travel powered by diesel
* **VanPropGasoline**: Proportion of non-electric transit van travel powered by gasoline
* **VanPropCng**: Proportion of non-electric transit van travel powered by compressed natural gas
* **BusPropDiesel**: Proportion of non-electric transit bus travel powered by diesel
* **BusPropGasoline**: Proportion of non-electric transit bus travel powered by gasoline
* **BusPropCng**: Proportion of non-electric transit bus travel powered by compressed natural gas
* **RailPropDiesel**: Proportion of non-electric transit rail travel powered by diesel
* **RailPropGasoline**: Proportion of non-electric transit rail travel powered by gasoline

Here is a snapshot of the file:

<img align="center" width="1100" border=1 src="images/marea_transit_fuel.PNG">

### marea_transit_powertrain_prop.csv {#vestate-marea_transit_powertrain_prop.csv}

This input file is OPTIONAL. It is only needed if the user wants to modify the mixes of transit vehicle powertrains.

* **VanPropIcev**: Proportion of transit van travel using internal combustion engine powertrains
* **VanPropHev**: Proportion of transit van travel using hybrid electric powertrains
* **VanPropBev**: Proportion of transit van travel using battery electric powertrains
* **BusPropIcev**: Proportion of transit bus travel using internal combustion engine powertrains 
* **BusPropHev**: Proportion of transit bus travel using hybrid electric powertrains
* **BusPropBev**: Proportion of transit bus travel using battery electric powertrains
* **RailPropIcev**: Proportion of transit rail travel using internal combustion engine powertrains
* **RailPropHev**: Proportion of transit rail travel using hybrid electric powertrains
* **RailPropEv**: Proportion of transit rail travel using electric powertrains

    

Here is a snapshot of the file:

<img align="center" width="1100" border=1 src="images/marea_transit_powertrain_prop.PNG">

### marea_transit_service.csv {#vestate-marea_transit_service.csv}

This file contains annual revenue-miles for different transit modes for metropolitan area.

 **DRRevMi**: Annual revenue-miles of demand-responsive public transit service
 **VPRevMi**: Annual revenue-miles of van-pool and similar public transit service
 **MBRevMi**: Annual revenue-miles of standard bus public transit service
 **RBRevMi**: Annual revenue-miles of rapid-bus and commuter bus public transit service
 **MGRevMi**: Annual revenue-miles of monorail and automated guideway public transit service
 **SRRevMi**: Annual revenue-miles of streetcar and trolleybus public transit service
 **HRRevMi**: Annual revenue-miles of light rail and heavy rail public transit service
 **CRRevMi**: Annual revenue-miles of commuter rail, hybrid rail, cable car, and aerial tramway public transit service

Here is a snapshot of the file:

<img align="center" width="800" border=1 src="images/marea_transit_service.PNG">

### marea_travel-demand-mgt_by_area-type.csv {#vestate-marea_travel-demand-mgt_by_area-type.csv}

This file has the data for proportions participating in demand management programs

* **CenterEcoProp**: Proportion of workers working in center area type in Marea who participate in strong employee commute options program
* **InnerEcoProp**: Proportion of workers working in inner area type in Marea who participate in strong employee commute options program
* **OuterEcoProp**: Proportion of workers working in outer area type in Marea who participate in strong employee commute options program
* **FringeEcoProp**: Proportion of workers working in fringe area type in Marea who participate in strong employee commute options program
* **CenterImpProp**: Proportion of households residing in center area type in Marea who participate in strong individualized marketing program
* **InnerImpProp**: Proportion of households residing in inner area type in Marea who participate in strong individualized marketing program
* **OuterImpProp**: Proportion of households residing in outer area type in Marea who participate in strong individualized marketing program
* **FringeImpProp**: Proportion of households residing in fringe area type in Marea who participate in strong individualized marketing program

Here is a snapshot of the file:

<img align="center" width="500" border=1 src="images/demand_management.PNG">

### marea_uza_profile_names.csv {#vestate-marea_uza_profile_names.csv}

This file provides the name of a specific urbanized area for the urbanized area profile to use in SimBzone creation.

* **UzaProfileName**: Name of a specific urbanized area for the urbanized area profile to use in SimBzone creation or one of the following: small, medium-small, medium, medium-large, large, very-large

Here is a snapshot of the file:

<img align="center" width="200" border=1 src="images/uza.PNG">   

### other_ops_effectiveness.csv {#vestate-other_ops_effectiveness.csv}

This input file is OPTIONAL. It is only needed if the user wants to modify the other delay effects of operations in different road classes

* **Level**: Congestion levels: None = none, Mod = moderate, Hvy = heavy, Sev = severe, Ext = extreme
* **Art_Rcr**: Percentage reduction of recurring arterial delay that would occur with full deployment of other user-defined arterial operations measures
* **Art_NonRcr**: Percentage reduction of non-recurring arterial delay that would occur with full deployment of other user-defined arterial operations measures
* **Fwy_Rcr**: Percentage reduction of recurring freeway delay that would occur with full deployment of other user-defined freeway operations measures
* **Fwy_NonRcr**: Percentage reduction of non-recurring freeway delay that would occur with full deployment of other user-defined freeway operations measures
  

Here is a snapshot of the file:	

<img align="center" width="500" border=1 src="images/other_ops_effectiveness.PNG">

### region_ave_fuel_carbon_intensity.csv {#vestate-region_ave_fuel_carbon_intensity.csv}

This input file is OPTIONAL. It is only needed if the user wants to modify the average carbon density for different vehicle types.

* **HhFuelCI**: Average carbon intensity of fuels used by household vehicles (grams CO2e per megajoule)
* **CarSvcFuelCI**: Average carbon intensity of fuels used by car service vehicles (grams CO2e per megajoule)
* **ComSvcFuelCI**: Average carbon intensity of fuels used by commercial service vehicles (grams CO2e per megajoule)
* **HvyTrkFuelCI**: Average carbon intensity of fuels used by heavy trucks (grams CO2e per megajoule)
* **TransitVanFuelCI**: Average carbon intensity of fuels used by transit vans (grams CO2e per megajoule)
* **TransitBusFuelCI**: Average carbon intensity of fuels used by transit buses (grams CO2e per megajoule)
* **TransitRailFuelCI**: Average carbon intensity of fuels used by transit rail vehicles (grams CO2e per megajoule)

Here is a snapshot of the file:	

<img align="center" width="800" border=1 src="images/region_ave_fuel_carbon_intensity.PNG">

### region_base_year_hvytrk_dvmt.csv {#vestate-region_base_year_hvytrk_dvmt.csv}

This input file is OPTIONAL. It is only needed if the user wants to adjust heavy truck dvmt for base year

* **HvyTrkDvmtGrowthBasis**: Factor used to grow heavy truck DVMT from base year value
* **HvyTrkDvmt**: Average daily vehicle miles of travel on roadways in the region by heavy trucks during he base year
* **HvyTrkDvmtUrbanProp**: Proportion of Region heavy truck daily vehicle miles of travel occurring on urbanized area roadways

Here is a snapshot of the file:	

<img align="center" width="600" border=1 src="images/region_base_year_hvytrk_dvmt.PNG">

### region_carsvc_powertrain_prop.csv {#vestate-region_carsvc_powertrain_prop.csv}

This input file is OPTIONAL. It is only needed if the user wants to modify the powertrain proportion of car services.

* **CarSvcAutoPropIcev**: Proportion of car service automobile travel powered by internal combustion engine powertrains
* **CarSvcAutoPropHev**: Proportion of car service automobile travel powered by hybrid electric powertrains
* **CarSvcAutoPropBev**: Proportion of car service automobile travel powered by battery electric powertrains
* **CarSvcLtTrkPropIcev**: Proportion of car service light truck travel powered by internal combustion engine powertrains
* **CarSvcLtTrkPropHev**: Proportion of car service light truck travel powered by hybrid electric powertrains
* **CarSvcLtTrkPropBev**: Proportion of car service light truck travel powered by battery electric powertrains
  

Here is a snapshot of the file:	

<img align="center" width="800" border=1 src="images/region_carsvc_powertrain_prop.PNG">

### region_comsvc_lttrk_prop.csv {#vestate-region_comsvc_lttrk_prop.csv}

This input file defines the proportion of commerical vehicles that are light trucks.

* **ComSvcLtTrkProp**: Regional proportion of commercial service vehicles that are light trucks

Here is a snapshot of the file:

| Year | ComSvcLtTrkProp |
| ---- | --------------- |
| 2010 | 0.51            |
| 2040 | 0.51            |
### region_comsvc_powertrain_prop.csv {#vestate-region_comsvc_powertrain_prop.csv}

This input file is OPTIONAL. It is only needed if the user wants to modify the powertrain proportion of commercial vehicles.

* **ComSvcAutoPropIcev**: Proportion of commercial service automobile travel powered by internal combustion engine powertrains
* **ComSvcAutoPropHev**: Proportion of commercial service automobile travel powered by hybrid electric powertrains
* **ComSvcAutoPropBev**: Proportion of commercial service automobile travel powered by battery electric powertrains
* **ComSvcLtTrkPropIcev**: Proportion of commercial service light truck travel powered by internal combustion engine powertrains
* **ComSvcLtTrkPropHev**: Proportion of commercial service light truck travel powered by hybrid electric powertrains
* **ComSvcLtTrkPropBev**: Proportion of commercial service light truck travel powered by battery electric powertrains

Here is a snapshot of the file:	

<img align="center" width="800" border=1 src="images/region_comsvc_powertrain_prop.PNG">

### region_comsvc_veh_mean_age.csv {#vestate-region_comsvc_veh_mean_age.csv}

This input file contains average age of commercial service vehicles

   * **AveComSvcVehicleAge**: average age of commercial service vehicles

Here is a snapshot of the file:	

<img align="center" width="400" border=1 src="images/age.PNG">

### region_hh_driver_adjust_prop.csv {#vestate-region_hh_driver_adjust_prop.csv}

This file specifies the relative driver licensing rate relative to the model estimation data year in order to account for observed or projected changes in licensing rates.

* **Drv15to19AdjProp**: Target proportion of unadjusted model number of drivers 15 to 19 years old (`1` = no adjustment)
* **Drv20to29AdjProp**: Target proportion of unadjusted model number of drivers 20 to 29 years old (`1` = no adjustment)
* **Drv30to54AdjProp**: Target proportion of unadjusted model number of drivers 30 to 54 years old (`1` = no adjustment)
* **Drv55to64AdjProp**: Target proportion of unadjusted model number of drivers 55 to 64 years old (`1` = no adjustment)
* **Drv65PlusAdjProp**: Target proportion of unadjusted model number of drivers 65 or older (`1` = no adjustment)
  

Here is a snapshot of the file:

<img align="center" width="800" border=1 src="images/region_hh_driver_adjust_prop.PNG">

### region_hvytrk_powertrain_prop.csv {#vestate-region_hvytrk_powertrain_prop.csv}

This input file is OPTIONAL. It is only needed if the user wants to modify the powertrain proportion of heavy duty trucks.

   * **HvyTrkPropIcev**: Proportion of heavy truck travel powered by internal combustion engine powertrains
   * **HvyTrkPropHev**: Proportion of heavy truck travel powered by hybrid electric powertrains
   * **HvyTrkPropBev**: Proportion of heavy truck travel powered by battery electric powertrains
		

Here is a snapshot of the file:	

<img align="center" width="400" border=1 src="images/region_hvytrk_powertrain_prop.PNG">

### region_prop_externalities_paid.csv {#vestate-region_prop_externalities_paid.csv}

This file supplies data for climate change and other social costs.

   * **PropClimateCostPaid**: Proportion of climate change costs paid by users (i.e. ratio of carbon taxes to climate change costs
   * **PropOtherExtCostPaid**: Proportion of other social costs paid by users

Here is a snapshot of the file:	

<img align="center" width="400" border=1 src="images/region_prop_externalities_paid.PNG">

### region_road_cost.csv {#vestate-region_road_cost.csv}

This file supplies data for different types of road costs

* **RoadBaseModCost**: Average base modernization cost per light-duty vehicle mile traveled (dollars per vehicle mile). Base modernization includes roadway improvements exclusive of addition of lanes.
* **RoadPresOpMaintCost**: Average road preservation, operations, and maintenance cost per light-duty vehicle mile traveled (dollars per vehicle mile).
* **RoadOtherCost**: Average other road cost (e.g. administration, planning, project development, safety) per light-duty vehicle mile traveled (dollars per vehicle mile).
* **FwyLnMiCost**: Average cost to build one freeway lane-mile (dollars per lane-mile)
* **ArtLnMiCost**: Average cost to build one arterial lane-mile (dollars per lane-mile)
* **HvyTrkPCE**: Passenger car equivalent (PCE) for heavy trucks. PCE indicates the number of light-duty vehicles a heavy truck is equivalent to in calculating road capacity.


Here is a snapshot of the file:	

| Year | RoadBaseModCost.2005 | RoadPresOpMaintCost.2005 | RoadOtherCost.2005 | FwyLnMiCost.2005.1e3 | ArtLnMiCost.2005.1e3 | HvyTrkPCE |
| ---- | -------------------- | ------------------------ | ------------------ | -------------------- | -------------------- | --------- |
| 2010 | 0.004                | 0.01                     | 0.015              | 4900                 | 1800                 | 3         |
| 2040 | 0.004                | 0.01                     | 0.015              | 4900                 | 1800                 | 3         |

