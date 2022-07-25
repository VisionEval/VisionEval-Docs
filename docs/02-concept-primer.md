# Concept Primer {#conceptprimer}

VisionEval differs from traditional travel demand models both in how it works and what kind of planning concerns it helps to address. This chapter provides a quick introduction approach to the unique features and applications of VisionEval. It reviews the main model components and key concepts at a high level, to assist new users in understanding concepts they will apply as they set up scenarios, develop inputs and evaluate outputs.  Links to more detailed documentation will allow the reader to delve further into each topic, as they choose.

## What can I do with VisionEval?

Structurally, VisionEval may be described as a "disaggregate demand/aggregate supply" model. That is, it combines rich demographic and socioeconomic detail from a synthetic population with aggregate treatments of travel (multi-modal VMT and congestion without explicit trips, or transport networks). The implication of the "aggregate supply" model is that VisionEval cannot be used to evaluate performance of specific projects or corridors.

What VisionEval can do, and even makes especially simple, is to evaluate large numbers of scenarios and explore how combinations of alternative future conditions might affect performance measures. Travel demand models, whether built using traditional trip-based or more contemporary activity-based techniques, sacrifice flexibility for network detail. It is difficult in such models to capture novel behaviors such as an increased propensity to use inexpensive ride-hailing services, or to express shifts in vehicle ownership and occupancy that may be influenced by multiple factors some of which have not yet been observed. Yet these potential shifts are often very important for assessing the potential of pricing, investment strategies or other policy priorities. VisionEval also makes it relatively simple to explore risks and opportunities that may eventually be realized as new transportation options mature.

VisionEval won't help us determine if a particular highway segment should be built or upgraded, or what kind of transit service improvements should be extended into new areas. But it can help us look at the market for new technologies, and explore future scenarios that are based both on changed circumstances (altered demographics, increased congestion, or alternate road pricing strategies) as well as on changed behaviors (including behaviors that *might* happen, but that we have not yet observed because the key enabling technologies are too early in their deployment). VisionEval results can be explored in detail by market segment, asking questions about how benefits might be distributed regionally, and what overall system performance might look like.

Ultimately, VisionEval is a system for asking a very broad range of "what if" questions about how the transportation system might perform, and how its benefits and costs might be distributed over the community.  It can efficiently process hundreds of scenarios looking at many different types of interventions, alternative policies, and hypothetical future conditions and travel behaviors. The results can inform strategic questions, helping decision makers answer questions such as "What are our options for achieving this performance result?" or "What are our risks if new transportation technologies develop in these different ways?"

Using VisionEval to answer such questions does not make other types of modeling obsolete (such as travel demand models or corridor microsimulations). Instead, it helps to determine what is worth the effort to code into these more detailed models, and also to explore and document novel assumptions about the future that may require extra effort to implement, and that would be prohibitively expensive to explore through traditional planning models.

## Strengths and limitations

VisionEval operates at broad geographic levels and without explicit network representations to enable very fast analyses across scores of different assumptions and inputs. It is especially well suited for quickly evaluating several different combinations of policies or assessing the range of impacts when uncertainty exists in several key inputs. Because much of the travel behavior is asserted based on observed travel patterns the latter can be changed to reflect expected changes due to new technologies, services, and expected changes in behavior over time. Thus, VisionEval is better suited than traditional travel modeling approaches for certain pursuits:

+ Screening a wide range of policy actions, especially in the face of uncertainties where ranges of expected responses or effects must be considered
+ Resilience testing under uncertainties (e.g., population growth, household size, fuel prices)
+ Directly "comparing and contrasting" broad ranges or combinations of policies (e.g., ITS, transit service, active transport, demand management)
+ Analysis of broad policy or technology changes (e.g., carbon taxes, low-carbon fuels)
+ Evaluating fuel consumption, particulate emissions, and greenhouse gas emissions impacts of proposed policies

However, VisionEval is not well suited for detailed geographic analyses, to include the effects of congestion on individual trips or tours. Thus, examining the effects of localized land use (e.g. parcel or block) or network assumptions cannot be carried out using VisionEval. Improvements in network capacity, efficiency, or safety can only be indirectly incorporated in VisionEval. 

## VisionEval geographies

Traditional travel forecasting models divide a study area into thousands of traffic analysis zones in order to facilitate highly granular spatial analyses. This allows trip (tour segment) origins and destinations to enter and exit a detailed representation of the multimodal transportation network in order to study network flows, congestion, and efficiency outcomes. VisionEval operates at a much broader spatial scale, using several levels of geography:

