# Estimation in VisionEval {#ve-estimation}




## Introduction

### Overview and Content of this Chapter

Model estimation in VisionEval, either statistical estimation of model parameters (such as estimating linear regression or logit models) or tabulation of external data to produce model parameters, is designed to be integrated into VE modules and to take place during the build process of the modules into packages. 

While this is convenient, the current process in existing VE modules has limitations:

* It is difficult to replace models with local or updated data due to complexity and lack of documentation
* Several modules obscure data and parameters in the estimation portion of the package and therefore require package rebuilds if changes are made
* Legacy model estimation (i.e., from earlier work prior to the development of the VE framework and which does not conform to the current recommended code structure for implementing modules in VE) is incorporated in several modules, e.g., modules that were part of the RPAT model
* There are data discontinuities preventing users from estimating models where, for example, restricted or confidential data have been used to estimate model components (e.g., use of restricted spatial data in VETravelDemandMM) preventing the data from being included in the model package.

This chapter forms an element of work to improve the ability for those applying VE to incorporate newer publicly available datasets or custom datasets to develop locally relevant models for use in VE. This work will include defining a process for users to make use of the latest NHTS data, local HTS data, and local PUMS data, to update models estimated using older versions of the NHTS and PUMS data from different states or regions. 

This chapter includes, in the section [VE Estimation Classification], a classification of the source data and estimation approaches with respect to how important it might be to re-estimate models using localized and/or updated versions of the source information, and whether the estimation approach used in those packages forms a barrier to that re-estimation. The discussion is intended to provide input to the next step of work, which is designed approaches to improve the flexiblity and usability of the estimation procedures in VE. 

This chapter includes, in the section [VE Modules With Estimation], a detailed catalog of estimated models in all of the VE modules and lists the underlying data used in the estimation process for each module.

Finally, this chapter includes, in the section [VE Module Structure], a more complete discussion of the typical R package structure of modules in VE, include discussion of the location of data used in various types of estimation and the ideal structure of scripts that are used to estimate models, apply those estimated models, and to develop documentation. This section can be used as a reference for model developers to adjust models in existing packages (particularly those that do conform to the current VE structure and support estimation during the package build process) and how to set up new modules.

### Key Concepts

There are several key concepts referred to in the discussions in this chapter, which are introduced here:

* VE modules and packages: A VE model, such as VE-State, is a sequences of models that simulate population, landuse, and travel in a region. Each element of that simulate is comprised of a module that simulates a step, such as developing the set of households in the region. The R package structure is used to house the code and data required to estimate and apply that step of the model. The R package structure is described in detail in [VE Module Structure].

* Model estimation and model application: model estimation is the process of either statistically estimating the parameters of models such as linear regression models from a dataset, or of creating a set of parameters in another way such as by deriving a distribution by tabulating a dataset. Those parameters and tabulation can then be used in the model application. The model application is the process of actually running a model scenario for the region that the model system has been implemented.

* Package build process: R packages are comprised of R code, datasets, documentation, and other files. The build process, some details of which are included in the [VE Module Structure], is the standard R process where a package is compiled into a form that can be installed and loaded, making the functions and datasets included in the package available to be called by R scripts in the model application. As a package is built its R code is executed, which provides the opportunity to run data processing and model estimation code to create data and model objects that are available when the model is applied. This process supports a typical workflow for a model developer where module data and data processing and model estimation scripts can be modified and then the changes will be reflected in the module R package when it is built, ready for use in model application. (As noted below, not all VE modules conform to this approach where estimation is updated during the build process).

## VE Estimation Classification

There are several main estimation methods used in current VE modules. Their characteristics are discussed here with particular focus on places where the methods already lend themselves to updates and places where the current approach makes updates to the package by users more difficult. The specific data sources and approaches used for each module is cataloged in detail in the section [VE Modules With Estimation] below.

### Modules importing data from VENHTS2001

The VENHTS2001 module processes the 2001 NHTS publically available datasets to create a household dataset which is augmented with other public data on transport supply. The built VENHTS2001 package can then be used in other modules to support model estimation. For example, the VEHouseholdTravel uses the data output by the VENHTS2001 package to estimate its various travel demand models. There are instances of a second round of dependencies, where models estimated using the data from the VENHTS2001 package are used in the estimation of additional models, for example in the VEPowertrainsAndFuels module. During a complete build of VE, where all packages are built, the order of package building needs to be cognizant of these dependencies -- packages functions, model objects, and datasets required in order to estimate models need to be built first.

The general approach is shown here:

```
* VENHTS2001
  + Make2001NHTSDataset: process NHTS data and add FHWA HPMS and FTA NTD
  + Creates NHTS data frame on package build
* VEHouseholdTravel
  + CalculateAltModeTrips: estimates models of household transit trips, walk trips, and bike trips
  + CalculateHouseholdDvmt: estimates models of household average daily vehicle miles traveled
  + (other components in VEHouseholdTravel also estimate models with VENHTS2001)
  + Creates estimated model objects on package build
* VEHouseholdVehicles
  + AssignDrivers: estimates model to assign drivers by age group to each household
  + (other components in VEHouseholdVehicles also estimate models with VENHTS2001)
  + Creates estimated model objects on package build
* VEPowertrainsAndFuels
  + AssignHhVehiclePowertrain: 
    - estimates model to assign a powertrain type to each household vehicle. 
    - uses the VEHouseholdTravel::DvmtModel_ls, which is based on VENHTS2001, for estimation
    - Creates estimated model objects on package build
  
```

This sequential and modularized approach, where data processing is contained in one package, and then those data are used to support estimation in several other modules, lends itself well to incorporating updated datasets. In this case, alternative versions of the NHTS might be substituted for the 2001 NHTS, or a local household travel survey could be used in place of the NHTS, as long as the output format currently used in the VENHTS2001 package was conformed with.

The development requirements here are:

* A method to select between different household travel source data during the package build process.
* A documented approach to developing alternative household travel survey source data in the correct format.
* NHTS 2009 and NHTS 2017 packages consistent with the NHTS 2001 package to allow for substitution with newer versions of the NHTS.

### Modules using confidential NHTS data

The use of publically available data for model estimation, where the data and estimation scripts are included in modules and are freely available to model users, is an attractive aspect of VE. 

A new package developed using the NHTS 2009, VETravelDemandMM, doesn't fully conform to this ideal. Estimation in this package incorporates neighborhood land use characteristics around each of the NHTS households taken from the EPA's Smart Location Database. However, the connection between the NHTS and the SLD requires the data item describing the Census blockgroup of the household, which is a confidential data item only provided to researchers by FHWA following the completion of a non-disclosure process. 

In this case, estimated model objects can be included in the package but the estimation data cannot be included, preventing easy re-estimation of the models by other developers.

The development requirements here are:

* Consider alternative methods for attributing the NHTS with the neighboorhood land use variables that might not require confidentiality requriements.

### Modules imported from RPAT

VERPAT is the VE implementation of the RPAT model, which was originally developed as part of the SHRP 2 C16 project. While the RPAT model was converted to run as a set of VE modules, the modules do not incorporate model estimation during package build. In most cases, RPAT used models imported from the GreenSTEP model, which were later incorporated into VE and form the basis of many of the models still used in, for example, the VEHouseholdTravel module.

If VERPAT is to be maintained, it would be of benefit to re-establish the connections back to the model estimation porcesses used in modules such as VEHouseholdTravel and VEHouseholdVehicles

The development requirements here are:

* Identify the specific connections between VERPAT models and the locations where those models are now estimated in VE modules.
* Replace the hardcoded models and imported model objects currently used in VERPAT modules with references to the models estimated during a build of VE. This would allow, for example, connections to updated NHTS data and/or local household travel survey data discussed above. 

### Modules estimated with local data

In some cases, locally specific data were used to develop model inputs and estimate models that are incorporated into modules. One example is the use of the Census Public User Microdata Sample (PUMS) for Oregon, which is used to estimate income models and to develop probability distributions used in the VESimHouseholds package. 

Ideally, the implementation of a VE model in another state would replace the Oregon data with a local dataset. The data are also from 2001, and would ideally be replaced with a more recent version of the PUMS data, for example from the American Community Survey (ACS) 5 year data or an alternative local data source.

The development requirements here are:

* Documentation of an approach to replace the 2001 Oregon data with an alternative data source
* Consider the development of a seperate package or module in VESimHouseholds to process a selected state or region's ACS data via an automatic download or API call to source the data.

### Modules estimated with other types of data

Several other data sources are used in the development of modules, particularly those that deal with vehicle operations and congestion. These are generally reasonably well documented and the estimation process is traceable from data included in the modules through an estimation script to a final model object. The estimation work could be considered for updating by model users where local conditions are sufficiently different from those covered in the original estimation date, or over time as the origimal estimation data being aged and are superseded.

The development requirements here are:

* Further refine the cataloging of estimation work in this chapter to clearly identify each data source and its vintage.
* Identify the public availability (or not) of the data source and whether more recent data are already available.

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
   <td style="text-align:right;"> 7 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> VELandUse </td>
   <td style="text-align:right;"> 5 </td>
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
   <td style="text-align:right;"> 5 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> VESimLandUseData </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> VESimTransportSupply </td>
   <td style="text-align:right;"> 1 </td>
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
This module contains the following step(s): 
 
####  Make2001NHTSDataset 

This module creates a data frame of data from the publically available data from the 2001 National Household Travel Survey (NHTS) augmented with data on metropolitan area freeway supply and transit supply. The package produces a data frame of values by household. 

* Data sources include NHTS 2001, FHWA HPMS, FTA NTD 
* Model types include Tabulation of data by household 
* Estimation uses the following methods: Package build 
* Documented in R Script only, no md file produced 

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
This module contains the following step(s): 
 
####  ApplyDvmtReductions 

This module applies the computed proportional reductions in household DVMT due to the application of travel demand management programs and the diversion of single-occupant vehicle travel to bicycles, electric bicycles, or other light-weight vehicles. It also computes added bike trips due to the diversion. 

This module step has no estimated parameters or other model types derived from data. 
 
####  CalculateAltModeTrips 

This module calculates household transit trips, walk trips, and bike trips. The models are sensitive to household DVMT so they are run after all household DVMT adjustments (e.g. to account for cost on household DVMT) are made. 

* Data sources include NHTS 2001 
* Model types include Hurdle 
* Estimation uses the following methods: Package build 
* Documented in inst/module_docs/CalculateAltModeTrips.md 

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

* Data sources include NHTS 2001 
* Model types include Linear regression 
* Estimation uses the following methods: Package build 
* Documented in inst/module_docs/CalculateHouseholdDvmt.md 

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

* Data sources include NHTS 2001 
* Model types include Linear regression 
* Estimation uses the following methods: Package build 
* Documented in inst/module_docs/CalculateVehicleTrips.md 

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

* Data sources include NHTS 2001 
* Model types include Linear regression 
* Estimation uses the following methods: Package build 
* Documented in inst/module_docs/DivertSovTravel.md 

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

* Data sources include NHTS 2001 
* Model types include Linear regression 
* Estimation uses the following methods: Parameters hardcoded in script 
* Documented in R Script only, no md file produced 

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

* Data sources include NHTS 2001 and ? 
* Model types include Linear regression and Tabulation of data by vehicle vintage 
* Estimation uses the following methods: Parameters hardcoded in script and Data file in data-raw/PhevModelData_ls.rda 
* Documented in R Script only, no md file produced 

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

* Data sources include ? 
* Model types include Tabulation of data 
* Estimation uses the following methods: Data file in inst/extdata/power_co2.csv 
* Documented in R Script only, no md file produced 

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
This module contains the following step(s): 
 
####  AssignDrivers 

This module assigns drivers by age group to each household as a function of the numbers of persons and workers by age group, the household income, land use characteristics, and public transit availability. Users may specify the relative driver licensing rate relative to the model estimation data year in order to account for observed or projected changes in licensing rates. 

* Data sources include NHTS 2001 
* Model types include Binary Logit 
* Estimation uses the following methods: Package build 
* Documented in inst/module_docs/AssignDrivers.md 

The models in this model step are: 
 
* Model name: Metropolitan Driver (license) Binary Model 
  + Model type: Binary Logit 
  + Estimation data: VE2001NHTS::Hh_df 
  + Estimation method: Package build 
  + Estimation script: R/AssignDrivers.R 
  + Model object: data/DriverModel_ls.rda 
  + Notes: Sources estimation data from the VE NHTS 2001 package. 

* Model name: Non-metropolitan Driver (license) Binary Model 
  + Model type: Binary Logit 
  + Estimation data: VE2001NHTS::Hh_df 
  + Estimation method: Package build 
  + Estimation script: R/AssignDrivers.R 
  + Model object: data/DriverModel_ls.rda 
  + Notes: Sources estimation data from the VE NHTS 2001 package. 

####  AssignVehicleAge 

This module assigns vehicle ages to each household vehicle. Vehicle age is assigned as a function of the vehicle type (auto or light truck), household income, and assumed mean vehicle age by vehicle type and Azone. Car service vehicles are assigned an age based on input assumptions with no distinction between vehicle type. 

* Data sources include NHTS 2001 
* Model types include Joint Probability Distributions 
* Estimation uses the following methods: Package build 
* Documented in inst/module_docs/AssignVehicleAge.md 

The models in this model step are: 
 
