## VE-State Tutorial {#vestate}

## Overview 

### VE-State Vs. VE-RSPM

The main difference between VE-RSPM models and VE-State models is that a number of VE-RSPM inputs are specified at the Bzone level. The Bzones are sub-regional geographies, typically census tracts or block groups. Diagrams are available on the VisionEval wiki for a visual explanation of the [VE-RSPM](https://github.com/VisionEval/VisionEval/wiki/VERSPM-Training/VE-RSPM_Inputs_by_Geo.pdf) and [VE-State](https://github.com/VisionEval/VisionEval/wiki/VERSPM-Training/VE-State_Inputs_by_Geo.pdf) geographies. 
Also, note that 'Azones' are typically counties, and 'Mareas' are metropolitan areas, typically defined by the boundaries of an MPO.

The following diagrams show how these two model differ at the early stages.
VE-State uses simulation methods to generate land use and housing input in Bzone level.

#### VE-RSPM Structure

<img align="center" width="600" border=1 src="images/VE-RSPM.png">

#### VE-State Structure

<img align="center" width="600" border=1 src="images/VE-State.png">

Bzone level attributes are required by a number of modules so methods need to be developed for synthesizing a representative set of Bzones and their characteristics from policies and attributes specified at the Azone and Marea levels. Something like this is done in the GreenSTEP model where a likely distribution of neighborhood population density is synthesized from the overall metropolitan area density. Azone level inputs are provided for base year population and area by development type (metropolitan, town, rural), population growth by development type, and the ratio of urban area growth to population growth. From these inputs, average density is calculated by Azone and development type and a model is applied to synthesize a distribution of neighborhood densities from the average density. 
All of the VE-RSPM modules which assign Bzone characteristics are contained in the `VELandUse` package. The modules that are developed to synthesize Bzones and their characteristics will be placed in a `VESimLandUse` package. When a VE-State model is run, the modules in the `VESimLandUse` package will be run instead of the modules in the `VELandUse` package. Otherwise the model setup is nearly the same for VE-State and VE-RSPM. The use of the `VESimLandUse` modules is not be limited to statewide applications however. Users could simulate Bzones in an VE-RSPM-type application that would enable metropolitan area planners to more easily define and model alternative land use scenarios as is done in VE-RPAT (Rapid Policy Analysis Tool) applications.


## Required Bzone Attributes 

Land use modeling in VE-RSPM is the basis for the land use modeling in VE-State. These modules were designed to produce datasets needed to run the new multi-modal travel model. The multi-modal module requires several activity density, diversity (i.e., activity mixing), and destination accessibility measures that in turn require households and employment to be located at the Bzone level to calculate those measures. In addition, a few multi-modal network and service level measures need to be calculated. Second, locating jobs at the Bzone level allows for the travel demand management (TDM) and parking pricing modules to establish more realistic relationships between policies and the households they would affect. This also allows household workers to be assigned to job sites and that information can be used to translate job site TDM and parking policies back to households. Finally, simulated households are assigned to Bzones. In VE-RSPM a number of single family and multifamily dwelling units are assigned to Bzones as inputs along with the relative income distribution of households in each Bzone. VE-RSPM models the housing choice of each household based on the overall supply of housing of each type in the Azone and the household characteristics. Then the model assigns each household to a Bzone based on the household’s housing choice and income, and on the relative supplies of housing of the type and household income distribution in the Bzone. The Bzone attributes that need to be synthesized are: 

-  Destination accessibility (i.e., accessibility to jobs and housing) measured consistent as it is used in the multi-modal travel model – This information is one of the 5D measured used in the VE-RSPM multi-modal travel model. Since synthetic zones won’t have physical locations, it can’t be calculated simply from households and employment by zone.
-  Number of households proportional split of dwelling units between single family and multifamily – Number of households and dwelling unit split by Bzone is needed in order to assign households to Bzones. 
-  Number of jobs by sector (retail, service, other) is used in calculating several diversity measures used in the RSPM multi-modal travel model. The number of jobs is also used to associate household workers with workplace Bzones
-  Area type and development type – Some practical system of zonal development classification is needed for organizing policy inputs. Policies such as travel demand management policies will be specified by Azone and area type and/or development type. These designations will also be used in the calculation of the design and distance to transit ‘5D’ measure categories that are used in the VE-RSPM multi-modal travel model.

## Approach for Synthesizing Bzones and their Attributes 

1. The user provides inputs on:  
-  Azone proportional split of dwelling units by location type (metropolitan, town and rural) 
-  Azone proportional split of workers by job site location types (for example, proportions of rural residents in the Azone who work in rural locations, town locations, or the metropolitan area) 
-  Marea proportional split of Marea employment among Azones


2. Total activity – numbers of households and jobs – will determine the number of SimBzones in the Azone. SimBzones will have equal amounts of activity and unequal areas since activity density will vary among SimBzones. An appropriate average SimBzone activity value will be determined through evaluation of the [EPA Smart Location Database (SLD)](https://www.epa.gov/smartgrowth/smart-location-mapping#SLD).

3. Models will be applied to select a destination accessibility value for each Bzone. For metropolitan type development, the model will create a distribution of destination accessibility values that is consistent with the overall activity density in the metropolitan area. Random sampling from the distribution will be used to assign destination accessibility values to metropolitan SimBzones. Models will also be developed for town and rural types, but more investigation is needed in order to determine their form. 

4. Activity density of each SimBzones will be determined as a function of the destination accessibility of each zone (because destination accessibility is a measure of activity density at a larger geographic scale). A model will be estimated from the SLD which creates a distribution of zone densities as a function of destination accessibility. An adjustment process, such as an iterative proportional fitting process (IPF), will be used to adjust densities and destination accessibilities so that the overall activity density of all the zones in a metropolitan area is equal to the input value

5. Further subdivision of the metropolitan area into area types will be done as a function of the destination accessibility and activity density of each zone. Four such area types are proposed: urban core, close in community, and suburban/town, low density/rural. The final typology and the relationship of area types to destination accessibility and activity density will be developed through examination of the SLD dataset. It is envisioned that area types will be defined as fuzzy sets rather than crisp sets.  Although some SimBzones may be wholly one type, many SimBzones will have degrees of membership in several types. Using fuzzy sets is a more realistic recognition of the nature of area types and avoids aberrations resulting from threshold effects. 

6. The total activity in each SimBzone is split into households and jobs using a model which relates zonal mixing to destination accessibility, activity density, and area type. This model will be specified and estimated based on investigations using the SLD data. It is anticipated that the model will produce distributions of activity splits from which values will be drawn. IPF or some other adjustment process will be used to adjust values so that the aggregation of the splits for all the SimBzones in an Azone is consistent with the Azone inputs. This model will also need to specify the split of land area between households and jobs. 

7. Once the number of households is determined for each SimBzone, the split of dwelling units by housing type (single family, multifamily) as a function of activity density. The SLD and census data will be used to develop this model. IPF is be used to fit the distribution of SimBzone values to Azone level control totals. This will allow users to specify Azone ratios as policy inputs. 

8. A variant of the VE-RSPM housing model is applied to assign households to housing types and to Bzones. One thing to be worked out is whether the allocation to SimBzones considers household income or not. In VE-RSPM, relative Bzone income distributions are input and these are used in the process of allocating households to Bzones. This enables VE-State users to model general relationships of income to parts of the metropolitan area (e.g., the effect of gentrification in the urban core). 

9. Jobs in each SimBzone will be split into numbers of retail, service, and other jobs. The approach for doing this is yet to be determined. SimBzone splits will be constrained so that they total to Azone splits that are inputs. The model will probably be a function of the destination accessibility, employment density, and mixing of households and employment in the SimBzone. The SLD data will be used to develop and estimate this model. Thought will be given as to whether there should be control totals on the mix for a metropolitan area.  If so, IPF or some other adjustment process would need to be used to match the totals. 

10. Workers will be assigned to SimBzone job sites. How this is done is yet to be determined. It is proposed that an agile development approach be used where the first iteration of the model will be a random assignment of workers to job sites. Other extensions that could be considered if there is time/budget investigation could be done using LEHD data and SLD data to look for relationships between worker residence by area type and worker job site by area type. Relative income could also be considered.

11. Once numbers of households and numbers of jobs by type are assigned to SimBzones, all the remaining density and diversity measures can be calculated. 

12. The distance to transit measure is modeled for metropolitan SimBzones as a function of the metropolitan-level transit supply measure and the SimBzone attributes for destination 

13. Development type (e.g., residential, employment, mixed, transit-oriented development, greenfield), are assigned to SimBzones based on the density, diversity, and distance to transit measures. These development types, like the area types may be fuzzy sets. The SLD is used to create the development type specifications. The design will enable model users to input Marea goals for the proportional split of development types. The model will adjust the allocation of development types consistent with the goals but constrained to plausible levels. 

14. Network design measures used by the VE-RSPM multi-modal travel model (e.g., multi-modal network density, pedestrian network density) will be applied based on inputs related to area and development type. The SLD will be used to identify ranges of values by area and development type. Users will specify in inputs goals relative to these ranges by Azone, development type and area type.

15.  The parking pricing, travel demand management, and car service inputs is specified by Azone, area type, and development type. These will then be translated to the SimBzone based on the SimBzone area type and development type. After that is done, the `AssignDemandManagement`, `AssignParkingRestrictions`, and `AssignCarSvcAvailability` modules can run as they currently do. Thought will be given as to how to simplify inputs so that users are not required to provide inputs for every combination of Azone, area type and development type.

## Inputs and Parameters

VE-State data inputs are classified into two categories: Inputs and Model Parameters. It includes five definition files and dozens of input files, some of which the user must change and others which typically remain unchanged. This page provides guidance of these files to the end user and which files must be updated to implement VE-State.


### Model Definition Files

The following five files need to be configured in the "defs" directory:

- [run_parameters.json](#run_parametersjson)
- [model_parameters.json](#model_parametersjson)
- [deflators.csv](#deflatorscsv)
- [geo.csv](#geocsv)
- [units.csv](#unitscsv)

#### run_parameters.json

This file contains parameters that define key attributes of the model run and relationships to other model runs. A more detailed description of the file can be found [here](https://github.com/Visioneval/VisionEval/blob/master/api/model_system_design.md#61-model-directory-structure). The results of model run are stored in a directory with the name specified by ```"DatastoreName"```. This name should be changed when running different scenarios. For e.g. when running base scenario the output directory name can be set to *BaseScenario* by using ```"DatastoreName": "BaseScenario"``` in the file. The format of this file is as follows:

```json
{
    "Model": "VE-State",
    "Scenario": "Test",
    "Description": "Test of VE-State",
    "Region": "Oregon",
    "BaseYear": "2010",
    "Years": ["2010", "2038"],
    "DatastoreName": "Datastore",
    "DatastoreType": "RD",
    "Seed": 1 , 
	"RequiredVEPackages": [
		"VESimHouseholds",
		"VESimLandUseData",
		"VESimLandUse",
		"VESimTransportSupply",
		"VEHouseholdVehicles",
		"VEHouseholdTravel",
		"VEPowertrainsAndFuels",
		"VETravelPerformance"
  ]
}
```

[Top](#rspm-inputs-and-parameters)
___

#### model_parameters.json

This file contains global parameters for a particular model configuration that may be used by multiple modules. A more detailed description of the file and its structure can be found [here](https://github.com/Visioneval/VisionEval/blob/master/api/model_system_design.md#61-model-directory-structure). The source of the default $16/hr is per an ODOT Report, "The Value of Travel-Time: Estimates of the Hourly Value of Time for Vehicles in Oregon 2015". The [2017 version is here](https://www.oregon.gov/ODOT/Data/Documents/2017-The-Value-of-Travel-Time.pdf).

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

[Top](#rspm-inputs-and-parameters)
___

#### deflators.csv

This file defines the annual deflator values, such as the consumer price index, that are used to convert currency values between different years for currency denomination. This file does not need to be modified unless the years for which the dollar values used in the input dataset is not contained in this file. The format of the file is as follows:

|              Year          |             Value          |
|----------------------------|----------------------------|
|              1999          |             172.6          |
|              2000          |             178.0          |
|              2001          |             182.4          |
|              ...           |             ...            |
|              2010          |             218.344        |
|              ...           |             ...            |
|              2016          |             249.426        |

[Top](#rspm-inputs-and-parameters)
___

#### geo.csv

This file describes all of the geographic relationships for the model and the names of geographic entities in a CSV formatted text file. [**Azone**](https://github.com/Visioneval/VisionEval/blob/master/api/model_system_design.md#62-model-geography), [**Bzone**](https://github.com/Visioneval/VisionEval/blob/master/api/model_system_design.md#62-model-geography), and [**Marea**](https://github.com/Visioneval/VisionEval/blob/master/api/model_system_design.md#62-model-geography) should remain consistent with the input data. The format of the file is as follows:

| Azone       | Bzone          | Czone      | Marea      |
| ----------- | -------------- | ---------- | ---------- |
| Baker       | NA  | NA         | None     |
| Benton    | NA  | NA         | Corvallis      |
| Clackamas      | NA  | NA         | Portland      |
| Clatsop    | NA  | NA         | None      |
| Columbia   | NA  | NA         | Portland      |
| Coos  | NA  | NA         | None      |
| Crook       | NA  | NA         | None      |
| Curry      | NA  | NA         | None      |
| Deschutes      | NA  | NA         | Bend      |
| Douglas       | NA  | NA         | None      |
| Gilliam       | NA  | NA         | None      |
| Grant       | NA  | NA         | None      |
| Harney      | NA            | NA         | None      |

To learn more about VE-State model geographic relationships see [here](docs/VisionEval_Inputs_by_Geo.docx)

[Top](#rspm-inputs-and-parameters)
___

### units.csv

This file describes the default units to be used for storing complex data types in the model. This file should NOT be modified by the user. The format of the file is as follows:

| Type                 | Units            |
| -------------------- | ---------------- |
| currency             | USD              |
| distance             | MI               |
| area                 | SQMI             |
| mass                 | KG               |
| volume               | GAL              |
| time                 | DAY              |
| energy               | GGE              |
| people               | PRSN             |
| trips                | VEH              |
| area                 | TRIP             |
| households           | HH               |
| employment           | JOB              |
| activity             | HHJOB            |

The VisionEval model system keeps track of the types and units of measure of all data that is processed. More details about the file and structure can be found [here](https://github.com/Visioneval/VisionEval/blob/master/api/model_system_design.md#63-data-types-units-and-currency-deflators).

[Top](#rspm-inputs-and-parameters)
___


### Input Files

- **azone_carsvc_characteristics.csv** This file specifies the different characteristics for high and low car service level and is used in the [CreateVehicleTable](Modules_and_Outputs.md/#createvehicletable) and [AssignVehicleAge](Modules_and_Outputs.md/#assignvehicleage) modules. 
- **azone_charging_availability.csv** This file has data on proportion of different household types who has EV charging available  and is used in the [AssignHHVehiclePowertrain](Modules_and_Outputs.md/#assignhhvehiclepowertrain) module.          
- **azone_electricity_carbon_intensity.csv** This file is used to specify the carbon intensity of electricity and is optional (only needed if user wants to modify the values). The file is used in [Initialize (VEPowertrainsAndFuels)](Modules_and_Outputs.md/#initialize-vepowertrainsandfuels
) and [CalculateCarbonIntensity](Modules_and_Outputs.md/#calculatecarbonintensity) modules.      
- **azone_fuel_power_cost.csv** This file supplies data for retail cost of fuel and electricity and is used in the [CalculateVehicleOperatingCost](Modules_and_Outputs.md/#calculatevehicleoperatingcost) module.                 
- **azone_gq_pop_by_age.csv** This file contains group quarters population estimates/forecasts by age and is used in the [CreateHouseholds](Modules_and_Outputs.md/#createhouseholds) module.                    
- **azone_gq_pop-prop_by_area-type.csv** This file provides the proportions for groupquarters in different area types and is used in the [Initialize](Modules_and_Outputs.md/#initialize) module.                    
- **azone_hh_loc_type_prop.csv** This file provides the proportions for households residing in the metropolitan, towns and rural part of the Azone and is used in the [Initialize](Modules_and_Outputs.md/#initialize) module.                    

- **azone_hh_pop_by_age.csv** This file contains population estimates/forecasts by age and is used in the [CreateHouseholds](Modules_and_Outputs.md/#createhouseholds) module.                  

- **azone_hh_veh_mean_age.csv** This file provides inputs for mean auto age and mean light truck age and is used in the [AssignVehicleAge](Modules_and_Outputs.md/#assignvehicleage) module.                 
- **azone_hh_veh_own_taxes.csv** This file provides inputs for flat fees/taxes (i.e. annual cost per vehicle) and ad valorem taxes (i.e. percentage of vehicle value paid in taxes). The file is used in [CalculateVehicleOwnCost](Modules_and_Outputs.md/#calculatevehicleowncost) module.                 
- **azone_hhsize_targets.csv** This file contains the household specific targets and is used in [CreateHouseholds](Modules_and_Outputs.md/#createhouseholds) module.                   
- **azone_loc_type_land_area.csv** This file provides land area data for different area types and is used in [Initialize](Modules_and_Outputs.md/#initialize) module.                  
- **azone_lttrk_prop.csv** This file specifies the light truck proportion of the vehicle fleet and is used in [AssignVehicleType](Modules_and_Outputs.md/#assignvehicletype) module. 
- **azone_payd_insurance_prop.csv** This file provides inputs on the proportion of households having PAYD (pay-as-you-drive) insurance and is used in the [CalculateVehicleOwnCost](Modules_and_Outputs.md/#calculatevehicleowncost) module.               
- **azone_per_cap_inc.csv** This file contains information on regional average per capita household and group quarters income in year 2010 dollars and is used in the [PredictIncome](Modules_and_Outputs.md/#predictincome) module.                 
- **azone_prop_sov_dvmt_diverted.csv** This file provides inputs for a goal for diverting a portion of SOV travel within a 20-mile tour distance and is used in the [DivertSovTravel](Modules_and_Outputs.md/#divertsovtravel) module.            
- **azone_relative_employment.csv** This file contains ratio of workers to persons by age and is used in the [PredictWorkers](Modules_and_Outputs.md/#predictworkers) module. 
- **azone_veh_use_taxes.csv** This file supplies data for vehicle related taxes and is used in the [CalculateVehicleOperatingCost](Modules_and_Outputs.md/#calculatevehicleoperatingcosts) module.         
- **azone_vehicle_access_times.csv** This file supplies data for vehicle access and egress time and is used in the [CalculateVehicleOperatingCost](Modules_and_Outputs.md/#calculatevehicleoperatingcost) module.              
- **azone_wkr_loc_type_prop** This file provides the proportions for workers residing in Azone who works in the metropolitan, towns and rural part of the Azone and is used in [Initialize](Modules_and_Outputs.md/#initialize) module.              
- **marea_base_year_dvmt.csv** This file is used to specify to adjust the dvmt growth factors and is optional (only needed if user wants to modify the values). The file is used in the [Initialize (VETravelPerformance)](Modules_and_Outputs.md/#initialize-vetravelperformance), [CalculateBaseRoadDvmt](Modules_and_Outputs.md/#calculatebaseroaddvmt) and [CalculateFutureRoadDvmt](Modules_and_Outputs.md/#calculatefutureroaddvmt) modules.
- **marea_carsvc_availability.csv** This file has the data for activity proportions which are served by car services and is used in the [Initialize (AssignCarSvcAvailability)](Modules_and_Outputs.md/#assigncarsvcavailability)
- **marea_congestion_charges.csv** This file is used to specify the charges of vehicle travel for different congestion levels and is optional. The file is used in the [Initialize (VETravelPerformance)](Modules_and_Outputs.md/#initialize-vetravelperformance) and [CalculateRoadPerformance](Modules_and_Outputs.md/#calculateroadperformance) modules.               
- **marea_dvmt_split_by_road_class.csv** This file is used to specify the dvmt split for different road classes and is optional. The file is used in the [Initialize (VETravelPerformance)](Modules_and_Outputs.md/#initialize-vetravelperformance) and [CalculateBaseRoadDvmt](Modules_and_Outputs.md/#calculatebaseroaddvmt) modules.         
- **marea_d3bpo4_adj.csv** This file provides the D3bpo4 value for urban, town and rural areas from the EPA 2010 Smart Location Database and is used in the [Simulate4DMeasures](Modules_and_Outputs.md/#simulate4dmeasures) 
- **marea_lane_miles.csv** This file contains inputs on the numbers of freeway lane-miles and arterial lane-miles and is used in the [AssignRoadMiles](Modules_and_Outputs.md/#assignroadmiles) module.                   
- **marea_mix_targets.csv** This file represents Marea target for proportion of households located in mixed-use neighborhoods (or NA if no target) and is used in the [SimulateUrbanMixMeasure](Modules_and_Outputs.md/#simulateurbanmixmeasure) module.                   
- **marea_operations_deployment.csv** This file is used to specify the proportion of dvmt affected by operations for different road classes and is optional. The file is used in the [Initialize (VETravelPerformance)](Modules_and_Outputs.md/#initialize-vetravelperformance) and [CalculateRoadPerformance](Modules_and_Outputs.md/#calculateroadperformance) modules.        
- **marea_parking-avail_by_area-type.csv** This file has the data for average number of parking spots available to households and is used in the [AssignParkingRestrictions](Modules_and_Outputs.md/#assignparkingrestrictions)   
- **marea_parking-cost_by_area-type.csv** This file has the data related to parking costs and population proportions paying the parking costs and is used in the [AssignParkingRestrictions](Modules_and_Outputs.md/#assignparkingrestrictions) 


- **marea_speed_smooth_ecodrive.csv** This input file supplies information of deployment of speed smoothing and ecodriving by road class and vehicle type and is used in the [CalculateMpgMpkwhAdjustments](Modules_and_Outputs.md/#calculatempgmpkwhadjustments) module.          
- **marea_transit_ave_fuel_carbon_intensity.csv** This file is used to specify the average carbon intensity of fuel used by transit and is optional. The file is used in the [Initialize (VETravelPerformance)](Modules_and_Outputs.md/#initialize-vetravelperformance) module. 
- **marea_transit_biofuel_mix.csv** This file is used to specify the biofuel used by transit and is optional. The file is used in the [Initialize (VETravelPerformance)](Modules_and_Outputs.md/#initialize-vetravelperformance) and [CalculateCarbonIntensity](Modules_and_Outputs.md/#calculatecarbonintensity) modules.             
- **marea_transit_fuel.csv** This file is used to specify the transit fuel proportions and is optional. The file is used in the [Initialize (VETravelPerformance)](Modules_and_Outputs.md/#initialize-vetravelperformance) and [CalculateCarbonIntensity](Modules_and_Outputs.md/#calculatecarbonintensity) modules.                      
- **marea_transit_powertrain_prop.csv** This file is used to specify the mixes of transit vehicle powertrains and is optional. The file is used in the [Initialize (VETravelPerformance)](Modules_and_Outputs.md/#initialize-vetravelperformance) and [CalculatePtranEnergyAndEmissions](Modules_and_Outputs.md/#calculateptranenergyandemissions) modules.     
- **marea_transit_service.csv** This file contains annual revenue-miles for different transit modes for metropolitan area and is used in the [AssignTransitService](Modules_and_Outputs.md/#assigntransitservice) module.                   
- **marea_travel-demand-mgt_by_area-type.csv** This file has the data for proportions participating in demand management programs and is used in the [AssignDemandManagement](Modules_and_Outputs.md/#assigndemandmanagement) module.                   
- **marea_uza_profile_names.csv** his file provides the name of a specific urbanized area for the urbanized area profile to use in SimBzone creation and is used in the [Initialize](Modules_and_Outputs.md/#initialize) module.

- **other_ops_effectiveness.csv** This file is used to specify the delay effects of operations in different road classes and is optional (only needed if user wants to modify the values). The file is used in the [Initialize (VETravelPerformance)](Modules_and_Outputs.md/#initialize-vetravelperformance) and [CalculateRoadPerformance](Modules_and_Outputs.md/#calculateroadperformance) modules. 
- **region_ave_fuel_carbon_intensity.csv** This file is used to specify the average carbon density for different vehicle types and is optional (only needed if user wants to modify the values). The file is used in the [Initialize (VETravelPerformance)](Modules_and_Outputs.md/#initialize-vetravelperformance) and [CalculateCarbonIntensity](Modules_and_Outputs.md/#calculatecarbonintensity) modules.       
- **region_base_year_hvytrk_dvmt.csv** This file is used to specify the heavy truck dvmt for base year and is optional. The file is used in the [Initialize (VETravelPerformance)](Modules_and_Outputs.md/#initialize-vetravelperformance), [CalculateBaseRoadDvmt](Modules_and_Outputs.md/#calculatebaseroaddvmt) and [CalculateFutureRoadDvmt](Modules_and_Outputs.md/#calculatefutureroaddvmt)  modules.            
- **region_carsvc_powertrain_prop.csv** This file is used to specify the powertrain proportion of car services and is optional. The file is used in the [Initialize (VETravelPerformance)](Modules_and_Outputs.md/#initialize-vetravelperformance), [AssignHhVehiclePowertrain](Modules_and_Outputs.md/#assignhhvehiclepowertrain) and [AdjustHhVehicleMpgMpkwh](Modules_and_Outputs.md/#adjusthhvehiclempgmpkwh) modules.                      
- **region_comsvc_lttrk_prop.csv** This file supplies data for the light truck proportion of commercial vehicles and is used in the [CalculateComEnergyAndEmissions](Modules_and_Outputs.md/#calculatecomenergyandemissions) module.              
- **region_comsvc_powertrain_prop.csv** This file is used to specify the powertrain proportion of commercial vehicles and is optional. The file is used in the [Initialize (VEPowertrainsAndFuels)](Modules_and_Outputs.md/#initialize-vepowertrainsandfuels
) and [CalculateComEnergyAndEmissions](Modules_and_Outputs.md/#calculatecomenergyandemissions) modules.        
- **region_comsvc_veh_mean_age.csv** This input file contains average age of commercial service vehicles and is used in the [CalculateComEnergyAndEmissions](Modules_and_Outputs.md/#calculatecomenergyandemissions) module.              


- **region_hh_driver_adjust_prop.csv** This file specifies the relative driver licensing rate relative to the model estimation data year and is used in the [AssignDrivers](Modules_and_Outputs.md/#assigndrivers) module. 
- **region_hvytrk_powertrain_prop.csv** This file is used to specify the powertrain proportion of heavy duty trucks and is optional. The file is used in the [Initialize (VEPowertrainsAndFuels)](Modules_and_Outputs.md/#initialize-vepowertrainsandfuels
) and [CalculateComEnergyAndEmissions](Modules_and_Outputs.md/#calculatecomenergyandemissions) modules.
- **region_prop_externalities_paid.csv** This file supplies data for climate change and other social costs and is used in the [CalculateVehicleOperatingCost](Modules_and_Outputs.md/#calculatevehicleoperatingcost) module. 
- **region_road_cost.csv** This file supplies data for different types of road costs and is used in the [BalanceRoadCostsAndRevenues](Modules_and_Outputs.md/#balanceroadcostsandrevenues) module. 

[Top](#rspm-inputs-and-parameters)
___

Return to [Tutorial](Main.md). 

## Modules and Outputs
----

The VE-State model is a compilation of several modules, listed below:

|      MODULE                                                          |     PACKAGE           |
|----------------------------------------------------------------------|-----------------------|
|[CreateHouseholds](#createhouseholds)                                 |VESimHouseholds        |
|[PredictWorkers](#predictworkers)                                     |VESimHouseholds        |
|[AssignLifeCycle](#assignlifecycle)                                   |VESimHouseholds        |
|[PredictIncome](#predictincome)                                       |VESimHouseholds        |
|[Initialize](#initialize)                                     		   |VESimLandUse           |
|[CreateSimBzones](#createsimbzones)                                     |VESimLandUse           |
|[SimulateHousing](#simulatehousing)                                   |VESimLandUse           |
|[SimulateEmployment](#simulateemployment)                             |VESimLandUse           |
|[Simulate4DMeasures](#simulate4dmeasures)                             |VESimLandUse           |
|[SimulateUrbanMixMeasure](#simulateurbanmixmeasure)                   |VESimLandUse           |
|[AssignParkingRestrictions](#assignparkingrestrictions)               |VESimLandUse           |
|[AssignDemandManagement](#assigndemandmanagement)                     |VESimLandUse           |
|[AssignCarSvcAvailability](#assigncarsvcavailability)                 |VESimLandUse           |
|[SimulateTransitService](#simulatetransitservice)                     |VESimTransportSupply   |
|[SimulateRoadMiles](#simulateroadmiles)                               |VESimTransportSupply   |
|[AssignDrivers](#assigndrivers)                                       |VEHouseholdVehicles    |
|[AssignVehicleOwnership](#assignvehicleownership)                     |VEHouseholdVehicles    |
|[AssignVehicleType](#assignvehicletype)                               |VEHouseholdVehicles    |
|[CreateVehicleTable](#createvehicletable)                             |VEHouseholdVehicles    |
|[AssignVehicleAge](#assignvehicleage)                                 |VEHouseholdVehicles    |
|[CalculateVehicleOwnCost](#calculatevehicleowncost)                   |VEHouseholdVehicles    |
|[AdjustVehicleOwnership](#adjustvehicleownership)                     |VEHouseholdVehicles    |
|[CalculateHouseholdDvmt](#calculatehouseholddvmt)                     |VEHouseholdTravel      |
|[CalculateAltModeTrips](#calculatealtmodetrips)                       |VEHouseholdTravel      |
|[CalculateVehicleTrips](#calculatevehicletrips)                       |VEHouseholdTravel      |
|[DivertSovTravel](#divertsovtravel)                                   |VEHouseholdTravel      |
|[Initialize](#initialize-vepowertrainsandfuels)                       |VEPowertrainsAndFuels  |
|[CalculateCarbonIntensity](#calculatecarbonintensity)                 |VEPowertrainsAndFuels  |
|[AssignHhVehiclePowertrain](#assignhhvehiclepowertrain)               |VEPowertrainsAndFuels  |
|[Initialize](#initialize-vetravelperformance)                         |VETravelPerformance    |
|[CalculateBaseRoadDvmt](#calculatebaseroaddvmt)                       |VETravelPerformance    |
|[CalculateFutureRoadDvmt](#calculatefutureroaddvmt)                   |VETravelPerformance    |
|[CalculateRoadPerformance](#calculateroadperformance)                 |VETravelPerformance    |
|[CalculateMpgMpkwhAdjustments](#calculatempgmpkwhadjustments)         |VETravelPerformance    |
|[AdjustHhVehicleMpgMpkwh](#adjusthhvehiclempgmpkwh)                   |VETravelPerformance    |
|[CalculateVehicleOperatingCost](#calculatevehicleoperatingcost)       |VETravelPerformance    |
|[BudgetHouseholdDvmt](#budgethouseholddvmt)                           |VETravelPerformance    |
|[BalanceRoadCostsAndRevenues](#balanceroadcostsandrevenues)           |VETravelPerformance    |
|[CalculateComEnergyAndEmissions](#calculatecomenergyandemissions)     |VETravelPerformance    |
|[CalculatePtranEnergyAndEmission](#calculateptranenergyandemissions)  |VETravelPerformance    | 
___

Each of these modules use different input data. Generally speaking, the VE-State inputs are classified into the five following categories:

1. **User input model parameters**: These are input parameters (model or scenario specific), defined in [model_parameters.json](#model_parametersjson), that users should review and modify as needed.
2. **Fixed input model parameters**: These are input parameters specific to the model, defined in [model_parameters.json](#model_parametersjson), that users should not typically modify.
3. **User input files**: These are input files (model or scenario specific) that users should review and modify as needed.
4. **Fixed input files**: These are input parameters specific to the model that are fixed.
5. **Internal module inputs**: These are inputs created by other VE-RSPM modules.

The following section decribes each module, its required inputs, and its generated outputs.

### CreateHouseholds
This module creates simulated households using inputs of population by age group by simulation year. 

#### User Input Files
1. Household population (**_azone_hh_pop_by_age.csv_**): This file contains population estimates/forecasts by age for each of the base and future years. The file format includes number of persons within six age groups:
   * 0-14
   * 15-19
   * 20-29
   * 30-54
   * 55-64
   * 65 Plus

   Here is a snapshot of the file:
   <img align="center" width="800" border=1 src="images/azone_hh_pop_by_age.PNG">


2. Household size (**_azone_hhsize_targets.csv_**): This file contains the household-specific targets for the population synthesizer. This file contains two attributes: 
   * **AveHhSize**: Average household size for non-group quarters households
   * **Prop1PerHh**: Proportion of non-group quarters households having only one person

   Here is a snapshot of the file:
   <img align="center" width="400" border=1 src="images/azone_hhsize_targets.PNG">

3. Group quarter population (**_azone_gq_pop_by_age.csv_**):  This file contains group quarters population estimates/forecasts by age for each of the base and future years. The file format includes number of persons within the following six age categories:
   * 0-14
   * 15-19
   * 20-29
   * 30-54
   * 55-64
   * 65 Plus

   Here is a snapshot of the file:
   <img align="center" width="800" border=1 src="images/azone_gq_pop_by_age.PNG">
   
   
#### Module Outputs
Households are created with the number of persons in each of six age categories (0-14, 15-19, 20-29, 30-54, 55-64, and 65+) and the total number of persons in the household. Two types of households are created: regular households (i.e. not persons living in group quarters) and group quarters households .

* **HhId**: Unique household ID
* **HhSize**: Number of persons
* **Age0to14**: Persons in 0 to 14 year old age group
* **Age15to19**: Persons in 15 to 19 year old age group
* **Age20to29**: Persons in 20 to 29 year old age group
* **Age30to54**: Persons in 30 to 54 year old age group
* **Age55to64**: Persons in 55 to 64 year old age group
* **Age65Plus**: Persons in 65 or older age group
* **HhType**: Coded household age composition (e.g., `2-1-0-2-0-0`) or `Grp` for group quarters

For more information see [here](https://github.com/VisionEval/VisionEval/blob/master/sources/modules/VESimHouseholds/inst/module_docs/CreateHouseholds.md)

[Top](#rspm-modules-and-outputs)
___


### PredictWorkers
This module assigns workers by age to households and to non-institutional group quarters population. It is a simple model which predicts workers as a function of the household type and age composition. 

#### User Input Files
1. Relative employment (**_azone_relative_employment.csv"_**): This file contains the ratio of workers to persons by age cohort in the model year relative to the model estimation data year. This file contains five age cohorts:
   * **RelEmp15to19**: Ratio of workers to persons age 15 to 19 in model year versus in estimation data year
   * **RelEmp20to29**: Ratio of workers to persons age 20 to 29 in model year versus in estimation data year
   * **RelEmp30to54**: Ratio of workers to persons age 30 to 54 in model year versus in estimation data year
   * **RelEmp55to64**: Ratio of workers to persons age 55 to 64 in model year versus in estimation data year
   * **RelEmp65Plus**: Ratio of workers to persons age 65 or older in model year versus in estimation data year

   Here is a snapshot of the file:
   <img align="center" width="800" border=1 src="images/azone_relative_employment.PNG">

#### Internal Module Inputs
|    Package         |      Module                           |   Outputs    | Description                               |
|--------------------|---------------------------------------|--------------|-------------------------------------------|
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**Age0to14**  | Persons in 0 to 14 year old age group     |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**Age15to19** | Persons in 15 to 19 year old age group    |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**Age20to29** | Persons in 20 to 29 year old age group    |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**Age30to54** | Persons in 30 to 54 year old age group    |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**Age55to64** | Persons in 55 to 64 year old age group    |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**Age65Plus** | Persons in 65 or older age group          |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**HHType**    | Coded household age composition           |

#### Module Outputs
* **Wkr15to19**: Workers in 15 to 19 year old age group
* **Wkr20to29**: Workers in 20 to 29 year old age group
* **Wkr30to54**: Workers in 30 to 54 year old age group
* **Wkr55to64**: Workers in 55 to 64 year old age group
* **Wkr65Plus**: Workers in 65 or older age group
* **Workers**: Total workers
* **NumWkr**: Number of workers residing in the zone

For more information see [here](https://github.com/VisionEval/VisionEval/blob/master/sources/modules/VESimHouseholds/inst/module_docs/PredictWorkers.md)

[Top](#rspm-modules-and-outputs)
___

### AssignLifeCycle
This module assigns a life cycle category to each household. The life cycle categories are similar, but not the same as, those established for the National Household Travel Survey (NHTS). The age categories used in VisionEval models are broader than those used by the NHTS to identify children of different ages. This is a simple model with set of rules that assigns age group categories based on the age of persons and workers in the household.

#### User Input Files
This module has no user input requirements.

#### Internal Module Inputs
|    Package         |      Module                           |   Outputs    | Description                               |
|--------------------|---------------------------------------|--------------|-------------------------------------------|
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**Age0to14**  | Persons in 0 to 14 year old age group     |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**Age15to19** | Persons in 15 to 19 year old age group    |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**Age20to29** | Persons in 20 to 29 year old age group    |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**Age30to54** | Persons in 30 to 54 year old age group    |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**Age55to64** | Persons in 55 to 64 year old age group    |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**Age65Plus** | Persons in 65 or older age group          |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**HHType**    | Coded household age composition           |
| VESimHouseholds    | [PredictWorkers](#predictworkers)     |**Wrk15to19** | Workers in 15 to 19 year old age group    |
| VESimHouseholds    | [PredictWorkers](#predictworkers)     |**Wrk20to29** | Workers in 20 to 29 year old age group    |
| VESimHouseholds    | [PredictWorkers](#predictworkers)     |**Wrk30to54** | Workers in 30 to 54 year old age group    |
| VESimHouseholds    | [PredictWorkers](#predictworkers)     |**Wrk55to64** | Workers in 55 to 64 year old age group    |
| VESimHouseholds    | [PredictWorkers](#predictworkers)     |**Wrk65Plus** | Workers in 65 or older age group          |

#### Module Outputs
* **LifeCycle**: Household life cycle as defined by 2009 NHTS `LIF_CYC` variable

For more information see [here](https://github.com/VisionEval/VisionEval/blob/master/sources/modules/VESimHouseholds/inst/module_docs/AssignLifeCycle.md)

[Top](#rspm-modules-and-outputs)
___

### PredictIncome
This module predicts the income for each simulated household given the number of workers in each age group and the average per capita income for the `Azone` where the household resides.

#### User Input Files
1. Regional income (**_azone_per_cap_inc.csv"_**): This file contains information on regional average per capita household (`HHIncomePC`) and group quarters (`GQIncomePC`) income by forecast year in year 2010 dollars. The data can be obtained from the U.S. Department of Commerce Bureau of Economic Analysis for the current year or from regional or state sources for forecast years. In order to use current year dollars just replace 2010 in column labels with current year. For example, if the data is obtained in year 2015 dollars then the column labels in the file shown below will become `HHIncomePC.2015` and `GQIncomePC.2015`. 

   Here is a snapshot of the file:
<img align="center" width="400" border=1 src="images/azone_per_cap_inc.PNG">

#### Internal Module Inputs
|    Package         |      Module                           |   Outputs    | Description                               |
|--------------------|---------------------------------------|--------------|-------------------------------------------|
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**HHSize**    | Number of persons in the household        |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**Age65Plus** | Persons in 65 or older age group          |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**HHType**    | Coded household age composition           |
| VESimHouseholds    | [PredictWorkers](#predictworkers)     |**Wrk15to19** | Workers in 15 to 19 year old age group    |
| VESimHouseholds    | [PredictWorkers](#predictworkers)     |**Wrk20to29** | Workers in 20 to 29 year old age group    |
| VESimHouseholds    | [PredictWorkers](#predictworkers)     |**Wrk30to54** | Workers in 30 to 54 year old age group    |
| VESimHouseholds    | [PredictWorkers](#predictworkers)     |**Wrk55to64** | Workers in 55 to 64 year old age group    |

#### Module Outputs
* **Income**: Total annual household (non-group and group quarters) income

For more information see [here](https://github.com/VisionEval/VisionEval/blob/master/sources/modules/VESimHouseholds/inst/module_docs/PredictIncome.md)

[Top](#rspm-modules-and-outputs)
___




### Initialize
Modules in the VESimLandUse package synthesize Bzones and their land use attributes as a function of Azone characteristics as well as data derived from the US Environmental Protection Agency's Smart Location Database (SLD) augmented with US Census housing and household income data, and data from the National Transit Database. Details on these data are included in the VESimLandUseData package. The combined dataset contains a number of land use attributes at the US Census block group level. The goal of Bzone synthesis to generate a set of SimBzones in each Azone that reasonably represent block group land use characteristics given the characteristics of the Azone, the Marea that the Azone is a part of, and scenario inputs provided by the user.
Many of the models and procedures used in Bzone synthesis pivot from profiles developed from these data sources for specific urbanized areas, as well as more general profiles for different urbanized area population size categories, towns, and rural areas. Using these specific and general profiles enables the simulated Bzones (SimBzones) to better represent the areas being modeled and the variety of conditions found in different states. Following is a listing of the urbanized areas for which profiles have been developed. Note that urbanized areas that cross state lines are split into the individual state components. This is done to facilitate the development of state models and to better reflect the characteristics of the urbanized area characteristics in each state.
It is incumbent on the model user to identify the name of the urbanized area profile that will be used for each of the Mareas in the model. This module reads in the names assigned in the "marea_uza_profile_names.csv" file and checks their validity. If any are invalid, input processing will stop and error messages will be written to the log identifying the problem names. The following table identifies the names that may be used.

#### User Input Files

1. hh location type proportions (**_marea_uza_profile_names.csv_**): This file provides the name of a specific urbanized area for the urbanized area profile to use in SimBzone creation
   * **UzaProfileName**: Name of a specific urbanized area for the urbanized area profile to use in SimBzone creation or one of the following: small, medium-small, medium, medium-large, large, very-large

   Here is a snapshot of the file:
   <img align="center" width="200" border=1 src="images/uza.PNG">   



2. hh location type proportions (**_azone_hh_loc_type_prop.csv_**): This file provides the proportions for households residing in the metropolitan, towns and rural part of the Azone
   * **PropMetroHh**: Proportion of households residing in the metropolitan (i.e. urbanized) part of the Azone
   * **PropTownHh**: Proportion of households residing in towns (i.e. urban-like but not urbanized) in the Azone
   * **PropRuralHh**: Proportion of households residing in rural (i.e. not urbanized or town) parts of the Azone

   Here is a snapshot of the file:
   <img align="center" width="400" border=1 src="images/hh_loc_type.PNG">   
   
3. work location type proportions (**_azone_wkr_loc_type_prop.csv_**): This file provides the proportions for workers residing in Azone who works in the metropolitan, towns and rural part of the Azone
   * **PropWkrInMetroJobs**: Proportion of workers residing in the Azone who work at jobs in the metropolitan (i.e. urbanized) area associated with the Azone
   * **PropWkrInTownJobs**: Proportion of workers residing in the Azone who work at jobs in towns (i.e. urban-like but not urbanized) in the Azone
   * **PropWkrInRuralJobs**: Proportion of workers residing in the Azone who work at jobs in rural (i.e. not urbanized or town) parts of the Azone
   * **PropMetroJobs**: Proportion of the jobs of the metropolitan area that the Azone is associated with that are located in the metropolitan portion of the Azone
   
   Here is a snapshot of the file:
   <img align="center" width="400" border=1 src="images/wrk_loc_prop.PNG">
   
4. work location type proportions (**_azone_gq_pop-prop_by_area-type.csv_**): This file provides the proportions for groupquarters in different area types.
   * **MetroLandArea**: Land area (excluding large water bodies and large tracts of undevelopable land) in the metropolitan (i.e. urbanized) portion of the Azone
   * **TownLandArea**: Land area (excluding large water bodies and large tracts of undevelopable land) in towns (i.e. urban-like but not urbanized) in the Azone
   * **RuralAveDensity**: Proportion of workers residing in the Azone who work at jobs in the metropolitan (i.e. urbanized) area associated with the Azone

  Here is a snapshot of the file:

 <img align="center" width="400" border=1 src="images/loc_type_land.PNG"> 


5. work location type proportions (**_azone_gq_pop-prop_by_area-type.csv_**): This file provides the average activity density in rural areas 
   * **PropGQPopCenter**: Proportion of Azone non-institutional group quarters population located in center area type
   * **PropGQPopInner**: Proportion of Azone non-institutional group quarters population located in inner area type
   * **PropGQPopOuter**: Proportion of Azone non-institutional group quarters population located in outer area type
   * **PropGQPopFringe**: Proportion of Azone non-institutional group quarters population located in fringe area type



   Here is a snapshot of the file:
<img align="center" width="400" border=1 src="images/gq_prop.PNG">


6. Land area for area types(**_azone_loc_type_land_area.csv_**): This file provides land area data for different area types
   * **MetroLandArea**: Land area (excluding large water bodies and large tracts of undevelopable land) in the metropolitan (i.e. urbanized) portion of the Azone
   * **TownLandArea**: Land area (excluding large water bodies and large tracts of undevelopable land) in towns (i.e. urban-like but not urbanized) in the Azone
   * **RuralAveDensity**: Average activity density (households and jobs per acre) of rural (i.e. not metropolitan or town) portions of the Azone not including large waterbodies or large tracts of agricultural lands, forest lands, or otherwise protected lands



   Here is a snapshot of the file:
<img align="center" width="400" border=1 src="images/land_area.PNG">






For more information see [here](https://github.com/VisionEval/VisionEval-Dev/blob/master/sources/modules/VESimLandUse/inst/module_docs/Initialize.md)
)

[Top](#rspm-modules-and-outputs)
___
### CreateSimBzones
This module synthesizes Bzones and their land use attributes as a function of Azone characteristics as well as data derived from the US Environmental Protection Agency's Smart Location Database (SLD) augmented with US Census housing and household income data, and data from the National Transit Database. Details on these data are included in the `VESimLandUseData` package. The combined dataset contains a number of land use attributes at the US Census block group level. The goal of Bzone synthesis to generate a set of SimBzones in each Azone that reasonably represent block group land use characteristics given the characteristics of the Azone, the Marea that the Azone is a part of, and scenario inputs provided by the user.

Many of the models and procedures used in Bzone synthesis pivot from profiles developed from these data sources for specific urbanized areas, as well as more general profiles for different urbanized area population size categories, towns, and rural areas. Using these specific and general profiles enables the simulated Bzones (SimBzones) to better represent the areas being modeled and the variety of conditions found in different states. The documentation for the `Initialize` module has a listing of urbanized area profile names.

The models and procedures in this module create SimBzones within each Azone that simulate the land use characteristics of neighborhoods likely to be found in the Azone. The SimBzones are assigned quantities of households and jobs and are attributed with several land use measures in the process. The characteristics are:

* **Location Type**: Identification of whether the SimBzone is located in an urbanized area, a town (i.e. an urban-type area that is not large enough to be urbanized), rural (i.e. dispersed low-density development)

* **Households**: Number of households in each SimBzone

* **Employment**: Number of jobs in each SimBzone

* **Activity Density**: Number of households and jobs per acre

* **Land Use Diversity**: Measures of the degree of mixing of households and jobs

* **Destination Accessibility**: Measures of proximity to households and jobs

* **Area Type and Development Type**: Categories which describe the relative urban nature of the SimBzone (area type) and the character of development in the SimBzone (development type).

* **Employment Split**: Number of retail, service, and other jobs in each SimBzone.

#### User Input Files

#### Internal Module Inputs
|    Package         |      Module                           |   Outputs    | Description                               |
|--------------------|---------------------------------------|--------------|-------------------------------------------|
| VESimHouseholds    | [PredictWorkers](#predictworkers)   |**NumWkr**    | see  [PredictWorkers](#predictworkers)         |
| VESimLandUse    | [Initialize](#initialize) |**PropMetroHh** | see  [Initialize](#initialize)        |
| VESimLandUse    | [Initialize](#initialize)      |**PropTownHh**   | see  [Initialize](#initialize)         |
| VESimLandUse    | [Initialize](#initialize)        |**PropRuralHh**    | see  [Initialize](#initialize)      |
| VESimLandUse    | [Initialize](#initialize)   |**PropWkrInMetroJobs**    | see  [Initialize](#initialize)           |
| VESimLandUse    | [Initialize](#initialize)  |**PropWkrInTownJobs** | see  [Initialize](#initialize)          |
| VESimLandUse    | [Initialize](#initialize)     |**PropWkrInRuralJobs**   | see  [Initialize](#initialize)            |
| VESimLandUse    | [Initialize](#initialize)       |**PropMetroJobs**    | see  [Initialize](#initialize)         |
| VESimLandUse    | [Initialize](#initialize)   |**MetroLandArea**    | see  [Initialize](#initialize)           |
| VESimLandUse    | [Initialize](#initialize)  |**TownLandArea** | see  [Initialize](#initialize)         |
| VESimLandUse    | [Initialize](#initialize)      |**RuralAveDensity**   | see  [Initialize](#initialize)            |

#### Module Outputs
* **LocType**: Location type (Urban, Town, Rural) of the place where the household resides
* **NumHh**: Number of households allocated to the SimBzone
* **TotEmp**: Total number of jobs in zone
* **RetEmp**: Number of jobs in retail sector in zone
* **SvcEmp**: Number of jobs in service sector in zone
* **OthEmp**: Number of jobs in other than the retail and service sectors in zone
* **AreaType**: Area type (center, inner, outer, fringe) of the Bzone
* **DevType**: Location type (Urban, Town, Rural) of the Bzone
* **D1D**: Gross activity density (employment + households) on unprotected land in zone (Ref: EPA 2010 Smart Location Database)
* **D5**: Destination accessibility of zone calculated as harmonic mean of jobs within 2 miles and population within 5 miles
* **UrbanArea**: Area that is Urban and unprotected (i.e. developable) within the zone
* **TownArea**: Area that is Town and unprotected (i.e. developable) within the zone
* **RuralArea**: Area that is Rural and unprotected (i.e. developable) within the zone
* **SFDU**: Number of single family dwelling units (PUMS codes 01 - 03) in zone
* **MFDU**: Number of multi-family dwelling units (PUMS codes 04 - 09) in zone




For more information see [here](https://github.com/VisionEval/VisionEval-Dev/blob/master/sources/modules/VESimLandUse/inst/module_docs/CreateSimBzones.md)

[Top](#rspm-modules-and-outputs)
___


### SimulateHousing    
his module assigns a housing type, either single-family (SF) or multifamily (MF) to regular households based on the respective supplies of SF and MF dwelling units in the housing market to which the household is assigned (i.e. the Azone the household is assigned to) and on household characteristics. It then assigns each household to a SimBzone based on the household's housing type as well as the supply of housing by type and SimBzone. The module assigns non-institutional group quarters households to SimBzones randomly.
#### User Input Files

#### Internal Module Inputs
|    Package         |      Module                           |   Outputs    | Description                               |
|--------------------|---------------------------------------|--------------|-------------------------------------------|
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**HhId**      | Household id                              |
| VESimHouseholds    | [PredictWorkers](#predictworkers)     |**Workers**   | Total workers in the household            |
| VESimLandUse    | [Initialize](#initialize)     |**PropGQPopCenter**    | see [Initialize](#initialize)   |
| VESimLandUse    |[Initialize](#initialize) |**PropGQPopInner**      |see [Initialize](#initialize)                              |
| VESimLandUse    | [Initialize](#initialize)    |**PropGQPopOuter**   | see [Initialize](#initialize)            |
| VESimLandUse    | [Initialize](#initialize)     |**PropGQPopFringe**    | see [Initialize](#initialize)    |
| VESimLandUse    | [CreateSimBzones](#createsimbzones)  |**SFDU**      | see [CreateSimBzones](#createsimbzones)                             |
| VESimLandUse    | [CreateSimBzones](#createsimbzones)      |**MFDU**   | see [CreateSimBzones](#createsimbzones)             |
| VESimLandUse    | [CreateSimBzones](#createsimbzones)     |**LocType**    | see [CreateSimBzones](#createsimbzones)     |
| VESimLandUse    | [CreateSimBzones](#createsimbzones)  |**AreaType**      | see [CreateSimBzones](#createsimbzones)                              |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds)      |**HhSize**   | Total workers in the household            |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds)      |**Age15to19**    | Number of workers residing in the zone    |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**Age20to29**      | Household id                              |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds)      |**Age30to54**   | Total workers in the household            |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds)      |**Age55to64**    | Number of workers residing in the zone    |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds)      |**Age65Plus**   | Total workers in the household            |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds)      |**HhType**    | Number of workers residing in the zone    |

#### Module Outputs
* **HouseType**: Type of dwelling unit in which the household resides (SF = single family, MF = multi-family, GQ = group quarters
* **LocType**: Location type (Urban, Town, Rural) of the place where the household resides
* **Pop**: Total population residing in Bzone
* **UrbanPop**: Urbanized area population in the Marea
* **TownPop**: Town (i.e. urban but non-urbanized area) in the Marea
* **RuralPop**: Rural (i.e. not urbanized and not town) population in the Marea
* **NumWkr**: Number of jobs in retail sector in zone
* **UrbanIncome**: Total household income of the urbanized area population in the Marea
* **TownIncome**: Total household income of the town (i.e. urban but non-urbanized area) population in the Marea
* **RuralIncome**: Total household income of the rural (i.e. not urbanized and not town) population in the Marea




For more information see [here](https://github.com/VisionEval/VisionEval-Dev/blob/master/sources/modules/VESimLandUse/inst/module_docs/SimulateHousing.md)

[Top](#rspm-modules-and-outputs)
___
### SimulateEmployment   
This module assign workers SimBzone work locations. A worker table is created which identifies a unique worker ID, the household ID the worker is a part of, and the SimBzone, Azone, and Marea of the worker job location.
#### User Input Files

#### Internal Module Inputs
|    Package         |      Module                           |   Outputs    | Description                               |
|--------------------|---------------------------------------|--------------|-------------------------------------------|
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**HhId**      | Household id                              |
| VESimHouseholds    | [PredictWorkers](#predictworkers)     |**Workers**   | Total workers in the household            |
| VESimLandUse    | [CreateSimBzones](#createsimbzones)     |**TotEmp**    | see [CreateSimBzones](#createsimbzones)   |
| VESimLandUse    |[CreateSimBzones](#createsimbzones) |**LocType**      |see [CreateSimBzones](#createsimbzones)                              |

#### Module Outputs
* **WkrId**: Unique worker ID
* **Bzone**: Bzone ID of worker job location
* **Azone**: Azone ID of worker job location
* **Marea**: Marea ID of worker job location




For more information see [here](https://github.com/VisionEval/VisionEval/blob/master/sources/modules/VESimLandUse/inst/module_docs/SimulateEmployment.md)

[Top](#rspm-modules-and-outputs)
___

### Simulate4DMeasures   
This module calculates several 4D measures by SimBzone including density, diversity (i.e. mixing of land uses), and pedestrian-orientedn transportation network design. These measures are the same as or are similar to measures included in the Environmental Protection Agency's (EPA)
#### User Input Files
1. D3bpo4 value or different location types (**_marea_d3bpo4_adj_**): This file provides the D3bpo4 value for urban, town and rural areas from the EPA 2010 Smart Location Database
   * **UrbanD3bpo4Adj**: Proportion of base urban D3bpo4 value as tabulated from the EPA 2010 Smart Location Database for the urbanized portion of the marea
   * **TownD3bpo4Adj**: Proportion of base town D3bpo4 value as tabulated from the EPA 2010 Smart Location Database for towns
   * **RuralD3bpo4Adj**: Proportion of base town D3bpo4 value as tabulated from the EPA 2010 Smart Location Database for rural areas

   Here is a snapshot of the file:
   <img align="center" width="400" border=1 src="images/d3.PNG">   

#### Internal Module Inputs
|    Package         |      Module                           |   Outputs    | Description                               |
|--------------------|---------------------------------------|--------------|-------------------------------------------|
| VESimLandUse    | [CreateSimBzones](#createsimbzones)     |**TotEmp**    | see [CreateSimBzones](#createsimbzones)    |
| VESimLandUse    | [CreateSimBzones](#createsimbzones)     |**RetEmp**    | see [CreateSimBzones](#createsimbzones)    |
| VESimLandUse    | [CreateSimBzones](#createsimbzones)     |**SvcEmp**    | see [CreateSimBzones](#createsimbzones)    |
| VESimLandUse    | [SimulateHousing](#simulatehousing)    |**Pop**   | see  [SimulateHousing](#simulatehousing)           |
| VESimLandUse    | [CreateSimBzones](#createsimbzones)     |**NumHh**    | see [CreateSimBzones](#createsimbzones)   |
| VESimLandUse    | [SimulateHousing](#simulatehousing)  |**NumWkr**      | see [SimulateHousing](#simulatehousing)                             |
| VESimLandUse    | [CreateSimBzones](#createsimbzones)      |**UrbanArea**   | see [CreateSimBzones](#createsimbzones)             |
| VESimLandUse    | [CreateSimBzones](#createsimbzones)     |**TownArea**    | see [CreateSimBzones](#createsimbzones)     |
| VESimLandUse    | [CreateSimBzones](#createsimbzones)  |**RuralArea**      | see [CreateSimBzones](#createsimbzones)                              |
| VESimLandUse    | [CreateSimBzones](#createsimbzones)  |**AreaType**      | see [CreateSimBzones](#createsimbzones)                              |
| VESimLandUse    | [CreateSimBzones](#createsimbzones)       |**DevType**   | see [CreateSimBzones](#createsimbzones)              |
| VESimLandUse    | [CreateSimBzones](#createsimbzones)  |**LocType**      | see [CreateSimBzones](#createsimbzones)                                |

#### Module Outputs
* **D1B**: Gross population density (people/acre) on unprotected 
* **D1C**: Gross employment density (jobs/acre) on unprotected land
* **D2A_JPHH**: Ratio of jobs to households in zone 
* **D2A_WRKEMP**: Ratio of workers to jobs in zone 
* **D2A_EPHHM**: Employment and household entropy measure for zone considering numbers of households, retail jobs, service jobs, and other jobs  
* **D3bpo4**: Intersection density in terms of pedestrian-oriented intersections having four or more legs per square mile



For more information see [here](https://github.com/VisionEval/VisionEval/blob/master/sources/modules/VESimLandUse/inst/module_docs/Simulate4DMeasures.md)

[Top](#rspm-modules-and-outputs)

___

### SimulateUrbanMixMeasure   
This module simulates an urban mixed-use measure based on the 2001 National Household Travel Survey measure of the tract level urban/rural indicator

#### User Input Files
1. Target for proportion of households  (**_marea_mix_targets_**): This file represents Marea target for proportion of households located in mixed-use neighborhoods (or NA if no target)
   * **UrbanMixProp**: Marea target for proportion of households located in mixed-use neighborhoods (or NA if no target)


   Here is a snapshot of the file:
<img align="center" width="400" border=1 src="images/mix.PNG">   

#### Internal Module Inputs
|    Package         |      Module                           |   Outputs    | Description                               |
|--------------------|---------------------------------------|--------------|-------------------------------------------|
|VESimLandUse    | [SimulateHousing](#simulatehousing)    |**Pop**   | see  [SimulateHousing](#simulatehousing)           |
|VESimLandUse    | [SimulateHousing](#simulatehousing)    |**UrbanPop**   | see  [SimulateHousing](#simulatehousing)           |
|VESimLandUse    | [SimulateHousing](#simulatehousing)    |**TownPop**   | see  [SimulateHousing](#simulatehousing)           |
|VESimLandUse    | [SimulateHousing](#simulatehousing)    |**RuralPop**   | see  [SimulateHousing](#simulatehousing)           |
| VESimLandUse    | [CreateSimBzones](#createsimbzones)     |**NumHh**    | see [CreateSimBzones](#createsimbzones)   |
| VESimLandUse    | [CreateSimBzones](#createsimbzones)      |**UrbanArea**   | see [CreateSimBzones](#createsimbzones)             |
| VESimLandUse    | [CreateSimBzones](#createsimbzones)     |**TownArea**    | see [CreateSimBzones](#createsimbzones)     |
| VESimLandUse    | [CreateSimBzones](#createsimbzones)  |**RuralArea**      | see [CreateSimBzones](#createsimbzones)                              |
| VESimLandUse    | [CreateSimBzones](#createsimbzones)  |**SFDU**      | see [CreateSimBzones](#createsimbzones)                              |
| VESimLandUse    | [CreateSimBzones](#createsimbzones)       |**MFDU**   | see [CreateSimBzones](#createsimbzones)              |

#### Module Outputs
* **IsUrbanMixNbrhd**: Flag identifying whether household is (1) or is not (0) in urban mixed-use neighborhood



For more information see [here](https://github.com/VisionEval/VisionEval/blob/master/sources/modules/VESimLandUse/inst/module_docs/SimulateUrbanMixMeasure.md)

[Top](#rspm-modules-and-outputs)


___

### AssignParkingRestrictions   
This module identifies parking restrictions and prices affecting households at their residences, workplaces, and other places they are likely to visit in the urban area. The module takes user inputs on parking restrictions and prices by Bzone and calculates for each household the number of free parking spaces available at the household's residence, which workers pay for parking and whether their payment is part of a cash-out-buy-back program, the cost of residential parking for household vehicles that can't be parked in a free space, the cost for workplace parking, and the cost of parking for other activities such as shopping. The parking restriction/cost information is used by other modules in calculating the cost of vehicle ownership and the cost of vehicle use.
#### User Input Files
1. Parking availability  (**_marea_parking-avail_by_area-type_**): This file has the data for avereage number of parkings available to households
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

2. Parking cost  (**_marea_parking-cost_by_area-type_**): This file has the data related to parking costs and population proportions paying the parking costs
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

#### Internal Module Inputs
|    Package         |      Module                           |   Outputs    | Description                               |
|--------------------|---------------------------------------|--------------|-------------------------------------------|
| VESimLandUse    | [CreateSimBzones](#createsimbzones)     |**RetEmp**    | see [CreateSimBzones](#createsimbzones)    |
| VESimLandUse    | [CreateSimBzones](#createsimbzones)     |**SvcEmp**    | see [CreateSimBzones](#createsimbzones)    |
| VESimLandUse    | [CreateSimBzones](#createsimbzones)     |**NumHh**    | see [CreateSimBzones](#createsimbzones)   |
| VESimLandUse    | [CreateSimBzones](#createsimbzones)      |**UrbanArea**   | see [CreateSimBzones](#createsimbzones)             |
| VESimLandUse    | [CreateSimBzones](#createsimbzones)  |**AreaType**      | see [CreateSimBzones](#createsimbzones)                              |
| VESimLandUse    | [CreateSimBzones](#createsimbzones)  |**LocType**      | see [CreateSimBzones](#createsimbzones)                                |
| VESimLandUse    | [SimulateHousing](#simulatehousing)  |**HouseType**      | see [SimulateHousing](#simulatehousing)                                |

#### Module Outputs
* **FreeParkingSpaces**: Number of free parking spaces available to the household
* **ParkingUnitCost**: Daily cost for long-term parking (e.g. paid on monthly basis)
* **OtherParkingCost**: Daily cost for parking at shopping locations or other locations of paid parking not including work (not adjusted for number of vehicle trips)
* **PaysForParking**: Does worker pay for parking: 1 = yes, 0 = no
* **IsCashOut**: Is worker paid parking in cash-out-buy-back program: 1 = yes, 0 = no
* **ParkingCost**: Daily cost for long-term parking (e.g. paid on monthly basis)



For more information see [here](https://github.com/VisionEval/VisionEval/blob/master/sources/modules/VESimLandUse/inst/module_docs/AssignParkingRestrictions.md)

[Top](#rspm-modules-and-outputs)

___

### AssignDemandManagement   
This module assigns demand management program participation to households and to workers. Households are assigned to individualized marketing program participation. Workers are assigned to employee commute options participation. The module computes the net proportional reduction in household DVMT based on the participation in travel demand management programs.
#### User Input Files
1. travel demand management  (**_marea_travel-demand-mgt_by_area-type_**): This file has the data for proportions participating in demand management programs
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



#### Internal Module Inputs
|    Package         |      Module                           |   Outputs    | Description                               |
|--------------------|---------------------------------------|--------------|-------------------------------------------|
| VESimHouseholds    | [CreateHouseholds](#createhouseholds)     |**HhSize**    | see [CreateHouseholds](#createhouseholds)    |
| VESimHouseholds    | [PredictWorkers](#predictworkers)     |**workers** | see [PredictWorkers](#predictworkers)    |


#### Module Outputs
* **IsIMP**: dentifies whether household is participant in travel demand management individualized marketing program (IMP): 1 = yes, 0 = n
* **PropTdmDvmtReduction**: Proportional reduction in household DVMT due to participation in travel demand management programs
* **IsECO**: Identifies whether worker is a participant in travel demand management employee commute options program: 1 = yes, 0 = no


For more information see [here](https://github.com/VisionEval/VisionEval/blob/master/sources/modules/VESimLandUse/inst/module_docs/AssignDemandManagement.md)

[Top](#rspm-modules-and-outputs)
__


### AssignCarSvcAvailability 

This module assigns car service availability levels (Low, High) to Bzones and households. Car services include taxis, car sharing services (e.g. Car-To-Go, Zipcar), and future automated taxi services
#### User Input Files
1. Car service availability  (**_marea_carsvc_availability_**): This file has the data for acitivity proportions which are served by car services
   * **CenterPropHighCarSvc**: Proportion of activity in center area type that is served by high level car service (i.e. service competitive with household owned car)
   * **InnerPropHighCarSvc**: Proportion of activity in inner area type that is served by high level car service (i.e. service competitive with household owned car)
   * **OuterPropHighCarSvc**: Proportion of activity in outer area type that is served by high level car service (i.e. service competitive with household owned car)
   * **FringePropHighCarSvc**: Proportion of activity in fringe area type that is served by high level car service (i.e. service competitive with household owned car)

   Here is a snapshot of the file:
   <img align="center" width="500" border=1 src="images/car_service.PNG">   



#### Internal Module Inputs
|    Package         |      Module                           |   Outputs    | Description                               |
|--------------------|---------------------------------------|--------------|-------------------------------------------|
| VESimLandUse    | [CreateSimBzones](#createsimbzones)     |**NumHh**    | see [CreateSimBzones](#createsimbzones)   |
| VESimLandUse    | [CreateSimBzones](#createsimbzones)  |**AreaType**      | see [CreateSimBzones](#createsimbzones)                              |
| VESimLandUse    | [CreateSimBzones](#createsimbzones)     |**TotEmp**    | see [CreateSimBzones](#createsimbzones)    |
| VESimLandUse    | [Calculate4DMeasures](#calculate4dmeasures)  |**D1D**      | see [Calculate4DMeasures](#calculate4dmeasures)                             |

#### Module Outputs
* **IsIMP**: dentifies whether household is participant in travel demand management individualized marketing program (IMP): 1 = yes, 0 = n
* **PropTdmDvmtReduction**: Proportional reduction in household DVMT due to participation in travel demand management programs
* **IsECO**: Identifies whether worker is a participant in travel demand management employee commute options program: 1 = yes, 0 = no


For more information see [here](https://github.com/VisionEval/VisionEval/blob/master/sources/modules/VESimLandUse/inst/module_docs/AssignDemandManagement.md)

[Top](#rspm-modules-and-outputs)
__


### SimulateTransitService 
This module assigns transit service level to the urbanized portion of each Marea and to neighborhoods (SimBzones) within the urbanized area. Annual revenue-miles (i.e. transit miles in revenue service) by transit mode type are read from an input file
#### User Input Files
1. Transit service for Marea (**_marea_transit_service.csv_**): This file contains annual revenue-miles for different transit modes for metropolitan area.
   * **DRRevMi**: Annual revenue-miles of demand-responsive public transit service
   * **VPRevMi**: Annual revenue-miles of van-pool and similar public transit service
   * **MBRevMi**: Annual revenue-miles of standard bus public transit service
   * **RBRevMi**: Annual revenue-miles of rapid-bus and commuter bus public transit service
   * **MGRevMi**: Annual revenue-miles of monorail and automated guideway public transit service
   * **SRRevMi**: Annual revenue-miles of streetcar and trolleybus public transit service
   * **HRRevMi**: Annual revenue-miles of light rail and heavy rail public transit service
   * **CRRevMi**: Annual revenue-miles of commuter rail, hybrid rail, cable car, and aerial tramway public transit service
   
   Here is a snapshot of the file:
   <img align="center" width="800" border=1 src="images/marea_transit_service.PNG">


#### Internal Module Inputs
|    Package         |      Module                           |   Outputs    | Description                               |
|--------------------|---------------------------------------|--------------|-------------------------------------------|
| VESimLandUse    | [CreateSimBzones](#createsimbzones)     |**NumHh**    | see [CreateSimBzones](#createsimbzones)   |
| VESimLandUse    | [CreateSimBzones](#createsimbzones)  |**AreaType**      | see [CreateSimBzones](#createsimbzones)                              |
| VESimLandUse    | [CreateSimBzones](#createsimbzones)     |**TotEmp**    | see [CreateSimBzones](#createsimbzones)    |
| VESimLandUse    | [CreateSimBzones](#createsimbzones)      |**UrbanArea**   | see [CreateSimBzones](#createsimbzones)             |
| VESimLandUse    | [CreateSimBzones](#createsimbzones)       |**DevType**   | see [CreateSimBzones](#createsimbzones)              |
|VESimLandUse    | [SimulateHousing](#simulatehousing)    |**UrbanPop**   | see  [SimulateHousing](#simulatehousing)           |

#### Module Outputs
* **TranRevMiPC**: Ratio of annual bus-equivalent revenue-miles (i.e. revenue-miles at the same productivity - passenger miles per revenue mile - as standard bus) to urbanized area population
* **VanDvmt**: Total daily miles traveled by vans of various sizes to provide demand responsive, vanpool, and similar services.
* **BusDvmt**: Total daily miles traveled by buses of various sizes to provide bus service of various types.
* **RailDvmt**: Total daily miles traveled by light rail, heavy rail, commuter rail, and similar types of vehicles.
* **D4c**: Aggregate frequency of transit service within 0.25 miles of block group boundary per hour during evening peak period (Ref: EPA 2010 Smart Location Database)


For more information see [here](https://github.com/VisionEval/VisionEval/blob/master/sources/modules/VESimTransportSupply/inst/module_docs/SimulateTransitService.md)

[Top](#rspm-modules-and-outputs)

__

### SimulateRoadMiles 
This module assigns freeway and arterial lane-miles to metropolitan areas (Marea) and calculates freeway lane-miles per capita.
#### User Input Files
1. Lane-Miles for `Marea` (**_marea_lane_miles.csv_**): This file contains inputs on the numbers of freeway lane-miles and arterial lane-miles by `Marea` and year.
   * **FwyLaneMi**: Lane-miles of roadways functionally classified as freeways or expressways in the urbanized portion of the metropolitan area
   * **ArtLaneMi**: Lane-miles of roadways functionally classified as arterials (but not freeways or expressways) in the urbanized portion of the metropolitan area

   Here is a snapshot of the file:
   <img align="center" width="400" border=1 src="images/marea_lane_miles.PNG">


#### Internal Module Inputs
|    Package         |      Module                           |   Outputs    | Description                               |
|--------------------|---------------------------------------|--------------|-------------------------------------------|
|VESimLandUse    | [SimulateHousing](#simulatehousing)    |**UrbanPop**   | see  [SimulateHousing](#simulatehousing)           |

#### Module Outputs
* **FwyLaneMiPC**: Ratio of urbanized area freeway and expressway lane-miles to urbanized area population



For more information see [here](https://github.com/VisionEval/VisionEval/blob/master/sources/modules/VESimTransportSupply/inst/module_docs/SimulateRoadMiles.md)

[Top](#rspm-modules-and-outputs)

___

### AssignDrivers 
This module assigns drivers by age group to each household as a function of the numbers of persons and workers by age group, the household income, land use characteristics, and public transit availability. 

#### User Input Files
1. Adjustment proportion for household drivers by age group for the region (**_region_hh_driver_adjust_prop.csv_**): This file specifies the relative driver licensing rate relative to the model estimation data year in order to account for observed or projected changes in licensing rates.
   * **Drv15to19AdjProp**: Target proportion of unadjusted model number of drivers 15 to 19 years old (`1` = no adjustment)
   * **Drv20to29AdjProp**: Target proportion of unadjusted model number of drivers 20 to 29 years old (`1` = no adjustment)
   * **Drv30to54AdjProp**: Target proportion of unadjusted model number of drivers 30 to 54 years old (`1` = no adjustment)
   * **Drv55to64AdjProp**: Target proportion of unadjusted model number of drivers 55 to 64 years old (`1` = no adjustment)
   * **Drv65PlusAdjProp**: Target proportion of unadjusted model number of drivers 65 or older (`1` = no adjustment)
   
   Here is a snapshot of the file:
   <img align="center" width="800" border=1 src="images/region_hh_driver_adjust_prop.PNG">

#### Internal Module Inputs
|    Package         |      Module                           |   Outputs    | Description                               |
|--------------------|---------------------------------------|--------------|-------------------------------------------|
| VETransportSupply  | [AssignTransitService](#assigntransitservice)     |**TranRevMiPC**     |Ratio of annual bus-equivalent revenue-miles (i.e. revenue-miles at the same productivity - passenger miles per revenue mile - as standard bus) to urbanized area population              |
| VELandUse          | [Calculate4DMeasures](#calculate4dmeasures)     |**D1B** | Gross population density (people/acre) on unprotected (i.e. developable) land in zone    |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**HhId**      | Household id                              |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**Age15to19** | Persons in 15 to 19 year old age group    |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**Age20to29** | Persons in 20 to 29 year old age group    |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**Age30to54** | Persons in 30 to 54 year old age group    |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**Age55to64** | Persons in 55 to 64 year old age group    |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**Age65Plus** | Persons in 65 or older age group          |
| VESimHouseholds    | [PredictIncome](#predictincome)       |**Income**    | Total annual income of household          |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**HHSize**    | Number of persons in the household        |
| VELandUse          | [CalculateUrbanMixMeasure](#calculateurbanmixmeasure)     |**IsUrbanMixNbrhd** | Flag identifying whether household is (`1`) or is not (`0`) in urban mixed-use neighborhood    |
| VELandUse          | [AssignLocTypes](#assignloctypes) |**LocType**    | Location type (Urban, Town, Rural) of the place where the household resides        |


#### Module Outputs
* **Drv15to19**: Number of drivers 15 to 19 years old
* **Drv20to29**: Number of drivers 20 to 29 years old
* **Drv30to54**: Number of drivers 30 to 54 years old
* **Drv55to64**: Number of drivers 55 to 64 years old
* **Drv65Plus**: Number of drivers 65 or older
* **Drivers**: Number of drivers in household
* **DrvAgePersons**: Number of people 15 year old or older in the household

For more information see [here](https://github.com/VisionEval/VisionEval/blob/master/sources/modules/VEHouseholdVehicles/inst/module_docs/AssignDrivers.md)

[Top](#rspm-modules-and-outputs)

___

### AssignVehicleOwnership 
This module determines the number of vehicles owned or leased by each household as a function of household characteristics, land use characteristics, and transportation system characteristics.

#### User Input Files
This module has no user input requirements.


#### Internal Module Inputs
|    Package         |      Module                           |   Outputs    | Description                               |
|--------------------|---------------------------------------|--------------|-------------------------------------------|
| VETransportSupply          | [AssignTransitService](#assigntransitservice)     |**TranRevMiPC**     | Ratio of annual bus-equivalent revenue-miles to urbanized area population              |
| VELandUse          | [Calculate4DMeasures](#calculate4dmeasures)     |**D1B** | Gross population density (people/acre) on unprotected (i.e. developable) land in zone    |
| VESimHouseholds    | [PredictWorkers](#predictworkers)     |**Workers**   | Total workers in the household            |
| VEHouseholdVehicles    | [AssignDrivers](#assigndrivers)     |**Drivers**   | Number of drivers in household            |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**Age65Plus** | Persons in 65 or older age group          |
| VELandUse          | [PredictHousing](#predicthousing)     |**HouseType** | Type of dwelling unit of the household    |
| VESimHouseholds    | [PredictIncome](#predictincome)       |**Income**    | Total annual income of household          |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**HHSize**    | Number of persons in the household        |
| VELandUse          | [CalculateUrbanMixMeasure](#calculateurbanmixmeasure)     |**IsUrbanMixNbrhd** | Flag identifying whether household is (`1`) or is not (`0`) in urban mixed-use neighborhood    |
| VELandUse    | [AssignLocTypes](#assignloctypes) |**LocType**    | Location type (Urban, Town, Rural) of the place where the household resides        |


#### Module Outputs  
* **Vehicles**: Number of automobiles and light trucks owned or leased by the household including high level car service vehicles available to driving-age persons


For more information see [here](https://github.com/visioneval/VisionEval/blob/master/sources/modules/VEHouseholdVehicles/inst/module_docs/AssignVehicleOwnership.md)

[Top](#rspm-modules-and-outputs)

___

### AssignVehicleType 
This module identifies how many household vehicles are light trucks and how many are automobiles. Light trucks include pickup trucks, sport utility vehicles, vans, and any other vehicle not classified as a passenger car. Automobiles are vehicles classified as passenger cars.

#### User Input Files
1. Light truck proportion for `Azone` (**_azone_lttrk_prop.csv_**): This file specifies the light truck proportion of the vehicle fleet.
   * **LtTrkProp**: Proportion of household vehicles that are light trucks (pickup, SUV, van).
     
   
   Here is a snapshot of the file:
   <img align="center" width="300" border=1 src="images/azone_lttrk_prop.PNG">

#### Internal Module Inputs
|    Package         |      Module                           |   Outputs    | Description                               |
|--------------------|---------------------------------------|--------------|-------------------------------------------|
| VELandUse          | [Calculate4DMeasures](#calculate4dmeasures)     |**D1B** | Gross population density (people/acre) on unprotected (i.e. developable) land in zone    |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**HhId**      | Household id                              |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**Age0to14** | Persons in 0 to 14 year old age group   |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**Age15to19** | Persons in 15 to 19 year old age group    |
| VEHouseholdVehicles    | [AssignDrivers](#assigndrivers)     |**Drivers**   | Number of drivers in household            |
| VEHouseholdVehicles    | [AssignVehicleOwnership](#assignvehicleownership)     |**Vehicles**   | Number of automobiles and light trucks owned or leased by the household including high level car service vehicles available to driving-age persons           |
| VELandUse          | [PredictHousing](#predicthousing)     |**HouseType** | Type of dwelling unit of the household    |
| VESimHouseholds    | [PredictIncome](#predictincome)       |**Income**    | Total annual income of household          |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**HHSize**    | Number of persons in the household        |
| VELandUse          | [CalculateUrbanMixMeasure](#calculateurbanmixmeasure)     |**IsUrbanMixNbrhd** | Flag identifying whether household is (`1`) or is not (`0`) in urban mixed-use neighborhood    |


#### Module Outputs
* **NumLtTrk**: Number of light trucks (pickup, sport-utility vehicle, and van) owned or leased by household
* **NumAuto**: Number of automobiles (i.e., four-tire passenger vehicles that are not light trucks) owned or leased by household

For more information see [here](https://github.com/visioneval/VisionEval/blob/master/sources/modules/VEHouseholdVehicles/inst/module_docs/AssignVehicleType.md)

[Top](#rspm-modules-and-outputs)

___

### CreateVehicleTable  
This module creates a vehicle table and populates it with household ID and geography fields.

#### User Input Files
1. Car service characteristics for `Azone` (**azone_carsvc_characteristics.csv**): This file specifies the different characteristics for high and low car service levels
   * **HighCarSvcCost**: Average cost in dollars per mile for travel by high service level car service
   * **LowCarSvcCost**: Average cost in dollars per mile for travel by low service level car service
   * **AveCarSvcVehicleAge**: Average age of car service vehicles in years
   * **LtTrkCarSvcSubProp**: The proportion of light-truck owners who would substitute a less-costly car service option for owning their light truck
   * **AutoCarSvcSubProp**: The proportion of automobile owners who would substitute a less-costly car service option for owning their automobile

   Here is a snapshot of the file:
   <img align="center" width="800" border=1 src="images/azone_carsvc_characteristics.PNG">

#### Internal Module Inputs
|    Package         |      Module                           |   Outputs    | Description                               |
|--------------------|---------------------------------------|--------------|-------------------------------------------|
| VEHouseholdVehicles    | [AssignVehicleOwnership](#assignvehicleownership)     |**Vehicles**   | Number of automobiles and light trucks owned or leased by the household including high level car service vehicles available to driving-age persons           |
| VEHouseholdVehicles    | [AssignDrivers](#assigndrivers)     |**DrvAgePersons**   | Number of people 15 year old or older in the household           |
| VELandUse     | [AssignCarSvcAvailability ](#assigncarsvcavailability)     |**CarSvcLevel**   | Level of car service availability for household. High means access is competitive with household owned car. Low is not competitive.          |

#### Module Outputs
* **VehId**: Unique vehicle ID
* **VehicleAccess**: Identifier whether vehicle is owned by household (`Own`), if vehicle is low level car service (`LowCarSvc`), or if vehicle is high level car service (`HighCarSvc`)

For more information see [here](https://github.com/visioneval/VisionEval/blob/master/sources/modules/VEHouseholdVehicles/inst/module_docs/CreateVehicleTable.md)

[Top](#rspm-modules-and-outputs)

___

### AssignVehicleAge   
This module assigns vehicle ages to each household vehicle. Vehicle age is assigned as a function of the vehicle type (auto or light truck), household income, and assumed mean vehicle age by vehicle type and `Azone`. Car service vehicles are assigned an age based on input assumptions with no distinction between vehicle type.

#### User Input Files
1. Vehicles mean age for `Azone` (**azone_hh_veh_mean_age.csv**): This file provides inputs for mean auto age and mean light truck age in azone.
   * **AutoMeanAge**: Mean age of automobiles owned or leased by households.
   * **LtTrkMeanAge**: Mean age of light trucks owned or leased by households.

   Here is a snapshot of the file:
   <img align="center" width="400" border=1 src="images/azone_hh_veh_mean_age.PNG">

2. Car service characteristics for `Azone` (**azone_carsvc_characteristics.csv**): This file specifies the different characteristics for high and low car service levels
   * **AveCarSvcVehicleAge**: Average age of car service vehicles in years

   Here is a snapshot of the file:
   <img align="center" width="800" border=1 src="images/azone_carsvc_characteristics.PNG">

#### Internal Module Inputs
|    Package         |      Module                           |   Outputs    | Description                               |
|--------------------|---------------------------------------|--------------|-------------------------------------------|
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**HhId**      | Household id                              |
| VEHouseholdVehicles    | [CreateVehicleTable ](#createvehicletable ) |**VehId**      |  Unique vehicle ID                             |
| VESimHouseholds    | [PredictIncome](#predictincome)       |**Income**    | Total annual income of household          |
| VEHouseholdVehicles    | [AssignVehicleOwnership](#assignvehicleownership)     |**Vehicles**   | Number of automobiles and light trucks owned or leased by the household including high level car service vehicles available to driving-age persons           |
| VEHouseholdVehicles    | [AssignVehicleType](#assignvehicletype) |**NumLtTrk**      | Number of light trucks (pickup, sport-utility vehicle, and van) owned or leased by household                             |
| VEHouseholdVehicles    | [AssignVehicleType](#assignvehicletype) |**NumAuto**      | Number of automobiles (i.e. 4-tire passenger vehicles that are not light trucks) owned or leased by household                              |
| VEHouseholdVehicles    | [CreateVehicleTable](#createvehicletable) |**VehicleAccess**      | Identifier whether vehicle is owned by household (Own), if vehicle is low level car service (LowCarSvc), or if vehicle is high level car service (`HighCarSvc`)                             |

#### Module Outputs
* **Type**: Vehicle body type: Auto = automobile, LtTrk = light trucks (i.e. pickup, SUV, Van)
* **Age**: Vehicle age in years

For more information see [here](https://github.com/visioneval/VisionEval/blob/master/sources/modules/VEHouseholdVehicles/inst/module_docs/AssignVehicleAge.md)

[Top](#rspm-modules-and-outputs)

___

### CalculateVehicleOwnCost  
This module calculates average vehicle ownership cost for each vehicle based on the vehicle type and age using data from the American Automobile Association (AAA). To this are added the cost of parking at the vehicle residence if free parking is not available for all household vehicles. The ownership cost is converted into an average ownership cost per mile by predicting the household DVMT, given the number of owned vehicles and splitting the miles equally among each vehicle.
#### User Input Files
1. Vehicle ownership taxes for `Azone` (**azone_hh_veh_own_taxes.csv**): This file provides inputs for flat fees/taxes (i.e. annual cost per vehicle) and ad valorem taxes (i.e. percentage of vehicle value paid in taxes).
   * **VehOwnFlatRateFee**: Annual flat rate tax per vehicle in dollars
   * **VehOwnAdValoremTax**: Annual proportion of vehicle value paid in taxes
   
   Here is a snapshot of the file:

   <img align="center" width="500" border=1 src="images/azone_hh_veh_own_taxes.PNG">

2. Proportion of pay-as-you-drive (PAYD) insurance users for `Azone` (**azone_payd_insurance_prop.csv**): This file provides inputs on the proportion of households having PAYD insurance.
   * **PaydHhProp**: Proportion of households in the Azone who have pay-as-you-drive insurance for their vehicles
   
   Here is a snapshot of the file:
   
   <img align="center" width="300" border=1 src="images/azone_payd_insurance_prop.PNG">

#### Internal Module Inputs
|    Package         |      Module                           |   Outputs    | Description                               |
|--------------------|---------------------------------------|--------------|-------------------------------------------|
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**HhId**      | Household id                              |
| VEHouseholdVehicles    | [CreateVehicleTable ](#createvehicletable ) |**VehId**      |  Unique vehicle ID                             |
| VEHouseholdVehicles    | [CreateVehicleTable    ](#createvehicletable ) |**VehicleAccess**      |  Identifier whether vehicle is owned by household (`Own`), if vehicle is low level car service (`LowCarSvc`), or if vehicle is high level car service (`HighCarSvc`)                            |
| VEHouseholdVehicles    | [AssignVehicleAge ](#assignvehicleage ) |**Type**      |  Vehicle body type: `Auto` = automobile, `LtTrk` = light trucks (i.e. pickup, SUV, Van)                             |
| VEHouseholdVehicles    | [AssignVehicleAge ](#assignvehicleage ) |**Age**      |  Vehicle age in years                            |
| VELandUse  | [AssignParkingRestrictions ](#assignparkingrestrictions ) |**FreeParkingSpaces**      |  Number of free parking spaces available to the household                           |
| VELandUse  | [AssignParkingRestrictions ](#assignparkingrestrictions ) |**ParkingUnitCost**      | Daily cost for long-term parking (e.g. paid on monthly basis)                         |
| VEHouseholdVehicles    | [AssignDrivers](#assigndrivers)     |**Drivers**   | Number of drivers in household            |
| VEHouseholdVehicles    | [AssignDrivers](#assigndrivers)     |**Drv15to19**   | Number of drivers 15 to 19 years old            |
| VEHouseholdVehicles    | [AssignDrivers](#assigndrivers)     |**Drv20to29**   | Number of drivers 20 to 29 years old            |
| VEHouseholdVehicles    | [AssignDrivers](#assigndrivers)     |**Drv30to54**   | Number of drivers 30 to 54 years old            |
| VEHouseholdVehicles    | [AssignDrivers](#assigndrivers)     |**Drv55to64**   | Number of drivers 55 to 64 years old            |
| VEHouseholdVehicles    | [AssignDrivers](#assigndrivers)     |**Drv65Plus**   | Number of drivers 65 and older                  |
| VESimHouseholds    | [PredictIncome](#predictincome)       |**Income**    | Total annual income of household          |
| VELandUse    | [AssignLocTypes](#assignloctypes) |**LocType**    | Location type (Urban, Town, Rural) of the place where the household resides        |
| VEHouseholdVehicles    | [AssignVehicleType](#assignvehicletype) |**NumLtTrk**      | Number of light trucks (pickup, sport-utility vehicle, and van) owned or leased by household                             |
| VEHouseholdVehicles    | [AssignVehicleType](#assignvehicletype) |**NumAuto**      | Number of automobiles (i.e. 4-tire passenger vehicles that are not light trucks) owned or leased by household                              |


#### Module Outputs
* **OwnCost**: Annual cost of vehicle ownership including depreciation, financing, insurance, taxes, and residential parking in dollars
* **OwnCostPerMile**: Annual cost of vehicle ownership per mile of vehicle travel (dollars per mile)
* **InsCost**: Annual vehicle insurance cost in dollars
* **HasPaydIns**: Identifies whether household has pay-as-you-drive insurance for vehicles: 1 = Yes, 0 = no

For more information see [here](https://github.com/visioneval/VisionEval/blob/master/sources/modules/VEHouseholdVehicles/inst/module_docs/CalculateVehicleOwnCost.md)

[Top](#rspm-modules-and-outputs)

___

### AdjustVehicleOwnership  
This module adjusts household vehicle ownership based on a comparison of the cost of owning a vehicle per mile of travel compared to the cost per mile of using a car service in locations where the level of car service quality is high. The determination of whether car services are substituted for ownership also depends on input assumptions regarding the average likelihood that an owner would substitute car services for a household vehicle.

#### User Input Files
1. Car service characteristics for `Azone` (**azone_carsvc_characteristics.csv**): This file specifies the different characteristics for high and low car service levels
   * **HighCarSvcCost**: Average cost in dollars per mile for travel by high service level car service
   * **LowCarSvcCost**: Average cost in dollars per mile for travel by low service level car service
   * **AveCarSvcVehicleAge**: Average age of car service vehicles in years
   * **LtTrkCarSvcSubProp**: The proportion of light-truck owners who would substitute a less-costly car service option for owning their light truck
   * **AutoCarSvcSubProp**: The proportion of automobile owners who would substitute a less-costly car service option for owning their automobile
   
   Here is a snapshot of the file:
   <img align="center" width="800" border=1 src="images/azone_carsvc_characteristics.PNG">


#### Internal Module Inputs
|    Package         |      Module                           |   Outputs    | Description                               |
|--------------------|---------------------------------------|--------------|-------------------------------------------|
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**HhId**      | Household id                              |
| VEHouseholdVehicles    | [CreateVehicleTable ](#createvehicletable ) |**VehId**      |  Unique vehicle ID                             |
| VEHouseholdVehicles    | [AssignVehicleOwnership](#assignvehicleownership)     |**Vehicles**   | Number of automobiles and light trucks owned or leased by the household including high level car service vehicles available to driving-age persons           |
| VEHouseholdVehicles    | [CreateVehicleTable    ](#createvehicletable ) |**VehicleAccess**      |  Identifier whether vehicle is owned by household (`Own`), if vehicle is low level car service (`LowCarSvc`), or if vehicle is high level car service (`HighCarSvc`)                            |
| VEHouseholdVehicles    | [AssignVehicleType](#assignvehicletype) |**NumLtTrk**      | Number of light trucks (pickup, sport-utility vehicle, and van) owned or leased by household                             |
| VEHouseholdVehicles    | [AssignVehicleType](#assignvehicletype) |**NumAuto**      | Number of automobiles (i.e. 4-tire passenger vehicles that are not light trucks) owned or leased by household                              |
| VELandUse     | [AssignCarSvcAvailability ](#assigncarsvcavailability)     |**CarSvcLevel**   | Level of car service availability for household. High means access is competitive with household owned car. Low is not competitive.          |
| VEHouseholdVehicles    | [AssignVehicleAge ](#assignvehicleage ) |**Type**      |  Vehicle body type: `Auto` = automobile, `LtTrk` = light trucks (i.e. pickup, SUV, Van)                             |
| VEHouseholdVehicles    | [AssignVehicleAge ](#assignvehicleage ) |**Age**      |  Vehicle age in years                            |
ouseholdVehicles    | [CalculateVehicleOwnCost ](#calculatevehicleowncost ) |**OwnCost**      |  Annual cost of vehicle ownership including depreciation, financing, insurance, taxes, and residential parking in dollars                       |
| VEHouseholdVehicles    | [CalculateVehicleOwnCost ](#calculatevehicleowncost ) |**OwnCostPerMile**      |  Annual cost of vehicle ownership per mile of vehicle travel (dollars per mile)                       |
| VEHouseholdVehicles    | [CalculateVehicleOwnCost ](#calculatevehicleowncost ) |**InsCost**      |  Annual vehicle insurance cost in dollars                       |


#### Module Outputs
* **VehicleAccess**: Identifier whether vehicle is owned by household (Own), if vehicle is low level car service (`LowCarSvc`), or if vehicle is high level car service (`HighCarSvc`)
* **OwnCost**: Annual cost of vehicle ownership per mile of vehicle travel (dollars per mile)
* **OwnCostPerMile**:Annual cost of vehicle ownership per mile of vehicle travel (dollars per mile)
* **InsCost**: Annual vehicle insurance cost in dollars
* **SwitchToCarSvc**: Identifies whether a vehicle was switched from owned to car service
* **OwnCostSavings**: Annual vehicle ownership cost (depreciation, finance, insurance, taxes) savings in dollars resulting from substituting the use of car services for a household vehicle
* **OwnCost**:Annual household vehicle ownership cost (depreciation, finance, insurance, taxes) savings in dollars
* **Vehicles**:Number of automobiles and light trucks owned or leased by the household including high level car service vehicles available to driving-age persons
* **NumLtTrk**:Number of light trucks (pickup, sport-utility vehicle, and van) owned or leased by household
* **NumAuto**:Number of automobiles (i.e. 4-tire passenger vehicles that are not light trucks) owned or leased by household
* **NumHighCarSvc**:Number of high level service car service vehicles available to the household (difference between number of vehicles owned by the household and number of driving age persons for households having availability of high level car services

For more information see [here](https://github.com/visioneval/VisionEval/blob/master/sources/modules/VEHouseholdVehicles/inst/module_docs/AdjustVehicleOwnership.md)

[Top](#rspm-modules-and-outputs)

___


### CalculateHouseholdDvmt  
This module models household average daily vehicle miles traveled as a function of household characteristics, vehicle ownership, and attributes of the neighborhood and metropolitan area where the household resides.
#### User Input Files
This module has no user input requirements.

#### Internal Module Inputs
|    Package         |      Module                           |   Outputs    | Description                               |
|--------------------|---------------------------------------|--------------|-------------------------------------------|
| VETransportSupply          | [AssignTransitService](#assigntransitservice)     |**TranRevMiPC**     |Ratio of annual bus-equivalent revenue-miles (i.e. revenue-miles at the same productivity - passenger miles per revenue mile - as standard bus) to urbanized area population              |
| VETransportSupply          | [ AssignRoadMiles ](#assignroadmiles)     |**FwyLaneMiPC**     |Ratio of urbanized area freeway and expressway lane-miles to urbanized area population              |
| VELandUse          | [Calculate4DMeasures](#calculate4dmeasures)     |**D1B** | Gross population density (people/acre) on unprotected (i.e., developable) land in zone    |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**Age0to14**  | Persons in 0 to 14 year old age group     |
| VEHouseholdVehicles    | [AssignDrivers](#assigndrivers)     |**Drivers**   | Number of drivers in household            |
| VESimHouseholds    | [PredictWorkers](#predictworkers)     |**Workers**   | Total workers in the household            |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**HHSize**    | Number of persons in the household        |
| VELandUse    | [AssignLocTypes](#assignloctypes) |**LocType**    | Location type (`Urban`, `Town`, `Rural`) of the place where the household resides        |
| VEHouseholdVehicles    | [AssignVehicleOwnership](#assignvehicleownership)     |**Vehicles**   | Number of automobiles and light trucks owned or leased by the household including high level car service vehicles available to driving-age persons           |
| VESimHouseholds    | [PredictIncome](#predictincome)       |**Income**    | Total annual income of household          |
| VELandUse          | [CalculateUrbanMixMeasure](#calculateurbanmixmeasure)     |**IsUrbanMixNbrhd** | Flag identifying whether household is (`1`) or is not (`0`) in urban mixed-use neighborhood    |


#### Module Outputs
* **Dvmt**: Average daily vehicle miles traveled by the household in autos or light trucks
* **UrbanHhDvmt**: Average daily vehicle miles traveled in autos or light trucks by households residing in the urbanized portion of the `Marea`
* **TownHhDvmt**: Average daily vehicle miles traveled in autos or light trucks by households residing in town (urban but not urbanized) portion of the `Marea`
* **RuralHhDvmt**: Average daily vehicle miles traveled in autos or light trucks by households residing in the rural (non-urban) portion of the `Marea`


For more information see [here](https://github.com/visioneval/VisionEval/blob/master/sources/modules/VEHouseholdTravel/inst/module_docs/CalculateHouseholdDvmt.md)

[Top](#rspm-modules-and-outputs)

___

### CalculateAltModeTrips   
This module calculates household transit trips, walk trips, and bike trips. The models are sensitive to household DVMT so they are run after all household DVMT adjustments (e.g. to account for cost on household DVMT) are made.
#### User Input Files
This module has no user input requirements.

#### Internal Module Inputs
|    Package         |      Module                           |   Outputs    | Description                               |
|--------------------|---------------------------------------|--------------|-------------------------------------------|
| VETransportSupply          | [AssignTransitService](#assigntransitservice)     |**TranRevMiPC**     |Ratio of annual bus-equivalent revenue-miles (i.e. revenue-miles at the same productivity - passenger miles per revenue mile - as standard bus) to urbanized area population              |
| VELandUse          | [Calculate4DMeasures](#calculate4dmeasures)     |**D1B** | Gross population density (people/acre) on unprotected (i.e. developable) land in zone    |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**Age15to19** | Persons in 15 to 19 year old age group    |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**Age20to29** | Persons in 20 to 29 year old age group    |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**Age30to54** | Persons in 30 to 54 year old age group    |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**Age55to64** | Persons in 55 to 64 year old age group    |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**Age65Plus** | Persons in 65 or older age group          |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**Age0to14**  | Persons in 0 to 14 year old age group     |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**HHSize**    | Number of persons in the household        |
| VELandUse    | [AssignLocTypes](#assignloctypes) |**LocType**    | Location type (`Urban`, `Town`, `Rural`) of the place where the household resides        |
| VEHouseholdVehicles    | [AssignVehicleOwnership](#assignvehicleownership)     |**Vehicles**   | Number of automobiles and light trucks owned or leased by the household including high level car service vehicles available to driving-age persons           |
| VESimHouseholds    | [PredictIncome](#predictincome)       |**Income**    | Total annual income of household          |
| VELandUse          | [CalculateUrbanMixMeasure](#calculateurbanmixmeasure)     |**IsUrbanMixNbrhd** | Flag identifying whether household is (`1`) or is not (`0`) in urban mixed-use neighborhood    |
| VEHouseholdTravel          | [CalculateHouseholdDvmt](#CalculateHouseholdDvmt)     |**Dvmt** | Average daily vehicle miles traveled by the household in autos or light trucks    |


#### Module Outputs
* **WalkTrips**: Average number of walk trips per year by household members
* **BikeTrips**: Average number of bicycle trips per year by household members
* **TransitTrips**:Average number of public transit trips per year by household members

For more information see [here](https://github.com/visioneval/VisionEval/blob/master/sources/modules/VEHouseholdTravel/inst/module_docs/CalculateAltModeTrips.md)

[Top](#rspm-modules-and-outputs)

___

### CalculateVehicleTrips    
This module calculates average daily vehicle trips for households consistent with the household DVMT. An average trip length model is applied to estimate average length of household trips reflecting the characteristics of the household and the place where they live. The average trip length is divided into the average household DVMT to get an estimate of average number of daily vehicle trips.
#### User Input Files
This module has no user input requirements.


#### Internal Module Inputs
|    Package         |      Module                           |   Outputs    | Description                               |
|--------------------|---------------------------------------|--------------|-------------------------------------------|
| VETransportSupply          | [ AssignRoadMiles ](#assignroadmiles)     |**FwyLaneMiPC**     |Ratio of urbanized area freeway and expressway lane-miles to urbanized area population              |
| VELandUse          | [Calculate4DMeasures](#calculate4dmeasures)     |**D1B** | Gross population density (people/acre) on unprotected (i.e. developable) land in zone    |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**HHSize**    | Number of persons in the household        |
| VELandUse    | [AssignLocTypes](#assignloctypes) |**LocType**    | Location type (Urban, Town, Rural) of the place where the household resides        |
| VEHouseholdVehicles    | [AssignVehicleOwnership](#assignvehicleownership)     |**Vehicles**   | Number of automobiles and light trucks owned or leased by the household including high level car service vehicles available to driving-age persons           |
| VEHouseholdVehicles    | [AssignDrivers](#assigndrivers)     |**Drivers**   | Number of drivers in household            |
| VESimHouseholds    | [PredictIncome](#predictincome)       |**Income**    | Total annual income of household          |
| VELandUse          | [CalculateUrbanMixMeasure](#calculateurbanmixmeasure)     |**IsUrbanMixNbrhd** | Flag identifying whether household is (`1`) or is not (`0`) in urban mixed-use neighborhood    |
| VEHouseholdTravel          | [CalculateHouseholdDvmt](#CalculateHouseholdDvmt)     |**Dvmt** | Average daily vehicle miles traveled by the household in autos or light trucks    |


#### Module Outputs
* **VehicleTrips**: Average number of vehicle trips per day by household members
* **AveVehTripLen**: Average household vehicle trip length in miles

For more information see [here](https://github.com/visioneval/VisionEval/blob/master/sources/modules/VEHouseholdTravel/inst/module_docs/CalculateVehicleTrips.md)

[Top](#rspm-modules-and-outputs)

___

### DivertSovTravel    
This module reduces household single-occupant vehicle (SOV) travel to achieve goals that are inputs to the model. The purpose of this module is to enable users to do 'what if' analysis of the potential of light-weight vehicles (e.g. bicycles, electric bikes, electric scooters) and infrastructure to support their use to reduce SOV travel.
#### User Input Files
1. Proportion of diverted SOVs for `Azone` (**azone_prop_sov_dvmt_diverted.csv**): This file provides inputs for a goal for diverting a portion of SOV travel within a 20-mile tour distance (round trip distance).
   * **PropSovDvmtDiverted**: Goals for the proportion of household DVMT in single occupant vehicle tours with round-trip distances of 20 miles or less be diverted to bicycling or other slow speed modes of travel
   
   Here is a snapshot of the file:
   <img align="center" width="400" border=1 src="images/azone_prop_sov_dvmt_diverted.PNG">

#### Internal Module Inputs
|    Package         |      Module                           |   Outputs    | Description                               |
|--------------------|---------------------------------------|--------------|-------------------------------------------|
| VETransportSupply          | [ AssignRoadMiles ](#assignroadmiles)     |**FwyLaneMiPC**     |Ratio of urbanized area freeway and expressway lane-miles to urbanized area population              |
| VELandUse          | [Calculate4DMeasures](#calculate4dmeasures)     |**D1B** | Gross population density (people/acre) on unprotected (i.e. developable) land in zone    |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**HHSize**    | Number of persons in the household        |
| VELandUse    | [AssignLocTypes](#assignloctypes) |**LocType**    | Location type (`Urban`, `Town`, `Rural`) of the place where the household resides        |
| VEHouseholdVehicles    | [AssignVehicleOwnership](#assignvehicleownership)     |**Vehicles**   | Number of automobiles and light trucks owned or leased by the household including high level car service vehicles available to driving-age persons           |
| VEHouseholdVehicles    | [AssignDrivers](#assigndrivers)     |**Drivers**   | Number of drivers in household            |
| VESimHouseholds    | [PredictIncome](#predictincome)       |**Income**    | Total annual income of household          |
| VELandUse          | [CalculateUrbanMixMeasure](#calculateurbanmixmeasure)     |**IsUrbanMixNbrhd** | Flag identifying whether household is (`1`) or is not (`0`) in urban mixed-use neighborhood    |
| VEHouseholdTravel          | [CalculateHouseholdDvmt](#CalculateHouseholdDvmt)     |**Dvmt** | Average daily vehicle miles traveled by the household in autos or light trucks    |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**Age0to14**  | Persons in 0 to 14 year old age group     |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**Age15to19** | Persons in 15 to 19 year old age group    |
| VELandUse          | [PredictHousing](#predicthousing)     |**HouseType** | Type of dwelling unit of the household    |


#### Module Outputs
* **PropDvmtDiverted**: Proportion of household DVMT diverted to bicycling, electric bikes, or other 'low-speed' travel modes
* **AveTrpLenDiverted**: Average length in miles of vehicle trips diverted to bicycling, electric bikes, or other 'low-speed' travel modes

For more information see [here](https://github.com/visioneval/VisionEval/blob/master/sources/modules/VEHouseholdTravel/inst/module_docs/DivertSovTravel.md)

[Top](#rspm-modules-and-outputs)

___

### Initialize-vepowertrainsandfuels  
This module processes vehicle and fuel characteristics files that model users may optionally supply. When these files are supplied, modules in the package that compute carbon intensities of vehicle travel will use the user-supplied data instead of the datasets that are part of the package (see the `LoadDefaultValues.R` script).
#### User Input Files
1. Carbon intensity of electricity for `Azone` (**azone_electricity_carbon_intensity.csv**): This input file is OPTIONAL. It is only needed if the user wants to modify the carbon intensity of electricity.

   * **ElectricityCI**: Carbon intensity of electricity at point of consumption (grams CO2e per megajoule)

   Here is a snapshot of the file:
<img align="center" width="200" border=1 src="images/azone_electricity_carbon_intensity.PNG">

2. Average fuel carbon intensity of transit for Marea (**marea_transit_ave_fuel_carbon_intensity.csv**): This input file is OPTIONAL. It is only needed if the user wants to modify the average carbon intensity of fuel used by transit.

   * **TransitVanFuelCI**: Average carbon intensity of fuel used by transit vans (grams CO2e per megajoule)
   * **TransitBusFuelCI**: Average carbon intensity of fuel used by transit buses (grams CO2e per megajoule)
   * **TransitRailFuelCI**: Average carbon intensity of fuel used by transit rail vehicles (grams CO2e per megajoule)

   
   Here is a snapshot of the file:
	<img align="center" width="400" border=1 src="images/marea_transit_ave_fuel_carbon_intensity.PNG">
	
3. Biofuels proportions of transit fuels by `Marea`  (**marea_transit_biofuel_mix.csv**): This input file is OPTIONAL. It is only needed if the user wants to modify the biofuel used by transit services.

   * **TransitEthanolPropGasoline**: Ethanol proportion of gasoline used by transit vehicles
   * **TransitBiodieselPropDiesel**: Biodiesel proportion of diesel used by transit vehicles
   * **TransitRngPropCng**: Renewable natural gas proportion of compressed natural gas used by transit vehicles

   
   Here is a snapshot of the file:
	<img align="center" width="600" border=1 src="images/marea_transit_biofuel_mix.PNG">
	
4. Transit fuels proportions by transit vehicle type and `Marea` (**marea_transit_fuel.csv**): This input file is OPTIONAL. It is only needed if the user wants to modify the transit fuels proportions.

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
	
5. Transit powertrain proportions by transit vehicle type and `Marea` (**marea_transit_powertrain_prop.csv**): This input file is OPTIONAL. It is only needed if the user wants to modify the mixes of transit vehicle powertrains.

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
	
6. Average carbon intensities of fuels by vehicle category for the model region (**region_ave_fuel_carbon_intensity.csv**): This input file is OPTIONAL. It is only needed if the user wants to modify the average carbon density for different vehicle types.

   * **HhFuelCI**: Average carbon intensity of fuels used by household vehicles (grams CO2e per megajoule)
   * **CarSvcFuelCI**: Average carbon intensity of fuels used by car service vehicles (grams CO2e per megajoule)
   * **ComSvcFuelCI**: Average carbon intensity of fuels used by commercial service vehicles (grams CO2e per megajoule)
   * **HvyTrkFuelCI**: Average carbon intensity of fuels used by heavy trucks (grams CO2e per megajoule)
   * **TransitVanFuelCI**: Average carbon intensity of fuels used by transit vans (grams CO2e per megajoule)
   * **TransitBusFuelCI**: Average carbon intensity of fuels used by transit buses (grams CO2e per megajoule)
   * **TransitRailFuelCI**: Average carbon intensity of fuels used by transit rail vehicles (grams CO2e per megajoule)

   Here is a snapshot of the file:	
   <img align="center" width="800" border=1 src="images/region_ave_fuel_carbon_intensity.PNG">
  
7. Car service vehicle powertrain proportions by vehicle type for the model region (**region_carsvc_powertrain_prop.csv**): This input file is OPTIONAL. It is only needed if the user wants to modify the powertrain proportion of car services.

   * **CarSvcAutoPropIcev**: Proportion of car service automobile travel powered by internal combustion engine powertrains
   * **CarSvcAutoPropHev**: Proportion of car service automobile travel powered by hybrid electric powertrains
   * **CarSvcAutoPropBev**: Proportion of car service automobile travel powered by battery electric powertrains
   * **CarSvcLtTrkPropIcev**: Proportion of car service light truck travel powered by internal combustion engine powertrains
   * **CarSvcLtTrkPropHev**: Proportion of car service light truck travel powered by hybrid electric powertrains
   * **CarSvcLtTrkPropBev**: Proportion of car service light truck travel powered by battery electric powertrains
   
   Here is a snapshot of the file:	
   <img align="center" width="800" border=1 src="images/region_carsvc_powertrain_prop.PNG">
  
8. Commercial service vehicle powertrain proportions by vehicle type (**region_comsvc_powertrain_prop.csv**): This input file is OPTIONAL. It is only needed if the user wants to modify the powertrain proportion of commercial vehicles.

   * **ComSvcAutoPropIcev**: Proportion of commercial service automobile travel powered by internal combustion engine powertrains
   * **ComSvcAutoPropHev**: Proportion of commercial service automobile travel powered by hybrid electric powertrains
   * **ComSvcAutoPropBev**: Proportion of commercial service automobile travel powered by battery electric powertrains
   * **ComSvcLtTrkPropIcev**: Proportion of commercial service light truck travel powered by internal combustion engine powertrains
   * **ComSvcLtTrkPropHev**: Proportion of commercial service light truck travel powered by hybrid electric powertrains
   * **ComSvcLtTrkPropBev**: Proportion of commercial service light truck travel powered by battery electric powertrainss

   
   Here is a snapshot of the file:	
<img align="center" width="800" border=1 src="images/region_comsvc_powertrain_prop.PNG">

9. Heavy duty truck powertrain proportions (**region_hvytrk_powertrain_prop.csv**): This input file is OPTIONAL. It is only needed if the user wants to modify the powertrain proportion of heavy duty trucks.

   * **HvyTrkPropIcev**: Proportion of heavy truck travel powered by internal combustion engine powertrains
   * **HvyTrkPropHev**: Proportion of heavy truck travel powered by hybrid electric powertrains
   * **HvyTrkPropBev**: Proportion of heavy truck travel powered by battery electric powertrains
	
   Here is a snapshot of the file:	
	<img align="center" width="400" border=1 src="images/region_hvytrk_powertrain_prop.PNG">
	

#### Internal Module Inputs

This module uses no datasets that are in the datastore.

#### Module Outputs

This module produces no datasets to store in the datastore.

For more information see [here](https://github.com/visioneval/VisionEval/blob/master/sources/modules/VEPowertrainsAndFuels/inst/module_docs/Initialize.md)

[Top](#rspm-modules-and-outputs)

___

### CalculateCarbonIntensity     
This module calculates the average carbon intensity of fuels (grams CO2e per megajoule) by transportation mode and vehicle type. The transportation modes and vehicle types are:

|Mode               |Vehicle Types           |
|-------------------|------------------------|
|Household          |automobile, light truck |
|Car Service        |automobile, light truck |
|Commercial Service |automobile, light truck |
|Heavy Truck        |heavy truck             |
|Public Transit     |van, bus, rail          |

Average fuel carbon intensities for public transit vehicles are calculated by `Marea`. The average fuel carbon intensities for the other mode vehicles are calculated for the entire model region. The module also calculates the average carbon intensity of electricity at the `Azone` level. Note that this module uses the user input files only if the user runs [Initialize](#initialize) module. Otherwise the module uses default inputs in the [inst\extdata folder](https://github.com/visioneval/VisionEval/tree/master/sources/modules/VEPowertrainsAndFuels/inst/extdata). 

#### User Input Files
1. Carbon intensity of electricity for `Azone` (**azone_electricity_carbon_intensity.csv**): This input file is OPTIONAL. It is only needed if the user wants to modify the carbon intensity of electricity.

   * **ElectricityCI**: Carbon intensity of electricity at point of consumption (grams CO2e per megajoule)

   Here is a snapshot of the file:
<img align="center" width="200" border=1 src="images/azone_electricity_carbon_intensity.PNG">

2. Biofuels proportions of transit fuels by `Marea`  (**marea_transit_biofuel_mix.csv**): This input file is OPTIONAL. It is only needed if the user wants to modify the biofuel used by transit services.

   * **TransitEthanolPropGasoline**: Ethanol proportion of gasoline used by transit vehicles
   * **TransitBiodieselPropDiesel**: Biodiesel proportion of diesel used by transit vehicles
   * **TransitRngPropCng**: Renewable natural gas proportion of compressed natural gas used by transit vehicles

   
   Here is a snapshot of the file:
<img align="center" width="600" border=1 src="images/marea_transit_biofuel_mix.PNG">

3. Transit fuels proportions by transit vehicle type and Marea (**marea_transit_fuel.csv**): This input file is OPTIONAL. It is only needed if the user wants to modify the transit fuels proportions.

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

4. Average carbon intensities of fuels by vehicle category for the model region  (**region_ave_fuel_carbon_intensity.csv**): This input file is OPTIONAL. It is only needed if the user wants to modify the average carbon density for different vehicle types.

   * **HhFuelCI**: Average carbon intensity of fuels used by household vehicles (grams CO2e per megajoule)
   * **CarSvcFuelCI**: Average carbon intensity of fuels used by car service vehicles (grams CO2e per megajoule)
   * **ComSvcFuelCI**: Average carbon intensity of fuels used by commercial service vehicles (grams CO2e per megajoule)
   * **HvyTrkFuelCI**: Average carbon intensity of fuels used by heavy trucks (grams CO2e per megajoule)
   * **TransitVanFuelCI**: Average carbon intensity of fuels used by transit vans (grams CO2e per megajoule)
   * **TransitBusFuelCI**: Average carbon intensity of fuels used by transit buses (grams CO2e per megajoule)
   * **TransitRailFuelCI**: Average carbon intensity of fuels used by transit rail vehicles (grams CO2e per megajoule)

   Here is a snapshot of the file:	
 <img align="center" width="800" border=1 src="images/region_ave_fuel_carbon_intensity.PNG">

#### Internal Module Inputs
This module does not have any internal module inputs


#### Module Outputs
* **ElectricityCI**: Carbon intensity of electricity at point of consumption (grams CO2e per megajoule)
* **HhAutoFuelCI**: Average carbon intensity of fuels used by household automobiles (grams CO2e per megajoule)
* **HhLtTrkFuelCI**: Average carbon intensity of fuels used by household light trucks (grams CO2e per megajoule)
* **CarSvcAutoFuelCI**: Average carbon intensity of fuels used by car service automobiles (grams CO2e per megajoule)
* **CarSvcLtTrkFuelCI**: Average carbon intensity of fuels used by car service light trucks (grams CO2e per megajoule)
* **ComSvcAutoFuelCI**: Average carbon intensity of fuels used by commercial service automobiles (grams CO2e per megajoule)
* **ComSvcLtTrkFuelCI**: Average carbon intensity of fuels used by commercial service light trucks (grams CO2e per megajoule)
* **HvyTrkFuelCI**: Average carbon intensity of fuels used by heavy trucks (grams CO2e per megajoule)
* **TransitVanFuelCI**: Average carbon intensity of fuel used by transit vans (grams CO2e per megajoule)
* **TransitBusFuelCI**: Average carbon intensity of fuel used by transit buses (grams CO2e per megajoule)
* **TransitRailFuelCI**: Average carbon intensity of fuel used by transit rail vehicles (grams CO2e per megajoule)

For more information see [here](https://github.com/visioneval/VisionEval/blob/master/sources/modules/VEPowertrainsAndFuels/inst/module_docs/CalculateCarbonIntensity.md)

[Top](#rspm-modules-and-outputs)

___

### AssignHhVehiclePowertrain     
This module assigns a powertrain type to each household vehicle. The powertrain types are internal combustion engine vehicle (ICEV), hybrid electric vehicle (HEV), plug-in hybrid electric vehicle (PHEV), and battery electric vehicles (BEV). The module also assigns related characteristics to household vehicles including:

* Battery range (for PHEV and BEV)

* Miles per gallon (MPG) and gallons per mile (GPM)

* Miles per kilowatt-hour (MPKWH) and kilowatt-hours per mile (KWHPM)

* Miles per gasoline gallon equivalent (MPGe)

* The proportion of DVMT powered by electricity

* Carbon dioxide equivalent emissions per mile powered by hydrocarbon fuel

* Carbon dioxide equivalent emissions per mile powered by electricity

#### User Input Files
1. Charging availability for `Azone` (**azone_charging_availability.csv**): This input file supplies data on proportion of different household types who has available charging 

   * **PropSFChargingAvail**: Proportion of single-family dwellings in Azone that have PEV charging facilties installed or able to be installed
   * **PropMFChargingAvail**: Proportion of multi-family dwelling units in Azone that have PEV charging facilities available
   * **PropGQChargingAvail**: Proportion of group quarters dwelling units in Azone that have PEV charging facilities available
   
   Here is a snapshot of the file:	
<img align="center" width="500" border=1 src="images/azone_charging_availability.PNG">


2. Car service vehicle powertrain proportions by vehicle type for the model region (**region_carsvc_powertrain_prop.csv**): This input file is OPTIONAL. It is only needed if the user wants to modify the powertrain proportion of car services.

   * **CarSvcAutoPropIcev**: Proportion of car service automobile travel powered by internal combustion engine powertrains
   * **CarSvcAutoPropHev**: Proportion of car service automobile travel powered by hybrid electric powertrains
   * **CarSvcAutoPropBev**: Proportion of car service automobile travel powered by battery electric powertrains
   * **CarSvcLtTrkPropIcev**: Proportion of car service light truck travel powered by internal combustion engine powertrains
   * **CarSvcLtTrkPropHev**: Proportion of car service light truck travel powered by hybrid electric powertrains
   * **CarSvcLtTrkPropBev**: Proportion of car service light truck travel powered by battery electric powertrains
   
   Here is a snapshot of the file:	
 <img align="center" width="800" border=1 src="images/region_carsvc_powertrain_prop.PNG">


#### Internal Module Inputs
|    Package         |      Module                           |   Outputs    | Description                               |
|--------------------|---------------------------------------|--------------|-------------------------------------------|
| VEPowertrainsAndFuels    | [CalculateCarbonIntensity](#calculatecarbonintensity) |**ElectricityCI**      | Carbon intensity of electricity at point of consumption (grams CO2e per megajoule)                             |
| VEPowertrainsAndFuels    | [CalculateCarbonIntensity](#calculatecarbonintensity) |**HhAutoFuelCI**  | Average carbon intensity of fuels used by household automobiles (grams CO2e per megajoule))     |
| VEPowertrainsAndFuels    | [CalculateCarbonIntensity](#calculatecarbonintensity) |**HhLtTrkFuelCI** | Average carbon intensity of fuels used by household light trucks (grams CO2e per megajoule)    |
| VEPowertrainsAndFuels          | [CalculateCarbonIntensity](#calculatecarbonintensity)     |**CarSvcAutoFuelCI** | Average carbon intensity of fuels used by car service automobiles (grams CO2e per megajoule)    |
| VEPowertrainsAndFuels          | [CalculateCarbonIntensity](#calculatecarbonintensity)     |**CarSvcLtTrkFuelCI** | Average carbon intensity of fuels used by car service light trucks (grams CO2e per megajoule)   |
ESimHouseholds    | [CreateHouseholds](#createhouseholds) |**HhId**      | Household id                              |
| VELandUse    | [AssignLocTypes](#assignloctypes) |**LocType**    | Location type (Urban, Town, Rural) of the place where the household resides        |
| VEHouseholdVehicles    | [AssignVehicleOwnership](#assignvehicleownership)     |**Vehicles**   | Number of automobiles and light trucks owned or leased by the household including high level car service vehicles available to driving-age persons           |
| VEHouseholdVehicles    | [AssignVehicleType](#assignvehicletype) |**NumAuto**      | Number of automobiles (i.e. 4-tire passenger vehicles that are not light trucks) owned or leased by household                              |
| VEHouseholdVehicles    | [AssignVehicleType](#assignvehicletype) |**NumLtTrk**      | Number of light trucks (pickup, sport-utility vehicle, and van) owned or leased by household                             |
| VELandUse          | [PredictHousing](#predicthousing)     |**HouseType** | Type of dwelling unit of the household    |
| VEHouseholdTravel          | [CalculateHouseholdDvmt](#CalculateHouseholdDvmt)     |**Dvmt** | Average daily vehicle miles traveled by the household in autos or light trucks    |
| VEHouseholdVehicles    | [CreateVehicleTable ](#createvehicletable ) |**VehId**      |  Unique vehicle ID                             |
| VEHouseholdVehicles    | [AssignVehicleAge ](#assignvehicleage ) |**Type**      |  Vehicle body type: Auto = automobile, LtTrk = light trucks (i.e. pickup, SUV, Van)                             |
| VEHouseholdVehicles    | [AssignVehicleAge ](#assignvehicleage ) |**Age**      |  Vehicle age in years                             |
| VEHouseholdVehicles    | [CreateVehicleTable](#createvehicletable) |**VehicleAccess**      | Identifier whether vehicle is owned by household (Own), if vehicle is low level car service (LowCarSvc), or if vehicle is high level car service (HighCarSvc)                             |


#### Module Outputs
* **Powertrain**: Vehicle powertrain type: ICEV = internal combustion engine vehicle, HEV = hybrid electric vehicle, PHEV = plug-in hybrid electric vehicle, BEV = battery electric vehicle, NA = not applicable because is a car service vehicle
* **BatRng**: Miles of travel possible on fully charged battery
* **MPG**: Average miles of vehicle travel powered by fuel per gasoline equivalent gallon
* **GPM**: Average gasoline equivalent gallons per mile of vehicle travel powered by fuel
* **MPKWH**: Average miles of vehicle travel powered by electricity per kilowatt-hour
* **KWHPM**: Average kilowatt-hours per mile of vehicle travel powered by electricity
* **MPGe**: Average miles of vehicle travel per gasoline equivalent gallon (fuel and electric powered)
* **ElecDvmtProp**: Average miles of vehicle travel per gasoline equivalent gallon (fuel and electric powered)
* **FuelCO2ePM**: Average grams of carbon-dioxide equivalents produced per mile of travel powered by fuel
* **ElecCO2ePM**: Average grams of carbon-dioxide equivalents produced per mile of travel powered by electricity




For more information see [here](https://github.com/visioneval/VisionEval/blob/master/sources/modules/VEPowertrainsAndFuels/inst/module_docs/AssignHhVehiclePowertrain.md)

[Top](#rspm-modules-and-outputs)


___


### Initialize-vetravelperformance    
This module reads and processes roadway DVMT and operations inputs.
The following input files are optional. If these data are not provided, the model calculates values based on default data included with the package and processed by the `LoadDefaultRoadDvmtValues.R` script.

#### User Input Files
1. Base year highway truck dvmt for region (**region_base_year_hvytrk_dvmt.csv**): This input file is OPTIONAL. It is only needed if the user wants to adjust heavy truck dvmt for base year

   * **HvyTrkDvmtGrowthBasis**: Factor used to grow heavy truck DVMT from base year value
   * **HvyTrkDvmt**: Average daily vehicle miles of travel on roadways in the region by heavy trucks during he base year
   * **HvyTrkDvmtUrbanProp**: Proportion of Region heavy truck daily vehicle miles of travel occurring on urbanized area roadways
   
   

   Here is a snapshot of the file:	
<img align="center" width="600" border=1 src="images/region_base_year_hvytrk_dvmt.PNG">

2. Base year dvmt for Marea (**marea_base_year_dvmt.csv**): This input file is OPTIONAL. It is only needed if the user wants to modify the adjust dvmt growth factors from base year in by Marea

   * **ComSvcDvmtGrowthBasis**: Factor used to grow commercial service vehicle DVMT in Marea from base year value
   * **HvyTrkDvmtGrowthBasis**: Factor used to grow heavy truck DVMT from base year value
   * **UrbanLdvDvmt**: Average daily vehicle miles of travel on roadways in the urbanized portion of the Marea by light-duty vehicles during the base year
   * **UrbanHvyTrkDvmt**: Average daily vehicle miles of travel on roadways in the urbanized portion of the Marea by heavy trucks during he base year

   
   Here is a snapshot of the file:	
	<img align="center" width="800" border=1 src="images/marea_base_year_dvmt.PNG">
	
3. DVMT split by road class by Marea  (**marea_dvmt_split_by_road_class.csv**): This input file is OPTIONAL. It is only needed if the user wants to modify the dvmt split for different road classes.

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
	
4. Operations deployment effects on dvmt for Marea (**marea_operations_deployment.csv**): This input file is OPTIONAL. It is only needed if the user wants to modify the proportion of dvmt affected by operations for different road classes.

   * **RampMeterDeployProp**: Proportion of freeway DVMT affected by ramp metering deployment
   * **IncidentMgtDeployProp**: Proportion of freeway DVMT affected by incident management deployment
   * **SignalCoordDeployProp**: Proportion of arterial DVMT affected by signal coordination deployment
   * **AccessMgtDeployProp**: Proportion of arterial DVMT affected by access management deployment
   * **OtherFwyOpsDeployProp**: Proportion of freeway DVMT affected by deployment of other user-defined freeway operations measures
   * **OtherArtOpsDeployProp**: Proportion of arterial DVMT affected by deployment of other user-defined arterial operations measures

   Here is a snapshot of the file:	
	<img align="center" width="1200" border=1 src="images/marea_operations_deployment.PNG">
	
5. Other operations effects (**other_ops_effectiveness.csv**): This input file is OPTIONAL. It is only needed if the user wants to modify the other delay effects of operations in different road classes

   * **Level**: Congestion levels: None = none, Mod = moderate, Hvy = heavy, Sev = severe, Ext = extreme
   * **Art_Rcr**: Percentage reduction of recurring arterial delay that would occur with full deployment of other user-defined arterial operations measures
   * **Art_NonRcr**: Percentage reduction of non-recurring arterial delay that would occur with full deployment of other user-defined arterial operations measures
   * **Fwy_Rcr**: Percentage reduction of recurring freeway delay that would occur with full deployment of other user-defined freeway operations measures
   * **Fwy_NonRcr**: Percentage reduction of non-recurring freeway delay that would occur with full deployment of other user-defined freeway operations measures
   
   Here is a snapshot of the file:	
	<img align="center" width="500" border=1 src="images/other_ops_effectiveness.PNG">
	
6. Charges by congestion levels by road class for Marea  (**marea_congestion_charges.csv**): This input file is OPTIONAL. It is only needed if the user wants to modify the charges of vehicle travel for different congestion levels

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

   

	​	

#### Internal Module Inputs

This module uses no datasets that are in the datastore.


#### Module Outputs

This module produces no datasets to store in the datastore.



[Top](#rspm-modules-and-outputs)

___

### CalculateBaseRoadDvmt     
This module calculates base year roadway DVMT by vehicle type (light-duty, heavy truck, bus) and the distribution of roadway DVMT by vehicle type to roadway classes (freeway, arterial, other)
This module uses optional user inputs if [Initialize](#initialize-vetravelperformance) module is run. Otherwise, it uses default data in [inst\extdata folder](https://github.com/visioneval/VisionEval/tree/develop/sources/modules/VETravelPerformance/inst/extdata)

#### User Input Files
1. Base year highway truck dvmt for region (**region_base_year_hvytrk_dvmt.csv**): This input file is OPTIONAL. It is only needed if the user wants to adjust heavy truck dvmt for base year

   * **HvyTrkDvmtGrowthBasis**: Factor used to grow heavy truck DVMT from base year value
   * **HvyTrkDvmt**: Average daily vehicle miles of travel on roadways in the region by heavy trucks during he base year
   * **HvyTrkDvmtUrbanProp**: Proportion of Region heavy truck daily vehicle miles of travel occurring on urbanized area roadways
   
   

   Here is a snapshot of the file:	
<img align="center" width="600" border=1 src="images/region_base_year_hvytrk_dvmt.PNG">

2. Base year dvmt for Marea (*marea_base_year_dvmt.csv**): This input file is OPTIONAL. It is only needed if the user wants to modify the adjust dvmt growth factors from base year in by Marea

   * **ComSvcDvmtGrowthBasis**: Factor used to grow commercial service vehicle DVMT in Marea from base year value
   * **HvyTrkDvmtGrowthBasis**: Factor used to grow heavy truck DVMT from base year value
   * **UrbanLdvDvmt**: Average daily vehicle miles of travel on roadways in the urbanized portion of the Marea by light-duty vehicles during the base year
   * **UrbanHvyTrkDvmt**: Average daily vehicle miles of travel on roadways in the urbanized portion of the Marea by heavy trucks during he base year

   
   Here is a snapshot of the file:	
<img align="center" width="800" border=1 src="images/marea_base_year_dvmt.PNG">

3. DVMT split by road class by Marea  (**marea_dvmt_split_by_road_class.csv**): This input file is OPTIONAL. It is only needed if the user wants to modify the dvmt split for different road classes.

   * **LdvFwyArtDvmtProp**: Proportion of light-duty daily vehicle miles of travel in the urbanized portion of the Marea occurring on freeway or arterial roadways
   * **LdvOthDvmtProp**: Proportion of light-duty daily vehicle miles of travel in the urbanized portion of the Marea occurring on other roadways
   * **HvyTrkFwyDvmtProp**: Proportion of heavy truck daily vehicle miles of travel in the urbanized portion of the Marea occurring on freeways
   * **HvyTrkArtDvmtProp**: Proportion of heavy truck daily vehicle miles of travel in the urbanized portion of the Marea occurring on arterial roadways
   * **HvyTrkOthDvmtProp**: Proportion of heavy truck daily vehicle miles of travel in the urbanized portion of the Marea occurring on other roadways
   * **BusFwyDvmtProp**: Proportion of bus daily vehicle miles of travel in the urbanized portion of the Marea occurring on freeways
   * **BusArtDvmtProp**: Proportion of bus daily vehicle miles of travel in the urbanized portion of the Marea occurring on arterial roadways
   * **BusOthDvmtProp**: Proportion of bus daily vehicle miles of travel in the urbanized portion of the Marea occuring on other roadways

#### Internal Module Inputs
|    Package         |      Module                           |   Outputs    | Description                               |
|--------------------|---------------------------------------|--------------|-------------------------------------------|
| VETransportSupply            | [AssignTransitService](#assigntransitservice) |**VanDvmt**      |  Total daily miles traveled by vans of various sizes to provide demand responsive, vanpool, and similar services                            |
| VETransportSupply            | [AssignTransitService](#assigntransitservice) |**BusDvmt**      | Total daily miles traveled by buses of various sizes to provide bus service of various types                           |
| VETransportSupply            | [AssignTransitService](#assigntransitservice)     |**RailDvmt** | Total daily miles traveled by light rail, heavy rail, commuter rail, and similar types of vehicles   |
| VELandUse          | [AssignLocTypes](#assignloctypes)     |**UrbanPop**  | Urbanized area population                 |
| VELandUse          | [AssignLocTypes](#assignloctypes)     |**RuralPop**  | Rural (i.e. non-urbanized area) population|
| VELandUse          | [AssignLocTypes](assignloctypes)     |**RuralIncome**  | Total household income of the rural (i.e. non-urbanized area) population               |
| VELandUse          | [AssignLocTypes](#assignloctypes)     |**UrbanIncome**  | Total household income of the rural (i.e. non-urbanized area) population|
| VEHouseholdTravel          | [CalculateHouseholdDvmt](#calculatehouseholddvmt)     |**UrbanHhDvmt**  | Average daily vehicle miles traveled in autos or light trucks by households residing in the urbanized portion of the Marea               |
| VEHouseholdTravel          | [CalculateHouseholdDvmt](#calculatehouseholddvmt)     |**RuralHhDvmt**  | Average daily vehicle miles traveled in autos or light trucks by households residing in the rural (non-urban) portion of the Marea|

#### Module Outputs
* **HvyTrkDvmtUrbanProp**: Proportion of Region heavy truck daily vehicle miles of travel occurring on urbanized area roadways
* **HvyTrkDvmtIncomeFactor**: Ratio of Region base year heavy truck DVMT to household income
* **HvyTrkDvmtPopulationFactor**: Ratio of Region base year heavy truck DVMT to population
* **HvyTrkUrbanDvmt**: Base year Region heavy truck daily vehicle miles of travel in urbanized areas
* **HvyTrkRuralDvmt**: Base year Region heavy truck daily vehicle miles of travel in rural (i.e. non-urbanized) areas
* **ComSvcDvmtHhDvmtFactor**: Ratio of Marea base year commercial service DVMT to household DVMT
* **ComSvcDvmtIncomeFactor**: Ratio of base year commercial service vehicle DVMT to household income
* **ComSvcDvmtPopulationFactor**: Ratio of base year commercial service vehicle DVMT to population
* **HvyTrkDvmtPopulationFactor**: Ratio of base year heavy truck DVMT to population
* **LdvRoadDvmtLdvDemandRatio**: Ratio between light-duty vehicle (LDV) daily vehicle miles of travel (DVMT) on urbanized area roadways in the Marea to the total LDV DVMT of households residing in the urbanized area, the commercial service vehicle travel related to household demand, and LDV public transit DVMT.
* **ComSvcUrbanDvmt**: Commercial service daily vehicle miles of travel associated with Marea urbanized household activity
* **ComSvcRuralDvmt**: Commercial service daily vehicle miles of travel associated with Marea rural household activity
* **LdvFwyArtDvmtProp**: Proportion of light-duty daily vehicle miles of travel in the urbanized portion of the Marea occurring on freeway or arterial roadways
* **LdvOthDvmtProp**: Proportion of light-duty daily vehicle miles of travel in the urbanized portion of the Marea occurring on other roadways
* **HvyTrkFwyDvmtProp**: Proportion of heavy truck daily vehicle miles of travel in the urbanized portion of the Marea occurring on freeways
* **HvyTrkArtDvmtProp**: Proportion of heavy truck daily vehicle miles of travel in the urbanized portion of the Marea occurring on arterial roadways
* **HvyTrkOthDvmtProp**: Proportion of heavy truck daily vehicle miles of travel in the urbanized portion of the Marea occurring on other roadways
* **BusFwyDvmtProp**: Proportion of bus daily vehicle miles of travel in the urbanized portion of the Marea occurring on freeways
* **BusArtDvmtProp**: Proportion of bus daily vehicle miles of travel in the urbanized portion of the Marea occurring on arterial roadways
* **BusOthDvmtProp**: Proportion of bus daily vehicle miles of travel in the urbanized portion of the Marea occuring on other roadways
* **LdvFwyArtDvmt**: Light-duty daily vehicle miles of travel in the urbanized portion of the Marea occurring on freeway or arterial roadways
* **LdvOthDvmt**: Light-duty daily vehicle miles of travel in the urbanized portion of the Marea occurring on other roadways
* **HvyTrkFwyDvmt**: Heavy truck daily vehicle miles of travel in the urbanized portion of the Marea occurring on freeways
* **HvyTrkArtDvmt**:Heavy truck daily vehicle miles of travel in the urbanized portion of the Marea occurring on arterial roadways
* **HvyTrkOthDvmt**: Heavy truck daily vehicle miles of travel in the urbanized portion of the Marea occurring on other roadways
* **BusFwyDvmt**: Bus daily vehicle miles of travel in the urbanized portion of the Marea occurring on freeways
* **BusArtDvmt**: Bus daily vehicle miles of travel in the urbanized portion of the Marea occurring on arterial roadways
* **BusOthDvmt**: Bus daily vehicle miles of travel in the urbanized portion of the Marea occuring on other roadways






[Top](#rspm-modules-and-outputs)

___

### CalculateFutureRoadDvmt     
This module calculates future year roadway DVMT by vehicle type (light-duty, heavy truck, bus) and the distribution of roadway DVMT by vehicle type to roadway classes (freeway, arterial, other)
This module uses optional user inputs if [Initialize](#initialize-vetravelperformance) module is run. Otherwise, it uses default data in [inst\extdata folder](https://github.com/visioneval/VisionEval/tree/develop/sources/modules/VETravelPerformance/inst/extdata)

#### User Input Files
1. Base year highway truck dvmt for region (**region_base_year_hvytrk_dvmt.csv**): This input file is OPTIONAL. It is only needed if the user wants to adjust heavy truck dvmt for base year

   * **HvyTrkDvmtGrowthBasis**: Factor used to grow heavy truck DVMT from base year value
   
2. Base year dvmt for Marea (*marea_base_year_dvmt.csv**): This input file is OPTIONAL. It is only needed if the user wants to modify the adjust dvmt growth factors from base year in by Marea

   * **ComSvcDvmtGrowthBasis**: Factor used to grow commercial service vehicle DVMT in Marea from base year value
     

   Here is a snapshot of the file:	
   <img align="center" width="800" border=1 src="images/marea_base_year_dvmt.PNG">


    Here is a snapshot of the file:	
   <img align="center" width="600" border=1 src="images/region_base_year_hvytrk_dvmt.PNG">

#### Internal Module Inputs
|    Package         |      Module                           |   Outputs    | Description                               |
|--------------------|---------------------------------------|--------------|-------------------------------------------|
| VETravelPerformance          | [CalculateBaseRoadDvmt](#calculatebaseroaddvmt)       |**HvyTrkDvmtIncomeFactor**  |  Ratio of Region base year heavy truck DVMT to household income     |
| vetravelperformance          | [CalculateBaseRoadDvmt](#calculatebaseroaddvmt)       |**HvyTrkDvmtUrbanProp** | proportion of region heavy truck daily vehicle miles of travel occurring on urbanized area roadways    |
| VETravelPerformance          | [CalculateBaseRoadDvmt](#calculatebaseroaddvmt)       |**HvyTrkDvmtPopulationFactor** | Ratio of Region base year heavy truck DVMT to population   |
| VETravelPerformance          | [CalculateBaseRoadDvmt](#calculatebaseroaddvmt)       |**LdvFwyArtDvmtProp** |  Proportion of light-duty daily vehicle miles of travel in the urbanized portion of the Marea occurring on freeway or arterial roadways    |
| VETravelPerformance          | [CalculateBaseRoadDvmt](#calculatebaseroaddvmt)       |**LdvOthDvmtProp** | Proportion of light-duty daily vehicle miles of travel in the urbanized portion of the Marea occurring on other roadways    |
| VETravelPerformance          | [CalculateBaseRoadDvmt](#calculatebaseroaddvmt)       |**HvyTrkFwyDvmtProp** | Proportion of heavy truck daily vehicle miles of travel in the urbanized portion of the Marea occurring on freeways  |
| VETravelPerformance          | [CalculateBaseRoadDvmt](#calculatebaseroaddvmt)       |**LdvOthDvmtProp** | Proportion of heavy truck daily vehicle miles of travel in the urbanized portion of the Marea occurring on freeways   |
| VETravelPerformance          | [CalculateBaseRoadDvmt](#calculatebaseroaddvmt)       |**HvyTrkFwyDvmtProp** | Proportion of heavy truck daily vehicle miles of travel in the urbanized portion of the Marea occurring on arterial roadways    |
| VETravelPerformance          | [CalculateBaseRoadDvmt](#calculatebaseroaddvmt)       |**HvyTrkArtDvmtProp** | Proportion of heavy truck daily vehicle miles of travel in the urbanized portion of the Marea occurring on arterial roadways   |
| VETravelPerformance          | [CalculateBaseRoadDvmt](#calculatebaseroaddvmt)       |**HvyTrkOthDvmtProp**      |Proportion of heavy truck daily vehicle miles of travel in the urbanized portion of the Marea occurring on other roadways                             |
| VETravelPerformance          | [CalculateBaseRoadDvmt](#calculatebaseroaddvmt)       |**BusFwyDvmtProp**    |  Proportion of bus daily vehicle miles of travel in the urbanized portion of the Marea occurring on freeways     |
| VETravelPerformance          | [CalculateBaseRoadDvmt](#calculatebaseroaddvmt)       |**BusArtDvmtProp**   | Proportion of bus daily vehicle miles of travel in the urbanized portion of the Marea occurring on arterial roadways         |
| VETravelPerformance            | [CalculateBaseRoadDvmt](#calculatebaseroaddvmt) |**BusOthDvmtProp**      |  Proportion of bus daily vehicle miles of travel in the urbanized portion of the Marea occuring on other roadways                           |
| VETravelPerformance            | [CalculateBaseRoadDvmt](#calculatebaseroaddvmt) |**ComSvcDvmtHhDvmtFactor**      |  Ratio of Marea base year commercial service DVMT to household DVMT                       |
| VETravelPerformance            | [CalculateBaseRoadDvmt](#calculatebaseroaddvmt)     |**ComSvcDvmtIncomeFactor** |  Ratio of base year commercial service vehicle DVMT to household income  |
| VELandUse          | [CalculateBaseRoadDvmt](#calculatebaseroaddvmt)     |**ComSvcDvmtPopulationFactor**  | Ratio of base year commercial service vehicle DVMT to population                 |
| VELandUse          | [CalculateBaseRoadDvmt](#calculatebaseroaddvmt)     |**HvyTrkDvmtPopulationFactor**  | Ratio of base year heavy truck DVMT to population
| VELandUse          | [CalculateBaseRoadDvmt](calculatebaseroaddvmt)     |**LdvRoadDvmtLdvDemandRatio**  | Ratio between light-duty vehicle (LDV) daily vehicle miles of travel (DVMT) on urbanized area roadways in the Marea to the total LDV DVMT of households residing in the urbanized area, the commercial service vehicle travel related to household demand, and LDV public transit DVMT              |
| VETransportSupply            | [AssignTransitService](#assigntransitservice) |**VanDvmt**      |  Total daily miles traveled by vans of various sizes to provide demand responsive, vanpool, and similar services                            |
| VETransportSupply            | [AssignTransitService](#assigntransitservice) |**BusDvmt**      | Total daily miles traveled by buses of various sizes to provide bus service of various types                           |
| VELandUse          | [AssignLocTypes](#assignloctypes)     |**UrbanPop**  | Urbanized area population                 |
| VELandUse          | [AssignLocTypes](#assignloctypes)     |**RuralPop**  | Rural (i.e. non-urbanized area) population|
| VELandUse          | [AssignLocTypes](assignloctypes)     |**RuralIncome**  | Total household income of the rural (i.e. non-urbanized area) population               |
| VELandUse          | [AssignLocTypes](#assignloctypes)     |**UrbanIncome**  | Total household income of the rural (i.e. non-urbanized area) population|
| VEHouseholdTravel          | [CalculateHouseholdDvmt](#calculatehouseholddvmt)     |**UrbanHhDvmt**  | Average daily vehicle miles traveled in autos or light trucks by households residing in the urbanized portion of the Marea               |
| VEHouseholdTravel          | [CalculateHouseholdDvmt](#calculatehouseholddvmt)     |**RuralHhDvmt**  | Average daily vehicle miles traveled in autos or light trucks by households residing in the rural (non-urban) portion of the Marea|

#### Module Outputs
* **HvyTrkUrbanDvmt**: Base year Region heavy truck daily vehicle miles of travel in urbanized areas
* **HvyTrkRuralDvmt**: Base year Region heavy truck daily vehicle miles of travel in rural (i.e. non-urbanized) areas
* **ComSvcUrbanDvmt**: Commercial service daily vehicle miles of travel associated with Marea urbanized household activity
* **ComSvcRuralDvmt**: Commercial service daily vehicle miles of travel associated with Marea rural household activity
* **LdvFwyArtDvmt**: Light-duty daily vehicle miles of travel in the urbanized portion of the Marea occurring on freeway or arterial roadways
* **LdvOthDvmt**: Light-duty daily vehicle miles of travel in the urbanized portion of the Marea occurring on other roadways
* **HvyTrkFwyDvmt**: Heavy truck daily vehicle miles of travel in the urbanized portion of the Marea occurring on freeways
* **HvyTrkArtDvmt**:Heavy truck daily vehicle miles of travel in the urbanized portion of the Marea occurring on arterial roadways
* **HvyTrkOthDvmt**: Heavy truck daily vehicle miles of travel in the urbanized portion of the Marea occurring on other roadways
* **BusFwyDvmt**: Bus daily vehicle miles of travel in the urbanized portion of the Marea occurring on freeways
* **BusArtDvmt**: Bus daily vehicle miles of travel in the urbanized portion of the Marea occurring on arterial roadways
* **BusOthDvmt**: Bus daily vehicle miles of travel in the urbanized portion of the Marea occuring on other roadways






[Top](#rspm-modules-and-outputs)

___

### CalculateRoadPerformance      

This module splits light-duty vehicle (LDV) daily vehicle miles of travel DVHT between freeways and arterials as a function of relative speeds and congestion prices. Speeds and prices are combined to calculate an average 'effective' speed for freeways and for arterials. The ratio of freeway and arterial 'effective' speeds and a split factor calculated for the metropolitan area are used to split the LDV DVMT. Iteration is used to find an equilibrium split value. In addition to the LDV freeway DVMT and arterial DVMT, the following performance measures are saved to the datastore:

* Average freeway speed by congestion level;

* Average arterial speed by congestion level;

* Average freeway delay by congestion level;

* Average arterial delay by congestion level;

* Freeway DVMT proportions by congestion level;

* Arterial DVMT proportions by congestion level;

* Average amount paid per mile in congestion pricing fees; and,

* Vehicle hours of delay by vehicle type.

#### User Input Files
1. Operations deployment effects on dvmt for Marea (**marea_operations_deployment.csv**): This input file is OPTIONAL. It is only needed if the user wants to modify the proportion of dvmt affected by operations for different road classes.

   * **RampMeterDeployProp**: Proportion of freeway DVMT affected by ramp metering deployment
   * **IncidentMgtDeployProp**: Proportion of freeway DVMT affected by incident management deployment
   * **SignalCoordDeployProp**: Proportion of arterial DVMT affected by signal coordination deployment
   * **AccessMgtDeployProp**: Proportion of arterial DVMT affected by access management deployment
   * **OtherFwyOpsDeployProp**: Proportion of freeway DVMT affected by deployment of other user-defined freeway operations measures
   * **OtherArtOpsDeployProp**: Proportion of arterial DVMT affected by deployment of other user-defined arterial operations measures

   Here is a snapshot of the file:	
<img align="center" width="1200" border=1 src="images/marea_operations_deployment.PNG">

2. Other operations effects (**other_ops_effectiveness.csv**): This input file is OPTIONAL. It is only needed if the user wants to modify the other delay effects of operations in different road classes

   * **Level**: Congestion levels: None = none, Mod = moderate, Hvy = heavy, Sev = severe, Ext = extreme
   * **Art_Rcr**: Percentage reduction of recurring arterial delay that would occur with full deployment of other user-defined arterial operations measures
   * **Art_NonRcr**: Percentage reduction of non-recurring arterial delay that would occur with full deployment of other user-defined arterial operations measures
   * **Fwy_Rcr**: Percentage reduction of recurring freeway delay that would occur with full deployment of other user-defined freeway operations measures
   * **Fwy_NonRcr**: Percentage reduction of non-recurring freeway delay that would occur with full deployment of other user-defined freeway operations measures
   
   Here is a snapshot of the file:	
<img align="center" width="500" border=1 src="images/other_ops_effectiveness.PNG">

3. Charges by congestion levels by road class for Marea  (**marea_congestion_charges.csv**): This input file is OPTIONAL. It is only needed if the user wants to modify the charges of vehicle travel for different congestion levels

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


#### User Input Parameters
**Value of time (valueoftime)** : This parameter set the value of time (base cost year dollars per hour).  It should be defined in [model_parameters.json]

   ```json
 {"NAME": "ValueOfTime", 
   "VALUE": "16", 
   "TYPE": "double", 
   "UNITS": "base cost year dollars per hour"
  }
   ```
#### Internal Module Inputs
|    Package         |      Module                           |   Outputs    | Description                               |
|--------------------|---------------------------------------|--------------|-------------------------------------------|
| VELandUse          | [AssignLocTypes](#assignloctypes)     |**UrbanPop**  | Urbanized area population                 |
| VETransportSupply          | [AssignRoadMiles](#assignroadmiles)     |**FwyLaneMi**  | Lane-miles of roadways functionally classified as freeways or expressways in the urbanized portion of the metropolitan area                 |
| VETravelPerformance          | [CalculateBaseRoadDvmt](#calculatebaseroaddvmt)     |**LdvFwyArtDvmt**  | Light-duty daily vehicle miles of travel in the urbanized portion of the Marea occurring on freeway or arterial roadways               |
| VETravelPerformance          | [CalculateBaseRoadDvmt](#calculatebaseroaddvmt)     |**LdvOthDvmt**  | Light-duty daily vehicle miles of travel in the urbanized portion of the Marea occurring on freeway or arterial roadways                 |
| VETravelPerformance          | [CalculateBaseRoadDvmt](#calculatebaseroaddvmt)     |**HvyTrkFwyDvmt**  | Heavy truck daily vehicle miles of travel in the urbanized portion of the Marea occurring on freeways              |
| VETravelPerformance          | [CalculateBaseRoadDvmt](#calculatebaseroaddvmt)     |**HvyTrkArtDvmt**    | Heavy truck daily vehicle miles of travel in the urbanized portion of the Marea occurring on arterial roadways               |
| VETravelPerformance          | [CalculateBaseRoadDvmt](#calculatebaseroaddvmt)     |**HvyTrkOthDvmt**  | Light-duty daily vehicle miles of travel in the urbanized portion of the Marea occurring on other roadways               |
| VETravelPerformance          | [CalculateBaseRoadDvmt](#calculatebaseroaddvmt)     |**BusFwyDvmt**  | Bus daily vehicle miles of travel in the urbanized portion of the Marea occurring on freeways                 |
| VETravelPerformance          | [CalculateBaseRoadDvmt](#calculatebaseroaddvmt)     |**BusArtDvmt**  | Bus daily vehicle miles of travel in the urbanized portion of the Marea occurring on arterial roadways              |
| VETravelPerformance          | [CalculateBaseRoadDvmt](#calculatebaseroaddvmt)     |**BusOthDvmt**    | Bus daily vehicle miles of travel in the urbanized portion of the Marea occuring on other roadways               |
| VELandUse          | [Calculate4DMeasures](#calculate4dmeasures)     |**UrbanArea**  |  Area that is Urban and unprotected (i.e. developable) within the zone              |


#### Module Outputs
* **LdvFwyDvmt**: Light-duty daily vehicle miles of travel in the urbanized portion of the Marea occurring on freeways
* **LdvArtDvmt**: Light-duty daily vehicle miles of travel in the urbanized portion of the Marea occurring on arterial roadways
* **FwyNoneCongSpeed**: Average freeway speed (miles per hour) when there is no congestion
* **FwyModCongSpeed**: Average freeway speed (miles per hour) when congestion is moderate
* **FwyHvyCongSpeed**: Average freeway speed (miles per hour) when congestion is heavy
* **FwySevCongSpeed**: Average freeway speed (miles per hour) when congestion is severe
* **FwyExtCongSpeed**: Average freeway speed (miles per hour) when congestion is extreme
* **ArtNoneCongSpeed**: Average arterial speed (miles per hour) when there is no congestion
* **ArtModCongSpeed**: Average arterial speed (miles per hour) when congestion is moderate
* **ArtHvyCongSpeed**: Average arterial speed (miles per hour) when congestion is heavy
* **ArtSevCongSpeed**: Average arterial speed (miles per hour) when congestion is severe
* **ArtExtCongSpeed**: Average arterial speed (miles per hour) when congestion is extreme
* **OthSpd**: Average speed (miles per hour) on other roadways
* **LdvAveSpeed**: Average light-duty vehicle speed (miles per hour) on all roadways weighted by the proportions of light-duty vehicle travel
* **FwyNoneCongDelay**: Average freeway delay (hours per mile) occurring when there is no congestion
* **FwyModCongDelay**: Average freeway delay (hours per mile) occurring when congestion is moderate
* **FwyHvyCongDelay**: Average freeway delay (hours per mile) occurring when congestion is heavy
* **FwySevCongDelay**: Average freeway delay (hours per mile) occurring when congestion is severe
* **FwyExtCongDelay**: Average freeway delay (hours per mile) occurring when congestion is extreme
* **ArtNoneCongDelay**: Average arterial delay (hours per mile) occurring when there is no congestion
* **ArtModCongDelay**: Average arterial delay (hours per mile) occurring when congestion is moderate
* **ArtHvyCongDelay**: Average arterial delay (hours per mile) occurring when congestion is heavy
* **ArtSevCongDelay**: Average arterial delay (hours per mile) occurring when congestion is severe
* **ArtExtCongDelay**: Average arterial delay (hours per mile) occurring when congestion is extreme
* **FwyDvmtPropNoneCong**: Proportion of freeway DVMT occurring when there is no congestion
* **FwyDvmtPropModCong**: Proportion of freeway DVMT occurring when congestion is moderate
* **FwyDvmtPropHvyCong**: Proportion of freeway DVMT occurring when congestion is heavy
* **FwyDvmtPropSevCong**: Proportion of freeway DVMT occurring when congestion is severe
* **FwyDvmtPropExtCong**: Proportion of freeway DVMT occurring when congestion is extreme
* **ArtDvmtPropNoneCong**: Proportion of arterial DVMT occurring when there is no congestion
* **ArtDvmtPropModCong**: Proportion of arterial DVMT occurring when congestion is moderate
* **ArtDvmtPropHvyCong**: Proportion of arterial DVMT occurring when congestion is heavy
* **ArtDvmtPropSevCong**: Proportion of arterial DVMT occurring when congestion is severe
* **ArtDvmtPropExtCong**: Proportion of arterial DVMT occurring when congestion is extreme
* **AveCongPrice**: Average price paid (dollars per mile) in congestion fees

For more information see [here](https://github.com/visioneval/VisionEval/blob/master/sources/modules/VETravelPerformance/inst/module_docs/CalculateRoadPerformance.md)


[Top](#rspm-modules-and-outputs)

___

### CalculateMpgMpkwhAdjustments      

This module calculates adjustments to fuel economy and electric energy economy for plug-in vehicles) resulting from traffic congestion, speed smoothing(i.e. active traffic management which reduces speed variation), and ecodriving practices.

#### User Input Files
1. Speed smoothing and ecodriving for Marea (**marea_speed_smooth_ecodrive.csv**): This input file supplies information of deployment of speed smoothing and ecodriving by road class and vehicle type

   * **FwySmooth**:Fractional deployment of speed smoothing traffic management on freeways, where 0 is no deployment and 1 is the full potential fuel savings
   * **ArtSmooth**: Fractional deployment of speed smoothing traffic management on arterials, where 0 is no deployment and 1 is the full potential fuel savings
   * **LdvEcoDrive**: Eco-driving penetration for light-duty vehicles; the fraction of vehicles from 0 to 1
   * **HvyTrkEcoDrive**: Eco-driving penetration for heavy-duty vehicles; the fraction of vehicles from 0 to 1
   
   Here is a snapshot of the file:	
<img align="center" width="600" border=1 src="images/marea_speed_smooth_ecodrive.PNG">

#### Internal Module Inputs
|    Package         |      Module                           |   Outputs    | Description                               |
|--------------------|---------------------------------------|--------------|-------------------------------------------|
| VETravelPerformance          | [CalculateRoadPerformance](#calculateroadperformance)     |**LdvFwyDvmt**  | Light-duty daily vehicle miles of travel in the urbanized portion of the Marea occurring on freeways                |
| VETravelPerformance          | [CalculateRoadPerformance](#calculateroadperformance)     |**LdvArtDvmt**  | Light-duty daily vehicle miles of travel in the urbanized portion of the Marea occurring on arterial roadways               |
| VETravelPerformance          | [CalculateBaseRoadDvmt](#calculatebaseroaddvmt)     |**LdvOthDvmt**  | Light-duty daily vehicle miles of travel in the urbanized portion of the Marea occurring on freeway or arterial roadways                 |
| VETravelPerformance          | [CalculateBaseRoadDvmt](#calculatebaseroaddvmt)     |**HvyTrkFwyDvmt**  | Heavy truck daily vehicle miles of travel in the urbanized portion of the Marea occurring on freeways              |
| VETravelPerformance          | [CalculateBaseRoadDvmt](#calculatebaseroaddvmt)     |**HvyTrkArtDvmt**    | Heavy truck daily vehicle miles of travel in the urbanized portion of the Marea occurring on arterial roadways               |
| VETravelPerformance          | [CalculateBaseRoadDvmt](#calculatebaseroaddvmt)     |**HvyTrkOthDvmt**  | Light-duty daily vehicle miles of travel in the urbanized portion of the Marea occurring on other roadways               |
| VETravelPerformance          | [CalculateBaseRoadDvmt](#calculatebaseroaddvmt)     |**BusFwyDvmt**  | Bus daily vehicle miles of travel in the urbanized portion of the Marea occurring on freeways                 |
| VETravelPerformance          | [CalculateBaseRoadDvmt](#calculatebaseroaddvmt)     |**BusArtDvmt**  | Bus daily vehicle miles of travel in the urbanized portion of the Marea occurring on arterial roadways              |
| VETravelPerformance          | [CalculateBaseRoadDvmt](#calculatebaseroaddvmt)     |**BusOthDvmt**    | Bus daily vehicle miles of travel in the urbanized portion of the Marea occuring on other roadways               |
| VETravelPerformance          | [CalculateRoadPerformance](#calculateroadperformance)     |**FwyNoneCongSpeed**  | Average freeway speed (miles per hour) when there is no congestion              |
| VETravelPerformance          | [CalculateRoadPerformance](#calculateroadperformance)     |**FwyModCongSpeed**  | Light-duty daily vehicle miles of travel in the urbanized portion of the Marea occurring on arterial roadways                |
| VETravelPerformance          | [CalculateRoadPerformance](#calculateroadperformance)     |**FwyHvyCongSpeed**  | Average freeway speed (miles per hour) when congestion is heavy              |
| VETravelPerformance          | [CalculateRoadPerformance](#calculateroadperformance)     |**FwySevCongSpeed**    | Average freeway speed (miles per hour) when congestion is severe              |
| VETravelPerformance          | [CalculateRoadPerformance](#calculateroadperformance)     |**FwyExtCongSpeed**  | Light-duty daily vehicle miles of travel in the urbanized portion of the Marea occurring on other roadways               |
| VETravelPerformance          | [CalculateRoadPerformance](#calculateroadperformance)     |**BusFwyDvmt**  | Bus daily vehicle miles of travel in the urbanized portion of the Marea occurring on freeways                 |
| VETravelPerformance          | [CalculateRoadPerformance](#calculateroadperformance)     |**BusArtDvmt**  | Bus daily vehicle miles of travel in the urbanized portion of the Marea occurring on arterial roadways              |
| VETravelPerformance          | [CalculateRoadPerformance](#calculateroadperformance)     |**BusOthDvmt**    | Bus daily vehicle miles of travel in the urbanized portion of the Marea occuring on other roadways               |
| VETravelPerformance          | [CalculateRoadPerformance](#calculateroadperformance)     |**FwyDvmtPropNoneCong**  | Proportion of freeway DVMT occurring when there is no congestion                 |
| VETravelPerformance          | [CalculateRoadPerformance](#calculateroadperformance)     |**FwyDvmtPropModCong**  | Proportion of freeway DVMT occurring when congestion is moderate                |
| VETravelPerformance          | [CalculateRoadPerformance](#calculateroadperformance)     |**FwyDvmtPropHvyCong**  |Proportion of freeway DVMT occurring when congestion is heavy                 |
| VETravelPerformance          | [CalculateRoadPerformance](#calculateroadperformance)     |**FwyDvmtPropSevCong**    | Proportion of freeway DVMT occurring when congestion is severe                   |
| VETravelPerformance          | [CalculateRoadPerformance](#calculateroadperformance)     |**FwyDvmtPropExtCong**  | Proportion of freeway DVMT occurring when congestion is extreme                  |
| VETravelPerformance          | [CalculateRoadPerformance](#calculateroadperformance)     |**ArtDvmtPropNoneCong**  | Proportion of arterial DVMT occurring when there is no congestion               |
| VETravelPerformance          | [CalculateRoadPerformance](#calculateroadperformance)     |**ArtDvmtPropModCong**  | Proportion of arterial DVMT occurring when congestion is moderate                |
| VETravelPerformance          | [CalculateRoadPerformance](#calculateroadperformance)     |**ArtDvmtPropHvyCong**  | Proportion of arterial DVMT occurring when congestion is heavy               |
| VETravelPerformance          | [CalculateRoadPerformance](#calculateroadperformance)     |**ArtDvmtPropSevCong**  |  Proportion of arterial DVMT occurring when congestion is severe               |
| VETravelPerformance          | [CalculateRoadPerformance](#calculateroadperformance)     |**ArtDvmtPropExtCong**    |  Proportion of arterial DVMT occurring when congestion is extereme             |


#### Module Outputs
* **LdvSpdSmoothFactor**: Proportional adjustment of light-duty internal combustion engine (ICE) vehicle MPG due to speed smoothing
* **HvyTrkSpdSmoothFactor**: Proportional adjustment of heavy truck internal combustion engine (ICE) vehicle MPG due to speed smoothing
* **BusSpdSmoothFactor**: Proportional adjustment of bus internal combustion engine (ICE) vehicle MPG due to speed smoothing
* **LdvEcoDriveFactor**: Proportional adjustment of light-duty internal combustion engine (ICE) vehicle MPG due to eco-driving
* **HvyTrkEcoDriveFactor**: Proportional adjustment of heavy truck internal combustion engine (ICE) vehicle MPG due to eco-driving
* **BusEcoDriveFactor**: Proportional adjustment of bus internal combustion engine (ICE) vehicle MPG due to eco-driving
* **LdIceFactor**: Proportional adjustment of light-duty internal combustion engine (ICE) vehicle MPG due to congestion
* **LdHevFactor**: Proportional adjustment of light-duty hybrid-electric vehicle (HEV) MPG due to congestion
* **LdEvFactor**: Proportional adjustment of light-duty battery electric vehicle (EV) MPkWh due to congestion
* **LdFcvFactor**: Proportional adjustment of light-duty fuel cell vehicle (FCV) MPkWh due to congestion
* **HdIceFactor**: Proportional adjustment of heavy-duty internal combustion engine (ICE) vehicle MPG due to congestion




[Top](#rspm-modules-and-outputs)

___

### AdjustHhVehicleMpgMpkwh      

This module adjusts the fuel economy and power efficiency of household vehicles to reflect roadway congestion.
#### User Input Files
1. Car service vehicle powertrain proportions by vehicle type for the model region (**region_carsvc_powertrain_prop.csv**): This input file is OPTIONAL. It is only needed if the user wants to modify the powertrain proportion of car services.

   * **CarSvcAutoPropIcev**: Proportion of car service automobile travel powered by internal combustion engine powertrains
   * **CarSvcAutoPropHev**: Proportion of car service automobile travel powered by hybrid electric powertrains
   * **CarSvcAutoPropBev**: Proportion of car service automobile travel powered by battery electric powertrains
   * **CarSvcLtTrkPropIcev**: Proportion of car service light truck travel powered by internal combustion engine powertrains
   * **CarSvcLtTrkPropHev**: Proportion of car service light truck travel powered by hybrid electric powertrains
   * **CarSvcLtTrkPropBev**: Proportion of car service light truck travel powered by battery electric powertrains
   
   Here is a snapshot of the file:	
 <img align="center" width="800" border=1 src="images/region_carsvc_powertrain_prop.PNG">

#### Internal Module Inputs
|    Package         |      Module                           |   Outputs    | Description                               |
|--------------------|---------------------------------------|--------------|-------------------------------------------|
| VETravelPerformance          | [CalculateMpgMpkwhAdjustments](#calculatempgmpkwhadjustments)     |**LdvEcoDrive**  | Eco-driving penetration for light-duty vehicles; the fraction of vehicles from 0 to 1               |
| VETravelPerformance          | [CalculateMpgMpkwhAdjustments](#calculatempgmpkwhadjustments)     |**LdvSpdSmoothFactor**  | Proportional adjustment of light-duty internal combustion engine (ICE) vehicle MPG due to speed smoothing            |
| VETravelPerformance          | [CalculateMpgMpkwhAdjustments](#calculatempgmpkwhadjustments)     |**LdvEcoDriveFactor**    |Proportional adjustment of light-duty internal combustion engine (ICE) vehicle MPG due to eco-driving             |
| VETravelPerformance          | [CalculateMpgMpkwhAdjustments](#calculatempgmpkwhadjustments)     |**LdIceFactor**  | Proportional adjustment of light-duty internal combustion engine (ICE) vehicle MPG due to congestion               |
| VETravelPerformance          | [CalculateMpgMpkwhAdjustments](#calculatempgmpkwhadjustments)     |**LdHevFactor**  | Proportional adjustment of light-duty hybrid-electric vehicle (HEV) MPG due to congestion                 |
| VETravelPerformance          | [CalculateMpgMpkwhAdjustments](#calculatempgmpkwhadjustments)     |**LdFcvFactor**  | Proportional adjustment of light-duty fuel cell vehicle (FCV) MPkWh due to congestion              |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**HhId**      | Household id                              |
| VELandUse    | [AssignLocTypes](#assignloctypes) |**LocType**    | Location type (Urban, Town, Rural) of the place where the household resides        |
| VEHouseholdVehicles    | [AssignVehicleOwnership](#assignvehicleownership)     |**Vehicles**   | Number of automobiles and light trucks owned or leased by the household including high level car service vehicles available to driving-age persons           |
| VEHouseholdVehicles    | [AssignVehicleType](#assignvehicletype) |**NumLtTrk**      | Number of light trucks (pickup, sport-utility vehicle, and van) owned or leased by household                             |
| VEHouseholdVehicles    | [AssignVehicleType](#assignvehicletype) |**NumAuto**      | Number of automobiles (i.e. 4-tire passenger vehicles that are not light trucks) owned or leased by household                              |
| VEHouseholdTravel          | [CalculateHouseholdDvmt](#CalculateHouseholdDvmt)     |**Dvmt** | Average daily vehicle miles traveled by the household in autos or light trucks    |
| VEHouseholdVehicles    | [AssignVehicleAge ](#assignvehicleage ) |**Type**      |  Vehicle body type: Auto = automobile, LtTrk = light trucks (i.e. pickup, SUV, Van)                             |
| VEPowertrainsAndFuels          | [AssignHhVehiclePowertrain](#assignhhvehiclepowertrain)     |**Powertrain**    |Vehicle powertrain type: ICEV = internal combustion engine vehicle, HEV = hybrid electric vehicle, PHEV = plug-in hybrid electric vehicle, BEV = battery electric vehicle, NA = not applicable because is a car service vehicle              |
| VEHouseholdVehicles    | [CreateVehicleTable](#createvehicletable) |**VehicleAccess**      | Identifier whether vehicle is owned by household (Own), if vehicle is low level car service (LowCarSvc), or if vehicle is high level car service (HighCarSvc)                             |
| VEPowertrainsAndFuels          | [AssignHhVehiclePowertrain](#assignHhvehiclepowertrain)     |**MPG**  | Average miles of vehicle travel powered by fuel per gasoline equivalent gallon               |
| VEPowertrainsAndFuels          | [AssignHhVehiclePowertrain](#assignHhvehiclepowertrain)     |**GPM**  |Average gasoline equivalent gallons per mile of vehicle travel powered by fuel                 |
| VEPowertrainsAndFuels          | [AssignHhVehiclePowertrain](#assignHhvehiclepowertrain)     |**MPKWH**    | Average miles of vehicle travel powered by electricity per kilowatt-hour                  |
| VEPowertrainsAndFuels          | [AssignHhVehiclePowertrain](#assignHhvehiclepowertrain)     |**KWHPM**  | Average kilowatt-hours per mile of vehicle travel powered by electricity                 |
| VEPowertrainsAndFuels          | [AssignHhVehiclePowertrain](#assignHhvehiclepowertrain)     |**MPGe**  | Average miles of vehicle travel per gasoline equivalent gallon (fuel and electric powered)               |
| VEPowertrainsAndFuels          | [AssignHhVehiclePowertrain](#assignHhvehiclepowertrain)     |**ElecDvmtProp**  | Average miles of vehicle travel per gasoline equivalent gallon (fuel and electric powered)                |
| VEPowertrainsAndFuels          | [AssignHhVehiclePowertrain](#assignHhvehiclepowertrain)     |**FuelCO2ePM**  | Average grams of carbon-dioxide equivalents produced per mile of travel powered by fuel          |
| VEPowertrainsAndFuels          | [AssignHhVehiclePowertrain](#assignHhvehiclepowertrain)     |**ElecCO2ePM**  |  Average grams of carbon-dioxide equivalents produced per mile of travel powered by electricity |


#### Module Outputs
* **MPG**: Average miles of vehicle travel powered by fuel per gasoline equivalent gallon
* **GPM**: Average gasoline equivalent gallons per mile of vehicle travel powered by fuel
* **MPKWH**: Average miles of vehicle travel powered by electricity per kilowatt-hour
* **KWHPM**: Average kilowatt-hours per mile of vehicle travel powered by electricity
* **MPGe**: Average miles of vehicle travel per gasoline equivalent gallon (fuel and electric powered)
* **ElecDvmtProp**: Average miles of vehicle travel per gasoline equivalent gallon (fuel and electric powered)
* **FuelCO2ePM**: Average grams of carbon-dioxide equivalents produced per mile of travel powered by fuel
* **IsEcoDrive**: Flag identifying whether drivers in household are eco-drivers





[Top](#rspm-modules-and-outputs)

___

### CalculateVehicleOperatingCost      

This module calculates vehicle operating costs per mile of travel and uses those costs to determine the proportional split of DVMT among household vehicles. The module also calculates the average out-of-pocket costs per mile of vehicle by household, as well as the cost of social and environmental impacts, and road use taxes per mile of vehicle travel.

#### User Input Files
1. Vehicle access time for `Azone` (**azone_vehicle_access_times.csv**): This file supplies data for vehicle access and eagress time.

   * **OwnedVehAccessTime**:Average amount of time in minutes required for access to and egress from a household-owned vehicle for a trip
   * **HighCarSvcAccessTime**: Average amount of time in minutes required for access to and egress from a high service level car service for a trip
   * **LowCarSvcAccessTime**: Average amount of time in minutes required for access to and egress from a low service level car service for a trip
   
   Here is a snapshot of the file:	
  <img align="center" width="500" border=1 src="images/azone_vehicle_access_times.PNG">
  
2. Fuel and electricity cost for `Azone` (**azone_fuel_power_cost.csv**): This file supplies data for retail cost of fuel and electricity

   * **FuelCost**:Retail cost of fuel per gas gallon equivalent in dollars
   * **PowerCost**: Retail cost of electric power per kilowatt-hour in dollars
   
   Here is a snapshot of the file:	
 <img align="center" width="400" border=1 src="images/azone_fuel_power_cost.PNG">

3. Vehicle taxes for `Azone` (**azone_veh_use_taxes.csv**): This file supplies data for vehicle related taxes

   * **FuelTax**:Tax per gas gallon equivalent of fuel in dollars
   * **VmtTax**: Tax per gas gallon equivalent of fuel in dollars
   * **PevSurchgTaxProp**: Proportion of equivalent gas tax per mile paid by hydrocarbon fuel consuming vehicles to be charged to plug-in electric vehicles per mile of travel powered by electricity

   Here is a snapshot of the file:	
    <img align="center" width="400" border=1 src="images/azone_veh_use_taxes.PNG">
   
4. Proportional external costs for the ragion  (**region_prop_externalities_paid.csv**): This file supplies data for climate change and other social costs.

   * **PropClimateCostPaid**: Proportion of climate change costs paid by users (i.e. ratio of carbon taxes to climate change costs
   * **PropOtherExtCostPaid**: Proportion of other social costs paid by users
   
   Here is a snapshot of the file:	
 <img align="center" width="400" border=1 src="images/region_prop_externalities_paid.PNG">


#### User Input Parameters
**Value of time (valueoftime)** : This parameter set the value of time (base cost year dollars per hour).  It should be defined in [model_parameters.json]

   ```json
 {"NAME": "ValueOfTime", 
   "VALUE": "16", 
   "TYPE": "double", 
   "UNITS": "base cost year dollars per hour"
  }
   ```
#### Internal Module Inputs
|    Package         |      Module                           |   Outputs    | Description                               |
|--------------------|---------------------------------------|--------------|-------------------------------------------|
| VETravelPerformance          | [CalculateRoadPerformance](#calculateroadperformance)     |**LdvAveSpeed**  | Average light-duty vehicle speed (miles per hour) on all roadways weighted by the proportions of light-duty vehicle travel                |
| VETravelPerformance          | [CalculateRoadPerformance](#calculateroadperformance)     |**AveCongPrice**  | Average price paid (dollars per mile) in congestion fees             |
| VEHouseholdVehicles          | [CreateVehicleTable ](#createvehicletable ) |**HighCarSvcCost**      |  Average cost in dollars per mile for travel by high service level car service                       |
| VEHouseholdVehicles          | [CreateVehicleTable ](#createvehicletable ) |**LowCarSvcCost**      |  Average cost in dollars per mile for travel by low service level car service                      |
| VESimHouseholds              | [CreateHouseholds](#createhouseholds) |**HhId**      | Household id                              |
| VEHouseholdVehicles    | [CreateVehicleTable ](#createvehicletable ) |**VehId**      |  Unique vehicle ID                             |
| VESimHouseholds    | [PredictIncome](#predictincome)       |**Income**    | Total annual income of household          |
| VEHouseholdTravel          | [CalculateHouseholdDvmt](#CalculateHouseholdDvmt)     |**Dvmt** | Average daily vehicle miles traveled by the household in autos or light trucks    |
| VEHouseholdVehicles          | [CalculateVehicleOwnCost](#calculatevehicleowncost)     |**HasPaydIns**  | Identifies whether household has pay-as-you-drive insurance for vehicles: 1 = Yes, 0 = no               |
| VEHouseholdTravel          | [CalculateVehicleTrips](#calculatevehicletrips)     |**VehicleTrips**  | Average number of vehicle trips per day by household members                |
| VELandUse          | [AssignParkingRestrictions](#assignparkingrestrictions)     |**OtherParkingCost**  | Daily cost for parking at shopping locations or other locations of paid parking not including work             |
| VEHouseholdVehicles    | [AssignVehicleAge ](#assignvehicleage ) |**Type**      |  Vehicle body type: Auto = automobile, LtTrk = light trucks (i.e. pickup, SUV, Van)                             |
| VEHouseholdVehicles    | [AssignVehicleAge ](#assignvehicleage ) |**Age**      |  Vehicle age in years                            |
| VEHouseholdVehicles    | [CreateVehicleTable](#createvehicletable) |**VehicleAccess**      | Identifier whether vehicle is owned by household (Own), if vehicle is low level car service (LowCarSvc), or if vehicle is high level car service (HighCarSvc)                             |
| VEPowertrainsAndFuels          | [AssignHhVehiclePowertrain](#assignhhvehiclepowertrain)     |**Powertrain**    |Vehicle powertrain type: ICEV = internal combustion engine vehicle, HEV = hybrid electric vehicle, PHEV = plug-in hybrid electric vehicle, BEV = battery electric vehicle, NA = not applicable because is a car service vehicle              |
| VEPowertrainsAndFuels          | [AssignHhVehiclePowertrain](#assignHhvehiclepowertrain)     |**GPM**  |Average gasoline equivalent gallons per mile of vehicle travel powered by fuel                 |
| VEPowertrainsAndFuels          | [AssignHhVehiclePowertrain](#assignHhvehiclepowertrain)     |**KWHPM**  | Average kilowatt-hours per mile of vehicle travel powered by electricity                 |
| VEPowertrainsAndFuels          | [AssignHhVehiclePowertrain](#assignHhvehiclepowertrain)     |**ElecDvmtProp**  | Average miles of vehicle travel per gasoline equivalent gallon (fuel and electric powered)                |
| VEPowertrainsAndFuels          | [AssignHhVehiclePowertrain](#assignHhvehiclepowertrain)     |**FuelCO2ePM**  | Average grams of carbon-dioxide equivalents produced per mile of travel powered by fuel          |
| VEPowertrainsAndFuels          | [AssignHhVehiclePowertrain](#assignHhvehiclepowertrain)     |**ElecCO2ePM**  |  Average grams of carbon-dioxide equivalents produced per mile of travel powered by electricity |
| VEHouseholdVehicles    | [CalculateVehicleOwnCost ](#calculatevehicleowncost ) |**InsCost**      |  Annual vehicle insurance cost in dollars                       |
| VELandUse          | [AssignParkingRestrictions](#assignparkingrestrictions)     |**ParkingCost**    |Daily cost for long-term parking (e.g. paid on monthly basis)               |
| VELandUse          | [AssignParkingRestrictions](#assignparkingrestrictions)     |**IsCashOut**  | Is worker paid parking in cash-out-buy-back program: 1 = yes, 0 = no              |
| VELandUse          | [AssignParkingRestrictions](#assignparkingrestrictions)     |**PaysForParking**  | Does worker pay for parking: 1 = yes, 0 = no             |


#### Module Outputs
* **AveVehCostPM**: Average out-of-pocket cost in dollars per mile of vehicle travel
* **AveSocEnvCostPM**: Average cost in dollars of the social and environmental impacts per mile of vehicle travel
* **AveRoadUseTaxPM**: Average road use taxes in dollars collected per mile of vehicle travel
* **DvmtProp**: Proportion of household DVMT allocated to vehicle
* **AveGPM**: Average gasoline equivalent gallons per mile of household vehicle travel
* **AveKWHPM**: Average kilowatt-hours per mile of household vehicle travel
* **AveCO2ePM**: Average grams of carbon-dioxide equivalents produced per mile of household vehicle travel




[Top](#rspm-modules-and-outputs)

___

### BudgetHouseholdDvmt      

This module adjusts average household DVMT to keep the quantity within household operating cost limits. The limit for each household is calculated in several steps. First, the proportion of the household's income that may be spent on vehicle operating costs is calculated using a model that is explained below. This is called the budget proportion. Then an adjusted household income
for budget calculation purposes is calculated by adding the annual cost of insurance for households subscribing to payd-as-you-drive (PAYD) insurance, cash-out parking payments for workers who work at an employer that has cash-out-buy-back parking, and any vehicle ownership cost savings for households that substitute high level car service for one or more household
vehicles. The adjusted household income is muliplied by the budget proportion and divided by the average vehicle operating cost per mile for the household to determine the maximum household DVMT that fits within the household budget. The household DVMT is then set at the lesser of this budget maximum or the modeled household DVMT.
The budget proportion model is estimated using data from the Bureau of Labor's consumer expenditure survey for the years from 2003 to 2015. The data used are the nominal dollar expenditures by household income category and year by transportation category. The values for the operating cost categories (gas and oil, and maintenance and repair) are summed and then divided by the
midpoint value for each income category to calculate the budget proportion for each income group and each year. From this the mean value is computed for each income group. The budget proportions for each income group and year are divided by the mean values by income group to normalize values. The standard deviation for the combined normalized values is computed and value of 3
deviations above the mean is set as the maximum normalized value. The mean values by income group are multiplied by this normalized maximum to derive a budget proportion maximum by income group. A smoothed splines model of the budget proportion as a function of income is then estimated from the calculated budget proportion maximums. This model is used to calculate the budget proportion for a household based on the household income. The minimum and
maximum values of the calculated budget proportion maximums are used as constraints to avoid unreasonable results for very low incomes and very high incomes.

#### User Input Files
This module does not have user-supplied input files



#### Internal Module Inputs
|    Package         |      Module                           |   Outputs    | Description                               |
|--------------------|---------------------------------------|--------------|-------------------------------------------|
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**HhId**      | Household id                              |
| VESimHouseholds    | [CreateHouseholds](#createhouseholds) |**HHSize**    | Number of persons in the household        |
| VESimHouseholds    | [PredictIncome](#predictincome)       |**Income**    | Total annual income of household          |
| VELandUse    | [AssignLocTypes](#assignloctypes) |**LocType**    | Location type (Urban, Town, Rural) of the place where the household resides        |
| VETravelPerformance          | [CalculateVehicleOperatingCost](#calculatevehicleoperatingcost)     |**AveVehCostPM**  | Average out-of-pocket cost in dollars per mile of vehicle travel                |
| VEHouseholdVehicles          | [AdjustVehicleOwnership](#adjustvehicleownership)     |**OwnCostSavings**  |  Annual vehicle ownership cost (depreciation, finance, insurance, taxes) savings in dollars resulting from substituting the use of car services for a household vehicle             |
| VEHouseholdVehicles          | [CalculateVehicleOwnCost](#calculatevehicleowncost)     |**HasPaydIns**  | Identifies whether household has pay-as-you-drive insurance for vehicles: 1 = Yes, 0 = no               |
| VETravelPerformance          | [CalculateVehicleOperatingCost ](#calculatevehicleoperatingcost ) |**AveGPM**      | Average gasoline equivalent gallons per mile of household vehicle travel                      |
| VETravelPerformance          | [CalculateVehicleOperatingCost ](#calculatevehicleoperatingcost ) |**AveKWHPM**      |  Average kilowatt-hours per mile of household vehicle travel                     |
| VETravelPerformance              | [CalculateVehicleOperatingCost](#calculatevehicleoperatingcost) |**AveCO2ePM**      |  Average grams of carbon-dioxide equivalents produced per mile of household vehicle travel                            |
| VELandUse          | [AssignParkingRestrictions](#assignparkingrestrictions)     |**ParkingCost**    |Daily cost for long-term parking (e.g. paid on monthly basis)               |
| VELandUse          | [AssignParkingRestrictions](#assignparkingrestrictions)     |**IsCashOut**  | Is worker paid parking in cash-out-buy-back program: 1 = yes, 0 = no              |
| VELandUse          | [AssignParkingRestrictions](#assignparkingrestrictions)     |**PaysForParking**  | Does worker pay for parking: 1 = yes, 0 = no             |
| VEHouseholdVehicles    | [CalculateVehicleOwnCost ](#calculatevehicleowncost ) |**InsCost**      |  Annual vehicle insurance cost in dollars                       |

#### Module Outputs
* **Dvmt**: Average daily vehicle miles traveled by the household in autos or light trucks
* **UrbanHhDvmt**: Average daily vehicle miles traveled in autos or light trucks by households residing in the urbanized portion of the Marea
* **RuralHhDvmt**: Average daily vehicle miles traveled in autos or light trucks by households residing in the non-urbanized portion of the Marea
* **DailyGGE**: Gasoline equivalent gallons consumed per day by household vehicle travel
* **DailyKWH**: Kilowatt-hours consumed per day by household vehicle travel
* **DailyCO2e**: Grams of carbon-dioxide equivalents produced per day by household vehicle travel
* **WalkTrips**: Average number of walk trips per year by household members
* **BikeTrips**: Average number of bicycle trips per year by household members
* **TransitTrips**: Average number of public transit trips per year by household members
* **VehicleTrips**: Average number of vehicle trips per day by household members

[Top](#rspm-modules-and-outputs)
___

### BalanceRoadCostsAndRevenues      

This module calculates an extra mileage tax ($ per vehicle mile traveled) for household vehicles needed to make up any difference in the cost of constructing, maintaining, and operating roadways and the revenues from fuel, VMT, and congestion taxes.
#### User Input Files
1. Road cost for the region (**region_road_cost.csv**): This file supplies data for different types of road costs

   * **RoadBaseModCost**: Average base modernization cost per light-duty vehicle mile traveled (dollars per vehicle mile). Base modernization includes roadway improvements exclusive of addition of lanes.
   * **RoadPresOpMaintCost**: Average road preservation, operations, and maintenance cost per light-duty vehicle mile traveled (dollars per vehicle mile).
   * **RoadOtherCost**: Average other road cost (e.g. administration, planning, project development, safety) per light-duty vehicle mile traveled (dollars per vehicle mile).
   * **FwyLnMiCost**: Average cost to build one freeway lane-mile (dollars per lane-mile)
   * **ArtLnMiCost**: Average cost to build one arterial lane-mile (dollars per lane-mile)
   * **HvyTrkPCE**: Passenger car equivalent (PCE) for heavy trucks. PCE indicates the number of light-duty vehicles a heavy truck is equivalent to in calculating road capacity.


   Here is a snapshot of the file:	
<img align="center" width="300" border=1 src="images/road_cost.PNG">


#### Internal Module Inputs
|    Package         |      Module                           |   Outputs    | Description                               |
|--------------------|---------------------------------------|--------------|-------------------------------------------|
| VETravelPerformance    | [CalculateBaseRoadDvmt ](#calculatebaseroaddvmt) |**HvyTrkUrbanDvmt**      |  Base year Region heavy truck daily vehicle miles of travel in urbanized areas                             |
| VETravelPerformance          | [CalculateBaseRoadDvmt](#CalculateBaseRoadDvmt)     |**ComSvcUrbanDvmt** | Commercial service daily vehicle miles of travel associated with Marea urbanized household activity    |
| VETravelPerformance          | [CalculateBaseRoadDvmt](#CalculateBaseRoadDvmt)     |**ComSvcRuralDvmt**  | Commercial service daily vehicle miles of travel associated with Marea rural household activity             |
| VETravelPerformance          | [CalculateBaseRoadDvmt](#CalculateBaseRoadDvmt)     |**ComSvcTownDvmt**  | Commercial service daily vehicle miles of travel associated with Marea town household activity             |
| VETransportSupply          | [AssignRoadMiles](#assignroadmiles)     |**FwyLaneMi**  | Lane-miles of roadways functionally classified as freeways or expressways in the urbanized portion of the metropolitan area                 |
| VETransportSupply     | [AssignRoadMiles](#assignroadmiles)  |**ArtLaneMi**      |  Lane-miles of roadways functionally classified as arterials (but not freeways or expressways) in the urbanized portion of the metropolitan area                             |
| VETravelPerformance     | [CalculateVehicleOperatingCost](#calculatevehicleoperatingcost)  |**AveRoadUseTaxPM**      |  Average road use taxes in dollars collected per mile of vehicle travel                             |
| VETravelPerformance          | [BudgetHouseholdDvmt](#budgethouseholddvmt)     |**Dvmt** | Average daily vehicle miles traveled by the household in autos or light trucks    |

#### Module Outputs
* **ExtraVmtTax**: Added vehicle mile tax for household vehicle use to pay for any deficit between road costs and road revenues (dollars per vehicle mile)

[Top](#rspm-modules-and-outputs)
___

### CalculateComEnergyAndEmissions      

This module calculates the energy consumption and carbon emissions of heavy trucks and light-duty commercial service vehicles. It does not calculate the values for car service vehicles which are calculated as part of the household emissions. It also does not calculate public transit emissions which are calculated in the CalculateTransitEnergyAndEmissions module.
#### User Input Files
1. Light trucks proportion for the region (**region_comsvc_lttrk_prop.csv**): This file supplies data for the light truck proportion og commercial vehicles

   * **ComSvcLtTrkProp**: Regional proportion of commercial service vehicles that are light trucks
   Here is a snapshot of the file:	
<img align="center" width="300" border=1 src="images/region_comsvc_lttrk_prop.PNG">


2. Commercial service vehicle powertrain proportions by vehicle type (**region_comsvc_powertrain_prop.csv**): This input file is OPTIONAL. It is only needed if the user wants to modify the powertrain proportion of commercial vehicles.

   * **ComSvcAutoPropIcev**: Proportion of commercial service automobile travel powered by internal combustion engine powertrains
   * **ComSvcAutoPropHev**: Proportion of commercial service automobile travel powered by hybrid electric powertrains
   * **ComSvcAutoPropBev**: Proportion of commercial service automobile travel powered by battery electric powertrains
   * **ComSvcLtTrkPropIcev**: Proportion of commercial service light truck travel powered by internal combustion engine powertrains
   * **ComSvcLtTrkPropHev**: Proportion of commercial service light truck travel powered by hybrid electric powertrains
   * **ComSvcLtTrkPropBev**: Proportion of commercial service light truck travel powered by battery electric powertrainss

   Here is a snapshot of the file:	
<img align="center" width="800" border=1 src="images/region_comsvc_powertrain_prop.PNG">

3. Heavy duty truck powertrain proportions (**region_hvytrk_powertrain_prop.csv**): This input file is OPTIONAL. It is only needed if the user wants to modify the powertrain proportion of heavy duty trucks.

   * **HvyTrkPropIcev**: Proportion of heavy truck travel powered by internal combustion engine powertrains
   * **HvyTrkPropHev**: Proportion of heavy truck travel powered by hybrid electric powertrains
   * **HvyTrkPropBev**: Proportion of heavy truck travel powered by battery electric powertrains

   Here is a snapshot of the file:	
<img align="center" width="400" border=1 src="images/region_hvytrk_powertrain_prop.PNG">

4. Heavy duty truck maean ages (**region_comsvc_veh_mean_age.csv**): This input file contains average age of commercial service vehicles

   * **AveComSvcVehicleAge**: average age of commercial service vehicles

   Here is a snapshot of the file:	
   <img align="center" width="400" border=1 src="images/age.PNG">

   
#### Internal Module Inputs
|    Package         |      Module                           |   Outputs    | Description                               |
|--------------------|---------------------------------------|--------------|-------------------------------------------|
| VEPowertrainsAndFuels    | [CalculateCarbonIntensity](#calculatecarbonintensity) |**ElectricityCI**      | Carbon intensity of electricity at point of consumption (grams CO2e per megajoule)                             |
| VEPowertrainsAndFuels    | [CalculateCarbonIntensity](#calculatecarbonintensity) |**HhAutoFuelCI**  | Average carbon intensity of fuels used by household automobiles (grams CO2e per megajoule))     |
| VEPowertrainsAndFuels    | [CalculateCarbonIntensity](#calculatecarbonintensity) |**HhLtTrkFuelCI** | Average carbon intensity of fuels used by household light trucks (grams CO2e per megajoule)    |
| VEPowertrainsAndFuels          | [CalculateCarbonIntensity](#calculatecarbonintensity)     |**HvyTrkFuelCI** | Average carbon intensity of fuels used by heavy trucks (grams CO2e per megajoule)    |
| VETravelPerformance          | [CalculateMpgMpkwhAdjustments](#calculatempgmpkwhadjustments)     |**LdvEcoDrive**  | Eco-driving penetration for light-duty vehicles; the fraction of vehicles from 0 to 1               |
| VETravelPerformance          | [CalculateMpgMpkwhAdjustments](#calculatempgmpkwhadjustments)     |**HvyTrkEcoDrive**  | Eco-driving penetration for heavy-duty vehicles; the fraction of vehicles from 0 to 1               |
| VETravelPerformance          | [CalculateMpgMpkwhAdjustments](#calculatempgmpkwhadjustments)     |**LdvSpdSmoothFactor**  | Proportional adjustment of light-duty internal combustion engine (ICE) vehicle MPG due to speed smoothing            |
| VETravelPerformance          | [CalculateMpgMpkwhAdjustments](#calculatempgmpkwhadjustments)     |**LdvEcoDriveFactor**    |Proportional adjustment of light-duty internal combustion engine (ICE) vehicle MPG due to eco-driving             |
| VETravelPerformance          | [CalculateMpgMpkwhAdjustments](#calculatempgmpkwhadjustments)     |**HvyTrkSpdSmoothFactor**  | Proportional adjustment of heavy truck internal combustion engine (ICE) vehicle MPG due to speed smoothing             |
| VETravelPerformance          | [CalculateMpgMpkwhAdjustments](#calculatempgmpkwhadjustments)     |**LdIceFactor**  | Proportional adjustment of light-duty internal combustion engine (ICE) vehicle MPG due to congestion               |
| VETravelPerformance          | [CalculateMpgMpkwhAdjustments](#calculatempgmpkwhadjustments)     |**LdHevFactor**  | Proportional adjustment of light-duty hybrid-electric vehicle (HEV) MPG due to congestion                 |
| VETravelPerformance          | [CalculateMpgMpkwhAdjustments ](#calculatempgmpkwhadjustments ) |**HvyTrkEcoDriveFactor**      |  Proportional adjustment of heavy truck internal combustion engine (ICE) vehicle MPG due to eco-driving                     |
| VETravelPerformance          | [CalculateMpgMpkwhAdjustments ](#calculatempgmpkwhadjustments ) |**LdEvFactor**      |  Proportional adjustment of light-duty battery electric vehicle (EV) MPkWh due to congestion                      |
| VETravelPerformance              | [CalculateMpgMpkwhAdjustments](#calculatempgmpkwhadjustments) |**HdIceFactor**      | Proportional adjustment of heavy-duty internal combustion engine (ICE) vehicle MPG due to congestion                              |
| VETravelPerformance    | [CalculateBaseRoadDvmt ](#calculatebaseroaddvmt) |**HvyTrkUrbanDvmt**      |  Base year Region heavy truck daily vehicle miles of travel in urbanized areas                             |
| VETravelPerformance    | [CalculateBaseRoadDvmt](#CalculateBaseRoadDvmt)       |**HvyTrkRuralDvmt**    | Base year Region heavy truck daily vehicle miles of travel in rural (i.e. non-urbanized) areas          |
| VETravelPerformance          | [CalculateBaseRoadDvmt](#CalculateBaseRoadDvmt)     |**ComSvcUrbanDvmt** | Commercial service daily vehicle miles of travel associated with Marea urbanized household activity    |
| VETravelPerformance          | [CalculateBaseRoadDvmt](#CalculateBaseRoadDvmt)     |**ComSvcRuralDvmt**  | Commercial service daily vehicle miles of travel associated with Marea rural household activity             |


#### Module Outputs
* **ComSvcUrbanGGE**: Average daily amount of hydrocarbon fuels consumed by commercial service vehicles associated with urban household activity in gas gallon equivalents
* **ComSvcRuralGGE**: Average daily amount of hydrocarbon fuels consumed by commercial service vehicles associated with rural household activity in gas gallon equivalents
* **HvyTrkUrbanGGE**: Average daily amount of hydrocarbon fuels consumed by heavy trucks on urbanized area roadways in the Marea in gas gallon equivalents
* **ComSvcUrbanKWH**: Average daily amount of electricity consumed by commercial service vehicles associated with urban household activity in kilowatt-hours
* **ComSvcRuralKWH**: Average daily amount of electricity consumed by commercial service vehicles associated with rural household activity in kilowatt-hours
* **ComSvcUrbanCO2e**: Average daily amount of carbon-dioxide equivalents produced by commercial service vehicles associated with urban household activity in grams
* **ComSvcRuralCO2e**: Average daily amount of carbon-dioxide equivalents produced by commercial service vehicles associated with rural household activity in grams
* **HvyTrkUrbanCO2e**: Average daily amount of carbon-dioxide equivalents produced by heavy trucks on urbanized area roadways in the Marea in grams
* **ComSvcAveUrbanAutoCO2eRate**: Average amount of carbon-dioxide equivalents produced by commercial service automobiles per mile of travel on urbanized area roadways in grams per mile
* **ComSvcAveUrbanLtTrkCO2eRate**: Average amount of carbon-dioxide equivalents produced by commercial service light trucks per mile of travel on urbanized area roadways in grams per mile
* **HvyTrkAveUrbanCO2eRate**: Average amount of carbon-dioxide equivalents produced by heavy trucks per mile of travel on urbanized area roadways in grams per mile

* **HvyTrkRuralGGE**: Average daily amount of hydrocarbon fuels consumed by heavy trucks on rural roadways in the Region in gas gallon equivalents
* **HvyTrkUrbanGGE**: Average daily amount of hydrocarbon fuels consumed by heavy trucks on urbanized area roadways in the Region in gas gallon equivalents
* **HvyTrkRuralKWH**: Average daily amount of electricity consumed by heavy trucks on rural roadways in the Region in kilowatt-hours
* **HvyTrkUrbanKWH**: Average daily amount of electricity consumed by heavy trucks on urbanized area roadways in the Region in kilowatt-hours
* **HvyTrkRuralCO2e**: Average daily amount of carbon-dioxide equivalents produced by heavy trucks on rural roadways in the Region in grams
* **HvyTrkUrbanCO2e**: Average daily amount of carbon-dioxide equivalents produced by heavy trucks on urbanized area roadways in the Region in grams


[Top](#rspm-modules-and-outputs)

___

### CalculatePtranEnergyAndEmissions    

This module calculates the energy consumption and carbon emissions of public transit vehicle emissions in urbanized areas.

#### User Input Files
1. Transit powertrain proportions by transit vehicle type and Marea (**marea_transit_powertrain_prop.csv**): This input file is OPTIONAL. It is only needed if the user wants to modify the mixes of transit vehicle powertrains.

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

#### Internal Module Inputs
|    Package         |      Module                           |   Outputs    | Description                               |
|--------------------|---------------------------------------|--------------|-------------------------------------------|
| VEPowertrainsAndFuels    | [CalculateCarbonIntensity](#calculatecarbonintensity) |**ElectricityCI**      | Carbon intensity of electricity at point of consumption (grams CO2e per megajoule)                             |
| VEPowertrainsAndFuels          | [CalculateCarbonIntensity](#calculatecarbonintensity)     |**TransitVanFuelCI** | Average carbon intensity of fuel used by transit vans (grams CO2e per megajoule)    |
| VEPowertrainsAndFuels          | [CalculateCarbonIntensity](#calculatecarbonintensity)     |**TransitBusFuelCI** | Average carbon intensity of fuel used by transit buses (grams CO2e per megajoule)    |
| VEPowertrainsAndFuels          | [CalculateCarbonIntensity](#calculatecarbonintensity)     |**TransitRailFuelCI** | Average carbon intensity of fuel used by transit rail vehicles (grams CO2e per megajoule)    |
| VETransportSupply            | [AssignTransitService](#assigntransitservice) |**VanDvmt**      |  Total daily miles traveled by vans of various sizes to provide demand responsive, vanpool, and similar services                            |
| VETransportSupply            | [AssignTransitService](#assigntransitservice) |**BusDvmt**      | Total daily miles traveled by buses of various sizes to provide bus service of various types                           |
| VETransportSupply            | [AssignTransitService](#assigntransitservice)     |**RailDvmt** | Total daily miles traveled by light rail, heavy rail, commuter rail, and similar types of vehicles   |


#### Module Outputs
* **BusGGE**: Average daily amount of hydrocarbon fuels consumed by bus transit vehicles in urbanized area in gas gallon equivalents
* **RailGGE**: Average daily amount of hydrocarbon fuels consumed by rail transit vehicles in urbanized area in gas gallon equivalents
* **VanGGE**: Average daily amount of hydrocarbon fuels consumed by van transit vehicles in urbanized area in gas gallon equivalents
* **BusKWH**: Average daily amount of electricity consumed by bus transit vehicles in urbanized area in kilowatt-hours
* **RailKWH**: Average daily amount of electricity consumed by rail transit vehicles in urbanized area in kilowatt-hours
* **VanKWH**:Average daily amount of electricity consumed by van transit vehicles in urbanized area in kilowatt-hours
* **BusCO2e**: Average daily amount of carbon-dioxide equivalents produced by bus transit vehicles in urbanized area in grams
* **RailCO2e**: Average daily amount of carbon-dioxide equivalents produced by rail transit vehicles in urbanized area in grams
* **VanCO2e**: Average daily amount of carbon-dioxide equivalents produced by van transit vehicles in urbanized area in grams
* **BusCO2eRate**: Average amount of carbon-dioxide equivalents produced by bus transit vehicles per mile of travel in urbanized area in grams per mile
* **RailCO2eRate**: Average amount of carbon-dioxide equivalents produced by rail transit vehicles per mile of travel in urbanized area in grams per mile
* **VanCO2eRate**: Average amount of carbon-dioxide equivalents produced by van transit vehicles per mile of travel in urbanized area in grams per mile


[Top](#rspm-modules-and-outputs)

##  Development and Installation

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
hh_dvmt <- statemod$extract(saveTo = F)
hh_dvmt <- unlist(hh_dvmt)
year <- names(hh_dvmt)
year <- ifelse(grepl('2010', year), '2010', '2040')
hh_dvmt <- data.frame(year, Dvmt = hh_dvmt)
```

Plot using the `ggplot2` library, for example:

```
ggplot(hh_dvmt, aes(x = Dvmt, fill = year)) + 
  geom_histogram() + 
  ylab('Number of Households') +
  ggtitle('Distribution of DVMT by VE-State for Oregon')
```

<img align="center" width="600" border=1 src="images/VEState_HH_DVMT_Distribution.png">


Other query methods are described in the [Getting Started documentation](https://github.com/VisionEval/VisionEval/wiki/Getting-Started-v2## extracting-model-results). 

### Scenarios

To modify a scenario, the appropriate input files are edited.  For example, to change the flat rate tax of vehicles for future [`azone_hh_veh_own_taxes.csv`](https://github.com/visioneval/VisionEval/blob/master/sources/modules/VEHouseholdVehicles/inst/module_docs/CalculateVehicleOwnCost.md## azone_hh_veh_own_taxescsv) would be modified in Excel, LibreOffice, OpenOffice, or a text editor to change the `VehOwnFlatRateFee` of year 2038.

<img align="center" width="600" border=1 src="../verspm/images/modify_input.PNG">

Create scenarios using the same steps as for [VE-RSPM]('../verspm/Running_VERSPM.md')

Return to [Tutorial](Main.md). 

##  Development and Installation

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
hh_dvmt <- statemod$extract(saveTo = F)
hh_dvmt <- unlist(hh_dvmt)
year <- names(hh_dvmt)
year <- ifelse(grepl('2010', year), '2010', '2040')
hh_dvmt <- data.frame(year, Dvmt = hh_dvmt)
```

Plot using the `ggplot2` library, for example:

```
ggplot(hh_dvmt, aes(x = Dvmt, fill = year)) + 
  geom_histogram() + 
  ylab('Number of Households') +
  ggtitle('Distribution of DVMT by VE-State for Oregon')
```

<img align="center" width="600" border=1 src="images/VEState_HH_DVMT_Distribution.png">


Other query methods are described in the [Getting Started documentation](https://github.com/VisionEval/VisionEval/wiki/Getting-Started-v2## extracting-model-results). 

### Scenarios

To modify a scenario, the appropriate input files are edited.  For example, to change the flat rate tax of vehicles for future [`azone_hh_veh_own_taxes.csv`](https://github.com/visioneval/VisionEval/blob/master/sources/modules/VEHouseholdVehicles/inst/module_docs/CalculateVehicleOwnCost.md## azone_hh_veh_own_taxescsv) would be modified in Excel, LibreOffice, OpenOffice, or a text editor to change the `VehOwnFlatRateFee` of year 2038.

<img align="center" width="600" border=1 src="../verspm/images/modify_input.PNG">

Create scenarios using the same steps as for [VE-RSPM]('../verspm/Running_VERSPM.md')

Return to [Tutorial](Main.md). 
