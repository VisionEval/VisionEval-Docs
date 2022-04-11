# Estimation in VisionEval {#ve-estimation}




## Overview 

Model estimation in VisionEval, either statistical estimation of model parameters (such as estimating linear regression or logit models) or tabulation of external data to produce model parameters, is designed to be integrated into VE modules and to take place during the build process of the modules into packages. 

While this is convenient, the current process in existing VE modules has limitations:

* It is difficult to replace models with local or updated data due to complexity and lack of documentation
* Several modules obscure data and parameters in the estimation portion of the package and therefore require package rebuilds if changes are made
* Legacy model estimation is incorporated in several modules, e.g., modules that were part of the RPAT model
* There are data discontinuities preventing users from estimating models where, for example, restricted or confidential data have been used to estimate model components (e.g., use of restricted spatial data in VETravelDemandMM) preventing the data from being included in the model package.

This chapter forms an element of work to improve the ability for those applying VE to incorporate newer publicly available datasets or custom datasets to develop locally relevant models for use in VE. This includes defining a process for users to make use of the latest NHTS data, local HTS data, and local PUMS data, to update models estimated using older versions of the NHTS and PUMS data from different states or regions. 

This chapter includes a catalog of estimated models and lists the underlying data used in the estimation process for each modules. This includes coverage of legacy pieces of VE code that were estimated in prior models (e.g., GreenStep and RPAT). There is a classification of the data with respect to how important it might be to re-estimate models using localized and/or updated versions of the source information. 

The chapter also documents how the build process currently works, and the requirements to assert new data or assumptions into existing packages. Finally, the chapter discusses several topics for improving the flexiblity and usability of the estimation procedures in VE. 

## VE Modules With Estimation

The table lists the VE modules that currently exist and whether they include estimation. Several of the modules, notably the original and more recently developed household travel modules (VEHouseholdTravel and VETravelDemandMM) contain a high number of estimated models. Several modules include no estimation.

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Module Name </th>
   <th style="text-align:right;"> Estimated Components and Models </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> VEHouseholdTravel </td>
   <td style="text-align:right;"> 22 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> VEHouseholdVehicles </td>
   <td style="text-align:right;"> 9 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> VELandUse </td>
   <td style="text-align:right;"> 11 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> VENHTS2001 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> VEPowertrainsAndFuels </td>
   <td style="text-align:right;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> VEReports </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> VEScenario </td>
   <td style="text-align:right;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> VESimHouseholds </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> VESimLandUse </td>
   <td style="text-align:right;"> 9 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> VESimLandUseData </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> VESimTransportSupply </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> VESyntheticFirms </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> VETransportSupply </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> VETransportSupplyUse </td>
   <td style="text-align:right;"> 3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> VETravelDemandMM </td>
   <td style="text-align:right;"> 24 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> VETravelPerformance </td>
   <td style="text-align:right;"> 9 </td>
  </tr>
</tbody>
</table>

This section describes the estimation that takes places in each module.


###  VENHTS2001 

2001 NHTS data package This package processes the 2001 NHTS publically available datasets to create a household dataset which is used for model estimations. The NHTS data are augmented with transportation service data.
This modules contains the following step(s): 
 
####  Make2001NHTSDataset 

This module creates a data frame of data from the publically available data from the 2001 National Household Travel Survey (NHTS) augmented with data on metropolitan area freeway supply and transit supply. The package produces a data frame of values by household. 

* This module step uses data sources including NHTS 2001, FHWA HPMS, FTA NTD 
* This module step uses model types including Tabulation of data by household 
* This module step is estimated using the following methods: Package build 
* This module step is documented in R Script only, no md file produced 

The models in this model step are: 
 
* Model name: Processed NHTS 2001 Dataset 
  + Model type: Tabulation of data by household 
  + Estimation data: inst/extdata/highway_statistics.csv, inst/extdata/uza_bus_eq_rev_mi.csv, NHTS data downloaded from "https://raw.githubusercontent.com/gregorbj/NHTS2001/master/data" if not already present in data-raw 
  + Estimation method: Package build 
  + Estimation script: R/Make2001NHTSDataset.r 
  + Model object: data-raw/Dt_df.rda, data-raw/Hh_df.rda, data-raw/Per_df.rda, data-raw/ToursByHh_df.Rda, data-raw/Veh_df.rda 
  + Notes: Original data are housed in another repository and downloaded and processed if that has not already been done before, checks for presence of processed files in data-raw before initiating new download. The outputs from this module are used in the estimation of many other modules (notes by VE2001 in Estimation data field) 


###  VEHouseholdTravel 

VisionEval module for calculating household vehicle travel and travel by other modes (public transit, walk, bike)
This modules contains the following step(s): 
 
####  ApplyDvmtReductions 

This module applies the computed proportional reductions in household DVMT due to the application of travel demand management programs and the diversion of single-occupant vehicle travel to bicycles, electric bicycles, or other light-weight vehicles. It also computes added bike trips due to the diversion. 

This module step has no estimated parameters or other model types derived from data. 
 
####  CalculateAltModeTrips 

This module calculates household transit trips, walk trips, and bike trips. The models are sensitive to household DVMT so they are run after all household DVMT adjustments (e.g. to account for cost on household DVMT) are made. 

* This module step uses data sources including NHTS 2001 
* This module step uses model types including Hurdle 
* This module step is estimated using the following methods: Package build 
* This module step is documented in inst/module_docs/CalculateAltModeTrips.md 

The models in this model step are: 
 
* Model name: Metropolitan Walk Trip Model 
  + Model type: Hurdle 
  + Estimation data: VE2001NHTS::Hh_df 
  + Estimation method: Package build 
  + Estimation script: R/CalculateAltModeTrips.R 
  + Model object: data/AltModeModels_ls.rda 
  + Notes: Sources estimation data from the VE NHTS 2001 package. 

* Model name: Nonmetropolitan Walk Trip Model 
  + Model type: Hurdle 
  + Estimation data: VE2001NHTS::Hh_df 
  + Estimation method: Package build 
  + Estimation script: R/CalculateAltModeTrips.R 
  + Model object: data/AltModeModels_ls.rda 
  + Notes: Sources estimation data from the VE NHTS 2001 package. 

* Model name: Metropolitan Bike Trip Model 
  + Model type: Hurdle 
  + Estimation data: VE2001NHTS::Hh_df 
  + Estimation method: Package build 
  + Estimation script: R/CalculateAltModeTrips.R 
  + Model object: data/AltModeModels_ls.rda 
  + Notes: Sources estimation data from the VE NHTS 2001 package. 

* Model name: Nonmetropolitan Bike Trip Model 
  + Model type: Hurdle 
  + Estimation data: VE2001NHTS::Hh_df 
  + Estimation method: Package build 
  + Estimation script: R/CalculateAltModeTrips.R 
  + Model object: data/AltModeModels_ls.rda 
  + Notes: Sources estimation data from the VE NHTS 2001 package. 

* Model name: Metropolitan Transit Trip Model 
  + Model type: Hurdle 
  + Estimation data: VE2001NHTS::Hh_df 
  + Estimation method: Package build 
  + Estimation script: R/CalculateAltModeTrips.R 
  + Model object: data/AltModeModels_ls.rda 
  + Notes: Sources estimation data from the VE NHTS 2001 package. 

* Model name: Nonmetropolitan Transit Trip Model 
  + Model type: Hurdle 
  + Estimation data: VE2001NHTS::Hh_df 
  + Estimation method: Package build 
  + Estimation script: R/CalculateAltModeTrips.R 
  + Model object: data/AltModeModels_ls.rda 
  + Notes: Sources estimation data from the VE NHTS 2001 package. 

####  CalculateHouseholdDvmt 

This module models household average daily vehicle miles traveled as a function of household characteristics, vehicle ownership, and attributes of the neighborhood and metropolitan area where the household resides 

* This module step uses data sources including NHTS 2001 
* This module step uses model types including Linear regression 
* This module step is estimated using the following methods: Package build 
* This module step is documented in inst/module_docs/CalculateHouseholdDvmt.md 

The models in this model step are: 
 
* Model name: metropolitan household power-transformed simulated average DVMT linear model 
  + Model type: Linear regression 
  + Estimation data: VE2001NHTS::Hh_df 
  + Estimation method: Package build 
  + Estimation script: R/CalculateHouseholdDvmt.R 
  + Model object: data/DvmtModel_ls.rda 
  + Notes: Sources estimation data from the VE NHTS 2001 package. The final linear regression model is estimated following a multistep process that estimates a series of models to simulate annual travel from survey day travel 

* Model name: non-metropolitan household power-transformed simulated average DVMT linear model 
  + Model type: Linear regression 
  + Estimation data: VE2001NHTS::Hh_df 
  + Estimation method: Package build 
  + Estimation script: R/CalculateHouseholdDvmt.R 
  + Model object: data/DvmtModel_ls.rda 
  + Notes: Sources estimation data from the VE NHTS 2001 package. The final linear regression model is estimated following a multistep process that estimates a series of models to simulate annual travel from survey day travel 

* Model name: 95th percentile DVMT model for metropolitan households 
  + Model type: Linear regression 
  + Estimation data: VE2001NHTS::Hh_df 
  + Estimation method: Package build 
  + Estimation script: R/CalculateHouseholdDvmt.R 
  + Model object: data/DvmtModel_ls.rda 
  + Notes: Sources estimation data from the VE NHTS 2001 package. The final linear regression model is estimated following a multistep process that estimates a series of models to simulate annual travel from survey day travel 