* Model name: Joint probability distribution 
  + Model type: Joint Probability Distributions 
  + Estimation data: VE2001NHTS::Hh_df
VE2001NHTS::Veh_df 
  + Estimation method: Package build 
  + Estimation script: R/AssignVehicleAge.R 
  + Model object: data/VehicleAgeModel_ls.rda 
  + Notes: Sources estimation data from the VE NHTS 2001 package. 

####  AssignVehicleOwnership 

This module determines the number of vehicles owned or leased by each household as a function of household characteristics, land use characteristics, and transportation system characteristics. 

* Data sources include NHTS 2001 
* Model types include Hurdle 
* Estimation uses the following methods: Package build 
* Documented in inst/module_docs/AssignVehicleOwnership.md 

The models in this model step are: 
 
* Model name: Metropolitan Binary Logit Vehicle Ownership Model 
  + Model type: Hurdle 
  + Estimation data: VE2001NHTS::Hh_df 
  + Estimation method: Package build 
  + Estimation script: R/AssignVehicleOwnership.R 
  + Model object: data/AutoOwnModels_ls.rda 
  + Notes: Sources estimation data from the VE NHTS 2001 package. 

* Model name: Non-metropolitan Binary Logit Vehicle Ownership Model 
  + Model type: Hurdle 
  + Estimation data: VE2001NHTS::Hh_df 
  + Estimation method: Package build 
  + Estimation script: R/AssignVehicleOwnership.R 
  + Model object: data/AutoOwnModels_ls.rda 
  + Notes: Sources estimation data from the VE NHTS 2001 package. 

####  AssignVehicleType 

This module identifies how many household vehicles are light trucks and how many are automobiles. Light trucks include pickup trucks, sport utility vehicles, vans, and any other vehicle not classified as a passenger car. Automobiles are vehicles classified as passenger cars. 

* Data sources include NHTS 2001 
* Model types include Binary Logit 
* Estimation uses the following methods: Package build 
* Documented in inst/module_docs/AssignVehicleType.md 

The models in this model step are: 
 
* Model name: Truck or Car binary logit 
  + Model type: Binary Logit 
  + Estimation data: VE2001NHTS::Hh_df 
  + Estimation method: Package build 
  + Estimation script: R/AssignVehicleType.R 
  + Model object: data/VehicleTypeModel_ls.rda 
  + Notes: Sources estimation data from the VE NHTS 2001 package. 

####  CalculateVehicleOwnCost 

This module calculates average vehicle ownership cost for each vehicle based on the vehicle type and age using data from the American Automobile Association (AAA). 

* Data sources include AAA Costs 
* Model types include Log-Linear Depreciation 
* Estimation uses the following methods: Package build  
* Documented in inst/module_docs/CalculateVehicleOwnCost.md 

The models in this model step are: 
 
* Model name: (log) Linear Age-Depreciation model 
  + Model type: Log-Linear Depreciation 
  + Estimation data: inst/extdata/aaa_vehicle_ownership_costs.txt 
  + Estimation method: Package build  
  + Estimation script: R/CalculateVehicleOwnCost.R 
  + Model object: data/VehOwnCost_ls.rda 
  + Notes: Uses AAA car ownership and depreciation model data 

####  CreateVehicleTable 

This module creates a vehicle table and populates it with household ID and geography fields. 

This module step has no estimated parameters or other model types derived from data. 
 
####  AdjustVehicleOwnership 

This module adjusts household vehicle ownership based on a comparison of the cost of owning a vehicle per mile of travel compared to the cost per mile of using a car service where the level of service is high. The determination of whether car services are substituted for ownership also depends on input assumptions regarding the average likelihood that an owner would substitute car services for a household vehicle. 

This module step has no estimated parameters or other model types derived from data. 
 

###  VELandUse 

Land Use simulation package for VisionEval This package contains a number of modules that work in the VisionEval framework to calculate land use characteristics.
This module contains the following step(s): 
 
####  AssignCarSvcAvailability 

This module reads in user specified data and assigns car service availability in Bzones. 

This module step has no estimated parameters or other model types derived from data. 
 
####  AssignDemandManagement 

This module assigns demand management program participation to households and to workers. 

* Data sources include NHTS 2001 and default data specified in CSV 
* Model types include Proportions 
* Estimation uses the following methods: Package build  
* Documented in inst/module_docs/AssignDemandManagement.md 

The models in this model step are: 
 
* Model name: Proportional VMT Reduction Estimation 
  + Model type: Proportions 
  + Estimation data: VE2001NHTS::Hh_df
VE2001NHTS::HhTours_df
inst/extdata/tdm_parameters.csv 
  + Estimation method: Package build  
  + Estimation script: R/AssignDemandManagement.R 
  + Model object: data/TdmModel_ls.rda 
  + Notes: Sources estimation data from the VE NHTS 2001 package and default user specifications 

####  AssignDevTypes 

This module assigns households to development types: Urban (located within an urbanized area boundary) and Rural (located outside of an urbanized area boundary). 

This module step has no estimated parameters or other model types derived from data. 
 
####  AssignLocTypes 

This module assigns households to location types: Urban (located within an urbanized area boundary), Town (located in a smaller urban area that does not have enough population to qualify as an urbanized area), and Rural (located in an area characterized by low density dispersed development). 

This module step has no estimated parameters or other model types derived from data. 
 
####  AssignParkingRestrictions 

This module identifies parking restrictions and prices affecting households at their residences, workplaces, and other places they are likely to visit in the urban area. 

This module step has no estimated parameters or other model types derived from data. 
 
####  Calculate4DMeasures 

This module calculates several 4D measures by Bzone including density, diversity (i.e. mixing of land uses), transportation network design, and destination accessibility 

This module step has no estimated parameters or other model types derived from data. 
 
####  CalculateUrbanMixMeasures 

This module calculates an urban mixed-use measure based on the 2001 National Household Travel Survey measure of the tract level urban/rural indicator 

* Data sources include NHTS 2001 
* Model types include Binary Logit 
* Estimation uses the following methods: Package build  
* Documented in inst/module_docs/CalculateUrbanMixMeasure.md 

The models in this model step are: 
 
* Model name: Probability that household is urban mixed-use (binary logit) 
  + Model type: Binary Logit 
  + Estimation data: VE2001NHTS::Hh_df 
  + Estimation method: Package build  
  + Estimation script: R/CalculateUrbanMixMeasure.R 
  + Model object: data/UrbanMixModel_ls.rda 
  + Notes: Sources estimation data from the VE NHTS 2001 package. 

####  LocateEmployment 

This module places employment in Bzones based on input assumptions of employment by type and Bzone 

This module step has no estimated parameters or other model types derived from data. 
 
####  PredictHousing 

This module assigns a housing type, either single-family (SF) or multifamily (MF) to regular households based on the respective supplies of SF and MF dwelling units in the housing market to which the household is assigned (i.e. the Azone the household is assigned to) and on household characteristics. 

* Data sources include PUMS (processed in VESimHouseholds) 
* Model types include Binomial Logit & IPF 
* Estimation uses the following methods: Package build  
* Documented in inst/module_docs/PredictHousing.md 

The models in this model step are: 
 
* Model name: Binary logit single family or multifamily dwelling and IPF to balance results 
  + Model type: Binomial Logit & IPF 
  + Estimation data: VESimHouseholds::Hh_df 
  + Estimation method: Package build  
  + Estimation script: R/PredictHousing.R 
  + Model object: data/HouseTypeModel_ls.rda 
  + Notes: Sources estimation from Census PUMS prepared in the VESimHousehold package 

####  CalculateBasePlaceTypes 

This module calculates place types for households and firms for the base year. 

* Data sources include NHTS 2001 
* Model types include Multinomial Logit 
* Estimation uses the following methods: Data file in data-raw/HhAllocationModelCoeff.rda 
* Documented in R Script only, no md file produced 

The models in this model step are: 
 
* Model name: MNL model of household allocation to place types based on household structures and income 
  + Model type: Multinomial Logit 
  + Estimation data: data-raw/HhAllocationModelCoeff.rda 
  + Estimation method: Data file in data-raw/HhAllocationModelCoeff.rda 
  + Estimation script: R/CalculateBasePlaceTypes.R 
  + Model object: data/HhAllocationModelCoeff_df.rda 
  + Notes: This module has no estimated model parameters, model was estimated in the development of RPAT and transferred as a model object saved in data-raw. 

####  CalculateFuturePlaceTypes 

This module calculates place types for households and firms for the future year. 

* Data sources include NHTS 2001 
* Model types include Multinomial Logit 
* Estimation uses the following methods: Data file in data-raw/HhAllocationModelCoeff.rda 
* Documented in R Script only, no md file produced 

The models in this model step are: 
 
* Model name: MNL model of household allocation to place types based on household structures and income 
  + Model type: Multinomial Logit 
  + Estimation data: data-raw/HhAllocationModelCoeff.rda 
  + Estimation method: Data file in data-raw/HhAllocationModelCoeff.rda 
  + Estimation script: R/CalculateFuturePlaceTypes.R 
  + Model object: data/HhAllocationModelCoeff_df.rda 
  + Notes: This module has no estimated model parameters, model was estimated in the development of RPAT and transferred as a model object saved in data-raw. 


###  VEPowertrainsAndFuels 

VisionEval module for calculating energy consumption and emissions from transportation. Includes modules for inputting energy consumption characteristics of different vehicle technologies, carbon intensities of different fuels, functions for calculating energy consumption and emissions from household, commercial, and public transit travel.
This module contains the following step(s): 
 
####  AssignHhVehiclePowertrain 

This module assigns a powertrain type to each household vehicle. The powertrain types are internal combustion engine vehicle (ICEV), hybrid electric vehicle (HEV), plug-in hybrid electric vehicle (PHEV), and battery electric vehicles (BEV). The module also assigns related characteristics to household vehicles 

* Data sources include NHTS 2001 
* Model types include lookup tables  
* Estimation uses the following methods: Package build  
* Documented in inst/module_docs/AssignHhVehiclePowertrain.md 

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

* Data sources include Described in text files in inst/extdata 
* Model types include Tabulation of data 
* Estimation uses the following methods: Data files in inst/extdata/power_co2.csv 
* Documented in inst/module_docs/LoadDefaultValues.md 

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
This module contains the following step(s): 
 
####  AssignLifeCycle 

This module assigns a life cycle category to each household. The life cycle categories are similar, but not the same as, those established for the NHTS.  

This module step has no estimated parameters or other model types derived from data. 
 
####  CreateHouseholds 

This module creates a Household table in the datastore and populates the table with datasets characterizing simulated households. 

* Data sources include Census PUMS, OR 2000 Census data are included in the package 
* Model types include Tabulation of data 
* Estimation uses the following methods: Package Build 
* Documented in inst/module_docs/CreateHouseholds.md 

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

* Data sources include Census PUMS, OR 2000 Census data are included in the package 
* Model types include Linear regression 
* Estimation uses the following methods: Package Build 
* Documented in inst/module_docs/PredictIncome.md 

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

* Data sources include Census PUMS, OR 2000 Census data are included in the package 
* Model types include Tabulation of data 
* Estimation uses the following methods: Package Build 
* Documented in inst/module_docs/PredictWorkers.md 

The models in this model step are: 
 
* Model name: Probability matrix that a person in each age group in a specified household type is a worker 
  + Model type: Tabulation of data 
  + Estimation data: inst/extdata/pums_households.csv, inst/extdata/pums_persons.csv 
  + Estimation method: Package Build 
  + Estimation script: R/PredictWokers.R, R/CreateEstimationDatasets.R 
  + Model object: data/PropHhWkr_HtAg.rda 
  + Notes: This module develops a table of probabilities processed in two scripts from Census PUMS data. The data in the package are for Oregon. 


###  VESimLandUse 

This module simulates various land use characteristics
This module contains the following step(s): 
 
####  AssignCarSvcAvailability 

This module assigns car service availability levels (Low, High) to Bzones and households.  

This module step has no estimated parameters or other model types derived from data. 
 
####  AssignDemandManagement 

This module assigns demand management program participation to households and to workers. 

* Data sources include NHTS 2001 
* Model types include Proportions 
* Estimation uses the following methods: Imports from VELandUse 
* Documented in inst/module_docs/AssignDemandManagement.md 

The models in this model step are: 
 
* Model name: Proportional VMT Reduction Estimation 
  + Model type: Proportions 
  + Estimation data: VELandUse::TdmModel_ls 
  + Estimation method: Imports from VELandUse 
  + Estimation script: R/AssignDemandManagement.R 
  + Model object: NA 
  + Notes: This module has no estimated model parameters. It loads the model estimated in the VELandUse module 

####  AssignParkingRestrictions 

This module identifies parking restrictions and prices affecting households at their residences, workplaces, and other places they are likely to visit in the urban area.  

* Data sources include none 
* Model types include none 
* Estimation uses the following methods: none 
* Documented in inst/module_docs/AssignParkingRestrictions.md 

The models in this model step are: 
 
* Model name: Proportional/Average assignment 
  + Model type: NA 
  + Estimation data: NA 
  + Estimation method: NA 
  + Estimation script: R/AssignParkingRestrictions.R 
  + Model object: NA 
  + Notes: This module has no estimated model parameters. Function appplied by this model is deterministic. 

####  CreateSimBzoneModels 

