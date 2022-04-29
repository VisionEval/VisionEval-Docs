# VisionEval Tutorial 101 {#tutorial}

This chapter provides an introductory walkthrough on how to set up a VisionEval model specific to your area of interest. This chapter does not cover how to install and run VisionEval, those instructions are covered in the [Getting Started][Getting Started] chapter. 

The application process can be broken down into several steps, described in the following sections:

* [Picking a model](#picking-a-model)
* [Selecting model geography and years](#model-geography-and-run-years)
* [Developing inputs (generalized best practices)](#developing-inputs)
* [Validating a base model](#validation)
* [Running multiple scenarios](#running-multiple-scenarios)
* [Customizing packages](#customizing-packages)

## Picking a Model

The VisionEval system is comprised of three models:

* **VERSPM** - The RSPM (Regional Strategic Planning Model) was developed by ODOT as an offshoot of the GreenSTEP model to
support the preparation of metropolitan area scenario plans. The name reflects a broadening of the policies, beyond state statutory requirements.  This model operates largely at the zonal level (i.e. inputs and outputs are zone-based).
* **VERPAT** - The RPAT (Rapid Policy Analysis Tool) was developed under the federal Strategic Highway Research Program (SHRP2).  The model was developed to help planners evaluate the potential effect of growth policies on regional travel. Portions of the GreenSTEP model were used in RPAT, but substantial revisions were made to the code, including use of land use place type categories.  This model operates largely at the region or place type level for the entire region.
* **VE-State** - The VE-State model is a state level version of VERSPM.  Like VERSPM, this model operates at the zonal level, but the zones are larger than their VERSPM counterparts.

### Spatial Detail

Although VERSPM and VERPAT are both regional models, one key distinction between the two models is the level of spatial detail.  

* VERPAT operates primarily at the region level and therefore requires inputs at the region or place type level.  As shown below, place types are defined as a combination of area type and development type.  Area type (or regional role) describes the interdependencies of each neighborhood compared to the rest of the region, e.g. how centered is it to jobs in the region.   Development type (or neighborhood character) is used to describe the physical characteristics of each neighborhood in isolation.  Operating at the place type level simplifies the input data requirements and the spatial precision of outputs while still capturing the effects of the different place types in the region.  Take a look at the example model [inputs](https://github.com/gregorbj/VisionEval/tree/master/sources/models/VERPAT/inputs), which has only one input by bzone - population and employment - which represents population and employment for each place type.
* VERSPM models the region in zones (in a manner similar to traditional travel model zones), which results in improved spatial resolution of outputs, but which also increases the data development burden.  The selection of the right tool therefore depends on a number of factors – available of data, project resources, desired spatial output detail, etc.  Take a look at the example model [inputs](https://github.com/gregorbj/VisionEval/tree/master/sources/models/VERSPM/Test1/inputs), which has many inputs by bzones.


## Model Geography and Run Years

Inputs in VisionEval are developed for every model year. Most applications consist of a base year and a future year. If the model area has a travel demand model available, it is good practice to align the VisionEval model years with those in the travel demand model, allowing the user to use the travel demand model to develop VisionEval inputs and validate the VisionEval Model. VisionEval may be used to model interim years, however each year modeled requires additional input data. 

All VisionEval models share a common geography framework. Input data is developed at several different geographies. 

* The **region** level is the entire model area. Large-scale characteristics that do not vary across the region are specified at the region level. For example, the carbon intensities of vehicle fuels are defined at the region level since they tend not to vary widely across a large geographic area. Typically, in a VERSPM model the region level is the metropolitan planning region being modeled, for VE-State it's the entire state.
*	**Azones** are large subdivisions of the region level. Azones are used to represent population and economic characteristics that vary across the region such as demographic forecasts of persons by age group and average per capita income. County boundaries are commonly used to represent azones in both VE-State. In VERSPM, county or municipal boundaries are commonly used.
*	**Bzones** are subdivisions of azones. Bzones are nested within azones and provide more granularity on the intensity and nature of development. Inputs are only developed at the bzone level in VERSPM; examples of bzone inputs include housing and population density. Common bzone boundaries for VERSPM are TAZs, Census Tracts, or Census Block Groups. In VE-State, bzones are simulated and do not represent physical geographic boundaries. Bzones in VE-State are synthesized to represent characteristics likely to be found in an actual set of bzones within each azone, such as neighborhood density. 
* **Mareas** represent metropolitan urbanized areas and are comprised of several azones. The model system requires that each azone may be associated with only one marea. Azones are associated with an marea either because a portion of the urbanized area is located in the azone or because a substantial proportion of the workers residing in the azone work at jobs located in the urbanized area. A special Marea named 'None' is used to apply to azones that are not associated with any urbanized area. Mareas are used to specify and model urbanized area transportation characteristics such as overall transportation supply (transit, highways) and congestion. 
* **Location Type** is not a geography level but a categorical level that identifies whether households are urban/town/rural.
* **Place Type** not a geography level but defines the level of urbanization (area type) and mixing of jobs and housing (development type).

## Developing Inputs
All input files are csv-formatted text files. The names of the file identify the geography level for the input data. For example, azone_hh_pop_by_age.csv is the input for household population by age, and should have data at the azone level. Each input file has:

* **Field names** identifying dataset names
* **Year** field when inputs vary by model year
* **Geo** field when inputs vary by geography

Field names can also have modifiers, such as the year that money values are denominated in (e.g. 2010) or magnitude multiplier for large numbers (e.g. 1e3). Input specifications, which can be located in the source code for each module as well as the module documentation, can be referenced when users are unsure of the input data type, units, and any prohibited values. In formatting input files, users should pay attention to the following:

* Need values for every combination of year and geography
* Field names must exactly match specifications
* Values must match specification data type and not contain any prohibited values 
* No data for years other than model run years
* No data for areas other than those defined in geo.csv file

The rest of this section will contain generalized best practices for input development applicable to all VisionEval models. While inputs specific to each model may differ slightly, it is recommended for more beginner users to start with the input tutorial information included in this chapter before proceeding to the more detailed input information on inputs specific to a each model, accessible at the following sections in each model's documentation:

* VERSPM inputs
* VE-State inputs
* VERPAT inputs

### Set-up Inputs
The set-up inputs are those in the **defs** directory. Most of these files shouldn’t change much from the download, unless users want their own deflators, etc. The exception is the geo.csv file which will need to be developed to inform the model geography. Below is an example of the geographic structure of Oregon DOT's VE-State model.

**ODOT’s VE-State Geographies (geo.csv)**

* Azones = Counties; Mareas = MPOs (can be multi-county)
* Location Type (Urbanized, Town, Rural) = MPOs are “Metro”, urban growth boundaries (UGBs) smaller than MPOs are “Town”, rest is “Rural”
* (VE-State only) Marea Area Types (Center, Inner, Outer, Fringe) = based on VE-State EAP-SLD-based definition here.  ODOT builds TAZ-level place type maps for all MPOs to generate. 
* (VERSPM only) Marea definition: “Urbanized” portion of a select set of Azones that are associated with a common urbanized area; often separate models are applied for Mareas, so information on road, transit and urban-mixed use variables, only present there can be applied (most notably VMT and other mode usage).  Marea is typically equivalent to a “census urbanized area” definition.

Mareas do not include “town” location types within the Marea counties. As such, "towns" in the Marea counties typically fall outside of the continuous urbanized area (i.e. census urbanized area). Some exceptions may be made if the outside areas are contiguous enough with the official urbanized area or will be in the horizon of the modeled scenarios, such that they will use common (high frequency) transit systems, and share the same road/congestion. Some examples of this are Eugene VE model including the city of Coburg as "urbanized" rather than a "town" and Portland including Ridgefield in the urbanized area.  The recommendation can be summarized as designating an Marea city outside the census "Urbanized area" definition as “towns” unless: (1) they are continguous to the larger urbanized area, or will be in the planning horizon, or (2) if they have significant transit service, road congestion that the “town” formulas will not account for. 

### Household Synthesis Inputs 
The demographic and land use inputs are those related to population, employment, and income that result in the household synthesis. VisionEval takes user input statewide population by age group, assembles them into households with demographic attributes (lifecycle, per capita income). 

* **Pool of Available Households.** Modelwide, Census PUMS data represents actual households and representative mix of household composition and demographics for your area it is built into the code (must rebuilt VESimHousehold package for local PUMS data, Oregon data is the default, see [instructions to rebuilt packages])
 
* **Population by Age Control Totals.** For population inputs, VisionEval models distinguish between the *regular household population* and *group quarter population* due to distinct differences in travel behaviors.  Zone-level inputs for (1) regular households and (2) group quarters households (can be 0) include population by [`age group`]() and average per capita income. Base year totals for the household population can be obtained from Census. Future year forecasts  should be consistent with but may need to be extrapolated beyond adopted regional plans (e.g., RTP, County and City TSPs).  Some local governments may have detailed age information generated as part of a Housing Needs Analysis completed for the Periodic Review of the local Comprehensive Plan. If not, future population by age can apply ratios from the base year model set-up. Group quarters population data is best obtained from the university administration, by age if possible.  Group quarters can be approximated from enrollment data by class year. All other group quarters data (e.g., income) are difficult to obtain but not of paramount importance to the model, simplifying assumptions are often required. Per capita income can be obtained from either the Census or Bureau of Economic Analysis. Since the model accounts for inflation, future income can remain the same in future years, or adjusted based on local plans. 

* **Optional Household adjustments.** (Optional) constraints on regular households include average household size and proportion of single-person households, adjustments to [`licensure rate`]() for driving age persons. Household size values can be obtained from the Census and lisensure data can be obtained from the state DMV.

* **Employment.** VERSPM employment inputs require [`employment by type`]() in each model year by bzone). VE-State requires workers by [`location type`]() (Optional) constraints on aggregated [employment rate`]() for working age persons (azone). 

### Land Use Inputs
Once households are synthesised, VisionEval allocates them to bzone-level dwelling units inputs. Separately Bzones are attributed with employment and land use attributes (location type, built form ‘D’ values, mixed use, employment by type). Household members are identified as workers and/or drivers and number of household vehicles are estimated. Each home and work location is tied to a specific Bzone with its associated attributes. Additionally, some local policies are land use based.

* **Dwelling Units.** Numbers of [`dwelling units by type`]() in each model year and proportions of each in each [`development type`](). Income quartiles tied to households in dwelling units help VisionEval assign households to a compatible Bzone location. The base year dwelling unit data can sourced from either the Census or an available travel demand model. Future year dwelling units can be obtained from local Comprehensive Plans. Adjustments may be needed to count only occupied units, and occupancy rates can be obtained from Census block group data, as a starting point. Base and future year dwelling unit counts should be consistent with household assumptions in the region’s travel demand model.

* **Land Use.** Inputs set the total [`developable land area`](), by [`development type`](). VERSPM also requires its location (centroid latitude-longitude) for spatially linking to source data, and input assumptions on the built form [`Design 'D'`](). These inputs can change by model run year. Some land use data use EPA SLD data. Geospatial SLD data can be downloaded at the block group level and extrapolated to other geographies if needed using just used the EPA block group data.
     
* **Land Use-Household linkages.** VisionEval assigns a BZone to each household's home and to each household worker's work location, with the associated BZone attributes. The VisionEval-calculated [`urban mixed use`]() designation of the bzone can optionally be modified by input targets on the proportion of households assigned that designation in each Bzone  in this process.

**Note:**  Input files must be consistent.  This includes: (1) land area must be specified for each azone location type that has households or employment assigned to it; (2) dwelling units must be a reasonable match with population (divided by houssehold size); (3) shares of jobs within each AZone must sum to 1 for all Azones in the Marea.

#### Defining “Location Type” (metro, town, rural)
One method is to define land in MPO boundaries to be **metro**, for urban areas smaller than MPOs, land inside their UGB is a **town**. Everything else is **rural**. Note that if you want to further refine within the MPO, place types can identify low density areas that you might consider “rural” and areas that less accessible/more isolated (don’t have access to broader transit service) as “town”. Some states have official population forecasts done for each urban area that helps with the population inputs. Users can also use LEHD where we used the boundaries identified above to designate location types, and then used LEHD to calculate worker flows between county home location-to-work LocType (any county).

An alternative method is to use the [Census Urban and Rural Classification](https://www.census.gov/programs-surveys/geography/guidance/geo-areas/urban-rural/2010-urban-rural.html). The Census Urban and Rural Classification distinguishes between two types of urban areas: 

*	Urbanized Areas (UAs) of 50,000 or more people are defined as **metro**
*	Urban Clusters (UCs) of at least 2,500 and less than 50,000 people are definied as **town**
* Everything else is **rural**

#### Defining "Area Type" (center, inner, outer, fringe)
“Area Type” is based on a mix of activity density levels and destination accessibility levels, as disussed in VE-State EAP-SLD-based documentation here.  

ODOT uses place types by local travel model TAZ within MPOs (MAreas), and generate VE input for these 2 dimensions (see below calculations) from pop & emp data by TAZ. By using local travel model TAZ data which has base and fute pop & emp, we can create a future version of these 2 variables and thus the VE-State area type inputs we calculate cover different areas over time: 

* activity density  = TAZ-level (HHs+Emp+GQ/2.5)/unprotected acres(parks & water removed)  .  SLD D1B is roughly the same.
* destination accessibility = TAZ-level as shown below.  There’s not an equivalent SLD attribute, but some of the D5* attributes are similar.
* Destination accessibility (D5)Harmonic mean of Employment within 2 mi and Pop within 5mi  
(2 * TotEmp_InDist2mi * Pop_InDist5mi) / (TotEmp_InDist2mi + Pop_InDist5mi). 
Levels:  VL = 0 - 2e3, L = 2e3 - 1e4, M = 1e4 - 5e4, H = 5e4+.

For the design VE-State input, here is the equivalent SLD attribute
* Design... =  (d3bpo4)

### Household Travel Behavior Inputs
Many of the inputs relating to household multi-modal travel are those that also can serve as policy levers to be tested in multi-run scenario exercises. Users should work with stakeholders to refine these values and finalize reference scenario inputs that reflect financially constrained adopted plans in their area. These discussions with local staff also start to define more/less ambitious scenarios to include in the multi-run scenario modeling.

* **Transport Supply(metropolitan areas only).**
Inputs define roadway capacity (lane-miles of arterials and freeways) and transit service levels (annual revenue service miles for each of the 8 transit modes) for the urbanized area portion of each Marea by model run year. A separate Bzone-level input sets neighborhood transit accessibility or [`Transit D`]().  [[marea_lane_miles.csv]()][[marea_transit_service.csv]()][[bzone_transit_service.csv]()]
* **Personal Short Trip/Alt Modes.**  Use policies for transit, bike and walk modes include: transit service levels and transit accessibility ([`Transit D`]()) [per Transit Supply above]; Goals for the proportion of SOV diversion (20 miles or less round-trip); while walk is dependent upon....[azone_prop_sov_dvmt_diverted.csv] 
* **Travel Demand Management.**  [[bzone_travel_demand_mgt.csv]()]
* **Car Service.** See [Household Costs & Budgets](https://github.com/VisionEval/VisionEval/wiki/VE-Inputs-by-Concept--UNDER-CONSTRUCTION#inputs-5-household-costs--budgets) for service levels, geographic coverage, and fees. See [Vehicles, Fuels & Emissions](https://github.com/VisionEval/VisionEval/wiki/VE-Inputs-by-Concept--UNDER-CONSTRUCTION#inputs-3-vehicles-fuels-and-emissions) and for fleet characteristics.  
* **Parking.** See [Household Costs & Budgets](https://github.com/VisionEval/VisionEval/wiki/VE-Inputs-by-Concept--UNDER-CONSTRUCTION#inputs-5-household-costs--budgets) for geographic coverage and fees. 

Transportation Options Programs

In RSPM, each household is assigned as a participant or not in a number of travel demand management programs (e.g. employee commute options program, individualized marketing) based on policy assumptions about the degree of deployment of those programs and the household characteristics.   Individual households are also identified as candidate participants for car sharing programs based on their household characteristics and input assumptions on the market penetration of car sharing vehicles.  

Workplace TDM Programs

Level of deployment assumptions for TDM (at work and home locations) lead to reduced VMT, diverting travel to other modes.  Car Sharing reduces VMT through changes in auto ownership and per mile costs. 
Employee commute options (ECO) programs are work-based travel demand management programs. They may include transportation coordinators, employer-subsidized transit passes, bicycle parking, showers for bicycle commuters, education and promotion, carpool and vanpool programs, etc. The default assumption is that that ECO programs reduce the average commute DVMT of participating households by 5.4%.  It is assumed that all work travel of the household will be reduced by this percentage if any working age persons are identified as ECO participants
The proportion of employees participating in ECO programs is a policy input at the district level (prop_wrk_eco.csv).  The input assumes workers participate in a strong employee commute options programs (e.g., free transit pass, emergency ride home, bike rider facilities, etc.).  

Individualized Marketing Program 

Individualized marketing (IM) programs are travel demand management programs focused on individual households in select neighborhoods. IM programs involve individualized outreach to households that identify residents’ travel needs and ways to meet those needs with less vehicle travel. Customized to the neighborhood, IM programs work best in locations where a number of travel options are available. RSM assumes that households participating in an IM program reduce their DVMT by 9% based on studies done in the Portland area. IM programs target work as well as non-work travel and produce larger reductions than ECO work-based programs. Only the IM reduction is used for households that are identified as participating in both ECO and IM programs.

RSPM district-level inputs for IM programs (imp_prop_goal.csv) include an overall assumption for the percentage of households participating in an IM program.  A minimum population density of 4,000 persons per square mile necessary to implement a successful IM program and the requirement that the household reside an urban mixed-use district. The number of households identified as participating is the minimum of the number needed to meet the program goal or the number of qualifying households.


### Vehicle, Fuels and Emissions Inputs

Vehicle and Fuel Technology are expected to change significantly during the next 20-50 years as vehicles turn-over and the newer fleets are purchased.  The characteristics of the fleet of new cars and trucks are influenced by federal CAFÉ standards as well as state energy policies and promotions.  Local areas can contribute through decisions about the light-duty fleet used by local transit agencies and by assisting in deployment of electric vehicle charging stations and their costs in work and home locations, but otherwise have less influence on the characteristics of the future vehicle fleet, including auto, light truck, and heavy truck vehicles.   As a consequence, the RSPM inputs on vehicle and fuel technology are largely specified at the state level.  These include inputs that reflect the default assumptions included in the Metropolitan GHG target rules and a more aggressive future as specified in the Oregon Statewide Transportation Strategy.  These will both be available to provide sensitivity test to assess their impact on energy use and GHG emissions in the metropolitan area.

The key local contribution to these inputs is the bus electric/fuels inputs; although defaults can be used if no additional local data is available. These variables are briefly summarized below.

Vehicle age, fuel economy, and congestion 

Several input files specify vehicle attributes and fuel economy for autos, light trucks, heavy truck, and transit vehicles.  Four vehicle powertrain types are modeled : 
•  ICE - Internal Combustion Engines  having no electrical assist; 
•  HEV - Hybrid-Electric Vehicles  where all motive power is generated on-board; 
•  PHEV - Plug-in Hybrid Electric Vehicles where some motive power comes from charging an on-board battery from external power supplies; 
•  EV - Electric Vehicles where all motive power comes from charging an on-board battery from external power supplies. 

Household owned vehicles -- sales mix; %LtTrks & veh age from household and the regional trends for its area.  These combine with sales mix (powertain mix). Each Powertrain in each year has an associated fuel efficiency and power efficiency assumptions for PHEVs (MPG for PHEVs in charge-sustaining mode). For EVs and PHEVs, battery range is specified.  
All other vehicles -- skip sales and jump directly to the mix of vehicles on the road in the modeled year, adjusted by inputs. 

User inputs on vehicle age adjustment factors by vehicle type and year. The purpose of this input is to allow scenarios to be developed which test faster or slower turn-over of the vehicle fleet
Households and commercial fleets operate a mix of passenger autos and light trucks or SUVs.  This mix has an impact on fuel economy.  In RSPM a file contains base year and target values for the proportion of the passenger vehicle fleet that is light trucks for each Metropolitan division (lttruck_prop.csv), 

NOTE: the actual EV-HEV split depends on whether enough households have their 95Th percentile daily travel within the EV battery range 

Vehicle Fuel Technology

A second set of inputs specifies the attributes of the fuels and their contributions to GHG emissions (fuel_co2.csv).  This file contains information on lifecycle CO2 equivalent emissions by fuel type in grams per mega joule of fuel energy content. Fuel types are ultra-low sulfur diesel (ULSD), Biodiesel, reformulated gasoline (RFG), CARBOB (California Reformulated Gasoline Blendstock for Oxygenate Blending), Ethanol, compressed natural gas (CNG), LtVehComposite. The latter category is a blend of the carbon values of all of the fuel types relative to the proportions in which they were used in 1990. This allows the model to be more easily run to simulate lower carbon content of fuels without having to specify the relative proportions of each specific fuel type.   The additives in fuel sold that contribute to GHG emissions.  These include the average ethanol proportion in gasoline and biodiesel proportion in diesel (auto_lighttruck_fuel.csv, comm_service_fuel.csv, heavy_truck_fuel.csv). 

Fuel Mix Shares (the remaining share is assumed to be diesel fuel):
  * PropGas – The proportion of bus miles using gasoline
  * PropCng – The proportion of bus miles using compressed natural gas

Biofuel Additives:
  * DieselPropBio – The biodiesel proportion of diesel fuel used
  * GasPropEth – The ethanol proportion of gasoline used

Electric Emissions Rate (Co2e lbs/ kwhr) of electricity consumed

Since electricity generation varies across the state, a local input to the model is the average cost and GHG emission rates of the local area.  The average cost of electricity per kilowatt hour (kWh) in dollars across the metropolitan study area is included in the file costs.csv, while the emissions rate (in average pounds of CO2 equivalents generated per kilowatt hour of electricity consumed by the end user) by district and forecast year is found in a separate input file (power_co2.csv).  Statewide default values for these inputs are available, if no local source is obtained.


* **Household vehicles and fuels**. Household vehicle characteristics by Azone and model run year, including [`vehicle type`]() shares, average vehicle age by [`vehicle type`]().  (optional) Region-wide composite fuel carbon intensity by [`vehicle type`]. Azone availability of residential electric vehicle charging stations by [`dwelling type'](), by model run year. 

* **CarService vehicles and fuels**.  Car service characteristics by Azone and model run year, including cost per mile by [`CarService Level`](), average age of car service vehicles, and limits on households’ [`substitutability`]() by [`vehicle type`]() for owned vehicles. Region-level inputs on [`powertrain`]() mix by model (not sales) year and (optional) region-wide composite fuel carbon intensity. 

* **Transit.** Transit vehicles characteristics by marea and model run year for [`transit vehicle types`]() (van, bus, rail), including [`powertain`]() mix by model (not sales) year and (detailed option)  fuel-biofuel shares.  Alternatively [`metropolitan area`]() or region-wide composite fuel carbon intensity may be input by [`transit vehicle types`]().

* **Freight Vehicles & Fuels.** [`Commercial Service`]() vehicle characteristics ([`Metropolitan areas`]() only) by azone and model run year, including [`vehicle type`]() shares, and average vehicle age by [`vehicle type`](). (optional) Region-wide composite fuel carbon intensity by [`vehicle type`](). Heavy Truck vehicle characteristics are region-level, including [`powertain`]() mix and composite fuel carbon intensity by model (not sales) year.

* **Electric Carbon Intensity.** Electricity [`carbon intensity`]() by AZone and model run year. [azone_electricity_carbon_intensity.csv]

|Vehicle Group|Vehicle Types|Powertrain Options|Veh Inputs|Fuel Options|Fuel input options|
|----|--------|-------|----------|----------|----------|
|Household|automobile, light truck|ICE, HEV, PHEV, EV|(default veh mix), age, %LtTrk|gas/ethanol, diesel/biodiesel, CNG/RNG|default, region composite|
|Car Service|automobile, light truck|ICE, HEV, EV|veh mix, age (HH veh mix)|gas/ethanol, diesel/biodiesel, CNG/RNG|default, region composite|
|Commercial Service|automobile, light truck|ICE, HEV, EV|veh mix, age, %LtTrk|gas/ethanol, diesel/biodiesel, CNG/RNG|default, region composite|
|Heavy Truck|heavy truck|ICE, HEV, EV|veh mix|gas/ethanol, diesel/biodiesel, CNG/LNG|default, region composite|
|Public Transit|van, bus, rail|ICE, HEV, EV|veh mix|gas/ethanol, diesel/biodiesel, CNG/RNG|default, fuel/biofuel mix, marea or region composite|

**Fuel Input Options**.  
Three options are available for fuel assumptions. The choices are outlined in the table above and the options described below. User choice of option can vary by [`vehicle group`]() and where applicable, [`vehicle type`]():
(1) Default package datasets.  These may represent federal or statewide fuel policies that apply to all [`metropolitan areas`]() and all [`vehicle groups`] in the model (e.g., state ethanol regulations, low carbon fuel policies). NAs would be placed in all user input files. 
(2) Detailed fuel and biofuel inputs. Values for the proportions of [`base fuels types`]() (gasoline, diesel, compressed natural gas), as well as [`fuel blend`]() proportions (gasoline blended with ethanol, biodiesel blended with diesel, renewable natural gas is blended with natural gas). A third assumption specifies the carbon_intenaity of the fuels (input or default). For example Hvy trucks can be set to 95% diesel, 5% natural gas, with diesel having a 5% biodiesel blend. 
(3) Composite carbon intensity. This option simplifies the process of modeling emissions policies, particularly low carbon fuels policies by bypasses the need to specify fuel types and biofuel blends. Average carbon intensity by [`vehicle group`]() and if applicable, [`vehicle type`]() is specified directly. These inputs, if present and not 'NA', supercede other transit inputs. 
 
Note:  Given that transit agencies in different metropolitan areas may have substantially different approaches to using biofuels, transit vehicles have the option of region or metropolitan area specifications for Options (1) and (2).  
Note: The proportions in option (2) do not represent volumetric proportions (e.g. gallons), they represent energy proportions (e.g. gasoline gallon equivalents) or DVMT proportions.
Note:  Individual vehicles are modeled for households. Other groups vehicle and fuel attributes apply to VMT.  As a result, PHEVs in all but household vehicles should be split into miles driven in HEVs and miles in EVs.

### Pricing, Household Costs & Budgets
Most of these will be state-led actions, reflecting your own local/state policies. 

* **Household CarService-Owned Auto substitution ** Per [Concept #1](), Car service characteristics by Azone and model run year, including cost per mile by [`CarService Level`](), average age of car service vehicles, and limits on households’ [`substitutability`]() by [`vehicle type`]() for owned vehicles. [azone_carsvc_characteristics.csv]

* **Per Mile Vehicle Out-Of-Pocket Costs.**  Input assumptions on per mile costs used in calculating User annual operating costs that may be limited by the household's income-based maximum annual travel budget. This includes energy costs, car service fees, and fees to recover road and social costs, as noted below. 

* **Energy Costs.** Unit cost of energy to power household vehicles, both fuel ($/gallon) and electricity ($/kilowatt-hour). 
* CarService Fees. If Car Service are used, the per mile fees paid for that service, outside of energy costs. Car service characteristics cost per mile by [`CarService Level`]() by Azone and model run year.[]
* Road Cost Recovery VMT fee. Inputs include per mile gas tax or levying a fuel-equivalent tax on travel by some/all electric vehicles (PevSurchgTaxProp), for their use of roads in lieu of gas purchases. User can also directly specify a VMT (mileage) fee, to further recover road costs, or (optional) flag VisionEval to iteratively estimate the VMT fee to fully recover road costs incurred by household VMT.  This user-estimated VMT fee, utilizes user inputs on unit costs for freeway and arterial operation, preservation, modernization, and other($/light-duty VMT or $/lane-mile). [xxxIs PCE used here or only in congestion model?][xxxflag??.csv][region_road_cost.csv][azone_veh_use_taxes.csv]
* Social Cost Recovery/Carbon Fees.  (Optional) Inputs allow per mile fee to cover social costs or externalities, not recovered in this way today, but instead incur costs elsewhere in the economy (e.g., safety, health).  This is the cost imposed on society and future generations, not the cost to the vehicle user. This requires assumptions on the cost incurred from these externalities (per mile, per gallon) and the proportion to be paid by drivers as a per mile fee (varies by vehicle powertrain).  The proportion of carbon costs (e.g., impact on fuel price from cap & trade policy) imposed on drivers is specified separately from other social costs, so it can be assessed on its own if desired; including (optionally) specifying the cost of carbon to over-ride the default value of carbon. [region_prop_externalities_paid.csv][region_co2e_costs.csv]
* **Per Mile Time-Equivalent Costs.**  Only included in XXX calculations...includes travel time (model-calculated), plus time to access vehicle on both ends of trip (between vehicle parking location and origin or end destination), multiplied by value of time (default model parameter).[azone_vehicle_access_times.csv][model_parameters.jsn]
* **Annual Vehicle Ownership costs.** Azone inputs by year includes annual vehicle fees (flat fee and/or tax on vehicle value), PAYD insurance participation rates, residential parking limitations and fees, that are combined with model-estimated ownership costs (financing, depreciation, insurance)  [azone_hh_veh_own_taxes.csv] [azone_payd_insurance_prop.csv]+ xxxConcept#1[Payd][res pkg]
* **Congestion Fees.** 

### Congestion Inputs
* **Base year VMT.** Base year VMT, both urban and state LDV, HvyTruck (default via state/UzaLookup or input) and growth basis for HvyTrk (population or income) and CommService VMT (population, income, or household VMT), share of LDV, HyTrk, Bus VMT on urban roads by [`road class.`]() Values for UzaNameLookup must be present in the list provided in the module documentation, otherwise user inputs must specify the data directly. [region_base_year_dvmt.csv][marea_base_year_dvmt.csv][marea_dvmt_split_by_road_class.csv][marea_base_year_VMT.csv]

* **ITS-Operational Policies.** Proportion of VMT by [road class]() affected by standard ITS-Operation policies on Freeways (xxx) and Arterials (xxx), and [`other ops`]() provides flexibility for future user-defined freeway and arterial operations program coverage and  effectiveness. These programs reduce delay.[marea_operations_deployment.csv][other_ops_effectiveness.csv]

* **Speed smoothing programs.** Proportion of VMT by [`road class`]() covered by  [`ITS-speed smoothing programs`](), and [`Eco-drive programs`]()([`LDV`]() and Heavy Truck VMT).  These programs reduce vehicle accelerations and decelerations, but do not affect delay. 
[marea_speed_smooth_ecodrive.csv] 

xxxwhere fits?xxxNote:  Literature review of [`fuel efficiency`]() improvements found that [`Speed smoothing`] policies could only reasonably achieve a portion of the theoretical maximum; 50% from ITS-Speed Smoothing policies and 33%Fwys/21%Arterials for eco-drive programs. These ratios are applied to arrive at the highest achievable impact given a user input of full deployment (input of 1=100%). 

ITS impact is modeled within RSPM, through speed reductions from basic and enhanced traffic operations, and active management of speed smoothing operational programs. Average speed on roadways in RSPM, is calculated as a function of congestion level and the type and amount of deployment of traffic operations programs. An average speed is associated with each roadway functional class (freeway or arterial) and congestion level. Those speeds are modified depending on the cumulative effect of user-specified deployment of the following traffic operations programs:
  *  Freeway ramp metering - Metering freeways can reduce delay by keeping mainline vehicle density below unstable levels. It creates delay for vehicles entering the freeway, but this is typically more than offset by the higher speeds and postponed congestion on the freeway facility. The Urban Mobility Report cites a delay reduction of 0 to 12%, with an average of 3%, for 25 U.S. urban areas with ramp metering.  Only urban areas with Heavy, Severe, and Extreme freeway congestion can benefit from ramp metering in RSPM
  *  Freeway incident management - Incident Response programs are designed to quickly detect and remove incidents which impede traffic flow. The UMR study  reports incident-related freeway delay reductions of 0 to 40%, with an average of 8%, for the 79 U.S. urban areas with incident response programs. This reflects the combined effects of both service patrols to address the incidents and surveillance cameras to detect the incidents. Effects were seen in all sizes of urban area, though the impacts were greater in larger cities. 
  *  Arterial access management– Access management on arterials can increase speeds by reducing the number of enter/exit points on the arterial and reduce crashes by reducing conflict points. Although improvements such as raised medians can reduce throughput by causing turning queue spillback during heavy congestion, other types of access management, such as reduced business ingress/egress points, show consistent benefits system-wide.
  *  Arterial signal coordination – Traffic signal coordination, particularly for adaptive traffic signals, can reduce arterial delay by increasing throughput in peak flow directions. UMR and other analysis estimates delay reductions of up to 6-9% due to signal coordination, with more potential savings from more sophisticated control systems. An average arterial delay savings was found to be about 1%.
  *  Enhanced ITS/Speed Smoothing programs– Insufficient aggregate performance data is available for a number of other current and future ITS/operations strategies.  These include: speed limit reductions, speed enforcement, and variable speed  limits that reduce the amount of high-speed freeway travel; advanced signal optimization techniques that reduce stops and starts on arterials;  and truck/bus-only lanes that can move high-emitting vehicles through congested areas at improved efficiency.
  *  Other Ops programs – Ability within VE allows flexibility within the model to accommodate future enhancements (other_ops.csv, other_ops_effectiveness.csv).  Further research and significant program investment would be needed to justify benefits in these enhanced ITS programs.

Inputs specifying the level of deployment of several roadway Intelligent Transportation System (ITS) programs, determine the area roadway speeds which influence fuel efficiency.   

Eco-Driving Practices (autos and trucks)

Eco-driving involves educating motorists on how to drive in order to reduce fuel consumption and cut emissions. Examples of eco-driving practices include avoiding rapid starts and stops, matching driving speeds to synchronized traffic signals, and avoiding idling. Practicing eco-driving also involves keeping vehicles maintained in a way that reduces fuel consumption such as keeping tires properly inflated and reducing aerodynamic drag. In RSPM, fuel economy benefits of improved vehicle maintenance are included in the eco-driving benefit. A default 19% improvement in vehicle fuel economy is assumed 
Vehicle operations and maintenance programs (e.g. eco-driving) based on policy assumptions about the degree of deployment of those programs and the household characteristics.  Vehicle operating programs (eco-driving) reduces emissions per VMT

The fuel economy of all household vehicles of participating households is increased by a factor representing the average fuel economy gains of persons who are trained in eco-driving techniques. 
An RSPM input (speed_smooth_ecodrive.csv) specifies the proportion of light duty vehicle drivers who exhibit eco-driving habits.  The same file makes similar assumptions on the proportion of other (commercial,heavy truck) drivers who are eco-drivers.  

We get this information by MPO from ODOT’s HPMS submittal team. We use the lane-length values as lane mile inputs, aggregating as follows:
* Fwys = "Interstate "& "Other Freeways & Expressways"
* Arterials = "Other Principal Arterial" & "Minor Arterial" 
We ignore Major/Minor collectors and Local streets.

### Customized VE packages: 
These require rebuilding VE packages with local /extdata/ files)
-	VESimHouseholds – Update to use WA PUMS. FHWA/Volpe can help with this, contact Jeremy Raw/Dan Flynn.
-	PowertrainsAndFuels – You are welcome to use (with caution), Oregon’s VE-State inputs that are under-development (see link above).

## Common Errors and Troubleshooting

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

## Running Multiple Scenarios

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