* Model name: 95th percentile DVMT model for non-metropolitan households 
  + Model type: Linear regression 
  + Estimation data: VE2001NHTS::Hh_df 
  + Estimation method: Package build 
  + Estimation script: R/CalculateHouseholdDvmt.R 
  + Model object: data/DvmtModel_ls.rda 
  + Notes: Sources estimation data from the VE NHTS 2001 package. The final linear regression model is estimated following a multistep process that estimates a series of models to simulate annual travel from survey day travel 

####  CalculateVehicleTrips 

This module calculates average daily vehicle trips for households consistent with the household DVMT. An average trip length model is applied to estimate average length of household trips reflecting the characteristics of the household and the place where they live. The average trip length is divided into the average household DVMT to get an estimate of average number of daily vehicle trips. 

* This module step uses data sources including NHTS 2001 
* This module step uses model types including Linear regression 
* This module step is estimated using the following methods: Package build 
* This module step is documented in inst/module_docs/CalculateVehicleTrips.md 

The models in this model step are: 
 
* Model name: metropolitan model of average vehicle trip length 
  + Model type: Linear regression 
  + Estimation data: VE2001NHTS::Hh_df 
  + Estimation method: Package build 
  + Estimation script: R/CalculateVehicleTrips.R 
  + Model object: data/VehTrpLenModel_ls.rda 
  + Notes: Sources estimation data from the VE NHTS 2001 package. The final linear regression model is estimated following a two step process 

* Model name: non-metropolitan model of average vehicle trip length 
  + Model type: Linear regression 
  + Estimation data: VE2001NHTS::Hh_df 
  + Estimation method: Package build 
  + Estimation script: R/CalculateVehicleTrips.R 
  + Model object: data/VehTrpLenModel_ls.rda 
  + Notes: Sources estimation data from the VE NHTS 2001 package. The final linear regression model is estimated following a two step process 

####  DivertSovTravel 

This module reduces household single-occupant vehicle (SOV) travel to achieve goals that are inputs to the model. The purpose of this module is to enable users to do 'what if' analysis of the potential of light-weight vehicles (e.g. bicycles, electric bikes, electric scooters) and infrastructure to support their use to reduce SOV travel 

* This module step uses data sources including NHTS 2001 
* This module step uses model types including Linear regression 
* This module step is estimated using the following methods: Package build 
* This module step is documented in inst/module_docs/DivertSovTravel.md 

The models in this model step are: 
 
* Model name: Model of Proportion of DVMT in Qualifying SOV Tours 
  + Model type: Linear regression 
  + Estimation data: VE2001NHTS::Hh_df 
  + Estimation method: Package build 
  + Estimation script: R/DivertSovTravel.R 
  + Model object: data/SovModel_ls.rda 
  + Notes: Sources estimation data from the VE NHTS 2001 package. The final linear regression model is estimated following a two step process 

* Model name: Metropolitan Area Model of Average Length of Trips in Qualifying SOV Tours 
  + Model type: Linear regression 
  + Estimation data: VE2001NHTS::Hh_df 
  + Estimation method: Package build 
  + Estimation script: R/DivertSovTravel.R 
  + Model object: data/SovModel_ls.rda 
  + Notes: Sources estimation data from the VE NHTS 2001 package. 

* Model name: Non-Metropolitan Area Model of Average Length of Trips in Qualifying SOV Tours 
  + Model type: Linear regression 
  + Estimation data: VE2001NHTS::Hh_df 
  + Estimation method: Package build 
  + Estimation script: R/DivertSovTravel.R 
  + Model object: data/SovModel_ls.rda 
  + Notes: Sources estimation data from the VE NHTS 2001 package. 

####  CalculateInducedDemand 

This module calculates average daily vehicle miles traveld for households. It also calculates average DVMT, daily consumption of fuel (in gallons), and average daily Co2 equivalent greenhouse emissions for all vehicles. 

This module step has no estimated parameters or other model types derived from data. 
 
####  CalculatePolicyVmt 

This module models adjusts the VMT for the policies entered for the scenario. The outputs form this module contains 'Policy' as the suffix in their names 

* This module step uses data sources including ? 
* This module step uses model types including Linear regression 
* This module step is estimated using the following methods: Parameters hardcoded in script 
* This module step is documented in R Script only, no md file produced 

The models in this model step are: 
 
* Model name: Metropolitan light vehicle ownership model 
  + Model type: Linear regression 
  + Estimation data: NA 
  + Estimation method: Parameters hardcoded in script 
  + Estimation script: R/CalculatePolicyVmt.R 
  + Model object: data/LtVehOwnModels_ls.rda 
  + Notes: This module has no estimated model parameters, derived from RPAT scripts. Original source of models is generally GreenSTEP models estimated with NHTS 2001 data, See inst/extdata/GreenSTEP_.RData 

* Model name: Non-Metropolitan light vehicle ownership model 
  + Model type: Linear regression 
  + Estimation data: NA 
  + Estimation method: Parameters hardcoded in script 
  + Estimation script: R/CalculatePolicyVmt.R 
  + Model object: data/LtVehOwnModels_ls.rda 
  + Notes: This module has no estimated model parameters, derived from RPAT scripts. Original source of models is generally GreenSTEP models estimated with NHTS 2001 data, See inst/extdata/GreenSTEP_.RData 

* Model name: Average single-occupant vehicle (SOV) travel proportion model 
  + Model type: Linear regression 
  + Estimation data: NA 
  + Estimation method: Parameters hardcoded in script 
  + Estimation script: R/CalculatePolicyVmt.R 
  + Model object: data/AveSovPropModels_ls.rda 
  + Notes: This module has no estimated model parameters, derived from RPAT scripts. Original source of models is generally GreenSTEP models estimated with NHTS 2001 data, See inst/extdata/GreenSTEP_.RData 

####  CalculateTravelDemand 

This module calculates average daily vehicle miles traveld for households. It also calculates average DVMT, daily consumption of fuel (in gallons), and average daily Co2 equivalent greenhouse emissions for all vehicles. 

* This module step uses data sources including NHTS 2001 and ? 
* This module step uses model types including Linear regression and Tabulation of data by vehicle vintage 
* This module step is estimated using the following methods: Parameters hardcoded in script and Data file in data-raw/PhevModelData_ls.rda 
* This module step is documented in R Script only, no md file produced 

The models in this model step are: 
 
* Model name: DVMT assignment models for metropolitan households (Ave DVMT, 95th percentile DVMT, and max DVMT) 
  + Model type: Linear regression 
  + Estimation data: NA 
  + Estimation method: Parameters hardcoded in script 
  + Estimation script: R/CalculateTravelDemand.R 
  + Model object: data/DvmtLmModels_ls.rda 
  + Notes: This module has no estimated model parameters, derived from RPAT scripts. Original source of models is generally GreenSTEP models estimated with NHTS 2001 data, See inst/extdata/GreenSTEP_.RData 

* Model name: DVMT assignment models for non-metropolitan households (Ave DVMT, 95th percentile DVMT, and max DVMT) 
  + Model type: Linear regression 
  + Estimation data: NA 
  + Estimation method: Parameters hardcoded in script 
  + Estimation script: R/CalculateTravelDemand.R 
  + Model object: data/DvmtLmModels_ls.rda 
  + Notes: This module has no estimated model parameters, derived from RPAT scripts. Original source of models is generally GreenSTEP models estimated with NHTS 2001 data, See inst/extdata/GreenSTEP_.RData 

* Model name: PHEV/HEV model: fixed characteristics files for PHEVs and HEVs from RPAT model 
  + Model type: Tabulation of data by vehicle vintage 
  + Estimation data: data-raw/PhevModelData_ls.rda 
  + Estimation method: Data file in data-raw/PhevModelData_ls.rda 
  + Estimation script: R/CalculateTravelDemand.R 
  + Model object: data/PhevModelData_ls.rda 
  + Notes: This module has no estimated model parameters, derived from RPAT scripts. Data file is a scenario input in GreenSTEP 

####  CalculateTravelDemandFuture 

This module calculates average daily vehicle miles traveld for households. It also calculates average DVMT, daily consumption of fuel (in gallons), and average daily Co2 equivalent greenhouse emissions for all vehicles. 

This module step has no estimated parameters or other model types derived from data. 
 
####  Initialize 

This module processes optional roadway DVMT and operations inputs. The optional roadway DVMT inputs allow users to specify base year roadway DVMT by vehicle type and how the DVMT by type splits across road classes. If these data are not provided, the model calculates values based on default data. 

This module step has no estimated parameters or other model types derived from data. 
 
####  LoadDefaultValues 

This module processes default carbon intensity of electricity consumption for all counties 

* This module step uses data sources including ? 
* This module step uses model types including Tabulation of data 
* This module step is estimated using the following methods: Data file in inst/extdata/power_co2.csv 
* This module step is documented in R Script only, no md file produced 

The models in this model step are: 
 
* Model name: C02 from Electricity 
  + Model type: Tabulation of data 
  + Estimation data: inst/extdata/power_co2.csv 
  + Estimation method: Data file in inst/extdata/power_co2.csv 
  + Estimation script: R/LoadDefaultValues.R 
  + Model object: data/TravelDemandDefaults_ls.rda 
  + Notes: This module has no estimated model parameters, derived from RPAT scripts. Uses deafult Power data, which are included in the inst/extdata fold 


###  VEHouseholdVehicles 

Vehicle ownership simulation package for VisionEval This package contains modules that work in the VisionEval framework to calculate vehicle ownership and to adjust ownership based on participation in carsharing programs
This modules contains the following step(s): 
 
####  AssignDrivers 

This module assigns drivers by age group to each household as a function of the numbers of persons and workers by age group, the household income, land use characteristics, and public transit availability. Users may specify the relative driver licensing rate relative to the model estimation data year in order to account for observed or projected changes in licensing rates. 