This module estimates all the models for synthesizing Bzones and their land use attributes as a function of Azone characteristics as well as data derived from the US Environmental Protection Agency's Smart Location Database (SLD) augmented with US Census housing and household income data, and data from the National Transit Database. 

* Data sources include VESimLandUseData 
* Model types include Distributions 
* Estimation uses the following methods: Package build  
* Documented in inst/module_docs/CreateSimBzoneModels.md 

The models in this model step are: 
 
* Model name: Distribution profiles 
  + Model type: Distributions 
  + Estimation data: VESimLandUseData::SimLandUseData_df 
  + Estimation method: Package build  
  + Estimation script: R/CreateSimBzoneModels.R 
  + Model object: data/SimBzone_ls.rda
data/UsaBlkGrpTypes_df.rda 
  + Notes: This modules estimates a system of models to synthesize Bzones and their attributes as a funciton of Azone characteristics and other data in the VESimLandUseData pacakge 

####  CreateSimBzones 

This module synthesizes Bzones and their land use attributes as a function of Azone characteristics as well as data derived from the US Environmental Protection Agency's Smart Location Database (SLD) augmented with US Census housing and household income data, and data from the National Transit Database.  

This module step has no estimated parameters or other model types derived from data. 
 
####  Initialize 

Initialization and data check 

This module step has no estimated parameters or other model types derived from data. 
 
####  Simulate4DMeasures 

This module calculates several 4D measures by SimBzone including density, diversity (i.e. mixing of land uses), and pedestrian-orientedn transportation network design. 

This module step has no estimated parameters or other model types derived from data. 
 
####  SimulateEmployment 

This module assign workers SimBzone work locations. A worker table is created which identifies a unique worker ID, the household ID the worker is a part of, and the SimBzone, Azone, and Marea of the worker job location. 

This module step has no estimated parameters or other model types derived from data. 
 
####  Simulate Housing 

This module assigns a housing type, either single-family (SF) or multifamily (MF) to regular households based on the respective supplies of SF and MF dwelling units in the housing market to which the household is assigned (i.e. the Azone the household is assigned to) and on household characteristics.  

* Data sources include PUMS (processed in VESimHouseholds) 
* Model types include Binary search algorithm 
* Estimation uses the following methods: Imports from VELandUse 
* Documented in inst/module_docs/SimulateHousing.md 

The models in this model step are: 
 
* Model name: housing choice model estimated by the 'PredictHousing' module in the 'VELandUse' package. 
  + Model type: Binary search algorithm 
  + Estimation data: VELandUse::HouseTypeModel_ls 
  + Estimation method: Imports from VELandUse 
  + Estimation script: R/SimulateHousing.R 
  + Model object: data/HouseTypeModel_ls.rda 
  + Notes: Sources models estimated in the VELandUse module that were estimated using PUMS data processed in the VESimHouseholds package 

####  SimulateUrbanMixMeasure 

This module simulates an urban mixed-use measure based on the 2001 National Household Travel Survey measure of the tract level urban/rural indicator. 

* Data sources include NHTS 2001 
* Model types include Binary Logit 
* Estimation uses the following methods: Imports from VELandUse 
* Documented in inst/module_docs/SimulateUrbanMixMeasure.md 

The models in this model step are: 
 
* Model name: binary logit model estimated in the CalculateUrbanMixMeasure module of the VELandUse package 
  + Model type: Binary Logit 
  + Estimation data: VELandUse::UrbanMixModel_ls 
  + Estimation method: Imports from VELandUse 
  + Estimation script: R/SimulateUrbanMixMeasure.R 
  + Model object: data/UrbanMixModelSim_ls.rda 
  + Notes: Sources models estimated in the VELandUse module that were estimated using PUMS data processed in the VESimHouseholds package 


###  VESimLandUseData 

This package processes data from several sources to produce a dataset that is used to estimate several models for synthesizing Bzones and their likely land use attributes.
This module contains the following step(s): 
 
####  MakeSimBzoneEstDataset 

This script combines data from the US Census, the EPA Smart Location Database (SLD), and the National Transit Database 

* Data sources include US Census Housing and Household Income Data, Smart Location Database, National Transit Database 
* Model types include Tabulation of data by household 
* Estimation uses the following methods: Package build  
* Documented in inst/module_docs/MakeSimBzoneEstDataset.md 

The models in this model step are: 
 
* Model name: Processed Dataset 
  + Model type: Tabulation of data by household 
  + Estimation data: data-raw/2010_Service.csv
data-raw/2010_transit_uza_data.csv
data-raw/2010_Agency_Information.csv 
  + Estimation method: Package build  
  + Estimation script: R/MakeSimBzoneEstDataset.R 
  + Model object: data/SimLandUseData_df.rda 
  + Notes: This module processes data for use in the VESimLandUse module 


###  VESimTransportSupply 

This package contains modules that work in the VisionEval framework to simulate transportation supply characteristics including roadway supply and public transit supply.
This module contains the following step(s): 
 
####  SimulateRoadMiles 

This module assigns freeway and arterial lane-miles to metropolitan areas (Marea) and calculates freeway lane-miles per capita. 

This module step has no estimated parameters or other model types derived from data. 
 
####  SimulateTransitService 

This module assigns transit service level to the urbanized portion of each Marea and to neighborhoods (SimBzones) within the urbanized area. 

* Data sources include VESimLandUseData 
* Model types include Distributions 
* Estimation uses the following methods: Imports from VELandUse 
* Documented in R Script only, no md file produced 

The models in this model step are: 
 
* Model name: Models estimated in the VESimLandUse modules 
  + Model type: Distributions 
  + Estimation data: VESimLandUse::SimBzone_ls 
  + Estimation method: Imports from VELandUse 
  + Estimation script: R/SimulateTransitService.R 
  + Model object: data/D4cModels_ls.rda 
  + Notes: Sources models estimated in the VELandUse module. 


###  VESyntheticFirms 

VisionEval Synthetic Firms module
This module contains the following step(s): 
 
####  CreateBaseSyntheticFirms 

Creates a list of base year synthetic firms 

This module step has no estimated parameters or other model types derived from data. 
 
####  CreateFutureSyntheticFirms 

Creates a list of future year synthetic firms 

This module step has no estimated parameters or other model types derived from data. 
 

###  VETransportSupply 

This package contains a number of modules that work in the VisionEval framework to calculate transportation supply characteristics including roadway supply and public transit supply.
This module contains the following step(s): 
 
####  SimulateRoadMiles 

This module assigns freeway and arterial lane-miles to metropolitan areas (Marea) and calculates freeway lane-miles per capita.
 

This module step has no estimated parameters or other model types derived from data. 
 
####  SimulateTransitService 

This module assigns transit service level to the urbanized portion of each Marea and to neighborhoods (SimBzones) within the urbanized area. 

* Data sources include FTA NTD 
* Model types include Factors 
* Estimation uses the following methods: Package build  
* Documented in inst/module_docs/AssignTransitService.md 

The models in this model step are: 
 
* Model name: Factors to convert revenue mules, develop bus equivalency factors, compare vehicle miles by mode 
  + Model type: Factors 
  + Estimation data: inst/extdata/2015_Agency_information.csv, inst/extdata/2015_Service.csv 
  + Estimation method: Package build  
  + Estimation script: R/AssignTransitService.R 
  + Model object: data/BusEquivalents_df.rda, data/VehMiFactors_df.rda, data/UZABusEqRevMile_df.rda 
  + Notes: The module develops factors based on FTA NTD data 


###  VETransportSupplyUse 

VisionEval module for roadway speeds, delay, and congestion costs using run year data
This module contains the following step(s): 
 
####  CalculateCongestionBase 

This module calculates the amount of congestion for base year - automobile, light truck, truck, and bus vmt are allocated to freeways, arterials, and other roadways. 

* Data sources include 2009 Urban Mobility Study 
* Model types include lookup tables  
* Estimation uses the following methods: Data files in inst/extdata 
* Documented in R Script only, no md file produced 

The models in this model step are: 
 
* Model name: Speed estimated from demand vs lane-mile supply 
  + Model type: lookup tables  
  + Estimation data: inst/extdata/CongModel_ls.RData 
  + Estimation method: Data files in inst/extdata 
  + Estimation script: R/CalculateCongestionBase.R 
  + Model object: data/CongModel_ls.rda 
  + Notes: This module has no estimated model parameters, derived from RPAT scripts. Original source of models is GreenSTEP models. 

####  CalculateCongestionFuture 

This module calculates the amount of congestion for future year - automobile, light truck, truck, and bus vmt are allocated to freeways, arterials, and other roadways. 

* Data sources include 2009 Urban Mobility Study 
* Model types include lookup tables  
* Estimation uses the following methods: Data files in inst/extdata 
* Documented in R Script only, no md file produced 

The models in this model step are: 
 
* Model name: Speed estimated from demand vs lane-mile supply 
  + Model type: lookup tables  
  + Estimation data: inst/extdata/CongModel_ls.RData 
  + Estimation method: Data files in inst/extdata 
  + Estimation script: R/CalculateCongestionFuture.R 
  + Model object: NA 
  + Notes: This module has no estimated model parameters, derived from RPAT scripts. Original source of models is GreenSTEP models. 

####  CalculateCongestionPolicy 

This module calculates the amount of congestion - automobile, light truck, truck, and bus vmt are allocated to freeways, arterials, and other roadways adjusted by policy applied for the selected scenario. 

* Data sources include 2009 Urban Mobility Study 
* Model types include lookup tables  
* Estimation uses the following methods: Data files in inst/extdata 
* Documented in R Script only, no md file produced 

The models in this model step are: 
 
* Model name: Speed estimated from demand vs lane-mile supply, adjusted by intervention policy 
  + Model type: lookup tables  
  + Estimation data: inst/extdata/CongModel_ls.RData 
  + Estimation method: Data files in inst/extdata 
  + Estimation script: R/CalculateCongestionPolicy.R 
  + Model object: NA 
  + Notes: This module has no estimated model parameters, derived from RPAT scripts. Original source of models is GreenSTEP models. 


###  VETravelDemandMM 

This package contains a module for the VisionEval framework that simulates multi-modal travel demand for individual households
This module contains the following step(s): 
 
####  CalculateAltModeTrips 

Predicts transit, bike, walk PMT and trips 

* Data sources include NHTS 2009, FHWA HPMS, FTA NTD, EPA SLD 
* Model types include Hurdle and Linear regression 
* Estimation uses the following methods: Pre-estimated, saved objects in data-raw/estimated 
* Documented in inst/module_docs/CalculateAltModeTrips.md 

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

* Data sources include NHTS 2009, FHWA HPMS, FTA NTD, EPA SLD and NHTS 2001 
* Model types include Linear regression 
* Estimation uses the following methods: Pre-estimated, saved objects in data-raw/estimated 
* Documented in inst/module_docs/CalculateHouseholdDVMT.md and inst/module_docs/HouseholdDvmtQuantileEstimation.md 

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

* Data sources include NHTS 2009, FHWA HPMS, FTA NTD, EPA SLD 
* Model types include Ordered logit 
* Estimation uses the following methods: Pre-estimated, saved objects in data-raw/estimated 
* Documented in inst/module_docs/PredictDrivers.md 

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

* Data sources include NHTS 2009, FHWA HPMS, FTA NTD, EPA SLD 
* Model types include Ordered logit 
* Estimation uses the following methods: Pre-estimated, saved objects in data-raw/estimated 
* Documented in inst/module_docs/PredictVehicles.md 

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
This module contains the following step(s): 
 
####  AdjustHhVehicleMpgMpkwh 

This module adjusts the fuel economy (MPG) and power efficiency (MPKWH) of household vehicles to reflect the effects of congestion, speed smoothing, and eco-driving that are calculated by the CalculateMpgMpkwhAdjustments module. 

This module step has no estimated parameters or other model types derived from data. 
 
####  BalanceRoadCostsAndRevenues 

This module calculates an extra mileage tax ($ per vehicle mile traveled) for household vehicles needed to make up any difference in the cost of constructing, maintaining, and operating roadways and the revenues from fuel, VMT, and congestion taxes. 

This module step has no estimated parameters or other model types derived from data. 
 
####  BudgetHouseholdDvmt 

This module adjusts average household DVMT to keep the quantity within the limit of the household vehicle operating cost budget.  

* Data sources include US BEA CES 
* Model types include Linear regression 
* Estimation uses the following methods: Package Build 
* Documented in inst/module_docs/BudgetHouseholdDvmt.md 

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

* Data sources include Outputs from EPA PERE model 
* Model types include Tabulation of data 
* Estimation uses the following methods: Package Build 
* Documented in inst/module_docs/CalculateMpgMpkwhAdjustments.md 

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

* Data sources include 2009 Urban Mobility Study and NHTS 2017 research by Bigazzi and Clifton and NHTS 2017 
* Model types include lookup tables  and Lookup tables and equation Linear regression and Lookup tables and equation 
* Estimation uses the following methods: Package Build 
* Documented in inst/module_docs/CalculateRoadPerformance.md 

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

* Data sources include ? and data from the American Automobile Association and the Bureau of Labor Statistics 
* Model types include Cobb-Douglas utility function and Products of rates 
* Estimation uses the following methods: Package Build 
* Documented in inst/module_docs/CalculateVehicleOperatingCost.md 

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
This module contains the following step(s): 
 
####  ReportRPATMetrics 

