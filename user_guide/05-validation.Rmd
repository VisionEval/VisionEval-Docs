# Validation and Troubleshooting

Each model run will produce a time stamped Log.txt file. This log file is the first thing that the user should reference in troubleshooting errors. The log file should point to which input files have errors and help to define the error. If a model is not producing a log file, that indicates a more deep-rooted issue related to the model set-up, installation, or one or more packages.

Other common errors users should watch out for include:

* Files having data for years other than model run years will generate an error, files can only have data for model run years
* Consistent geography names across input files
* Input files in different modules need to be consistent
  + Zero land area for an azone location type when there are non-zero values for households in that azone location type
  + Zero land area for an azone location type when there are non-zero values for employment in that azone location type

## Validation
  
This section summarizes additional detail on the validation of VisionEval models. 

### More How
Adjustments can be made to specific modules within each package:
  
  Essential...vs. fine tuning
[using local PUMS is necessary, PowertrainsAndFuels is good practice, most others are fine-tuning]
[can we put more meat in 7.1, classify by importance, show more detail on necessary, and have this be a drill-down detail on another page?]
[Can we group these by the concepts, or by the bulleted types in 7.1?  "package" organization are obtuse for basic user]
+ The `VESimHouseholds` package processes PUMS data to derive parameters for several of its sub-modules. The default PUMS files in the `inst/extdata` folder from Oregon should be replaced with data for the area they are modeling. Some adjustments specific to simulated households by Azone include:
  + The average household size (`AveHhSize`) and proportion of one-person households (`Prop1PerHh`) can be set in the [azone_hhsize_targets.csv]() file.
+ The relative employment rate by age group by Azone can be specified to match observed differences across a metropolitan area or levels at various points of economic cycles. These changes are coded in the optional [azone_relative_employment.csv]() file. The relative employment rate is relative to the average employment rate for the worker group in the PUMS data (e.g., a value of 0.5 would be entered if the employment rate for 20-29 age group in one Azone was half the employment rate for persons in that age group in the metropolitan area).
+ The prediction of household income as a function of workers by age group and per captia income can be adjusted in the [azone_per_cap_inc.csv]() file. Note that adjustments to the relative employment rate described above will influence affect the distribution of incomes across households.

+ The `VELandUse` package also uses the PUMS data, which can be further adjusted in two ways:
  + The mix of single family versus multi-family households will reflect local patterns if PUMS data for the modeled region are used instead of the default data from Oregon.