* This module step uses data sources including NHTS 2001 
* This module step uses model types including Binary Logit 
* This module step is estimated using the following methods: Package build 
* This module step is documented in inst/module_docs/AssignDrivers.md 

The models in this model step are: 
 
* Model name: Metropolitan Driver (license) Binary Model 
  + Model type: Binary Logit 
  + Estimation data: VE2001NHTS::Hh_df 
  + Estimation method: Package build 
  + Estimation script: R/AssignDrivers.R 
  + Model object: data/AssignDriversSpecifications.rda 
  + Notes: Sources estimation data from the VE NHTS 2001 package. 

* Model name: Non-metropolitan Driver (license) Binary Model 
  + Model type: Binary Logit 
  + Estimation data: VE2001NHTS::Hh_df 
  + Estimation method: Package build 
  + Estimation script: R/AssignDrivers.R 
  + Model object: data/AssignDriversSpecifications.rda 
  + Notes: Sources estimation data from the VE NHTS 2001 package. 

####  AssignVehicleAge 

This module assigns vehicle ages to each household vehicle. Vehicle age is assigned as a function of the vehicle type (auto or light truck), household income, and assumed mean vehicle age by vehicle type and Azone. Car service vehicles are assigned an age based on input assumptions with no distinction between vehicle type. 

* This module step uses data sources including NHTS 2001 
* This module step uses model types including Joint Probability Distributions 
* This module step is estimated using the following methods: Package build 
* This module step is documented in inst/module_docs/AssignVehicleAge.md 

The models in this model step are: 
 
* Model name: Joint probability distribution 
  + Model type: Joint Probability Distributions 
  + Estimation data: VE2001NHTS::Hh_df
VE2001NHTS::Veh_df 
  + Estimation method: Package build 
  + Estimation script: R/AssignVehicleAge.R 
  + Model object: data/AssignVehicleAgeSpecifications.rda 
  + Notes: Sources estimation data from the VE NHTS 2001 package. 

####  AssignVehicleOwnership 

This module determines the number of vehicles owned or leased by each household as a function of household characteristics, land use characteristics, and transportation system characteristics. 

* This module step uses data sources including NHTS 2001 
* This module step uses model types including Hurdle 
* This module step is estimated using the following methods: Package build 
* This module step is documented in inst/module_docs/AssignVehicleOwnership.md 

The models in this model step are: 
 
* Model name: Metropolitan Binary Logit Vehicle Ownership Model 
  + Model type: Hurdle 
  + Estimation data: VE2001NHTS::Hh_df 
  + Estimation method: Package build 
  + Estimation script: R/AssignVehicleOwnership.R 
  + Model object: data/AssignVehicleOwnershipSpecifications.rda 
  + Notes: Sources estimation data from the VE NHTS 2001 package. 

* Model name: Non-metropolitan Binary Logit Vehicle Ownership Model 
  + Model type: Hurdle 
  + Estimation data: VE2001NHTS::Hh_df 
  + Estimation method: Package build 
  + Estimation script: R/AssignVehicleOwnership.R 
  + Model object: data/AssignVehicleOwnershipSpecifications.rda 
  + Notes: Sources estimation data from the VE NHTS 2001 package. 

####  AssignVehicleType 

This module identifies how many household vehicles are light trucks and how many are automobiles. Light trucks include pickup trucks, sport utility vehicles, vans, and any other vehicle not classified as a passenger car. Automobiles are vehicles classified as passenger cars. 

* This module step uses data sources including NHTS 2001 
* This module step uses model types including Binary Logit 
* This module step is estimated using the following methods: Package build 
* This module step is documented in inst/module_docs/AssignVehicleType.md 

The models in this model step are: 
 
* Model name: Truck or Car binary logit 
  + Model type: Binary Logit 
  + Estimation data: VE2001NHTS::Hh_df 
  + Estimation method: Package build 
  + Estimation script: R/AssignVehicleType.R 
  + Model object: data/AssignVehicleTypeSpecifications.rda 
  + Notes: Sources estimation data from the VE NHTS 2001 package. 

####  CalculateVehicleOwnCost 

This module calculates average vehicle ownership cost for each vehicle based on the vehicle type and age using data from the American Automobile Association (AAA). 

* This module step uses data sources including AAA Costs 
* This module step uses model types including Log-Linear Depreciation 
* This module step is estimated using the following methods: Package build  
* This module step is documented in inst/module_docs/CalculateVehicleOwnCost.md 

The models in this model step are: 
 
* Model name: (log) Linear Age-Depreciation model 
  + Model type: Log-Linear Depreciation 
  + Estimation data: inst/extdata/aaa_vehicle_ownership_costs.txt 
  + Estimation method: Package build  
  + Estimation script: R/CalculateVehicleOwnCost.R 
  + Model object: data/CalculateVehicleOwnCostSpecifications.rda 
  + Notes: Uses AAA car ownership and depreciation model data 

####  CreateVehicleTable 

This module creates a vehicle table and populates it with household ID and geography fields. 

* This module step uses data sources including none 
* This module step uses model types including none 
* This module step is estimated using the following methods: Package build 
* This module step is documented in inst/module_docs/CreateVehicleTable.md 

The models in this model step are: 
 
* Model name: Creates vehicle table populated with household ID and geography 
  + Model type: NA 
  + Estimation data: NA 
  + Estimation method: Package build 
  + Estimation script: R/CreateVehicleTable.R 
  + Model object: data/CreateVehicleTableSpecifications.rda 
  + Notes: NA 

####  AdjustVehicleOwnership 

This module adjusts household vehicle ownership based on a comparison of the cost of owning a vehicle per mile of travel compared to the cost per mile of using a car service where the level of service is high. The determination of whether car services are substituted for ownership also depends on input assumptions regarding the average likelihood that an owner would substitute car services for a household vehicle. 

* This module step uses data sources including User specified from CreateVehicleTable 
* This module step uses model types including Deterministic (substitutes random portion of cases where car service is cheaper) 
* This module step is estimated using the following methods: Package build  
* This module step is documented in inst/module_docs/AdjustVehicleOwnership.md 

The models in this model step are: 
 
* Model name: Adjusts household vehicle ownership based on a comparison of the cost of owning a vehicle per mile of travel compared to the cost per mile of using a car service where the level of service is high 
  + Model type: Deterministic (substitutes random portion of cases where car service is cheaper) 
  + Estimation data: NA 
  + Estimation method: Package build  
  + Estimation script: R/AdjustVehicleOwnership.R 
  + Model object: data/AdjustVehicleOwnershipSpecifications.rda 
  + Notes: User input from csv 


###  VELandUse 

Land Use simulation package for VisionEval This package contains a number of modules that work in the VisionEval framework to calculate land use characteristics.
This modules contains the following step(s): 
 
####  AssignCarSvcAvailability 

This module reads in user specified data and assigns car service availability in Bzones. 

* This module step uses data sources including User specified from csv 
* This module step uses model types including none 
* This module step is estimated using the following methods: Package build  
* This module step is documented in inst/module_docs/AssignCarSvcAvailability.md 

The models in this model step are: 
 
* Model name: No Model 
  + Model type: NA 
  + Estimation data: bzone_carsvc_availability.csv 
  + Estimation method: Package build  
  + Estimation script: R/AssignCarSvcAvailability.R 
  + Model object: data/AssignCarSvcAvailabilitySpecifications.rda 
  + Notes: User input from csv 

####  AssignDemandManagement 

This module assigns demand management program participation to households and to workers. 

* This module step uses data sources including NHTS 2001 and default user specified from CSV 
* This module step uses model types including Proportions 
* This module step is estimated using the following methods: Package build  
* This module step is documented in inst/module_docs/AssignDemandManagement.md 

The models in this model step are: 
 
* Model name: Proportional VMT Reduction Estimation 
  + Model type: Proportions 
  + Estimation data: VE2001NHTS::Hh_df
VE2001NHTS::HhTours_df
inst/extdata/tdm_parameters.csv 
  + Estimation method: Package build  
  + Estimation script: R/AssignDemandManagement.R 
  + Model object: data/AssignDemandManagementSpecifications.rda 
  + Notes: Sources estimation data from the VE NHTS 2001 package and default user specifications 

####  AssignDevTypes 

This module assigns households to development types: Urban (located within an urbanized area boundary) and Rural (located outside of an urbanized area boundary). 

* This module step uses data sources including User specified from csv 
* This module step uses model types including Proportions 
* This module step is estimated using the following methods: Package build  
* This module step is documented in inst/module_docs/AssignDevTypes.md 

The models in this model step are: 
 
* Model name: Proportional assignment (Urban or Rural) 
  + Model type: Proportions 
  + Estimation data: bzone_urban_du_proportions.csv 
  + Estimation method: Package build  
  + Estimation script: R/AssignDevTypes.R 
  + Model object: data/AssignDevTypesSpecifications.rda 
  + Notes: User input from csv 

####  AssignLocTypes 

This module assigns households to location types: Urban (located within an urbanized area boundary), Town (located in a smaller urban area that does not have enough population to qualify as an urbanized area), and Rural (located in an area characterized by low density dispersed development). 

* This module step uses data sources including User specified 
* This module step uses model types including Proportions 
* This module step is estimated using the following methods: Package build  
* This module step is documented in inst/module_docs/AssignLocTypes.md 

The models in this model step are: 
 
* Model name: Proportional assignment (Urban, Town, Rural) 
  + Model type: Proportions 
  + Estimation data: bzone_urban-town_du_proportions.csv 
  + Estimation method: Package build  
  + Estimation script: R/AssignLocTypes.R 
  + Model object: data/AssignLocTypesSpecifications.rda 
  + Notes: User input from csv 

####  AssignParkingRestrictions 

This module identifies parking restrictions and prices affecting households at their residences, workplaces, and other places they are likely to visit in the urban area. 