This module calculates and reports various performance metrics. These performance metrics include environment and energey impacts, financial and economic impacts, and community impacts. 

* Data sources include ? 
* Model types include Tabulation of data 
* Estimation uses the following methods: Data file in inst/extdata/TruckBusAgeDist_.Rdata 
* Documented in R Script only, no md file produced 

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
This module contains the following step(s): 
 
####  VERPATResults 

This module gathers the output of scenario runs in data.table and returns it as a list 

* Data sources include Hardcoded configuration 
* Model types include config file 
* Estimation uses the following methods: Package Build 
* Documented in R Script only, no md file produced 

The models in this model step are: 
 
* Model name: VERPAT OUTPUT config file 
  + Model type: config file 
  + Estimation data: Hardcoded configuration 
  + Estimation method: Package Build 
  + Estimation script: R/VERPATResults.R 
  + Model object: data/VERPATOutputConfig.rda 
  + Notes: This module creates a scenario configuration file during package build 

####  VERSPMResults 

This module gathers the output of scenario runs in data.table and returns it as a list 

* Data sources include Hardcoded configuration 
* Model types include config file 
* Estimation uses the following methods: Package Build 
* Documented in R Script only, no md file produced 

The models in this model step are: 
 
* Model name: VERSPM OUTPUT config file 
  + Model type: config file 
  + Estimation data: Hardcoded configuration 
  + Estimation method: Package Build 
  + Estimation script: R/VERSPMResults.R 
  + Model object: data/VERSPMOutputConfig.rda 
  + Notes: This module creates a scenario configuration file during package build 

## VE Module Structure

All modules are made available in the form of standard R packages that meet framework specifications. Packages may be in source form or installed form. The following presentation refers to the source form of VisionEval packages. When a package is installed (built) the R system runs the scripts in the R directory and saves functions that are defined within and datasets that are saved by the script. The structure of this installed package is not covered by this document with the exception of the *module_docs* directory in the installed package. If the module developer follows the guidelines for module documentation, a *module_docs* directory will be included in the installed package. This will include module documentation in the form of markdown documents.

A package may contain more than one module. The package organization follows the standard organization of R packages. The structure is shown in the following diagram. The components are described below in the order that they are presented in the diagram. The file names are examples.

```
VESimHouseholds
|   DESCRIPTION
|   NAMESPACE
|   LICENSE
|     
|
|____R
|    |   CreateHouseholds.R  
|    |   PredictWorkers.R
|    |   CreateEstimationDatasets.R
|    |   ...
|
|
|____inst  
|    |    NOTICE
|    |____extdata  
|         |   pums_households.csv
|         |   pums_households.txt
|         |   pums_persons.csv
|         |   pums_persons.txt
|         |   ...
|         
|
|____data-raw
|    |    some_processed_model_dataset.rda
|    |    ...
|    
|
|____tests
     |____scripts
     |    |   test.R
     |    |   test_functions.R
     |    |   verspm_test.R 
     |    |   vestate_test.R    
     |
     |____verspm
     |    |   logs
  	 |    |   |   Log_CreateHouseholds.txt
	 |    |   |   ...
	 |    |
	 |    |   ModelState.Rda
	 |    
     |____vestate
     |    |   ...
     |
     |    ...

```

The *DESCRIPTION* and *NAMESPACE* files are standard files required by the R package system. There are good sources available for describing the required contents of these files ([R Packages](http://r-pkgs.had.co.nz/)), so that will not be done here. Most of the entries in these files can be produced automatically from annotations in the R scripts that will be described next, using freely available tools such as [devtools](https://github.com/hadley/devtools) and [RStudio](https://www.rstudio.com/). The *LICENSE* file contains the text for the Apache 2 license which is the open source license that should be used for VisionEval packages. The accompanying Apache 2 *NOTICE* file is in the *inst* directory.

### The R Directory
The *R* directory is where all the R scripts are placed which define the modules that are included in the package. Each module is defined by a single R script which has the name of the module (and the .R file extension). A module script does 4 things:  
1) It specifies the model and estimates model parameters. Model estimation datasets may be processed by the script or may be loaded from other sources (see below).  
2) It defines all the specifications for data that the module depends on.  
3) It defines all of the functions that implement the submodel.
4) It includes test code used during module development

When a binary (installed) package is built from the source package, each R script is run; estimation datasets are processed, model parameters are saved, module specifications are saved, functions are parsed into a more efficient form. Following section describe the structure of a module R script in more detail. An example of the *AssignTransitService* module script from the *VETransportSupply* package is included in Appendix E.  

By convention, the module script is organized into 4 sections reflecting the list above. Following sections 8.1.1 to 8.1.4 explain each module script section in detail. Section 8.1.1 explains how model specification and estimation is handled. Subsection 8.1.1.1 focuses in on the handling of model estimation data which, in some cases, may use specialized scripts. Section 8.1.2 explains how to write module specifications which tell the framework how the module is to be run, what input data are to be processed, what data are to be retrieved from the datastore, and what data are to be saved to the datastore. Subsection 8.1.2.1 focuses in on the *OPTIONAL* specification that module developers can use to enable optional model inputs. Subsection 8.1.2.2 focues in the the *CALL* specification that enables modules to call other modules to perform calculation services. Section 8.1.3 describes how to write a main function and supporting functions to implement a module. Section 8.1.4 explains test code that is commonly included in a module to assist the module developer in the module development process. Finally, Section 8.1.5 explains a special module named *Initialize* that may be included in a package. The purpose of this module is to enable module developers to include specialized input data checks and preparation. 

#### Model Specification and Estimation

As the name suggests, this section of the script handles tasks related to processing model estimation data, model specification, and model parameter estimation. This should be done in a manner which enables others to understand the structure of the model, the data it is based on, and how parameters are estimated. It should enable others to replicate the process and to test modifications. Typically, model specification and estimation code does 4 things: loading the data to be used, defining functions that carry out key specification and estimation procedures, applying the functions to produce objects that define the model(s), and saving the model objects. 

Models vary in their complexity. In some modules the model may simply be an algorithm with decision rules or asserted parameters. In this case, there is no need to fill out this section of the script. For example, the *AssignLifeCycle* module in the *VESimHouseholds* package assigns lifecycle codes to households using rules regarding the numbers of adults, children, and workers in the household. In cases like this, the model estimation and specification section will be empty. In other cases, models will be quite complex and this section of the script will be extensive. For example, the "CalculateHouseholdDvmt" module does the following in the process of building models and comprises hundreds of lines of code:  
- Estimate a binomial logit model of the probability that a household has any DVMT
- Estimate a linear model of the amount of household DVMT given that a household has any DVMT
- Estimate a dispersion factor for the linear model so that the variance of modeled DVMT matches the observed variance
- Simulate household DVMT 1000 times by stochastically applying the binomial and linear models
- Calculate quantiles of simulated DVMT
- Estimate a linear model of average DVMT using the simulation data
- Estimate models of the DVMT quantiles as a function of the average DVMT  

Model estimation data preparation may also be extensive. Whether it is or not, documenting the data used in building a model and making those data available are key to making the models reproducible and extensible. Moreover, for some modules it is important that model users be able to have model parameters reflect the conditions for their region. For example, the *CreateHouseholds*, *PredictWorkers*, and *PredictIncome* modules use Census public use microdata sample data for the region to estimate parameters. There are several ways that model estimation data can be handled in the VisionEval model system. These are described in detail in Section 8.1.1.1.

The model estimation code should also save objects to use in documenting the modules such as:
1. Model summary statistics such as is produced when a model object (such as a linear model estimated using the *lm* function) is processed by the *summary* function;
2. Data frames, tables, and matrices; and,
3. Graphs or other static data visualizations.

The first two should be saved as objects just like any other object saved to implement a model. It is suggested that these documentation objects be stored in a list along with the model that they document. For example, follow is a portion of the *PredictIncome.R* script which saves (and documents) a list which contains the household income model including documentation of the summary statistics for the model.

```
#Save the household income model
#-------------------------------
#' Household income model
#'
#' A list containing the income model equation and other information needed to
#' implement the household income model.
#'
#' @format A list having the following components:
#' \describe{
#'   \item{Type}{a string identifying the type of model ("linear")}
#'   \item{Formula}{makeModelFormulaString(IncModel_LM)}
#'   \item{PrepFun}{a function that prepares inputs to be applied in the linear model}
#'   \item{OutFun}{a function that transforms the result of applying the linear model}
#'   \item{Summary}{the summary of the linear model estimation results}
#'   \item{SearchRange}{a two-element vector specifying the range of search values}
#' }
#' @source PredictIncome.R script.
"HHIncModel_ls"
usethis::use_data(HHIncModel_ls, overwrite = TRUE)
```
The *Summary* component of this list shows the summary statistics for the model. As explained in the module documentation section below, this can be automatically inserted into the module documentation. It is recommended that the *capture.output* function be used rather than the *print* function to capture model summary statistics because the *print* function will insert line numbers. This method can be used to save other text that can then be inserted into module documentation. This example also shows how objects are documented and saved.

It can also be useful to save data frames, tables, matrices to use in the model documentation. These can be saved like any other data object and then inserted as described in the module documentation section.

Graphs or other visualizations are saved in a different manner. If these are saved as an image file in "png" format, they can be inserted into the module documentation. They must be saved to the "data" directory to do so. Following is an example:

```
#Plot comparison of observed and estimated income distributions
png(
  filename = "data/reg-hh-inc_obs-vs-est_distributions.png",
  width = 480,
  height = 480
)
plot(
  density(IncObs_),
  xlim = c(0, 200000),
  xlab = "Annual Dollars ($2000)",
  main = "Distributions of Observed and Predicted Household Income \nRegular Households"
  )
lines(density(IncEst_), lty = 2)
legend("topright", legend = c("Observed", "Predicted"), lty = c(1,2))
dev.off()
```