+ The proportion of households residing in mixed-use neighborhoods within each Bzone can optionally be set in the [bzone_urban-mixed-use_prop.csv]() file. Such adjustments are subjective, as the definition of "urban mixed-use" neighborhoods [derived from the Claritas data](https://nhts.ornl.gov/2009/pub/DerivedAddedVariables2009.pdf) in the [NHTS](https://nhts.ornl.gov/) are imprecise. 

+ Most of the parameters in the `VEHouseholdVehicles` package are self-calibrating. However, the relative driver licensing rate by age group can be coded in the [region_hh_driver_adjust_prop.csv]() file. 
+ There are few opportunities to adjust the parameters in the `VEHouseholdTravel` package, as most are derived from the NHTS and PUMS input data. Note that the optionally specified driver licensing rates described above can substantially affect daily household VMT. It is possible to specify the percentage of household Short Trips SOV travel diverted to bicycles in the [azone_prop_sov_dvmt_diverted.csv]() file to better match observed local values. 
+ The default data inputs in the `VEPowertrainsAndFuels` package substantially affect modeled fuel consumption and vehicle emissions rates. These default inputs are contained in the `inst/extdata` folder of the source package. Note that the package needs to be built (installed) from the source package after adjustments have been made in order for the changes to have effect. 
+ The `VETravelPerformance` package is self-calibrating. However, the user must provide several estimates used as constraints during that process:
  + Estimates of urbanized area light-duty vehicle and heavy truck VMT (`UrbanLdvDvmt` and `UrbanHvyTrkDvmt`, respectively) must be coded in the [marea_base_year_dvmt.csv]() input file. 
+ The user must also provide a regional estimate of heavy truck VMT (`HvyTrkDvmt`) in the [region_base_year_dvmt.csv]() that is consistent with the urbanized area heavy truck VMT estimates.
+ The user should check the basis used for estimating commercial service VMT (`ComSvcDvmtGrowthBasis`) and heavy truck VMT (`HvyTrkDvmtGrowthBasis`).

### Key Considerations
[Great to have this in 1 place! Group by Concept?]

The experience to date suggest that several model inputs and assumptions can be changed to better match observed local patterns and trends:
  
  + The choice of geographies used in VisionEval can influence validation results. For example, if economic conditions or driver licensing rates vary significantly across the modeled area it might be a good idea to define Azones to reflect those differences. 
+ PUMS data for the modeled region should be used in place of the Oregon data used in the original development of the model. This is done by simply replacing the PUMS data in the `inst/extdata` folder with local data, which are then processed by several modules as part of a normal model run. [I think you have to rebuild the package, need to show how or have FHWA do this for you, keep options available for download]
+ Care should be taken in choosing the validation targets to match model predictions. VE household travel modules predict household travel regardless of where the travel occurs within the modeled region. Therefore the results should be compared with household survey data which provide similarly defined estimates. 
+ Care should similarly be taken in comparing the model results with daily roadway VMT data, such as those reported in Highway Statistics reports or imputed from annual HPMS estimates. If such comparisons are made the model estimates of roadway DVMT calculated by the `CalculateRoadDvmt` module should be used for comparison.[rather than HPMS data that is defined as all vehicles but only those miles on roadways within a specific geography.]
+ If modeled DVMT matches validation data but fuel consumption does not (e.g. light-duty vehicle fuel consumption reported in Highway Statistics), the values in [ldv_powertrain_characteristics.csv]() for current and past years can be adjusted to achieve a match. Fuel consumption may not match for several reasons such as:
  + The definition of crossover vehicles as light trucks vs. autos used in the vehicle type model does not match the average fuel consumption characteristics in the [ldv_powertrain_characteristics.csv]() file.
+ The average fuel consumption characteristics in [ldv_powertrain_characteristics.csv]() do not represent real world fuel economy.
+ If validation data are available for commercial service vehicles, heavy trucks, and public transit vehicles changes can be made to the respective powertrain characteristics files for those vehicle types to match observed values.
+ If the modeled road DVMT estimates match for the base year but not for prior years the modeled household DVMT trends should be checked against road DVMT trends. In particular, check whether reduction of DVMT (or reduction of DVMT growth rate) observed during the [Great Recession](https://en.wikipedia.org/wiki/Great_Recession) and increase in DVMT (or increase in the DVMT growth rate) afterwards are reflected in the modeled household DVMT. If not, the values in the following files should be checked and adjusted if warranted:
  + Young persons that moved back in with parents during recession and left afterwards when earning more should be accounted for in [azone_hhsize_targets.csv]()
+ The lower incomes during the recession should be reflected in the [azone_per_cap_inc.csv]() file
+ Lower employment rates, especially in certain age groups, should be reflected in [azone_relative_employment.csv]()
+ The reduction in driver licensing rates among young drivers should be accounted for in the [region_hh_driver_adjust_prop.csv]() file

## Customizing Packages
Users have the option to customize or re-estimate the model packages based on local data. Customizing packages is a more advanced user technique that is recommended only after users have some experience using the VisionEval system. 

For a deeper dive into how to customize packages and the various data that is available for local estimation, users should reference the [Estimation in VisionEval][Estimation in VisionEval] chapter.

* PUMS
* PowertrainsAndFuels
VETravelPerformance/[_LoadDefaultRoadDvmtValues_](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#91-loaddefaultroaddvmtvalues) datasets from the 2010 Highway Statistics reports are used to calculate state and urbanized area travel statistics as described below. A data from the Transportation Energy Databook (Edition 31) are used to calculate the ratio of commercial service vehicle DVMT with household DVMT. These datasets are in the "inst/extdata" folder of the package. Documentation for these datasets are included. Advanced users may update the datasets if desired.
Various [VETravelPerformance default files](<https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#advanced-user-inputs>) are included in the inst/extdata directory of the PowertrainsAndFuels package. Each file is documented with a correspondingly named text file. Advanced users may modify these files to create other default scenarios. 

PACKAGE MAINTENANCE
* BudgetHouseholdDvmt Ext_data:  The CES data used to estimate the BudgetHouseholdDvmt model are included in 'ces_vehicle_op-cost.csv' with documentation in 'ces_vehicle_op-cost.txt'. The 'ces.R' R script file contains the code used to download the raw CES dataset from the BLS website and process it to produce the dataset in the 'ces_vehicle_op-cost.csv' file. CES data for the years 2003 to 2015 are used in model estimation. 2003 being the first year that the BLS included income subcategories for incomes greater than $70,000. 2015 being the last year of complete data when the model was estimated.

* VETravelPerformance\CalculateVehicleOperatingCost Module:  [vehicle maintenance, repair, and tire cost]() as a function of the vehicle age is calculated based on data from the American Automobile Association (AAA) and the Bureau of Labor Statistics (BLS). AAA publishes reports yearly on the cost of vehicle use by vehicle type over the first 5 years of the vehicle's life. The 2017 report, a copy of which is included as the '17-0013_Your-Driving-Costs-Brochure-2017-FNL-CX-1.pdf' file in the 'inst/extdata/sources' directory of this package, is used to calculate baseline MRT cost by vehicle type. Data from a BLS report, "Beyond the Numbers, Prices and Spending, Americans' Aging Autos, BLS, May 2014, Vol.3/No.9", are used to establish the relationship between MRT cost and vehicle age. A copy of the report is included as the 'americans-aging-autos.pdf' file in the 'inst/extdata/sources' directory of this package. This report includes estimates of average MRT cost by vehicle age category for all household vehicles. The MRT costs by vehicle type and age are calculated as the outer product of the AAA costs by vehicle type and the BLS ratio of MRT cost by vehicle age. Since the BLS data don't distinguish between vehicle types, it is assumed that the effect of age on MRT expenses is the same for all vehicle types.

* VETravelPerformance\CalculateVehicleOperatingCost Module: **Default Carbon Cost** values are from "Technical Support Document: Technical Update of the Social Cost of Carbon for Regulatory Impact Analysis Under Executive Order 12866, Interagency Working Group on Social Cost of Greenhouse Gases, United States Government, August 2016". A copy of the report is included as the 'sc_co2_tsd_august_2016.pdf' file in the 'inst/extdata/sources' directory of this package.Carbon costs are estimated by year and assumed discount rate scenarios: 5%, 3%, 2.5%. In addition, they are calculated for a lower probability but higher impact scenario. The default carbon costs used in the model are the values listed for the 3% discount rate. 

* VETravelPerformance\CalculateVehicleOperatingCost Module: **Non-Carbon Social Costs**: Values for other social costs are derived from an  white paper prepared for the Oregon Department of Transportation (ODOT) to support the development of ODOT's statewide transportation strategy for reducing greenhouse gas emissions from the transportation sector. This paper is included as the 'STS_White_Paper_on_External_Costs_9-21-2011.pdf' file in the 'inst/extdata/sources' directory of this package. The included social cost categories are air pollution, other resource pollution, energy security, safety, and noise.

* VETravelPerformance\BalanceRoadCostsAndRevenues Module: **region_road_cost.csv** file includes unit costs for freeway and arterial operation, preservation, modernization, and other costs.  Based on values in original GreenSTEP model (ODOT, 2012). 

# Developing Scenarios

TO BE DEVELOPED

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

![Bike Network Research](VE_PackagesModules/VERSPM_Bike.JPG)

Note:  The project also intends to synchronize the disaggregate Bike Network assumptions with the Bike Module in Portland Metro's new Activity Based Model, where the full network, not just the aggregated metrics of VisionEval, could be utilized directly.

### User Impact
The VisionEval Bike upgrades will change both methods, inputs and outputs.  Methods will reflect the new functional form of travel by mode, and new data (updated NHTS2009 and EPA SLD land use data), leading to different outcomes for household travel by bike.  

Users will likely need to provide more detailed bike network data (for historic and forecast years) to a pre-processor to develop Bzone inputs for use in VisionEval.

### Status
The multi-agency research agreement was signed in early 2020.  The Research team anticipates the project will last roughly 12-18 months.  As with other VE research, additional efforts may be needed to implement the work within the VE codebase. 