* This module step uses data sources including User specified 
* This module step uses model types including Proportions 
* This module step is estimated using the following methods: Package build  
* This module step is documented in inst/module_docs/AssignParkingRestrictions.md 

The models in this model step are: 
 
* Model name: Proportional/Average assignment 
  + Model type: Proportions 
  + Estimation data: bzone_parking.csv 
  + Estimation method: Package build  
  + Estimation script: R/AssignParkingRestrictions.R 
  + Model object: data/AssignParkingRestrictionsSpecifications.rda 
  + Notes: User input from csv 

####  Calculate4DMeasures 

This module calculates several 4D measures by Bzone including density, diversity (i.e. mixing of land uses), transportation network design, and destination accessibility 

* This module step uses data sources including User specified 
* This module step uses model types including Closed formula 
* This module step is estimated using the following methods: Package build  
* This module step is documented in inst/module_docs/Calculate4DMeasures.md 

The models in this model step are: 
 
* Model name: Calculated entropy (diversity) and harmonic mean (accessibility) measures 
  + Model type: Closed formula 
  + Estimation data: bzone_unprotected_area.csv
bzone_network_design.csv 
  + Estimation method: Package build  
  + Estimation script: R/Calculate4DMeasures.R 
  + Model object: data/Calculate4DMeasuresSpecifications.rda 
  + Notes: User input from csv 

####  CalculateUrbanMixMeasures 

This module calculates an urban mixed-use measure based on the 2001 National Household Travel Survey measure of the tract level urban/rural indicator 

* This module step uses data sources including NHTS 2001 and default user specified from CSV 
* This module step uses model types including Binary Logit 
* This module step is estimated using the following methods: Package build  
* This module step is documented in inst/module_docs/CalculateUrbanMixMeasure.md 

The models in this model step are: 
 
* Model name: Probability that household is urban mixed-use (binary logit) 
  + Model type: Binary Logit 
  + Estimation data: VE2001NHTS::Hh_df
bzone_urban-mixed-use_prop.csv 
  + Estimation method: Package build  
  + Estimation script: R/CalculateUrbanMixMeasure.R 
  + Model object: data/CalculateUrbanMixMeasureSpecifications.rda 
  + Notes: Sources estimation data from the VE NHTS 2001 package and default user specifications 

####  LocateEmployment 

This module places employment in Bzones based on input assumptions of employment by type and Bzone 

* This module step uses data sources including User specified from csv 
* This module step uses model types including IPF 
* This module step is estimated using the following methods: Package build  
* This module step is documented in inst/module_docs/LocateEmployment.md 

The models in this model step are: 
 
* Model name: Iterative Proportional Fitting 
  + Model type: IPF 
  + Estimation data: bzone_employment.csv
bzone_lat_lon.csv 
  + Estimation method: Package build  
  + Estimation script: R/LocateEmployment.R 
  + Model object: data/LocateEmploymentSpecifications.rda 
  + Notes: User input from csv 

####  PredictHousing 

This module assigns a housing type, either single-family (SF) or multifamily (MF) to regular households based on the respective supplies of SF and MF dwelling units in the housing market to which the household is assigned (i.e. the Azone the household is assigned to) and on household characteristics. 

* This module step uses data sources including PUMS-based user specified csv 
* This module step uses model types including Binomial Logit & IPF 
* This module step is estimated using the following methods: Package build  
* This module step is documented in inst/module_docs/PredictHousing.md 

The models in this model step are: 
 
* Model name: Binary logit single family or multifamily dwelling and IPF to balance results 
  + Model type: Binomial Logit & IPF 
  + Estimation data: VESimHouseholds::Hh_df
bzone_hh_inc_qrtl_prop.csv
bzone_dwelling_units.csv 
  + Estimation method: Package build  
  + Estimation script: R/PredictHousing.R 
  + Model object: data/PredictHousingSpecifications.rda 
  + Notes: User input from csv 

####  CalculateBasePlaceTypes 

This module calculates place types for households and firms for the base year. 

* This module step uses data sources including User defined model and CSV 
* This module step uses model types including Linear 
* This module step is estimated using the following methods: Package build  
* This module step is documented in missing? 

The models in this model step are: 
 
* Model name: Random allocation based on linear model 
  + Model type: Linear 
  + Estimation data: VELandUse::HhAllocationModelCoeff_df
bzone_pop_emp_prop.csv 
  + Estimation method: Package build  
  + Estimation script: R/CalculateBasePlaceTypes.R 
  + Model object: data/CalculateBasePlaceTypesSpecifications.rda 
  + Notes: User input from csv 

####  CalculateFuturePlaceTypes 

This module calculates place types for households and firms for the future year. 

* This module step uses data sources including User defined model and CSV 
* This module step uses model types including Linear 
* This module step is estimated using the following methods: Package build  
* This module step is documented in missing? 

The models in this model step are: 
 
* Model name: Random allocation based on linear model 
  + Model type: Linear 
  + Estimation data: VELandUse::HhAllocationModelCoeff_df 
  + Estimation method: Package build  
  + Estimation script: R/CalculateFuturePlaceTypes.R 
  + Model object: data/CalculateFuturePlaceTypesSpecifications.rda 
  + Notes: User input from csv 


###  VEPowertrainsAndFuels 

VisionEval module for calculating energy consumption and emissions from transportation. Includes modules for inputting energy consumption characteristics of different vehicle technologies, carbon intensities of different fuels, functions for calculating energy consumption and emissions from household, commercial, and public transit travel.
This modules contains the following step(s): 
 
####  AssignHhVehiclePowertrain 

This module assigns a powertrain type to each household vehicle. The powertrain types are internal combustion engine vehicle (ICEV), hybrid electric vehicle (HEV), plug-in hybrid electric vehicle (PHEV), and battery electric vehicles (BEV). The module also assigns related characteristics to household vehicles 

* This module step uses data sources including NHTS 2001 
* This module step uses model types including lookup tables  
* This module step is estimated using the following methods: Package build  
* This module step is documented in inst/module_docs/AssignHhVehiclePowertrain.md 

The models in this model step are: 
 
* Model name: calculate the proportions of PHEV vehicle travel powered by electricity vs. fuel 
  + Model type: lookup tables  
  + Estimation data: VEHouseholdTravel::DvmtModel_ls 
  + Estimation method: Package build  
  + Estimation script: R/AssignHhVehiclePowertrain.R 
  + Model object: data/PhevElecProp_ls.rda 
  + Notes: Sources models estimated in the VEHouseholdTravel module that were estimated using data in the VE NHTS 2001 package 

####  CalculateCarbonIntensity 

This module calculates the average carbon intensity of fuels (grams CO2e per megajoule) by transportation mode and vehicle type. 

This module step has no estimated parameters or other model types derived from data. 
 
####  Initialize 

This module processes vehicle and fuel characteristics files that model users may optionally supply. When these files are supplied, modules in the package that compute carbon intensities of vehicle travel will use the user-supplied data instead of the datasets that are part of the package (see the LoadDefaultValues.R script) 

This module step has no estimated parameters or other model types derived from data. 
 
####  LoadDefaultValues 

Powertrain and fuels data are some of the most complex datasets used in VisionEval models to develop. To simplify matters for the user, default datasets are included in the package and are processed when the package is built. The user can then work with a simpler set of input files to develop scenarios. 

* This module step uses data sources including Described in text files in inst/extdata 
* This module step uses model types including Tabulation of data 
* This module step is estimated using the following methods: Data files in inst/extdata/power_co2.csv 
* This module step is documented in inst/module_docs/LoadDefaultValues.md 

The models in this model step are: 
 
* Model name: Default data for powertrain and fuels data 
  + Model type: Tabulation of data 
  + Estimation data: NA 
  + Estimation method: Data files in inst/extdata/power_co2.csv 
  + Estimation script: R/LoadDefaultValues.R 
  + Model object: data/PowertrainFuelDefaults_ls.rda 
  + Notes: Processes a large set of default data into a set of model inputs 


###  VESimHouseholds 

Household simulation package for VisionEval This package will contain a number of modules that work in the VisionEval framework to simulate households and their characteristics.
This modules contains the following step(s): 
 
####  AssignLifeCycle 

This module assigns a life cycle category to each household. The life cycle categories are similar, but not the same as, those established for the NHTS.  

This module step has no estimated parameters or other model types derived from data. 
 
####  CreateHouseholds 

This module creates a Household table in the datastore and populates the table with datasets characterizing simulated households. 

* This module step uses data sources including Census PUMS, OR 2000 Census data are included in the package 
* This module step uses model types including Tabulation of data 
* This module step is estimated using the following methods: Package Build 
* This module step is documented in inst/module_docs/CreateHouseholds.md 

The models in this model step are: 
 
* Model name: Probability matrix that a person in each age group is in one of several hundred regular household types 
  + Model type: Tabulation of data 
  + Estimation data: inst/extdata/pums_households.csv, inst/extdata/pums_persons.csv 
  + Estimation method: Package Build 
  + Estimation script: R/CreateHouseholds.R, R/CreateEstimationDatasets.R 
  + Model object: data/HtProb_HtAp.rda 
  + Notes: This module develops a table of probabilities processed in two scripts from Census PUMS data. The data in the package are for Oregon. 

####  PredictIncome 

This module predicts the income for each simulated household given the number of workers in each age group and the average per capita income for the Azone where the household resides. 

* This module step uses data sources including Census PUMS, OR 2000 Census data are included in the package 
* This module step uses model types including Linear regression 
* This module step is estimated using the following methods: Package Build 
* This module step is documented in inst/module_docs/PredictIncome.md 

The models in this model step are: 
 