* A [<span style="color:green">region</span>](#region) defines the entire area covered by the VisionEval analyses
* [<span style="color:green">Azones</span>](#azones) are large areas such as cities, counties, or Census Public Use Microdata Areas (PUMAs)
* [<span style="color:green">Bzones</span>](#bzones) are subdivisions of Azones that represent neighborhoods, Census tracts or block groups, or other relatively homogenous areas
* [<span style="color:green">Metropolitan areas</span>](#metropolitan-area) (Marea) are defined as groups of Azones that define them

The [<span style="color:green">location type</span>](#location-type) of each household is also coded as urban, town, or rural areas. A [<span style="color:green">place type</span>](#place-type) is also defined in terms of urban density and its mix of jobs and housing. Both are usually defined for each Bzone used in the model.

> Watch a [video presentation](https://youtu.be/-ylFbyLfhbw?t=4690) with more information about VisionEval geographies

<a href="http://www.youtube.com/watch?feature=player_embedded&v=-ylFbyLfhbw
" target="_blank"><img src="http://img.youtube.com/vi/-ylFbyLfhbw/0.jpg" 
alt="VisionEval Training Overview" width="280" height="200" border="5" /></a>

### Performance metrics

The following table summarizes many of the possible performance metrics that can be summarized at the region level. The ability to easily export the data enables the analyst to construct new or different performance measures easily. 

+ Mobility
    + Daily VMT per capita
    + Annual walk trips per capita
    + Daily Bike trips per capita

+ Economy
    + Annual all vehicle delay per capita (hours)
    + Daily household [<span style="color:green">parking costs</span>](#parking-costs)
    + Annual household [<span style="color:green">vehicle operating cost</span>](#vehicle-operating-costs) (fuel, taxes, parking)
    + Annual household [<span style="color:green">vehicle ownership costs</span>](#vehicle-ownership-costs) (depreciation, vehicle maintenance, tires, finance charge, insurance, registration)


+ Land Use
    + Number or percent of residents living in [<span style="color:green">mixed use</span>](#mixed-use) areas
    + Number of dwelling units by housing type (e.g., single family [SF], multi-family [MF])

+ Environmental
    + Annual greenhouse gas emissions per capita
    + Household vehicle greenhouse gas/mile
    + Commercial vehicle greenhouse gas/mile
    + Transit vehicle greenhouse gas/mile

+ Energy
    + Annual per capita fuel consumption for all vehicles (gallons)
    + Average [<span style="color:green">fuel efficiency</span>](#fuel-efficiency) (net miles per gallon) for all vehicles
    + Annual external [<span style="color:green">social costs</span>](#social-costs) per households (total/percent paid)

<!-- 
_Specific list of metrics under each category above could correspond to standard CSV/GUI outputs we are working on. ODOT outputs use classification above, like in [RV Strategic Assessment Report](https://www.rvmpo.org/images/studies/2015-strategic-assessment/Strategic_Asessment_Final_Report.pdf)  (Table 2 basic scenarios & appendix Table 3C for selected unidimensional multiruns)._
-->

## Typical applications

VisionEval can be used to inform planning in several different realms, as described in the following sections. 

### Strategic modeling

VisionEval is a strategic modeling system. It differs from traditional travel demand and microsimulation models principally in that it is applied earlier in the planning process, and it is used for different purposes. Rather than examining the detailed performance of specific facilities (assessing individual projects), VisionEval estimates regional and small area performance metrics that reflect overarching policy goals such as emission reduction, regional VMT, or mode share. 

Traditional travel models used for planning purposes are applied to estimate outcomes under a small number of alternate input scenarios that vary land use characteristics (e.g. type and density of land uses), socioeconomic characteristics (e.g. population, ages, incomes), and/or transportation characteristics (e.g. road alignments, lane configurations, tolls, etc.). In these models, the response to the changed inputs is estimated based on parameters typically derived from household surveys and other related data sources: that is, the behavior in the model is presumed to be what we see today. Even though such models are often behaviorally complex (e.g., activity-based models), the effort required to assess many alternative scenarios is often prohibitive, and because such models are built using complex estimation procedures rooted in detailed data about existing behavior, it can be technically difficult or impossible to reliably encode possible future shifts in behavior, or to explore alternative possible future behaviors.

VisionEval is typically set up to run many scenarios that explore a broad set of alternative policies and investment priorities that may result from a variety of possible categories of policy and project interventions, or from a range of possible future conditions (strong or weak economic growth, demographics that shift at different rates), or from uncertain deployment of new technologies such as app-based ridesharing (Transportation Network Companies or TNCs).

A full application of VisionEval may examine hundreds or even thousands of permutations of inputs representing many possible future outcomes. The outputs allow planners and decision-makers to explore the outcomes of each scenario compared to the others, so they can visualize and discuss the relative impact and cross-influences, as well as the unintended consequences, of factors represented across the scenarios. VisionEval allows planners to assess alternative assumptions about uncertain phenomena such as autonomous vehicle (AV) deployment, it is a very effective tool for identifying risks and opportunities, as well as for formulating effective strategic responses to new challenges for which little current data exists or for which many outcomes are possible yet none are certain. The most interesting of the resulting strategic plans can be refined with more detailed models. Based on the strategic modeling findings, uncertainties can be confidently simplified into a smaller number of scenarios to explore in detail.

Notwithstanding its typical application as a strategic model, VisionEval does allow detailed investigation of certain phenomena such as fleet composition and vehicle ownership in relation to Greenhouse Gas Analysis. It also is unique in its ability to explore budget constraints on travel. Its simulation of individual households enables it to assess policies that would be difficult or impossible to model successfully with traditional models. 

### Local policy actions

VisionEval is well suited for evaluating a wide range of local policies at varying levels of geography: 

+ Demographics (Azone)
    + Population by age (households & non-institutional group quarters)
    + Average household size and percent of single-person households
    + Driver licensing rates (optional)
    + Average per capita Income

+ LandUse (Bzone)
    + Employment by type (Total, Retail, Service)
    + [<span style="color:green">Dwelling units</span>](#dwelling-unit-type) by type (SF, MF)
    + Income quartiles (for allocating households to neighborhoods and [<span style="color:green">Dwelling units</span>](#dwelling-unit-type))
    + Share of households in [<span style="color:green">urban mixed-use</span>](#urban-mixed-use) areas (optional)
    + [<span style="color:green">5D built form measures</span>](#buit-form-measures) (Design & Transit)
    + Developable area
    + Parking pricing policies

+ Transportation Operations Actions
    + [<span style="color:green">Road lane-miles</span>](#road-lane-miles) (freeways, arterials) (Marea)
    + [<span style="color:green">Transit service</span>](#transit-service-miles) (service miles by transit mode) (Marea)
    + [<span style="color:green">Short SOV trip diversion</span>](#sov-diversion) (to bikes, personal electrics, etc.) (Azone)
    + [<span style="color:green">ITS</span>](#its) Operations (Ramp metering, Incident response, (Marea)
    + ITS [<span style="color:green">speed smoothing</span>](#speed-smoothing) (Freeway ATM, Art Signal optimization) (Marea)
    + VMT covered by Drivers in [<span style="color:green">Eco-Drive</span>](#ecodrive) programs (Marea)
    + EV Charging infrastructure (residential) (Azone)

+ Pricing
    + Fuel and electricity costs (Azone)
    + Road cost recovery – registration fee, gas taxes, VMT fee (Azone)
    + [<span style="color:green">Carbon pricing</span>](#carbon-price) and otherand other environmental impact and [<span style="color:green">social costs</span>](#social-costs) (Region)
    + [<span style="color:green">Congestion fees</span>](#congestion-fee) (Marea)
    + [<span style="color:green">PAYD insurance</span>](#pay-as-you-drive) participation (Azone)

+ Vehicle, Fuels, & Emissions
    + Electricity [<span style="color:green">carbon intensity</span>](#carbon-intensity) (Azone)
    + Fuel [<span style="color:green">carbon intensity</span>](#carbon-intensity) (composites by vehicle group) (Region)
    + LDV-HH percent light trucks (stock) (Azone)
    + LDV-HH [<span style="color:green">vehicle age</span>](#vehicle-age) average (Azone)
    + LDV [<span style="color:green">car service</span>](#car-service), vehicle mix (stock) (Region)
    + Transit vehicles & fuels mix (Marea)
    + LDV [<span style="color:green">commercial service</span>](#commercial-service) vehicle mix, %Light Trucks (stock) (Region)
    + [<span style="color:green">Heavy truck</span>](#heavy-truck) vehicle mix (stock) (Region)

## Scenario analyses

A key value of VisionEval is how it facilitates running many scenarios or possible futures.  In practice, the user typically starts by setting up the model with a reference scenario (i.e. a scenario that represents current policies and extrapolation of current trends). The model can be validated for current and past years at this point. This Reference scenario then serves as a pivot point for the development of alternative scenarios that modify one or more policy assumptions or other assumptions about the future (e.g. assumptions about urban area expansion, assumptions about future light-duty vehicle fleet composition). Because VisionEval models address a large number of factors that are specified by dozens of input files, and because each set of inputs could have many different values, the potential number of alternate scenarios that could be defined is probably uncountable. For this reason, the scenario generation process is simplified by defining *categories* of inputs that are related in how they affect behavior or are related in how policies are likely to be deployed. An example of the former would be the definition of a pricing category that groups all inputs affecting the price/cost of operating light-duty vehicles (e.g. fuel price, congestion price, carbon price). An example of the latter would be the definition of a land use category which in addition to including land use inputs such as development density, also includes transportation inputs that are associated with land use such as transit service frequency. For each category of inputs, several *levels* of change from the reference scenario assumptions are defined. Alternate scenarios can then be developed by swapping out reference scenario inputs in each category with different level inputs for the category. This is typically done in two ways:

+ Sensitivity tests that change a single category of inputs for each run. Such tests are useful for exploring the relative effects of each category.
+ Combinatorial tests which compose scenarios from combinations of all categories and all levels. 

Note that the number of combinatorial scenarios is a function of the number of categories and the number of levels in each category. For example, if inputs are grouped into 5 categories and each category has 3 levels, at total of 243 scenarios (3x3x3x3x3) would be generated by all combinations. For this reason, automated processes are typically developed to aid in the set-up and running of these scenarios, and analysis of the results. 

## Building blocks

### Household synthesis and land use

One of the strengths of VisionEval is the rich detail on individual households. This allows for household specific policies, travel behavior can respond to specific household costs and attributes, and outputs can be mined for differences by population groups. The approach of building on a synthesized population borrows from the state of the practice in activity-based travel demand models.

> Watch a [short video](https://youtu.be/-ylFbyLfhbw?t=5371) on household synthesis
 
VisionEval creates simulated households in each Azone from user-supplied projections of persons by [<span style="color:green">age group</span>](#age-group) and average per capita income. Each simulated household has the characteristics of the number of persons in each of 6 age groups, number of workers in each of 5 age groups, [<span style="color:green">lifecycle category</span>](#lifecycle), and household income. The simulated households are assigned a [<span style="color:green">dwelling unit type</span>](#dwelling-unit-type) (single family or multi-family) using a model that is sensitive to the household characteristics and the number of units of each type assigned to the Azone (based on user inputs). Each simulated household is assigned to a Bzone based on the number of dwelling units of their assigned type in each Bzone and the household's income compared to the relative income distribution by BZone. Separately, Bzones are attributed with employment and land use attributes ([<span style="color:green">location type</span>](#location-type), [<span style="color:green">built form 'D' values</span>](#buit-form-measures), [<span style="color:green">urban mixed use</span>](#urban-mixed-use), and [<span style="color:green">employment by type</span>](#employment-type)). Household members who are workers are assigned a Bzone work location as a function of the distribution of jobs in the model area. Each home and work location is tied to a specific Bzone with its associated attributes.

Policies are added to each household as a function of their home and work Bzones:

+ Parking restrictions (work and non-work)
+ [<span style="color:green">Travel demand management</span>](#travel-demand-management) (TDM) programs (home and work-based)
+ [<span style="color:green">Car service</span>](#car-service) availability 

The following sections describe each module that contributes to this concept.

#### Synthesize households

Household synthesis is carried out in several steps:

1. _Create customized PUMS dataset_: This is done prior to setting up a model in VisionEval. A household dataset is prepared from [<span style="color:green">Census PUMS</span>](#census-pums) data for the modeled region. The default data included with VisionEval is for Oregon. PUMS data for other regions may be used instead, rebuilding the package to reflect Census households for the region of interest.
2. _Create Households_: The identified types of PUMS households are expanded to meet user control totals and other demographic inputs. [<span style="color:green">Census PUMS</span>](#census-pums) data are used define probabilities that a person by [<span style="color:green">age group</span>](#age-group) would be found in each of hundreds of household types. A matrix balancing process is used to allocate persons by age to each of the PUMS household types in a way that matches input control totals and optional constraints. The sampled households are expanded to meet user control totals and other demographic inputs. 
3. _Predict Workers_: The number of workers by [<span style="color:green">age group</span>](#age-group) within each simulated household is predicted using [<span style="color:green">Census PUMS</span>](#census-pums) probabilities. The user may optionally specify changes in employment rates by age group and Azone to simulate changes in labor force participation over time and/or differences in employment rates by location. 
4. _Assign LifeCyle_: Categorizes households are categorized by six [<span style="color:green">lifecycle</span>](#lifecycle) categories given the household age mix and employment status.
5. _Predict Income_: The annual income for each simulated household is predicted as a function of the household's worker count by age group, the average per capita income where the household resides (AZone), and interactions between neighborhood income and age (all and seniors). The models are estimated with [<span style="color:green">Census PUMS</span>](#census-pums) data.

#### Household drivers and autos

The number of drivers and autos in each household are calculated in two steps:

1. _Assign Drivers_: Drivers by [<span style="color:green">age group</span>](#age-group) are assigned to each household as a function of the numbers of persons and workers by age group, the household income, land use characteristics, and transit availability. [<span style="color:green">Metropolitan areas</span>](#metropolitan-area) are also sensitive to transit service level and urban [<span style="color:green">mixed use</span>](#mixed-use) indicators at the home location. Optional restriction on drivers by age group can be used in calibration or to address trends such as lower millennial [<span style="color:green">licensure rates</span>](#licensure-rate).
2. _Assign Vehicle Ownership_: The number of vehicles owned or leased by each household are determined as a function of household characteristics, land use characteristics, and transportation system characteristics. Households in [<span style="color:green">metropolitan areas</span>](#metropolitan-area) are also sensitive to [<span style="color:green">transit service level</span>](#transit-service-levels) and [<span style="color:green">urban mixed use</span>](#urban-mixed-use) indicators at the home location. The model first predicts zero-auto households and then the number of vehicles owned (up to 6), if any.

#### Land use attributes

Two steps are required to add land use attributes to the synthetic population:

1. _Calculate 4D Measures_: Several land use [<span style="color:green">5D built form measures</span>](#buit-form-measures) are calculated for each Bzone. The `density`, `diversity`, and     `destination` accessibilities are based on Bzone population, employment, dwelling units, and `developable land area` inputs. The `design` variable is a user input. 
2. _Calculate Urban Mixed Use Measure_: An [<span style="color:green">urban mixed</span>](#urban-mixed-use) measure for the household is calculated based on population density of the home Bzone and [<span style="color:green">dwelling unit type</span>](#dwelling-unit-type). The model is based on 2001 NHTS data. The model iterates to match an optional input target on the share of households to locate in [<span style="color:green">urban mixed-use</span>](#urban-mixed-use) areas.

#### Land use-household linkages

Several land use attributes are added to each household:

1. [_Assign Location Types_](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#43-assignloctypes-module): Households are assigned to land use [<span style="color:green">location types</span>](#location-type) -- urban, town, or rural -- by random allocation based on the household's [<span style="color:green">dwelling unit type</span>](#dwelling-unit-type) and input proportions on the mix of dwelling types in its enclosing Bzone.
2. [_Predict Housing_](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#41-predicthousing-module): [<span style="color:green">Dwelling unit types</span>](#dwelling-unit-type) are assigned to regular and group quarter households based on the input Bzone supply of dwelling units by type. Residential households also consider the relative costliness of housing within the Azone (logged ratio of the household’s income relative to mean income in their Azone), household size, oldest age person, and the interaction of size and income ratio.
3. [_Locate Employment_](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#42-locateemployment-module): The number of input jobs by Bzone and [<span style="color:green">employment type</span>](#employment-type) (retail, service, total) are scaled so that total jobs equals total household workers within the Marea. A worker table is developed and each worker is assigned to a work Bzone. The assignment essentially uses a gravity-type model with tabulations of workers and jobs by Bzone (marginal controls) and distance between residence and employment Bzones (IPF seed, inverse of straight-line distances between home and all work Bzone centroids).

#### Policy levers

Several assumptions about parking, demand management, and mobility services can also be coded:

1. [_Assign Parking Restrictions_](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#46-assignparkingrestrictions-module): Households are assigned specific [<span style="color:green">parking restrictions</span>](#parking-restrictions) and fees for their residence, workplace(s), and other places they are likely to visit based on parking inputs by BZone (within Bzones coded as within metropolitan areas [Marea] only).
    + _Residential Parking Restrictions & Fees_: The number of free parking spaces available at the household's residence is set based on input value that identify the average residential parking spaces by dwelling type in each Bzone. For household vehicles that cannot be parked in a free space a residential parking cost (part of auto ownership costs) is identified as a function of input parking rates for the home Bzone (if any).
    + _Employer Parking and Fees_: Which workers pay for parking is set by inputs that define the proportion of workers facing parking fees in each Bzone. Whether their payment is part of a [<span style="color:green">cash out/buy back</span>](#cash-out-buy-back) program is similarly set by input proportions by Bzone and associated fees set by input parking rates for the work Bzone.
    + _Non-work Parking Fees:_ The cost of parking for other activities such as shopping is estimated as the likelihood that a household would visit each Bzone and the parking fee in that Bzone. The likelihood is calculated with a gravity-type model, given the relative amount of activity in the Bzone (numbers of households by Bzone and the scaled retail and service job attractions by Bzone as marginals) and the proximity to each destination (inverse distance matrix from home Bzone seed matrix). The average daily parking cost is a weighted average of the fee faced in each destination bzone and the likelihood of visiting that Bzone.
2. [_Assign Demand Management_](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#47-assigndemandmanagement-module): Households are assigned to [<span style="color:green">individualized marketing programs</span>](#individualized-marketing-programs) based on input participation levels within their home Bzone. Each worker in the household can also be assigned to an [<span style="color:green">employee commute options program</span>](#employee-commute-options-program) based on input participation levels for workers within their assigned work Bzone. A simple percentage reduction in household VMT is applied based on the household's participation in one or more of these program (maximum of multiple program participation, to avoid double-counting). Worker reductions are only applied to that worker's work travel portion of overall household VMT, and summed if multiple workers in the household participate in such programs.

    > Caution: The model assumes high-caliber TDM programs are in place that produce significant VMT savings. Inputs should reflect this.

3. [_Assign CarSvc Availability_](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#48-assigncarsvcavailability-module): A [<span style="color:green">car service</span>](#car-service) level is assigned to each household based on the input car service coverage for where the household resides (Bzone). High Car Service availability can have an impact on auto ownership (households may own fewer vehicles where high level car service is available) and auto operating cost (see the discussion in the next section on [household costs and budgets](#household-costs-and-budgets)).

### Household multimodal travel

> Watch a [video overview](https://youtu.be/-ylFbyLfhbw?t=5927) of the Household Multimodal Travel module

Travel of various modes by households (vehicle, transit, bike, and walk modes) is estimated as a simple function of the rich demographic and land use attributes of the household. In [<span style="color:green">metropolitan areas</span>](#metropolitan-area) travel is also influenced by inputs on transport supply on a per capita basis, such as available roadway capacity and [<span style="color:green">bus-equivalent transit service</span>](#bus-equivalent-miles) levels. Transit, bike, and walk trips are also influenced by household VMT (i.e. if household VMT decreases, trips by these modes increase, and vise verse). Traditional travel models incorporate behavioral dynamics in choice models to build tours and trips for each synthetic person. VisionEval, by contrast, uses simple regression equations that directly estimate average per capita trips and miles by mode, linked by average trip lengths.

After adjusting VMT for household budget limitations it is further adjusted for household participation in TDM programs (home & work-based) and [<span style="color:green">short-trip SOV diversion</span>](#sov-diversion) before calculating household trips for all modes. The household's bike miles are also adjusted to reflect SOV diversion input.

The following sections describe each module, which are implemented in sequence:

1. The household's daily VMT is calculated without household budget adjustments
2. The household's vehicle operating costs are calculated
3. The household's vehicle operating cost budget is calculated and daily VMT is adjusted to fit within the budget if necessary
4. Daily VMT reductions due to TDM measures and short-trip SOV diversions are calculated and applied
5. Vehicle and non-vehicular (AltMode) trips are calculated for each household

#### Transport supply

Transport supply variables are defined in two steps. Note that these calculations are only carried out within [<span style="color:green">metropolitan areas</span>](#metropolitan-area)
 (Mareas) only:

1. _Assign Transit Service_: Transit service levels are input for each [<span style="color:green">metropolitan areas</span>](#metropolitan-area) and neighborhood (Bzone).  Annual revenue-miles (i.e. transit miles in revenue service) by eight [<span style="color:green">transit modes</span>](#transit-modes) are read from inputs for each metropolitan area. A Bzone-level [<span style="color:green">Transit D</span>](#transit-d) attribute defines access to transit (not yet work access) for each household based on inputs on relative transit accessibility. Using factors derived from the National Transit Database (NTD), input annual transit revenue miles for each of the eight transit modes are converted to [<span style="color:green">bus-equivalent miles</span>](#bus-equivalent-miles) by three [<span style="color:green">transit vehicle types</span>](#transit-vehicle-type) (van, bus, and rail). Per capita [<span style="color:green">relative transit supply</span>](#relative-transit-supply) and bus-equivalent service-miles are calculated.
2. _Assign Road Miles_: Stores input on the numbers of freeway lane-miles and arterial lane-miles by [<span style="color:green">metropolitan area</span>](#metropolitan-area) and year. Computes the [<span style="color:green">relative roadway supply</span>](#relative-roadway-supply), arterial and freeway lane-miles per capita.

#### Household travel calculations

Household travel by vehicles are calculated in three steps:

1. _Calculate Household Daily VMT (Dvmt)_: Household average daily vehicle miles traveled (VMT) is estimated as a function of household characteristics(income, workers, children, drivers), vehicle ownership, and attributes of the neighborhood (population density) and metropolitan area ([<span style="color:green">urban mixed-use</span>](#urban-mixed-use), [<span style="color:green">transit service level</span>](#transit-service-levels), freeway lane-miles) where the household resides. It also calculates household VMT percentiles which are used by other modules to calculate whether a household is likely to own an electric vehicle (EV) and to calculate the proportions of plug-in hybrid electric vehicles (PHEV) VMT powered by electricity. These values are derived from the 2001 [<span style="color:green">NHTS</span>](#nhts) data.
2. _CalculateVehicleTrips_: This module calculates average daily vehicle trips for households consistent with the household VMT. Average length of household vehicle trips is estimated as a function of household characteristics (drivers/non-driers, income), vehicle ownership ([<span style="color:green">auto sufficiency</span>](#auto-sufficiency)), and attributes of the neighborhood (population density) and [<span style="color:green">metropolitan area</span>](#metropolitan-area) ([<span style="color:green">urban mixed-use</span>](#urban-mixed-use), freeway lane-miles) where the household resides, and interactions among these variables. The average trip length is divided into the average household VMT to get an estimate of average number of daily vehicle trips.
3. _Calculate AltMode Trips_: This module calculates household transit trips, walk trips, and bike trips. The models are sensitive to household VMT so they are run after all household VMT adjustments (e.g., to account for cost on household VMT) are made. Twelve models estimate trips for the three modes in metropolitan and non-metropolitan areas, in two steps each. The first step determines whether a household has any AltMode trips and the second part determines the number of trips. All of the models include terms for household characteristics (size, income, age mix) and the household's overall VMT. Neighborhood factors (population density) factors into all but the bike trip models. For households in metropolitan areas [<span style="color:green">transit service level</span>](#transit-service-levels) has an impact as well, with transit ridership also sensitive to when residents live in [<span style="color:green">urban mixed-use</span>](#urban-mixed-use) neighborhoods.

#### SOV diversion

Household single-occupant vehicle (SOV) travel is reduced to achieve bike and micro-transportation input policy goals, i.e., for diverting a portion of SOV travel within a 20-mile tour distance (round trip distance). This allows evaluating the potential for light-weight vehicles (e.g. bicycles, electric bikes, electric scooters) and infrastructure to support their use, in reducing SOV travel. First, the amount of the household's VMT that occurs in SOV tours having round trip distances of 20 miles or less is estimated. Then the average trip length within those tours is estimated. Both models are sensitive to household characteristics(drivers, income, kids), vehicle ownership ([<span style="color:green">auto sufficiency</span>](#auto-sufficiency)), and attributes of the neighborhood (population density, dwelling type) and [<span style="color:green">metropolitan area</span>](#metropolitan-area) ([<span style="color:green">urban mixed-use</span>](#urban-mixed-use), freeway lane-miles) where the household resides, and the household's overall VMT.

The diversion of these short trips is assumed to only apply in urban and town [<span style="color:green">location types</span>](#location-type). The VMT reductions are allocated to households as a function of the household's SOV VMT and (the inverse of) SOV trip length. In other words, it is assumed that households having more qualifying SOV travel and households having shorter SOV trips will be more likely to divert SOV travel to bicycle-like modes. The estimates of the household's share of diverted VMT, average trip length of diverted VMT are applied elsewhere to reduce DMVT and increase bike trips. Zero vehicle households are not allowed to divert SOV travel. [<span style="color:green">Census PUMS</span>](#census-pums) data is used to estimate the models.

#### DVMT reductions

Each household's VMT is adjusted for their TDM program(s) participation, if any, as well as input from metropolitan area [<span style="color:green">short-trips SOV diversion</span>](#metropolitan-area) goals. The SOV diversion also increases bike trips (diverted SOV VMT divided by SOV average trip length).

### Vehicles, fuels and emissions

The [<span style="color:green">powertrains</span>](#powertrain), fuels, and associated emissions datasets for all modeled [<span style="color:green">vehicle groups</span>](#vehicle-group) are among the most complex inputs used in VisionEval. Default datasets are included in the VisionEval installer to simplify this for the user. The user can use these defaults or develop their own data that matches the VisionEval input requirements. It is anticipated that different datasets will be developed by users that can be shared with the VisionEval community. For example, one package may represent a base scenario of federal vehicle, fuel, and emission standards, while another package represents the California zero-emissions vehicle (ZEV) rules and low carbon fuel for the home location's [<span style="color:green">car service</span>](#car-service). 

The model looks in household vehicle sales tables indexed by [<span style="color:green">vehicle type</span>](#vehicle-type) and age to determine the probability of each powertrain in that sales year, along with its associated fuel efficiency and other attributes.  Each household vehicle is assigned attributes consistent with these probabilities. In some cases electric vehicles (EVs) are replaced by plug-in hybrid electric vehicles (PHEVs) if household VMT and residential charging limitations exist.  

The [<span style="color:green">powertrain</span>](#powertrain) mix of non-household vehicle groups -- car service, commercial service, transit, and heavy trucks --  is applied to VMT (rather than individual vehicles) in the scenario year (rather than sales year). There is some input adjustment for average vehicle age and commercial [<span style="color:green">vehicle type</span>](#vehicle-type) share.

Fuels for each vehicle groups can rely on the package defaults, or use one of two input options.  The user can either provide a composite [<span style="color:green">carbon intensity</span>](#carbon-intensity) representing all gallons of fuel used for that vehicle group, or provide fuel mix shares (base fuel mix, biofuel blend proportions), combined with package default lifecycle (well-to-wheels) carbon intensity for the individual fuels.  The resulting carbon intensity per gallon are applied to gallons generated from VMT and vehicle fuel efficiency assumptions. Adjustments to fuel efficiency due to reduced speeds due to congestion as well as ITS operational programs (e.g., [<span style="color:green">speed smoothing</span>](#speed-smoothing)) and [<span style="color:green">EcoDrive</span>](#ecodrive) programs.

The table below summarizes the vehicle and fuel options available within VisionEval.

|Vehicle Group|Vehicle Types|Powertrain Options|Veh Input Adjustments|Fuel Options|
|-----------|--------|---------------------|----------|----------|
|Household Vehicles|automobile, light truck|ICE, HEV, EV, PHEV|(default veh mix), age, %LtTrk|gas/ethanol, diesel/biodiesel, CNG/RNG|
|Car Service VMT|automobile, light truck|ICE, HEV, EV|veh mix, age (HH %LtTrk)|gas/ethanol, diesel/biodiesel, CNG/RNG|
|Commercial Service VMT|automobile, light truck|ICE, HEV, EV|veh mix, age, %LtTrk|gas/ethanol, diesel/biodiesel, CNG/RNG|
|Heavy Truck VMT|heavy truck|ICE, HEV, EV|veh mix|gas/ethanol, diesel/biodiesel, CNG/LNG|
|Public Transit VMT|van, bus, rail|ICE, HEV, EV|veh mix|gas/ethanol, diesel/biodiesel, CNG/RNG|

Note that individual vehicles are modeled for households, based on sales year default datasets and age of the owned vehicle. Other groups' vehicle and fuel attributes apply to VMT in the scenario modeled year.  As a result, PHEVs do not exist other than household vehicles, instead PHEVs are represented as miles driven in HEVs and miles in EVs.

> Watch a [video overview](https://youtu.be/-ylFbyLfhbw?t=6747) of vehicles, fuels, and emissions

#### Household vehicle table

The household vehicle table is generated in two steps:

1. [_Create Vehicle Table:_](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#64-createvehicletable)  A [<span style="color:green">vehicle table</span>](#vehicle-table) is created with a record for every vehicle owned by the household, and additional vehicle records are added to reach the household’s number of driving age persons. Each vehicle record is populated with household ID and geography fields (Azone, Marea) and [<span style="color:green">access time</span>](#access-time) attributes. Each vehicle record is either “own” or (driving-age person without a vehicle) assigned access to a [<span style="color:green">car service</span>](#car-service) level, depending upon coverage in the household’s home Bzone. 
2. [_Assign Vehicle Type:_](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#63-assignvehicletype). Identifies how many household vehicles are light trucks and how many are automobiles as a function of number of vehicles, person-to-vehicle and vehicle-to-driver ratios, number of children, [<span style="color:green">dwelling unit type</span>](#dwelling-unit-type), income, density, and [<span style="color:green">urban mixed use</span>](#urban-mixed-use) data (in [<span style="color:green">metropolitan areas</span>](#metropolitan-area) only).

#### Powertrains and fuels defaults

These values are defined in two steps:

1. [_Load Default Values:_](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#81-loaddefaultvalues). This script, run before the rest of VisionEval is started, reads and processes the default [<span style="color:green">powertrains</span>](#powertrain) and fuels files in the package and creates datasets used by other modules to compute fuel and electricity consumption, and well as associated fuel and electricity [<span style="color:green">carbon intensity</span>](#carbon-intensity) emissions from vehicle travel.
2. An [_Initialize_](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#82-initialize-module) step is run by VisionEval as part of its initialization on each run. Optional user-supplied vehicle and fuel input files, if any, are processed (including input data checks). When available, modules that compute carbon intensities of vehicle travel will use the user-supplied data instead of the package default datasets.

#### Assign household powertrains and fuels

The powertrain and fuel type is assigned to each vehicle in each household in three steps:

1. [_Assign Vehicle Age:_](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#65-assignvehicleage)  Assigns vehicle ages to each household vehicle and [<span style="color:green">car service</span>](#car-service) vehicle used by the household as a function of the [<span style="color:green">vehicle group</span>](#vehicle-group) (household vehicles only), household income, and assumed mean vehicle age by vehicle type and Azone. The age model starts with an observed vehicle age distribution and relationship between vehicle age and income. These data are currently based on summaries of the 2001 [<span style="color:green">NHTS</span>](#nhts). Adjustments are made based on user average vehicle age inputs (household by vehicle type, car service overall). 
2. [_Assign Household Vehicle Powertrain:_](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#84-assignhhvehiclepowertrain-module)  This module assigns a [<span style="color:green">powertrain</span>](#powertrain) type to each household vehicle. The age of each vehicle is used with default tables by [<span style="color:green">vehicle type</span>](#vehicle-type) that identify the powertrain mix of vehicles sold in each sales year. Other default tables identify vehicle characteristics tied to powertrain that include battery range, [<span style="color:green">fuel efficiency</span>](#fuel-efficiency), and emissions rate. Assignments of EVs may be changed to PHEVs if the battery range is not compatible with estimated day-to-day trip lengths, or the home dwelling lacks vehicle charging availability.
3. [_Calculate Carbon Intensity:_](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#83-calculatecarbonintensity-module)  This module calculates the average [<span style="color:green">carbon intensity</span>](#carbon-intensity) of fuels (grams CO2e per megajoule) by [<span style="color:green">vehicle group</span>](#vehicle-group) and, if applicable, [<span style="color:green">vehicle type</span>](#vehicle-type). Average fuel carbon intensities for transit vehicle modes are calculated by [<span style="color:green">metropolitan area</span>](#metropolitan-area), other vehicles are calculated for the entire model region. The module also reads the input average [<span style="color:green">carbon intensity</span>](#carbon-intensity) of electricity at the Azone level.

#### Assign non-household powertrains and fuels

The assignment of powertrain and fuel characteristics is carried out in two steps:

1. [_Calculate Transit Energy And Emissions:_](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#911-calculateptranenergyandemissions-module) This module calculates the energy consumption and carbon emissions from transit vehicles in urbanized areas. Assumptions (package default or user input) on [<span style="color:green">powertrain</span>](#powertrain) mix and fuels for three [<span style="color:green">transit vehicle types</span>](#vehicle-type) by [<span style="color:green">metropolitan area</span>](#metropolitan-area) are applied to associated Marea [<span style="color:green">transit service miles</span>](#transit-service-miles) for these types. Assumptions (package default or user input) on average [<span style="color:green">carbon intensity</span>](#carbon-intensity) of fuel and electricity by [<span style="color:green">transit vehicle types</span>](#vehicle-type) are then applied to Marea fuel and electricity usage across types to calculate carbon emissions.
2. [_Calculate Commercial Energy And Emissions:_](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#910-calculatecomenergyandemissions-module)  The energy consumption and carbon emissions of [<span style="color:green">heavy trucks</span>](#heavy-truck) and [<span style="color:green">commercial service</span>](#commercial-service) VMT (no vehicles) are calculated by on-road (not sales) year. VMT shares of Commercial Service [<span style="color:green">powertrains</span>](#powertrain) by [<span style="color:green">vehicle type</span>](#vehicle-type) and [<span style="color:green">heavy truck</span>](#heavy-truck) powertrains are calculated (per package default or user input). Any [<span style="color:green">fuel efficiency</span>](#fuel-efficiency) (MPG and MPKWH) adjustments are then applied, due to policies ([<span style="color:green">EcoDriving</span>](#ecodrive), [<span style="color:green">speed smoothing</span>](#speed-smoothing) and/or congestion (including effects of any [<span style="color:green">ITS</span>](#its) operational and congestion fee policies). Ecodriving applies only to internal combustion engine (ICE) vehicles and [<span style="color:green">ITS</span>](#its) operational policies and congestion apply only in [<span style="color:green">metropolitan areas</span>](#metropolitan-area). Both vary by [<span style="color:green">powertrain</span>](#powertrain) and for commercial vehicles, [<span style="color:green">vehicle type</span>](#vehicle-type). Combining [<span style="color:green">fuel efficiency</span>](#fuel-efficiency) and VMT (from the Household Multimodal Travel Model) results in estimates of energy usage (fuel and electricity). Fuel carbon intensity for these modes is calculated by [<span style="color:green">metropolitan area</span>](#metropolitan-area) and/or region and applied to fuel and electricity usage to estimate CO2e emissions.

## Adjustments

### Congestion adjustments

Congestion, only calculated on urbanized roads (a subset of [<span style="color:green">metropolitan area</span>](#metropolitan-area) roads, requires estimating and combining together the VMT of all [<span style="color:green">vehicle groups</span>](#vehicle-group). For non-household vehicles, base year VMT is calculated directly from inputs and model parameters, while future year is a function of the input [<span style="color:green">growth basis</span>](#growth-basis). Initial allocations of DMVT across [<span style="color:green">road class</span>](#road-class)] is based on input values. 

Light duty vehicle (LDV) VMT is allowed to re-allocate between freeways and arterials to balance demand (VMT) and roadway supply (lane-miles) through a generalized cost framework (including roadway speed and congestion fees, if any). Roadway supply (i.e., capacity) is adjusted by delay-reducing [<span style="color:green">ITS</span>](#its) operations policies based on [<span style="color:green">fuel-speed curves</span>](#fuel-speed-curves) by [<span style="color:green">powertrain</span>](#powertrain), the resulting congested speeds impact vehicle [<span style="color:green">fuel efficiency</span>](#fuel-efficiency). Further adjustments are applied to reflect any [<span style="color:green">speed smoothing</span>](#speed-smoothing) and [<span style="color:green">EcoDrive</span>](#ecodrive) programs that may not affect delay but reduce acceleration and deceleration with associated impacts on fuel efficiency.

No fuel efficiency adjustments for congestion or policies are made to non-urban roadway VMT.  The delays faced by each household and associated fuel economy impacts are applied to each individual household's VMT and vehicles. Resulting overall average speeds, delays, and DMVT proportions, by [<span style="color:green">road class</span>](#road-class) at each [<span style="color:green">congestion level</span>](#congestion-level) on urbanized and other roads are also tabulated along with the resulting average per mile [<span style="color:green">congestion fees</span>](#congestion-fee) paid, if any, and overall vehicle hours of delay (VHD) by [<span style="color:green">vehicle group</span>](#vehicle-group).

> Watch a [video summary](https://youtu.be/-ylFbyLfhbw?t=8401) of VisionEval's congestion adjustment

#### Initialize roadway conditions

The roadway conditions in the model are calculated in three steps:

1. [_Load Default Road VMT Values:_](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#91-loaddefaultroaddvmtvalues)  These calculations are completed before the model run starts. The base year roadway VMT is processed, including light duty vehicle and [<span style="color:green">heavy truck</span>](#heavy-truck) VMT by state and urbanized area as well as VMT proportions by urbanized area, [<span style="color:green">vehicle group</span>](#vehicle-group) (light duty vehicle, heavy truck, bus), and [<span style="color:green">road class</span>](#road-class). The user can either provide direct inputs for these values or specify a state and/or urbanized area and the model will use default data from the [20xx USDOT Highway Statistics](https://github.com/VisionEval/VisionEval/tree/master/sources/modules/VETravelPerformance/inst/extdata/sources), where available.
2. [_Initialize:_](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#92-initialize-module) This step is run when the model run is initialized. User inputs used by several modules are read and checked (many with several valid options, proportions sum to 1, consistency, congestion fees increase with congestion level). Some of these values are optional, using default data where not specified. This includes various assumptions on base year VMT within both [<span style="color:green">urbanized area(s)</span>](#urbanized-area) and the full model region, by [<span style="color:green">vehicle group</span>](#vehicle-group), allocation among [<span style="color:green">road class</span>](#road-class), [<span style="color:green">growth basis</span>](#growth-basis), and assumptions for [<span style="color:green">freight vehicle groups</span>](#freight-vehicle-groups). It also checks inputs on [<span style="color:green">ITS</span>](#its) operational policies and [<span style="color:green">EcoDriving</span>](#ecodrive) programs, including any user-specified "other ops" programs and [<span style="color:green">congestion fees</span>](#congestion-fee) (by road class and [<span style="color:green">congestion level</span>](#congestion-level)). 
3. [_Calculate Road VMT:_](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#93-calculateroaddvmt-module)  Adds together [<span style="color:green">metropolitan area</span>](#metropolitan-area) VMT of all [<span style="color:green">vehicle groups</span>](#vehicle-group) (Households, CarService, Commercial Service, Heavy Truck, Transit) and allocates it across [<span style="color:green">road classes</span>](#road-class) (freeway, arterial, other), limiting it to urbanized area roadways for use in congestion calculations. To do so, several factors are established in the base year.  One uses the input [<span style="color:green">growth basis</span>](#growth-basis) (population, income, household VMT) to estimate future year [<span style="color:green">freight vehicle group</span>](#vehicle-group) (commercial service and heavy truck) VMT (using input base year VMT values by region and Marea, if provided, model-estimates otherwise). A second base year factor identifies the urban and non-urban allocation of VMT from [<span style="color:green">metropolitan area</span>](#metropolitan-area) households and related commercial service vehicles. For Heavy Trucks VMT an input specifies the proportion of VMT on urbanized roads while transit VMT (of all [<span style="color:green">transit service modes</span>](#transit-service-modes)) is assumed to only occur on urbanized roads. Base year allocations of urban VMT by [<span style="color:green">vehicle group</span>](#vehicle-group) among [<span style="color:green">road classes</span>](#road-class) are based on input shares, subject to adjustment during subsequent congestion calculations. Finally, to assess delay faced by each household and associated fuel efficiency impacts, each individual household's VMT is split between miles on urbanized and other road miles.

#### Congestion model and adjustments

Three adjustments are made based on congestion levels:

1. [_Calculate Road Performance:_](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#94-calculateroadperformance-module)  [<span style="color:green">Congestion level</span>](#congestion-level) by [<span style="color:green">road class</span>](#road-class) and the associated amounts of VMT are iteratively estimated. Light duty vehicle (LDV) VMT is allowed to re-allocate between freeways and arterials to balance demand and roadway supply (lane-miles) through a generalized cost framework (including roadway speed and congestion fees, if any and an estimated base year urbanized area [<span style="color:green">lambda parameter</span>](#lambda-parameter) based on the area's population and freeway-arterial lane-mile ratio). DMVT allocation at different aggregate demand-supply ratios relies on data from the [2009 Urban Mobility Study (UMS)](https://static.tti.tamu.edu/tti.tamu.edu/documents/umr/archive/mobility-report-2009-wappx.pdf) for 90 urbanized areas, where the model chooses the 5-10 cities with most similar congestion ratios.

    The supply calculation considers the delay-reduction effects of deploying urban area [<span style="color:green">ITS</span>](#its) operations programs (freeway ramp metering, freeway incident management, arterial signal coordination, arterial access control or user-defined "other ops" programs. The standard ITS-operations program impacts are based on research ([Bigazzi & Clifton 2011](https://github.com/VisionEval/VisionEval/tree/master/sources/modules/VETravelPerformance/inst/extdata/sources)). Non-urban speeds are also calculated, using a simple ratio of rural-to-urban travel volumes.
    
    The resulting average speeds, delay and DMVT proportions, by [<span style="color:green">road class</span>][lexicon] at each [<span style="color:green">congestion level</span>][lexicon] on urbanized and other metropolitan area roads are calculated, as is the resulting average per mile [<span style="color:green">congestion fees</span>](#congestion-fee) paid, if any, and overall VHD by [<span style="color:green">vehicle group</span>][lexicon].

2. [_Calculate Mpg Mpkwh Adjustments:_](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#95-calculatempgmpkwhadjustments-module)  Adjustments to [<span style="color:green">fuel efficiency</span>](#fuel-efficiency) (MPG and MPKwhr) for all [<span style="color:green">vehicle groups</span>](#vehicle-group) resulting from traffic congestion, [<span style="color:green">congestion fees</span>](#congestion-fee), ITS [<span style="color:green">speed smoothing</span>](#speed-smoothing) (i.e. active traffic management which reduces speed variation), and [<span style="color:green">EcoDriving</span>](#ecodrive) are calculated. The [<span style="color:green">fuel-speed curves</span>](#fuel-speed-curves) vary by [<span style="color:green">road class</span>](#road-class), congestion [<span style="color:green">powertrains</span>](#powertrain) (LdIce, LdHev, LdEv, HdIce) and, where applicable, [<span style="color:green">vehicle type</span>](#vehicle-type) relative to reference speeds by [<span style="color:green">road class</span>](#road-class). The adjustments are based on drive-cycle level simulation research ([Bigazzi & Clifton 2011](https://github.com/VisionEval/VisionEval/tree/master/sources/modules/VETravelPerformance/inst/extdata/sources)). Note that no adjustments are made for [<span style="color:green">ITS</span>](#its) policies (standard and speed smoothing policies) or [<span style="color:green">EcoDrive</span>](#ecodrive) programs on 'other' road classes (non-freeway or arterials) and non-urbanized roads, which are assumed to be uncongested. 
3. [_Adjust Household Vehicle MPg Mpkwh:_](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#96-adjusthhvehiclempgmpkwh-module)  Implements the [<span style="color:green">fuel efficiency</span>](#fuel-efficiency) (MPG and MPKwh) adjustments of household vehicles (including Car Service VMT), reflecting the effects of congestion, [<span style="color:green">congestion fees</span>](#congestion-fee), ITS [<span style="color:green">speed smoothing</span>](#speed-smoothing), and [<span style="color:green">eco-driving</span>](#ecodrive) that were calculated elsewhere. These adjustments vary by vehicle [<span style="color:green">powertrain</span>](#powertrain), [<span style="color:green">vehicle type</span>](#vehicle-type), and the proportion of the household's travel that is driven on urban and non-urban roads within the [<span style="color:green">metropolitan area</span>](#metropolitan-area). Joint effects are calculated as the product of congestion speed effects and the maximum of implemented speed-smoothing policies (eco-driving & ITS-speed smoothing).

### Household costs and budgets {#household-costs-and-budgets}

Two adjustments are made in response to household budgets. [<span style="color:green">Vehicle ownership costs</span>](#vehicle-ownership-costs) are calculated and an adjustment is made to the number of household owned autos if the costs are greater than switching to a 'High' level [<span style="color:green">car service</span>](#car-service), where available (subject to input limits on [<span style="color:green">car service</span>](#car-service) substitutability). [<span style="color:green">Vehicle ownership costs</span>](#vehicle-ownership-costs) include financing, depreciation, insurance (unless in [<span style="color:green">PAYD program</span>](#pay-as-you-drive)), annual registration fees, and residential parking fees.

Additionally, in order to respond to pricing policies and energy costs, VisionEval imposes an operating cost budget limitation. Household VMT is constrained such that annual [<span style="color:green">vehicle operating costs</span>](#vehicle-operating-costs) must stay below a maximum share of annual household income, or budget limit. A household-specific average annual vehicle operating costs is first calculated, including out-of-pocket per mile costs for each household owned and car service vehicles used by the household, as well as time-equivalent cost (input [<span style="color:green">access times</span>](#access-time), estimates of VMT at congested speeds, and [<span style="color:green">value of time</span>](#value-of-time) input). Vehicle operating costs determine the proportional split of VMT across household vehicles. Out-of-pocket costs include the energy, maintenance, repair, & tires, [<span style="color:green">road use taxes</span>](#road-use-taxes) (including [<span style="color:green">EV surcharge</span>](#ev-surcharge) and optional calculation of fee to fully recover road costs), work/non-work parking, [<span style="color:green">PAYD insurance</span>](#pay-as-you-drive), input share of carbon and other [<span style="color:green">social costs</span>](#social-costs), as well as [<span style="color:green">car service</span>](#car-service) fees by the household. Note that time-equivalent costs are only used to allocate travel between household vehicles (including car services used by the household). Time-equivalent cost is not used in the balancing of household vehicle operating cost and budget.

The following sections describe each module that contributes to this concept.

> Watch a [video overview](https://youtu.be/-ylFbyLfhbw?t=8739) of costs and budgets

#### Auto Ownership Cost & Adjustment

Two steps are required to calculate and adjust auto ownership costs:

1. [_Calculate Vehicle Own Cost:_](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#66-calculatevehicleowncost)  Average [<span style="color:green">Vehicle ownership costs</span>](#vehicle-ownership-costs) are calculated for each vehicle based on the vehicle type, age, and annual VMT (financing, depreciation, and insurance), annual registration fees (flat and ad valorum), combined with any residential [<span style="color:green">parking costs</span>](#parking-costs) (if household exceeds free parking limits). To do so, [<span style="color:green">PAYD insurance</span>](#pay-as-you-drive) participation is assigned based on household characteristics (drivers by age, annual mileage, income, location type, vehicle type and age) and input PAYD insurance program participation. The ownership cost is converted into an average vehicle-specific ownership cost per mile by dividing by estimated household VMT per vehicle.

Note that PAYD insurance does not affect the cost of vehicle ownership when determining whether a household will substitute car services for one or more of their vehicles. It does affect the out-of-pocket operating cost used in budget limitations on household VMT.
    
2. [_Adjust Vehicle Ownership:_](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#67-adjustvehicleownership)  Household vehicle ownership is adjusted based on a comparison of the cost of owning versus 'high' [<span style="color:green">car service</span>](#car-service) per mile rates, where available. The module identifies all household vehicles in a 'High' car service area, where the car service mileage rate exceeds the household's estimated [<span style="color:green">vehicle ownership cost</span>](#vehicle-ownership-costs) per annual household VMT. The household's [<span style="color:green">vehicle table</span>](#vehicle-table) entry changes from 'Own' to 'HighCarSvc' for these vehicles, limited by input assumptions regarding the average likelihood that an owner would substitute [<span style="color:green">car services</span>](#car-service) for a household vehicle (separate values are specified by [<span style="color:green">vehicle type</span>](#vehicle-type)). Other auto ownership values are also updated (e.g., insurance, total vehicles).

#### Auto Operating Cost & Adjustment

Three primary adjustments adjustments to auto operating cost are carried out in VisionEval:

1. [_Calculate Vehicle Operating Cost:_](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#97-calculatevehicleoperatingcost-module)  A composite per mile cost is calculated as an [<span style="color:green">out-of-pocket cost</span>](#out-of-pocket-cost) for various household and car service vehicle VMT (see below), combined with cost equivalent of travel time (access time and travel time at congested speeds times [<span style="color:green">value of time</span>](#value-of-time) (VOT)). Total costs result from applying this vehicle-specific cost rate to each vehicle's VMT, where VMT is split among household vehicles (including car services used by household members) as a (reciprocal) function of this vehicle-specific composite cost rate:

+ **Vehicle maintenance, repair, and tire cost (MRT)** costs are calculated as a function of the [<span style="color:green">vehicle type</span>](#vehicle-type), [<span style="color:green">powertrain</span>](#powertrain) and [<span style="color:green">vehicle age</span>](#vehicle-age) based on data from the American Automobile Association (AAA) and the Bureau of Labor Statistics (BLS).
+ **Fuel and energy costs** are calculated as energy rates time average fuel efficiency (miles per gallon or Kwhr electricity).
+ **Gas taxes** are federal, state and local per gallon taxes to cover road costs. For Electric vehicles, an equivalent per mile cost is calculated and can be applied to some or all electric vehicles ($/gallon or EV vehicle surcharge tax).
+ **Other Road Cost Recovery taxes** (i.e. VMT tax) is a user input. If the (optional) `BalanceRoadCostsAndRevenues` module is run, an extra VMT tax is calculated that recovers household share of road costs, consistent across all model households.
+ **Congestion fees** are calculated average congestion price ($/mile) for travel on urbanized roads in the Marea multiplied by the proportion of household travel occurring on those roads.
+ **Carbon fee** and **other social cost fees** are carbon cost per mile is calculated as the input [<span style="color:green">carbon price</span>](#carbon-price) times the average household emissions rate (grams/mile), a VMT-weighting of all vehicles in the household.  Of the other [<span style="color:green">social costs</span>](#social-costs), some are per gallon (non-EV vehicle miles) others per mile (regardless of [<span style="color:green">powertrain</span>](#powertrain)). The full per mile costs are discounted to only reflect the input proportion of [<span style="color:green">social cost</span>](#social-costs) paid by user.
+ Daily **parking costs** from work parking costs (workers who pay for parking) and other parking cost (cost of parking for shopping, etc.) are summed and divided by the household DMVT. Note that residential parking costs are included in the vehicle ownership not per mile cost calculations.
+ **Pay-as-you-drive (PAYD) insurance** is defined for participating households as the sum of the annual insurance cost for all the household vehicles is divided by the annual household VMT.
+ **Car-service costs** are the cost of using a [<span style="color:green">car service</span>](#car-service) (dollars/mile) is a user input by car service level (Low, High).

2. [_Balance Road Costs And Revenues:_](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#99-balanceroadcostsandrevenues-module)  Optionally, an extra mileage tax (\$/mile) for household vehicles needed to make up any difference in the cost of constructing, maintaining, and operating roadways and the revenues from total road cost fees including fuel, VMT, and congestion charges. Optionally, an additional mileage fee ($/mile) on household travel is calculated that would fully pay for roadway costs attributable to household vehicle travel. The cost of existing and new freeway and arterial lane-miles by Marea is calculated from the difference in input lane-miles relative to the base year and input unit [<span style="color:green">road costs</span>](#road-costs) (constructing, maintaining, and operating). Reductions in lane-miles are ignored. The proportion of road costs attributable to households is set as the ratio of household VMT divided by the sum of household (including CarService), commercial service, and car-equivalent heavy truck VMT (multiply by [<span style="color:green">PCE</span>](#passenger-car-equivalents)). Average road taxes collected per household vehicle mile are calculated as a weighted average of the average road tax per mile of each household (calculated by the `CalculateVehicleOperatingCost` module) using the household VMT (calculated by the `BudgetHouseholdDvmt` module) as the weight. Currently no annual fees contribute to road cost recovery.

3. [_Budget Household Dvmt:_](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#98-budgethouseholddvmt-module)  Household VMT is adjusted to keep within the household's [<span style="color:green">vehicle operating cost</span>](#vehicle-operating-costs) budget, based on the historic maximum proportion of income the household is willing to pay for vehicle operations. This proportions varies with income. The household's DMVT is then reduced as needed to keep annual out-of-pocket [<span style="color:green">vehicle operating cost</span>](#vehicle-operating-costs) within that share of the household's annual income. Annual vehicle operating costs include the household's VMT times their out-of-pocket per mile vehicle costs, adding credits for selected annual payments (annual work parking fee if in a work parking [<span style="color:green">cash-out-buy-back program</span>](#cash-out-buy-back), annual vehicle insurance if in a [<span style="color:green">PAYD insurance program</span>](#pay-as-you-drive), and annual auto ownership costs if [<span style="color:green">car service</span>](#car-service) program reduced auto ownership). The module relies on aggregate survey data from the U.S. Bureau of Labor Statistics (BLS) Consumer Expenditure Survey (CES) for years 2003-2015.

## Processing

VisionEval is designed to be easy to install, run, and summarize, even when comparing scores of different scenarios. It produces consistent and detailed performance metrics. The user can modify the metrics produced by the model or define their own from data exported from the model. There are also several ways to think about validation of the model within the VisionEval mindset. These topics are explored in this chapter.

### Running VisionEval

VisionEval is implemented entirely in the [R statistical language](https://www.r-project.org) and operates on recent versions of Microsoft Windows. All development work is done there, although macOS and Linux versions are usually distributed. A fully self-contained installer for the more recent production release of VisionEval can be found on the [download page](https://visioneval.org/category/download.html). It permits installation of the full VisionEval platform, to include example data, even behind firewalls that prevent access to R Project and GitHub repositories. 

Once installed the user assembles data into a [standard directory structure](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#12-basic-structure-of-model-system). Once the [model run script](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#17-basic-model-setup) is customized by the user it is typically run from a command prompt. Running it in this manner allows several different scenarios to be run at the same time with minimal user interaction. The results can then be mined or visualized using a variety of VisionEval and third-party products. Some users use [R Shiny](https://shiny.rstudio.com/) or similar interactive environments for summarizing and visualizing the output from VisionEval. Such an environment is especially useful when comparing key metrics from a large number of scenarios.

### Typical outputs

VisionEval generates a large set of performance metrics at varying summary levels. Several pre-defined metrics are compiled for mobility, economic, land use, environmental, and energy categories in each model run. They can be tabulated for individual scenarios or compared to other scenarios, as well as visualized using a variety of tools.

The intermediate data generated during the various VisionEval module steps can be compiled as performance metrics, both in absolute and per-capita terms and at various geographies. Traditional transportation network metrics such as VMT, vehicle and person hours of travel, and total delay are easily compiled by overall or focused areas within the model. Likewise, emission estimates and fuel consumption are tabulated. These can be viewed in standard reports or in `VEScenarioManager` files, especially when comparing such values between scenarios. 

One example of a set of region-wide performance metrics used by Oregon DOT includes:

+ Mobility
    + Daily per capita VMT
    + Annual walk trips per capita
    + Daily Bike trips per capita
+ Economy
    + Annual all vehicle delay per capita (hours)
    + Daily household parking costs
    + Annual HH vehicle operating cost (fuel, taxes, parking)
    + Annual HH ownership costs (depreciation, vehicle maintenance, tires, finance charge, insurance, registration)
+ Land Use
    + Residents living in mixed use areas
    + Housing type (SF: MF)
+ Environmental
    + Annual GHG emissions per capita
    + HH vehicle GHG/mile
    + Commercial vehicle GHG/mile
    + Transit Vehicle GHG/mile
 + Energy
    + Annual all vehicle fuel consumption per capita (gallons)
    + Average all vehicle fuel efficiency (net miles per gallon)
    + Annual external social costs per households (total/% paid)

### Exporting data

Most of the data generated during a VisionEval model run can be exported (using [exporter.R](https://github.com/VisionEval/VisionEval-Dev/blob/development/sources/tools/exporter.R)) if desired for further analyses. The user can then mine and visualize the data using a variety of open source and proprietary tools.  This provides the user with considerable flexibility for creating more detailed statistics than those provided by the program. These VisionEval outputs might further serve as inputs to other models (e.g., emissions models, economic impact models) and visualization tools, and compilation of additional performance metrics.

### Validation

Setting up the model includes the steps required to apply the model for a given study. It is somewhat related to validation, both for informing what types of studies that VisionEval are appropriately sensitive to and interpreting the results. See the Getting Started page on the wiki for an overview of getting started initially.

Validation is the assessment of a model's suitability for its intended purpose, often informed by comparisons against information not used in its original development. In traditional transportation planning models the comparison of observed versus modeled link flows is often a key component of validation. VisionEval is a data-driven model in that most of its inputs values are exogenously defined rather than emergent behavior from complex mathematical equations. Its aggregate representation of travel demand dictates that it be validated at the same level, with an emphasis on a wider number of comparisons than many traditional models.

The metric used in validation can range from relatively few, such as per-capita mobility estimates (e.g., VMT and VHT by mode), to a large number of more detailed targets. Examples of the latter include comparisons to external sources (e.g., HPMS data, DMV data), sensitivity tests of key variables, and comparison to comparable communities. An example of detailed validation criteria [used by the Oregon DOT]() provides examples of these targets. 

There are several options for making adjustments in order to calibrate and validate the models. These adjustments vary in difficulty, and the most appropriate approach varies by module. From easiest to most difficult the options for making adjustments are:

+ _Self-calibration:_ Several of the modules are self-calibrating in that they automatically adjust calculations to match input values without intervention by the user.[Selected value should be validated to confirm the calculations are done correctly]
+ _Adjustment of model inputs:_ Some modules allow the user to optionally enter data that can be used to adjust the models to improve their match to observed conditions.
+ _Model estimation data_: Several modules use data specific to the region where the model is deployed, such as household synthesis. Functions within each module generate cross-tabulations required from these data. [<span style="color:green">Census PUMS</span>](#census-pums) data from Oregon were used to develop the original models, and should be replaced with PUMS data for the modeled area.
+ _Model estimation scripts:_ An advanced user or developer can make adjustments to the model code itself in order to facilitate better matching observed local behavior or patterns. This, of course, is the most difficult option and opens up potential for significant errors, but it is possible for users that know what they are doing.

The main validation targets have historically included household income, vehicle ownership, vehicle miles of travel, and fuel consumption. The number of workers and drivers within each geography have recently become more widely used. These statistical comparisons can be made for the modeled area as a whole or for large geographies nested within them (e.g., Azones, Mareas). Sensitivity tests should be performed to evaluate the reasonableness (eg. correct direction and magnitude) of the VisionEval output estimates. Comparable community applications of VisionEval may also provide a reasonableness check that the model is functioning appropriately. 

Note that HPMS definition of VMT differs from that used in VisionEval. VisionEval reports on all household travel regardless of where it occurs, and adds Commercial vehicle and Heavy Duty Truck and Bus travel on MPO roads.  HPMS reports vehicular travel of all modes on roads within the MPO boundary.

## Lexicon

### 5D built form measures {#buit-form-measures}
The five dimensions considered in designing efficient and sustainable cities include density, design, destination access, distance to transit, and diversity of the built environment. The five dimensions build upon the original 3Ds (density, diversity, and design) advanced by [Cervero & Kockelman (1997)](https://www.sciencedirect.com/science/article/pii/S1361920997000096). These measures are calculated in the `Calculate4DMeasures` module during household synthesis.

### access time {#access-time}
The time required to get from the origin to the vehicle (or in the case of [car service](#car-service), the time for the vehicle to get to the traveler) and the time to get from the vehicle to the destination (including time to park the vehicle). These values are defined for vehicles owned  by the household and for two levels of car service (low and high availability levels) in each Bzone. These factors are defined in `azone_vehicle_access_times.csv` and used by the `CalculateVehicleOperatingCost` module in the `VETravelPerformance` package.
[Additional details](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#97-calculatevehicleoperatingcost-module)

### age group {#age-group}
VisionEval uses the same age groups used in the U.S. Census: 0-14, 15-19, 20-29, 30-54, 55-64, and 65+ years old. The number of persons in each age group are defined for each synthetic household.

### auto sufficiency {#auto-sufficiency}
Auto sufficiency is achieved when the number of vehicles available to a household is equal to or greater than the number of licensed drivers in a household. A household in "auto insufficient" when that is not true. Zero-auto households are cases where the household has access to a vehicle. In the age of ubiquitous mobility services this definition may become less important in describing mobility options open to the household.

### azones {#azones}
Aggregations of [Bzones](#bzones), often corresponding to county, city, Census named place, or comparable political divisions.
[Additional details](#model-geography-and-years) on VisionEval model geography levels.

### bus-equivalent-miles {#bus-equivalent-miles}
The total bus revenue miles for a transit system are divided by the assumed transit vehicle type capacities to arrive at bus-equivalent miles of service. The total bus revenue miles for a transit system are divided by the population of the enclosing Marea(s) to compute per capita bus-equivalent miles.
[Additional details](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#51-assigntransitservice-module)

### bzones {#bzones}
The smallest levels of geography coded in VisionEval, and often correspond to Census tracts or block groups. In most instances the Bzones are larger than traffic analysis zones used in traditional travel demand forecasting models.
[Additional details](#model-geography-and-years) on VisionEval model geography levels.

### carbon intensity {#carbon-intensity}
A emissions measure in grams of carbon dioxide equivalents per megajoule of energy. VisionEval uses a "well-to-wheels" estimate that takes into account not only the emissions resulting from the use of the fuel ("tank-to-wheels" measures) but also the carbon emissions required to produce and transport the fuel it where it is purchased by consumers. Default values are estimated from various sources in VisionEval. The user can specify different values. These values are used in several places in the `VEPowertrainsAndFuels` package.
[Additional details](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#8-vepowertrainsandfuels-package)

### carbon price {#carbon-price}
A carbon price in dollars per ton is used to estimate part of the [social cost](#social-costs) of emissions in the `CalculateVehicleOperatingCost` module of the `VETravelPerformance` package.
[Additional details](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#97-calculatevehicleoperatingcost-module)

### car service {#car-service}
Car services are a specific mode used in VisionEval models treated as vehicles available to the household. Car services can be considered a synonym for popular ride-sharing services provided by mobility-as-a-service (MaaS) companies. VisionEval distinguishes between two levels of car service, categorized as “high” or “low” level service. Users can define different attributes for each level of car service. Notably, households in areas with a "high" level of car service, car service will be competitive with vehicle ownership. Users can define the car service substitution probability.

### car service level {#car-service-level}
Car services include taxis, car sharing services (e.g. Car-To-Go, Zipcar), and future automated taxi services. A high car service level is one that has vehicle access times (time to walk between car and origin or final destination) that are competitive with private car use. High level of car service is considered to increase household car availability similar to owning a car. Low level car service, approximates current taxi service does not have competitive access time and is not considered as increasing household car availability.

### car service substitution probability {#car-service-substitution}
Average likelihood that an owner would substitute car services for a household vehicle (separate values by [vehicle type](#vehicle-type).  For example, if the user assumes that only a quarter of light truck owners would substitute car services for owning a light truck (e.g. because car services wouldn't enable them to use their light truck as they intend, such as towing a trailer), then the light truck substitution probability would be 0.25.

### cash-out/buy-back program {#cash-out-buy-back}
Parking cash-out schemes are an employee benefit that enables them to accept taxable cash income in lieu of paid or subsidized parking at the workplace. The cash-out is sometimes combined with discounted transit passes in some places. It is used as an inducement to reduce commuting by auto, especially in single-occupant vehicles.
FHWA has an [excellent primer on the topic](https://ops.fhwa.dot.gov/publications/fhwahop12026/sec_4.htm), while many consider Donald Shoup's [online book](http://shoup.bol.ucla.edu/Parking%20Cash%20Out%20Report.pdf) a definitive resource on the topic.

### Census PUMS {#census-pums}
The Public Use Microsample (PUMS) data are anonymized long form responses from the American Community Survey (ACS) that enable custom tabulations, summaries, and visualizations. The PUMS were formerly associated with each dicennial Census of Households and Population. The samples are anonymized by assigning each to a Public Use Microdata Area (PUMA) of 100,000 or more households. Several multi-dimensional summaries used in model estimation are gleaned from the PUMS that cannot be obtained from other Census data. Data indexed along these multiple dimensions permit the PUMS data to be fused with travel survey data and to create synthetic populations.
ACS PUMS data from 2005-19 in annual increments can be accessed from the [PUMS website](https://www.census.gov/programs-surveys/acs/microdata.html). Data from 1996-2004 can be [accessed separately](https://www2.census.gov/programs-surveys/acs/data/pums/).

### commercial service {#commercial-service}
The use of vehicles by firms and government agencies for non-personal travel other than the delivery of freight. (e.g., parcel delivery, business meetings, sales calls). Both automobiles and light trucks can be used for commercial services, and are defined both in terms of [powertrain](#powertrain) and fuel type (gasoline, diesel, or compressed natural gas).
[Additional details](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#81-loaddefaultvalues)

### congestion fee {#congestion-fee}
The fee collected to manage congestion, by charging a higher price during congested periods, and thereby reducing demand and freeing capacity for higher value users such a freight movement. Separate price schemes can be set by year to be imposed only during severe or extreme congestion. The input is the average amount paid per mile in congestion pricing fee. This is an input to the `CalculateRoadPerformance` module in the `VETravelPerformance` package.
[Additional details](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#94-calculateroadperformance-module)

### congestion level {#congestion-level}
Five levels of congestion -- none, moderate, heavy, severe, and extreme -- are estimated within each Marea by comparing [relative roadway supply] with the aggregate level of daily VMT (demand). Lookup tables are then used to estimate average speeds and delay for freeways and arterials. The effects of four standard operations programs (freeway ramp metering and incident management, arterial signal progression and access control) and optional user-defined programs are included in the calculations. The calculations are carried out in the `CalculateRoadPerformance` module of the `VETravelPerformance` package.
[Additional details](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#94-calculateroadperformance-module)

### development type {#development-type}
NEED MORE INFO The mixing of jobs and housing 

### dwelling unit type {#dwelling-unit-type}
Each household inhabits a dwelling unit that is either a single-family dwelling, a multi-family dwelling, or group quarters.
[Additional details](https://github.com/visioneval/visioneval/blob/master/api/model_system_design.md#811-model-specification-and-estimation)

### EcoDrive {#ecodrive}
A term used to describe energy efficient use of vehicles in order to reduce fuel consumption and emissions. Primarily a [European pursuit](https://www.ecodrive.org), EcoDriving involves changes to vehicular technology, vehicle navigation and automation systems, and driving techniques. Factors expressing the degree of EcoDriving adoption are applied in the `CalculateMpgMpkwhAdjustments` module of the `VETravelPerformance` package.
[Additional details](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#96-adjusthhvehiclempgmpkwh-module)

### employee commute options program {#employee-commute-options-program}
A voluntary employer-based program aimed at reducing solo commutes by automobile using strategies and incentive tailored towards each specific organization. Strategies range from providing information and management encouragement to use alternative modes of transportation to cash incentives. Cash-out/buy-in programs are one example of the latter.
A massDOT [guidebook](https://www.mass.gov/doc/guidebook/download) provides extensive information about such programs. 
In some states such programs are mandatory for large employers. Information on Oregon's [Employee Commute Options](https://www.oregon.gov/deq/aq/programs/pages/eco.aspx) program includes information about conducting employee surveys to demonstrate progress towards commuting trip reduction targets.

### employment rate {#employment-rate}
The employment rate is the number potential workers aged 17 and over divided by the total number of persons in the Bzone. Note that it is a calculated rate based on zonal attributes, and is a proxy for the labor force participation rate.

### employment type {#employment-type}
Zonal employment estimates in VisionEval are made for retail, service, and total employment categories. The delineation of retail and service employment is typically by the [two-digit sectors](https://www.census.gov/cgi-bin/sssd/naics/naicsrch?chart=2017) in the [North American Industrial Classification System](https://www.census.gov/eos/www/naics/) (NAICS). The NAICS system is widely used in most governmental reporting systems.  

### EV surcharge {#ev-surcharge}
Some states impose a tax on electric vehicles beyond sales tax and vehicle registration fees to make up for the shortfall in gasoline sales tax revenue they might otherwise contribute towards the costs of roadway infrastructure. The methods and rates [vary considerably](https://www.wsj.com/articles/more-states-charge-fees-for-electric-vehicles-11585400401), with some EV owners paying more in sales tax and EV surcharges than most owners of conventional autos. The EV surcharge can be accounted for in the `CalculateVehicleOperatingCosts` module in the `VETravelPerformance` package.
[Additional details](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#97-calculatevehicleoperatingcost-module)

### freeway lane-miles {#freeway-lane-miles}
The sum of the number of lanes multiplied by the length of each freeway segment within a metropolitan area (Marea). The lane-miles of arterials are calculated separated (see [roadway lane-miles](#roadway-lane-miles). Both are created in the `AssignRoadMiles` module of the `VETransportSupply` package.
[Additional details](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#52-assignroadmiles-module)

### freight vehicle groups
_see_ [vehicle groups](#vehicle-groups)

### fuel efficiency {#fuel-efficiency}
VisionEval does not simulate driving cycles so uses measures of relative fuel efficiency derived from the USEPA's Physical Emission Rate Estimator (PERE) for different vehicle [powertrains](#powertrains) during congested conditions. The user-supplied values in `congestion_efficiency.csv` define the congestion performance of each powertrain relative to best (1.0) and worst (0.0) values. The data are used in the `LoadDefaultValues` module in the `VEPowertrainsAndFuels` package.
[Additional details](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#81-loaddefaultvalues)

### fuel-speed curves {#fuel-speed-curves}
A set of exogenously calculated adjustments to the average fuel economy of vehicles as a function of the vehicle type (light-duty or heavy-duty), [powertrain](#powertrain), and [roadway type](#roadway-types). The curves and their derivation are described by [Bigazzi & Clifton (2011)](https://pdxscholar.library.pdx.edu/cengin_fac/342/).

### growth basis {#growth-basis}
The growth in commercial and heavy truck travel over time increase at the same rate as the population does, as firms and establishments are not explicitly modeled in VisionEval. Future year daily VMT is calculated as a function of population or income from heavy trucks or population, income, or household daily VMT for commercial service.
[Additional details](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#93-calculateroaddvmt-module)

### heavy truck {#heavy-truck}	
A single class of heavy trucks are used to represent all commercial vehicles larger than the light duty trucks included in the [commercial service](#commercial-service) vehicles. The same vehicle operating and emissions parameters specified for other [vehicle groups](#vehicle-group) are defined for heavy trucks, and their impacts are calculated in several VisionEval packages.

### individualized marketing programs {#individualized-marketing-programs}
Education and public outreach efforts designed to encourage voluntary travel behavior changes. Rather than using broad messages for the entire population this approaches targets specific groups of travelers with information more relevant to them.
A [concise fact sheet](https://www.oregon.gov/ODOT/Planning/Documents/Mosaic-Individualized-Marketing-Programs.pdf) describes its implementation in Oregon. [Dill & Mohr (2010)](https://trec.pdx.edu/research/project/160/Long_term_evaluation_of_individualized_marketing_programs_for_travel_demand_management) investigate the long-term effectiveness of such programs.

### intelligent transportation systems (ITS) {#intelligent-transportation-systems}
Systems that integrate information, communications, and advanced vehicular technologies into transportation infrastructure, maintenance, and operations programs to improve mobility and safety. ITS programs are typically centrally controlled by transportation agencies rather than individually autonomous solutions like personal navigation systems. Examples of ITS systems include traveler information systems (e.g., 511 systems, variable message signs), adaptive traffic signal systems, ramp metering, and electronic toll collection.

### ITS
_see_ [intelligent transportation systems](#intelligent-transportation-systems)

### lambda parameter {#lambda-parameter}
The assumed split of light-duty household and [commercial service](#commercial-service) vehicles between freeways and arterials is calculated dynamically as the ratio of the respective average travel speeds and an urbanized area specific factor (lambda). The latter adjusts the raw ratio of speeds to match observed percentages using data from 90 urbanized areas. The calculation is carried out in the `CalculateRoadPerformance` module.
[Additional details](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#94-calculateroadperformance-module)

### licensure rate {#licensure-rate}
The percent of adults aged 17 and over that possess a drivers license, summarized from the PUMS data for the modeled region. 

### lifecycle {#lifecycle}
A label used to describe the stage of life that a household's members are at. This is guessed at in VisionEval as a function of the number of adults, children, and workers in the household. This is assigned in the `AssignLifeCycle` module. It assumes one of 10 values defined in the [2009 NHTS LIF_CYC variable](https://nhts.ornl.gov/tables09/CodebookPage.aspx?id=1239)
[Additional details](https://github.com/visioneval/visioneval/blob/master/api/model_system_design.md#811-model-specification-and-estimation)

### location type {#location-type}
Each household is classified by whether its enclosing Bzone is located in an urban, town, or rural area. The `location_type` variable is defined for each Bzone.
[Additional details](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#15-geographic-structure-of-a-visioneval-model)

### metropolitan area (Marea) {#metropolitan-area}
In VisionEval a metropolitan area (Marea) is a collection of Azones that define a unique urbanized area with shared characteristics such as freeway lane-miles and transit revenue-miles. In some cases a transit service area might define a metropolitan area rather than political boundaries.
[Additional details](#model-geography-and-years) on VisionEval model geography levels.

### mixed use
_see_ [urban mixed-use](#urban-mixed-use)

### National Household Travel Survey (NHTS) {#national-household-travel-survey}
The NHTS collects household and traveler information and travel diaries from a random sample of U.S. households. The 2017 survey collected data from 26,000 households selected nationwide and an additional 103,112 additional "add-on" samples purchased by nine states and four regional and metropolitan planning agencies. The information collected is comparable to the data collected in bespoke household travel surveys. The latest year for which NHTS data are available is 2017, with seven prior surveys dating to 1969 conducted before it. Publicly available data are available with reduced geographic detail (i.e., households only coded to state and place size ranges) for [2017](https://nhts.ornl.gov/) and [prior years](https://nhts.ornl.gov/download.shtml). VisionEval was developed using the public use NHTS data from 2001, while the Multimodal Travel package was developed using confidential 2009 NHTS data.

### NHTS
_see_ [National Household Travel Survey](#national-household-travel-survey)

### Non-institutional group quarters {#non-institutional-group-quarters}
Persons living in non-institutional group dwellings (e.g., college dormitories, halfway houses). Persons living in institutional group dwellings are not included in VisionEval, and include hospital patients, prison inmates, and military barracks.

### out-of-pocket cost {#out-of-pocket-cost}
The variable costs of automobile usage are considered out-of-pocket costs. They are often considered the perceived cost of using automobiles. In VisionEval they include the cost of fuel and parking or the cost of using [CarService](#car-service). The out-of-pockets are a subset of the [auto operating costs](#auto-operating-costs). 

### parking costs {#parking-costs}
Parking costs in VisionEval are trip-based costs, commonly paid for at one or both ends of a trip, and sometimes paid for on a monthly basis. The standard practice for handling parking pricing in urban travel demand models is to include it in the trip costs for auto travel. Two types of parking costs are addressed in the model - parking costs at places of employment and parking costs at other places. Daily parking costs are calculated for each household and added in with other variable costs.  This includes fees for parking at workplace (including cash-out policies) and for non-work trips. Parking fees are a subset of [parking restrictions](#parking-restrictions). Parking fees can be paid for residential, workplace, or other destinations. 

### parking restrictions {#parking-restrictions}
Parking restrictions and fees affect households at their places of residence and work, as well as other places they travel to within the modeled area. This information is coded at the Bzone level and typically includes the average number of free parking spaces by dwelling unit type (single family, multi-family, and group quarters), the average daily parking cost, and proportion of workers who pay for parking or participate in a cash out-buy back program. Parking restrictions are used for Azones that are members of a defined metropolitan area (Marea) within the model.
[Additional details](https://github.com/visioneval/visioneval/blob/master/sources/modules/VELandUse/inst/module_docs/AssignParkingRestrictions.md)

### pay-as-you-drive (PAYD) {#pay-as-you-drive}
An insurance program, also known as usage-based insurance, whose premiums are based on actual usage of the insured vehicle as well as how well you drive. It is viewed by some as the emerging standard in insurance. Using a PAYD assumption in VisionEval enables the analyst to more precisely calculate [auto ownership cost](#auto-ownership-cost) based on household daily VMT estimates. The proportion of households using PAYD are included in the calculations carried out by the `CalculateVehicleOwnCost` module.
[Additional details](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#66-calculatevehicleowncost)

### passenger car equivalents (PCE) {#passenger-car-equivalents}
A factor that indicates the number of light-duty vehicles that a [heavy truck](#heavy-truck) is equivalent to in terms of vehicle length and lane usage when calculating [roadway capacity](#roadway-capacity). It is used in the `BalanceRoadCostsAndRevenues` module of the `VETravelPerformance` package.
[Additional details](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#99-balanceroadcostsandrevenues-module)

### place type {#place-type}
NEED DEFINITION

### powertrain {#powertrain}
VisionEval uses detailed operating and emissions characteristics from several different types of vehicular powertrains, enabling scenarios to be quickly assembled with different assumptions about their mix in future years. Four powertrain types are presently defined in VisionEval: internal combustion engines (ICE), hybrid electric vehicles (HEV), plug-in hybrid electric vehicles (PHEV), and battery electric vehicles (BEV). The powertrain is assigned to each household vehicle in the `AssignHhVehiclePowertrain` module.

### regular households {#regular-households}
Related and unrelated persons living in the same dwelling unit, but not including persons living in non-institutional group quarters

### region {#region}
The region defines the entire modeled area represented in the model. There is no limit to the size of the modeled region, although sub-state areas, states, and[megaregions](https://en.wikipedia.org/wiki/Megaregions_of_the_United_States) are often simulated using VisionEval. 
[Additional details](#model-geography-and-years) on VisionEval model geography levels.

### relative roadway supply {#relative-roadway-supply}
A synthetic measure that divides the total arterial and freeway lane-miles (i.e., the sum of the length in miles times the number of lanes for each distinct roadway segment) by the sum of the estimated trip lengths for all households. This calculation is carried out for each Marea and year. Thus, it is a measure that only applies in metropolitan areas defined in the model. This value is calculated in the `AssignRoadMiles` module and is used in several other modules.
[Additional details](https://github.com/visioneval/visioneval/blob/master/sources/modules/VETransportSupply/inst/module_docs/AssignRoadMiles.md) 

### relative transit supply {#relative-transit-supply}
NEED DEFINITION

### road class {#road-class}
The proportion of lane miles that are classified as freeway, arterial, and other roadways. The vehicle miles of travel (VMT) calculated for households, [commercial service](#commercial-service), and [heavy trucks](#heavy-trucks) is split between these three classes of roadways in the `LoadDefaultRoadDvmtValues` module of the `VETravelPerformance` package.
[Additional details](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#91-loaddefaultroaddvmtvalues)

### road costs {#road-costs}
This includes costs for roadway expansion, other modernization projects, preservation, operations, maintenance and administration. VisionEval calculates an average mileage tax for household vehicles needed to make up any differences in the cost of constructing, maintaining, and operating roadways from the revenues from fuel taxes and pricing schemes (e.g., VMT taxes, congestion taxes). The latter are calculated based on assumptions about fuel consumption (a function of total daily VMT) and fuel efficiency. While VisionEval adds this to the [auto operating costs](#auto-operating-costs) of households it is important to note that such costs might not be passed on by governments in future years as assumed by VisionEval. The road costs and revenues are reconciled in the `BalanceRoadCostsAndRevenue` module in the `VETravelPerformance` package.
[Additional details](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#99-balanceroadcostsandrevenues-module)

### road lane-miles {#road-lane-miles}
The sum of the number of lanes multiplied by the length of each arterial roadway segment within a metropolitan area (Marea). The lane-miles of freeways are calculated separated (see [freeway lane-miles](#roadway-lane-miles). Both are created in the `AssignRoadMiles` module of the `VETransportSupply` package.
[Additional details](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#52-assignroadmiles-module)

### road use taxes {#road-use-taxes}
_see_ [road costs](#road-costs)

### short-trip SOV diversion {#sov-diversion}
The `DivertSovTravel` module reduces travel in single-occupant vehicles (SOVs) to account for assumed availability of solo travel alternatives such as bicycles (traditional and electric) and scooters. The user inputs a goal for diverting a proportion of SOV travel within a 20-mile round-trip distance (i.e., for trips longer than 10 miles in one direction). 
[Additional details](https://github.com/visioneval/visioneval/blob/master/sources/modules/VEHouseholdTravel/inst/module_docs/DivertSovTravel.md)

### social costs {#social-costs}
Present and future generations bear costs due to the impact of transportation that are not fully recouped through [auto operating costs](#auto operating costs) or [auto ownership costs](#auto-ownership-costs), such as the costs of abating pollution, security and safety costs, and noise. VisionEval includes these costs in their full-cost accounting approach to calculating costs and benefits. The social cost parameters are defined as inputs to the `CalculateVehicleOperatingCost` module in the `VETravelPerformance` package.
[Additional details](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#97-calculatevehicleoperatingcost-module)

### speed smoothing {#speed-smoothing}
A traffic management action or design that reduces the speed variation on freeways and arterials. Note that the introduction of autonomous vehicles will likely achieve this effect even when they only constitute a quarter or more of all vehicles on the roadway ([Levin & Boyles 2015](https://doi.org/10.3141/2493-04), [Mahmassani 2016](https://doi.org/10.1287/trsc.2016.0712)). Thus, speed smoothing might become an important property of future traffic systems that analysts should include in future years even in spite of current local interest in such programs.
[Additional details](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#95-calculatempgmpkwhadjustments-module)

### transit d {#transit-d}
NEED DEFINITION

### transit modes {#transit-modes}
VisionEval includes eight transit modes, which are also called transit service modes in some places in the documentation. The eight modes include demand-responsive (DR), vanpool and similar (VP), standard motor bus (MB), bus rapid transit and commuter bus (RB), monorail or other automated guideway (MG), streetcar or trolley bus (SR), light or heavy rail (HR), and commuter rail (CR) services. The latter includes specialized CR services such as hybrid rail, cable cars, and aerial tramways.
[Additional details](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#51-assigntransitservice-module)

### transit service level {#transit-service-levels}
User-supplied annual revenue miles of service for each of the eight [transit modes](#transit-modes) are translated into bus-equivalents, revenue miles, and ultimately, vehicle miles. The transit service levels are set in the `AssignTransitService` module in the `VETransportSupply` package.
[Additional details](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#51-assigntransitservice-module)

### transit service miles {#transit-service-miles}
[Bus-equivalent-miles](#bus-equivalent-miles) used to compute [transit service levels](#transit-service-levels) are summed to calculate transit miles by each [transit mode](#transit-modes). The calculations are carried out in the `AssignTransitService` module in the `VETransportSupply` package.
[Additional details](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#51-assigntransitservice-module)

### transit vehicle type {#transit-vehicle-type}
Different energy consumption and emissions characteristics are defined for vans, buses, and rail transit modes. 
[Additional details](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#911-calculateptranenergyandemissions-module)

### travel demand management (TDM) {#travel-demand-management}
Policies and programs used to discourage travel in single-occupant vehicles in order to achieve safer and more efficient multimodal transportation systems. TDM encompasses a wide variety of initiatives, to include promotion of active transport, public transportation modes, car and bike sharing, and telecommuting. Adjustments in household VMT due to TDM actions are coded in the `BudgetHouseholdDvmt` module in the `VETravelPerformance` package.
[Additional details](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#98-budgethouseholddvmt-module)

### urban mixed-use {#urban-mixed-use}
A mixed use development or neighborhood is one that includes residential and non-residential land uses in close proximity to one another, allowing for pedestrian access to many desired goods and services. Such places are walkable,"bikeable," and encourage a local economy and strong social connections. From a transportation perspective such places are distinguished by their high degree of accessibility using non-motorized modes (active transport).
In VisionEval the proportion of each Bzone that falls into this category can either be specified by the user or calculated by the program. If the latter a random sampling from an asserted distribution is used to define whether a household is in a mixed-use area. The density of the enclosing Bzone weights the probability of a household being so classified (i.e., the higher the density the higher probability of being assigned to a mixed-use neighborhood). These calculations are carried on in the `CalculateUrbanMixMeasure` module of the `VEHouseholds` package.
[Additional details](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#45-calculateurbanmixmeasure-module)

### urbanized area {#urbanized-area}
Collectively the urban, or "metro", [location type](#location-type) portion of the [metropolitan area](metropolitan-area) (Marea) set of zones. The road, transit and urban mixed use variables only cover this portion of the Marea, which is typically equivalent to a Census urbanized area. 

### value of time (VOT) {#value-of-time}
The opportunity cost of the time that a person spends traveling rather than engaged in other activities. In theory it represents what the traveler would be willing to pay in order to reduce their time traveling. It is a surrogate for the value of travel times savings, which attempts to place a monetary value on the benefits of more efficient travel. While often an important parameter along with the equally influential value of reliability in pricing studies ([Kockelman et al. 2013](https://www.caee.utexas.edu/prof/kockelman/TransportationEconomics_Website/TranspEconReference.pdf), [Parsons Brinckerhoff et al. 2013](http://onlinepubs.trb.org/onlinepubs/shrp2/SHRP2prepubC04.pdf)) VOT is an average value in VisionEval. It is used in `TimeCost` calculations in the `CalculateVehicleOperatingCost` module. 
[Additional details](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#97-calculatevehicleoperatingcost-module)

### vehicle age {#vehicle-age}
The age of each household vehicle is estimated as a function of vehicle type (auto or light truck), household income, and the assumed average vehicle age coded for each vehicle type and Azone. The vehicle age is assigned in the `AssignVehicleAge` module in the `VEHouseholdVehicles` package.
[Additional details](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#65-assignvehicleage)

### vehicle group {#vehicle-group}
Different types of vehicles are used in VisionEval by different types of users. Automobiles and light trucks are used by households, car service, and commercial service, and are assigned in the `VEHouseholdVehicles` package. Heavy trucks are treated separately, and three types of vehicles -- vans, buses, and rail -- are used for transit.
[Additional details](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#83-calculatecarbonintensity-module)

### vehicle hours of delay (VHD) {#vehicle-hours-of-delay}
An aggregate performance measure usually calculated by subtracting vehicle hours of travel under uncontested conditions from total vehicle hours of travel (VHT). Both measures are approximated for each [metropolitan area](#metropolitan-area) in VisionEval in the `CalculateRoadPerformance` module of the `VETravelPerformance` package.
[Additional details](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#94-calculateroadperformance-module) 

### vehicle operating costs {#vehicle-operating-costs}
A combination of out-of-pocket and travel time costs used to estimate the cost per mile of owning and operating an automobile. These costs include fuel (energy), maintenance, tires, and repairs for all households. In addition, pollution or carbon taxes, parking charges, and pay-as-you-drive (PAYD) insurance costs are included where coded for the household's enclosed Bzone. The costs are calculated in the `CalculateHhVehicleOperatingCosts` module of the `VETravelPerformance` package.
[Additional details](https://github.com/visioneval/visioneval/blob/master/sources/modules/VETravelPerformance/inst/module_docs/CalculateVehicleOperatingCost.md)

### vehicle ownership costs {#vehicle-ownership-costs}
The average cost of auto ownership is calculated based upon vehicle type (automobile, light truck) and age using typical cost figures from AAA data. The cost per mile is estimated by dividing the average cost by the household daily VMT estimates produced by the model. A depreciation model is used to adjust this cost based upon the vehicle type, age, and annual miles driven (daily VMT converted into annual miles). The ownership costs represent the full costs of ownership, to include maintenance, tires, depreciation, fuel, insurance, etc.Auto ownership is adjusted when the per-mile cost of owning a car is higher than car service (mobility services) when the latter has high availability. This adjustment is made in the `AdjustVehicleOwnership` module.
[Additional details on auto ownership](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#66-calculatevehicleowncost) and [auto ownership adjustments](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#67-adjustvehicleownership)

### vehicle table {#vehicle-table}
A vehicle table is a list of every vehicle owned by a household in VisionEval. It includes the vehicle characteristics, household ID, and the Azone and Marea the household is allocated to. It is created in the `CreateVehicleTable` module in the `VEHouseholdVehicles` package.
[Additional details](https://github.com/VisionEval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#64-createvehicletable)

vehicle type {#vehicle-type}
In VisionEval vehicle type refers to the distinction between automobiles and light trucks that are used by all light duty [vehicle groups](#vehicle-group): households, car service, and commercial service vehicles.