There are many ways that a module developer can code the model specification and parameter estimation procedures. However this is done, the code should be well organized and commented so that it is understandable to reviewers. All code should follow the VisionEval coding guidelines. In addition, it is highly recommended that code be grouped into functions to aid understandability and reduce unnecessary code repetition which can lead to errors. Complex functions should be well documented. Function documentation is done using [Roxygen syntax](http://r-pkgs.had.co.nz/man.html). Following is an example of the code which estimates a housing choice model (single-family vs. multifamily) in the *PredictHousing* module of the *VELandUse* package.  

```
#Define a function to estimate housing choice model
#--------------------------------------------------
#' Estimate housing choice model
#'
#' \code{estimateHousingModel} estimates a binomial logit model for choosing
#' between single family and multifamily housing
#'
#' This function estimates a binomial logit model for predicting housing choice
#' (single family or multifamily) as a function of the supply of housing of
#' these types and the demographic and income characteristics of the household.
#'
#' @param Data_df A data frame containing estimation data.
#' @param StartTerms_ A character vector of the terms of the model to be
#' tested in the model.
#' @return A list which has the following components:
#' Type: a string identifying the type of model ("binomial"),
#' Formula: a string representation of the model equation,
#' PrepFun: a function that prepares inputs to be applied in the binomial model,
#' OutFun: a function that transforms the result of applying the binomial model.
#' Summary: the summary of the binomial model estimation results.
#' @import visioneval stats
#Define function to estimate the income model
estimateHousingModel <- function(Data_df, StartTerms_) {
  #Define function to prepare inputs for estimating model
  prepIndepVar <-
    function(In_df) {
      Ah <-
        c("Age15to19",
          "Age20to29",
          "Age30to54",
          "Age55to64",
          "Age65Plus")
      Out_df <-
        data.frame(t(apply(In_df[, Ah], 1, function(x) {
          AgeLvl_ <- 1:5 #Age levels
          HhAgeLvl_ <- rep(AgeLvl_, x)
          HeadOfHh_ <- numeric(5)
          if (max(HhAgeLvl_) < 5) {
            HeadOfHh_[max(HhAgeLvl_)] <- 1
          } else {
            if (all(HhAgeLvl_ == 5)) {
              HeadOfHh_[5] <- 1
            } else {
              NumMidAge <- sum(HhAgeLvl_ %in% c(3, 4))
              NumElderly <- sum(HhAgeLvl_ == 5)
              if (NumMidAge > NumElderly) {
                HeadOfHh_[max(HhAgeLvl_[HhAgeLvl_ < 5])] <- 1
              } else {
                HeadOfHh_[5] <- 1
              }
            }
          }
          HeadOfHh_
        })))
      names(Out_df) <- paste0("Head", Ah)
      Out_df$HhSize <- In_df$HhSize
      Out_df$Income <- In_df$Income
      Out_df$RelLogIncome <- log1p(In_df$Income) / mean(log1p(In_df$Income))
      Out_df$Intercept <- 1
      Out_df
    }
  EstData_df <- prepIndepVar(Data_df)
  EstData_df$SingleFamily <- as.numeric(Data_df$HouseType == "SF")
  #Define function to make the model formula
  makeFormula <-
    function(StartTerms_) {
      FormulaString <-
        paste("SingleFamily ~ ", paste(StartTerms_, collapse = "+"))
      as.formula(FormulaString)
    }
  #Estimate model
  HouseTypeModel <-
    glm(makeFormula(StartTerms_), family = binomial, data = EstData_df)
  #Return model
  list(
    Type = "binomial",
    Formula = makeModelFormulaString(HouseTypeModel),
    Choices = c("SF", "MF"),
    PrepFun = prepIndepVar,
    Summary = summary(HouseTypeModel)
  )
}

#Estimate the binomial logit model
#---------------------------------
#Load the household estimation data
Hh_df <- VESimHouseholds::Hh_df
#Select regular households
Hh_df <- Hh_df[Hh_df$HhType == "Reg",]
Hh_df$Income[Hh_df$Income == 0] <- 1
#Estimate the housing model
HouseTypeModelTerms_ <-
  c(
    "HeadAge20to29",
    "HeadAge30to54",
    "HeadAge55to64",
    "HeadAge65Plus",
    "RelLogIncome",
    "HhSize",
    "RelLogIncome:HhSize"
  )
HouseTypeModel_ls <- estimateHousingModel(Hh_df, HouseTypeModelTerms_)
rm(HouseTypeModelTerms_)
```

As can be seen in this example, most of the code defines and documents a function which estimates a binomial choice model given a estimation dataset and a list of model variable names. This function does a number of things including transforming estimation data, creating a model formulation from the list of independent variables, estimating the variables, and returning a list of model components. After the function is defined, it is applied using the model estimation data and a specified list of independent variables. This approach to model specification and estimation makes it easy for a module developer to try out different model specifications, measuring their relative performance, and documenting the results.

The approach used in this example takes advantage of some helper functions in the framework software. The *makeModelFormulaString* function takes an R model formula object and converts it into a string representation. When the model is applied in the module, the string is parsed and evaluated with a data frame of independent variables. This provides a compact way to store a model and a fast way to apply it. Several other framework functions assist with applying models in this form. The *applyBinomialModel* applies a binomial logit model. The *applyLinearModel* applies a linear regression model. Both of these functions enable the models to self calibrate to match an input target. For example, the *PredictHousing* module adjusts the constant of the model so that the proportions of households in single-family vs. multifamily dwelling units matches the housing supply in the area. The *applyBinomialModel* does this efficiently by calling the *binarySearch* function which implements a binary search algorithm.

Module developers are not limited to using the previous approach to specifying and implementing a model. Most if not all R functions that estimate models also have companion prediction functions to apply the estimated model to a new set of data. This is often the simplest and best way to apply a model. One drawback of this approach, however, is that the object that is returned by the model estimation function and that is used in making a prediction is often very large because it includes a copy of all of the estimation data and datasets used to calculate model statistics. If the model estimation datasets are very large, this will pose a problem for keeping the module package in a central repository. In that case, the module code needs to remove parts of the model object that are not necessary for prediction. For example, the *AssignVehicleOwnership* module in the *VEHouseholdVehicles* package uses an ordered logit model to predict household auto ownership for households owning one or more vehicles. The model is estimated using data from the 2001 NHTS so the model object returned by the estimation function (*clm* in the *ordinal* package) is large. Portions of the model object not needed by the corresponding prediction function are removed. It is often a matter of trial and error to find out how much can be removed from the model object without adversely affecting the prediction function.

```
#Model number of vehicles of non-zero vehicle households
EstData_df <- EstData_df[EstData_df$ZeroVeh == 0,]
EstData_df$VehOrd <- EstData_df$NumVeh
EstData_df$VehOrd[EstData_df$VehOrd > 6] <- 6
EstData_df$VehOrd <- ordered(EstData_df$VehOrd)
AutoOwnModels_ls$Metro$Count <-
  clm(
    VehOrd ~ Workers + LogIncome + DrvAgePop + HhSize + OnlyElderly + IsSF +
      IsUrbanMixNbrhd + LogDensity + TranRevMiPC,
    data = EstData_df,
    threshold = "equidistant"
  )
#Trim down model
AutoOwnModels_ls$Metro$Count[c("fitted.values", "model", "y")] <- NULL
```

After a model has been estimated, the model objects which embody the model need to be saved as part of the package. There is a standard way of doing this which is illustrated in the following example of saving the model in the *PredictHousing* module. The housing prediction model object is a list called 'HouseTypeModel_ls'. This list is saved in the 'data' directory of the package. By saving the model object in the 'data' directory, it can be addressed directly in the module function that applies the model. Note how documentation is handled.

```
#Save the housing choice model
#-----------------------------
#' Housing choice model
#'
#' A list containing the housing choice model equation and other information
#' needed to implement the housing choice model.
#'
#' @format A list having the following components:
#' \describe{
#'   \item{Type}{a string identifying the type of model ("binomial")}
#'   \item{Formula}{makeModelFormulaString(HouseTypeModel)}
#'   \item{PrepFun}{a function that prepares inputs to be applied in the model}
#'   \item{Summary}{the summary of the binomial logit model estimation results}
#'   \item{SearchRange}{a two-element vector specifying the range of search values}
#' }
#' @source PredictHousing.R script.
"HouseTypeModel_ls"
usethis::use_data(HouseTypeModel_ls, overwrite = TRUE)

```

The *use_data* function in the *usethis* package saves the data and documention correctly in the package and simplifies the procedure for doing so.

Although model estimation code is usually included in the module script, in some instances it may be more understandable to estimate the models for several modules in one script. This is what is done in the *CreateSimBzoneModels.R* script in the *VESimLandUse* package. This script estimates all the models for modules in the package. Model estimation is handled this way because the same model estimation dataset is used for all the models and the models build upon each other. Including all the model estimations in one file makes it easier to code and easier to review.

#### Model Estimation Datasets

Model estimation datasets may be read in from several sources. If model estimation data are large and are used by multiple modules located in different packages, then they may be housed in their own package. This is the case with the 2001 NHTS data which are in the *VE2001NHTS* package. The estimation data in the package can be directly addressed in the model estimation code using the standard 'PackageName::DatasetName' notation as shown in the following example:  

```
Hh_df <- VE2001NHTS::Hh_df
```

If estimation data are retrieved from another package as in this case, the DESCRIPTION file for the package must list the package from which the data are retrieved in the *Imports* section. For example, the Imports section of the VEHouseholdTravel package reads as follows. The VE2001NHTS package is listed as are other packages that this package relies on.

```
Imports:
    visioneval,
    devtools,
    VE2001NHTS,
    data.table
```
    
If estimation data is to be shared among several modules that are all within the same package, then all the data preparation can be done in one script which is run first when the package is built. This approach is used in the *VESimHouseholds* package. The *CreateEstimationDatasets.R* script loads and processes a Census public use microdata sample dataset that is used in estimating models in 3 modules that are in the package (*CreateHouseholds*, *PredictWorkers*, *PredictIncome*). When, as in this case, a separate script is used to prepare the estimation data for several modules in the package, the data are saved in the data directory of the package and the other scripts load the dataset from that directory. The following extracts shows how a processed PUMS household dataset (a data frame named Hh_df) is saved in the CreateEstimationDatasets.R script. The lines starting with `#'` are data documentation in [roxygen2](https://cran.r-project.org/web/packages/roxygen2/vignettes/roxygen2.html) form. Although data documentation can be tedious, especially for large datasets, it is should always be done and is an important aspect of the VisionEval model system.

```
#' Household data from Census PUMS
#'
#' A household dataset containing the data used for estimating the
#' CreateHouseholds, PredictWorkers, PredictLifeCycle, PredictIncome, and
#' PredictHouseType modules derived from from year 2000 PUMS data for Oregon.
#'
#' @format A data frame with 65988 rows and 17 variables (there may be a
#' different number of rows if PUMS datasets are used for different areas):
#' \describe{
#'   \item{Age0to14}{number of persons in 0 to 14 age group}
#'   \item{Age15to19}{number of persons in 15 to 19 age group}
#'   \item{Age20to29}{number of persons in 20 to 29 age group}
#'   \item{Age30to54}{number of persons in 30 to 54 age group}
#'   \item{Age55to64}{number of persons in 55 to 64 age group}
#'   \item{Age65Plus}{number of persons 65 years or older}
#'   \item{Wkr15to19}{number of workers in 15 to 19 age group}
#'   \item{Wkr20to29}{number of workers in 20 to 29 age group}
#'   \item{Wkr30to54}{number of workers in 30 to 54 age group}
#'   \item{Wkr55to64}{number of workers in 55 to 64 age group}
#'   \item{Wkr65Plus}{number of workers 65 years or older}
#'   \item{AvePerCapInc}{average per capita income of PUMA, nominal $}
#'   \item{HouseType}{housing type (SF = single family, MF = multifamily)}
#'   \item{Income}{annual household income, nominal 1999$}
#'   \item{HhSize}{number of persons in household}
#'   \item{HhType}{household type (Reg = regular household, Grp = group quarters)}
#'   \item{HhWeight}{household sample weight}
#' }
#' @source CreateEstimationDatasets.R script.
"Hh_df"
devtools::use_data(Hh_df, overwrite = TRUE)
rm(Hh_df)
```

If as in this case, one script processes the estimation data for use by several modules, it is important that the data processing script be run prior to the other scripts when the package is built. Otherwise the processed estimation data will not be available to the module packages that need it. Managing the order of package script processing is handled by the *Collate* section of the package *DESCRIPTION* file. Following is an example from the *VESimHouseholds* package:

```
Collate: 
    'CreateEstimationDatasets.R'
    'CreateHouseholds.R'
    'PredictWorkers.R'
    'PredictIncome.R'
    'AssignLifeCycle.R'
```

The best way to establish the proper collation (i.e. ordering) of script execution is to carry out model estimation through the definition and invocation of a function, and to have an *@include* statement which lists the estimation data processing script in the function documentation using [Roxygen syntax](http://r-pkgs.had.co.nz/man.html). When the package documentation is compiled, the *Collate* section of the package *DESCRIPTION* file will be filled out properly. Following is an example of function documentation containing a *@include* statement from the *CreateHouseholds.R* module script in the *VESimHouseholds* package:

```
#Define a function to estimate household size proportion parameters
#------------------------------------------------------------------
#' Calculate proportions of households by household size
#'
#' \code{calcHhAgeTypes} creates a matrix of household types and age
#' probabilities.
#'
#' This function produces a matrix of probabilities that a person in one of six
#' age groups is in one of many household types where each household type is
#' determined by the number of persons in each age category.
#'
#' @param HhData_df A dataframe of household estimation data as produced by the
#' CreateEstimationDatasets.R script.
#' @param Threshold A number between 0 and 1 identifying the percentile
#' cutoff for determining the most prevalent households.
#' @return A matrix where the rows are the household types and the columns are
#' the age categories and the values are the number of persons.
#' @include CreateEstimationDatasets.R
#' @export
```

If model estimation data are only used by a single module, then the processing code should be included in the module script. 

There are several places where model estimation datasets may be located depending on the size of the datasets, whether the datasets were preprocessed using other tools or scripts, and whether the intention of the module developer is to enable model users to customize model estimation to reflect data for the region where the model is to be applied.

For some modules, it is desirable that model parameters be estimated to reflect data for the region where the model is to be applied. This is the case for the *CreateHouseholds*, *PredictWorkers*, and *PredictIncome* modules in the *VESimHouseholds* package because household and worker age compositions and income distributions are likely to vary by region. For modules like these, the estimation data should be included in the 'inst/extdata' directory of the package in the form of CSV-formatted text files. The data files should be accompanied by text files having the same names but with a '.txt' extension rather than a '.csv' extension. The purpose of the text files is to document the corresponding data files so that model users will know how to obtain and prepare datasets for their region that can be used in model estimation. For example, the 'inst/extdata' directory of the *VESimHouseholds* package contains the following files: 'pums_households.csv', 'pums_households.txt', 'pums_persons.csv', and 'pums_persons.txt'.

If a module's estimation datasets are to be loaded from 'csv' files in the 'inst/extdata' directory, then the module code should include procedures to check those data for correctness to assure that the model parameters will be estimated correctly. The framework includes as function, *processEstimationInputs*, to assist with this task. The *processEstimationInputs* function has 3 arguments: *Inp_ls*, *FileName*, and *ModuleName*. *ModuleName* is the name of the module that is doing the processing. The sole purpose of this argument is to identify the module in any error messages that are written to the log. *FileName* is the name of the file in the 'inst/extdata' directory to be processed. *Inp_ls* is a list of data specifications that are used in checking the correctness of the data. This is explained in more detail below. The *processEstimationInputs* function returns a data frame which contains the data in the specified file, if those data have no errors. Following is an example of how the *processEstimationInputs* function is used:

```
Hh_df <- processEstimationInputs(
    Inp_ls = PumsHhInp_ls,
    FileName = "pums_households.csv",
    ModuleName = "CreateEstimationDatasets")
```

Before the estimation data may be checked, the script must describe specifications for the data. The structure of the specifications is best described using an example. The following code snippet is from the *CreateEstimationDatasets.R* script:

```
PumsHhInp_ls <- items(
  item(
    NAME =
      items("SERIALNO",
            "PUMA5",
            "HWEIGHT",
            "UNITTYPE",
            "PERSONS"),
    TYPE = "integer",
    PROHIBIT = c("NA", "< 0"),
    ISELEMENTOF = "",
    UNLIKELY = "",
    TOTAL = ""
  ),
  item(
    NAME = "BLDGSZ",
    TYPE = "integer",
    PROHIBIT = c("< 0"),
    ISELEMENTOF = "",
    UNLIKELY = "",
    TOTAL = ""
  ),
  item(
    NAME = "HINC",
    TYPE = "double",
    PROHIBIT = c("NA"),
    ISELEMENTOF = "",
    UNLIKELY = "",
    TOTAL = ""
  )
)
```

The meanings of these specifications are as follows:  
- **NAME** This is the name(s) of the data column in the file. The name must be a character string (i.e. surrounded by quotation marks). If multiple columns of the file have the same specifications except for their names, they can listed as in the first item in the example. This method avoids a lot of redundant specifications. Note that the order of specifications does not need to be the same as the order of the columns in the file. Also note that it is OK if the file contains columns that are not specified, as long as it contains all of the columns that are specified. Columns that are not listed are ignored.  
- **TYPE** This the data type of the data contained in the column. Allowable types are the 4 primitive types recognized by the R language (integer, double, character, and logical), the complex types listed in section 6.4, or 'compound'. The type must be a character string.  
- **PROHIBIT** This is a character vector which identifies all prohibited data conditions. For example, the specification for the "PERSONS" data column in the example above is c("NA", "< 0"). This means that there cannot be any values that are undefined (NA) or less than 0. The symbols that may be used in a PROHIBIT specification are: NA, ==, !=, <, <=, >, >= (i.e. undefined, equal to, not equal to, less than, less than or equal to, greater than, greater than or equal to). Note that prohibited conditions must be represented as character strings. If there is more than one prohibited condition, as in the example, the conditions must be entered as an R vector using the 'c()' function, as shown in the example. The absence of prohibited conditions is represented by an empty character string (i.e. "").  
- **ISELEMENTOF** This is a vector which specifies the set of allowed values. It is used when the input values must be elements of a set of discrete values. The vector describing the set must be of the same type as is specified for the input data. Vectors of elements are entered using the 'c()' function. For example, if the entries in a column of data could only have the values 'urban' or 'rural', then the specification owould be written as c("urban", "rural"). The absence of a specification for this is represented by an empty character string.  
- **UNLIKELY** This is a vector of conditions that while not prohibited, are not likely to occur. While conditions identified in the PROHIBIT and ISELEMENTOF specifications will produce an error if they are not met (thereby stopping the calculation of parameters), the conditions identified in the UNLIKELY specification will only produce a warning message. Vectors of conditions are entered using the 'c()' function. 
- **TOTAL** This specifies a required total value for the column of data. This is useful if the data represents proportions or percentages and must add up to 1 or 100. The absence of a specification for this is represented by an empty character string.

In some instances it is impractical to include the model estimation data as files in the 'inst/extdata' directory, and not necessary for model users to provide regional model estimation data. If, for example, the source data has confidential elements, it may be necessary to preprocess the data to anonymize it before including in the package; or the source data may be too large to include as a text file in the package. In these cases, source data may be processed outside of the package and then the processed datasets included in the package as datasets in R binary files. If that is done, the binary data files should be placed in a directory named 'data-raw' in the package.

For large datasets, it is also possible to have them stored remotely and to have the module code retrieve them from remote storage. This is what is done in the *Make2001NHTSDataset.r* script in the *VE2001NHTS* package. Zip archives of the public use datasets for the 2001 National Household Travel Survey are stored in a GitHub repository (https://github.com/VisionEval/NHTS2001). There are 4 zip archive files stored in the 'data' directory of the repository: DAYPUB.zip, HHPUB.zip, PERPUB.zip, and VEHPUB.zip. Each zip archive contains a compressed 'csv' formatted text file containing the data of interest. Because the process  of downloading and unzipping some of the files takes an appreciable amount of time, the script checks whether that has already been done (by the presence of a file in the 'data-raw' directory). If it has not been done, the script calls a function which handles the downloading, unzipping, and reading of the file. It also cleans up temporary files created when the zip archive was downloaded and unzipped. 

If a module is to download datafiles from remote storage, the module developer will need to write R code to handle the requisite tasks. The framework does not build in any functionality to do this. The coding is not complicated as the following example of commented snippets of code from the *Make2001NHTSDataset.r* script illustrate. The first section of code identifies the address of the data repository. The second section defines a function which handles downloading, unzipping, and reading a dataset stored in the repository, and cleaning up temporary files created in the process. The third section applies the handler function to download NHTS public use household data (HHPUB), selects relevant data fields, and saves those data as an R binary file to the 'data-raw' directory. If the R binary file already exists, the data are not downloaded from the repository but are loaded from the saved file instead.

```
#Identify the code repository. Note that in order to access data
#files from a GitHub repository, the beginning of the address must 
#be 'raw.githubusercontent.com' not 'github.com'
Nhts2001Repo <-
  "https://github.com/VisionEval/NHTS2001/blob/master/data"
  
#Define a function to handle retrieving a zipped dataset from the
#repository, unzipping it, reading the unzipped file, and cleaning
#up temporary files
getZipDatasetFromRepo <- function(Repo, DatasetName) {
  ZipArchiveFileName <- paste0(DatasetName, ".zip")
  CsvFileName <- paste0(DatasetName, ".csv")
  download.file(paste0(file.path(Repo, ZipArchiveFileName),"?raw=true"), ZipArchiveFileName)
  Data_df <- read.csv(unzip(ZipArchiveFileName), as.is = TRUE)
  file.remove(ZipArchiveFileName, CsvFileName)
  Data_df
}

#Download NHTS 2001 public use household data from repository and 
#process if it has not already been done
if (!file.exists("data-raw/Hh_df.rda")) {
  Hh_df <- getZipDatasetFromRepo(Nhts2001Repo, "HHPUB")
  Keep_ <- c("HOUSEID", "AGE_P1", "AGE_P2", "AGE_P3", "AGE_P4", "AGE_P5", "AGE_P6",
             "AGE_P7", "AGE_P8", "AGE_P9", "AGE_P10", "AGE_P11", "AGE_P12", "AGE_P13",
             "AGE_P14", "CENSUS_D", "CENSUS_R", "DRVRCNT", "EXPFLHHN", "EXPFLLHH",
             "FLGFINCM", "HBHRESDN", "HBHUR", "HBPPOPDN", "HHC_MSA", "HHFAMINC",
             "HHINCTTL", "HHNUMBIK", "HHR_AGE", "HHR_DRVR", "HHR_RACE", "HHR_SEX",
             "HHSIZE", "HHVEHCNT", "HOMETYPE", "HTEEMPDN", "HTHRESDN", "HTHUR",
             "HTPPOPDN", "LIF_CYC", "MSACAT", "MSASIZE", "RAIL", "RATIO16V",
             "URBAN", "URBRUR", "WRKCOUNT", "CNTTDHH")
  Hh_df <- Hh_df[, Keep_]
  save(Hh_df, file = "data-raw/Hh_df.rda", compress = TRUE)
} else {
  load("data-raw/Hh_df.rda")
}
```

#### Module Specifications

The module specifications section of the module script provides specifications that are used by the framework in a number of ways. The specifications:  
- Identify the level of geography that the model is to be run at;
- Describe all the data to be loaded from input files and enable unit conversions;
- Describe all the data that the module needs from the datastore in order to run;
- Describe all the data that the module produces that needs to be saved to the datastore;
- Identify other modules the module needs to call in order to do its calculations;
- Allow the framework to check and load all input files before any modules are run;
- Allow the framework to check that modules are compatible with one another in terms of the data that they produce and consume;
- Allow the sequence of model steps (module calls) to be simulated to check whether each module will have the data it needs when it is run; and,
- Provide detailed documentation about all data that is produced by a model run.  

These specifications are declared in a list that is similar to the list for specifying model estimation data described in Section 8.1.1.1. A full example is shown in Appendix E. Following is a skeleton of a module specifications list for a module whose name is *MyModule*. The name of the specifications list must be the concatenation of the module name and *Specifications*, so in this example the name is *MyModuleSpecifications*. Note that the functions *items* and *item* are aliases for the R *list* function. Their purpose is to make the specifications easier to read.  
```
MyModuleSpecifications <- list(
  RunBy = ...,
  NewInpTable = items(
    item(
      ...
    ),
    item(
      ...
    )
  ),
  NewSetTable = items(
    item(
      ...
    ),
    item(
      ...
    )
  ),
  Inp = items(
    item(
      ...
    ),
    item(
      ...
    )
  ),
  Get = items(
     item(
      ...
    ),
    item(
      ...
    )
  ),
  Set = items(
    item(
      ...
    ),
    item(
      ...
    )
  ),
  Call = items(
     item(
      ...
    ),
    item(
      ...
    )
  )
)
```  
Following are detailed descriptions and examples of each component of the specifications list.  

The **RunBy** component specifies the level of geography that the model is to be run at. For example, the congestion submodel in the GreenSTEP and RSPM models runs at the Marea level. This specification is used by the software framework to determine how to index data that is read from the datastore and data that is written to the datastore. Acceptable values are "Region", "Azone", "Bzone", and "Marea". The *RunBy* specification looks like the following example:

```
RunBy = "Marea",
```

The **NewInpTable** and **NewSetTable** components specify any new tables that need to be created in the datastore to accommodate input data or data produced by a module respectively. The following specifications are required for each new table that is to be created.  
- TABLE: the name of the table that is to be created; and,
- GROUP: the type of group the table is to be put into. There are 3 group types: *Global*, *BaseYear*, and *Year*. If *Global*, the table is created in the global group of the datastore. If *BaseYear* the table is created in the year group for the base year and only in that year group. For example, if the model base year is 2010, the table will be created in the *2010* group. If *Year*, the table will be created in the group for every model run year. For example, if the run years are 2010 and 2040, the table will be created in both the *2010* group and the *2040* group.  
Following is an example of a *NewSetTable* specification for creating a Vehicle table in each model run year group.  
```
NewSetTable = items(
  item(
    TABLE = "Vehicle",
    GROUP = "Year"
  )
),
```
  
The **Inp** component specifies all model inputs that the module requires. Each item in the list describes one or more data fields in an input file. Each item must have the following attributes (except for the OPTIONAL attribute):  
-  NAME: the names of one or more data fields in the input file, and the names used for the datasets when they are loaded into the datastore. The names must match corresponding column names with the exception that column names in input files may contain *year* and *multiplier* modifiers as described in Section 6.4.;  
-  FILE: the name of the file that contains the data fields;  
-  TABLE: the name of the datastore table the datasets will be put into;  
-  GROUP: the type of group where the table is located in the datastore (i.e. Global, Year, BaseYear);
-  TYPE: the data type (e.g. double, distance, compound);  
-  UNITS: the measurement units for the data;  
-  NAVALUE: the value used to represent NA (i.e. missing value) in the datastore;  
-  SIZE: the maximum number of characters for character data (or 0 for numeric data);  
-  PROHIBIT: data values that are prohibited or "" if not applicable (see Section 8.1.1.1 for explanation);  
-  ISELEMENTOF: allowed categorical data values or "" if not applicable (see Section 8.1.1.1 for explanation);  
-  UNLIKELY: data conditions that are unlikely or "" if not applicable (see Section 8.1.1.1 for explanation);  
-  TOTAL: the total for all values (e.g. 1) or "" if not applicable;  
-  DESCRIPTION: descriptions of the data corresponding to the names in the NAME attribute; and,  
-  OPTIONAL: optional specification which identifies whether dataset is optional (see section 8.1.2.1)  
Following is an example of the *Inp* component for the *PredictHousingSpecifications* in the *VELandUse* package. The *Inp* specifications include two items. Each item lists one or more field names (i.e. column names in the input file) in the NAME attribute. Multiple field names can be listed in an item if all the other attributes except for DESCRIPTION are the same for all the fields. The descriptions in the DESCRIPTION attribute must correspond in order to the dataset names in the NAME attribute in order for them to be stored correctly in the datastore. The values that may be entered for the TYPE and UNITS attributes are described in Section 6.3. It should be noted that the UNITS attribute must not include 'year' (for 'currency' type) or 'multiplier' information. That information is part of the input file field names instead (where relevant). This is explained in more detail in Section 6.4. The framework uses the information in the *Inp* to read the input files, check whether the data are correct, and save the data to the correct location in the datastore.     
```
Inp = items(
  item(
    NAME =
      items(
        "SFDU",
        "MFDU",
        "GQDU"),
    FILE = "bzone_dwelling_units.csv",
    TABLE = "Bzone",
    GROUP = "Year",
    TYPE = "integer",
    UNITS = "DU",
    NAVALUE = -1,
    SIZE = 0,
    PROHIBIT = c("NA", "< 0"),
    ISELEMENTOF = "",
    UNLIKELY = "",
    TOTAL = "",
    DESCRIPTION =
      items(
        "Number of single family dwelling units (PUMS codes 01 - 03) in zone",
        "Number of multi-family dwelling units (PUMS codes 04 - 09) in zone",
        "Number of qroup quarters population accommodations in zone"
      )
  ),
  item(
    NAME = items(
      "HhPropIncQ1",
      "HhPropIncQ2",
      "HhPropIncQ3",
      "HhPropIncQ4"),
    FILE = "bzone_hh_inc_qrtl_prop.csv",
    TABLE = "Bzone",
    GROUP = "Year",
    TYPE = "double",
    UNITS = "NA",
    NAVALUE = -1,
    SIZE = 0,
    PROHIBIT = c("NA", "< 0"),
    ISELEMENTOF = "",
    UNLIKELY = "",
    TOTAL = "",
    DESCRIPTION =
      items(
        "Proportion of Bzone households (non-group quarters) in 1st quartile of Azone household income",
        "Proportion of Bzone households (non-group quarters) in 2nd quartile of Azone household income",
        "Proportion of Bzone households (non-group quarters) in 3rd quartile of Azone household income",
        "Proportion of Bzone households (non-group quarters) in 4th quartile of Azone household income"
      )
  )
),
```
  
The **Get** component contains one or more items that identify data that the module need to have retrieved from the datastore. Note that the *Get* component must identify all datasets the module requires (other than those that are included in the package), including those specified in the *Inp* component. The datasets identified in the *Inp* component are not automatically made available to the module. Each item in the *Get* component specifies attributes for one or more related datasets as follows:  
-  NAME: the names of one or more datasets to be loaded;  
-  TABLE: the name of the table that the datasets are located in;  
-  GROUP: the type of group where the table is located in the datastore (i.e. Global, Year, BaseYear);  
-  TYPE: the data type (e.g. double, distance, compound);  
-  UNITS: the measurement units for the data;  
-  PROHIBIT: data values that are prohibited or "" if not applicable (see Section 8.1.1.1 for explanation);  
-  ISELEMENTOF: allowed categorical data values or "" if not applicable (see Section 8.1.1.1 for explanation); and,
-  OPTIONAL: optional specification which identifies whether dataset is optional (see section 8.1.2.1)  
Unlike the 'Inp' specifications, the 'Get' specifications for UNITS must include 'year' information for 'currency' types. This is necessary in order for the framework to convert the currency data being requested from the datastore to the year denomination that the module needs. The UNITS attribute may also include a multiplier specification if the module needs the values to be modified in that way. For example, if the module needs VMT in thousands of miles, the UNITS specification would be 'MI.1e3'. Section 6.3 provides more information on how 'year' and 'multiplier' options are added to a UNITS specification. Following is an example of the *Get* component of the *AssignRoadMilesSpecifications* in the *VETransportSupply* package.   
```
Get = items(
  item(
    NAME = "Marea",
    TABLE = "Marea",
    GROUP = "Year",
    TYPE = "character",
    UNITS = "ID",
    PROHIBIT = "",
    ISELEMENTOF = ""
  ),
  item(
    NAME =
      items(
        "FwyLaneMi",
        "ArtLaneMi"),
    TABLE = "Marea",
    GROUP = "Year",
    TYPE = "distance",
    UNITS = "MI",
    PROHIBIT = c("NA", "< 0"),
    ISELEMENTOF = ""
  ),
  item(
    NAME = "Marea",
    TABLE = "Bzone",
    GROUP = "Year",
    TYPE = "character",
    UNITS = "ID",
    PROHIBIT = "",
    ISELEMENTOF = ""
  ),
  item(
    NAME = "UrbanPop",
    TABLE = "Bzone",
    GROUP = "Year",
    TYPE = "people",
    UNITS = "PRSN",
    PROHIBIT = c("NA", "<= 0"),
    ISELEMENTOF = ""
  )
),
```  

The **Set** component contains one or more items describing datasets to be saved in the datastore. Each item in the *Set* component specifies attributes for one or more related datasets as follows:  
-  NAME: the names of one or more datasets to be saved;  
-  TABLE: the name of the table that the datasets are to be saved in;  
-  GROUP: the type of group where the table is located in the datastore (i.e. Global, Year, BaseYear);  
-  TYPE: the data type (e.g. double, distance, compound);  
-  UNITS: the measurement units for the data;  
-  NAVALUE: the value used to represent NA in the datastore;  
-  PROHIBIT: data values that are prohibited or "" if not applicable (see Section 8.1.1.1 for explanation);  
-  ISELEMENTOF: allowed categorical data values or "" if not applicable (see Section 8.1.1.1 for explanation);  
-  SIZE: the maximum number of characters for character data (or 0 for numeric data); and,
-  DESCRIPTION: descriptions of the data corresponding to the names in the NAME attribute  
The requirements for the UNITS attribute are the same as described above for *Get* component items. Following is an example of the *Set* component of the *AssignRoadMilesSpecifications* in the *VETransportSupply* package.   
```
Set = items(
  item(
    NAME = "FwyLaneMiPC",
    TABLE = "Marea",
    GROUP = "Year",
    TYPE = "compound",
    UNITS = "MI/PRSN",
    NAVALUE = -1,
    PROHIBIT = c("NA", "< 0"),
    ISELEMENTOF = "",
    SIZE = 0,
    DESCRIPTION = "Ratio of urbanized area freeway and expressway lane-miles to urbanized area population"
  )
)
```  
It should be noted that it may not be possible to prespecify the SIZE attribute for a dataset. For example, if a unique household ID is assigned, the SIZE attribute will depend on the number of households and so must be calculated when the module is run. In such a circumstance, the SIZE attribute is omitted from the item and the module function must calculate it and include the calculated value as an attribute of the output dataset. The following code snippet from the *CreateHouseholds* module code in the *VESimHouseholds* package shows how this is done. In this example, the list of data that the module function returns is named *Out_ls*. The household ID (*HhId*) dataset is in the *Household* table of the *Year* group. The R *attributes* function is called to set the SIZE attribute of the *HhId* dataset equal to the maximum of the number of characters in each of the entries in the dataset.  
```  
attributes(Out_ls$Year$Household$HhId)$SIZE <- max(nchar(Out_ls$Year$Household$HhId))  
```  

The last component in the the module specifications list is the **Call** component. This is an optional component of the module specifications and is included if the module calls any other modules or if the module may be called by other modules. Following are *Call* component examples. The first is an example for a module that may be called. The second is an example for a module which calls another module. Section 8.1.2.2 explains module calling in detail.  
```
#Call component for a module that may be called
Call = TRUE

#Call component for a module that calls another module
Call = items(
  CalcDvmt = "VEHouseholdTravel::CalculateHouseholdDvmt"
)
```

#### OPTIONAL Attribute  
Module developers can use the OPTIONAL attribute to identify optional inputs or data to be retrieved from the datastore. This enables modules to be written to respond to optional inputs. For example, in the GreenSTEP and RSPM models, users may provide inputs on the average carbon intensity of fuels (grams CO2e per megajoule) by model run year. This allows users to model a scenario where state regulations require the average carbon intensity of fuels to be reduced over time. If the user supplies those data, the models calculate carbon emissions using those inputs. If not, the model calculates emissions using data on the carbon intensities of different fuel types and the mix of those fuel types.  

If the OPTIONAL attribute for an item is missing, then the item is not optional. If the OPTIONAL attribute is not missing but is set equal to *FALSE* then the item is not optional as well. Only when the OPTIONAL attribute is present and set equal to *TRUE* does the framework regard the item as optional (`OPTIONAL = TRUE`).  

If an input (*Inp*) item is identified as optional, the framework checks whether the identified input file is present. If the file is present, then the framework will process the data and load it into the datastore. Otherwise the item is ignored. Note that optional inputs can't be combined with non-optional inputs in the same file. This will cause an error. Also not that since the framework does not automatically supply inputs to the module, there must be optional *Get* items corresponding to the optional *Inp* items. When the framework sees an optional *Get* item, it checks the datastore to see whether the optional dataset(s) are present. If so, it retrieves them.  

#### CALL Specification

If same calculation code needs to be executed a number of times, it is best to define a function to encapsulate the code and then call the function whenever the calculation needs to be carried out. This reduces errors and code maintenance hassles. Likewise, module code duplication is reduced in the VisionEval model system by allowing modules to call other modules for their calculation services. For example, the *BudgetHouseholdDvmt* module in the *VETravelPerformance* package calls the *CalculateAltModeTrips* module in the *VEHouseholdTravel* package to recalculate trips by alternate modes (walk, bike, transit) to reflect budget-adjusted household DVMT. Calling a module is more involved than just calling the function that carries out the module's calculations because the module function will not work unless it is supplied with the datasets identified in its *Get* specifications. Of course the calling module could include those specifications in its own specifications, but that would create a significant potential for coding errors and maintenance problems (e.g. if the called module is module is modified at a later time). For this reason the software design includes functionality for calling modules in a simple manner which leaves the data management details to the framework behind the scenes.  

A module's call status is specified in the *Call* component of the module specifications. There are 3 possibilities for a module's call status. First, a module may be called by other modules. In this case the specification is `Call = TRUE`. Second, the module may call other modules. In this case the call specification is a list that identifies each of the modules that are called, assigning a reference to the module to an alias (i.e. *alias = module*) as shown in the following example:  
```
Call = items(
  CalcDvmt = "CalculateHouseholdDvmt",
  ReduceDvmt = "ApplyDvmtReductions",
  CalcVehTrips = "CalculateVehicleTrips",
  CalcAltTrips = "CalculateAltModeTrips"
)
```
The *alias* is the name that the called module will be referred to by the calling module code. The *module* is the name of the called module. The VisionEval framework software identifies which package the module resides in from the *ModulesByPackage_df* table in the *ModelState_ls* list. It is also possible to hard code the package name in the call definition. For example the *CalcDvmt* alias could be assign to `VEHouseholdTravel::CalculateHouseholdDvmt`. This is discouraged, however, because doing so limits the ability to maintain different versions of packages that have module modifications.  
```
Call = items(
  CalcDvmt = "VEHouseholdTravel::CalculateHouseholdDvmt"
)
```  
The third possibility is that a module may not be called and calls no other modules. In that case a *Call* component is not included in the module specifications.

There are some important restrictions to module calling. First, a module that may be called cannot call another module. If this restriction did not exist, there could be deeply nested module calls which could make debugging and understanding how a model works very difficult. Second, a module that may be called cannot have any inputs (i.e. *Inp* component). The reason for this restriction is that the function of called modules is to provide calculation services and those are hidden from model users. Unless a called module was also called directly in the model run script, there would be no way model user would know to supply input files without diving into the details about the module doing the calling. 

The framework does the following when a module is run which calls one or more other modules. For each of the modules that are called, the framework:  
1) Reads the 'Get' specifications for the called module, gets the datasets from the datastore, puts them in the standard list structure, and adds to the list that will be returned to the calling module as a component whose name is the assigned alias. In the example above, the retrieved datasets would be in a component named "CalcDvmt".  
2) Creates a list which holds the values of the called module functions. Each called module function is a component of the list whose name is the assigned alias. In the example above, this function list would have one component named "CalcDvmt" which contains the value of the CalculateHouseholdDVMT function.  
3) The framework passes these two lists to the calling module when it is run. Thus the calling module function must be written to accept two arguments rather than one.  

The calling module code invokes the called module by calling it from the function list that the framework passes it and passing to it the data it needs from the data list. Following from the example above, if the data list is called 'L' and the function list is called 'M', then the *CalculateHouseholdDVMT* module function would be called in the *AssignHhVehiclePowertrain* module as follows:  
```
M$CalcDvmt(L$CalcDvmt)
```

#### Module Function

The **function definitions** section of the module script is used to define all functions that will be used to implement the module. One of these functions is the main function that is called by the software framework to run the module. This function must have the same name as the module name. For example, the main function of the *CreateHouseholds* module is named *CreateHouseholds* as well. This function must be written to accept one argument, a list, which by convention is named L if the module calls no other modules, and two arguments (as explained in the previous section) if the module calls other modules. This list contains all of the datasets identified in the *Get* component of the module data specifications. The structure of this list is described in Section 7. The main function returns a list which contains all of the datasets identified in the *Set* component of the module data specifications and structured as described in Section 7. The software framework includes a function, *initDataList*, to initialize an outputs list having the proper structure with *Global*, *Year*, and *BaseYear* components. The module code will fill in each component with components for each of the specified tables and datasets within those tables. Following is a simple example from the *AssignTransitService* module in the *VETransportSupply* package. First, here are the module's *Set* items to provide context for the module code:  
```
Set = items(
  item(
    NAME = "TranRevMiPC",
    TABLE = "Marea",
    GROUP = "Year",
    TYPE = "compound",
    UNITS = "MI/PRSN",
    NAVALUE = -1,
    PROHIBIT = c("NA", "< 0"),
    ISELEMENTOF = "",
    SIZE = 0,
    DESCRIPTION = "Ratio of bus-equivalent revenue-miles (i.e. revenue-miles at the same productivity - passenger miles per revenue mile - as standard bus) to urbanized area population"
  )
)
```
The *AssignTransitService* function returns one dataset called *TranRevMiPc*. This dataset will be placed in the *Marea* table in the *Year* group (i.e. in the group for each model run year). Following is the function definition:  
```
AssignTransitService <- function(L) {
  #Set up
  #------
  #Fix seed as synthesis involves sampling
  set.seed(L$G$Seed)
  #Define vector of modes
  Md <- as.character(BusEquivalents_df$Mode)
  #Define vector of Mareas
  Ma <- L$Year$Marea$Marea

  #Calculate bus equivalent revenue miles
  #--------------------------------------
  #Make table of revenue miles by Marea
  RevMi_df <- data.frame(L$Year$Marea[paste0(Md, "RevMi")])
  colnames(RevMi_df) <- Md
  rownames(RevMi_df) <- Ma
  RevMi_MaMd <- as.matrix(RevMi_df)
  #Calculate the bus equivalent revenue miles
  BusEq_Md <- BusEquivalents_df$BusEquivalents
  names(BusEq_Md) <- Md
  BusEqRevMi_Ma <-
    rowSums(sweep(RevMi_MaMd, 2, BusEq_Md, "*"))[Ma]

  #Calculate the bus equivalent revenue miles per capita
  #-----------------------------------------------------
  #Calculate population in the urbanized area
  UrbanPop_Ma <-
    tapply(L$Year$Bzone$UrbanPop, L$Year$Bzone$Marea, sum)[Ma]
  #Calculate Marea bus equivalent revenue miles per capita
  TranRevMiPC_Ma <- BusEqRevMi_Ma / UrbanPop_Ma

  #Return the results
  #------------------
  #Initialize output list
  Out_ls <- initDataList()
  Out_ls$Year$Marea <-
    list(TranRevMiPC = TranRevMiPC_Ma)
  #Return the outputs list
  Out_ls
}
```

A module should include procedures as necessary to check for errors in output datasets. In most cases this won't be necessary if the module passes tests during development because the framework checks that all datasets passed to the module meet the module's specifications. However there may be conditions where some combinations of acceptable inputs produce unacceptable outputs. In such cases, the module code should check for unacceptable outputs and if found, report those to the framework for reporting to the model user and stopping the model run. The module should not stop the model run. Instead it composes a descriptive error message and adds it to an *Errors* component of the module outputs list. If there is more than one error, the *Errors* component will be a vector of error messages. The framework writes the error message(s) to the model run log and stops model execution.  

Warnings are handled in a similar way. If the module code is checks for warning conditions (i.e. model execution should not be stopped but users should be about the condition) and finds any, it composes a warning message that is added to a *Warnings* component of the module outputs list. The framework writes warnings messages to the model run log.  

The functionality for processing module errors and warnings is used primarily by *Initialize* modules as explained in Section 8.1.5.  

#### Module Documentation

It is recommended that module documentation be included at the top of the module script file if possible to make it easier to review and analyze the module. A standardized approach has been developed to do this that produces documentation in [markdown](https://en.wikipedia.org/wiki/Markdown) format that can be viewed as a web page or converted to other formats for printing. At the end of the module script the *documentModule* function like this `documentModule("PredictIncome")`. The *documentModule* parses the module script, extracts the documentation block at the head of the file and inserts any text, tables, or figures that are saved by the script and inserted into the documentation using special *tags* as explained below. In addition, the *documentModule* function reads the module specifications and creates formatted tables showing module inputs, datasets used, and datasets produced. The documentation file(s) are then saved to a *model_docs* directory in the *inst/extdata* directory which is in turn a directory in the installed package. The *documentModule* function is called at the end of the script because the rest of the script must be executed to produce the datasets that are inserted into the documentation file. Following is an example of what a documentation block looks like.

```
#<doc>
## PredictIncome Module
#### September 6, 2018
#
#This module predicts the income for each simulated household given the number of workers in each age group and the average per capita income for the Azone where the household resides.
#
### Model Parameter Estimation
#Household income models are estimated for *regular* households and for *group quarters* households.
#
#The household income models are estimated using Census public use microsample (PUMS) data that are compiled into a R dataset (HhData_df) by the 'CreateEstimationDatasets.R' script when the VESimHouseholds package is built. The data that are supplied with the VESimHouseholds package downloaded from the VisionEval repository may be used, but it is preferrable to use data for the region being modeled. How this is done is explained in the documentation for the *CreateEstimationDatasets.R* script.
#
#The household income models are linear regression models in which the dependent variable is a power transformation of income. Power transformation is needed in order to normalize the income data distribution which has a long right-hand tail. The power transform is found which minimizes the skewness of the income distribution. The power transform for *regular* households is:
#
#<txt:HHIncModel_ls$Pow>
#
#The power transform for *group quarters* households is:
#
#<txt:GQIncModel_ls$Pow>
#
#The independent variables for the linear models are power transformed per capita income for the area, the number of workers in each of 4 worker age groups (15-19, 20-29, 30-54, 55-64), and the number of persons in the 65+ age group. In addition, power-transformed per capita income is interacted with each of the 4 worker groups and 65+ age group variable. The summary statistics for the *regular* household model are as follows:
#
#<txt:HHIncModel_ls$Summary>
#
#The summary statistics for the *group quarters* household model are as follows:
#
#<txt:GQIncModel_ls$Summary>
#
#An additional step must be carried out in order to predict household income. Because the linear model does not account for all of the observed variance, and because income is power distribution, the average of the predicted per capita income is less than the average per capita income of the population. To compensate, random variation needs to be added to each household prediction of power-transformed income by randomly selecting from a normal distribution that is centered on the value predicted by the linear model and has a standard deviation that is calculated so as the resulting average per capita income of households match the input value. A binary search process is used to find the suitable standard deviation. Following is the comparison of mean values for the observed *regular* household income for the estimation dataset and the corresponding predicted values for the estimation dataset.
#
#<tab:HHIncModel_ls$MeanCompare>
#
#The following figure compares the distributions of the observed and predicted incomes of *regular* households.
#
#<fig:reg-hh-inc_obs-vs-est_distributions.png>
#
#Following is the comparison of mean values for the observed *group quarters* household income for the estimation dataset and the corresponding predicted values for the estimation dataset.
#
#<tab:GQIncModel_ls$MeanCompare>
#
#The following figure compares the distributions of the observed and predicted incomes of *groups quarters* households.
#
#<fig:gq-hh-inc_obs-vs-est_distributions.png>
#
### How the Module Works
#This module runs at the Azone level. Azone household average per capita income and group quarters average per capita income are user inputs to the model. The other model inputs are in the datastore, having been created by the CreateHouseholds and PredictWorkers modules. Household income is predicted separately for *regular* and *group quarters* households. Per capita income is transformed using the estimated power transform, the model dependent variables are calculated, and the linear model is applied. Random variation is applied so that the per capita mean income for the predicted household income matches the input value.
#

#</doc>

```

There are several things to note about this example. The first is that all text in the block is commented out (preceded by #). Since R doesn't support block comments, each line must be commented. It may not look this way in the example because of word wrapping, but every line is commented. Second, the start and end of the documentation block are denoted by matching `<doc>` and `</doc>` tags. The parser uses these to extract the documentation from the script. After the document has been extracted, the leading comments are stripped off, resulting in markdown-formatted text. The other comment (#) symbols in the text are actually markdown formatting to identify headings of different levels. Documentation can include any standard markdown formatting such as emphasis, links, and tables. In addition, the documentation can include special tags as shown in the example. Three types of tags are available:

* `<txt:xxxx>` inserts a block of text that is contained in the referenced object. For example the `<txt:GQIncModel_ls$Summary>` tag in the example will insert summary statistics for the group quarters income model.

* `<tab:xxxx>` inserts data that can be presented in table for such as a data frame. For example the `<tab:HHIncModel_ls$MeanCompare>` tag in the example will insert a table which compares observed and estimated mean values.

* `<fig:xxxx>` creates a markdown reference to an image file so that it will be show in the proper place when the markdown is displayed in a browser or converted to another document form. For example the `<fig:reg-hh-inc_obs-vs-est_distributions.png>` tag in the example will insert a figure which compares observed and estimated income distributions when the markdown is displayed.

It is helpful to include test code in the module script to aid with module development. The framework includes a *testModule* function to assist with module testing. This function is described in detail in Section 9.2.1. Testing requires having sample input files containing datasets specified by the modules *Inp* specifications. These are stored in the 'inputs' directory of the 'tests' directory. The 'tests' directory also must contain a 'defs' directory which contains all the required model definitions files (see Section 6.1). Finally, the 'tests' directory must contain a datastore of the type specified in the 'run_parameters.json' file, which contains all of the datasets specified in the modules *Get* specifications. In the first stage of module testing, the module specifications are checked, all input files are checked, the presence of all required data is checked, and an input list (L) is returned for use in module development. For this test, the *DoRun* argument of the *testModule* function needs to be set to *FALSE*. After the module code has been written, the module is tested again to check whether the module code is working correctly and that it returns results that are consistent with the *Set* specifications for the module. For this test, the *DoRun* argument of the *testModule* function must be *TRUE*. After the module has been tested, it is important to comment out all the testing code in the script because it must not be run when the package is built. Following is an example of testing code in a module that has been commented out.  


#### Initialize Module
Although the framework performs several checks on module input data based on the module specifications, there will be times when additional checks of inputs will be necessary and possibly transformations as well. For example, several datasets could have proportions data that must add up to 1 across the datasets. For example, 4 input datasets for the *PredictHousing* module of the *VELandUse** package give the proportions of households in each Bzone that are in each of 4 income quartiles for the Azone that the Bzones are located in. These inputs should be checked to assure that the sum of all quartile proportions for each Bzone adds up to one. If any sums are not close to 1, then the model user needs to be alerted to the fact so that they can correct the input file. If all the sums are close to 1 but some are not exactly 1 (due to rounding errors in preparing inputs), the inputs should be automatically adjusted to equal 1 before they are saved in the datastore. If a module developer needs to establish more complex checks and transformations like this, they do so in a special module that they name *Initialize*. 

In the *Initialize* module, the module specifications identify all of the input datasets that need to be checked. This is done in same manner as described in Section 8.1.2. The module specifications will not have *Get* or *Set* components since the only purpose of the *Initialize* module is to process inputs. There can only be one *Initialize* module in a package and so all inputs that need additional checking, regardless of which module in the package will use them, need to be processed in the *Initialize* module. Datasets that are listed in the *Inp* specifications of the *Initialize* module must not be included in the *Inp* specifications of any other module in the package.   

When a model is intialized by the *initializeModel* function in the *run_model.R* script (Section 5 and Appendix A), each of the module packages that will be run by the script is checked for the presence of an *Initialize* module. Any that are found are added to a list of modules that require input processing. When the *initializeModel* function processes the inputs for an *Initialize* module it does so in two steps. In the first step, it performs the standard input processing that is done for all modules (input files are read and datasets are checked for completeness and correctness). The output of this checking process is a standard outputs list with *Global*, *BaseYear*, and *Year* components. In the second step, the framework calls the *Initialize* module function and passes it the outputs list from the first step. The *Initialize* module does whatever enhanced data checking and transformation is necessary and returns an outputs list having the same structure as the inputs list with the addition of *Errors* and *Warnings* components (see Section 8.1.3). Several of the VisionEval packages include *Initialize* modules and can be used as examples.

### The inst/extdata Directory
By convention, the 'inst/extdata' directory is the standard place to put external (raw) data files as opposed to R datasets which are placed in the 'data' directory. This is where most model estimation data is kept. Section 8.1.1.1 provides a detailed explanation. The directory should include a subdirectory named 'sources' to hold reports or other external documentation if needed.

### The data-raw Directory
In some instances it is impractical to include the model estimation data as files in the 'inst/extdata' directory, and not necessary for model users to provide regional model estimation data. If, for example, the source data has confidential elements, it may be necessary to preprocess the data to anonymize it before including in the package; or the source data may be too large to include as a text file in the package. In these cases, source data may be processed outside of the package and then the processed datasets included in the package as datasets in R binary files. If that is done, the binary data files should be placed in a directory named 'data-raw' in the package.

### The tests Directory
The 'tests' directory contains R scripts and the results of module tests. The *scripts* directory contains all the scripts used to carry out module tests. The directory also contains subdirectories for each of the model types the module is to be tested with (e.g VE-RSPM, VE-State, VE-RPAT). Two approaches are available for handing module data that includes input files the module uses, all the *defs* files, and a datastore which contains all the datasets used by the module aside from those in the input files. These data can be included in the package or they may be kept in a central repository. If they are included in the package, they must be placed in the directory for the corresponding model. This is necessary to avoid conflicts in the test data for different models. The scripts directory includes a testing script which runs the tests on all modules in a package for a particular module. For example, the script for testing modules in a VE-State application is named *vestate_test.R*. The scripts directory also includes a *test.R* script which calls the individual model test scripts for automated package testing. If the centralized data testing approach is used, a *test_functions.R* script needs to be included. This includes functions needed to support the centralized test data approach. The test process is still not finalized. In the future this functionality will be included in the framework software. Following is an example of a test script using the central data approach:

```
#vestate_test.R
#--------------

#Load packages and test functions
library(visioneval)
library(filesstrings)
source("tests/scripts/test_functions.R")

#Define test setup parameters
TestSetup_ls <- list(
  TestDataRepo = "../Test_Data/VE-State",
  DatastoreName = "Datastore.tar",
  LoadDatastore = FALSE,
  TestDocsDir = "vestate",
  ClearLogs = TRUE,
  # SaveDatastore = TRUE
  SaveDatastore = FALSE
)

#Define the module tests
Tests_ls <- list(
  list(ModuleName = "CreateHouseholds", LoadDatastore = FALSE, SaveDatastore = TRUE, DoRun = TRUE),
  list(ModuleName = "PredictWorkers", LoadDatastore = TRUE, SaveDatastore = TRUE, DoRun = TRUE),
  list(ModuleName = "AssignLifeCycle", LoadDatastore = TRUE, SaveDatastore = TRUE, DoRun = TRUE),
  list(ModuleName = "PredictIncome", LoadDatastore = TRUE, SaveDatastore = TRUE, DoRun = TRUE)
)

#Set up, run tests, and save test results
setUpTests(TestSetup_ls)
doTests(Tests_ls, TestSetup_ls)
saveTestResults(TestSetup_ls)

```