* Model name: Household income linear model 
  + Model type: Linear regression 
  + Estimation data: inst/extdata/pums_households.csv, inst/extdata/pums_persons.csv 
  + Estimation method: Package Build 
  + Estimation script: R/PredictIncome.R, R/CreateEstimationDatasets.R 
  + Model object: data/HHIncModel_ls.rda 
  + Notes: This module develops regression models using data processed in a separate module script from Census PUMS data. The data in the package are for Oregon. 

* Model name: Group Quarters households income linear model 
  + Model type: Linear regression 
  + Estimation data: inst/extdata/pums_households.csv, inst/extdata/pums_persons.csv 
  + Estimation method: Package Build 
  + Estimation script: R/PredictIncome.R, R/CreateEstimationDatasets.R 
  + Model object: data/GQIncModel_ls.rda 
  + Notes: This module develops regression models using data processed in a separate module script from Census PUMS data. The data in the package are for Oregon. 

####  PredictWorkers 

This module assigns workers by age to households and to noninstitutional group quarters population. It is a simple model which predicts workers as a function of the age composition of household members. 

* This module step uses data sources including Census PUMS, OR 2000 Census data are included in the package 
* This module step uses model types including Tabulation of data 
* This module step is estimated using the following methods: Package Build 
* This module step is documented in inst/module_docs/PredictWorkers.md 

The models in this model step are: 
 
* Model name: Probability matrix that a person in each age group in a specified household type is a worker 
  + Model type: Tabulation of data 
  + Estimation data: inst/extdata/pums_households.csv, inst/extdata/pums_persons.csv 
  + Estimation method: Package Build 
  + Estimation script: R/PredictWokers.R, R/CreateEstimationDatasets.R 
  + Model object: data/PropHhWkr_HtAg.rda 
  + Notes: This module develops a table of probabilities processed in two scripts from Census PUMS data. The data in the package are for Oregon. 


###  VESimLandUse 

[Newer version of VELandUse?] This module assigns car service availability levels (Low, High) to Bzones and households. 
This modules contains the following step(s): 
 
####  AssignCarSvcAvailability 

This module assigns car service availability levels (Low, High) to Bzones and households.  

* This module step uses data sources including User specified from csv 
* This module step uses model types including none 
* This module step is estimated using the following methods: Package build  
* This module step is documented in inst/module_docs/AssignCarSvcAvailability.md 

The models in this model step are: 
 
* Model name: No Model 
  + Model type: NA 
  + Estimation data: bzone_carsvc_availability.csv 
  + Estimation method: Package build  
  + Estimation script: R/AssignCarSvcAvailability.R 
  + Model object: NA 
  + Notes: User input from csv 

####  AssignDemandManagement 

This module assigns demand management program participation to households and to workers. 

* This module step uses data sources including NHTS 2001 and default user specified from CSV 
* This module step uses model types including Proportions 
* This module step is estimated using the following methods: Package build  
* This module step is documented in inst/module_docs/AssignDemandManagement.md 

The models in this model step are: 
 
* Model name: Proportional VMT Reduction Estimation 
  + Model type: Proportions 
  + Estimation data: VE2001NHTS::Hh_df
VE2001NHTS::HhTours_df
inst/extdata/tdm_parameters.csv 
  + Estimation method: Package build  
  + Estimation script: R/AssignDemandManagement.R 
  + Model object: NA 
  + Notes: Sources estimation data from the VE NHTS 2001 package and default user specifications 

####  AssignParkingRestrictions 

This module identifies parking restrictions and prices affecting households at their residences, workplaces, and other places they are likely to visit in the urban area.  

* This module step uses data sources including User specified 
* This module step uses model types including Proportions 
* This module step is estimated using the following methods: Package build  
* This module step is documented in inst/module_docs/AssignParkingRestrictions.md 

The models in this model step are: 
 
* Model name: Proportional/Average assignment 
  + Model type: Proportions 
  + Estimation data: marea_parking-avail_by_area-type.csv
marea_parking-cost_by_area-type.csv 
  + Estimation method: Package build  
  + Estimation script: R/AssignParkingRestrictions.R 
  + Model object: NA 
  + Notes: User input from csv 

####  CreateSimBzoneModels 

This module estimates all the models for synthesizing Bzones and their land use attributes as a function of Azone characteristics as well as data derived from the US Environmental Protection Agency's Smart Location Database (SLD) augmented with US Census housing and household income data, and data from the National Transit Database. 

* This module step uses data sources including VESimLandUseData 
* This module step uses model types including Distributions 
* This module step is estimated using the following methods: Package build  
* This module step is documented in inst/module_docs/CreateSimBzoneModels.md 

The models in this model step are: 
 
* Model name: Distribution profiles 
  + Model type: Distributions 
  + Estimation data: VESimLandUseData::SimLandUseData_df 
  + Estimation method: Package build  
  + Estimation script: R/CreateSimBzoneModels.R 
  + Model object: data/SimBzone_ls.rda
data/UsaBlkGrpTypes_df.rda 
  + Notes: NA 

####  CreateSimBzones 

This module synthesizes Bzones and their land use attributes as a function of Azone characteristics as well as data derived from the US Environmental Protection Agency's Smart Location Database (SLD) augmented with US Census housing and household income data, and data from the National Transit Database.  

* This module step uses data sources including VESimLandUseData 
* This module step uses model types including Calculation steps 
* This module step is estimated using the following methods: Package build  
* This module step is documented in inst/module_docs/CreateSimBzones.md 

The models in this model step are: 
 
* Model name: Calculation steps 
  + Model type: Calculation steps 
  + Estimation data: VESimLandUse::SimBzone_ls 
  + Estimation method: Package build  
  + Estimation script: R/CreateSimBzones.R 
  + Model object: NA 
  + Notes: NA 

####  Initialize 

Initialization and data check 

This module step has no estimated parameters or other model types derived from data. 
 
####  Simulate4DMeasures 

This module calculates several 4D measures by SimBzone including density, diversity (i.e. mixing of land uses), and pedestrian-orientedn transportation network design. 

* This module step uses data sources including User specified 
* This module step uses model types including Closed formula 
* This module step is estimated using the following methods: Package build  
* This module step is documented in inst/module_docs/Simulate4DMeasures.md 

The models in this model step are: 
 
* Model name: Calculated entropy (diversity) and harmonic mean (accessibility) measures 
  + Model type: Closed formula 
  + Estimation data: marea_d3bpo4_adj.csv
bzone_network_design.csv 
  + Estimation method: Package build  
  + Estimation script: R/Simulate4DMeasures.R 
  + Model object: NA 
  + Notes: NA 

####  SimulateEmployment 

This module assign workers SimBzone work locations. A worker table is created which identifies a unique worker ID, the household ID the worker is a part of, and the SimBzone, Azone, and Marea of the worker job location. 

* This module step uses data sources including none 
* This module step uses model types including Rule based assignment 
* This module step is estimated using the following methods: Package build  
* This module step is documented in inst/module_docs/SimulateEmployment.md 

The models in this model step are: 
 
* Model name: Workers are assigned to Bzone job locations using simple rules 
  + Model type: Rule based assignment 
  + Estimation data: NA 
  + Estimation method: Package build  
  + Estimation script: R/SimulateEmployment.R 
  + Model object: NA 
  + Notes: NA 

####  Simulate Housing 

This module assigns a housing type, either single-family (SF) or multifamily (MF) to regular households based on the respective supplies of SF and MF dwelling units in the housing market to which the household is assigned (i.e. the Azone the household is assigned to) and on household characteristics.  

* This module step uses data sources including VELandUse 
* This module step uses model types including Binary search algorithm 
* This module step is estimated using the following methods: Package build  
* This module step is documented in inst/module_docs/SimulateHousing.md 

The models in this model step are: 
 
* Model name: housing choice model estimated by the 'PredictHousing' module in the 'VELandUse' package. 
  + Model type: Binary search algorithm 
  + Estimation data: VELandUse::HouseTypeModel_ls 
  + Estimation method: Package build  
  + Estimation script: R/SimulateHousing.R 
  + Model object: NA 
  + Notes: NA 

####  SimulateUrbanMixMeasure 

This module simulates an urban mixed-use measure based on the 2001 National Household Travel Survey measure of the tract level urban/rural indicator. 

* This module step uses data sources including VELandUse 
* This module step uses model types including Binary Logit 
* This module step is estimated using the following methods: Package build  
* This module step is documented in inst/module_docs/SimulateUrbanMixMeasure.md 

The models in this model step are: 
 
* Model name: binary logit model estimated in the CalculateUrbanMixMeasure module of the VELandUse package 
  + Model type: Binary Logit 
  + Estimation data: VELandUse::UrbanMixModel_ls 
  + Estimation method: Package build  
  + Estimation script: R/SimulateUrbanMixMeasure.R 
  + Model object: data/UrbanMixModelSim_ls.rda 
  + Notes: NA 


###  VESimLandUseData 

This package processes data from several sources to produce a dataset that is used to estimate several models for synthesizing Bzones and their likely land use attributes.
This modules contains the following step(s): 
 
####  MakeSimBzoneEstDataset 

This script combines data from the US Census, the EPA Smart Location Database (SLD), and the National Transit Database 

This module step has no estimated parameters or other model types derived from data. 
 

###  VESimTransportSupply 

NA
This modules contains the following step(s): 
 
####  NA 

NA 

This module step has no estimated parameters or other model types derived from data. 
 

###  VESyntheticFirms 

VisionEval Synthetic Firms module
This modules contains the following step(s): 
 
####  CreateBaseSyntheticFirms 

Creates a list of base year synthetic firms 

This module step has no estimated parameters or other model types derived from data. 
 
####  CreateFutureSyntheticFirms 

Creates a list of future year synthetic firms 

This module step has no estimated parameters or other model types derived from data. 
 

