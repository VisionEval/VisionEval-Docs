## VERPAT Tutorial {#verpat}

## Overview

VERPAT is a tool for evaluating the impact of various smart growth policies. VERPAT is designed to be a high-level evaluation at a regional scale that can bridge the distance between evaluating smart growth policies during a regional visioning process and evaluating smart growth policies at a project or alternative level in a regional transportation plan. VERPAT evaluates policy scenarios to identify the most promising policies that could be further tested using a more detailed project-level tool. Currently, VERPAT can provide information on the following changes in the regional system:

  + Built Environment - changes to the urban form (proportion of population and employment living in mixed-use areas, transit-oriented developments, or rural/greenfield areas)
  + Travel Demand - changes in population demographics (age structure), changes in personal income, changes in firms by size or industry, relative amounts of development occurring in urban core, close-in communities, suburban or rural areas, urban core, auto and light truck proportions by year, and induced demand
  + Transportation Supply - amounts of regional transit service, amounts of freeway and arterial capacity
  + Policies - pricing (vehicle miles traveled charges or parking pricing programs), intelligent transportation system (ITS) strategies for freeways and arterials, demand management (vanpool, telecommuting, ridesharing, and transit pass programs)

VERPAT is designed to evaluate regions, which can be a multi-county metropolitan region. It distinguishes between population and employment living/working in the urban core, close-in communities, suburban and rural/greenfield areas based on densities, diversity in land uses, street design or intersection densities, job accessibility by auto, distances to transit stops, and connectivity of the street system.  

The intended audience for VERPAT is regional decision-makers and land use and transportation planners involved in the development and evaluation of transportation and land use policies, and who need to conduct scenario planning to evaluate smart growth policies and determine their impact on travel demand. VERPAT was designed to address as many of the limitations identified in the research as possible and to provide a tool that filled a gap in the set of available tools. The relationships in the VERPAT tool were based upon the background research conducted for the SHRP 2 C16 project. VERPAT is designed to allow the evaluation of a wide range of policies and combination of policies in a consistent framework quickly and easily so that promising smart growth strategies can be identified and pursued in the land use and transportation planning processes. VERPAT is intended to precede and supplement more sophisticated modeling efforts, which can be used to evaluate specific smart growth projects. It is designed to be accessible to land use and transportation planners with no modeling experience.

### VERPAT Model Structure

VERPAT is a disaggregate policy model that predicts travel demand impacts at an individual household level. 

The diagram below illustrates the modeling system with model components and feedback loops. Links are provided to the source code that implements each section.


<table>
  <tr>
    <td><img align="center" width="500" border=1 src="VERPAT-Tutorial-images/rpat_process.png"></td> 
    <td> <ul> 
    
	<li> <a href="https://github.com/visioneval/VisionEval/tree/master/sources/modules/VESimHouseholds"> Household Models: Households Package </a> </li>
	<li> <a href="https://github.com/visioneval/VisionEval/tree/master/sources/modules/VESyntheticFirms"> Firms Models: Firms Package </a> </li>
	<li> <a href="https://github.com/visioneval/VisionEval/tree/master/sources/modules/VELandUse"> Urban Form Models: Land Use Package </a> </li>
	<li> <a href="https://github.com/visioneval/VisionEval/tree/master/sources/modules/VETransportSupply"> Accessibility Models: Transport Supply Package </a> </li>
	<li> <a href="https://github.com/visioneval/VisionEval/tree/master/sources/modules/VEHouseholdVehicles"> Vehicle Models: Household Vehicles Package </a> </li>
	<li> <a href="https://github.com/visioneval/VisionEval/tree/master/sources/modules/VEHouseholdTravel"> Travel Demand Models: Household Travel Package </a> </li>
	<li> <a href="https://github.com/visioneval/VisionEval/tree/master/sources/modules/VETransportSupplyUse"> Congestion Models: Transport Supply Use Package </a> </li>
	<li> <a href="https://github.com/visioneval/VisionEval/tree/master/sources/modules/VETravelPerformance"> Travel Performance Package </a> </li>
	<li> <a href="https://github.com/visioneval/VisionEval/tree/master/sources/modules/VEReports"> Reporting Package </a> </li>
	</ul> </td>
  </tr>
</table>


For more, see [[VERPAT Modules and Outputs | VERPAT-Modules-and-Outputs]].

### VERPAT Modules

VERPAT does not provide specific spatial results beyond the built environment categories at the regional level, but does capture individual household and firm characteristics and the interactions between policies. The disaggregate nature of the model captures impacts that may be occurring for small portions of the population (say 0-vehicle households) where aggregate models have a more difficult time capturing these impacts.  

The following is an explanation of major steps in the model execution


[] = indicates VE modules

  1. **Household Model** - *Households Package*  