###  VETransportSupply 

This package contains a number of modules that work in the VisionEval framework to calculate transportation supply characteristics including roadway supply and public transit supply.
This modules contains the following step(s): 
 
####  SimulateRoadMiles 

This module assigns freeway and arterial lane-miles to metropolitan areas (Marea) and calculates freeway lane-miles per capita.
 

* This module step uses data sources including User specified 
* This module step uses model types including Calculation steps 
* This module step is estimated using the following methods: Package build  
* This module step is documented in inst/module_docs/AssignRoadMiles.md 

The models in this model step are: 
 
* Model name: computes the value of freeway lane-miles per capita 
  + Model type: Calculation steps 
  + Estimation data: data/marea_lane_miles.csv 
  + Estimation method: Package build  
  + Estimation script: R/AssignRoadMiles.R 
  + Model object: NA 
  + Notes: NA 

####  SimulateTransitService 

This module assigns transit service level to the urbanized portion of each Marea and to neighborhoods (SimBzones) within the urbanized area. 

This module step has no estimated parameters or other model types derived from data. 
 

###  VETransportSupplyUse 

VisionEval module for roadway speeds, delay, and congestion costs using run year data
This modules contains the following step(s): 
 
####  CalculateCongestionBase 

This module calculates the amount of congestion for base year - automobile, light truck, truck, and bus vmt are allocated to freeways, arterials, and other roadways. 

* This module step uses data sources including User specified 
* This module step uses model types including Delay-based 
* This module step is estimated using the following methods: Package build  
* This module step is documented in R Script only, no md file produced 

The models in this model step are: 
 
* Model name: Speed estimated from demand vs lane-mile supply 
  + Model type: Delay-based 
  + Estimation data: azone_its_prop.csv 
  + Estimation method: Package build  
  + Estimation script: R/CalculateCongestionBase.R 
  + Model object: data/CongModel_ls.rda 
  + Notes: NA 

####  CalculateCongestionFuture 

This module calculates the amount of congestion for future year - automobile, light truck, truck, and bus vmt are allocated to freeways, arterials, and other roadways. 

* This module step uses data sources including User specified 
* This module step uses model types including Delay-based 
* This module step is estimated using the following methods: Package build  
* This module step is documented in R Script only, no md file produced 

The models in this model step are: 
 
* Model name: Speed estimated from demand vs lane-mile supply 
  + Model type: Delay-based 
  + Estimation data: NA 
  + Estimation method: Package build  
  + Estimation script: R/CalculateCongestionFuture.R 
  + Model object: NA 
  + Notes: NA 

####  CalculateCongestionPolicy 

This module calculates the amount of congestion - automobile, light truck, truck, and bus vmt are allocated to freeways, arterials, and other roadways adjusted by policy applied for the selected scenario. 

* This module step uses data sources including User specified 
* This module step uses model types including Delay-based 
* This module step is estimated using the following methods: Package build  
* This module step is documented in R Script only, no md file produced 

The models in this model step are: 
 
* Model name: Speed estimated from demand vs lane-mile supply, adjusted by intervention policy 
  + Model type: Delay-based 
  + Estimation data: NA 
  + Estimation method: Package build  
  + Estimation script: R/CalculateCongestionPolicy.R 
  + Model object: NA 
  + Notes: NA 


###  VETravelDemandMM 

This package contains a module for the VisionEval framework that simulates multi-modal travel demand for individual households
This modules contains the following step(s): 
 
####  CalculateAltModeTrips 

Predicts transit, bike, walk PMT and trips 

* This module step uses data sources including NHTS 2009, FHWA HPMS, FTA NTD, EPA SLD 
* This module step uses model types including Hurdle and Linear regression 
* This module step is estimated using the following methods: Pre-estimated, saved objects in data-raw/estimated 
* This module step is documented in inst/module_docs/CalculateAltModeTrips.md 

The models in this model step are: 
 
* Model name: Bike PMT for metropolitan households 
  + Model type: Hurdle 
  + Estimation data: inst/extdata/sources.md, confidential data not included in package 
  + Estimation method: Pre-estimated, saved objects in data-raw/estimated 
  + Estimation script: data-raw/BikePMTModel_df.R 
  + Model object: data/BikePMTModel_df.rda 
  + Notes: This model uses confidential spatial elements of the NHTS 2009 data to link to the EPA Smart Location Database. The estimated models are included with the package but not the estimation dataset. 

* Model name: Bike PMT for non-metropolitan households 
  + Model type: Hurdle 
  + Estimation data: inst/extdata/sources.md, confidential data not included in package 
  + Estimation method: Pre-estimated, saved objects in data-raw/estimated 
  + Estimation script: data-raw/BikePMTModel_df.R 
  + Model object: data/BikePMTModel_df.rda 
  + Notes: This model uses confidential spatial elements of the NHTS 2009 data to link to the EPA Smart Location Database. The estimated models are included with the package but not the estimation dataset. 

* Model name: Bike trip freqiency for metropolitan households 
  + Model type: Hurdle 
  + Estimation data: inst/extdata/sources.md, confidential data not included in package 
  + Estimation method: Pre-estimated, saved objects in data-raw/estimated 
  + Estimation script: data-raw/BikeTFLModel_df.R 
  + Model object: data/BikeTFLModel_df.rda 
  + Notes: This model uses confidential spatial elements of the NHTS 2009 data to link to the EPA Smart Location Database. The estimated models are included with the package but not the estimation dataset. 

* Model name: Bike trip freqiency for non-metropolitan households 
  + Model type: Hurdle 
  + Estimation data: inst/extdata/sources.md, confidential data not included in package 
  + Estimation method: Pre-estimated, saved objects in data-raw/estimated 
  + Estimation script: data-raw/BikeTFLModel_df.R 
  + Model object: data/BikeTFLModel_df.rda 
  + Notes: This model uses confidential spatial elements of the NHTS 2009 data to link to the EPA Smart Location Database. The estimated models are included with the package but not the estimation dataset. 

* Model name: Bike trip average distance for metropolitan households 
  + Model type: Linear regression 
  + Estimation data: inst/extdata/sources.md, confidential data not included in package 
  + Estimation method: Pre-estimated, saved objects in data-raw/estimated 
  + Estimation script: data-raw/BikeTFLModel_df.R 
  + Model object: data/BikeTFLModel_df.rda 
  + Notes: This model uses confidential spatial elements of the NHTS 2009 data to link to the EPA Smart Location Database. The estimated models are included with the package but not the estimation dataset. 

* Model name: Bike trip average distance for non-metropolitan households 
  + Model type: Linear regression 
  + Estimation data: inst/extdata/sources.md, confidential data not included in package 
  + Estimation method: Pre-estimated, saved objects in data-raw/estimated 
  + Estimation script: data-raw/BikeTFLModel_df.R 
  + Model object: data/BikeTFLModel_df.rda 
  + Notes: This model uses confidential spatial elements of the NHTS 2009 data to link to the EPA Smart Location Database. The estimated models are included with the package but not the estimation dataset. 

* Model name: Transit PMT for metropolitan households 
  + Model type: Hurdle 
  + Estimation data: inst/extdata/sources.md, confidential data not included in package 
  + Estimation method: Pre-estimated, saved objects in data-raw/estimated 
  + Estimation script: data-raw/TransitPMTModel_df.R 
  + Model object: data/TransitPMTModel_df.rda 
  + Notes: This model uses confidential spatial elements of the NHTS 2009 data to link to the EPA Smart Location Database. The estimated models are included with the package but not the estimation dataset. 

* Model name: Transit PMT for non-metropolitan households 
  + Model type: Hurdle 
  + Estimation data: inst/extdata/sources.md, confidential data not included in package 
  + Estimation method: Pre-estimated, saved objects in data-raw/estimated 
  + Estimation script: data-raw/TransitPMTModel_df.R 
  + Model object: data/TransitPMTModel_df.rda 
  + Notes: This model uses confidential spatial elements of the NHTS 2009 data to link to the EPA Smart Location Database. The estimated models are included with the package but not the estimation dataset. 

* Model name: Transit trip freqiency for metropolitan households 
  + Model type: Hurdle 
  + Estimation data: inst/extdata/sources.md, confidential data not included in package 
  + Estimation method: Pre-estimated, saved objects in data-raw/estimated 
  + Estimation script: data-raw/TransitTFLModel_df.R 
  + Model object: data/TransitTFLModel_df.rda 
  + Notes: This model uses confidential spatial elements of the NHTS 2009 data to link to the EPA Smart Location Database. The estimated models are included with the package but not the estimation dataset. 

* Model name: Transit trip freqiency for non-metropolitan households 
  + Model type: Hurdle 
  + Estimation data: inst/extdata/sources.md, confidential data not included in package 
  + Estimation method: Pre-estimated, saved objects in data-raw/estimated 
  + Estimation script: data-raw/TransitTFLModel_df.R 
  + Model object: data/TransitTFLModel_df.rda 
  + Notes: This model uses confidential spatial elements of the NHTS 2009 data to link to the EPA Smart Location Database. The estimated models are included with the package but not the estimation dataset. 

* Model name: Transit trip average distance for metropolitan households 
  + Model type: Linear regression 
  + Estimation data: inst/extdata/sources.md, confidential data not included in package 
  + Estimation method: Pre-estimated, saved objects in data-raw/estimated 
  + Estimation script: data-raw/TransitTFLModel_df.R 
  + Model object: data/TransitTFLModel_df.rda 
  + Notes: This model uses confidential spatial elements of the NHTS 2009 data to link to the EPA Smart Location Database. The estimated models are included with the package but not the estimation dataset. 

* Model name: Transit trip average distance for non-metropolitan households 
  + Model type: Linear regression 
  + Estimation data: inst/extdata/sources.md, confidential data not included in package 
  + Estimation method: Pre-estimated, saved objects in data-raw/estimated 
  + Estimation script: data-raw/TransitTFLModel_df.R 
  + Model object: data/TransitTFLModel_df.rda 
  + Notes: This model uses confidential spatial elements of the NHTS 2009 data to link to the EPA Smart Location Database. The estimated models are included with the package but not the estimation dataset. 

* Model name: Walk PMT for metropolitan households 
  + Model type: Hurdle 
  + Estimation data: inst/extdata/sources.md, confidential data not included in package 
  + Estimation method: Pre-estimated, saved objects in data-raw/estimated 
  + Estimation script: data-raw/WalkPMTModel_df.R 
  + Model object: data/WalkPMTModel_df.rda 
  + Notes: This model uses confidential spatial elements of the NHTS 2009 data to link to the EPA Smart Location Database. The estimated models are included with the package but not the estimation dataset. 

* Model name: Walk PMT for non-metropolitan households 
  + Model type: Hurdle 
  + Estimation data: inst/extdata/sources.md, confidential data not included in package 
  + Estimation method: Pre-estimated, saved objects in data-raw/estimated 
  + Estimation script: data-raw/WalkPMTModel_df.R 
  + Model object: data/WalkPMTModel_df.rda 
  + Notes: This model uses confidential spatial elements of the NHTS 2009 data to link to the EPA Smart Location Database. The estimated models are included with the package but not the estimation dataset. 

* Model name: Walk trip freqiency for metropolitan households 
  + Model type: Hurdle 
  + Estimation data: inst/extdata/sources.md, confidential data not included in package 
  + Estimation method: Pre-estimated, saved objects in data-raw/estimated 
  + Estimation script: data-raw/WalkTFLModel_df.R 
  + Model object: data/WalkTFLModel_df.rda 
  + Notes: This model uses confidential spatial elements of the NHTS 2009 data to link to the EPA Smart Location Database. The estimated models are included with the package but not the estimation dataset. 

* Model name: Walk trip freqiency for non-metropolitan households 
  + Model type: Hurdle 
  + Estimation data: inst/extdata/sources.md, confidential data not included in package 
  + Estimation method: Pre-estimated, saved objects in data-raw/estimated 
  + Estimation script: data-raw/WalkTFLModel_df.R 
  + Model object: data/WalkTFLModel_df.rda 
  + Notes: This model uses confidential spatial elements of the NHTS 2009 data to link to the EPA Smart Location Database. The estimated models are included with the package but not the estimation dataset. 

* Model name: Walk trip average distance for metropolitan households 
  + Model type: Linear regression 
  + Estimation data: inst/extdata/sources.md, confidential data not included in package 
  + Estimation method: Pre-estimated, saved objects in data-raw/estimated 
  + Estimation script: data-raw/WalkTFLModel_df.R 
  + Model object: data/WalkTFLModel_df.rda 
  + Notes: This model uses confidential spatial elements of the NHTS 2009 data to link to the EPA Smart Location Database. The estimated models are included with the package but not the estimation dataset. 

* Model name: Walk trip average distance for non-metropolitan households 
  + Model type: Linear regression 
  + Estimation data: inst/extdata/sources.md, confidential data not included in package 
  + Estimation method: Pre-estimated, saved objects in data-raw/estimated 
  + Estimation script: data-raw/WalkTFLModel_df.R 
  + Model object: data/WalkTFLModel_df.rda 
  + Notes: This model uses confidential spatial elements of the NHTS 2009 data to link to the EPA Smart Location Database. The estimated models are included with the package but not the estimation dataset. 

####  CalculateHouseholdDvmt 

This module predicts AADVMT for households. It uses the model object in data/AADVMTModel_df.rda and variables and coefficients therein to predict AADVMT. 

* This module step uses data sources including NHTS 2009, FHWA HPMS, FTA NTD, EPA SLD and NHTS 2001 
* This module step uses model types including Linear regression 
* This module step is estimated using the following methods: Pre-estimated, saved objects in data-raw/estimated 
* This module step is documented in inst/module_docs/CalculateHouseholdDVMT.md and inst/module_docs/HouseholdDvmtQuantileEstimation.md 

The models in this model step are: 
 
* Model name: Household Dvmt for metropolitan households 
  + Model type: Linear regression 
  + Estimation data: inst/extdata/sources.md, confidential data not included in package 
  + Estimation method: Pre-estimated, saved objects in data-raw/estimated 
  + Estimation script: data-raw/AADVMTModel_df.R 
  + Model object: data/AADVMTModel_df.rda 
  + Notes: This model uses confidential spatial elements of the NHTS 2009 data to link to the EPA Smart Location Database. The estimated models are included with the package but not the estimation dataset. 

* Model name: Household Dvmt for non-metropolitan households 
  + Model type: Linear regression 
  + Estimation data: inst/extdata/sources.md, confidential data not included in package 
  + Estimation method: Pre-estimated, saved objects in data-raw/estimated 
  + Estimation script: data-raw/AADVMTModel_df.R 
  + Model object: data/AADVMTModel_df.rda 
  + Notes: This model uses confidential spatial elements of the NHTS 2009 data to link to the EPA Smart Location Database. The estimated models are included with the package but not the estimation dataset. 

* Model name: 95th percentile DVMT model for metropolitan households 
  + Model type: Linear regression 
  + Estimation data: inst/extdata/sources.md, confidential data not included in package 
  + Estimation method: Pre-estimated, saved objects in data-raw/estimated 
  + Estimation script: data-raw/HouseholdDvmtQuantileEstimation.R 
  + Model object: data/DvmtModel_ls.rda 
  + Notes: These models and estimation scripts are included in this package and were transferred from the VEHouseholdTravel module 

* Model name: 95th percentile DVMT model for non-metropolitan households 
  + Model type: Linear regression 
  + Estimation data: inst/extdata/sources.md, confidential data not included in package 
  + Estimation method: Pre-estimated, saved objects in data-raw/estimated 
  + Estimation script: data-raw/HouseholdDvmtQuantileEstimation.R 
  + Model object: data/DvmtModel_ls.rda 
  + Notes: These models and estimation scripts are included in this package and were transferred from the VEHouseholdTravel module 

####  PredictDrivers 

This module predicts number of licensed drivers for households. It uses the model object in data/DriversModel_df.rda (ordered logit model by default) and variables and coefficients therein to predict Drivers. 

* This module step uses data sources including NHTS 2009, FHWA HPMS, FTA NTD, EPA SLD 
* This module step uses model types including Ordered logit 
* This module step is estimated using the following methods: Pre-estimated, saved objects in data-raw/estimated 
* This module step is documented in inst/module_docs/PredictDrivers.md 

The models in this model step are: 
 
* Model name: Drivers in the household 
  + Model type: Ordered logit 
  + Estimation data: inst/extdata/sources.md, confidential data not included in package 
  + Estimation method: Pre-estimated, saved objects in data-raw/estimated 
  + Estimation script: data-raw/DriversModel_df.R 
  + Model object: data/DriversModel_df.rda 
  + Notes: This model uses confidential spatial elements of the NHTS 2009 data to link to the EPA Smart Location Database. The estimated models are included with the package but not the estimation dataset. 

####  PredictVehicles 

This module predicts number of light-duty vehicles for households. It uses the model object in data/VehiclesModel_df.rda (ordered logit model by default) and variables and coefficients therein to predict number of vehicles. 

* This module step uses data sources including NHTS 2009, FHWA HPMS, FTA NTD, EPA SLD 
* This module step uses model types including Ordered logit 
* This module step is estimated using the following methods: Pre-estimated, saved objects in data-raw/estimated 
* This module step is documented in inst/module_docs/PredictVehicles.md 

The models in this model step are: 
 
* Model name: Number of light duty vehicles 
  + Model type: Ordered logit 
  + Estimation data: inst/extdata/sources.md, confidential data not included in package 
  + Estimation method: Pre-estimated, saved objects in data-raw/estimated 
  + Estimation script: data-raw/VehiclesModel_df.R 
  + Model object: data/VehiclesModel_df.rda 
  + Notes: This model uses confidential spatial elements of the NHTS 2009 data to link to the EPA Smart Location Database. The estimated models are included with the package but not the estimation dataset. 


###  VETravelPerformance 

Travel performance metrics
This modules contains the following step(s): 
 
####  AdjustHhVehicleMpgMpkwh 

This module adjusts the fuel economy (MPG) and power efficiency (MPKWH) of household vehicles to reflect the effects of congestion, speed smoothing, and eco-driving that are calculated by the CalculateMpgMpkwhAdjustments module. 

This module step has no estimated parameters or other model types derived from data. 
 
####  BalanceRoadCostsAndRevenues 

This module calculates an extra mileage tax ($ per vehicle mile traveled) for household vehicles needed to make up any difference in the cost of constructing, maintaining, and operating roadways and the revenues from fuel, VMT, and congestion taxes. 

This module step has no estimated parameters or other model types derived from data. 
 
####  BudgetHouseholdDvmt 

This module adjusts average household DVMT to keep the quantity within the limit of the household vehicle operating cost budget.  

* This module step uses data sources including US BEA CES 
* This module step uses model types including Linear regression 
* This module step is estimated using the following methods: Package Build 
* This module step is documented in inst/module_docs/BudgetHouseholdDvmt.md 

The models in this model step are: 
 
* Model name: model to calculate the maximum proportion of household income a household is willing to pay to operate vehicles used by the household 
  + Model type: Linear regression 
  + Estimation data: inst/extdata/ces_vehicle_op-cost.csv 
  + Estimation method: Package Build 
  + Estimation script: R/BudgetHouseholdDvmt.R 
  + Model object: data/OpPropModel_ls.rda 
  + Notes: Estimated model uses CES data, script inst/extdata/ces.R processes data into the format for the estimation input dataset 