Create synthetic households for the region, including persons [[Create Households](https://github.com/visioneval/VisionEval/wiki/VERPAT-Modules-and-Outputs#createhouseholds)] and workers [[Predict Workers](https://github.com/visioneval/VisionEval/wiki/VERPAT-Modules-and-Outputs#predictworkers)] by age group. A total household income is assigned to each household, given the ages of persons in the household and the average per capita income of the region where the household resides  [[PredictIncome](https://github.com/visioneval/VisionEval/wiki/VERPAT-Modules-and-Outputs#predictincome)].
  
  2. **Firm Model** - *Synthetic Firms Package*  
    A set of firms is created for each forecast year that represents the likely firm composition for the region, given the County Business Pattern data of firms by size and industry. Each firm is described in terms of the number of employees and its industry [[CreateBaseSyntheticFirms](https://github.com/visioneval/VisionEval/wiki/VERPAT-Modules-and-Outputs#createbasesyntheticfirms)] and [[CreateFutureSyntheticFirms](https://github.com/visioneval/VisionEval/tree/master/sources/modules/VESyntheticFirms)].
  
  3. **Urban Form Model** - *Land Use Package*  
    Calculate Place Types for Households and Firms - Population and employment location characteristics are important variables in the vehicle ownership, travel demand, and accessibility models. There are four place types (urban core, Close-in Community, suburban, and rural and five location categories (residential, commercial, mixed-use, transit-oriented development, and Greenfield)]. Models for households were developed to estimate location characteristics using National Household Travel Survey data. Firms are currently allocated randomly to fit the employment allocation inputs since there are no national datasets from which to draw these relationships [[CalculateBasePlaceTypes](https://github.com/visioneval/VisionEval/wiki/VERPAT-Modules-and-Outputs#calculatebaseplacetypes)] and [[CalculateFuturePlaceTypes](https://github.com/visioneval/VisionEval/wiki/VERPAT-Modules-and-Outputs#calculatefutureplacetypes)].
  
  4. **Accessibility Model** - *Transport Supply Package*  
    Calculate Freeway, Arterial, and Public Transit Supply Levels - The number of lane miles of freeways and arterials is computed for each region based on the change in inventories for a particular scenario. For public transit, the inputs specify the change in transit revenue miles relative to the base. Inputs for each area also specify the revenue mile split between electrified rail and buses [[CreateBaseAccessibility](https://github.com/visioneval/VisionEval/wiki/VERPAT-Modules-and-Outputs#createbaseaccessibility)] and [[CreateFutureAccessibility](https://github.com/visioneval/VisionEval/wiki/VERPAT-Modules-and-Outputs#createfutureaccessibility)].
  
  5. **Vehicle Model** - *Household Vehicle Package*  
    Calculate Vehicle Ownership - Each household is assigned the number of vehicles it is likely to own based on the number of persons of driving age in the household, whether only elderly persons live in the household, the income of the household, the population density where the household lives, the freeway supply, the transit supply, and whether the household is located in an urban mixed-use area.   [[AssignVehicleFeatures](https://github.com/visioneval/VisionEval/wiki/VERPAT-Modules-and-Outputs#assignvehiclefeatures)] and [[AssignVehicleFeaturesFuture](https://github.com/visioneval/VisionEval/wiki/VERPAT-Modules-and-Outputs#assignvehiclefeaturesfuture)].
  
  6. **Travel Demand Model** - *Household Travel Package*  
    Calculate Travel Demand - The average daily vehicle miles traveled, classification of vehicles as electric vehicles, auto and transit trips for each household is modeled based on household information determined in previous steps for the base conditions. The model is sensitive to household income, population density of the neighborhood where the household resides, number of household vehicles, whether the household owns no vehicles, the levels of public transportation and freeway supplies in the region, the driving age population in the household, the presence of persons over age 65, and whether the neighborhood is characterized by mixed-use development. [[CalculateTravelDemand](https://github.com/visioneval/VisionEval/wiki/VERPAT-Modules-and-Outputs#calculatetraveldemand)] and [[CalculateTravelDemandFuture](https://github.com/visioneval/VisionEval/wiki/VERPAT-Modules-and-Outputs#calculatetraveldemandfuture)].   
    
    Calculate Truck and Bus Vehicle Miles Traveled (VMT) - Regional truck VMT is calculated based on changes in the regional household income. As a default, a one-to-one relationship between regional income growth and truck VMT growth is assumed. In other words, a doubling of total regional income would result in a doubling of truck VMT. Bus VMT is calculated from bus revenue miles that are factored up to total vehicle miles to account for miles driven in non-revenue service. [[CalculateTravelDemand](https://github.com/visioneval/VisionEval/wiki/VERPAT-Modules-and-Outputs#calculatetraveldemand)] and [[CalculateTravelDemandFuture](https://github.com/visioneval/VisionEval/wiki/VERPAT-Modules-and-Outputs#calculatetraveldemandfuture)].   
  
  7. **Congestion Model** - *Transport Supply Use Package*  
    Calculate the amount of congestion – Auto, and light truck VMT, truck VMT and bus VMT are allocated to freeways, arterials, and other roadways. Truck and bus VMT are allocated based on mode-specific data, and auto and light truck VMT are allocated based on a combination of factors and a model that is sensitive to the relative supplies of freeway and arterial lane miles. System-wide ratios of VMT to lane miles for freeways and arterials are used to allocate VMT to congestion levels using congestion levels defined by the Texas Transportation Institute for the Urban Mobility Report. Each freeway and arterial congestion level is associated with an average trip speed for conditions that do and do not include ITS treatment for incident management on the roadway. Overall average speeds by congestion level are calculated based on input assumptions about the degree of incident management. Speed vs. fuel efficiency relationships for light vehicles, trucks, and buses are used to adjust the fleet fuel efficiency averages computed for the region. [[CalculateCongestionBase](https://github.com/visioneval/VisionEval/wiki/VERPAT-Modules-and-Outputs#calculatecongestionbase)], [[CalculateCongestionFuture](https://github.com/visioneval/VisionEval/wiki/VERPAT-Modules-and-Outputs#calculatecongestionfuture)], and [[CalculateCongestionPolicy](https://github.com/visioneval/VisionEval/wiki/VERPAT-Modules-and-Outputs#calculatecongestionpolicy)].

### Feedback loops

Following initial calculations for baseline conditions, the model has feedback loops, which allow for changes in travel demand and other impacts based on induced travel demand and for changes in policies for a given scenario. Congestion is recalculated following these adjustments to demand.

  + **Induced Demand Model** - *Household Travel Package*  

    Calculate Induced Travel Demand - Induced demand is calculated for changes in roadway supply in the near term as a function of speed, based on potential mode and route shifts to produce changes in VMT and in the longer term to include changes in vehicle ownership, still as a function of speed. This model does not include induced demand as a result of changes in growth that may occur as part of a smart growth scenario because the evidence is limited empirical evidence. [[CalculateInducedDemand](https://github.com/visioneval/VisionEval/wiki/VERPAT-Modules-and-Outputs#calculateinduceddemand)].

  + **Policy Adjusted Travel Demand** - *Household Travel Package*  
    Calculate Scenario Travel Demand - The average daily VMT for each household can be adjusted based on changes in growth patterns by place type, changes in auto operating cost, changes in road lane miles or transit revenue miles for any scenario. There are also a series of policy assumptions that can contribute to changes in VMT: pricing such as VMT charges or parking pricing, ITS strategies for freeways and arterials, and vanpool, telecommuting, ridesharing, and transit pass programs. All of these will contribute to shifts in travel demand for a given scenario. [[CalculatePolicyVmt](https://github.com/visioneval/VisionEval/wiki/VERPAT-Modules-and-Outputs#calculatepolicyvmt)].  

Performance metrics are calculated in the [VEReports package](https://github.com/visioneval/VisionEval/tree/master/sources/modules/VEReports).  The other impacts that are produced for a given scenario include environment and energy impacts greenhouse gas (GHG) emissions and fuel consumption), financial and economic impacts (highway and transit infrastructure costs, transit operating costs, and traveler costs), regional accessibility, and community impacts (livability and public health indicators).

### For more information

  + [VERPAT Modules and Outputs](https://github.com/visioneval/VisionEval/wiki/VERPAT-Modules-and-Outputs#reportrpatmetrics)
  + [VisionEval Model System Design and Users Guide](https://github.com/visioneval/VisionEval/blob/master/api/model_system_design.md)
  + [TravelWorks Rapid Policy Assessment Tool](https://planningtools.transportation.org/551/rapid-policy-analysis-tool.html)
  + [RPAT User manual](https://planningtools.transportation.org/files/63.pdf)

[[Overview | VERPAT-Tutorial-Overview]]

## Inputs and Parameters

VERPAT contains 5 definition files and 32 input files, some of which the user must change and others which typically remain unchanged. This page walks the end user through these files and specifies which files must be updated to implement VERPAT in a new region.

The following five files need to be configured in the "defs" directory:

- [run_parameters.json](#run_parametersjson)
- [model_parameters.json](#model_parametersjson)
- [deflators.csv](#deflatorscsv)
- [geo.csv](#geocsv)
- [units.csv](#unitscsv)

#### run_parameters.json

The "run_parameters.json" file contains parameters that define key attributes of the model run and relationships to other model runs. A more detailed description of the file can be found [here](https://github.com/visioneval/VisionEval/blob/master/api/model_system_design.md#61-model-directory-structure). The results of model run are stored in a directory with the name specified by ```"DatastoreName"```. This name should be changed when running different scenarios. For e.g. when running base scenario the output directory name can be set to *BaseScenario* by using ```"DatastoreName": ["BaseScenario"]``` in the file. The format of the VERPAT *run_parameters.json* file is as follows:

```json
{
    "Model": ["RPAT"],
    "Scenario": ["RPAT Pilot"],
    "Description": ["Pilot RPAT module in VisionEval"],
    "Region": ["Multnomah County Oregon"],
    "BaseYear": ["2005"],
    "Years": ["2005", "2035"],
    "DatastoreName": ["Datastore"],
    "DatastoreType": ["RD"],
    "Seed": [1],
    "RunTypes": ["E", "ELESNP"]
}
```

[Inputs](#inputs)  [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

------

#### model_parameters.json

The "model_parameters.json" can contain global parameters for a particular model configuration that may be used by multiple modules. A more detailed description of the file and its structure can be found [here](https://github.com/visioneval/VisionEval/blob/master/api/model_system_design.md#61-model-directory-structure). The description about the variables, required for **VERPAT**, listed in the file are documented by the modules that uses them in the [inputs and outputs](VERPAT-Modules-and-Outputs) section. Some of these values may be modified to run scenarios. The variables that can be modified are described further [Input Files](#input-files). The format of the VERPAT *model_parameters.json* file is as follows:

```json
[
  {"NAME": "EmploymentGrowth",
   "VALUE": "1.5",
   "TYPE": "double",
   "UNITS": "multiplier",
   "PROHIBIT": "",
   "ISELEMENTOF": ""},
  {
    "NAME": "FwyLaneMiGrowth",
    "VALUE": "1",
    "TYPE" : "double",
    "UNITS" : "multiplier",
    "PROHIBIT" : "c('NA', '< 0')",
    "ISELEMENTOF" : ""
  },
  {
    "NAME" : "ArtLaneMiGrowth",
    "VALUE": "1",
    "TYPE" : "double",
    "UNITS" : "multiplier",
    "PROHIBIT" : "c('NA', '< 0')",
    "ISELEMENTOF" : ""
  },
  .
  .
  .
  {
    "NAME" : "AutoCostGrowth",
    "VALUE": "1.5",
    "TYPE" : "double",
    "UNITS" : "multiplier",
    "PROHIBIT" : "c('NA', '< 0')",
    "ISELEMENTOF" : ""
  }
]
```

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

------

#### deflators.csv

The **deflators.csv** file defines the annual deflator values, such as the consumer price index, that are used to convert currency values between different years for currency denomination. This file does not need to be modified unless the years for which the dollar values used in the input dataset is not contained in this file. The format of the file is as follows:

|              Year              |             Value              |
| :----------------------------: | :----------------------------: |
|              1999              |             172.6              |
|              2000              |              178               |
|              2001              |             182.4              |
| ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) |

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

------

#### geo.csv

The "geography.csv" file describes all of the geographic relationships for the model and the names of geographic entities in a [CSV-formatted](https://en.wikipedia.org/wiki/Comma-separated_values) text file. **Azone**, **Bzone**, and **Marea** should remain consistent with the input data. The format of the file is as follows:

| [Azone](https://github.com/visioneval/VisionEval/blob/master/api/model_system_design.md#62-model-geography) | [Bzone](https://github.com/visioneval/VisionEval/blob/master/api/model_system_design.md#62-model-geography) | [Czone](https://github.com/visioneval/VisionEval/blob/master/api/model_system_design.md#62-model-geography) | [Marea](https://github.com/visioneval/VisionEval/blob/master/api/model_system_design.md#62-model-geography) |
| :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
|                          Multnomah                           |                             Rur                              |                              NA                              |                          Multnomah                           |
|                          Multnomah                           |                            Sub_R                             |                              NA                              |                          Multnomah                           |
|                          Multnomah                           |                            Sub_E                             |                              NA                              |                          Multnomah                           |
|                          Multnomah                           |                            Sub_M                             |                              NA                              |                          Multnomah                           |
|                          Multnomah                           |                            Sub_T                             |                              NA                              |                          Multnomah                           |
|                          Multnomah                           |                            CIC_R                             |                              NA                              |                          Multnomah                           |
|                          Multnomah                           |                            CIC_E                             |                              NA                              |                          Multnomah                           |
|                          Multnomah                           |                            CIC_M                             |                              NA                              |                          Multnomah                           |
|                          Multnomah                           |                            CIC_T                             |                              NA                              |                          Multnomah                           |
|                          Multnomah                           |                             UC_R                             |                              NA                              |                          Multnomah                           |
|                          Multnomah                           |                             UC_E                             |                              NA                              |                          Multnomah                           |
|                          Multnomah                           |                             UC_M                             |                              NA                              |                          Multnomah                           |
|                          Multnomah                           |                             UC_T                             |                              NA                              |                          Multnomah                           |

The geography is described by 13 place types as shown below. One emerging school of thought in land use planning is to consider land uses in terms of place types instead of simply residential or commercial or high density compared to low density. A place type refers to all of the characteristics of a developed area including the types of uses included, the mix of uses, the density and intensity of uses.

|                                  |          URBAN <br />CORE          |      CLOSE-IN <br />COMMUNITY      |              SUBURBAN              |               RURAL                |
| :------------------------------- | :--------------------------------: | :--------------------------------: | :--------------------------------: | :--------------------------------: |
| **Residential**                  | ![](./VERPAT_images/checkmark.gif) | ![](./VERPAT_images/checkmark.gif) | ![](./VERPAT_images/checkmark.gif) |                                    |
| **Commercial**                   | ![](./VERPAT_images/checkmark.gif) | ![](./VERPAT_images/checkmark.gif) | ![](./VERPAT_images/checkmark.gif) |                                    |
| **Mixed-Use**                    | ![](./VERPAT_images/checkmark.gif) | ![](./VERPAT_images/checkmark.gif) | ![](./VERPAT_images/checkmark.gif) |                                    |
| **Transit-Oriented Development** | ![](./VERPAT_images/checkmark.gif) | ![](./VERPAT_images/checkmark.gif) | ![](./VERPAT_images/checkmark.gif) |                                    |
| **Rural/Greenfield**             |                                    |                                    |                                    | ![](./VERPAT_images/checkmark.gif) |

An initial typology or system to organize place types can be traced to the Smart Growth Transect, which contained six zones in its original configuration including:

- Rural Preserve
- Rural Reserve
- Edge
- General
- Center
- Core

This approach to classifying place types was further refined in the Caltrans Smart Mobility which defined the following seven place types including:

- Urban Centers
- Close-In Compact Communities
- Compact Communities
- Suburban Communities
- Rural and Agricultural Lands
- Protected Lands
- Special Use Areas

Several of these place type categories provided additional options such as the Close-In Compact Communities which had three sub-definitions including Close-In-Centers, Close-In Corridors, and Close-In Neighborhoods.

An alternative view of place types was provided by Reconnecting America, which developed a performance based place type approach for describing areas proximate to transit stations. Station areas would vary in terms of their relative focus between residential units, employees or a mix of the two. Station areas are also characterized on their relative intensity as well as shown below.

![PERFORMANCE BASED TYPOLOGY FOR TRANSIT STATION AREAS](./VERPAT_images/performancebasedtypology.png)

The approach employed for the place types in RPAT is therefore an amalgam of these approaches, in that the terminology is borrowed from the Smart Growth Transect and Caltrans Smart Mobility Study, while the relative performance of each place type is taken from the Reconnecting America approach but applied to a region instead of transit station sites.

Four general area types are defined in RPAT including:

- The **Urban Core** is the high-density mixed-use places with high jobs-housing ratios, well connected streets and high levels of pedestrian activities. It is anticipated that for many regions, the Urban Core will be the traditional downtown area of which there likely would be only one.
- The **Close-in Community** would be those areas located near to the Urban Cores and would consist primarily of housing with scattered mixed-use centers and arterial corridors. Housing would be varied in terms of density and type. Transit would be available with a primary focus on commute trips. These areas may be classified by their residents as suburban would be considered to be close-in communities given their adjacency to the Downtown and therefore the higher levels of regional accessibility.
- The **Suburban** place type is anticipated to represent the majority of development within regions. These communities are characterized by low level of integration of housing with jobs, retail, and services, poorly connected street networks, low levels of transit service, large amounts of surface parking, and limited walk ability.
- The **Rural** place type is defined as settlements of widely spaced towns separated by firms, vineyards, orchards, or grazing lands. These areas would be characterized by widely dispersed residential uses, little or no transit service, and very limited pedestrian facilities.

Further definition of the place types is allowed through the use of development types within the Urban Core, Close-in Community, and Suburban area types including:

- **Residential** includes all place types that are predominantly residential in character with limited employment and retail opportunities. Examples of this development type might include typical Suburban Residential or areas of the Downtown which are primarily residential as well. It is anticipated that this development type may be found in all of the area types except for rural.
- **Employment** includes those areas which are focused on employment with limited retail and residential. An example of this might include a Suburban Office Complex or a large cluster of office buildings within a Close-in Community or Urban Core. As with the residential development type, it is anticipated that this type of use would be found in all place types except for rural.
- **Mixed-Use** are those areas within a region which have a mix of residential, employment, and retail uses. While this development type can be found in the Suburban place type, it is most commonly found in the close-in community and urban core place type. Downtown areas that have retained their residential population to complement the employment are examples of this development type.
- **Transit-Oriented Development (TOD)** which is similar to the other development types in that it is applied to all area types except for Rural areas since it is thought to be highly unlikely that a rural TOD would be developed. The TOD development type is characterized by greater access to transit in all area types. Examples of this development type might include a Suburban TOD focused on a commuter rail station.

The process of allocating existing land use to the 13 place types is somewhat dependent on the types of data available in a region that describe existing land use, and the process can be either very detailed or somewhat simplified. The following description relays the process developed by Atlanta Regional Commission (ARC) as part of the pilot testing of RPAT and provides an example of how, mechanically, an agency can approach this allocation. It should be noted that this is merely one approach and not a specific recommendation for a method that should be followed.

In general, ARC followed a somewhat detailed process to derive input data from land use data as presented in their “Unified Growth Policy Map”, and from their regional travel demand model. They developed heuristics to align their land use with the 13 place types that RPAT uses.

The conversion of land use data to the place type scheme used in RPAT involved taking ARC’s Unified Growth Policy Map (UGPM) Areas and converting them to the 13 RPAT place types.

1. The first step was to allocate the UGPM areas to the four area types used in RPAT. The Urban Core area type includes Region Core, Region Employment Centers and Aerotropolis UGPM areas; Close-in Community includes Maturing Neighborhoods; Suburban includes Developing Suburbs and Established Suburbs; and Rural includes Rural Areas and Developing Rural.
2. The ARC traffic analysis zone (TAZ) system was overlaid with the area types and the centroid of the TAZ was used to determine its area type.
3. The RPAT development type, the other dimension of the place type matrix, which included residential, mixed-use, employment, and TOD development types was determined for each TAZ not in the rural area type using the base year percentage of the TAZ’s employment in relation to the total of the population and employment in the TAZ. The mix between the employment and employment was used to determine the TAZs development type using the following cut points:
   - Residential: < 33.33% 
   - Mixed Use: 33.33% to 66.67%
   - Employment: > 66.67%
4. Identify any TAZs that are TOD based on transit service and specific development types: only one TAZ was determined to be TOD as a development type, Lindbergh Center, in the Urban Core area type.
5. The combination of the area type and the development type was then used to allocate all TAZs to one of the 13 place types.

The following is an enumeration of each place type abbreviation as it appears in the input file as well as a brief description of that value:

| Abbreviation | Description                                     |
| ------------ | ----------------------------------------------- |
| Rur          | Rural                                           |
| Sub_R        | Suburban Residential                            |
| Sub_E        | Suburban Employment (i.e. Commercial)           |
| Sub_M        | Suburban Mixed Use                              |
| Sub_T        | Suburban Transit Oriented Development           |
| CIC_R        | Close-in Community Residential                  |
| CIC_E        | Close-in Community Employment (i.e. Commercial) |
| CIC_M        | Close-in Community Mixed Use                    |
| CIC_T        | Close-in Community Transit Oriented Development |
| UC_R         | Urban Core Residential                          |
| UC_E         | Urban Core Employment (i.e. Commercial)         |
| UC_M         | Urban Core Mixed Use                            |
| UC_T         | Urban Core Transit Oriented Development         |

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)  

------

### units.csv

The "units.csv" file describes the default units to be used for storing complex data types in the model. This file should not be modified by the user. The format of the file is as follows:

| Type                           | Units                          |
| ------------------------------ | ------------------------------ |
| currency                       | USD                            |
| distance                       | MI                             |
| area                           | SQMI                           |
| ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) |

The VisionEval model system keeps track of the types and units of measure of all data that is processed. More details about the file and structure can be found [here](https://github.com/visioneval/VisionEval/blob/master/api/model_system_design.md#63-data-types-units-and-currency-deflators).

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)  



### Input Files

#### Inputs

The scenario inputs are split into four (4) categories: *Built Environment*, *Demand*, *Policy*, and *Supply*. There are two ways to specify these inputs. **CSV Inputs** are specified in a ```*.csv``` file and **JSON Inputs** are specified in ```model_parameters.json``` file. The users are encouraged to change these inputs to build different scenarios. The [RPAT to VERPAT](RPAT-To-VERPAT) the connection between RPAT inputs to VERPAT inputs.

[**Built Environment**](#built-environment)
  - CSV Inputs
      - [bzone_pop_emp_prop.csv](#bzone_pop_emp_propcsv)

[**Demand**](#demand)
  - CSV Inputs
      - [region_trips_per_cap.csv](#region_trips_per_capcsv)
      - [azone_employment_by_naics.csv](#azone_employment_by_naicscsv)
      - [azone_hh_pop_by_age.csv](#azone_hh_pop_by_agecsv)
      - [azone_gq_pop_by_age.csv](#azone_gq_pop_by_agecsv)
      - [azone_hhsize_targets.csv](#azone_hhsize_targetscsv)
      - [azone_per_cap_inc.csv](#azone_per_cap_inccsv)
      - [azone_relative_employment.csv](#azone_relative_employmentcsv)
      - [region_truck_bus_vmt.csv](#region_truck_bus_vmtcsv)
  - JSON Inputs
      - [BaseLtVehDvmt](#baseltvehdvmt)
      - [BaseFwyArtProp](#basefwyartprop)
      - [EmploymentGrowth](#employmentgrowth)

[**Transport Supply**](#Transport-Supply)

- CSV Inputs
  - [marea_lane_miles.csv](#marea_lane_milescsv)
  - [marea_rev_miles_pc.csv](#marea_rev_miles_pccsv)

[**Policy**](#policy)
  - CSV Inputs
      - [region_commute_options.csv](#region_commute_optionscsv)
      - [azone_its_prop.csv](#azone_its_propcsv)
      - [region_light_vehicles.csv](#region_light_vehiclescsv)
      - [marea_parking_growth.csv](#marea_parking_growthcsv)
  - JSON Inputs
      - [AutoCostGrowth](#autocostgrowth)
      - [FwyLaneMiGrowth](#fwylanemigrowth)
      - [ArtLaneMiGrowth](#artlanemigrowth)
      - [BusRevMiPCGrowth](#busrevmipcgrowth)
      - [RailRevMiPCGrowth](#railrevmipcgrowth)
      - [VmtCharge](#vmtcharge)

#### Model Parameters

There are two ways to specify model parameters. **CSV Parameters** are specified in a ```*.csv``` file and **JSON Parameters** in a ```model_parameters.json``` file. While you are provided access to the model parameters, you are encouraged to use the default parameter values unless directed to use alternatives. Editing modeling parameters should be based only on research pertaining to local data sources and may result in unpredictable results.

[**Model Parameters**](#model-parameters-1)

  - CSV Parameters
      - [model_accident_rates.csv](#model_accident_ratescsv)
      - [model_fuel_prop_by_veh.csv](#model_fuel_prop_by_vehcsv)
      - [model_fuel_composition_prop.csv](#model_fuel_composition_propcsv)
      - [model_fuel_co2.csv](#model_fuel_co2csv)
      - [model_place_type_elasticities.csv](#model_place_type_elasticitiescsv)
      - [model_place_type_relative_values.csv](#model_place_type_relative_valuescsv)
      - [model_tdm_ridesharing.csv](#model_tdm_ridesharingcsv)
      - [model_tdm_transit.csv](#model_tdm_transitcsv)
      - [model_tdm_transitlevels.csv](#model_tdm_transitlevelscsv)
      - [model_tdm_vanpooling.csv](#model_tdm_vanpoolingcsv)
      - [model_tdm_workschedule.csv](#model_tdm_workschedulecsv)
      - [model_tdm_workschedulelevels.csv](#model_tdm_workschedulelevelscsv)
      - [model_transportation_costs.csv](#model_transportation_costscsv)
      - [model_veh_mpg_by_year.csv](#model_veh_mpg_by_yearcsv)
      - [model_phev_range_prop_mpg_mpkwh.csv](#model_phev_range_prop_mpg_mpkwhcsv)
      - [model_hev_prop_mpg.csv](#model_hev_prop_mpgcsv)
      - [model_ev_range_prop_mpkwh.csv](#model_ev_range_prop_mpkwhcsv)
- JSON Parameters
  - [AnnVmtInflator](#annvmtinflator)
  - [BaseCostPerMile](#basecostpermile)
  - [DvmtBudgetProp](#DvmtBudgetProp)
  - [FuelCost](#FuelCost)
  - [KwhCost](#kwhcost)
  - [GasTax](#GasTax)
  - [LtTruckProp](#LtTruckProp)
  - [TranRevMiAdjFactor](#TranRevMiAdjFactor)
  - [TruckVmtGrowthMultiplier](#TruckVmtGrowthMultiplier)
  - [WorkVmtProp](#WorkVmtProp)


### Input Files to Change

The user should change the input files described here.

### Built Environment

------

#### CSV Inputs

#### bzone_pop_emp_prop.csv

**Population and Jobs by Place Type**: This file contains the distribution of  population and employment among the 13 place types for base and future year. See [this](https://github.com/visioneval/VisionEval/wiki/VERPAT-Inputs-and-Outputs#geocsv) explanation for more infomation regarding place types. Each column, for each year, must sum to one (1). It is acceptable to have no land use (i.e. a value of 0) in certain categories.

   The yearly TAZ employment and population totals were summed by the 13 place type and then scaled to total one for both employment and population. The allocation of growth between the base and the future years in population and employment to each of the 13 place types is captured by the rows containing future years. The discussion of the population and jobs by place type input above describes how to allocate existing land use to the 13 place types. A similar approach can be used to allocate expected growth from spatial planning resources such as TAZ or Census Block Group level forecasts to the place types.
   Here is a snapshot of the file:

| Geo   | Year | Pop  | Emp  |
| ----- | ---- | ---- | ---- |
| Rur   | 2005 | 0.05 | 0.1  |
| Sub_R | 2005 | 0.3  | 0    |
| Sub_E | 2005 | 0    | 0.2  |
| Sub_M | 2005 | 0.1  | 0.1  |
| Sub_T | 2005 | 0    | 0    |
| CIC_R | 2005 | 0.15 | 0    |
| CIC_E | 2005 | 0    | 0.2  |
| CIC_M | 2005 | 0.1  | 0.1  |
| CIC_T | 2005 | 0    | 0    |
| UC_R  | 2005 | 0.1  | 0    |
| UC_E  | 2005 | 0    | 0.1  |
| UC_M  | 2005 | 0.1  | 0.1  |
| UC_T  | 2005 | 0.1  | 0.1  |
| Rur   | 2035 | 0.05 | 0.1  |
| Sub_R | 2035 | 0.3  | 0    |
| Sub_E | 2035 | 0    | 0.2  |
| Sub_M | 2035 | 0.1  | 0.1  |
| Sub_T | 2035 | 0    | 0    |
| CIC_R | 2035 | 0.15 | 0    |
| CIC_E | 2035 | 0    | 0.2  |
| CIC_M | 2035 | 0.1  | 0.1  |
| CIC_T | 2035 | 0    | 0    |
| UC_R  | 2035 | 0.1  | 0    |
| UC_E  | 2035 | 0    | 0.1  |
| UC_M  | 2035 | 0.1  | 0.1  |
| UC_T  | 2035 | 0.1  | 0.1  |

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

### Demand

------

#### CSV Inputs

#### region_trips_per_cap.csv

**Auto and transit trips per capita**: This file contains regional averages for auto and transit trips per capita per day for the base year.

   - **Auto** is the regional average of auto trips per capita, including drive alone and shared ride travel. This data can be derived from the [National Household Travel Survey](https://nhts.ornl.gov/) by region or from a local household travel survey or regional travel demand forecasting model.
   - **Transit** is the regional average of transit trips per capita, including walk and drive access to transit. This data can be derived from the [National Transit Database](https://www.transit.dot.gov/ntd/ntd-data) where the annual database contains a “service” table that has annual transit trip data for each transit operator or from a local household travel survey or regional travel demand forecasting model.

   Here is a snapshot of the files:

| Mode    | Trips |
| ------- | ----- |
| Auto    | 3.2   |
| Transit | 0.4   |

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)


#### azone_employment_by_naics.csv

**Employment**: This file contains employment data for each of the counties that make up the region. The file is derived from County Business Pattern ([CBP](http://www.census.gov/econ/cbp/)) data by county. Industries are categorized by the North American Industrial Classification System (NAICS) 6 digit codes. Firm size categories are:

   - **n1_4**: 1- 4 employees
   - **n5_9**: 5-9 employees
   - **n10_19**: 10-19 employees
   - **n20_99**: 20-99 employees
   - **n100_249**: 100-249 employees
   - **n250_499**: 250-499 employees
   - **n500_999**: 500-999 employees
   - **n1000**: 1,000 or More Employee Size Class
   - **n1000_1**: 1,000-1,499 employees
   - **n1000_2**: 1,500-2,499 employees
   - **n1000_3**: 2,500 to 4, 999 Employees
   - **n1000_4**: Over 5,000 employees

   While the county field is required to be present, the business synthesis process does not require a meaningful value and therefore users may simply enter 'region'. The consistency in the naming of the "region" should be maintained across all the files that contains the label *"county"* or *"Geo"*. It is also not necessary to use such detailed NAICS categories if those are not available; the current business synthesis model and subsequent models do not use this level of detail (although future versions of the model may) – at minimum, the number of establishments for all employment types can be provided by size category. Regions with significant employment in industries such as government and public administration that are not covered by the CBP may need to add records to the file that cover this type of employment to more accurately match employment totals in their region. The two additional fields contained in the file are:

   - **emp**: Total number of employees
   - **est**: Total number of establishments

   Here is the snapshot of the file:

| county    | year | naics  | emp  | est  | n1_4 | n5_9 | n10_19 | n20_49 | n50_99 | n100_249 | n250_499 | n500_999 | n1000 | n1000_1 | n1000_2 | n1000_3 | n1000_4 |
| --------- | ---- | ------ | ---- | ---- | ---- | ---- | ------ | ------ | ------ | -------- | -------- | -------- | ----- | ------- | ------- | ------- | ------- |
| Multnomah | 2005 | 113110 | 0    | 5    | 2    | 1    | 0      | 2      | 0      | 0        | 0        | 0        | 0     | 0       | 0       | 0       | 0       |
| Multnomah | 2005 | 113310 | 0    | 3    | 2    | 0    | 0      | 1      | 0      | 0        | 0        | 0        | 0     | 0       | 0       | 0       | 0       |
| Multnomah | 2005 | 114111 | 0    | 1    | 0    | 1    | 0      | 0      | 0      | 0        | 0        | 0        | 0     | 0       | 0       | 0       | 0       |
| Multnomah | 2005 | 114112 | 0    | 1    | 1    | 0    | 0      | 0      | 0      | 0        | 0        | 0        | 0     | 0       | 0       | 0       | 0       |
| Multnomah | 2005 | 115114 | 0    | 1    | 0    | 0    | 0      | 0      | 0      | 0        | 1        | 0        | 0     | 0       | 0       | 0       | 0       |
| Multnomah | 2005 | 115210 | 0    | 4    | 3    | 1    | 0      | 0      | 0      | 0        | 0        | 0        | 0     | 0       | 0       | 0       | 0       |
| Multnomah | 2005 | 115310 | 0    | 5    | 2    | 0    | 1      | 1      | 1      | 0        | 0        | 0        | 0     | 0       | 0       | 0       | 0       |
| Multnomah | 2005 | 212319 | 0    | 1    | 1    | 0    | 0      | 0      | 0      | 0        | 0        | 0        | 0     | 0       | 0       | 0       | 0       |
| Multnomah | 2005 | 212321 | 0    | 4    | 1    | 1    | 1      | 1      | 0      | 0        | 0        | 0        | 0     | 0       | 0       | 0       | 0       |

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### azone_hh_pop_by_age.csv

**Household population**: This file contains population estimates/forecasts by county and age cohort for each of the base and future years. The file format includes six age categories used by the population synthesis model:

   - **0-14**
   - **15-19**
   - **20-29**
   - **30-54**
   - **55-64**
   - **65 Plus**

   Future year data must be developed by the user; in many regions population forecasts are available from regional or state agencies and/or local academic sources. As with the employment data inputs the future data need not be county specific. Rather, regional totals by age group can be entered into the file with a value such as “region” entered in the county field.

   Here is a snapshot of the file:

| Geo       | Year | Age0to14 | Age15to19 | Age20to29 | Age30to54 | Age55to64 | Age65Plus |
| --------- | ---- | -------- | --------- | --------- | --------- | --------- | --------- |
| Multnomah | 2005 | 129869   | 41133     | 99664     | 277854    | 71658     | 72648     |
| Multnomah | 2035 | 169200   | 48800     | 144050    | 327750    | 116100    | 162800    |

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### azone_gq_pop_by_age.csv :construction:

**Group quarter population**: This file contains group quarters population estimates/forecasts by county and age cohort for each of the base and future years. The file format includes six age categories used by the population synthesis model:

- **0-14**
- **15-19**
- **20-29**
- **30-54**
- **55-64**
- **65 Plus**

Here is a snapshot of the file:

| Geo       | Year | GrpAge0to14 | GrpAge15to19 | GrpAge20to29 | GrpAge30to54 | GrpAge55to64 | GrpAge65Plus |
| --------- | ---- | ----------- | ------------ | ------------ | ------------ | ------------ | ------------ |
| Multnomah | 2005 | 0           | 0            | 0            | 1            | 0            | 0            |
| Multnomah | 2035 | 0           | 0            | 0            | 1            | 0            | 0            |

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### azone_hhsize_targets.csv :construction:

**Household size (*azone_hhsize_targets.csv*)**: This file contains the household specific targets. This contain two household specific attributes:

- **AveHhSize**: Average household size of households (non-group quarters)
- **Prop1PerHh**: Proportion of households (non-group quarters) having only one person

Here is a snapshot of the file:

| Geo       | Year | AveHhSize | Prop1PerHh |
| --------- | ---- | --------- | ---------- |
| Multnomah | 2005 | NA        | NA         |
| Multnomah | 2035 | NA        | NA         |

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### azone_per_cap_inc.csv

**Regional income**: This file contains information on regional average per capita  household (**HHIncomePC**) and group quarters (**GQIncomePC**) income by forecast year in year 2000 dollars. The data can be obtained from the U.S. Department of [Commerce Bureau of Economic Analysis](http://www.bea.gov/regional/index.htm) for the current year or from regional or state sources for forecast years. In order to use current year dollars just replace ***2000*** in column labels with current year. For example, if the data is obtained in year 2005 dollars then the column labels in the file shown below will become **HHIncomePC.2005** and **GQIncomePC.2005**.
   Here is a snapshot of the file:

| Geo       | Year | HHIncomePC.2000 | GQIncomePC.2000 |
| --------- | ---- | --------------- | --------------- |
| Multnomah | 2005 | 32515           | 0               |
| Multnomah | 2035 | 40000           | 0               |

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### azone_relative_employment.csv

**Relative employment**: This file contains ratio of workers to persons by age cohort in model year vs. estimation data year. The relative employment value for each age group, which is the employment rate for the age group relative to the employment rate for the model estimation year data is used to adjust the relative employment to reflect changes in relative employment for other years. This file contains five age cohorts:

- **RelEmp15to19**: Ratio of workers to persons age 15 to 19 in model year vs. in estimation data year
- **RelEmp20to29**: Ratio of workers to persons age 20 to 29 in model year vs. in estimation data year
- **RelEmp30to54**: Ratio of workers to persons age 30 to 54 in model year vs. in estimation data year
- **RelEmp55to64**: Ratio of workers to persons age 55 to 64 in model year vs. in estimation data year
- **RelEmp65Plus**: Ratio of workers to persons age 65 or older in model year vs. in estimation data year

Here is a snapshot of the file:

| Geo       | Year | RelEmp15to19 | RelEmp20to29 | RelEmp30to54 | RelEmp55to64 | RelEmp65Plus |
| --------- | ---- | ------------ | ------------ | ------------ | ------------ | ------------ |
| Multnomah | 2005 | 1            | 1            | 1            | 1            | 1            |
| Multnomah | 2035 | 1            | 1            | 1            | 1            | 1            |

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### region_truck_bus_vmt.csv

**Truck and bus vmt**: This file contains the region’s proportion of VMT by truck and bus as well as the distribution of that VMT across functional classes (*freeway*, *arterial*, *other*). The file includes one row for bus VMT data and one row for Truck VMT data. It should be noted that it is not necessary to enter values in the **PropVmt** column for **BusVmt** as this is calculated using the values in the ***transportation_supply.csv*** #EDIT (marea_rev_miles_pc.csv?) user input file. The truck VMT proportion (PropVMT column, TruckVMT row) can be obtained from [Highway Performance Monitoring System](http://www.fhwa.dot.gov/policyinformation/hpms.cfm) data and local sources or the regional travel demand model if one exists.
   The proportions of VMT by functional class can be derived from the Federal Highway Cost Allocation Study and data from transit operators. The Federal Highway Cost Allocation Study (Table II-6, 1997 Federal Highway Cost Allocation Study Final Report, [Chapter II](http://www.fhwa.dot.gov/policy/hcas/final/two.cfm) is used to calculate the average proportion of truck VMT by functional class. Data from transit authorities are used to calculate the proportions of bus VMT by urban area functional class.
   Here is a snapshot of the file:

| Type     | PropVmt | Fwy      | Art      | Other    |
| -------- | ------- | -------- | -------- | -------- |
| BusVmt   | 0       | 0.15     | 0.591854 | 0.258146 |
| TruckVmt | 0.08    | 0.452028 | 0.398645 | 0.149327 |

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### JSON Inputs

#### BaseLtVehDvmt

**Light vehicle dvmt (*BaseLtVehDvmt*)**: Total light vehicle daily VMT for the base year in thousands of miles. This data can be derived from a combination of [Highway Performance Monitoring System](http://www.fhwa.dot.gov/policyinformation/hpms.cfm) data, Federal Highway Cost Allocation Study data, and regional data. Light vehicle daily VMT can be estimated by subtracting truck and bus VMT from total VMT provided in the Highway Performance Monitoring System (HPMS). Regional travel demand model outputs can also be used to derive these data. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

```json
{
    "NAME" : "BaseLtVehDvmt",
    "VALUE": "27244",
    "TYPE" : "compound",
    "UNITS" : "MI/DAY",
    "PROHIBIT" : "c('NA', '< 0')",
    "ISELEMENTOF" : ""
}
```

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### BaseFwyArtProp

**Dvmt proportion by functional class (*BaseFwyArtProp*)**: The proportions of daily VMT for light vehicles that takes place on freeways and arterials (i.e., the remainder of VMT takes place on lower functional class roads for the base year. This data can be derived from a combination of [Highway Performance Monitoring System](http://www.fhwa.dot.gov/policyinformation/hpms.cfm) data, Federal Highway Cost Allocation Study data, and regional data. The proportions of light vehicle daily VMT on freeways and arterials can be derived from the HPMS data. Regional travel demand model outputs can also be used to derive these data. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

```json
{
    "NAME" : "BaseFwyArtProp",
    "VALUE": "0.77",
    "TYPE" : "double",
    "UNITS" : "proportion",
    "PROHIBIT" : "c('NA', '< 0', '> 1')",
    "ISELEMENTOF" : ""
}
```

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### EmploymentGrowth

**Employment Growth (*EmploymentGrowth*)**: This variable represents a growth rate for employment in the region between the base year and the future year. A rate of 1 indicates no changes in overall employment, a value of more than 1 indicates some growth (e.g., 1.5 = 50% growth) and a value of less than 1 indicates decline in employment. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

```json
{
    "NAME": "EmploymentGrowth",
    "VALUE": "1.5",
    "TYPE": "double",
    "UNITS": "multiplier",
    "PROHIBIT": "",
    "ISELEMENTOF": ""
}
```

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

### Transport Supply

------

#### CSV Inputs

#### marea_lane_miles.csv

**Road lane miles**: This file contains the amount of transportation supply by base year in terms of lane miles of freeways and arterial roadways in the region. The base year data is duplicated for future year.
   **Freeway** and **Arterial** are total lane miles for those functional classes in the region. These data can be derived from the Federal Highway Administration’s (FHWA) Highway [Statistics data](http://www.fhwa.dot.gov/policy/ohim/hs05/roadway_extent.cfm).
   Here is a snapshot of the file:

| Geo       | Year | FwyLaneMi | ArtLaneMi |
| --------- | ---- | --------- | --------- |
| Multnomah | 2005 | 250       | 900       |
| Multnomah | 2035 | 250       | 900       |

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### marea_rev_miles_pc.csv

**Transit revenue miles**: This file contains the amount of transportation supply by base year in terms of the revenue miles operating by the transit system in the region. The base year data is duplicated for future year.
   **Bus** and **Rail** are annual bus and rail revenue miles per capita for the region. These data can be derived from the [National Transit Database](https://www.transit.dot.gov/ntd/ntd-data), where the annual database contains a “service” table that has annual revenue mile data by mode for each transit operator.
   Here is a snapshot of the file:

| Geo       | Year | BusRevMiPC | RailRevMiPC |
| --------- | ---- | ---------- | ----------- |
| Multnomah | 2005 | 19         | 4           |
| Multnomah | 2035 | 19         | 4           |

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

### Policy

------

#### CSV Inputs

#### region_commute_options.csv

**Percentage of employees offered commute options**: This file contains assumptions about the availability and participation in work based travel demand management programs. The policies are ridesharing programs, transit pass programs, telecommuting or alternative work schedule programs, and vanpool programs. For each, the user enters the proportion of workers who participate (the data items with the “Participation” suffix). For one program, the transit subsidy, the user must also enter the subsidy level in dollars for the TransitSubsidyLevel data item.
   Here is a snapshot of the file:

| TDMProgram     | DataItem                        | DataValue |
| -------------- | ------------------------------- | --------- |
| Ridesharing    | RidesharingParticipation        | 0.05      |
| TransitSubsidy | TransitSubsidyParticipation     | 0.1       |
| TransitSubsidy | TransitSubsidyLevel             | 1.25      |
| WorkSchedule   | Schedule980Participation        | 0.01      |
| WorkSchedule   | Schedule440Participation        | 0.01      |
| WorkSchedule   | Telecommute1.5DaysParticipation | 0.01      |
| Vanpooling     | LowLevelParticipation           | 0.04      |
| Vanpooling     | MediumLevelParticipation        | 0.01      |
| Vanpooling     | HighLevelParticipation          | 0.01      |

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### azone_its_prop.csv

**Percent road miles with ITS treatment**: This file is an estimate of the proportion of road miles that have improvements which reduce incidents through ITS treatments in both the base and future years. Values entered should be between 0 and 1, with 1 indicating that 100% of road miles are treated.
   The ITS policy measures the effects of incident management supported by ITS. The ITS table is used to inform the congestion model and the travel demand model. The model uses the mean speeds with and without incidents to compute an overall average speed by road type and congestion level providing a simple level of sensitivity to the potential effects of incident management programs on delay and emissions.
   The ITS treatments are evaluated only on freeways and arterials. The ITS treatments that can be evaluated are those that the analyst considers will reduce non-recurring congestion due to incidents. This policy does not deal with other operational improvements such as signal coordination, or temporary capacity increases such as allowing shoulder use in the peak.
   Here is a snapshot of the file:

| Geo       | Year | ITS  |
| --------- | ---- | ---- |
| Multnomah | 2005 | 0    |
| Multnomah | 2035 | 0    |

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)


#### region_light_vehicles.csv

**Bicycling/light vehicles targets**: This file contains input data for the non-motorized vehicle model. In VERPAT, non-motorized vehicles are bicycles, and also electric bicycles, segways, and similar vehicles that are small, light-weight and can travel at bicycle speeds or slightly higher. The parameters are as follows:

   - **TargetProp**: non-motorized vehicle ownership rate (average ratio of non-motorized vehicles to driver age population)
   - **Threshold**: single-occupant vehicle (SOV) tour mileage threshold used in the SOV travel proportion model. This is the upper limit for tour lengths that are suitable for reallocation to non-motorized modes.
   - **PropSuitable**: proportion of SOV travel suitable for non-motorized vehicle travel. This variable describes the proportion of SOV tours within the mileage threshold for which non-motorized vehicles might be substituted. This variable takes into account such factors as weather and trip purpose.

   The non-motorized vehicle model predicts the ownership and use of non-motorized vehicles (where non-motorized vehicles are bicycles, and also electric bicycles, segways and similar vehicles that are small, light-weight and can travel at bicycle speeds or slightly higher than bicycle speeds). The core concept of the model is that non-motorized vehicle usage will primarily be a substitute for short-distance SOV travel. Therefore, the model estimates the proportion of the household vehicle travel that occurs in short-distance SOV tours. The model determines the maximum potential for household VMT to be diverted to non-motorized vehicles, which is also dependent on the availability of non-motorized vehicles.
   Note that bike share programs (BSP) serve to increase the availability of non-motorized vehicles and can be taken into account by increasing the **TargetProp** variable. Use national estimates of non-motorized ownership if regional estimates of non-motorized ownership are not available (unless the region has notably atypical levels of bicycle usage). See [Bicycle Ownership in the United States](http://www.academia.edu/1839374/Bicycle_Ownership_in_the_United_States_Empirical_Analysis_of_Regional_Differences) for an analysis of regional differences.
   Here is a snapshot of the file:

| DataItem     | DataValue |
| ------------ | --------- |
| TargetProp   | 0.2       |
| Threshold    | 2         |
| PropSuitable | 0.1       |

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### marea_parking_growth.csv

**Increase in parking cost and supply**: This file contains information that allows the effects of policies such as workplace parking charges and "*cash-out buy-back*" programs to be tested. The input parameters are as follows and should be entered for both the base and future year:

   - **PropWorkParking**: proportion of employees that park at work
   - **PropWorkCharged**: proportion of employers that charge for parking
   - **PropCashOut**: proportion of employment parking that is converted from being free to pay under a "*cash-out buy-back*" type of program
   - **PropOtherCharged**: proportion of other parking that is not free
   - **ParkingCost.2000**: average daily parking cost in 2000 year USD. In order to use base year dollars just replace ***2000*** in column labels with base year. This variable is the average daily parking cost for those who incur a fee to park. If the paid parking varies across the region, then the "*PkgCost*" value should reflect the average of those parking fees, but weighted by the supply – so if most parking is in the Center City, then the average will be heavily weighted toward the price in the Center City.

   Here is a snapshot of the file:

| Geo       | Year | PropWorkParking | PropWorkCharged | PropCashOut | PropOtherCharged | ParkingCost.2000 |
| --------- | ---- | --------------- | --------------- | ----------- | ---------------- | ---------------- |
| Multnomah | 2005 | 1               | 0.1             | 0           | 0.05             | 5                |
| Multnomah | 2035 | 1               | 0.1             | 0           | 0.05             | 5                |

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### JSON Inputs

#### AutoCostGrowth

**% Increase in Auto Operating Cost (*AutoCostGrowth*):** This parameter reflects the proportional increase in auto operating cost. This can be used to test different assumptions for future gas prices or the effects of increased gas taxes. A value of 1.5 multiplies base year operating costs by 1.5 and thus reflects a 50% increase. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

```json
{
    "NAME" : "AutoCostGrowth",
    "VALUE": "1.5",
    "TYPE" : "double",
    "UNITS" : "multiplier",
    "PROHIBIT" : "c('NA', '< 0')",
    "ISELEMENTOF" : ""
}
```

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### FwyLaneMiGrowth

**FwyLaneMiGrowth**: The variable indicates the percent increase in supply of freeways lane miles in the future year compared to base year. By default, the transportation supply is assumed to grow in line with population increase; therefore a value of 1 indicates growth in proportion with population growth. A value less than 1 indicates that there will be less freeway lane mile supply, per person, in the future. A value of 1 indicates faster freeway expansion than population growth.  It should be defined in [model_parameters.json](#model_parametersjson) as follows:

```json
{
    "NAME": "FwyLaneMiGrowth",
    "VALUE": "1",
    "TYPE" : "double",
    "UNITS" : "multiplier",
    "PROHIBIT" : "c('NA', '< 0')",
    "ISELEMENTOF" : ""
}
```

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### ArtLaneMiGrowth

**ArtLaneMiGrowth**:  The variable indicates the percent increase in supply of arterial lane miles in the future year compared to base year. It is a similar value to freeway except that it measures arterial lane mile growth. It is also proportional to population growth. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

```json
{
    "NAME" : "ArtLaneMiGrowth",
    "VALUE": "1",
    "TYPE" : "double",
    "UNITS" : "multiplier",
    "PROHIBIT" : "c('NA', '< 0')",
    "ISELEMENTOF" : ""
}
```

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### BusRevMiPCGrowth

**BusRevMiPCGrowth**: It is the percent increase in transit revenue miles per capita for bus. It behaves in a similar way to the freeway and rail values in that a value of 1 indicates per capita revenue miles stays constant. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

```json
{
    "NAME" : "BusRevMiPCGrowth",
    "VALUE": "1",
    "TYPE" : "double",
    "UNITS" : "multiplier",
    "PROHIBIT" : "c('NA', '< 0')",
    "ISELEMENTOF" : ""
}
```

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### RailRevMiPCGrowth

**RailRevMiPCGrowth**: It is the percent increase in transit revenue miles per capita for rail. This encompasses all rail modes, from light rail through to commuter rail. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

```json
{
    "NAME" : "RailRevMiPCGrowth",
    "VALUE": "1",
    "TYPE" : "double",
    "UNITS" : "multiplier",
    "PROHIBIT" : "c('NA', '< 0')",
    "ISELEMENTOF" : ""
}
```

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### VmtCharge

**Auto Operating Surcharge Per VMT (*VmtCharge*)**: It is a cost in cents per mile that would be levied on auto users through the form of a VMT charge. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

```json
{
    "NAME" : "VmtCharge",
    "VALUE": "0.05",
    "TYPE" : "compound",
    "UNITS" : "USD/MI",
    "PROHIBIT" : "c('NA', '< 0')",
    "ISELEMENTOF" : ""
}
```

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

### Model Parameters

------

Users can modify these parameters to test alternative scenarios. For e.g. users can use [model_veh_mpg_by_year.csv](#model_veh_mpg_by_yearcsv) to test alternative vehicle development scenarios, such as improved technology and/or fuel economy standards that lead to higher fuel economies.

#### CSV Inputs

#### model_accident_rates.csv

**Accident Rates**: Road safety impacts are calculated by factoring the amount of VMT. The following national average rates, from the Fatality Analysis Reporting System General Estimates System (2009) by US Department of Transportation, are applied to calculate the number of fatal and injury accidents and the value of property damage:

- Fatal: 1.14 per 100 Million Miles Traveled
- Injury: 51.35 per 100 Million Miles Traveled
- Property damage: 133.95 per 100 Million Miles Traveled

Here is a snapshot of the file:

| Accident | Rate   |
| -------- | ------ |
| Fatal    | 1.14   |
| Injury   | 51.35  |
| Property | 133.95 |

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### model_fuel_prop_by_veh.csv

**Vehicle VMT proportion by fuel (*model_fuel_prop_by_veh.csv*)**: The file contains allocation of VMT for each of the four road vehicle types that VERPAT represents (*auto*, *light truck*, *bus*, and *heavy truck*) to different fuel types (*Diesel*, *CNG*, *Gasoline*). This file is used in the calculations of fuel consumption. This file can be used to test alternative fuel scenarios by varying the shares of non-gasoline fuels.

- **PropDiesel**: The proportion of the fleet that uses diesel
- **PropCng**: The proportion of the fleet that uses CNG
- **PropGas**: The proportion of the fleet that uses gasoline

Here is a snapshot of the file:

| VehType | PropDiesel | PropCng | PropGas |
| ------- | ---------- | ------- | ------- |
| Auto    | 0.007      | 0       | 0.993   |
| LtTruck | 0.04       | 0       | 0.96    |
| Bus     | 0.995      | 0.005   | 0       |
| Truck   | 0.945      | 0.005   | 0.05    |

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### model_fuel_composition_prop.csv

**Fuel composition**: This file contains the composition of fuel used for each of the four road vehicle types that VERPAT represents (*auto*, *light truck*, *bus*, and *heavy truck*). This file is also used in the calculations of fuel consumption along with the aforementioned file. The column labels in the file are:

- **GasPropEth**: The average ethanol proportion in gasoline sold
- **DieselPropBio**: The average biodiesel proportion in diesel sold

Here is a snapshot of the file:

| VehType | GasPropEth | DieselPropBio |
| ------- | ---------- | ------------- |
| Auto    | 0.1        | 0.05          |
| LtTruck | 0.1        | 0.05          |
| Bus     | 0.1        | 0.05          |
| Truck   | 0.1        | 0.01          |

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### model_fuel_co2.csv

**Emission Rate**: The emissions rate file contains information on “pump-to-wheels” CO2 equivalent emissions by fuel type in grams per mega Joule of fuel energy content. There is one row for each fuel type: ULSD, biodiesel, RFG (reformulated gasoline), CARBOB (gasoline formulated to be blended with ethanol), ethanol, and CNG. This file is used to convert fuel use to CO2 equivalent emissions.
Here is a snapshot of the file:

| Fuel      | Intensity |
| --------- | --------- |
| ULSD      | 77.19     |
| Biodiesel | 76.81     |
| RFG       | 75.65     |
| CARBOB    | 75.65     |
| Ethanol   | 74.88     |
| Cng       | 62.14     |

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### model_place_type_elasticities.csv

This file contains elasticities for four performance metrics:

- **VMT** – Following the estimate of travel demand that incorporates induced demand, an adjustment is made to travel demand that accounts for changes in growth by the place types that are used in the model to describe urban form. These changes are interpreted as changes in design (intersection street density), accessibility (job accessibility by auto), distance to transit (nearest transit stop), density (population density) and diversity (land use mix). The effect on travel demand is determined as changes in VMT by these urban form categories, as shown in the table below. The elasticities that are shown in the table are multiplied by the D values for each place type. The D values are proportion values for each place type that are relative to the regional average, which is set to 1.0.
- **VehicleTrips** – The change in the number of vehicle trips is calculated using a set of elasticities from Index 4D Values (2001) that pivots from the current number of vehicle trips per capita based on the scenario’s allocation of growth by place type. The elasticities shown in the table are applied to D values, which are proportional values for each place type that are relative to a regional average for that D value that is set to 1.0. The model reports the additional number of trips caused by the growth assumed in the scenario and not the regional total.
- **TransitTrips** – The change in the number of transit trips is calculated using a set of elasticities from Index 4D Values (2001) that pivots from the current number of transit trips per capita based on the scenario’s allocation of growth by place type. The elasticities shown in the table are applied to D values, which are proportional values for each place type that are relative to a regional average for that D value that is set to 1.0. The model reports the additional number of trips caused by the growth assumed in the scenario and not the regional total.
- **Walking** – The elasticities shown in the table are applied to D values, which are proportional values for each place type that are relative to a regional average for that D value that is set to 1.0. The product of the elasticity and D value is applied to the place type growth quantities for the scenario to calculated the percentage increase or decrease in walking for new residents in the region relative to a the current place type distribution.

Here is a snapshot of the file:

| Parameters             | VMT   | VehicleTrips | TransitTrips | Walking |
| ---------------------- | ----- | ------------ | ------------ | ------- |
| Density                | -0.04 | -0.043       | 0.07         | 0.07    |
| Diversity              | -0.09 | -0.051       | 0.12         | 0.15    |
| Design                 | -0.12 | -0.031       | 0.23         | 0.39    |
| Regional_Accessibility | -0.2  | -0.036       | 0            | 0       |
| Distance_to_Transit    | -0.05 | 0            | 0.29         | 0.15    |

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### model_place_type_relative_values.csv

This file contains the *D* values, which are proportional values for each of the 13 place types (*Bzones*) that are relative to a regional average, for each of the five Ds used in VERPAT - design (intersection street density), accessibility (job accessibility by auto), distance to transit (nearest transit stop), density (population density) and diversity (land use mix).
Here is a snapshot of the file:

| Geo   | Density | Diversity | Design | Regional_Accessibility | Distance_to_Transit |
| ----- | ------- | --------- | ------ | ---------------------- | ------------------- |
| Rur   | 0.5     | 0.5       | 0.5    | 0.5                    | 0.5                 |
| Sub_R | 0.75    | 0.75      | 0.75   | 0.75                   | 0.75                |
| Sub_E | 0.75    | 0.75      | 0.75   | 0.75                   | 0.75                |
| Sub_M | 1       | 1         | 1      | 0.75                   | 0.75                |
| Sub_T | 1       | 1         | 1      | 1                      | 1                   |
| CIC_R | 1.2     | 1.2       | 1.2    | 1.2                    | 1                   |
| CIC_E | 1.2     | 1.2       | 1.2    | 1.2                    | 1                   |
| CIC_M | 1.2     | 1.2       | 1.2    | 1.2                    | 1                   |
| CIC_T | 1.2     | 1.2       | 1.2    | 1.2                    | 1.2                 |
| UC_R  | 1.5     | 1.2       | 1.5    | 1.5                    | 1.2                 |
| UC_E  | 1.5     | 1.2       | 1.5    | 1.5                    | 1.2                 |
| UC_M  | 1.5     | 1.5       | 1.5    | 1.5                    | 1.2                 |
| UC_T  | 1.5     | 1.5       | 1.5    | 1.5                    | 1.5                 |

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### model_tdm_ridesharing.csv

**Travel Demand Management: Ridesharing**: The ridesharing Travel Demand Management file contains parameters describing the effectiveness of ridesharing programs by place type. The proportion of employees participating in the ridesharing program is a policy input. This is converted into a proportion of working-age persons by using an assumed labor force participation rate (0.65) to sample working-age persons in households. The ridesharing sub-model then computes the anticipated level of VMT reduction resulting from the implementation of ridesharing, based on the place type the household lives in, using the effectiveness values shown in this parameter file. Previous studies have determined that the level of ridesharing participation will be less in the rural and suburban areas, as compared to the more-urban areas. Typically, more people will carpool in the more urbanized areas due to the presence of parking charges, potential difficulties in finding parking, and other disincentives that are typically present in more urbanized areas.
Here is a snapshot of the file:

| ModelGeo | Effectiveness |
| -------- | ------------- |
| Rur      | 0             |
| Sub      | 0.05          |
| CIC      | 0.1           |
| UC       | 0.15          |

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### model_tdm_transit.csv

**Travel Demand Management: Transit Fares**: The transit fare Travel Demand Management files are parameters for the effectiveness (level of VMT reduction) and fare subsidy values for employer. The subsidized/discounted transit model begins by evaluating the level of participation within the region. Monte Carlo processes are used to identify which households participate in transit pass programs. The proportion of employees participating in this program is a policy input. This is converted into a proportion of working-age persons by using an assumed labor force participation rate (0.65) to sample working-age persons in households. The model then allows the selection of one of four potential subsidy levels (also a policy inputs), which influence the level of VMT reduction based on the level of subsidy applied to the place type. The anticipated level of VMT reduction is then further reduced to account for the proportion of work travel in overall daily travel.
Here is a snapshot of the file:

| ModelGeo | Subsidy0 | Subsidy1 | Subsidy2 | Subsidy3 | Subsidy4 |
| -------- | -------- | -------- | -------- | -------- | -------- |
| Rur      | 0        | 0        | 0        | 0        | 0        |
| Sub      | 0        | 0.02     | 0.033    | 0.079    | 0.2      |
| CIC      | 0        | 0.034    | 0.073    | 0.164    | 0.2      |
| UC       | 0        | 0.062    | 0.129    | 0.2      | 0.2      |

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### model_tdm_transitlevels.csv

**Travel Demand Management: Transit Subsidy Levels**: This file contains the dollar value match to the subsidy levels used in [model_tdm_transit.csv](#model_tdm_transitcsv) file.
Here is a snapshot of the file:

| SubsidyLevel | SubsidyValue.2000 |
| ------------ | ----------------- |
| Subsidy0     | 0                 |
| Subsidy1     | 0.75              |
| Subsidy2     | 1.49              |
| Subsidy3     | 2.98              |
| Subsidy4     | 5.96              |

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### model_tdm_vanpooling.csv

**Travel Demand Management: Vanpooling**: This file contains parameters describing the effectiveness in terms of VMT reductions for vanpooling programs across three levels of employee involvement.
The vanpool program sub-model operates by evaluating the likely level of participation. Monte Carlo processes are used to identify which households participate in vanpool programs. The proportion of employees participating in this program is a policy input. This is converted into a proportion of working-age persons by using an assumed labor force participation rate (0.65) to sample working-age persons in households. Those employers that would participate in the program are then categorized into three levels of involvement from low to medium to high. The level of involvement reflects the extent to which an employer would actively facilitate and promote vanpooling. For example, a low level of involvement might represent an employer who organizes only a minimal number of vanpools. The high level of involvement could represent an employer who has an extensive vanpooling program to cover a large number of employees. Based on the level of involvement, the reduction in VMT is estimated on the basis of the values in this file.
Here is a snapshot of the file:

| VanpoolingParticipation | VMTReduction |
| ----------------------- | ------------ |
| Low                     | 0.003        |
| Medium                  | 0.0685       |
| High                    | 0.134        |

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### model_tdm_workschedule.csv

**Travel Demand Management: Work Schedule**: This file contains parameters that describe the effectiveness for different participation levels for three different telecommuting or alternative work schedules.
The telecommuting or alternative work schedule model first evaluates the likely level of participation throughout the region in terms of telecommuting or alternatively-works schedules. Monte Carlo processes are used to identify which households participate in telecommuting programs. The proportion of employees participating in this program is a policy input. This is converted into a proportion of working-age persons by using an assumed labor force participation rate (0.65) to sample working-age persons in households. The model then determines the type of programs that might be implemented. Three potential alternatives are offered including:

- **4/40 Schedule**: 4 days per week with 40 hours per week
- **9/80 Schedule**: working 4 days every other week with an average of 80 hours over 2 weeks
- **Telecommuting**: Workers may work 1 to 2 days a week remotely

Once the option has been identified and the level of participation, the estimated VMT is determined on the basis of the parameters in this file.
Here is a snapshot of the file:

| WorkSchedulePolicy        | Participation0 | Participation1 | Participation2 | Participation3 | Participation4 | Participation5 |
| ------------------------- | -------------- | -------------- | -------------- | -------------- | -------------- | -------------- |
| Schedule980               | 0              | 0.0007         | 0.0021         | 0.0035         | 0.007          | 0.0175         |
| Schedule440               | 0              | 0.0015         | 0.0045         | 0.007          | 0.015          | 0.0375         |
| TelecommuteoneandhalfDays | 0              | 0.0022         | 0.0066         | 0.011          | 0.022          | 0.055          |

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### model_tdm_workschedulelevels.csv

**Travel Demand Management: Work Schedule Participation Levels**: This file describes the proportion of employees participating in the program corresponding to the participation levels used in *model_tdm_workschedule.csv* file.
Here is a snapshot of the file:

| ParticipationLevel | ParticipationValue |
| ------------------ | ------------------ |
| Participation0     | 0                  |
| Participation1     | 0.01               |
| Participation2     | 0.03               |
| Participation3     | 0.05               |
| Participation4     | 0.1                |
| Participation5     | 0.25               |

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### model_transportation_costs.csv

**Transportation Costs**: This file contains unit cost rates for transportation infrastructure investments and operating costs and transit fare revenue. The parameters are used in the calculations of the transportation costs performance metrics.
The source for transit capital, operating costs, and fare revenue is the [NTD](https://www.transit.dot.gov/ntd), and in particular the National Transit Profile which is available on the NTDB website. Costs are available in a variety of index formats, e.g. cost per revenue mile or hour; cost per passenger trip is used in VERPAT.
The source for highway infrastructure costs is FHWA’s Highway Economic Requirements System model, or HERS. Information was obtained from Chapter 6 of the 2005 Technical Report for all US states (FHWA, 2005). Table 8-1 in HERS provides unit costs (per lane mile) for both Rural and Urban highway systems, and distinguishes among three functional classes: interstates, freeways and expressways; other principal arterials; and minor arterials and collectors. Costs estimates are provided for the following improvements:

- Reconstruction and widening
- Reconstruct pavement
- Resurface and widen lanes
- Resurface pavement
- Improve shoulders

Additional choices are offered to distinguish between adding a lane at "normal" vs. "high cost", and also for pavement realignment, also under normal vs. high cost conditions. For practical reasons, it was decided to use only "new construction" (which also includes adding lanes) costs as the basis for the cost estimates, and to ignore the categories of reconstruction, resurfacing, and realignment. These construction costs include right of way, construction, and a "small" allowance for bridges and support facilities.
The infrastructure costs focus only on the "urban" system, not rural, which also makes it possible to differentiate by three size classes: Small Urban, Small Urbanized, and Large Urbanized. The numbers from HERS are in 2002 dollars; FHWA advises escalation to current dollars using its NHCCI, which is available online at http://www.fhwa.dot.gov/policyinformation/nhcci.cfm); the report in VERPAT escalates uses this Index to escalate to 2010 values.
The parameter values in this file are average values per lane mile, simplifying the calculations of highway costs to just differentiate investments in freeway vs. arterial functional class roads.
Here is a snapshot of the file:

| SupplyClass | CapCosts.2000 | OpCosts.2000 | Fare.2000 |
| ----------- | ------------- | ------------ | --------- |
| Freeway     | 17            | 0            | 0         |
| Arterial    | 7             | 0            | 0         |
| Bus         | 0.71          | 3.4          | 0.91      |
| Rail        | 5.11          | 4.87         | 2.19      |

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### model_veh_mpg_by_year.csv

**Vehicle fuel economy (*model_veh_mpg_by_year.csv*)**: This file contains the estimates and forecasts of average fuel economy and power economy in miles per gallon for autos, light trucks, heavy trucks (trucks) and miles per kilowatt for trains by vehicle model year. Note that this is not the fleet average for that year. It is the average for new vehicles sold in that year. The fuel economy is the same for all fuel types and is measured in gasoline equivalent gallons (i.e. energy content of a gallon of gasoline). This file is used in the calculations of fuel consumption.
Here is a snapshot of the file:

| ModelYear                      | AutoMpg                        | LtTruckMpg                     | TruckMpg                       | BusMpg                         | TrainMpg                       |
| ------------------------------ | ------------------------------ | ------------------------------ | ------------------------------ | ------------------------------ | ------------------------------ |
| 1975                           | 15.1                           | 12.7                           | 5.1                            | 4.2                            | 0.098266                       |
| 1976                           | 16.6                           | 13.2                           | 5.1                            | 4.1                            | 0.098266                       |
| 1977                           | 17.4                           | 14.1                           | 5.1                            | 4.1                            | 0.098266                       |
| 1978                           | 19.2                           | 13.7                           | 5.1                            | 4                              | 0.098266                       |
| ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) |
| 2046                           | 63.7                           | 41.1                           | 5.6                            | 4.8                            | 0.121191                       |
| 2047                           | 63.7                           | 41.1                           | 5.6                            | 4.8                            | 0.121191                       |
| 2048                           | 63.7                           | 41.1                           | 5.6                            | 4.8                            | 0.121191                       |
| 2049                           | 63.7                           | 41.1                           | 5.6                            | 4.8                            | 0.121191                       |
| 2050                           | 63.7                           | 41.1                           | 5.6                            | 4.8                            | 0.121191                       |

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### model_phev_range_prop_mpg_mpkwh.csv

**Plugin hybrid electric vehicles characteristics (*model_phev_range_prop_mpg_mpkwh.csv*)**: This file contains the estimates and forecasts of range, fuel efficiency (mpg), power efficiency (mpkwh), and proportions of automobiles and light trucks that are plugin hybrid electric vehicles by vehicle model year. Note that this is not the fleet average for that year. It is the average of new vehicles sold in that year. This file is used in identification of plugin hybrid electric and electric vehicles. Here is a snapshot of the file:

| ModelYear | AutoPhevRange | AutoPropPhev | AutoMpkwh | AutoMpg | LtTruckPhevRange | LtTruckPropPhev | LtTruckMpkwh | LtTruckMpg |
| --------- | ------------- | ------------ | --------- | ------- | ---------------- | --------------- | ------------ | ---------- |
| 1975      | 0             | 0            | 0         | 0       | 0                | 0               | 0            | 0          |
| 1976      | 0             | 0            | 0         | 0       | 0                | 0               | 0            | 0          |
| 1977      | 0             | 0            | 0         | 0       | 0                | 0               | 0            | 0          |
| 1978      | 0             | 0            | 0         | 0       | 0                | 0               | 0            | 0          |
| 1979      | 0             | 0            | 0         | 0       | 0                | 0               | 0            | 0          |
| ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) |
| 2045      | 40            | 0.66         | 4.375     | 74.5    | 40               | 0.586666667     | 2.875        | 58.2       |
| 2046      | 40            | 0.708        | 4.4       | 74.9    | 40               | 0.629333333     | 2.9          | 58.5       |
| 2047      | 40            | 0.756        | 4.425     | 75.3    | 40               | 0.672           | 2.925        | 58.8       |
| 2048      | 40            | 0.816        | 4.45      | 75.6    | 40               | 0.725333333     | 2.95         | 59.1       |
| 2049      | 40            | 0.864        | 4.475     | 76      | 40               | 0.768           | 2.975        | 59.3       |
| 2050      | 40            | 0.9          | 4.5       | 76.4    | 40               | 0.8             | 3            | 59.6       |

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### model_hev_prop_mpg.csv

**Hybrid electric vehicles characteristics (*model_hev_prop_mpg.csv*)**: This file contains the estimates and forecasts of fuel efficiency (mpg), and proportions of automobiles and light trucks that are hybrid electric vehicles (that are neither plugin hybrid nor electric vehicle) by vehicle model year. Note that this is not the fleet average for that year. It is the average of new vehicles sold in that year. This file is used in identification of hybrid electric that are not plugin hybrid or electric vehicles. Here is a snapshot of the file:

| ModelYear | AutoPropHev | AutoHevMpg | LtTruckPropHev | LtTruckHevMpg |
| --------- | ----------- | ---------- | -------------- | ------------- |
| 1975      | 0           | 0          | 0              | 0             |
| 1976      | 0           | 0          | 0              | 0             |
| 1977      | 0           | 0          | 0              | 0             |
| 1978      | 0           | 0          | 0              | 0             |
| 1979      | 0           | 0          | 0              | 0             |
| 1980      | 0           | 0          | 0              | 0             |
| ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) |
| 2046      | 0.981481481 | 74.2       | 0.736111111    | 55.4          |
| 2047      | 0.981481481 | 74.5       | 0.736111111    | 55.6          |
| 2048      | 1           | 74.9       | 0.75           | 55.9          |
| 2049      | 1           | 75.2       | 0.75           | 56.1          |
| 2050      | 1           | 75.5       | 0.75           | 56.3          |

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### model_ev_range_prop_mpkwh.csv

**Electric vehicles characteristics (*model_ev_range_prop_mpkwh.csv*)**: This file contains the estimates and forecasts of range, power efficiency (mpkwh), and proportions of automobiles and light trucks that are electric vehicles by vehicle model year. Note that this is not the fleet average for that year. It is the average of new vehicles sold in that year. This file is used in identification of electric vehicles. Here is a snapshot of the file:

| ModelYear | AutoRange | AutoPropEv | AutoMpkwh | LtTruckRange | LtTruckPropEv | LtTruckMpkwh |
| --------- | --------- | ---------- | --------- | ------------ | ------------- | ------------ |
| 1975      | 0         | 0          | 0         | 0            | 0             | 0            |
| 1976      | 0         | 0          | 0         | 0            | 0             | 0            |
| 1977      | 0         | 0          | 0         | 0            | 0             | 0            |
| 1978      | 0         | 0          | 0         | 0            | 0             | 0            |
| 1979      | 0         | 0          | 0         | 0            | 0             | 0            |
| ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) |
| 2046      | 277.5     | 0.72       | 4.4       | 185          | 0.56          | 2.9          |
| 2047      | 283.125   | 0.75       | 4.425     | 188.75       | 0.583333333   | 2.925        |
| 2048      | 288.75    | 0.795      | 4.45      | 192.5        | 0.618333333   | 2.95         |
| 2049      | 294.375   | 0.855      | 4.475     | 196.25       | 0.665         | 2.975        |
| 2050      | 300       | 0.9        | 4.5       | 200          | 0.7           | 3            |

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### JSON Inputs

#### AnnVmtInflator

**Annual VMT inflator (*AnnVmtInflator*)**: Factor to convert VMT between annual and average daily amounts. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

```json
{
    "NAME" : "AnnVmtInflator",
    "VALUE": "365",
    "TYPE" : "integer",
    "UNITS" : "DAYS",
    "PROHIBIT" : "c('NA', '< 0')",
    "ISELEMENTOF" : ""
}
```

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### BaseCostPerMile

**Base cost per mile (*BaseCostPerMile*)**: Base cost per mile in dollars for transportation costs used in the travel demand model to initially represent travel as close to unconstrained by transportation costs. The transportation costs are then fully constrained later in the model as travel reductions caused by budget constraints are estimated. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

```json
{
    "NAME" : "BaseCostPerMile",
    "VALUE": "0.04",
    "TYPE" : "compound",
    "UNITS" : "USD/MI",
    "PROHIBIT" : "c('NA', '< 0')",
    "ISELEMENTOF" : ""
}
```

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### DvmtBudgetProp

**Dvmt budget proportion (*DvmtBudgetProp*)**: The proportion of household budget that can be allocated to transportation spending. The travel demand models includes a constraint that reduces household travel if too high a proportion of household spending is spent on transportation. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

```json
{
    "NAME" : "DvmtBudgetProp",
    "VALUE": "0.1",
    "TYPE" : "double",
    "UNITS" : "multiplier",
    "PROHIBIT" : "c('NA', '< 0', '> 1')",
    "ISELEMENTOF" : ""
}
```

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### FuelCost

**Fuel cost (*FuelCost*)**: Average cost per gallon of fuel (before taxes are added). It should be defined in [model_parameters.json](#model_parametersjson) as follows:

```json
{
    "NAME" : "FuelCost",
    "VALUE": "1.82",
    "TYPE" : "compound",
    "UNITS" : "USD/GAL",
    "PROHIBIT" : "c('NA', '< 0')",
    "ISELEMENTOF" : ""
}
```

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### KwhCost

**Power cost (*KwhCost*)**: Average cost per kwh of power consumption (before taxes are added). It should be defined in [model_parameters.json](#model_parametersjson) as follows:

```json
{
    "NAME" : "KwhCost",
    "VALUE": "0.257",
    "TYPE" : "compound",
    "UNITS" : "USD/KWH",
    "PROHIBIT" : "c('NA', '< 0')",
    "ISELEMENTOF" : ""
}
```

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### GasTax

**Gas tax (*GasTax*)**: Average cost per gallon of fuel of gas taxes. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

```json
{
    "NAME" : "GasTax",
    "VALUE": "0.424",
    "TYPE" : "compound",
    "UNITS" : "USD/GAL",
    "PROHIBIT" : "c('NA', '< 0')",
    "ISELEMENTOF" : ""
}
```

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### LtTruckProp

**Light Truck Proportions (*LtTruckProp*)**: The proportion of household vehicles that are light trucks (SUVs, pickup trucks) as opposed to autos. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

```json
{
    "NAME" : "LtTruckProp",
    "VALUE": "0.45",
    "TYPE" : "double",
    "UNITS" : "multiplier",
    "PROHIBIT" : "c('NA', '< 0')",
    "ISELEMENTOF" : ""
}
```

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### TranRevMiAdjFactor

**Transit revenue adjustment factor (*TranRevMiAdjFactor*)**: Factor to convert transit revenue miles (i.e. miles run in service on routes) to total transit vehicle miles operated to account for vehicle miles run while deadheading from depots to route endpoints. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

```json
{
    "NAME" : "TranRevMiAdjFactor",
    "VALUE": "1.12",
    "TYPE" : "double",
    "UNITS" : "multiplier",
    "PROHIBIT" : "c('NA', '< 0')",
    "ISELEMENTOF" : ""
}
```

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### TruckVmtGrowthMultiplier

**Truck vmt growth multiplier (*TruckVmtGrowthMultiplier*)**: Rate at which heavy truck VMT growth in relation to total regional household income growth in the region. A value of 1 indicates that heavy truck VMT grows at the same rate as total regional household income. A value less than 1 means slower growth in truck VMT, and greater than 1 means faster growth in truck VMT than total regional household income. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

```json
{
    "NAME" : "TruckVmtGrowthMultiplier",
    "VALUE": "1",
    "TYPE" : "double",
    "UNITS" : "multiplier",
    "PROHIBIT" : "c('NA', '< 0')",
    "ISELEMENTOF" : ""
}
```

[Inputs](#inputs)   [Model Parameters](#model-parameters) [Definitions](#model-definition-files)

#### WorkVmtProp

**Work VMT Proportion (*WorkVmtProp*)**: The proportion of household VMT that takes place for commute to work purposes; used to differentiate between travel purposes for use in estimating overall VMT reductions that are targeted at the commute to work. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

```json
{
    "NAME" : "WorkVmtProp",
    "VALUE": "0.25",
    "TYPE" : "double",
    "UNITS" : "proportion",
    "PROHIBIT" : "c('NA', '< 0')",
    "ISELEMENTOF" : ""
}
```

## Modules and Outputs

The VERPAT model is a compilation of several packages, listed below, the inputs of which are described respectively. The inputs are classified into five categories:

1. **User input files**: These are input files (model or scenario specific) that a user is recommended to change.
2. **User input model parameters**: These are input parameters (model or scenario specific), defined in [model_parameters.json](#model_parametersjson), that a user is recommended to change.
3. **Fixed input files**: These are input parameters specific to the model that are fixed.
4. **Fixed input model parameters**: These are input parameters specific to the model, defined in [model_parameters.json](#model_parametersjson), that are fixed.
5. **Internal module inputs**: These are inputs produced as output by other modules.

| MODULE                                                      | PACKAGE                                                      | RPAT             |
| ----------------------------------------------------------- | ------------------------------------------------------------ | ---------------- |
| [CreateHouseholds](#createhouseholds)                       | [VESimHouseholds](https://github.com/visioneval/VisionEval/tree/master/sources/modules/VESimHouseholds) | household        |
| [PredictWorkers](#predictworkers)                           | [VESimHouseholds](https://github.com/visioneval/VisionEval/tree/master/sources/modules/VESimHouseholds) | household        |
| [PredictIncome](#predictincome)                             | [VESimHouseholds](https://github.com/visioneval/VisionEval/tree/master/sources/modules/VESimHouseholds) | household        |
| [CreateBaseSyntheticFirms](#createbasesyntheticfirms)       | [VESyntheticFirms](https://github.com/visioneval/VisionEval/tree/master/sources/modules/VESyntheticFirms) | household        |
| [CreateFutureSyntheticFirms](#createfuturesyntheticfirms)   | [VESyntheticFirms](https://github.com/visioneval/VisionEval/tree/master/sources/modules/VESyntheticFirms) | household        |
| [CalculateBasePlaceTypes](#calculatebaseplacetypes)         | [VELandUse](https://github.com/visioneval/VisionEval/tree/master/sources/modules/VELandUse) | urban            |
| [CalculateFuturePlaceTypes](#calculatefutureplacetypes)     | [VELandUse](https://github.com/visioneval/VisionEval/tree/master/sources/modules/VELandUse) | urban            |
| [CreateBaseAccessibility](#createbaseaccessibility)         | [VETransportSupply](https://github.com/visioneval/VisionEval/tree/master/sources/modules/VETransportSupply) | accessibility    |
| [CreateFutureAccessibility](#createfutureaccessibility)     | [VETransportSupply](https://github.com/visioneval/VisionEval/tree/master/sources/modules/VETransportSupply) | accessibility    |
| [AssignVehicleFeatures](#assignvehiclefeatures)             | [VEHouseholdVehicles](https://github.com/visioneval/VisionEval/tree/master/sources/modules/VEHouseholdVehicles) | vehicle          |
| [AssignVehicleFeaturesFuture](#assignvehiclefeaturesfuture) | [VEHouseholdVehicles](https://github.com/visioneval/VisionEval/tree/master/sources/modules/VEHouseholdVehicles) | vehicle          |
| [CalculateTravelDemand](#calculatetraveldemand)             | [VEHouseholdTravel](https://github.com/visioneval/VisionEval/tree/master/sources/modules/VEHouseholdTravel) | demand           |
| [CalculateTravelDemandFuture](#calculatetraveldemandfuture) | [VEHouseholdTravel](https://github.com/visioneval/VisionEval/tree/master/sources/modules/VEHouseholdTravel) | demand           |
| [CalculateCongestionBase](#calculatecongestionbase)         | [VETransportSupplyUse](https://github.com/visioneval/VisionEval/tree/master/sources/modules/VETransportSupplyUse) | congestion       |
| [CalculateCongestionFuture](#calculatecongestionfuture)     | [VETransportSupplyUse](https://github.com/visioneval/VisionEval/tree/master/sources/modules/VETransportSupplyUse) | congestion       |
| [CalculateInducedDemand](#calculateinduceddemand)           | [VEHouseholdTravel](https://github.com/visioneval/VisionEval/tree/master/sources/modules/VEHouseholdTravel) | induced          |
| [CalculatePolicyVmt](#calculatepolicyvmt)                   | [VEHouseholdTravel](https://github.com/visioneval/VisionEval/tree/master/sources/modules/VEHouseholdTravel) | policyvmt        |
| [CalculateCongestionPolicy](#calculatecongestionpolicy)     | [VETransportSupplyUse](https://github.com/visioneval/VisionEval/tree/master/sources/modules/VETransportSupplyUse) | policycongestion |
| [ReportRPATMetrics](#reportrpatmetrics)                     | [VEReports](https://github.com/visioneval/VisionEval/tree/master/sources/modules/VEReports) | metrics          |

[Top](#contents)										[Definitions](#definitions)								[Inputs/Outputs](#inputs-and-outputs)  

------

### CreateHouseholds

This module creates simulated households for a model using inputs of population by age group for each Azone and year.

#### User Input Files

1. **Household population (*azone_hh_pop_by_age.csv*)**: This file contains population estimates/forecasts by county and age cohort for each of the base and future years. The file format includes six age categories used by the population synthesis model:

   - **0-14**
   - **15-19**
   - **20-29**
   - **30-54**
   - **55-64**
   - **65 Plus**

   Future year data must be developed by the user; in many regions population forecasts are available from regional or state agencies and/or local academic sources. As with the employment data inputs the future data need not be county specific. Rather, regional totals by age group can be entered into the file with a value such as “region” entered in the county field.

   Here is a snapshot of the file:

   | Geo       | Year | Age0to14 | Age15to19 | Age20to29 | Age30to54 | Age55to64 | Age65Plus |
   | --------- | ---- | -------- | --------- | --------- | --------- | --------- | --------- |
   | Multnomah | 2005 | 129869   | 41133     | 99664     | 277854    | 71658     | 72648     |
   | Multnomah | 2035 | 169200   | 48800     | 144050    | 327750    | 116100    | 162800    |

2. **Household size (*azone_hhsize_targets.csv*)**: This file contains the household specific targets. This contain two household specific attributes:

   - **AveHhSize**: Average household size of households (non-group quarters)
   - **Prop1PerHh**: Proportion of households (non-group quarters) having only one person

   Here is a snapshot of the file:

   | Geo       | Year | AveHhSize | Prop1PerHh |
   | --------- | ---- | --------- | ---------- |
   | Multnomah | 2005 | NA        | NA         |
   | Multnomah | 2035 | NA        | NA         |

3. **Group quarter population (*azone_gq_pop_by_age.csv*)**: This file contains group quarters population estimates/forecasts by county and age cohort for each of the base and future years. The file format includes six age categories used by the population synthesis model:

   - **0-14**
   - **15-19**
   - **20-29**
   - **30-54**
   - **55-64**
   - **65 Plus**

   Here is a snapshot of the file:

   | Geo       | Year | GrpAge0to14 | GrpAge15to19 | GrpAge20to29 | GrpAge30to54 | GrpAge55to64 | GrpAge65Plus |
   | --------- | ---- | ----------- | ------------ | ------------ | ------------ | ------------ | ------------ |
   | Multnomah | 2005 | 0           | 0            | 0            | 1            | 0            | 0            |
   | Multnomah | 2035 | 0           | 0            | 0            | 1            | 0            | 0            |


#### Module Outputs

1. **NumHh**: Number of households (non-group quarters)
2. **HhId**: Unique household ID
3. **HhSize**: Number of persons
4. **Age0to14**: Persons in 0 to 14 year old age group
5. **Age15to19**: Persons in 15 to 19 year old age group
6. **Age20to29**: Persons in 20 to 29 year old age group
7. **Age30to54**: Persons in 30 to 54 year old age group 
8. **Age55to64**: Persons in 55 to 64 year old age group
9. **Age65Plus**: Persons in 65 or older age group
10. **HhType**: Coded household age composition (e.g. 2-1-0-2-0-0) or Grp for group quarters

	[Top](#contents)										[Definitions](#definitions)								[Inputs/Outputs](#inputs-and-outputs)  

------

### PredictWorkers

This module assigns workers by age to households and to non-institutional group quarters population. It is a simple model which predicts workers as a function of the household type and age composition. There is no responsiveness to jobs or how changes in the job market and demographics might change the worker age composition, but the user can exogenously adjust the relative employment by age group, Azone, and year. The values are the proportions of persons in the age group who are workers relative to the proportions in the estimation year.

#### User Input Files

1. **Relative employment (*azone_relative_employment.csv*)**: This file contains ratio of workers to persons by age cohort in model year vs. estimation data year. This file contains five age cohorts:

   - **RelEmp15to19**: Ratio of workers to persons age 15 to 19 in model year vs. in estimation data year
   - **RelEmp20to29**: Ratio of workers to persons age 20 to 29 in model year vs. in estimation data year
   - **RelEmp30to54**: Ratio of workers to persons age 30 to 54 in model year vs. in estimation data year
   - **RelEmp55to64**: Ratio of workers to persons age 55 to 64 in model year vs. in estimation data year
   - **RelEmp65Plus**: Ratio of workers to persons age 65 or older in model year vs. in estimation data year

   Here is a snapshot of the file:

   | Geo       | Year | RelEmp15to19 | RelEmp20to29 | RelEmp30to54 | RelEmp55to64 | RelEmp65Plus |
   | --------- | ---- | ------------ | ------------ | ------------ | ------------ | ------------ |
   | Multnomah | 2005 | 1            | 1            | 1            | 1            | 1            |
   | Multnomah | 2035 | 1            | 1            | 1            | 1            | 1            |

#### Internal Module Inputs

| Package         | Module                                | Outputs       | Description                                                  |
| --------------- | ------------------------------------- | ------------- | ------------------------------------------------------------ |
| VESimHouseholds | [CreateHouseholds](#createhouseholds) | **Age0to14**  | Persons in 0 to 14 year old age group                        |
| VESimHouseholds | [CreateHouseholds](#createhouseholds) | **Age15to19** | Persons in 15 to 19 year old age group                       |
| VESimHouseholds | [CreateHouseholds](#createhouseholds) | **Age20to29** | Persons in 20 to 29 year old age group                       |
| VESimHouseholds | [CreateHouseholds](#createhouseholds) | **Age30to54** | Persons in 30 to 54 year old age group                       |
| VESimHouseholds | [CreateHouseholds](#createhouseholds) | **Age55to64** | Persons in 55 to 64 year old age group                       |
| VESimHouseholds | [CreateHouseholds](#createhouseholds) | **Age65Plus** | Persons in 65 or older age group                             |
| VESimHouseholds | [CreateHouseholds](#createhouseholds) | **HhType**    | Coded household age composition (e.g. 2-1-0-2-0-0) or Grp for group  quarters |

#### Module Outputs

1. **Wkr15to19**: Workers in 15 to 19 year old age group
2. **Wkr20to29**: Workers in 20 to 29 year old age group
3. **Wkr30to54**: Workers in 30 to 54 year old age group
4. **Wkr55to64**: Workers in 55 to 64 year old age group
5. **Wkr65Plus**: Workers in 65 or older age group
6. **Workers**: Total number of workers
7. **NumWkr**: Number of workers residing in the zone

	[Top](#contents)										[Definitions](#definitions)								[Inputs/Outputs](#inputs-and-outputs)  

------

### PredictIncome

This module predicts the income for each simulated household given the number of workers in each age group and the average per capita income for the Azone where the household resides.

#### User Input Files

1. **Regional income (*azone_per_cap_inc.csv*)**: This file contains information on regional average per capita  household (**HHIncomePC**) and group quarters (**GQIncomePC**) income by forecast year in year 2000 dollars. The data can be obtained from the U.S. Department of [Commerce Bureau of Economic Analysis](http://www.bea.gov/regional/index.htm) for the current year or from regional or state sources for forecast years. In order to use current year dollars just replace ***2000*** in column labels with current year. For example, if the data is obtained in year 2005 dollars then the column labels in the file shown below will become **HHIncomePC.2005** and **GQIncomePC.2005**.
   Here is a snapshot of the file:

   | Geo       | Year | HHIncomePC.2000 | GQIncomePC.2000 |
   | --------- | ---- | --------------- | --------------- |
   | Multnomah | 2005 | 32515           | 0               |
   | Multnomah | 2035 | 40000           | 0               |

#### Internal Module Inputs

| Package         | Module                                | Outputs       | Description                                                  |
| --------------- | ------------------------------------- | ------------- | ------------------------------------------------------------ |
| VESimHouseholds | [CreateHouseholds](#createhouseholds) | **HhSize**    | Number of  persons                                           |
| VESimHouseholds | [CreateHouseholds](#createhouseholds) | **HhType**    | Coded household age composition (e.g. 2-1-0-2-0-0) or Grp for group  quarters |
| VESimHouseholds | [PredictWorkers](#predictworkers)     | **Wkr15to19** | Workers in 15 to 19 year old age group                       |
| VESimHouseholds | [PredictWorkers](#predictworkers)     | **Wkr20to29** | Workers in 20 to 29 year old age group                       |
| VESimHouseholds | [PredictWorkers](#predictworkers)     | **Wkr30to54** | Workers in 30 to 54 year old age group                       |
| VESimHouseholds | [PredictWorkers](#predictworkers)     | **Wkr55to64** | Workers in 55 to 64 year old age group                       |
| VESimHouseholds | [PredictWorkers](#predictworkers)     | **Wkr65Plus** | Workers in 65 or older age group                             |

#### Module Outputs

1. **Income**: Total annual household (non-group & group quarters) income in year 1999 dollars

	[Top](#contents)										[Definitions](#definitions)								[Inputs/Outputs](#inputs-and-outputs)  

------

### CreateBaseSyntheticFirms

This module creates a set of firms for base year that represents the likely firm composition for the region, given the County Business Pattern data of firms by size and industry. Each firm is described in terms of the number of employees and its industry.

#### User Input Files

1. **Employment (*azone_employment_by_naics.csv*)**: This file contains employment data for each of the counties that make up the region. The file is derived from County Business Pattern ([CBP](http://www.census.gov/econ/cbp/)) data by county. Industries are categorized by the North American Industrial Classification System (NAICS) 6 digit codes. Firm size categories are:

   - **n1_4**: 1- 4 employees
   - **n5_9**: 5-9 employees
   - **n10_19**: 10-19 employees
   - **n20_99**: 20-99 employees
   - **n100_249**: 100-249 employees
   - **n250_499**: 250-499 employees
   - **n500_999**: 500-999 employees
   - **n1000**: 1,000 or More Employee Size Class
   - **n1000_1**: 1,000-1,499 employees
   - **n1000_2**: 1,500-2,499 employees
   - **n1000_3**: 2,500 to 4, 999 Employees
   - **n1000_4**: Over 5,000 employees

   While the county field is required to be present, the business synthesis process does not require a meaningful value and therefore users may simply enter 'region'. The consistency in the naming of the "region" should be maintained across all the files that contains the label *"county"* or *"Geo"*. It is also not necessary to use such detailed NAICS categories if those are not available; the current business synthesis model and subsequent models do not use this level of detail (although future versions of the model may) - at minimum, the number of establishments for all employment types can be provided by size category. Regions with significant employment in industries such as government and public administration that are not covered by the CBP may need to add records to the file that cover this type of employment to more accurately match employment totals in their region. The two additional fields contained in the file are:

   - **emp**: Total number of employees
   - **est**: Total number of establishments

   Here is the snapshot of the file:

   | county    | year | naics  | emp  | est  | n1_4 | n5_9 | n10_19 | n20_49 | n50_99 | n100_249 | n250_499 | n500_999 | n1000 | n1000_1 | n1000_2 | n1000_3 | n1000_4 |
   | --------- | ---- | ------ | ---- | ---- | ---- | ---- | ------ | ------ | ------ | -------- | -------- | -------- | ----- | ------- | ------- | ------- | ------- |
   | Multnomah | 2005 | 113110 | 0    | 5    | 2    | 1    | 0      | 2      | 0      | 0        | 0        | 0        | 0     | 0       | 0       | 0       | 0       |
   | Multnomah | 2005 | 113310 | 0    | 3    | 2    | 0    | 0      | 1      | 0      | 0        | 0        | 0        | 0     | 0       | 0       | 0       | 0       |
   | Multnomah | 2005 | 114111 | 0    | 1    | 0    | 1    | 0      | 0      | 0      | 0        | 0        | 0        | 0     | 0       | 0       | 0       | 0       |
   | Multnomah | 2005 | 114112 | 0    | 1    | 1    | 0    | 0      | 0      | 0      | 0        | 0        | 0        | 0     | 0       | 0       | 0       | 0       |
   | Multnomah | 2005 | 115114 | 0    | 1    | 0    | 0    | 0      | 0      | 0      | 0        | 1        | 0        | 0     | 0       | 0       | 0       | 0       |
   | Multnomah | 2005 | 115210 | 0    | 4    | 3    | 1    | 0      | 0      | 0      | 0        | 0        | 0        | 0     | 0       | 0       | 0       | 0       |
   | Multnomah | 2005 | 115310 | 0    | 5    | 2    | 0    | 1      | 1      | 1      | 0        | 0        | 0        | 0     | 0       | 0       | 0       | 0       |
   | Multnomah | 2005 | 212319 | 0    | 1    | 1    | 0    | 0      | 0      | 0      | 0        | 0        | 0        | 0     | 0       | 0       | 0       | 0       |
   | Multnomah | 2005 | 212321 | 0    | 4    | 1    | 1    | 1      | 1      | 0      | 0        | 0        | 0        | 0     | 0       | 0       | 0       | 0       |

#### Module Outputs

1. **naics**: The six digit naics code
2. **esizecat**: The employment size category
3. **numbus**: The number of businesses
4. **emp**: The number of employees in a business

	[Top](#contents)										[Definitions](#definitions)								[Inputs/Outputs](#inputs-and-outputs)  

------

### CreateFutureSyntheticFirms

This module creates a set of firms for future year that represents the likely firm composition for the region, given the County Business Pattern data of firms by size and industry. Each firm is described in terms of the number of employees and its industry.

#### User Input Parameters

1. **Employment Growth (*EmploymentGrowth*)**: This variable represents a growth rate for employment in the region between the base year and the future year. A rate of 1 indicates no changes in overall employment, a value of more than 1 indicates some growth (e.g., 1.5 = 50% growth) and a value of less than 1 indicates decline in employment. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

   ```json
   {
       "NAME": "EmploymentGrowth",
       "VALUE": "1.5",
       "TYPE": "double",
       "UNITS": "multiplier",
       "PROHIBIT": "",
       "ISELEMENTOF": ""
   }
   ```

#### Internal Module Inputs

| Package          | Module                                                | Outputs      | Description                           |
| ---------------- | ----------------------------------------------------- | ------------ | ------------------------------------- |
| VESyntheticFirms | [CreateBaseSyntheticFirms](#createbasesyntheticfirms) | **naics**    | The six digit naics code              |
| VESyntheticFirms | [CreateBaseSyntheticFirms](#createbasesyntheticfirms) | **esizecat** | The employment size category          |
| VESyntheticFirms | [CreateBaseSyntheticFirms](#createbasesyntheticfirms) | **numbus**   | The number of businesses              |
| VESyntheticFirms | [CreateBaseSyntheticFirms](#createbasesyntheticfirms) | **emp**      | The number of employees in a business |

#### Module Outputs

1. **naics**: The six digit naics code
2. **esizecat**: The employment size category
3. **numbus**: The number of businesses
4. **emp**: The number of employees in a business


[Top](#contents)										[Definitions](#definitions)								[Inputs/Outputs](#inputs-and-outputs)  

------

### CalculateBasePlaceTypes

Population and employment location characteristics are important variables in the vehicle ownership, travel demand, and accessibility models. There are four place types (urban core, Close-in Community, suburban, and rural and five location categories (residential, commercial, mixed-use, transit-oriented development, and Greenfield). This module utilizes models for households that were developed to estimate location characteristics using National Household Travel Survey data for the base year. Firms are currently allocated randomly to fit the employment allocation inputs since there are no national datasets from which to draw these relationships.

#### User Input Files

1. **Population and Jobs by Place Type (*bzone_pop_emp_prop.csv*)**: This file contains the distribution of  population and employment among the 13 place types for base and future year. Each column, for each year, must sum to one (1). It is acceptable to have no land use (i.e. a value of 0) in certain categories.
   The yearly TAZ employment and population totals were summed by the 13 place type and then scaled to total one for both employment and population.
   Here is a snapshot of the file:

   | Geo   | Year | Pop  | Emp  |
   | ----- | ---- | ---- | ---- |
   | Rur   | 2005 | 0.05 | 0.1  |
   | Sub_R | 2005 | 0.3  | 0    |
   | Sub_E | 2005 | 0    | 0.2  |
   | Sub_M | 2005 | 0.1  | 0.1  |
   | Sub_T | 2005 | 0    | 0    |
   | CIC_R | 2005 | 0.15 | 0    |
   | CIC_E | 2005 | 0    | 0.2  |
   | CIC_M | 2005 | 0.1  | 0.1  |
   | CIC_T | 2005 | 0    | 0    |
   | UC_R  | 2005 | 0.1  | 0    |
   | UC_E  | 2005 | 0    | 0.1  |
   | UC_M  | 2005 | 0.1  | 0.1  |
   | UC_T  | 2005 | 0.1  | 0.1  |
   | Rur   | 2035 | 0.05 | 0.1  |
   | Sub_R | 2035 | 0.3  | 0    |
   | Sub_E | 2035 | 0    | 0.2  |
   | Sub_M | 2035 | 0.1  | 0.1  |
   | Sub_T | 2035 | 0    | 0    |
   | CIC_R | 2035 | 0.15 | 0    |
   | CIC_E | 2035 | 0    | 0.2  |
   | CIC_M | 2035 | 0.1  | 0.1  |
   | CIC_T | 2035 | 0    | 0    |
   | UC_R  | 2035 | 0.1  | 0    |
   | UC_E  | 2035 | 0    | 0.1  |
   | UC_M  | 2035 | 0.1  | 0.1  |
   | UC_T  | 2035 | 0.1  | 0.1  |

#### Internal Module Inputs

| Package          | Module                                                | Outputs       | Description                                                  |
| ---------------- | ----------------------------------------------------- | ------------- | ------------------------------------------------------------ |
| VESimHouseholds  | [CreateHouseholds](#createhouseholds)                 | **HhId**      | Unique  household ID                                         |
| VESimHouseholds  | [CreateHouseholds](#createhouseholds)                 | **Age0to14**  | Persons in 0 to 14 year old age group                        |
| VESimHouseholds  | [CreateHouseholds](#createhouseholds)                 | **Age15to19** | Persons in 15 to 19 year old age group                       |
| VESimHouseholds  | [CreateHouseholds](#createhouseholds)                 | **Age20to29** | Persons in 20 to 29 year old age group                       |
| VESimHouseholds  | [CreateHouseholds](#createhouseholds)                 | **Age30to54** | Persons in 30 to 54 year old age group                       |
| VESimHouseholds  | [CreateHouseholds](#createhouseholds)                 | **Age55to64** | Persons in 55 to 64 year old age group                       |
| VESimHouseholds  | [CreateHouseholds](#createhouseholds)                 | **Age65Plus** | Persons in 65 or older age group                             |
| VESimHouseholds  | [CreateHouseholds](#createhouseholds)                 | **HhSize**    | Number of  persons                                           |
| VESimHouseholds  | [PredictIncome](#predictincome)                       | **Income**    | Total annual household (non-qroup & group quarters) income in year  1999 dollars |
| VESyntheticFirms | [CreateBaseSyntheticFirms](#createbasesyntheticfirms) | **naics**     | The six digit naics code                                     |
| VESyntheticFirms | [CreateBaseSyntheticFirms](#createbasesyntheticfirms) | **esizecat**  | The employment size category                                 |
| VESyntheticFirms | [CreateBaseSyntheticFirms](#createbasesyntheticfirms) | **numbus**    | The number of businesses                                     |
| VESyntheticFirms | [CreateBaseSyntheticFirms](#createbasesyntheticfirms) | **emp**       | The number of employees in a business                        |

#### Module Outputs

The outputs produced by this module is for base year.

1. **DrvLevels**: The number of people in a household who can drive classified in three categories ("Drv1", "Drv2", "Drv3Plus")
2. **HhPlaceTypes**: A place type as assigned to the households
3. **EmpPlaceTypes**: A place types as assigned to the businesses
4. **UrbanPop**: Total population by place types
5. **UrbanEmp**: Total employees by place types
6. **UrbanIncome**: Total income by place types

[Top](#contents)										[Definitions](#definitions)								[Inputs/Outputs](#inputs-and-outputs)  

------

### CalculateFuturePlaceTypes

This module is similar to *CalculateBasePlaceTypes* module but utilizes the future year data to assign population and employment location characteristics.

#### User Input Files

1. **Population and Jobs by Place Type (*bzone_pop_emp_prop.csv*)**: This is the same file used as input in [CalculateBasePlaceTypes](#calculatebaseplacetypes) module.

#### Internal Module Inputs:

| Package          | Module                                                    | Outputs       | Description                                                  |
| ---------------- | --------------------------------------------------------- | ------------- | ------------------------------------------------------------ |
| VESimHouseholds  | [CreateHouseholds](#createhouseholds)                     | **HhId**      | Unique  household ID                                         |
| VESimHouseholds  | [CreateHouseholds](#createhouseholds)                     | **Age0to14**  | Persons in 0 to 14 year old age group                        |
| VESimHouseholds  | [CreateHouseholds](#createhouseholds)                     | **Age15to19** | Persons in 15 to 19 year old age group                       |
| VESimHouseholds  | [CreateHouseholds](#createhouseholds)                     | **Age20to29** | Persons in 20 to 29 year old age group                       |
| VESimHouseholds  | [CreateHouseholds](#createhouseholds)                     | **Age30to54** | Persons in 30 to 54 year old age group                       |
| VESimHouseholds  | [CreateHouseholds](#createhouseholds)                     | **Age55to64** | Persons in 55 to 64 year old age group                       |
| VESimHouseholds  | [CreateHouseholds](#createhouseholds)                     | **Age65Plus** | Persons in 65 or older age group                             |
| VESimHouseholds  | [CreateHouseholds](#createhouseholds)                     | **HhSize**    | Number of  persons                                           |
| VESimHouseholds  | [PredictIncome](#predictincome)                           | **Income**    | Total annual household (non-qroup & group quarters) income in year  1999 dollars |
| VESyntheticFirms | [CreateFutureSyntheticFirms](#createfuturesyntheticfirms) | **naics**     | The six digit naics code                                     |
| VESyntheticFirms | [CreateFutureSyntheticFirms](#createfuturesyntheticfirms) | **esizecat**  | The employment size category                                 |
| VESyntheticFirms | [CreateFutureSyntheticFirms](#createfuturesyntheticfirms) | **numbus**    | The number of businesses                                     |
| VESyntheticFirms | [CreateFutureSyntheticFirms](#createfuturesyntheticfirms) | **emp**       | The number of employees in a business                        |
| VELandUse        | [CalculateBasePlaceTypes](#calculatebaseplacetypes)       | **UrbanPop**  | Total population by place types                              |
| VELandUse        | [CalculateBasePlaceTypes](#calculatebaseplacetypes)       | **UrbanEmp**  | Total employees by place types                               |

#### Module Outputs

The outputs produced by this module is for future year.

1. **DrvLevels**: The number of people in a household who can drive classified in three categories ("Drv1", "Drv2", "Drv3Plus")
2. **HhPlaceTypes**: A place type as assigned to the households
3. **EmpPlaceTypes**: A place types as assigned to the businesses
4. **UrbanPop**: Total population by place types
5. **UrbanEmp**: Total employees by place types
6. **UrbanIncome**: Total income by place types

[Top](#contents)										[Definitions](#definitions)								[Inputs/Outputs](#inputs-and-outputs)  

------

### CreateBaseAccessibility

This module calculates freeway, arterial, and public transit supply levels for all years using existing (base) data. The number of lane miles of freeways and arterials is computed for each region based on the change in inventories for a particular scenario. For public transit, the inputs specify the change in transit revenue miles relative to the base. Inputs for each area also specify the revenue mile split between electrified rail and buses.

#### User Input Files

1. **Road lane miles (*marea_lane_miles.csv*)**: This file contains the amount of transportation supply by base year in terms of lane miles of freeways and arterial roadways in the region. The base year data is duplicated for future year.
   **Freeway** and **Arterial** are total lane miles for those functional classes in the region. These data can be derived from the Federal Highway Administration's (FHWA) Highway [Statistics data](http://www.fhwa.dot.gov/policy/ohim/hs05/roadway_extent.cfm).
   Here is a snapshot of the file:

   | Geo       | Year | FwyLaneMi | ArtLaneMi |
   | --------- | ---- | --------- | --------- |
   | Multnomah | 2005 | 250       | 900       |
   | Multnomah | 2035 | 250       | 900       |

2. **Transit revenue miles (*marea_rev_miles_pc.csv*)**: This file contains the amount of transportation supply by base year in terms of the revenue miles operating by the transit system in the region. The base year data is duplicated for future year.
   **Bus** and **Rail** are annual bus and rail revenue miles per capita for the region. These data can be derived from the [National Transit Database](https://www.transit.dot.gov/ntd/ntd-data), where the annual database contains a “service” table that has annual revenue mile data by mode for each transit operator.
   Here is a snapshot of the file:

   | Geo       | Year | BusRevMiPC | RailRevMiPC |
   | --------- | ---- | ---------- | ----------- |
   | Multnomah | 2005 | 19         | 4           |
   | Multnomah | 2035 | 19         | 4           |

#### Internal Module Inputs

| Package   | Module                                                  | Outputs      | Description                     |
| --------- | ------------------------------------------------------- | ------------ | ------------------------------- |
| VELandUse | [CalculateBasePlaceTypes](#calculatebaseplacetypes)     | **UrbanPop** | Total population by place types |
| VELandUse | [CalculateFuturePlaceTypes](#calculatefutureplacetypes) | **UrbanPop** | Total population by place types |

#### Module Outputs

1. **FwyLaneMiPC**: Ratio of urbanized area freeway and expressway lane-miles to urbanized area population
2. **ArtLaneMiPC**: Ratio of urbanized area arterial lane-miles to urbanized area population
3. **TranRevMiPC**: Transit revenue miles per capita for the region
4. **BusRevMi**: Bus revenue miles for the region
5. **RailRevMi**: Rail revenue miles for the region

[Top](#contents)										[Definitions](#definitions)								[Inputs/Outputs](#inputs-and-outputs)  

------

### CreateFutureAccessibility

This module calculates freeway, arterial, and public transit supply levels for all years using model estimation of future data.

#### User Input Files

1. **Road lane miles (*marea_lane_miles.csv*)**: This file contains the amount of transportation supply by base year in terms of lane miles of freeways and arterial roadways in the region. The base year data is duplicated for future year.
   **Freeway** and **Arterial** are total lane miles for those functional classes in the region. These data can be derived from the Federal Highway Administration’s (FHWA) Highway [Statistics data](http://www.fhwa.dot.gov/policy/ohim/hs05/roadway_extent.cfm).
   Here is a snapshot of the file:

   | Geo       | Year | FwyLaneMi | ArtLaneMi |
   | --------- | ---- | --------- | --------- |
   | Multnomah | 2005 | 250       | 900       |
   | Multnomah | 2035 | 250       | 900       |

2. **Transit revenue miles (*marea_rev_miles_pc.csv*)**: This file contains the amount of transportation supply by base year in terms of the revenue miles operating by the transit system in the region. The base year data is duplicated for future year.
   **Bus** and **Rail** are annual bus and rail revenue miles per capita for the region. These data can be derived from the [National Transit Database](https://www.transit.dot.gov/ntd/ntd-data), where the annual database contains a “service” table that has annual revenue mile data by mode for each transit operator.
   Here is a snapshot of the file:

   | Geo       | Year | BusRevMiPC | RailRevMiPC |
   | --------- | ---- | ---------- | ----------- |
   | Multnomah | 2005 | 19         | 4           |
   | Multnomah | 2035 | 19         | 4           |

#### User Input Parameters

1. **FwyLaneMiGrowth**: The variable indicates the percent increase in supply of freeways lane miles in the future year compared to base year. By default, the transportation supply is assumed to grow in line with population increase; therefore a value of 1 indicates growth in proportion with population growth. A value less than 1 indicates that there will be less freeway lane mile supply, per person, in the future. A value of 1 indicates faster freeway expansion than population growth.  It should be defined in [model_parameters.json](#model_parametersjson) as follows:

   ```json
   {
       "NAME": "FwyLaneMiGrowth",
       "VALUE": "1",
       "TYPE" : "double",
       "UNITS" : "multiplier",
       "PROHIBIT" : "c('NA', '< 0')",
       "ISELEMENTOF" : ""
   }
   ```

2. **ArtLaneMiGrowth**:  The variable indicates the percent increase in supply of arterial lane miles in the future year compared to base year. It is a similar value to freeway except that it measures arterial lane mile growth. It is also proportional to population growth. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

   ```json
   {
       "NAME" : "ArtLaneMiGrowth",
       "VALUE": "1",
       "TYPE" : "double",
       "UNITS" : "multiplier",
       "PROHIBIT" : "c('NA', '< 0')",
       "ISELEMENTOF" : ""
   }
   ```

3. **BusRevMiPCGrowth**: It is the percent increase in transit revenue miles per capita for bus. It behaves in a similar way to the freeway and rail values in that a value of 1 indicates per capita revenue miles stays constant. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

   ```json
   {
       "NAME" : "BusRevMiPCGrowth",
       "VALUE": "1",
       "TYPE" : "double",
       "UNITS" : "multiplier",
       "PROHIBIT" : "c('NA', '< 0')",
       "ISELEMENTOF" : ""
   }
   ```

4. **RailRevMiPCGrowth**: It is the percent increase in transit revenue miles per capita for rail. This encompasses all rail modes, from light rail through to commuter rail. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

   ```json
   {
       "NAME" : "RailRevMiPCGrowth",
       "VALUE": "1",
       "TYPE" : "double",
       "UNITS" : "multiplier",
       "PROHIBIT" : "c('NA', '< 0')",
       "ISELEMENTOF" : ""
   }
   ```

#### Internal Module Inputs

| Package   | Module                                                  | Outputs      | Description                     |
| --------- | ------------------------------------------------------- | ------------ | ------------------------------- |
| VELandUse | [CalculateBasePlaceTypes](#calculatebaseplacetypes)     | **UrbanPop** | Total population by place types |
| VELandUse | [CalculateFuturePlaceTypes](#calculatefutureplacetypes) | **UrbanPop** | Total population by place types |

#### Module Outputs

1. **FwyLaneMiPCFuture**: Ratio of urbanized area freeway and expressway lane-miles to urbanized area population calculated using model estimation of future data
2. **ArtLaneMiPCFuture**: Ratio of urbanized area arterial lane-miles to urbanized area population calculated using model estimation of future data
3. **TranRevMiPCFuture**: Transit revenue miles per capita for the region calculated using model estimation of future data
4. **BusRevMiFuture**: Bus revenue miles for the region calculated using model estimation of future data
5. **RailRevMiFuture**: Rail revenue miles for the region calculated using model estimation of future data

[Top](#contents)										[Definitions](#definitions)								[Inputs/Outputs](#inputs-and-outputs)  

------

### AssignVehicleFeatures

This module assigns each household a number of vehicles it is likely to own based on the number of persons of driving age in the household, whether only elderly persons live in the household, the income of the household, the population density where the household lives, the freeway supply, the transit supply, and whether the household is located in an urban mixed-use area.

#### User Input Files

1. **Vehicle fuel economy (*model_veh_mpg_by_year.csv*)**: This file contains the estimates and forecasts of average fuel economy and power economy in miles per gallon for autos, light trucks, heavy trucks (trucks) and miles per kilowatt for trains by vehicle model year. Note that this is not the fleet average for that year. It is the average for new vehicles sold in that year. The fuel economy is the same for all fuel types and is measured in gasoline equivalent gallons (i.e., energy content of a gallon of gasoline). This file is used in the calculations of fuel consumption. This file can be used to test alternative vehicle development scenarios, such as improved technology and/or fuel economy standards that lead to higher vehicle fuel economies.
   Here is a snapshot of the file:

   | ModelYear                      | AutoMpg                        | LtTruckMpg                     | TruckMpg                       | BusMpg                         | TrainMpg                       |
   | ------------------------------ | ------------------------------ | ------------------------------ | ------------------------------ | ------------------------------ | ------------------------------ |
   | 1975                           | 15.1                           | 12.7                           | 5.1                            | 4.2                            | 0.098266                       |
   | 1976                           | 16.6                           | 13.2                           | 5.1                            | 4.1                            | 0.098266                       |
   | 1977                           | 17.4                           | 14.1                           | 5.1                            | 4.1                            | 0.098266                       |
   | 1978                           | 19.2                           | 13.7                           | 5.1                            | 4                              | 0.098266                       |
   | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) |
   | 2046                           | 63.7                           | 41.1                           | 5.6                            | 4.8                            | 0.121191                       |
   | 2047                           | 63.7                           | 41.1                           | 5.6                            | 4.8                            | 0.121191                       |
   | 2048                           | 63.7                           | 41.1                           | 5.6                            | 4.8                            | 0.121191                       |
   | 2049                           | 63.7                           | 41.1                           | 5.6                            | 4.8                            | 0.121191                       |
   | 2050                           | 63.7                           | 41.1                           | 5.6                            | 4.8                            | 0.121191                       |


#### User Input Parameters

1. **Light Truck Proportions (*LtTruckProp*)**: The proportion of household vehicles that are light trucks (SUVs, pickup trucks) as opposed to autos. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

   ```json
   {
       "NAME" : "LtTruckProp",
       "VALUE": "0.45",
       "TYPE" : "double",
       "UNITS" : "multiplier",
       "PROHIBIT" : "c('NA', '< 0')",
       "ISELEMENTOF" : ""
   }
   ```


#### Internal Module Inputs

| Package           | Module                                                  | Outputs          | Description                                                  |
| ----------------- | ------------------------------------------------------- | ---------------- | :----------------------------------------------------------- |
| VESimHouseholds   | [CreateHouseholds](#createhouseholds)                   | **HhId**         | Unique  household ID                                         |
| VESimHouseholds   | [CreateHouseholds](#createhouseholds)                   | **Age0to14**     | Persons in 0 to 14 year old age group                        |
| VESimHouseholds   | [CreateHouseholds](#createhouseholds)                   | **Age65Plus**    | Persons in 65 or older age group                             |
| VESimHouseholds   | [CreateHouseholds](#createhouseholds)                   | **HhSize**       | Number of  persons                                           |
| VESimHouseholds   | [CreateHouseholds](#createhouseholds)                   | **HhType**       | Coded household age composition (e.g. 2-1-0-2-0-0) or Grp for group  quarters |
| VESimHouseholds   | [PredictIncome](#predictincome)                         | **Income**       | Total annual household (non-qroup & group quarters) income in year  1999 dollars |
| VELandUse         | [CalculateFuturePlaceTypes](#calculatefutureplacetypes) | **DrvLevels**    | The number of people in a household who can drive classified in three  categories ("Drv1", "Drv2", "Drv3Plus") |
| VELandUse         | [CalculateFuturePlaceTypes](#calculatefutureplacetypes) | **HhPlaceTypes** | A place type as assigned to the households                   |
| VETransportSupply | [CreateBaseAccessibility](#createbaseaccessibility)     | **FwyLaneMiPC**  | Ratio of urbanized area freeway and expressway lane-miles to urbanized  area population |
| VETransportSupply | [CreateBaseAccessibility](#createbaseaccessibility)     | **TranRevMiPC**  | Transit revenue miles per capita for the region              |

#### Module Outputs

1. **VehId**: Unique vehicle ID
2. **Type**: Vehicle body type: Auto = automobile, LtTrk = light trucks (i.e. pickup, SUV, Van)
3. **Age**: Vehicle age in years
4. **Mileage**: Mileage of vehicles (automobiles and light truck)
5. **DvmtProp**: Proportion of average vehicle DVMT
6. **Vehicles**: Number of automobiles and light trucks owned or leased by the household
7. **NumLtTrk**: Number of light trucks (pickup, sport-utility vehicle, and van) owned or leased by household
8. **NumAuto**: Number of automobiles (i.e. 4-tire passenger vehicles that are not light trucks) owned or leased by household

[Top](#contents)										[Definitions](#definitions)								[Inputs/Outputs](#inputs-and-outputs)  

------

### AssignVehicleFeaturesFuture

This module is similar to [AssignVehicleFeatures](#assignvehiclefeatures), but uses model estimation of future year data on population and transportation supply as a basis of the calculations.

#### Internal Module Inputs

| Package           | Module                                                  | Outputs               | Description                                                  |
| ----------------- | ------------------------------------------------------- | --------------------- | ------------------------------------------------------------ |
| VESimHouseholds   | [CreateHouseholds](#createhouseholds)                   | **HhId**              | Unique  household ID                                         |
| VESimHouseholds   | [CreateHouseholds](#createhouseholds)                   | **Age0to14**          | Persons in 0 to 14 year old age group                        |
| VESimHouseholds   | [CreateHouseholds](#createhouseholds)                   | **Age65Plus**         | Persons in 65 or older age group                             |
| VESimHouseholds   | [CreateHouseholds](#createhouseholds)                   | **HhSize**            | Number of  persons                                           |
| VESimHouseholds   | [CreateHouseholds](#createhouseholds)                   | **HhType**            | Coded household age composition (e.g. 2-1-0-2-0-0) or Grp for group  quarters |
| VESimHouseholds   | [PredictIncome](#predictincome)                         | **Income**            | Total annual household (non-qroup & group quarters) income in year  1999 dollars |
| VELandUse         | [CalculateFuturePlaceTypes](#calculatefutureplacetypes) | **DrvLevels**         | The number of people in a household who can drive classified in three  categories ("Drv1", "Drv2", "Drv3Plus") |
| VELandUse         | [CalculateFuturePlaceTypes](#calculatefutureplacetypes) | **HhPlaceTypes**      | A place type as assigned to the households                   |
| VETransportSupply | [CreateFutureAccessibility](#createfutureaccessibility) | **FwyLaneMiPCFuture** | Ratio of urbanized area freeway and expressway lane-miles to urbanized  area population calculated using future (estimated) data |
| VETransportSupply | [CreateFutureAccessibility](#createfutureaccessibility) | **TranRevMiPCFuture** | Transit revenue miles per capita for the region calculated using future  (estimated) data |

#### Module Outputs

1. **VehIdFuture**: Unique vehicle ID
2. **TypeFuture**: Vehicle body type: Auto = automobile, LtTrk = light trucks (i.e. pickup, SUV, Van)
3. **AgeFuture**: Vehicle age in years
4. **MileageFuture**: Mileage of vehicles (automobiles and light truck)
5. **DvmtPropFuture**: Proportion of average vehicle DVMT
6. **VehiclesFuture**: Number of automobiles and light trucks owned or leased by the household
7. **NumLtTrkFuture**: Number of light trucks (pickup, sport-utility vehicle, and van) owned or leased by household
8. **NumAutoFuture**: Number of automobiles (i.e. 4-tire passenger vehicles that are not light trucks) owned or leased by household

	Top](#contents)										[Definitions](#definitions)								[Inputs/Outputs](#inputs-and-outputs)  

------

### CalculateTravelDemand

This module calculates the average daily vehicle miles traveled, auto and transit trips for each household is modeled based on household information determined by previous modules for the base conditions. The model is sensitive to household income, population density of the neighborhood where the household resides, number of household vehicles, whether the household owns no vehicles, the levels of public transportation and freeway supplies in the region, the driving age population in the household, the presence of persons over age 65, and whether the neighborhood is characterized by mixed-use development.
It also calculates truck and bus Vehicle Miles Traveled (VMT). Regional truck VMT is calculated based on changes in the regional household income. As a default, a one-to-one relationship between regional income growth and truck VMT growth is assumed. In other words, a doubling of total regional income would result in a doubling of truck VMT. Bus VMT is calculated from bus revenue miles that are factored up to total vehicle miles to account for miles driven in non-revenue service.

#### User Input Files

1. **Emission Rate (*model_fuel_co2.csv*)**: The emissions rate file contains information on “pump-to-wheels” CO2 equivalent emissions by fuel type in grams per mega Joule of fuel energy content. There is one row for each fuel type: ULSD, biodiesel, RFG (reformulated gasoline), CARBOB (gasoline formulated to be blended with ethanol), ethanol, and CNG. Electricity is an optional fuel type not displayed in the table. If the intensity for power generation is known then that can be entered at the end of the row with the Fuel column containing the word *Electricity* and the respective value next to it. This file is used to convert fuel use to CO2 equivalent emissions.
   Here is a snapshot of the file:

   | Fuel      | Intensity |
   | --------- | --------- |
   | ULSD      | 77.19     |
   | Biodiesel | 76.81     |
   | RFG       | 75.65     |
   | CARBOB    | 75.65     |
   | Ethanol   | 74.88     |
   | Cng       | 62.14     |

2. **Vehicle VMT proportion by fuel (*model_fuel_prop_by_veh.csv*)**: The file contains allocation of VMT for each of the four road vehicle types that VERPAT represents (*auto*, *light truck*, *bus*, and *heavy truck*) to different fuel types (*Diesel*, *CNG*, *Gasoline*). This file is used in the calculations of fuel consumption. This file can be used to test alternative fuel scenarios by varying the shares of non-gasoline fuels.

   - **PropDiesel**: The proportion of the fleet that uses diesel
   - **PropCng**: The proportion of the fleet that uses CNG
   - **PropGas**: The proportion of the fleet that uses gasoline

   Here is a snapshot of the file:

   | VehType | PropDiesel | PropCng | PropGas |
   | ------- | ---------- | ------- | ------- |
   | Auto    | 0.007      | 0       | 0.993   |
   | LtTruck | 0.04       | 0       | 0.96    |
   | Bus     | 0.995      | 0.005   | 0       |
   | Truck   | 0.945      | 0.005   | 0.05    |

3. **Fuel composition (*model_fuel_composition_prop.csv*)**: This file contains the composition of fuel used for each of the four road vehicle types that VERPAT represents (*auto*, *light truck*, *bus*, and *heavy truck*). This file is also used in the calculations of fuel consumption along with the aforementioned file. The column labels in the file are:

   - **GasPropEth**: The average ethanol proportion in gasoline sold
   - **DieselPropBio**: The average biodiesel proportion in diesel sold

   Here is a snapshot of the file:

   | VehType | GasPropEth | DieselPropBio |
   | ------- | ---------- | ------------- |
   | Auto    | 0.1        | 0.05          |
   | LtTruck | 0.1        | 0.05          |
   | Bus     | 0.1        | 0.05          |
   | Truck   | 0.1        | 0.01          |


4. **Truck and bus vmt (*region_truck_bus_vmt.csv*)**: This file contains the region’s proportion of VMT by truck and bus as well as the distribution of that VMT across functional classes (*freeway*, *arterial*, *other*). The file includes one row for bus VMT data and one row for Truck VMT data. It should be noted that it is not necessary to enter values in the **PropVmt** column for **BusVmt** as this is calculated using the values in the ***transportation_supply.csv*** user input file. The truck VMT proportion (PropVMT column, TruckVMT row) can be obtained from [Highway Performance Monitoring System](http://www.fhwa.dot.gov/policyinformation/hpms.cfm) data and local sources or the regional travel demand model if one exists.
   The proportions of VMT by functional class can be derived from the Federal Highway Cost Allocation Study and data from transit operators. The Federal Highway Cost Allocation Study (Table II-6, 1997 Federal Highway Cost Allocation Study Final Report, [Chapter II](http://www.fhwa.dot.gov/policy/hcas/final/two.cfm) is used to calculate the average proportion of truck VMT by functional class. Data from transit authorities are used to calculate the proportions of bus VMT by urban area functional class.
   Here is a snapshot of the file:

   | Type     | PropVmt | Fwy      | Art      | Other    |
   | -------- | ------- | -------- | -------- | -------- |
   | BusVmt   | 0       | 0.15     | 0.591854 | 0.258146 |
   | TruckVmt | 0.08    | 0.452028 | 0.398645 | 0.149327 |

5. **Plugin hybrid electric vehicles characteristics (*model_phev_range_prop_mpg_mpkwh.csv*)**: This file contains the estimates and forecasts of range, fuel efficiency (mpg), power efficiency (mpkwh), and proportions of automobiles and light trucks that are plugin hybrid electric vehicles by vehicle model year. Note that this is not the fleet average for that year. It is the average of new vehicles sold in that year. This file is used in identification of plugin hybrid electric and electric vehicles. Here is a snapshot of the file:

   | ModelYear                      | AutoPhevRange                  | AutoPropPhev                   | AutoMpkwh                      | AutoMpg                        | LtTruckPhevRange               | LtTruckPropPhev | LtTruckMpkwh | LtTruckMpg |
   | ------------------------------ | ------------------------------ | ------------------------------ | ------------------------------ | ------------------------------ | ------------------------------ | --------------- | ------------ | ---------- |
   | 1975                           | 0                              | 0                              | 0                              | 0                              | 0                              | 0               | 0            | 0          |
   | 1976                           | 0                              | 0                              | 0                              | 0                              | 0                              | 0               | 0            | 0          |
   | 1977                           | 0                              | 0                              | 0                              | 0                              | 0                              | 0               | 0            | 0          |
   | 1978                           | 0                              | 0                              | 0                              | 0                              | 0                              | 0               | 0            | 0          |
   | 1979                           | 0                              | 0                              | 0                              | 0                              | 0                              | 0               | 0            | 0          |
   | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) |                 |              |            |
   | 2045                           | 40                             | 0.66                           | 4.375                          | 74.5                           | 40                             | 0.586666667     | 2.875        | 58.2       |
   | 2046                           | 40                             | 0.708                          | 4.4                            | 74.9                           | 40                             | 0.629333333     | 2.9          | 58.5       |
   | 2047                           | 40                             | 0.756                          | 4.425                          | 75.3                           | 40                             | 0.672           | 2.925        | 58.8       |
   | 2048                           | 40                             | 0.816                          | 4.45                           | 75.6                           | 40                             | 0.725333333     | 2.95         | 59.1       |
   | 2049                           | 40                             | 0.864                          | 4.475                          | 76                             | 40                             | 0.768           | 2.975        | 59.3       |
   | 2050                           | 40                             | 0.9                            | 4.5                            | 76.4                           | 40                             |                 |              |            |

6. **Hybrid electric vehicles characteristics (*model_hev_prop_mpg.csv*)**: This file contains the estimates and forecasts of fuel efficiency (mpg), and proportions of automobiles and light trucks that are hybrid electric vehicles (that are neither plugin hybrid nor electric vehicle) by vehicle model year. Note that this is not the fleet average for that year. It is the average of new vehicles sold in that year. This file is used in identification of hybrid electric that are not plugin hybrid or electric vehicles. Here is a snapshot of the file:

   | ModelYear                      | AutoPropHev                    | AutoHevMpg                     | LtTruckPropHev                 | LtTruckHevMpg                  |
   | ------------------------------ | ------------------------------ | ------------------------------ | ------------------------------ | ------------------------------ |
   | 1975                           | 0                              | 0                              | 0                              | 0                              |
   | 1976                           | 0                              | 0                              | 0                              | 0                              |
   | 1977                           | 0                              | 0                              | 0                              | 0                              |
   | 1978                           | 0                              | 0                              | 0                              | 0                              |
   | 1979                           | 0                              | 0                              | 0                              | 0                              |
   | 1980                           | 0                              | 0                              | 0                              | 0                              |
   | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) |
   | 2046                           | 0.981481481                    | 74.2                           | 0.736111111                    | 55.4                           |
   | 2047                           | 0.981481481                    | 74.5                           | 0.736111111                    | 55.6                           |
   | 2048                           | 1                              | 74.9                           | 0.75                           | 55.9                           |
   | 2049                           | 1                              | 75.2                           | 0.75                           | 56.1                           |
   | 2050                           | 1                              | 75.5                           | 0.75                           | 56.3                           |

7. **Electric vehicles characteristics (*model_ev_range_prop_mpkwh.csv*)**: This file contains the estimates and forecasts of range, power efficiency (mpkwh), and proportions of automobiles and light trucks that are electric vehicles by vehicle model year. Note that this is not the fleet average for that year. It is the average of new vehicles sold in that year. This file is used in identification of electric vehicles. Here is a snapshot of the file:

   | ModelYear                      | AutoRange                      | AutoPropEv                     | AutoMpkwh                      | LtTruckRange                   | LtTruckPropEv                  | LtTruckMpkwh |
   | ------------------------------ | ------------------------------ | ------------------------------ | ------------------------------ | ------------------------------ | ------------------------------ | ------------ |
   | 1975                           | 0                              | 0                              | 0                              | 0                              | 0                              | 0            |
   | 1976                           | 0                              | 0                              | 0                              | 0                              | 0                              | 0            |
   | 1977                           | 0                              | 0                              | 0                              | 0                              | 0                              | 0            |
   | 1978                           | 0                              | 0                              | 0                              | 0                              | 0                              | 0            |
   | 1979                           | 0                              | 0                              | 0                              | 0                              | 0                              | 0            |
   | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) |              |
   | 2046                           | 277.5                          | 0.72                           | 4.4                            | 185                            | 0.56                           | 2.9          |
   | 2047                           | 283.125                        | 0.75                           | 4.425                          | 188.75                         | 0.583333333                    | 2.925        |
   | 2048                           | 288.75                         | 0.795                          | 4.45                           | 192.5                          | 0.618333333                    | 2.95         |
   | 2049                           | 294.375                        | 0.855                          | 4.475                          | 196.25                         | 0.665                          | 2.975        |
   | 2050                           | 300                            | 0.9                            | 4.5                            | 200                            | 0.7                            | 3            |

#### User Input Parameters

1. **Base cost per mile (*BaseCostPerMile*)**: Base cost per mile in dollars for transportation costs used in the travel demand model to initially represent travel as close to unconstrained by transportation costs. The transportation costs are then fully constrained later in the model as travel reductions caused by budget constraints are estimated. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

   ```json
   {
       "NAME" : "BaseCostPerMile",
       "VALUE": "0.04",
       "TYPE" : "compound",
       "UNITS" : "USD/MI",
       "PROHIBIT" : "c('NA', '< 0')",
       "ISELEMENTOF" : ""
   }
   ```

2. **Dvmt budget proportion (*DvmtBudgetProp*)**: The proportion of household budget that can be allocated to transportation spending. The travel demand models includes a constraint that reduces household travel if too high a proportion of household spending is spent on transportation. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

   ```json
   {
       "NAME" : "DvmtBudgetProp",
       "VALUE": "0.1",
       "TYPE" : "double",
       "UNITS" : "multiplier",
       "PROHIBIT" : "c('NA', '< 0', '> 1')",
       "ISELEMENTOF" : ""
   }
   ```

3. **Annual vmt inflator (*AnnVmtInflator*)**: Factor to convert VMT between annual and average daily amounts. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

   ```json
   {
       "NAME" : "AnnVmtInflator",
       "VALUE": "365",
       "TYPE" : "integer",
       "UNITS" : "DAYS",
       "PROHIBIT" : "c('NA', '< 0')",
       "ISELEMENTOF" : ""
   }
   ```

4. **Fuel cost (*FuelCost*)**: Average cost per gallon of fuel (before taxes are added). It should be defined in [model_parameters.json](#model_parametersjson) as follows:

   ```json
   {
       "NAME" : "FuelCost",
       "VALUE": "1.82",
       "TYPE" : "compound",
       "UNITS" : "USD/GAL",
       "PROHIBIT" : "c('NA', '< 0')",
       "ISELEMENTOF" : ""
   }
   ```

5. **Power cost (*KwhCost*)**: Average cost per kwh of power consumption (before taxes are added). It should be defined in [model_parameters.json](#model_parametersjson) as follows:

   ```json
   {
       "NAME" : "KwhCost",
       "VALUE": "0.257",
       "TYPE" : "compound",
       "UNITS" : "USD/KWH",
       "PROHIBIT" : "c('NA', '< 0')",
       "ISELEMENTOF" : ""
   }
   ```

6. **Gas tax (*GasTax*)**: Average cost per gallon of fuel of gas taxes. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

   ```json
   {
       "NAME" : "GasTax",
       "VALUE": "0.424",
       "TYPE" : "compound",
       "UNITS" : "USD/GAL",
       "PROHIBIT" : "c('NA', '< 0')",
       "ISELEMENTOF" : ""
   }
   ```

7. **Light vehicle dvmt (*BaseLtVehDvmt*)**: Total light vehicle daily VMT for the base year in thousands of miles. This data can be derived from a combination of [Highway Performance Monitoring System](http://www.fhwa.dot.gov/policyinformation/hpms.cfm) data, Federal Highway Cost Allocation Study data, and regional data. Light vehicle daily VMT can be estimated by subtracting truck and bus VMT from total VMT provided in the Highway Performance Monitoring System (HPMS). Regional travel demand model outputs can also be used to derive these data. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

   ```json
   {
       "NAME" : "BaseLtVehDvmt",
       "VALUE": "27244",
       "TYPE" : "compound",
       "UNITS" : "MI/DAY",
       "PROHIBIT" : "c('NA', '< 0')",
       "ISELEMENTOF" : ""
   }
   ```

8. **Dvmt proportion by functional class (*BaseFwyArtProp*)**: The proportions of daily VMT for light vehicles that takes place on freeways and arterials (i.e., the remainder of VMT takes place on lower functional class roads for the base year. This data can be derived from a combination of [Highway Performance Monitoring System](http://www.fhwa.dot.gov/policyinformation/hpms.cfm) data, Federal Highway Cost Allocation Study data, and regional data. The proportions of light vehicle daily VMT on freeways and arterials can be derived from the HPMS data. Regional travel demand model outputs can also be used to derive these data. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

   ```json
   {
       "NAME" : "BaseFwyArtProp",
       "VALUE": "0.77",
       "TYPE" : "double",
       "UNITS" : "proportion",
       "PROHIBIT" : "c('NA', '< 0', '> 1')",
       "ISELEMENTOF" : ""
   }
   ```

9. **Truck vmt growth multiplier (*TruckVmtGrowthMultiplier*)**: Rate at which heavy truck VMT growth in relation to total regional household income growth in the region. A value of 1 indicates that heavy truck VMT grows at the same rate as total regional household income. A value less than 1 means slower growth in truck VMT, and greater than 1 means faster growth in truck VMT than total regional household income. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

   ```json
   {
       "NAME" : "TruckVmtGrowthMultiplier",
       "VALUE": "1",
       "TYPE" : "double",
       "UNITS" : "multiplier",
       "PROHIBIT" : "c('NA', '< 0')",
       "ISELEMENTOF" : ""
   }
   ```

#### Fixed Input Parameters

1. **Carbon cost (*CarbonCost*)**: Average cost of green house gas emissions. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

   ```json
   {
       "NAME" : "CarbonCost",
       "VALUE": "0",
       "TYPE" : "compound",
       "UNITS" : "USD/GAL",
       "PROHIBIT" : "c('NA', '< 0')",
       "ISELEMENTOF" : ""
   }
   ```

2. **Vmt cost (*VmtCost*)**: Average cost of vehicle miles traveled. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

   ```json
   {
       "NAME" : "VmtCost",
       "VALUE": "0",
       "TYPE" : "compound",
       "UNITS" : "USD/GAL",
       "PROHIBIT" : "c('NA', '< 0')",
       "ISELEMENTOF" : ""
   }
   ```

#### Internal Module Inputs

| Package             | Module                                                  | Outputs          | Description                                                  |
| ------------------- | ------------------------------------------------------- | ---------------- | ------------------------------------------------------------ |
| VESimHouseholds     | [CreateHouseholds](#createhouseholds)                   | **HhId**         | Unique household ID                                          |
| VESimHouseholds     | [CreateHouseholds](#createhouseholds)                   | **HhSize**       | Number of persons                                            |
| VESimHouseholds     | [CreateHouseholds](#createhouseholds)                   | **Age0to14**     | Persons in 0 to 14 year old age group                        |
| VESimHouseholds     | [CreateHouseholds](#createhouseholds)                   | **Age15to19**    | Persons in 15 to 19 year old age group                       |
| VESimHouseholds     | [CreateHouseholds](#createhouseholds)                   | **Age20to29**    | Persons in 20 to 29 year old age group                       |
| VESimHouseholds     | [CreateHouseholds](#createhouseholds)                   | **Age30to54**    | Persons in 30 to 54 year old age group                       |
| VESimHouseholds     | [CreateHouseholds](#createhouseholds)                   | **Age55to64**    | Persons in 55 to 64 year old age group                       |
| VESimHouseholds     | [CreateHouseholds](#createhouseholds)                   | **Age65Plus**    | Persons in 65 or older age group                             |
| VESimHouseholds     | [PredictIncome](#predictincome)                         | **Income**       | Total annual household (non-qroup & group quarters) income in year  1999 dollars |
| VELandUse           | [CalculateBasePlaceTypes](#calculatebaseplacetypes)     | **UrbanIncome**  | Total income by place types                                  |
| VELandUse           | [CalculateFuturePlaceTypes](#calculatefutureplacetypes) | **HhPlaceTypes** | A place type as assigned to the households                   |
| VELandUse           | [CalculateFuturePlaceTypes](#calculatefutureplacetypes) | **UrbanIncome**  | Total income by place types                                  |
| VETransportSupply   | [CreateBaseAccessibility](#createbaseaccessibility)     | **FwyLaneMiPC**  | Ratio of urbanized area freeway and expressway lane-miles to urbanized  area population |
| VETransportSupply   | [CreateBaseAccessibility](#createbaseaccessibility)     | **TranRevMiPC**  | Transit revenue miles per capita for the region              |
| VEHouseholdVehicles | [AssignVehicleFeatures](#assignvehiclefeatures)         | **VehId**        | Unique vehicle ID                                            |
| VEHouseholdVehicles | [AssignVehicleFeatures](#assignvehiclefeatures)         | **Type**         | Vehicle body type: Auto = automobile, LtTrk = light trucks (i.e. pickup,  SUV, Van) |
| VEHouseholdVehicles | [AssignVehicleFeatures](#assignvehiclefeatures)         | **Mileage**      | Mileage of vehicles (automobiles and light truck)            |
| VEHouseholdVehicles | [AssignVehicleFeatures](#assignvehiclefeatures)         | **DvmtProp**     | Proportion of average vehicle DVMT                           |
| VEHouseholdVehicles | [AssignVehicleFeatures](#assignvehiclefeatures)         | **Vehicles**     | Number of automobiles and light trucks owned or leased by the household |
| VEHouseholdVehicles | [AssignVehicleFeatures](#assignvehiclefeatures)         | **Age**          | Age of the vehicles                                          |

#### Module Outputs

1. **TruckDvmt**: Average daily vehicle miles traveled by trucks
2. **Dvmt (bzones)**: Average daily vehicle miles traveled by place types
3. **Dvmt (households)**: Average daily vehicle miles traveled by household
4. **Dvmt (vehicles)**: Average daily vehicle miles traveled by each vehicle
5. **EvDvmt (bzones)**: Average daily electric vehicle miles traveled by place types
6. **EvDvmt (vehicles)**: Average daily electric vehicle miles traveled by each vehicle
7. **HcDvmt (bzones)**: Average daily vehicle (ICE) miles traveled by place types
8. **HcDvmt (vehicles)**: Average daily vehicle (ICE) miles traveled by each vehicle
9. **FuelGallons**: Average daily fuel consumption in gallons by each household
10. **FuelCo2e**: Average daily Co2 equivalent greenhouse gas emissions by each household due to traditional fuel consumption
11. **ElecKwh**: Average daily power consumption in kilowatt-hours by each household
12. **ElecCo2e**: Average daily Co2 equivalent greenhouse gas emissions by each household due to power consumption
13. **MpKwh**: Power efficiency of electric vehicles by each vehicle
14. **Powertrain**: Powertrain of each vehicle.
15. **DailyParkingCost**: Average daily parking cost by each household
16. **FutureCostPerMile**: Total cost per mile for future year for each household


[Top](#contents)										[Definitions](#definitions)								[Inputs/Outputs](#inputs-and-outputs)  

------

### CalculateTravelDemandFuture

This module is similar to [CalculateTravelDemand](#calculatetraveldemand) module but uses future year (estimated) data for transportation supply and for vehicles like number of vehicles, mileage, type, etc.

#### User Input Files

1. **Emission Rate (*model_fuel_co2.csv*)**: The emissions rate file contains information on “pump-to-wheels” CO2 equivalent emissions by fuel type in grams per mega Joule of fuel energy content. There is one row for each fuel type: ULSD, biodiesel, RFG (reformulated gasoline), CARBOB (gasoline formulated to be blended with ethanol), ethanol, and CNG. This file is used to convert fuel use to CO2 equivalent emissions.
   Here is a snapshot of the file:

   | Fuel      | Intensity |
   | --------- | --------- |
   | ULSD      | 77.19     |
   | Biodiesel | 76.81     |
   | RFG       | 75.65     |
   | CARBOB    | 75.65     |
   | Ethanol   | 74.88     |
   | Cng       | 62.14     |

2. **Vehicle VMT proportion by fuel (*model_fuel_prop_by_veh.csv*)**: The file contains allocation of VMT for each of the four road vehicle types that VERPAT represents (*auto*, *light truck*, *bus*, and *heavy truck*) to different fuel types (*Diesel*, *CNG*, *Gasoline*). This file is used in the calculations of fuel consumption. This file can be used to test alternative fuel scenarios by varying the shares of non-gasoline fuels.

   - **PropDiesel**: The proportion of the fleet that uses diesel
   - **PropCng**: The proportion of the fleet that uses CNG
   - **PropGas**: The proportion of the fleet that uses gasoline

   Here is a snapshot of the file:

   | VehType | PropDiesel | PropCng | PropGas |
   | ------- | ---------- | ------- | ------- |
   | Auto    | 0.007      | 0       | 0.993   |
   | LtTruck | 0.04       | 0       | 0.96    |
   | Bus     | 0.995      | 0.005   | 0       |
   | Truck   | 0.945      | 0.005   | 0.05    |

3. **Fuel composition (*model_fuel_composition_prop.csv*)**: This file contains the composition of fuel used for each of the four road vehicle types that VERPAT represents (*auto*, *light truck*, *bus*, and *heavy truck*). This file is also used in the calculations of fuel consumption along with the aforementioned file. The column labels in the file are:

   - **GasPropEth**: The average ethanol proportion in gasoline sold
   - **DieselPropBio**: The average biodiesel proportion in diesel sold

   Here is a snapshot of the file:

   | VehType | GasPropEth | DieselPropBio |
   | ------- | ---------- | ------------- |
   | Auto    | 0.1        | 0.05          |
   | LtTruck | 0.1        | 0.05          |
   | Bus     | 0.1        | 0.05          |
   | Truck   | 0.1        | 0.01          |

4. **Truck and bus vmt (*region_truck_bus_vmt.csv*)**: This file contains the region’s proportion of VMT by truck and bus as well as the distribution of that VMT across functional classes (*freeway*, *arterial*, *other*). The file includes one row for bus VMT data and one row for Truck VMT data. It should be noted that it is not necessary to enter values in the **PropVmt** column for **BusVmt** as this is calculated using the values in the ***transportation_supply.csv*** user input file. The truck VMT proportion (PropVMT column, TruckVMT row) can be obtained from [Highway Performance Monitoring System](http://www.fhwa.dot.gov/policyinformation/hpms.cfm) data and local sources or the regional travel demand model if one exists.
   The proportions of VMT by functional class can be derived from the Federal Highway Cost Allocation Study and data from transit operators. The Federal Highway Cost Allocation Study (Table II-6, 1997 Federal Highway Cost Allocation Study Final Report, [Chapter II](http://www.fhwa.dot.gov/policy/hcas/final/two.cfm) is used to calculate the average proportion of truck VMT by functional class. Data from transit authorities are used to calculate the proportions of bus VMT by urban area functional class.
   Here is a snapshot of the file:

   | Type     | PropVmt | Fwy      | Art      | Other    |
   | -------- | ------- | -------- | -------- | -------- |
   | BusVmt   | 0       | 0.15     | 0.591854 | 0.258146 |
   | TruckVmt | 0.08    | 0.452028 | 0.398645 | 0.149327 |

5. **Plugin hybrid electric vehicles characteristics (*model_phev_range_prop_mpg_mpkwh.csv*)**: This file contains the estimates and forecasts of range, fuel efficiency (mpg), power efficiency (mpkwh), and proportions of automobiles and light trucks that are plugin hybrid electric vehicles by vehicle model year. Note that this is not the fleet average for that year. It is the average of new vehicles sold in that year. This file is used in identification of plugin hybrid electric and electric vehicles. Here is a snapshot of the file:

   | ModelYear                      | AutoPhevRange                  | AutoPropPhev                   | AutoMpkwh                      | AutoMpg                        | LtTruckPhevRange               | LtTruckPropPhev | LtTruckMpkwh | LtTruckMpg |
   | ------------------------------ | ------------------------------ | ------------------------------ | ------------------------------ | ------------------------------ | ------------------------------ | --------------- | ------------ | ---------- |
   | 1975                           | 0                              | 0                              | 0                              | 0                              | 0                              | 0               | 0            | 0          |
   | 1976                           | 0                              | 0                              | 0                              | 0                              | 0                              | 0               | 0            | 0          |
   | 1977                           | 0                              | 0                              | 0                              | 0                              | 0                              | 0               | 0            | 0          |
   | 1978                           | 0                              | 0                              | 0                              | 0                              | 0                              | 0               | 0            | 0          |
   | 1979                           | 0                              | 0                              | 0                              | 0                              | 0                              | 0               | 0            | 0          |
   | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) |                 |              |            |
   | 2045                           | 40                             | 0.66                           | 4.375                          | 74.5                           | 40                             | 0.586666667     | 2.875        | 58.2       |
   | 2046                           | 40                             | 0.708                          | 4.4                            | 74.9                           | 40                             | 0.629333333     | 2.9          | 58.5       |
   | 2047                           | 40                             | 0.756                          | 4.425                          | 75.3                           | 40                             | 0.672           | 2.925        | 58.8       |
   | 2048                           | 40                             | 0.816                          | 4.45                           | 75.6                           | 40                             | 0.725333333     | 2.95         | 59.1       |
   | 2049                           | 40                             | 0.864                          | 4.475                          | 76                             | 40                             | 0.768           | 2.975        | 59.3       |
   | 2050                           | 40                             | 0.9                            | 4.5                            | 76.4                           | 40                             |                 |              |            |

6. **Hybrid electric vehicles characteristics (*model_hev_prop_mpg.csv*)**: This file contains the estimates and forecasts of fuel efficiency (mpg), and proportions of automobiles and light trucks that are hybrid electric vehicles (that are neither plugin hybrid nor electric vehicle) by vehicle model year. Note that this is not the fleet average for that year. It is the average of new vehicles sold in that year. This file is used in identification of hybrid electric that are not plugin hybrid or electric vehicles. Here is a snapshot of the file:

   | ModelYear                      | AutoPropHev                    | AutoHevMpg                     | LtTruckPropHev                 | LtTruckHevMpg                  |
   | ------------------------------ | ------------------------------ | ------------------------------ | ------------------------------ | ------------------------------ |
   | 1975                           | 0                              | 0                              | 0                              | 0                              |
   | 1976                           | 0                              | 0                              | 0                              | 0                              |
   | 1977                           | 0                              | 0                              | 0                              | 0                              |
   | 1978                           | 0                              | 0                              | 0                              | 0                              |
   | 1979                           | 0                              | 0                              | 0                              | 0                              |
   | 1980                           | 0                              | 0                              | 0                              | 0                              |
   | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) |
   | 2046                           | 0.981481481                    | 74.2                           | 0.736111111                    | 55.4                           |
   | 2047                           | 0.981481481                    | 74.5                           | 0.736111111                    | 55.6                           |
   | 2048                           | 1                              | 74.9                           | 0.75                           | 55.9                           |
   | 2049                           | 1                              | 75.2                           | 0.75                           | 56.1                           |
   | 2050                           | 1                              | 75.5                           | 0.75                           | 56.3                           |

7. **Electric vehicles characteristics (*model_ev_range_prop_mpkwh.csv*)**: This file contains the estimates and forecasts of range, power efficiency (mpkwh), and proportions of automobiles and light trucks that are electric vehicles by vehicle model year. Note that this is not the fleet average for that year. It is the average of new vehicles sold in that year. This file is used in identification of electric vehicles. Here is a snapshot of the file:

   | ModelYear                      | AutoRange                      | AutoPropEv                     | AutoMpkwh                      | LtTruckRange                   | LtTruckPropEv                  | LtTruckMpkwh |
   | ------------------------------ | ------------------------------ | ------------------------------ | ------------------------------ | ------------------------------ | ------------------------------ | ------------ |
   | 1975                           | 0                              | 0                              | 0                              | 0                              | 0                              | 0            |
   | 1976                           | 0                              | 0                              | 0                              | 0                              | 0                              | 0            |
   | 1977                           | 0                              | 0                              | 0                              | 0                              | 0                              | 0            |
   | 1978                           | 0                              | 0                              | 0                              | 0                              | 0                              | 0            |
   | 1979                           | 0                              | 0                              | 0                              | 0                              | 0                              | 0            |
   | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) | ![](./VERPAT_images/vdots.gif) |              |
   | 2046                           | 277.5                          | 0.72                           | 4.4                            | 185                            | 0.56                           | 2.9          |
   | 2047                           | 283.125                        | 0.75                           | 4.425                          | 188.75                         | 0.583333333                    | 2.925        |
   | 2048                           | 288.75                         | 0.795                          | 4.45                           | 192.5                          | 0.618333333                    | 2.95         |
   | 2049                           | 294.375                        | 0.855                          | 4.475                          | 196.25                         | 0.665                          | 2.975        |
   | 2050                           | 300                            | 0.9                            | 4.5                            | 200                            | 0.7                            | 3            |

#### User Input Parameters

1. **Base cost per mile (*BaseCostPerMile*)**: Base cost per mile in dollars for transportation costs used in the travel demand model to initially represent travel as close to unconstrained by transportation costs. The transportation costs are then fully constrained later in the model as travel reductions caused by budget constraints are estimated. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

   ```json
   {
       "NAME" : "BaseCostPerMile",
       "VALUE": "0.04",
       "TYPE" : "compound",
       "UNITS" : "USD/MI",
       "PROHIBIT" : "c('NA', '< 0')",
       "ISELEMENTOF" : ""
   }
   ```

2. **Dvmt budget proportion (*DvmtBudgetProp*)**: The proportion of household budget that can be allocated to transportation spending. The travel demand models includes a constraint that reduces household travel if too high a proportion of household spending is spent on transportation. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

   ```json
   {
       "NAME" : "DvmtBudgetProp",
       "VALUE": "0.1",
       "TYPE" : "double",
       "UNITS" : "multiplier",
       "PROHIBIT" : "c('NA', '< 0', '> 1')",
       "ISELEMENTOF" : ""
   }
   ```

3. **Annual vmt inflator (*AnnVmtInflator*)**: Factor to convert VMT between annual and average daily amounts. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

   ```json
   {
       "NAME" : "AnnVmtInflator",
       "VALUE": "365",
       "TYPE" : "integer",
       "UNITS" : "DAYS",
       "PROHIBIT" : "c('NA', '< 0')",
       "ISELEMENTOF" : ""
   }
   ```

4. **Fuel cost (*FuelCost*)**: Average cost per gallon of fuel (before taxes are added). It should be defined in [model_parameters.json](#model_parametersjson) as follows:

   ```json
   {
       "NAME" : "FuelCost",
       "VALUE": "1.82",
       "TYPE" : "compound",
       "UNITS" : "USD/GAL",
       "PROHIBIT" : "c('NA', '< 0')",
       "ISELEMENTOF" : ""
   }
   ```

5. **Power cost (*KwhCost*)**: Average cost per kwh of power consumption (before taxes are added). It should be defined in [model_parameters.json](#model_parametersjson) as follows:

   ```json
   {
       "NAME" : "KwhCost",
       "VALUE": "0.257",
       "TYPE" : "compound",
       "UNITS" : "USD/KWH",
       "PROHIBIT" : "c('NA', '< 0')",
       "ISELEMENTOF" : ""
   }
   ```

6. **Gas tax (*GasTax*)**: Average cost per gallon of fuel of gas taxes. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

   ```json
   {
       "NAME" : "GasTax",
       "VALUE": "0.424",
       "TYPE" : "compound",
       "UNITS" : "USD/GAL",
       "PROHIBIT" : "c('NA', '< 0')",
       "ISELEMENTOF" : ""
   }
   ```

7. **Light vehicle dvmt (*BaseLtVehDvmt*)**: Total light vehicle daily VMT for the base year in thousands of miles. This data can be derived from a combination of [Highway Performance Monitoring System](http://www.fhwa.dot.gov/policyinformation/hpms.cfm) data, Federal Highway Cost Allocation Study data, and regional data. Light vehicle daily VMT can be estimated by subtracting truck and bus VMT from total VMT provided in the Highway Performance Monitoring System (HPMS). Regional travel demand model outputs can also be used to derive these data. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

   ```json
   {
       "NAME" : "BaseLtVehDvmt",
       "VALUE": "27244",
       "TYPE" : "compound",
       "UNITS" : "MI/DAY",
       "PROHIBIT" : "c('NA', '< 0')",
       "ISELEMENTOF" : ""
   }
   ```

8. **Dvmt proportion by functional class (*BaseFwyArtProp*)**: The proportions of daily VMT for light vehicles that takes place on freeways and arterials (i.e., the remainder of VMT takes place on lower functional class roads for the base year. This data can be derived from a combination of [Highway Performance Monitoring System](http://www.fhwa.dot.gov/policyinformation/hpms.cfm) data, Federal Highway Cost Allocation Study data, and regional data. The proportions of light vehicle daily VMT on freeways and arterials can be derived from the HPMS data. Regional travel demand model outputs can also be used to derive these data. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

   ```json
   {
       "NAME" : "BaseFwyArtProp",
       "VALUE": "0.77",
       "TYPE" : "double",
       "UNITS" : "proportion",
       "PROHIBIT" : "c('NA', '< 0', '> 1')",
       "ISELEMENTOF" : ""
   }
   ```

9. **Truck vmt growth multiplier (*TruckVmtGrowthMultiplier*)**: Rate at which heavy truck VMT growth in relation to total regional household income growth in the region. A value of 1 indicates that heavy truck VMT grows at the same rate as total regional household income. A value less than 1 means slower growth in truck VMT, and greater than 1 means faster growth in truck VMT than total regional household income. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

   ```json
   {
       "NAME" : "TruckVmtGrowthMultiplier",
       "VALUE": "1",
       "TYPE" : "double",
       "UNITS" : "multiplier",
       "PROHIBIT" : "c('NA', '< 0')",
       "ISELEMENTOF" : ""
   }
   ```

#### Fixed Input Parameters

1. **Carbon cost (*CarbonCost*)**: Average cost of green house gas emissions. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

   ```json
   {
       "NAME" : "CarbonCost",
       "VALUE": "0",
       "TYPE" : "compound",
       "UNITS" : "USD/GAL",
       "PROHIBIT" : "c('NA', '< 0')",
       "ISELEMENTOF" : ""
   }
   ```

2. **Vmt cost (*VmtCost*)**: Average cost of vehicle miles traveled. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

   ```json
   {
       "NAME" : "VmtCost",
       "VALUE": "0",
       "TYPE" : "compound",
       "UNITS" : "USD/GAL",
       "PROHIBIT" : "c('NA', '< 0')",
       "ISELEMENTOF" : ""
   }
   ```

#### Internal Module Inputs

| Package             | Module                                                      | Outputs               | Description                                                  |
| ------------------- | ----------------------------------------------------------- | --------------------- | ------------------------------------------------------------ |
| VESimHouseholds     | [CreateHouseholds](#createhouseholds)                       | **HhId**              | Unique household ID                                          |
| VESimHouseholds     | [CreateHouseholds](#createhouseholds)                       | **HhSize**            | Number of persons                                            |
| VESimHouseholds     | [CreateHouseholds](#createhouseholds)                       | **Age0to14**          | Persons in 0 to 14 year old age group                        |
| VESimHouseholds     | [CreateHouseholds](#createhouseholds)                       | **Age15to19**         | Persons in 15 to 19 year old age group                       |
| VESimHouseholds     | [CreateHouseholds](#createhouseholds)                       | **Age20to29**         | Persons in 20 to 29 year old age group                       |
| VESimHouseholds     | [CreateHouseholds](#createhouseholds)                       | **Age30to54**         | Persons in 30 to 54 year old age group                       |
| VESimHouseholds     | [CreateHouseholds](#createhouseholds)                       | **Age55to64**         | Persons in 55 to 64 year old age group                       |
| VESimHouseholds     | [CreateHouseholds](#createhouseholds)                       | **Age65Plus**         | Persons in 65 or older age group                             |
| VESimHouseholds     | [PredictIncome](#predictincome)                             | **Income**            | Total annual household (non-qroup & group quarters) income in year  1999 dollars |
| VELandUse           | [CalculateBasePlaceTypes](#calculatebaseplacetypes)         | **UrbanIncome**       | Total income by place types                                  |
| VELandUse           | [CalculateFuturePlaceTypes](#calculatefutureplacetypes)     | **HhPlaceTypes**      | A place type as assigned to the households                   |
| VELandUse           | [CalculateFuturePlaceTypes](#calculatefutureplacetypes)     | **UrbanIncome**       | Total income by place types                                  |
| VETransportSupply   | [CreateFutureAccessibility](#createfutureaccessibility)     | **FwyLaneMiPCFuture** | Ratio of urbanized area freeway and expressway lane-miles to urbanized  area population |
| VETransportSupply   | [CreateFutureAccessibility](#createfutureaccessibility)     | **TranRevMiPCFuture** | Transit revenue miles per capita for the region              |
| VEHouseholdVehicles | [AssignVehicleFeaturesFuture](#assignvehiclefeaturesfuture) | **VehIdFuture**       | Unique vehicle ID                                            |
| VEHouseholdVehicles | [AssignVehicleFeaturesFuture](#assignvehiclefeaturesfuture) | **TypeFuture**        | Vehicle body type: Auto = automobile, LtTrk = light trucks (i.e. pickup,  SUV, Van) |
| VEHouseholdVehicles | [AssignVehicleFeaturesFuture](#assignvehiclefeaturesfuture) | **MileageFuture**     | Mileage of vehicles (automobiles and light truck)            |
| VEHouseholdVehicles | [AssignVehicleFeaturesFuture](#assignvehiclefeaturesfuture) | **DvmtPropFuture**    | Proportion of average vehicle DVMT                           |
| VEHouseholdVehicles | [AssignVehicleFeaturesFuture](#assignvehiclefeaturesfuture) | **VehiclesFuture**    | Number of automobiles and light trucks owned or leased by the household |
| VEHouseholdVehicles | [AssignVehicleFeaturesFuture](#assignvehiclefeaturesfuture) | **AgeFuture**         | Age of the vehicles                                          |

#### Module Outputs

1. **TruckDvmtFuture**: Average daily vehicle miles traveled by trucks estimated using model estimations of future year data
2. **DvmtFuture (bzones)**: Average daily vehicle miles traveled by place types estimated using model estimations of future year data
3. **DvmtFuture (households)**: Average daily vehicle miles traveled by household estimated using model estimations of future year data
4. **DvmtFuture (vehicles)**: Average daily vehicle miles traveled by each vehicle estimated using model estimations of future year data
5. **EvDvmtFuture (bzones)**: Average daily electric vehicle miles traveled by place types estimated using model estimations of future year data
6. **EvDvmtFuture (vehicles)**: Average daily electric vehicle miles traveled by each vehicle estimated using model estimations of future year data
7. **HcDvmtFuture (bzones)**: Average daily vehicle (ICE) miles traveled by place types estimated using model estimations of future year data
8. **HcDvmtFuture (vehicles)**: Average daily vehicle (ICE) miles traveled by each vehicle estimated using model estimations of future year data
9. **FuelGallonsFuture**: Average daily fuel consumption in gallons by each household estimated using model estimations of future year data
10. **FuelCo2eFuture**: Average daily Co2 equivalent greenhouse gas emissions by each household due to traditional fuel consumption estimated using model estimations of future year data
11. **ElecKwhFuture**: Average daily power consumption in kilowatt-hours by each household estimated using model estimations of future year data
12. **ElecCo2eFuture**: Average daily Co2 equivalent greenhouse gas emissions by each household due to power consumption estimated using model estimations of future year data
13. **MpKwhFuture**: Power efficiency of electric vehicles by each vehicle estimated using model estimations of future year data
14. **PowertrainFuture**: Powertrain of each vehicle estimated using model estimations of future year data
15. **DailyParkingCostFuture**: Average daily parking cost by each household estimated using model estimations of future year data
16. **FutureCostPerMileFuture**: Total cost per mile for future year for each household estimated using model estimations of future year data

	Top](#contents)										[Definitions](#definitions)								[Inputs/Outputs](#inputs-and-outputs)  

------

### CalculateCongestionBase

This module calculates the amount of congestion using estimated data. Auto, and light truck VMT, truck VMT and bus VMT are allocated to freeways, arterials, and other roadways. Truck and bus VMT are allocated based on mode-specific data, and auto and light truck VMT are allocated based on a combination of factors and a model that is sensitive to the relative supplies of freeway and arterial lane miles. System-wide ratios of VMT to lane miles for freeways and arterials are used to allocate VMT to congestion levels using congestion levels defined by the Texas Transportation Institute for the Urban Mobility Report. Each freeway and arterial congestion level is associated with an average trip speed for conditions that do and do not include ITS treatment for incident management on the roadway. Overall average speeds by congestion level are calculated based on input assumptions about the degree of incident management. Speed vs. fuel efficiency relationships for light vehicles, trucks, and buses are used to adjust the fleet fuel efficiency averages computed for the region.

#### User Input Files

1. **Percent road miles with ITS treatment (*azone_its_prop.csv*)**: This file is an estimate of the proportion of road miles that have improvements which reduce incidents through ITS treatments in both the base and future years. Values entered should be between 0 and 1, with 1 indicating that 100% of road miles are treated.
   The ITS policy measures the effects of incident management supported by ITS. The ITS table is used to inform the congestion model and the travel demand model. The model uses the mean speeds with and without incidents to compute an overall average speed by road type and congestion level providing a simple level of sensitivity to the potential effects of incident management programs on delay and emissions.
   The ITS treatments are evaluated only on freeways and arterials. The ITS treatments that can be evaluated are those that the analyst considers will reduce non-recurring congestion due to incidents. This policy does not deal with other operational improvements such as signal coordination, or temporary capacity increases such as allowing shoulder use in the peak.
   Here is a snapshot of the file:

   | Geo       | Year | ITS  |
   | --------- | ---- | ---- |
   | Multnomah | 2005 | 0    |
   | Multnomah | 2035 | 0    |

2. **Truck and bus vmt (*region_truck_bus_vmt.csv*)**: This file contains the region’s proportion of VMT by truck and bus as well as the distribution of that VMT across functional classes (*freeway*, *arterial*, *other*). The file includes one row for bus VMT data and one row for Truck VMT data. It should be noted that it is not necessary to enter values in the **PropVmt** column for **BusVmt** as this is calculated using the values in the ***transportation_supply.csv*** user input file. The truck VMT proportion (PropVMT column, TruckVMT row) can be obtained from [Highway Performance Monitoring System](http://www.fhwa.dot.gov/policyinformation/hpms.cfm) data and local sources or the regional travel demand model if one exists.
   The proportions of VMT by functional class can be derived from the Federal Highway Cost Allocation Study and data from transit operators. The Federal Highway Cost Allocation Study (Table II-6, 1997 Federal Highway Cost Allocation Study Final Report, [Chapter II](http://www.fhwa.dot.gov/policy/hcas/final/two.cfm) is used to calculate the average proportion of truck VMT by functional class. Data from transit authorities are used to calculate the proportions of bus VMT by urban area functional class.
   Here is a snapshot of the file:

   | Type     | PropVmt | Fwy      | Art      | Other    |
   | -------- | ------- | -------- | -------- | -------- |
   | BusVmt   | 0       | 0.15     | 0.591854 | 0.258146 |
   | TruckVmt | 0.08    | 0.452028 | 0.398645 | 0.149327 |

#### User Input Parameters

1. **Light vehicle dvmt (*BaseLtVehDvmt*)**: Total light vehicle daily VMT for the base year in thousands of miles. This data can be derived from a combination of [Highway Performance Monitoring System](http://www.fhwa.dot.gov/policyinformation/hpms.cfm) data, Federal Highway Cost Allocation Study data, and regional data. Light vehicle daily VMT can be estimated by subtracting truck and bus VMT from total VMT provided in the Highway Performance Monitoring System (HPMS). Regional travel demand model outputs can also be used to derive these data. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

   ```json
   {
       "NAME" : "BaseLtVehDvmt",
       "VALUE": "27244",
       "TYPE" : "compound",
       "UNITS" : "MI/DAY",
       "PROHIBIT" : "c('NA', '< 0')",
       "ISELEMENTOF" : ""
   }
   ```

2. **Dvmt proportion by functional class (*BaseFwyArtProp*)**: The proportions of daily VMT for light vehicles that takes place on freeways and arterials (i.e., the remainder of VMT takes place on lower functional class roads for the base year. This data can be derived from a combination of [Highway Performance Monitoring System](http://www.fhwa.dot.gov/policyinformation/hpms.cfm) data, Federal Highway Cost Allocation Study data, and regional data. The proportions of light vehicle daily VMT on freeways and arterials can be derived from the HPMS data. Regional travel demand model outputs can also be used to derive these data. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

   ```json
   {
       "NAME" : "BaseFwyArtProp",
       "VALUE": "0.77",
       "TYPE" : "double",
       "UNITS" : "proportion",
       "PROHIBIT" : "c('NA', '< 0', '> 1')",
       "ISELEMENTOF" : ""
   }
   ```

3. **Transit revenue adjustment factor (*TranRevMiAdjFactor*)**: Factor to convert transit revenue miles (i.e. miles run in service on routes) to total transit vehicle miles operated to account for vehicle miles run while deadheading from depots to route endpoints. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

   ```json
   {
       "NAME" : "TranRevMiAdjFactor",
       "VALUE": "1.12",
       "TYPE" : "double",
       "UNITS" : "multiplier",
       "PROHIBIT" : "c('NA', '< 0')",
       "ISELEMENTOF" : ""
   }
   ```

#### Internal Module Inputs

| Package           | Module                                                  | Outputs           | Description                                                  |
| ----------------- | ------------------------------------------------------- | ----------------- | ------------------------------------------------------------ |
| VELandUse         | [CalculateBasePlaceTypes](#calculatebaseplacetypes)     | **UrbanPop**      | Total population by place types                              |
| VELandUse         | [CalculateFuturePlaceTypes](#calculatefutureplacetypes) | **UrbanPop**      | Total population by place types                              |
| VETransportSupply | [CreateBaseAccessibility](#createbaseaccessibility)     | **FwyLaneMiPC**   | Ratio of urbanized area freeway and expressway lane-miles to urbanized  area population |
| VETransportSupply | [CreateBaseAccessibility](#createbaseaccessibility)     | **ArtLaneMiPC**   | Ratio of urbanized area arterial lane-miles to urbanized area population |
| VETransportSupply | [CreateBaseAccessibility](#createbaseaccessibility)     | **TranRevMiPC**   | Transit revenue miles per capita for the region              |
| VETransportSupply | [CreateBaseAccessibility](#createbaseaccessibility)     | **BusRevMi**      | Bus revenue miles for the region                             |
| VETransportSupply | [CreateBaseAccessibility](#createbaseaccessibility)     | **RailRevMi**     | Rail revenue miles for the region                            |
| VEHouseholdTravel | [CalculateTravelDemand](#calculatetraveldemand)         | **TruckDvmt**     | Average daily vehicle miles traveled by trucks               |
| VEHouseholdTravel | [CalculateTravelDemand](#calculatetraveldemand)         | **Dvmt (bzones)** | Average daily vehicle miles traveled by place types          |

#### Module Outputs

1. **LtVehDvmt**: Daily vehicle miles travelled by light vehicles in the region
2. **BusDvmt**: Daily vehicle miles travelled by bus in the region
3. **MpgAdjLtVeh**: Average fuel efficiency adjustment for light vehicles in the region
4. **MpgAdjBus**: Average fuel efficiency adjustment for buses in the region
5. **MpgAdjTruck**: Average fuel efficiency adjustment for heavy trucks in the region
6. **MpKwhAdjLtVehEv**: Average power efficiency adjustment for electric light vehicles in the region
7. **MpKwhAdjLtVehHev**: Average power efficiency adjustment for hybrid electric light vehicles in the region
8. **MpKwhAdjBus**: Average power efficiency adjustment for buses in the region
9. **MpKwhAdjTruck**: Average power efficiency adjustment for heavy trucks in the region
10. **VehHrLtVeh**: Total vehicle travel time for light vehicles in the region
11. **VehHrBus**: Total vehicle travel time for buses in the region
12. **VehHrTruck**: Total vehicle travel time for heavy trucks in the region
13. **AveSpeedLtVeh**: Average speed for light vehicles in the region
14. **AveSpeedBus**: Average speed for buses in the region
15. **AveSpeedTruck**: Average speed for heavy trucks in the region
16. **FfVehHrLtVeh**: Average free-flow travel time for light vehicles in the region
17. **FfVehHrBus**: Average free-flow travel time for buses in the region
18. **FfVehHrTruck**: Average free-flow travel time for heavy trucks in the region
19. **DelayVehHrLtVeh**: Total vehicle delay time for light vehicles in the region
20. **DelayVehHrBus**: Total vehicle delay time for buses in the region
21. **DelayVehHrTruck**: Total vehicle delay time for heavy trucks in the region
22. **MpgAdjHh**: Average fuel efficiency adjustment for households in the region
23. **MpKwhAdjEvHh**: Average power efficiency adjustment for electric vehicles for households in the region
24. **MpKwhAdjHevHh**: Average power efficiency adjustment for hybrid electric vehicles for households in the region
25. **LtVehDvmtFactor**: Light vehicle Dvmt factor adjustment factor

	Top](#contents)										[Definitions](#definitions)								[Inputs/Outputs](#inputs-and-outputs)  

------

### CalculateCongestionFuture

This module is similar to [CalculateCongestionBase](#calculatecongestionbase) module but uses model estimation of future transportation supply as the basis of calculations.

#### User Input Files

1. **Percent road miles with ITS treatment (*azone_its_prop.csv*)**: This file is an estimate of the proportion of road miles that have improvements which reduce incidents through ITS treatments in both the base and future years. Values entered should be between 0 and 1, with 1 indicating that 100% of road miles are treated.
   The ITS policy measures the effects of incident management supported by ITS. The ITS table is used to inform the congestion model and the travel demand model. The model uses the mean speeds with and without incidents to compute an overall average speed by road type and congestion level providing a simple level of sensitivity to the potential effects of incident management programs on delay and emissions.
   The ITS treatments are evaluated only on freeways and arterials. The ITS treatments that can be evaluated are those that the analyst considers will reduce non-recurring congestion due to incidents. This policy does not deal with other operational improvements such as signal coordination, or temporary capacity increases such as allowing shoulder use in the peak.
   Here is a snapshot of the file:

   | Geo       | Year | ITS  |
   | --------- | ---- | ---- |
   | Multnomah | 2005 | 0    |
   | Multnomah | 2035 | 0    |

2. **Truck and bus vmt (*region_truck_bus_vmt.csv*)**: This file contains the region’s proportion of VMT by truck and bus as well as the distribution of that VMT across functional classes (*freeway*, *arterial*, *other*). The file includes one row for bus VMT data and one row for Truck VMT data. It should be noted that it is not necessary to enter values in the **PropVmt** column for **BusVmt** as this is calculated using the values in the ***transportation_supply.csv*** user input file. The truck VMT proportion (PropVMT column, TruckVMT row) can be obtained from [Highway Performance Monitoring System](http://www.fhwa.dot.gov/policyinformation/hpms.cfm) data and local sources or the regional travel demand model if one exists.
   The proportions of VMT by functional class can be derived from the Federal Highway Cost Allocation Study and data from transit operators. The Federal Highway Cost Allocation Study (Table II-6, 1997 Federal Highway Cost Allocation Study Final Report, [Chapter II](http://www.fhwa.dot.gov/policy/hcas/final/two.cfm) is used to calculate the average proportion of truck VMT by functional class. Data from transit authorities are used to calculate the proportions of bus VMT by urban area functional class.
   Here is a snapshot of the file:

   | Type     | PropVmt | Fwy      | Art      | Other    |
   | -------- | ------- | -------- | -------- | -------- |
   | BusVmt   | 0       | 0.15     | 0.591854 | 0.258146 |
   | TruckVmt | 0.08    | 0.452028 | 0.398645 | 0.149327 |

#### User Input Parameters

1. **Light vehicle dvmt (*BaseLtVehDvmt*)**: Total light vehicle daily VMT for the base year in thousands of miles. This data can be derived from a combination of [Highway Performance Monitoring System](http://www.fhwa.dot.gov/policyinformation/hpms.cfm) data, Federal Highway Cost Allocation Study data, and regional data. Light vehicle daily VMT can be estimated by subtracting truck and bus VMT from total VMT provided in the Highway Performance Monitoring System (HPMS). Regional travel demand model outputs can also be used to derive these data. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

   ```json
   {
       "NAME" : "BaseLtVehDvmt",
       "VALUE": "27244",
       "TYPE" : "compound",
       "UNITS" : "MI/DAY",
       "PROHIBIT" : "c('NA', '< 0')",
       "ISELEMENTOF" : ""
   }
   ```

2. **Dvmt proportion by functional class (*BaseFwyArtProp*)**: The proportions of daily VMT for light vehicles that takes place on freeways and arterials (i.e., the remainder of VMT takes place on lower functional class roads for the base year. This data can be derived from a combination of [Highway Performance Monitoring System](http://www.fhwa.dot.gov/policyinformation/hpms.cfm) data, Federal Highway Cost Allocation Study data, and regional data. The proportions of light vehicle daily VMT on freeways and arterials can be derived from the HPMS data. Regional travel demand model outputs can also be used to derive these data. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

   ```json
   {
       "NAME" : "BaseFwyArtProp",
       "VALUE": "0.77",
       "TYPE" : "double",
       "UNITS" : "proportion",
       "PROHIBIT" : "c('NA', '< 0', '> 1')",
       "ISELEMENTOF" : ""
   }
   ```

3. **Transit revenue adjustment factor (*TranRevMiAdjFactor*)**: Factor to convert transit revenue miles (i.e. miles run in service on routes) to total transit vehicle miles operated to account for vehicle miles run while deadheading from depots to route endpoints. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

   ```json
   {
       "NAME" : "TranRevMiAdjFactor",
       "VALUE": "1.12",
       "TYPE" : "double",
       "UNITS" : "multiplier",
       "PROHIBIT" : "c('NA', '< 0')",
       "ISELEMENTOF" : ""
   }
   ```

#### Internal Module Inputs

| Package              | Module                                                      | Outputs                 | Description                                                  |
| -------------------- | ----------------------------------------------------------- | ----------------------- | ------------------------------------------------------------ |
| VELandUse            | [CalculateBasePlaceTypes](#calculatebaseplacetypes)         | **UrbanPop**            | Total population by place types                              |
| VELandUse            | [CalculateFuturePlaceTypes](#calculatefutureplacetypes)     | **UrbanPop**            | Total population by place types                              |
| VETransportSupply    | [CreateFutureAccessibility](#createfutureaccessibility)     | **FwyLaneMiPCFuture**   | Ratio of urbanized area freeway and expressway lane-miles to urbanized  area population calculated using future (estimated) data |
| VETransportSupply    | [CreateFutureAccessibility](#createfutureaccessibility)     | **ArtLaneMiPCFuture**   | Ratio of urbanized area arterial lane-miles to urbanized area population  calculated using future (estimated) data |
| VETransportSupply    | [CreateFutureAccessibility](#createfutureaccessibility)     | **TranRevMiPCFuture**   | Transit revenue miles per capita for the region calculated using future  (estimated) data |
| VETransportSupply    | [CreateFutureAccessibility](#createfutureaccessibility)     | **BusRevMiFuture**      | Bus revenue miles for the region calculated using future (estimated) data |
| VETransportSupply    | [CreateFutureAccessibility](#createfutureaccessibility)     | **RailRevMiFuture**     | Rail revenue miles for the region calculated using future (estimated)  data |
| VEHouseholdTravel    | [CalculateTravelDemandFuture](#calculatetraveldemandfuture) | **TruckDvmtFuture**     | Average daily vehicle miles traveled by trucks estimated using model  estimations of future year data |
| VEHouseholdTravel    | [CalculateTravelDemandFuture](#calculatetraveldemandfuture) | **DvmtFuture (bzones)** | Average daily vehicle miles traveled by place types estimated using model  estimations of future year data |
| VETransportSupplyUse | [CalculateCongestionBase](#calculatecongestionbase)         | **LtVehDvmtFactor**     | Light vehicle Dvmt factor adjustment factor                  |

#### Module Outputs

1. **LtVehDvmtFuture**: Daily vehicle miles travelled by light vehicles in the region calculated using model estimation of future data
2. **BusDvmtFuture**: Daily vehicle miles travelled by bus in the region calculated using model estimation of future data
3. **MpgAdjLtVehFuture**: Average fuel efficiency adjustment for light vehicles in the region calculated using model estimation of future data
4. **MpgAdjBusFuture**: Average fuel efficiency adjustment for buses in the region calculated using model estimation of future data
5. **MpgAdjTruckFuture**: Average fuel efficiency adjustment for heavy trucks in the region calculated using model estimation of future data
6. **VehHrLtVehFuture**: Total vehicle travel time for light vehicles in the region calculated using model estimation of future data
7. **VehHrBusFuture**: Total vehicle travel time for buses in the region calculated using model estimation of future data
8. **VehHrTruckFuture**: Total vehicle travel time for heavy trucks in the region calculated using model estimation of future data
9. **AveSpeedLtVehFuture**: Average speed for light vehicles in the region calculated using model estimation of future data
10. **AveSpeedBusFuture**: Average speed for buses in the region calculated using model estimation of future data
11. **AveSpeedTruckFuture**: Average speed for heavy trucks in the region calculated using model estimation of future data
12. **FfVehHrLtVehFuture**: Average free-flow travel time for light vehicles in the region calculated using model estimation of future data
13. **FfVehHrBusFuture**: Average free-flow travel time for buses in the region calculated using model estimation of future data
14. **FfVehHrTruckFuture**: Average free-flow travel time for heavy trucks in the region calculated using model estimation of future data
15. **DelayVehHrLtVehFuture**: Total vehicle delay time for light vehicles in the region calculated using model estimation of future data
16. **DelayVehHrBusFuture**: Total vehicle delay time for buses in the region calculated using model estimation of future data
17. **DelayVehHrTruckFuture**: Total vehicle delay time for heavy trucks in the region calculated using model estimation of future data
18. **MpgAdjHhFuture**: Average fuel efficiency adjustment for households in the region calculated using model estimation of future data
19. **LtVehDvmtFactorFuture**: Light vehicle Dvmt factor adjustment factor calculated using model estimation of future data

[Top](#contents)										[Definitions](#definitions)								[Inputs/Outputs](#inputs-and-outputs)  

------

### CalculateInducedDemand

Induced demand is calculated for changes in roadway supply in the near term as a function of speed, based on potential mode and route shifts to produce changes in VMT and in the longer term to include changes in vehicle ownership, still as a function of speed. This model does not include induced demand as a result of changes in growth that may occur as part of a smart growth scenario because the evidence is limited empirical evidence.

#### User Input Files

1. **Auto and transit trips per capita (*region_trips_per_cap.csv*)**: This file contains regional averages for auto and transit trips per day for the base year.

   - **Auto** is the regional average of auto trips per capita, including drive alone and shared ride travel. This data can be derived from the [National Household Travel Survey](https://nhts.ornl.gov/) by region or from a local household travel survey or regional travel demand forecasting model.
   - **Transit** is the regional average of transit trips per capita, including walk and drive access to transit. This data can be derived from the [National Transit Database](https://www.transit.dot.gov/ntd/ntd-data) where the annual database contains a “service” table that has annual transit trip data for each transit operator or from a local household travel survey or regional travel demand forecasting model.

   Here is a snapshot of the files:

   | Mode    | Trips |
   | ------- | ----- |
   | Auto    | 3.2   |
   | Transit | 0.4   |

2. **Place type adjustments to travel demand (*model_place_type_elasticities.csv*)**: This file contains elasticities for four performance metrics:

   - **VMT** – Following the estimate of travel demand that incorporates induced demand, an adjustment is made to travel demand that accounts for changes in growth by the place types that are used in the model to describe urban form. These changes are interpreted as changes in design (intersection street density), accessibility (job accessibility by auto), distance to transit (nearest transit stop), density (population density) and diversity (land use mix). The effect on travel demand is determined as changes in VMT by these urban form categories, as shown in the table below. The elasticities that are shown in the table are multiplied by the D values for each place type. The D values are proportion values for each place type that are relative to the regional average, which is set to 1.0.
   - **VehicleTrips** – The change in the number of vehicle trips is calculated using a set of elasticities from Index 4D Values (2001) that pivots from the current number of vehicle trips per capita based on the scenario’s allocation of growth by place type. The elasticities shown in the table are applied to D values, which are proportional values for each place type that are relative to a regional average for that D value that is set to 1.0. The model reports the additional number of trips caused by the growth assumed in the scenario and not the regional total.
   - **TransitTrips** – The change in the number of transit trips is calculated using a set of elasticities from Index 4D Values (2001) that pivots from the current number of transit trips per capita based on the scenario’s allocation of growth by place type. The elasticities shown in the table are applied to D values, which are proportional values for each place type that are relative to a regional average for that D value that is set to 1.0. The model reports the additional number of trips caused by the growth assumed in the scenario and not the regional total.
   - **Walking** – The elasticities shown in the table are applied to D values, which are proportional values for each place type that are relative to a regional average for that D value that is set to 1.0. The product of the elasticity and D value is applied to the place type growth quantities for the scenario to calculated the percentage increase or decrease in walking for new residents in the region relative to a the current place type distribution.

   Here is a snapshot of the file:

   | Parameters             | VMT   | VehicleTrips | TransitTrips | Walking |
   | ---------------------- | ----- | ------------ | ------------ | ------- |
   | Density                | -0.04 | -0.043       | 0.07         | 0.07    |
   | Diversity              | -0.09 | -0.051       | 0.12         | 0.15    |
   | Design                 | -0.12 | -0.031       | 0.23         | 0.39    |
   | Regional_Accessibility | -0.2  | -0.036       | 0            | 0       |
   | Distance_to_Transit    | -0.05 | 0            | 0.29         | 0.15    |

3. **Place type adjustments to travel demand (*model_place_type_relative_values.csv*)**: This file contains the *D* values, which are proportional values for each of the 13 place types (*Bzones*) that are relative to a regional average, for each of the five Ds used in VERPAT - design (intersection street density), accessibility (job accessibility by auto), distance to transit (nearest transit stop), density (population density) and diversity (land use mix).
   Here is a snapshot of the file:

   | Geo   | Density | Diversity | Design | Regional_Accessibility | Distance_to_Transit |
   | ----- | ------- | --------- | ------ | ---------------------- | ------------------- |
   | Rur   | 0.5     | 0.5       | 0.5    | 0.5                    | 0.5                 |
   | Sub_R | 0.75    | 0.75      | 0.75   | 0.75                   | 0.75                |
   | Sub_E | 0.75    | 0.75      | 0.75   | 0.75                   | 0.75                |
   | Sub_M | 1       | 1         | 1      | 0.75                   | 0.75                |
   | Sub_T | 1       | 1         | 1      | 1                      | 1                   |
   | CIC_R | 1.2     | 1.2       | 1.2    | 1.2                    | 1                   |
   | CIC_E | 1.2     | 1.2       | 1.2    | 1.2                    | 1                   |
   | CIC_M | 1.2     | 1.2       | 1.2    | 1.2                    | 1                   |
   | CIC_T | 1.2     | 1.2       | 1.2    | 1.2                    | 1.2                 |
   | UC_R  | 1.5     | 1.2       | 1.5    | 1.5                    | 1.2                 |
   | UC_E  | 1.5     | 1.2       | 1.5    | 1.5                    | 1.2                 |
   | UC_M  | 1.5     | 1.5       | 1.5    | 1.5                    | 1.2                 |
   | UC_T  | 1.5     | 1.5       | 1.5    | 1.5                    | 1.5                 |


#### Internal Module Inputs

| Package           | Module                                                      | Outputs                     | Description                                                  |
| ----------------- | ----------------------------------------------------------- | --------------------------- | ------------------------------------------------------------ |
| VESimHouseholds   | [PredictIncome](#predictincome)                             | **Income**                  | Total annual household (non-qroup & group quarters) income in year  1999 dollars |
| VELandUse         | [CalculateBasePlaceTypes](#calculatebaseplacetypes)         | **HhPlaceTypes**            | A place type as assigned to the households                   |
| VELandUse         | [CalculateBasePlaceTypes](#calculatebaseplacetypes)         | **UrbanPop**                | Total population by place types                              |
| VELandUse         | [CalculateBasePlaceTypes](#calculatebaseplacetypes)         | **UrbanEmp**                | Total employees by place types                               |
| VELandUse         | [CalculateFuturePlaceTypes](#calculatefutureplacetypes)     | **HhPlaceTypes**            | A place type as assigned to the households                   |
| VELandUse         | [CalculateFuturePlaceTypes](#calculatefutureplacetypes)     | **UrbanPop**                | Total population by place types                              |
| VELandUse         | [CalculateFuturePlaceTypes](#calculatefutureplacetypes)     | **UrbanEmp**                | Total employees by place types                               |
| VEHouseholdTravel | [CalculateTravelDemandFuture](#calculatetraveldemandfuture) | **DvmtFuture (households)** | Average daily vehicle miles traveled by household estimated using model  estimations of future year data |

#### Module Outputs

1. **DvmtFuture (households)**: Average daily vehicle miles traveled by household estimated using model  estimations of future year data
2. **DvmtFuture (bzones)**: Average daily vehicle miles traveled by place types estimated using model estimations of future year data
3. **DvmtPtAdj**: Dvmt adjustment by place types
4. **Access**: Growth in job access
5. **Equity**: Growth in equity by income group
6. **VehicleTrips**: Policy adjusted vehicle trips
7. **TransitTrips**: Policy adjusted transit trips
8. **Walking**: Growth in walking

[Top](#contents)										[Definitions](#definitions)								[Inputs/Outputs](#inputs-and-outputs)  

------

### CalculatePolicyVmt

This module calculates scenario travel demand. The average daily VMT for each household can be adjusted based on changes in growth patterns by place type, changes in auto operating cost, changes in road lane miles or transit revenue miles for any scenario. There are also a series of policy assumptions that can contribute to changes in VMT: pricing such as VMT charges or parking pricing, ITS strategies for freeways and arterials, and vanpool, telecommuting, ridesharing, and transit pass programs. All of these will contribute to shifts in travel demand for a given scenario.

#### User Input Files

1. **Percentage of employees offered commute options (*region_commute_options.csv*)**: This file contains assumptions about the availability and participation in work based travel demand management programs. The policies are ridesharing programs, transit pass programs, telecommuting or alternative work schedule programs, and vanpool programs. For each, the user enters the proportion of workers who participate (the data items with the “Participation” suffix). For one program, the transit subsidy, the user must also enter the subsidy level in dollars for the TransitSubsidyLevel data item.
   Here is a snapshot of the file:

   | TDMProgram     | DataItem                        | DataValue |
   | -------------- | ------------------------------- | --------- |
   | Ridesharing    | RidesharingParticipation        | 0.05      |
   | TransitSubsidy | TransitSubsidyParticipation     | 0.1       |
   | TransitSubsidy | TransitSubsidyLevel             | 1.25      |
   | WorkSchedule   | Schedule980Participation        | 0.01      |
   | WorkSchedule   | Schedule440Participation        | 0.01      |
   | WorkSchedule   | Telecommute1.5DaysParticipation | 0.01      |
   | Vanpooling     | LowLevelParticipation           | 0.04      |
   | Vanpooling     | MediumLevelParticipation        | 0.01      |
   | Vanpooling     | HighLevelParticipation          | 0.01      |

2. **Bicycling/light vehicles targets (*region_light_vehicles.csv*)**: This file contains input data for the non-motorized vehicle model. In VERPAT, non-motorized vehicles are bicycles, and also electric bicycles, segways, and similar vehicles that are small, light-weight and can travel at bicycle speeds or slightly higher. The parameters are as follows:

   - **TargetProp**: non-motorized vehicle ownership rate (average ratio of non-motorized vehicles to driver age population)
   - **Threshold**: single-occupant vehicle (SOV) tour mileage threshold used in the SOV travel proportion model. This is the upper limit for tour lengths that are suitable for reallocation to non-motorized modes.
   - **PropSuitable**: proportion of SOV travel suitable for non-motorized vehicle travel. This variable describes the proportion of SOV tours within the mileage threshold for which non-motorized vehicles might be substituted. This variable takes into account such factors as weather and trip purpose.

   The non-motorized vehicle model predicts the ownership and use of non-motorized vehicles (where non-motorized vehicles are bicycles, and also electric bicycles, segways and similar vehicles that are small, light-weight and can travel at bicycle speeds or slightly higher than bicycle speeds). The core concept of the model is that non-motorized vehicle usage will primarily be a substitute for short-distance SOV travel. Therefore, the model estimates the proportion of the household vehicle travel that occurs in short-distance SOV tours. The model determines the maximum potential for household VMT to be diverted to non-motorized vehicles, which is also dependent on the availability of non-motorized vehicles.
   Note that bike share programs (BSP) serve to increase the availability of non-motorized vehicles and can be taken into account by increasing the **TargetProp** variable. Use national estimates of non-motorized ownership if regional estimates of non-motorized ownership are not available (unless the region has notably atypical levels of bicycle usage). See [Bicycle Ownership in the United States](http://www.academia.edu/1839374/Bicycle_Ownership_in_the_United_States_Empirical_Analysis_of_Regional_Differences) for an analysis of regional differences.
   Here is a snapshot of the file:

   | DataItem     | DataValue |
   | ------------ | --------- |
   | TargetProp   | 0.2       |
   | Threshold    | 2         |
   | PropSuitable | 0.1       |

3. **Increase in parking cost and supply (*marea_parking_growth.csv*)**: This file contains information that allows the effects of policies such as workplace parking charges and "*cash-out buy-back*" programs to be tested. The input parameters are as follows and should be entered for both the base and future year:

   - **PropWrkPkg**: proportion of employees that park at work
   - **PropWrkChrgd**: proportion of employers that charge for parking
   - **PropCashOut**: proportion of employment parking that is converted from being free to pay under a "*cash-out buy-back*" type of program
   - **PrkOthChrgd**: proportion of other parking that is not free
   - **PkgCost**: average daily parking cost. This variable is the average daily parking cost for those who incur a fee to park. If the paid parking varies across the region, then the "*PkgCost*" value should reflect the average of those parking fees, but weighted by the supply – so if most in the Center City, then the average will be heavily weighted toward the price in the Center City.

   Here is a snapshot of the file:

   | Geo       | Year | PropWorkParking | PropWorkCharged | PropCashOut | PropOtherCharged | ParkingCost.2000 |
   | --------- | ---- | --------------- | --------------- | ----------- | ---------------- | ---------------- |
   | Multnomah | 2005 | 1               | 0.1             | 0           | 0.05             | 5                |
   | Multnomah | 2035 | 1               | 0.1             | 0           | 0.05             | 5                |

4. **Travel Demand Management: Ridesharing (*model_tdm_ridesharing.csv*)**: The ridesharing Travel Demand Management file contains parameters describing the effectiveness of ridersharing programs by place type. The proportion of employees participating in the ridesharing program is a policy input. This is converted into a proportion of working-age persons by using an assumed labor force participation rate (0.65) to sample working-age persons in households. The ridesharing submodel then computes the anticipated level of VMT reduction resulting from the implementation of ridesharing, based on the place type the household lives in, using the effectiveness values shown in this parameter file. Previous studies have determined that the level of ridesharing participation will be less in the rural and suburban areas, as compared to the more-urban areas. Typically, more people will carpool in the more urbanized areas due to the presence of parking charges, potential difficulties in finding parking, and other disincentives that are typically present in more urbanized areas.
   Here is a snapshot of the file:

   | ModelGeo | Effectiveness |
   | -------- | ------------- |
   | Rur      | 0             |
   | Sub      | 0.05          |
   | CIC      | 0.1           |
   | UC       | 0.15          |

5. **Travel Demand Management: Transit Fares (*model_tdm_transit.csv*)**: The transit fare Travel Demand Management files are parameters for the effectiveness (level of VMT reduction) and fare subsidy values for employer. The subsidized/discounted transit model begins by evaluating the level of participation within the region. Monte Carlo processes are used to identify which households participate in transit pass programs. The proportion of employees participating in this program is a policy input. This is converted into a proportion of working-age persons by using an assumed labor force participation rate (0.65) to sample working-age persons in households. The model then allows the selection of one of four potential subsidy levels (also a policy inputs), which influence the level of VMT reduction based on the level of subsidy applied to the place type. The anticipated level of VMT reduction is then further reduced to account for the proportion of work travel in overall daily travel.
   Here is a snapshot of the file:

   | ModelGeo | Subsidy0 | Subsidy1 | Subsidy2 | Subsidy3 | Subsidy4 |
   | -------- | -------- | -------- | -------- | -------- | -------- |
   | Rur      | 0        | 0        | 0        | 0        | 0        |
   | Sub      | 0        | 0.02     | 0.033    | 0.079    | 0.2      |
   | CIC      | 0        | 0.034    | 0.073    | 0.164    | 0.2      |
   | UC       | 0        | 0.062    | 0.129    | 0.2      | 0.2      |

6. **Travel Demand Management: Transit Subsidy Levels (*model_tdm_transitlevels.csv*)**: This file contains the dollar value match to the subsidy levels used in *model_tdm_transit.csv* file.
   Here is a snapshot of the file:

   | SubsidyLevel | SubsidyValue.2000 |
   | ------------ | ----------------- |
   | Subsidy0     | 0                 |
   | Subsidy1     | 0.75              |
   | Subsidy2     | 1.49              |
   | Subsidy3     | 2.98              |
   | Subsidy4     | 5.96              |

7. **Travel Demand Management: Vanpooling (*model_tdm_vanpooling.csv*)**: This file contains parameters describing the effectiveness in terms of VMT reductions for vanpooling programs across three levels of employee involvement.
   The vanpool program submodel operates by evaluating the likely level of participation. Monte Carlo processes are used to identify which households participate in vanpool programs. The proportion of employees participating in this program is a policy input. This is converted into a proportion of working-age persons by using an assumed labor force participation rate (0.65) to sample working-age persons in households. Those employers that would participate in the program are then categorized into three levels of involvement from low to medium to high. The level of involvement reflects the extent to which an employer would actively facilitate and promote vanpooling. For example, a low level of involvement might represent an employer who organizes only a minimal number of vanpools. The high level of involvement could represent an employer who has an extensive vanpooling program to cover a large number of employees. Based on the level of involvement, the reduction in VMT is estimated on the basis of the values in this file.
   Here is a snapshot of the file:

   | VanpoolingParticipation | VMTReduction |
   | ----------------------- | ------------ |
   | Low                     | 0.003        |
   | Medium                  | 0.0685       |
   | High                    | 0.134        |

8. **Travel Demand Management: Work Schedule (*model_tdm_workschedule.csv*)**: This file contains parameters that describe the effectiveness for different participation levels for three different telecommuting or alternative work schedules.
   The telecommuting or alternative work schedule model first evaluates the likely level of participation throughout the region in terms of telecommuting or alternatively-works schedules. Monte Carlo processes are used to identify which households participate in telecommuting programs. The proportion of employees participating in this program is a policy input. This is converted into a proportion of working-age persons by using an assumed labor force participation rate (0.65) to sample working-age persons in households. The model then determines the type of programs that might be implemented. Three potential alternatives are offered including:

   - **4/40 Schedule**: 4 days per week with 40 hours per week
   - **9/80 Schedule**: working 4 days every other week with an average of 80 hours over 2 weeks
   - **Telecommuting**: Workers may work 1 to 2 days a week remotely

   Once the option has been identified and the level of participation, the estimated VMT is determined on the basis of the parameters in this file.
   Here is a snapshot of the file:

   | WorkSchedulePolicy        | Participation0 | Participation1 | Participation2 | Participation3 | Participation4 | Participation5 |
   | ------------------------- | -------------- | -------------- | -------------- | -------------- | -------------- | -------------- |
   | Schedule980               | 0              | 0.0007         | 0.0021         | 0.0035         | 0.007          | 0.0175         |
   | Schedule440               | 0              | 0.0015         | 0.0045         | 0.007          | 0.015          | 0.0375         |
   | TelecommuteoneandhalfDays | 0              | 0.0022         | 0.0066         | 0.011          | 0.022          | 0.055          |

9. **Travel Demand Management: Work Schedule Participation Levels (*model_tdm_workschedulelevels.csv*)**: This file describes the proportion of employees participating in the program corresponding to the participation levels used in *model_tdm_workschedule.csv* file.
   Here is a snapshot of the file:

   | ParticipationLevel | ParticipationValue |
   | ------------------ | ------------------ |
   | Participation0     | 0                  |
   | Participation1     | 0.01               |
   | Participation2     | 0.03               |
   | Participation3     | 0.05               |
   | Participation4     | 0.1                |
   | Participation5     | 0.25               |

#### User Input Parameters:

1. **% Increase in Auto Operating Cost (*AutoCostGrowth*):** This parameter reflects the proportional increase in auto operating cost. This can be used to test different assumptions for future gas prices or the effects of increased gas taxes. A value of 1.5 multiplies base year operating costs by 1.5 and thus reflects a 50% increase. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

   ```json
   {
       "NAME" : "AutoCostGrowth",
       "VALUE": "1.5",
       "TYPE" : "double",
       "UNITS" : "multiplier",
       "PROHIBIT" : "c('NA', '< 0')",
       "ISELEMENTOF" : ""
   }
   ```

2. **Auto Operating Surcharge Per VMT (*VmtCharge*)**: It is a cost in cents per mile that would be levied on auto users through the form of a VMT charge. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

   ```json
   {
       "NAME" : "VmtCharge",
       "VALUE": "0.05",
       "TYPE" : "compound",
       "UNITS" : "USD/MI",
       "PROHIBIT" : "c('NA', '< 0')",
       "ISELEMENTOF" : ""
   }
   ```

3. **Work VMT Proportion (*WorkVmtProp*)**: The proportion of household VMT that takes place for commute to work purposes; used to differentiate between travel purposes for use in estimating overall VMT reductions that are targeted at the commute to work. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

   ```json
   {
       "NAME" : "WorkVmtProp",
       "VALUE": "0.25",
       "TYPE" : "double",
       "UNITS" : "proportion",
       "PROHIBIT" : "c('NA', '< 0')",
       "ISELEMENTOF" : ""
   }
   ```


#### Internal Module Inputs

| Package              | Module                                                      | Outputs                     | Description                                                  |
| -------------------- | ----------------------------------------------------------- | --------------------------- | ------------------------------------------------------------ |
| VESimHouseholds      | [CreateHouseholds](#createhouseholds)                       | **HhId**                    | Unique household ID                                          |
| VESimHouseholds      | [CreateHouseholds](#createhouseholds)                       | **HhSize**                  | Number of persons                                            |
| VESimHouseholds      | [CreateHouseholds](#createhouseholds)                       | **Age0to14**                | Persons in 0 to 14 year old age group                        |
| VESimHouseholds      | [CreateHouseholds](#createhouseholds)                       | **Age15to19**               | Persons in 15 to 19 year old age group                       |
| VESimHouseholds      | [CreateHouseholds](#createhouseholds)                       | **Age20to29**               | Persons in 20 to 29 year old age group                       |
| VESimHouseholds      | [CreateHouseholds](#createhouseholds)                       | **Age30to54**               | Persons in 30 to 54 year old age group                       |
| VESimHouseholds      | [CreateHouseholds](#createhouseholds)                       | **Age55to64**               | Persons in 55 to 64 year old age group                       |
| VESimHouseholds      | [CreateHouseholds](#createhouseholds)                       | **Age65Plus**               | Persons in 65 or older age group                             |
| VESimHouseholds      | [PredictIncome](#predictincome)                             | **Income**                  | Total annual household (non-qroup & group quarters) income in year  1999 dollars |
| VELandUse            | [CalculateFuturePlaceTypes](#calculatefutureplacetypes)     | **HhPlaceTypes**            | A place type as assigned to the households                   |
| VELandUse            | [CalculateFuturePlaceTypes](#calculatefutureplacetypes)     | **UrbanPop**                | Total population by place types                              |
| VELandUse            | [CalculateFuturePlaceTypes](#calculatefutureplacetypes)     | **UrbanEmp**                | Total employees by place types                               |
| VELandUse            | [CalculateFuturePlaceTypes](#calculatefutureplacetypes)     | **UrbanIncome**             | Total income by place types                                  |
| VETransportSupply    | [CreateFutureAccessibility](#createfutureaccessibility)     | **FwyLaneMiPCFuture**       | Ratio of urbanized area freeway and expressway lane-miles to urbanized  area population calculated using future (estimated) data |
| VETransportSupply    | [CreateFutureAccessibility](#createfutureaccessibility)     | **ArtLaneMiPCFuture**       | Ratio of urbanized area arterial lane-miles to urbanized area population  calculated using future (estimated) data |
| VETransportSupply    | [CreateFutureAccessibility](#createfutureaccessibility)     | **TranRevMiPCFuture**       | Transit revenue miles per capita for the region calculated using future  (estimated) data |
| VETransportSupply    | [CreateFutureAccessibility](#createfutureaccessibility)     | **BusRevMiFuture**          | Bus revenue miles for the region calculated using future (estimated) data |
| VETransportSupply    | [CreateFutureAccessibility](#createfutureaccessibility)     | **RailRevMiFuture**         | Rail revenue miles for the region calculated using future (estimated)  data |
| VEHouseholdVehicles  | [AssignVehicleFeaturesFuture](#assignvehiclefeaturesfuture) | **VehIdFuture**             | Unique vehicle ID                                            |
| VEHouseholdVehicles  | [AssignVehicleFeaturesFuture](#assignvehiclefeaturesfuture) | **VehiclesFuture**          | Number of automobiles and light trucks owned or leased by the household |
| VEHouseholdVehicles  | [AssignVehicleFeaturesFuture](#assignvehiclefeaturesfuture) | **NumLtTrkFuture**          | Number of light trucks (pickup, sport-utility vehicle, and van) owned or  leased by household |
| VEHouseholdVehicles  | [AssignVehicleFeaturesFuture](#assignvehiclefeaturesfuture) | **NumAutoFuture**           | Number of automobiles (i.e. 4-tire passenger vehicles that are not light  trucks) owned or leased by household |
| VEHouseholdTravel    | [CalculateTravelDemandFuture](#calculatetraveldemandfuture) | **DvmtFuture (vehicles)**   | Average daily vehicle miles traveled by each vehicle estimated using  model estimations of future year data |
| VEHouseholdTravel    | [CalculateTravelDemandFuture](#calculatetraveldemandfuture) | **FuelGallonsFuture**       | Average daily fuel consumption in gallons by each household estimated  using model estimations of future year data |
| VEHouseholdTravel    | [CalculateTravelDemandFuture](#calculatetraveldemandfuture) | **FuelCo2eFuture**          | Average daily Co2 equivalent greenhouse gas emissions by each household  estimated using model estimations of future year data |
| VEHouseholdTravel    | [CalculateTravelDemandFuture](#calculatetraveldemandfuture) | **FutureCostPerMileFuture** | Total cost per mile for future year for each household estimated using  model estimations of future year data |
| VETransportSupplyUse | [CalculateCongestionFuture](#calculatecongestionfuture)     | **MpgAdjLtVehFuture**       | Average fuel efficiency adjustment for light vehicles in the region  calculated using model estimation of future data |
| VETransportSupplyUse | [CalculateCongestionFuture](#calculatecongestionfuture)     | **MpgAdjBusFuture**         | Average fuel efficiency adjustment for buses in the region calculated  using model estimation of future data |
| VETransportSupplyUse | [CalculateCongestionFuture](#calculatecongestionfuture)     | **MpgAdjTruckFuture**       | Average fuel efficiency adjustment for heavy trucks in the region  calculated using model estimation of future data |
| VETransportSupplyUse | [CalculateCongestionFuture](#calculatecongestionfuture)     | **VehHrLtVehFuture**        | Total vehicle travel time for light vehicles in the region calculated  using model estimation of future data |
| VETransportSupplyUse | [CalculateCongestionFuture](#calculatecongestionfuture)     | **VehHrBusFuture**          | Total vehicle travel time for buses in the region calculated using model  estimation of future data |
| VETransportSupplyUse | [CalculateCongestionFuture](#calculatecongestionfuture)     | **VehHrTruckFuture**        | Total vehicle travel time for heavy trucks in the region calculated using  model estimation of future data |
| VETransportSupplyUse | [CalculateCongestionFuture](#calculatecongestionfuture)     | **AveSpeedLtVehFuture**     | Average speed for light vehicles in the region calculated using model  estimation of future data |
| VETransportSupplyUse | [CalculateCongestionFuture](#calculatecongestionfuture)     | **AveSpeedBusFuture**       | Average speed for buses in the region calculated using model estimation  of future data |
| VETransportSupplyUse | [CalculateCongestionFuture](#calculatecongestionfuture)     | **AveSpeedTruckFuture**     | Average speed for heavy trucks in the region calculated using model  estimation of future data |
| VETransportSupplyUse | [CalculateCongestionFuture](#calculatecongestionfuture)     | **FfVehHrLtVehFuture**      | Average free-flow travel time for light vehicles in the region calculated  using model estimation of future data |
| VETransportSupplyUse | [CalculateCongestionFuture](#calculatecongestionfuture)     | **FfVehHrBusFuture**        | Average free-flow travel time for buses in the region calculated using  model estimation of future data |
| VETransportSupplyUse | [CalculateCongestionFuture](#calculatecongestionfuture)     | **FfVehHrTruckFuture**      | Average free-flow travel time for heavy trucks in the region calculated  using model estimation of future data |
| VETransportSupplyUse | [CalculateCongestionFuture](#calculatecongestionfuture)     | **DelayVehHrLtVehFuture**   | Total vehicle delay time for light vehicles in the region calculated  using model estimation of future data |
| VETransportSupplyUse | [CalculateCongestionFuture](#calculatecongestionfuture)     | **DelayVehHrBusFuture**     | Total vehicle delay time for buses in the region calculated using model  estimation of future data |
| VETransportSupplyUse | [CalculateCongestionFuture](#calculatecongestionfuture)     | **DelayVehHrTruckFuture**   | Total vehicle delay time for heavy trucks in the region calculated using  model estimation of future data |
| VETransportSupplyUse | [CalculateCongestionFuture](#calculatecongestionfuture)     | **MpgAdjHhFuture**          | Average fuel efficiency adjustment for households in the region  calculated using model estimation of future data |
| VEHouseholdTravel    | [CalculateInducedDemand](#calculateinduceddemand)           | **DvmtFuture (households)** | Average daily vehicle miles traveled by household estimated using model  estimations of future year data |
| VEHouseholdTravel    | [CalculateInducedDemand](#calculateinduceddemand)           | **DvmtFuture (bzones)**     | Average daily vehicle miles traveled by place types estimated using model  estimations of future year data |
| VEHouseholdTravel    | [CalculateInducedDemand](#calculateinduceddemand)           | **Access**                  | Growth in job access                                         |
| VEHouseholdTravel    | [CalculateInducedDemand](#calculateinduceddemand)           | **VehicleTrips**            | Policy adjusted vehicle trips                                |
| VEHouseholdTravel    | [CalculateInducedDemand](#calculateinduceddemand)           | **TransitTrips**            | Policy adjusted transit trips                                |
| VEHouseholdTravel    | [CalculateInducedDemand](#calculateinduceddemand)           | **Walking**                 | Growth in walking                                            |

#### Module Outputs

1. **DvmtPolicy (bzones)**: Average daily vehicle miles traveled by place types after policy adjustments
2. **DvmtPolicy (households)**: Average daily vehicle miles traveled by households after policy adjustments
3. **DvmtPolicy (vehicles)**: Average daily vehicle miles traveled by vehicles after policy adjustments
4. **LtVehiclesPolicy**: Number of light vehicles by households after policy adjustments
5. **LtVehAdjFactorPolicy**: Light vehicles adjustment factor for households
6. **TdmLtVehAdjFactorPolicy**: TDM Light vehicles adjustment factor for households
7. **TdmAdjFactorPolicy**: TDM adjustment factor for households
8. **LtVehDvmtPolicy**: Average daily vehicle miles traveled by light vehicles by households after policy adjustments
9. **FutureCostPerMilePolicy**: Total cost per mile for future year for each household estimated after making policy adjustments
10. **DailyParkingCostPolicy**: Daily parking cost calculated after making policy adjustments
11. **CashOutIncAdjPolicy**: Adjustment to income after cash out
12. **IncomePolicy**: Income of the households after applying policy
13. **CostsPolicy**: Various policy related energy costs

[Top](#contents)										[Definitions](#definitions)								[Inputs/Outputs](#inputs-and-outputs)  

------

### CalculateCongestionPolicy

This module is similar to [CalculateCongestionBase](#calculatecongestionbase) module but uses model estimation of future transportation supply adjusted to policies as the basis of calculations.

#### User Input Files

1. **Percent road miles with ITS treatment (*azone_its_prop.csv*)**: This file is an estimate of the proportion of road miles that have improvements which reduce incidents through ITS treatments in both the base and future years. Values entered should be between 0 and 1, with 1 indicating that 100% of road miles are treated.
   The ITS policy measures the effects of incident management supported by ITS. The ITS table is used to inform the congestion model and the travel demand model. The model uses the mean speeds with and without incidents to compute an overall average speed by road type and congestion level providing a simple level of sensitivity to the potential effects of incident management programs on delay and emissions.
   The ITS treatments are evaluated only on freeways and arterials. The ITS treatments that can be evaluated are those that the analyst considers will reduce non-recurring congestion due to incidents. This policy does not deal with other operational improvements such as signal coordination, or temporary capacity increases such as allowing shoulder use in the peak.
   Here is a snapshot of the file:

   | Geo       | Year | ITS  |
   | --------- | ---- | ---- |
   | Multnomah | 2005 | 0    |
   | Multnomah | 2035 | 0    |

2. **Truck and bus vmt (*region_truck_bus_vmt.csv*)**: This file contains the region’s proportion of VMT by truck and bus as well as the distribution of that VMT across functional classes (*freeway*, *arterial*, *other*). The file includes one row for bus VMT data and one row for Truck VMT data. It should be noted that it is not necessary to enter values in the **PropVmt** column for **BusVmt** as this is calculated using the values in the ***transportation_supply.csv*** user input file. The truck VMT proportion (PropVMT column, TruckVMT row) can be obtained from [Highway Performance Monitoring System](http://www.fhwa.dot.gov/policyinformation/hpms.cfm) data and local sources or the regional travel demand model if one exists.
   The proportions of VMT by functional class can be derived from the Federal Highway Cost Allocation Study and data from transit operators. The Federal Highway Cost Allocation Study (Table II-6, 1997 Federal Highway Cost Allocation Study Final Report, [Chapter II](http://www.fhwa.dot.gov/policy/hcas/final/two.cfm) is used to calculate the average proportion of truck VMT by functional class. Data from transit authorities are used to calculate the proportions of bus VMT by urban area functional class.
   Here is a snapshot of the file:

   | Type     | PropVmt | Fwy      | Art      | Other    |
   | -------- | ------- | -------- | -------- | -------- |
   | BusVmt   | 0       | 0.15     | 0.591854 | 0.258146 |
   | TruckVmt | 0.08    | 0.452028 | 0.398645 | 0.149327 |

#### User Input Parameters

1. **Light vehicle dvmt (*BaseLtVehDvmt*)**: Total light vehicle daily VMT for the base year in thousands of miles. This data can be derived from a combination of [Highway Performance Monitoring System](http://www.fhwa.dot.gov/policyinformation/hpms.cfm) data, Federal Highway Cost Allocation Study data, and regional data. Light vehicle daily VMT can be estimated by subtracting truck and bus VMT from total VMT provided in the Highway Performance Monitoring System (HPMS). Regional travel demand model outputs can also be used to derive these data. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

   ```json
   {
       "NAME" : "BaseLtVehDvmt",
       "VALUE": "27244",
       "TYPE" : "compound",
       "UNITS" : "MI/DAY",
       "PROHIBIT" : "c('NA', '< 0')",
       "ISELEMENTOF" : ""
   }
   ```

2. **Dvmt proportion by functional class (*BaseFwyArtProp*)**: The proportions of daily VMT for light vehicles that takes place on freeways and arterials (i.e., the remainder of VMT takes place on lower functional class roads for the base year. This data can be derived from a combination of [Highway Performance Monitoring System](http://www.fhwa.dot.gov/policyinformation/hpms.cfm) data, Federal Highway Cost Allocation Study data, and regional data. The proportions of light vehicle daily VMT on freeways and arterials can be derived from the HPMS data. Regional travel demand model outputs can also be used to derive these data. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

   ```json
   {
       "NAME" : "BaseFwyArtProp",
       "VALUE": "0.77",
       "TYPE" : "double",
       "UNITS" : "proportion",
       "PROHIBIT" : "c('NA', '< 0', '> 1')",
       "ISELEMENTOF" : ""
   }
   ```

3. **Transit revenue adjustment factor (*TranRevMiAdjFactor*)**: Factor to convert transit revenue miles (i.e. miles run in service on routes) to total transit vehicle miles operated to account for vehicle miles run while deadheading from depots to route endpoints. It should be defined in [model_parameters.json](#model_parametersjson) as follows:

   ```json
   {
       "NAME" : "TranRevMiAdjFactor",
       "VALUE": "1.12",
       "TYPE" : "double",
       "UNITS" : "multiplier",
       "PROHIBIT" : "c('NA', '< 0')",
       "ISELEMENTOF" : ""
   }
   ```

#### Internal Module Inputs

| Package              | Module                                                      | Outputs                   | Description                                                  |
| -------------------- | ----------------------------------------------------------- | ------------------------- | ------------------------------------------------------------ |
| VELandUse            | [CalculateBasePlaceTypes](#calculatebaseplacetypes)         | **UrbanPop**              | Total population by place types                              |
| VELandUse            | [CalculateFuturePlaceTypes](#calculatefutureplacetypes)     | **UrbanPop**              | Total population by place types                              |
| VETransportSupply    | [CreateFutureAccessibility](#createfutureaccessibility)     | **FwyLaneMiPCFuture**     | Ratio of urbanized area freeway and expressway lane-miles to urbanized  area population calculated using future (estimated) data |
| VETransportSupply    | [CreateFutureAccessibility](#createfutureaccessibility)     | **ArtLaneMiPCFuture**     | Ratio of urbanized area arterial lane-miles to urbanized area population  calculated using future (estimated) data |
| VETransportSupply    | [CreateFutureAccessibility](#createfutureaccessibility)     | **TranRevMiPCFuture**     | Transit revenue miles per capita for the region calculated using future  (estimated) data |
| VETransportSupply    | [CreateFutureAccessibility](#createfutureaccessibility)     | **BusRevMiFuture**        | Bus revenue miles for the region calculated using future (estimated) data |
| VETransportSupply    | [CreateFutureAccessibility](#createfutureaccessibility)     | **RailRevMiFuture**       | Rail revenue miles for the region calculated using future (estimated)  data |
| VEHouseholdTravel    | [CalculateTravelDemandFuture](#calculatetraveldemandfuture) | **TruckDvmtFuture**       | Average daily vehicle miles traveled by trucks estimated using model  estimations of future year data |
| VEHouseholdTravel    | [CalculatePolicyVmt](#calculatepolicyvmt)                   | **DvmtPolicy (bzones)**   | Average daily vehicle miles traveled by place types estimated using model  estimations of future year data |
| VETransportSupplyUse | [CalculateCongestionFuture](#calculatecongestionbase)       | **LtVehDvmtFactorFuture** | Light vehicle Dvmt factor adjustment factor                  |

#### Module Outputs

1. **LtVehDvmtPolicy**: Daily vehicle miles travelled by light vehicles in the region calculated using model estimation of future data after adjusting for policies
2. **BusDvmtPolicy**: Daily vehicle miles travelled by bus in the region calculated using model estimation of future data after adjusting for policies
3. **MpgAdjLtVehPolicy**: Average fuel efficiency adjustment for light vehicles in the region calculated using model estimation of future data after adjusting for policies
4. **MpgAdjBusPolicy**: Average fuel efficiency adjustment for buses in the region calculated using model estimation of future data after adjusting for policies
5. **MpgAdjTruckPolicy**: Average fuel efficiency adjustment for heavy trucks in the region calculated using model estimation of future data after adjusting for policies
6. **VehHrLtVehPolicy**: Total vehicle travel time for light vehicles in the region calculated using model estimation of future data after adjusting for policies
7. **VehHrBusPolicy**: Total vehicle travel time for buses in the region calculated using model estimation of future data after adjusting for policies
8. **VehHrTruckPolicy**: Total vehicle travel time for heavy trucks in the region calculated using model estimation of future data after adjusting for policies
9. **AveSpeedLtVehPolicy**: Average speed for light vehicles in the region calculated using model estimation of future data after adjusting for policies
10. **AveSpeedBusPolicy**: Average speed for buses in the region calculated using model estimation of future data after adjusting for policies
11. **AveSpeedTruckPolicy**: Average speed for heavy trucks in the region calculated using model estimation of future data after adjusting for policies
12. **FfVehHrLtVehPolicy**: Average free-flow travel time for light vehicles in the region calculated using model estimation of future data after adjusting for policies
13. **FfVehHrBusPolicy**: Average free-flow travel time for buses in the region calculated using model estimation of future data after adjusting for policies
14. **FfVehHrTruckPolicy**: Average free-flow travel time for heavy trucks in the region calculated using model estimation of future data after adjusting for policies
15. **DelayVehHrLtVehPolicy**: Total vehicle delay time for light vehicles in the region calculated using model estimation of future data after adjusting for policies
16. **DelayVehHrBusPolicy**: Total vehicle delay time for buses in the region calculated using model estimation of future data after adjusting for policies
17. **DelayVehHrTruckPolicy**: Total vehicle delay time for heavy trucks in the region calculated using model estimation of future data after adjusting for policies
18. **MpgAdjHhPolicy**: Average fuel efficiency adjustment for households in the region calculated using model estimation of future data after adjusting for policies
19. **LtVehDvmtFactorPolicy**: Light vehicle Dvmt factor adjustment factor calculated using model estimation of future data after adjusting for policies

[Top](#contents)										[Definitions](#definitions)								[Inputs/Outputs](#inputs-and-outputs)  

------

### ReportRPATMetrics

This module calculates performance metrics that are designed to address a variety of impacts that are helpful for decision-making. Following table summarizes various performance measures produced by this modules, details of which is discussed in [VEReports](https://github.com/visioneval/VisionEval/tree/master/sources/modules/VEReports).

| Performance Group              | Performance Metric                    | Units                    | Temporal Resolution |
| ------------------------------ | ------------------------------------- | ------------------------ | ------------------- |
| Direct Travel Impacts          | Daily Vehicle Miles Traveled          | Miles                    | Day                 |
| Direct Travel Impacts          | Daily Vehicle Trips                   | Trips                    | Day                 |
| Direct Travel Impacts          | Daily Transit Trips                   | Trips                    | Day                 |
| Direct Travel Impacts          | Average Travel Speeds by Vehicle Type | MPH                      | Day                 |
| Direct Travel Impacts          | Vehicle Hours of Travel Delay         | Hours                    | Day                 |
| Environment and Energy Impacts | Fuel Consumption                      | Gallons                  | Day                 |
| Environment and Energy Impacts | Greenhouse Gas Emissions              | Metric Tons              | Day                 |
| Financial and Economic Impacts | Regional Highway Infrastructure Costs | Dollars                  | Year                |
| Financial and Economic Impacts | Regional Transit Infrastructure Costs | Dollars                  | Year                |
| Financial and Economic Impacts | Regional Transit Operating Costs      | Dollars                  | Year                |
| Financial and Economic Impacts | Annual Traveler Cost (Fuel + Charges) | Dollars                  | Year                |
| Location Impacts               | Regional Accessibility                | Percent Change From Base | -                   |
| Community Impacts              | Accident Rates                        | Count                    | Year                |
| Community Impacts              | Walking Percentage Increase           | Percent Change From Base | -                   |
| Community Impacts              | Job Accessibility by Income Group     | Percent Change From Base | -                   |

#### User Input Files

1. **Transportation Costs (*model_transportation_costs.csv*)**: This file contains unit cost rates for transportation infrastructure investments and operating costs and transit fare revenue. The parameters are used in the calculations of the transportation costs performance metrics.
   The source for transit capital, operating costs, and fare revenue is the [NTD](https://www.transit.dot.gov/ntd), and in particular the National Transit Profile which is available on the NTDB website. Costs are available in a variety of index formats, e.g. cost per revenue mile or hour; cost per passenger trip is used in VERPAT.
   The source for highway infrastructure costs is FHWA’s Highway Economic Requirements System model, or HERS. Information was obtained from Chapter 6 of the 2005 Technical Report for all US states (FHWA, 2005). Table 8-1 in HERS provides unit costs (per lane mile) for both Rural and Urban highway systems, and distinguishes among three functional classes: interstates, freeways and expressways; other principal arterials; and minor arterials and collectors. Costs estimates are provided for the following improvements:

   - Reconstruction and widening
   - Reconstruct pavement
   - Resurface and widen lanes
   - Resurface pavement
   - Improve shoulders

   Additional choices are offered to distinguish between adding a lane at "normal" vs. "high cost", and also for pavement realignment, also under normal vs. high cost conditions. For practical reasons, it was decided to use only "new construction" (which also includes adding lanes) costs as the basis for the cost estimates, and to ignore the categories of reconstruction, resurfacing, and realignment. These construction costs include right of way, construction, and a "small" allowance for bridges and support facilities.
   The infrastructure costs focus only on the "urban" system, not rural, which also makes it possible to differentiate by three size classes: Small Urban, Small Urbanized, and Large Urbanized. The numbers from HERS are in 2002 dollars; FHWA advises escalation to current dollars using its NHCCI, which is available online at http://www.fhwa.dot.gov/policyinformation/nhcci.cfm); the report in VERPAT escalates uses this Index to escalate to 2010 values.
   The parameter values in this file are average values per lane mile, simplifying the calculations of highway costs to just differentiate investments in freeway vs. arterial functional class roads.
   Here is a snapshot of the file:

   | SupplyClass | CapCosts.2000 | OpCosts.2000 | Fare.2000 |
   | ----------- | ------------- | ------------ | --------- |
   | Freeway     | 17            | 0            | 0         |
   | Arterial    | 7             | 0            | 0         |
   | Bus         | 0.71          | 3.4          | 0.91      |
   | Rail        | 5.11          | 4.87         | 2.19      |

2. **Accident Rates (*model_accident_rates.csv*)**: Road safety impacts are calculated by factoring the amount of VMT. The following national average rates, from the Fatality Analysis Reporting System General Estimates System (2009) by US Department of Transportation, are applied to calculate the number of fatal and injury accidents and the value of property damage:

   - Fatal: 1.14 per 100 Million Miles Traveled
   - Injury: 51.35 per 100 Million Miles Traveled
   - Property damage: 133.95 per 100 Million Miles Traveled

   Here is a snapshot of the file:

   | Accident | Rate   |
   | -------- | ------ |
   | Fatal    | 1.14   |
   | Injury   | 51.35  |
   | Property | 133.95 |

#### Internal Module Inputs

| Package              | Module                                                      | Outputs                     | Description                                                  |
| -------------------- | ----------------------------------------------------------- | --------------------------- | ------------------------------------------------------------ |
| VESimHouseholds      | [CreateHouseholds](#createhouseholds)                       | **HhId**                    | Unique household ID                                          |
| VELandUse            | [CalculateFuturePlaceTypes](#calculatefutureplacetypes)     | **HhPlaceTypes**            | A place type as assigned to the households                   |
| VELandUse            | [CalculateFuturePlaceTypes](#calculatefutureplacetypes)     | **UrbanPop**                | Total population by place types                              |
| VETransportSupply    | [CreateFutureAccessibility](#createfutureaccessibility)     | **FwyLaneMiPCFuture**       | Ratio of urbanized area freeway and expressway lane-miles to urbanized  area population calculated using future (estimated) data |
| VETransportSupply    | [CreateFutureAccessibility](#createfutureaccessibility)     | **ArtLaneMiPCFuture**       | Ratio of urbanized area arterial lane-miles to urbanized area population  calculated using future (estimated) data |
| VETransportSupply    | [CreateFutureAccessibility](#createfutureaccessibility)     | **TranRevMiPCFuture**       | Transit revenue miles per capita for the region calculated using future  (estimated) data |
| VETransportSupply    | [CreateFutureAccessibility](#createfutureaccessibility)     | **BusRevMiFuture**          | Bus revenue miles for the region calculated using future (estimated) data |
| VETransportSupply    | [CreateFutureAccessibility](#createfutureaccessibility)     | **RailRevMiFuture**         | Rail revenue miles for the region calculated using future (estimated)  data |
| VEHouseholdVehicles  | [AssignVehicleFeaturesFuture](#assignvehiclefeaturesfuture) | **VehIdFuture**             | Unique vehicle ID                                            |
| VEHouseholdVehicles  | [AssignVehicleFeaturesFuture](#assignvehiclefeaturesfuture) | **TypeFuture**              | Vehicle body type: Auto = automobile, LtTrk = light trucks (i.e. pickup,  SUV, Van) |
| VEHouseholdVehicles  | [AssignVehicleFeaturesFuture](#assignvehiclefeaturesfuture) | **MileageFuture**           | Mileage of vehicles (automobiles and light truck)            |
| VEHouseholdVehicles  | [AssignVehicleFeaturesFuture](#assignvehiclefeaturesfuture) | **VehiclesFuture**          | Number of automobiles and light trucks owned or leased by the household |
| VEHouseholdTravel    | [CalculateTravelDemandFuture](#calculatetraveldemandfuture) | **TruckDvmtFuture**         | Average daily vehicle miles traveled by trucks estimated using model  estimations of future year data |
| VEHouseholdTravel    | [CalculateTravelDemandFuture](#calculatetraveldemandfuture) | **FuelGallonsFuture**       | Average daily fuel consumption in gallons by each household estimated  using model estimations of future year data |
| VEHouseholdTravel    | [CalculateTravelDemandFuture](#calculatetraveldemandfuture) | **FuelCo2eFuture**          | Average daily Co2 equivalent greenhouse gas emissions by each household  estimated using model estimations of future year data |
| VEHouseholdTravel    | [CalculateInducedDemand](#calculateinduceddemand)           | **TransitTrips**            | Policy adjusted transit trips                                |
| VEHouseholdTravel    | [CalculatePolicyVmt](#calculatepolicyvmt)                   | **DvmtPolicy (bzones)**     | Average daily vehicle miles traveled by place types after policy  adjustments |
| VEHouseholdTravel    | [CalculatePolicyVmt](#calculatepolicyvmt)                   | **DvmtPolicy (households)** | Average daily vehicle miles traveled by households after policy  adjustments |
| VEHouseholdTravel    | [CalculatePolicyVmt](#calculatepolicyvmt)                   | **DvmtPolicy (vehicles)**   | Average daily vehicle miles traveled by vehicles after policy adjustments |
| VEHouseholdTravel    | [CalculatePolicyVmt](#calculatepolicyvmt)                   | **LtVehDvmtPolicy**         | Average daily vehicle miles traveled by light vehicles by households  after policy adjustments |
| VEHouseholdTravel    | [CalculatePolicyVmt](#calculatepolicyvmt)                   | **DailyParkingCostPolicy**  | Daily parking cost calculated after making policy adjustments |
| VETransportSupplyUse | [CalculateCongestionPolicy](#calculatecongestionpolicy)     | **LtVehDvmtPolicy**         | Daily vehicle miles travelled by light vehicles in the region calculated  using model estimation of future data after adjusting for policies |
| VETransportSupplyUse | [CalculateCongestionPolicy](#calculatecongestionpolicy)     | **BusDvmtPolicy**           | Daily vehicle miles travelled by bus in the region calculated using model  estimation of future data after adjusting for policies |
| VETransportSupplyUse | [CalculateCongestionPolicy](#calculatecongestionpolicy)     | **MpgAdjLtVehPolicy**       | Average fuel efficiency adjustment for light vehicles in the region  calculated using model estimation of future data after adjusting for policies |
| VETransportSupplyUse | [CalculateCongestionPolicy](#calculatecongestionpolicy)     | **MpgAdjBusPolicy**         | Average fuel efficiency adjustment for buses in the region calculated  using model estimation of future data after adjusting for policies |
| VETransportSupplyUse | [CalculateCongestionPolicy](#calculatecongestionpolicy)     | **MpgAdjTruckPolicy**       | Average fuel efficiency adjustment for heavy trucks in the region  calculated using model estimation of future data after adjusting for policies |
| VETransportSupplyUse | [CalculateCongestionPolicy](#calculatecongestionpolicy)     | **MpgAdjHhPolicy**          | Average fuel efficiency adjustment for households in the region  calculated using model estimation of future data after adjusting for policies |

#### Module Outputs

1. **EmissionsMetric**: The amount of greenhouse gas emissions per day by place-types
2. **FuelMetric**: The amount of fuel consumed per day by place-types
3. **CostsMetric**: The annual traveler cost (fuel + charges)
4. **FuelGallonsMetric**: Average daily fuel consumption in gallons after policy
5. **FuelCo2eMetric**: Average daily Co2 equivalent greenhouse gas emissions after policy
6. **FutureCostPerMileMetric**: Total fuel cost per mile after policy
7. **TotalCostMetric**: Total fuel cost after policy
8. **RailPowerMetric**: Annual power consumption by rail
9. **TruckFuelMetric**: Annual truck fuel consumption
10. **BusFuelMetric**: Annual bus fuel consumption
11. **TruckCo2eMetric**: Annual greenhouse gas emissions by truck
12. **BusCo2eMetric**: Annual greenhouse gas emissions by bus
13. **RailCo2eMetric**: Annual greenhouse gas emissions by rail
14. **HighwayCostMetric**: Regional highway infrastructure costs
15. **TransitCapCostMetric**: Regional transit infrastructure costs
16. **TransitOpCostMetric**: Regional transit operating costs
17. **TransitRevenueMetric**: Annual fare revenue
18. **FatalIncidentMetric**: Number of fatal incidents
19. **InjuryIncidentMetric**: Number of incidents with injuries
20. **PropertyDamageMetric**: Amount of incidents with property damage
21. **TruckConsumptionMetric**: Annual truck fuel consumption by fuel type
22. **BusConsumptionMetric**: Annual bus fuel consumption by fuel type

[Top](#contents)										[Definitions](#definitions)								[Inputs/Outputs](#inputs-and-outputs)  
## Development and Installation

This section describes the installation and usage of VERPAT.

### Installation of VisionEval and VERPAT

VERPAT and the VisionEval framework are implemented in R, a statistical programming language and environment.  Both R and VERPAT are open source and freely available.  The installation of VERPAT is a two-step process.

1. Install R
2. Install VisionEval and VERPAT

These are described in [[Getting Started: Installation and Setup | Getting-Started#installation-and-setup]].  

### Running the VERPAT model

Once VisionEval and VERPAT have been installed, a directory with sample data for Multnomah County, Oregon will be present at `../VisionEval/sources/models/VERPAT`. (Note `..` refers to the parent directory of the installation directory). 

The `VERPAT` directory serves the dual purposes of providing sample data and serving as a template for local modification to other locations. 

It contains two subdirectories and several files:

<img align="center" width="500" border=1 src="VERPAT-Tutorial-images/verpat_model_directory.png">


The `defs` directory contains five [[model definition files | VERPAT-Inputs-and-Parameters#model-definition-files]], also described in the [Model System Design document](https://github.com/visioneval/VisionEval/blob/master/api/model_system_design.md#61-model-directory-structure).  These contain settings that define the model run.

The `inputs` directory contains a number of CSV and JSON files that provide inputs for the modules.  Each module specifies what input files it needs.  These are described in [[Input Files | VERPAT-Inputs-and-Parameters#input-files]] and in the [Model System Design document](https://github.com/visioneval/VisionEval/blob/master/api/model_system_design.md#64-model-inputs).  

<img align="center" width="500" border=1 src="VERPAT-Tutorial-images/verpat_model_directory_expand.png">

To change the conditions in the model, these input files are modified (see [Modifying the scenario](#modifying-the-scenario)). 

The `run_model.R` file is described in the [Model System Design document](https://github.com/visioneval/VisionEval/blob/master/api/model_system_design.md#5-model-system-layers) and consists of calls to the modules that make up the model. 

[ ![](VERPAT-Tutorial-images/verpat_run_model.png) ](VERPAT-Tutorial-images/verpat_run_model.png)

To run this file in R, see instructions at [[Getting Started: Running VE Models | Getting-Started#running-ve-models]].  That page describes running VERPAT via both the [R console](https://github.com/visioneval/VisionEval/wiki/Getting-Started#running-verpat-or-verspm-from-within-r) and using [VEGUI](https://github.com/visioneval/VisionEval/wiki/Getting-Started#running-vegui-from-github-to-run-verpat-or-verspm).   

The remaining files in the directory are `README.md`, a brief text file with a link to [[Getting Started]], and `VERPAT.Rproj`, a file for use with RStudio (a text editor and integrated development environment for R).


#### Modifying the scenario

As described above, the `VisionEval/sources/models/VERPAT` directory contains sample input files for Multnomah County, Oregon.  These can be modified or replaced to investigate the impacts of policy changes or to model a different region.  

To modify a scenario, the appropriate input files are edited.  For example, to increase bicycle usage, the file [`inputs/region_light_vehicles.csv`](https://github.com/visioneval/VisionEval/wiki/VERPAT-Inputs-and-Parameters#region_light_vehiclescsv) would be modified in Excel, LibreOffice, or a text editor to change the `DataValue` of `TargetProp` from 0.2 to 0.4:

<img align="center" width="500" border=1 src="VERPAT-Tutorial-images/verpat_region_light_vehicles.png">

The required input files are described in detail in the [Model System Design document](https://github.com/visioneval/VisionEval/blob/master/api/model_system_design.md#6-model-layer-description).  

#### Model output

The output data are contained in a *datastore*, which can be either an HDF5 file or a directory of RData files.  The datastore is described in detail in the [Model System Design document](https://github.com/visioneval/VisionEval/blob/master/api/model_system_design.md#65-the-datastore).  

In this case (below), the datastore is a directory of RData files. It has a hierarchical structure, with directories for each year that the model is run, plus a `Global` folder for output that is not year specific.  

<img align="center" width="500" border=1 src="VERPAT-Tutorial-images/verpat_datastore.png">

The year directories contain subdirectories for each geographic level, each containing RData files.

<img align="center" width="500" border=1 src="VERPAT-Tutorial-images/verpat_datastore_2005_Azone.png">

The `Global` directory contains data that do not vary by model run year such as model parameters or geographic tables.

<img align="center" width="500" border=1 src="VERPAT-Tutorial-images/verpat_datastore_global.png">

Each of the Rda files contains a single R vector called `Dataset` with attributes describing the data.

#### Exporting Data to CSV

At the end of the model run, a subset of the data are automatically exported from the Datastore to a set of CSV files.  These files will be placed in the model directory in a subfolder called `outputs`.   To export data manually, the script located in `../sources/models/export_output_to_csv.R` can be modified to suit.