####  CalculateComEnergyAndEmissions 

This module calculates the energy consumption and carbon emissions of heavy trucks and light-duty commercial service vehicles.  

This module step has no estimated parameters or other model types derived from data. 
 
####  CalculateMpgMpkwhAdjustments 

This module calculates adjustments to fuel economy and electric energy efficiency (for plug-in vehicles) resulting from traffic congestion, speed smoothing (i.e. active traffic management which reduces speed variation), and eco-driving. Eco-driving is the practice of driving in ways that increase fuel economy and reduce carbon emissions. 

* This module step uses data sources including Outputs from EPA PERE model 
* This module step uses model types including Tabulation of data 
* This module step is estimated using the following methods: Package Build 
* This module step is documented in inst/module_docs/CalculateMpgMpkwhAdjustments.md 

The models in this model step are: 
 
* Model name: Model of the Effects of Speed on Fuel Economy 
  + Model type: Tabulation of data 
  + Estimation data: vehicle_fuel_speed_curves.csv 
  + Estimation method: Package Build 
  + Estimation script: R/CalculateMpgMpkwhAdjustments.R 
  + Model object: data/MpgMpkwhAdj_ls.rda 
  + Notes: Model is based on outputs from the EPA's PERE model, estimation here is limited to tabulation and other simple processing  

* Model name: Speed Smoothing and Eco-driving Model 
  + Model type: Tabulation of data 
  + Estimation data: max_smooth_improve.csv 
  + Estimation method: Package Build 
  + Estimation script: R/CalculateMpgMpkwhAdjustments.R 
  + Model object: data/MpgMpkwhAdj_ls.rda 
  + Notes: Model is based on outputs from the EPA's PERE model, estimation here is limited to tabulation and other simple processing  

####  CalculatePtranEnergyAndEmissions 

This module calculates the energy consumption and carbon emissions from public transportation vehicles in urbanized areas. Note that fuel consumption and emissions from car services (e.g. taxi, Uber, Lyft) are calculated in conjunction with the calculation of household vehicle emissions and are attributed to the household. 

This module step has no estimated parameters or other model types derived from data. 
 
####  CalculateRoadDvmt 

module computes several factors used in computing roadway DVMT including factors for calculating commercial service vehicle travel and heavy truck travel.  

This module step has no estimated parameters or other model types derived from data. 
 
####  CalculateRoadPerformance 

This module calculates freeway and arterial congestion level and the amounts of DVMT by congestion level. It also calculates the average speed and delay at each congestion level. In addition, it splits light-duty vehicle (LDV) DVMT between freeways and arterials as a function of relative speeds and congestion prices 

* This module step uses data sources including 2009 Urban Mobility Study and NHTS 2017 research by Bigazzi and Clifton and NHTS 2017 
* This module step uses model types including lookup tables  and Lookup tables and equation Linear regression and Lookup tables and equation 
* This module step is estimated using the following methods: Package Build 
* This module step is documented in inst/module_docs/CalculateRoadPerformance.md 

The models in this model step are: 
 
* Model name: Model of Congestion as a Function of Daily Demand 
  + Model type: lookup tables  
  + Estimation data: inst/extdata/ums_2009.csv 
  + Estimation method: Package Build 
  + Estimation script: R/CalculateRoadPerformance.R 
  + Model object: data/CongestedProportions_ls.rda 
  + Notes: This module estimates models using Urban mobility study data 

* Model name: Model of Congested Speeds and the Effects of Operations Programs (e.g. ramp metering, signal coordination) 
  + Model type: lookup tables  
  + Estimation data: inst/extdata/base_speeds.csv, ramp_metering.csv, incident_management.csv, signal_coordination.csv, access_management.csv 
  + Estimation method: Package Build 
  + Estimation script: R/CalculateRoadPerformance.R, CalculateSpeeds.R 
  + Model object: data/BaseSpeeds_df.rda, data/Delay_df.rda, data/Ramp_df.rda, data/Incident_df.rda, data/Signal_df.rda, data/Access_df.rda 
  + Notes: This module estimates models based on research documented in the package 

* Model name: Model of the Split of Light-duty Vehicle (LDV) DVMT between Freeways and Arterials 
  + Model type: Linear regression 
  + Estimation data: inst/extdata/ums_2009.csv 
  + Estimation method: Package Build 
  + Estimation script: R/CalculateRoadPerformance.R 
  + Model object: data/DvmtSplit_LM.rda 
  + Notes: This module estimates models using Urban mobility study data 

* Model name: Model to Calculate Average Non-urban Road Speed from Average Urban Road Speed 
  + Model type: Lookup tables and equation 
  + Estimation data: inst/extdata/urban_rural_trip_length_duration.csv 
  + Estimation method: Package Build 
  + Estimation script: R/CalculateRoadPerformance.R 
  + Model object: data/UrbanRuralAveSpeed_ls.rda 
  + Notes: This module estimates models using NHTS 2017 data tabulated and included in the package 

####  CalculateSafetyMeasures 

This module aims to calculate safety measures for the model area. It uses the fatality and injury crash rates for different modes All these rates are per miles traveled. Therefore this module simply uses calculated VMT from model to estimate the fatality and injury rates for Marea. 

This module step has no estimated parameters or other model types derived from data. 
 
####  CalculateHhVehicleOperatingCosts 

This module calculates vehicle operating costs per mile of travel and uses those costs to determine the proportional split of DVMT among household vehicles. The module also calculates the average out-of-pocket costs per mile of vehicle travel by household, as well as the cost of social and environmental impacts, and road use taxes per mile of vehicle travel. 

* This module step uses data sources including ? and data from the American Automobile Association and the Bureau of Labor Statistics 
* This module step uses model types including Cobb-Douglas utility function and Products of rates 
* This module step is estimated using the following methods: Package Build 
* This module step is documented in inst/module_docs/CalculateVehicleOperatingCost.md 

The models in this model step are: 
 
* Model name: model for splitting household DVMT among household vehicles as a function of the unit cost of using each vehicle 
  + Model type: Cobb-Douglas utility function 
  + Estimation data: ? 
  + Estimation method: Package Build 
  + Estimation script: R/CalculateVehicleOperatingCost.R 
  + Model object: data/OpCosts_ls.rda 
  + Notes: Missing estimation script and data for this model? 

* Model name: Models for Calculating Out-of-pocket Costs 
  + Model type: Products of rates 
  + Estimation data: deflators.csv, aa_vehicle_operating_costs.csv 
  + Estimation method: Package Build 
  + Estimation script: R/CalculateVehicleOperatingCost.R 
  + Model object: data/OpCosts_ls.rda 
  + Notes: This module estimates models using BLS and AAA data 

####  LoadDefaultRoadDvmtValues 

This script calculates default values for base year roadway DVMT by vehicle type (light-duty, heavy truck, bus), the distribution of roadway DVMT by vehicle type to roadway classes (freeway, arterial, other), and the ratio of commercial service light-duty vehicle travel to household vehicle travel.  

This module step has no estimated parameters or other model types derived from data. 
 
####  TravelTimeReliability 

This module calculates travel time reliability measures for the model area. Average speeds at different congestion levels (None, Mod, Hvy, Sev, Ext) on freeways and arterials by marea calculated in the CalculateRoadPerformance Module are used as inputs to calculate travel time index.  

This module step has no estimated parameters or other model types derived from data. 
 

###  VEReports 

This module calculates and reports various performance metrics
This modules contains the following step(s): 
 
####  ReportRPATMetrics 

This module calculates and reports various performance metrics. These performance metrics include environment and energey impacts, financial and economic impacts, and community impacts. 

* This module step uses data sources including ? 
* This module step uses model types including Tabulation of data 
* This module step is estimated using the following methods: Data file in inst/extdata/TruckBusAgeDist_.Rdata 
* This module step is documented in R Script only, no md file produced 

The models in this model step are: 
 
* Model name: Truck and Bus age distribution data 
  + Model type: Tabulation of data 
  + Estimation data: inst/extdata/TruckBusAgeDist_.RData 
  + Estimation method: Data file in inst/extdata/TruckBusAgeDist_.Rdata 
  + Estimation script: R/ReportRPATMetrics.R 
  + Model object: data/TruckBusAgeDist_mx.rda 
  + Notes: This module has no estimated model parameters, derived from RPAT scripts. Data file is a model input in GreenSTEP 


###  VEScenario 

Scenario management for VE models
This modules contains the following step(s): 
 
####  VERPATResults 

This module gathers the output of scenario runs in data.table and returns it as a list 

* This module step uses data sources including Hardcoded configuration 
* This module step uses model types including config file 
* This module step is estimated using the following methods: none 
* This module step is documented in R Script only, no md file produced 

The models in this model step are: 
 
* Model name: VERPAT OUTPUT config file 
  + Model type: config file 
  + Estimation data: NA 
  + Estimation method: NA 
  + Estimation script: R/VERPATResults.R 
  + Model object: data/VERPATOutputConfig.rda 
  + Notes: This module creates a scenario configuration file during package build 

####  VERSPMResults 

This module gathers the output of scenario runs in data.table and returns it as a list 

* This module step uses data sources including Hardcoded configuration 
* This module step uses model types including config file 
* This module step is estimated using the following methods: none 
* This module step is documented in R Script only, no md file produced 

The models in this model step are: 
 
* Model name: VERSPM OUTPUT config file 
  + Model type: config file 
  + Estimation data: NA 
  + Estimation method: NA 
  + Estimation script: R/VERSPMResults.R 
  + Model object: data/VERSPMOutputConfig.rda 
  + Notes: This module creates a scenario configuration file during package build 
