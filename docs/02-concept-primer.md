# Concept Primer {#conceptprimer}

## Introduction

VisionEval differs from traditional travel demand models both in how it works and what kind of planning concerns it helps to address. This chapter provides a quick introduction approach to the unique features and applications of VisionEval. It reviews the main model components and key concepts at a high level, to assist new users in understanding concepts they will apply as they set up scenarios, develop inputs and evaluate outputs.  Links to more detailed documentation will allow the reader to delve further into each topic, as they choose.


### What can I do with VisionEval?

Structurally, VisionEval may be described as a "disaggregate demand/aggregate supply" model. That is, it combines rich demographic and socioeconomic detail from a synthetic population with aggregate treatments of travel (multi-modal VMT and congestion without explicit trips, or transport networks). The implication of the "aggregate supply" model is that VisionEval cannot be used to evaluate performance of specific projects or corridors.

What VisionEval can do, and even makes especially simple, is to evaluate large numbers of scenarios and explore how combinations of alternative future conditions might affect performance measures. Travel demand models, whether built using traditional trip-based or more contemporary activity-based techniques, sacrifice flexibility for network detail. It is difficult in such models to capture novel behaviors such as an increased propensity to use inexpensive ride-hailing services, or to express shifts in vehicle ownership and occupancy that may be influenced by multiple factors some of which have not yet been observed. Yet these potential shifts are often very important for assessing the potential of pricing, investment strategies or other policy priorities. VisionEval also makes it relatively simple to explore risks and opportunities that may eventually be realized as new transportation options mature.

VisionEval won't help us determine if a particular highway segment should be built or upgraded, or what kind of transit service improvements should be extended into new areas. But it can help us look at the market for new technologies, and explore future scenarios that are based both on changed circumstances (altered demographics, increased congestion, or alternate road pricing strategies) as well as on changed behaviors (including behaviors that _might_ happen, but that we have not yet observed because the key enabling technologies are too early in their deployment). VisionEval results can be explored in detail by market segment, asking questions about how benefits might be distributed regionally, and what overall system performance might look like.

Ultimately, VisionEval is a system for asking a very broad range of "what if" questions about how the transportation system might perform, and how its benefits and costs might be distributed over the community.  It can efficiently process hundreds of scenarios looking at many different types of interventions, alternative policies, and hypothetical future conditions and travel behaviors. The results can inform strategic questions, helping decision makers answer questions such as "What are our options for achieving this performance result?" or "What are our risks if new transportation technologies develop in these different ways?"

Using VisionEval to answer such questions does not make other types of modeling obsolete (such as travel demand models or corridor microsimulations). Instead, it helps to determine what is worth the effort to code into these more detailed models, and also to explore and document novel assumptions about the future that may require extra effort to implement, and that would be prohibitively expensive to explore through traditional planning models.

### Strengths and limitations

VisionEval operates at broad geographic levels and without explicit network representations to enable very fast analyses across scores of different assumptions and inputs. It is especially well suited for quickly evaluating several different combinations of policies or assessing the range of impacts when uncertainty exists in several key inputs. Because much of the travel behavior is asserted based on observed travel patterns the latter can be changed to reflect expected changes due to new technologies, services, and expected changes in behavior over time. Thus, VisionEval is better suited than traditional travel modeling approaches for certain pursuits:

+ Screening a wide range of policy actions, especially in the face of uncertainties where ranges of expected responses or effects must be considered
+ Resilience testing under uncertainties (e.g., population growth, household size, fuel prices)
+ Directly "comparing and contrasting" broad ranges or combinations of policies (e.g., ITS, transit service, active transport, demand management)
+ Analysis of broad policy or technology changes (e.g., carbon taxes, low-carbon fuels)
+ Evaluating fuel consumption, particulate emissions, and greenhouse gas emissions impacts of proposed policies

However, VisionEval is not well suited for detailed geographic analyses, to include the effects of congestion on individual trips or tours. Thus, examining the effects of localized land use (e.g. parcel or block) or network assumptions cannot be carried out using VisionEval. Improvements in network capacity, efficiency, or safety can only be indirectly incorporated in VisionEval. 

### VisionEval geographies

Traditional travel forecasting models divide a study area into thousands of traffic analysis zones in order to facilitate highly granular spatial analyses. This allows trip (tour segment) origins and destinations to enter and exit a detailed representation of the multimodal transportation network in order to study network flows, congestion, and efficiency outcomes. VisionEval operates at a much broader spatial scale, using several levels of geography:

+ A `region` defines the entire area covered by the VisionEval analyses
+ `Azone`s are large areas such as cities, counties, or Census Public Use Microdata Areas (PUMAs)
+ `Bzone`s are subdivisions of Azones that represent neighborhoods, Census tracts or block groups, or other relatively homogenous areas
+ [<span style="color:green">Metropolitan areas</span>][lexicon] (Marea) are defined as groups of Azones that define them

The _location type_ of each household is also coded as urban, town, or rural areas. A _place type_ is also defined in terms of urban density and its mix of jobs and housing. Both are usually defined for each Bzone used in the model.

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
    + Daily household [<span style="color:green">parking costs</span>][lexicon]
    + Annual household [<span style="color:green">vehicle operating cost</span>][lexicon] (fuel, taxes, parking)
    + Annual household [<span style="color:green">auto ownership costs</span>][auto_own_cost] (depreciation, vehicle maintenance, tires, finance charge, insurance, registration)


+ Land Use
    + Number or percent of residents living in [<span style="color:green">mixed use</span>][lexicon] areas
    + Number of dwelling by housing type (e.g., single family [SF], multi-family [MF])

+ Environmental
    + Annual greenhouse gas emissions per capita
    + Household vehicle greenhouse gas/mile
    + Commercial vehicle greenhouse gas/mile
    + Transit vehicle greenhouse gas/mile

+ Energy
    + Annual per capita fuel consumption for all vehicles (gallons)
    + Average [<span style="color:green">fuel efficiency</span>][lexicon] (net miles per gallon) for all vehicles
    + Annual external [<span style="color:green">social costs</span>][lexicon] per households (total/percent paid)

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
    + [<span style="color:green">Dwelling units</span>][lexicon] by type (SF, MF)
    + Income quartiles (for allocating households to neighborhoods and [<span style="color:green">Dwelling units</span>][lexicon])
    + Share of households in [<span style="color:green">Urban Mixed Use</span>][lexicon] areas (optional)
    + [<span style="color:green">5D built form measures</span>][lexicon] (Design & Transit)
    + Developable area
    + Parking pricing policies

+ Transportation Operations Actions
    + [<span style="color:green">Road lane-miles</span>][lexicon] (freeways, arterials) (Marea)
    + [<span style="color:green">Transit Service</span>][lexicon] (service miles by transit mode) (Marea)
    + [<span style="color:green">Short SOV Trips Diversion</span>][lexicon] (to bikes, personal electrics, etc.) (Azone)
    + [<span style="color:green">ITS</span>][lexicon] Operations (Ramp metering, Incident response, (Marea)
    + ITS [<span style="color:green">speed smoothing</span>][lexicon] (Freeway ATM, Art Signal optimization) (Marea)
    + VMT covered by Drivers in [<span style="color:green">Eco-Drive</span>][lexicon] programs (Marea)
    + EV Charging infrastructure (residential) (Azone)

+ Pricing
    + Fuel and electricity costs (Azone)
    + Road Cost Recovery – Registration Fee, gas taxes, VMT fee (Azone)
    + [<span style="color:green">Carbon Pricing and other environmental impact fees</span>][lexicon](social cost recovery) (Region)
    + [<span style="color:green">Congestion Fees</span>][lexicon] (Marea)
    + [<span style="color:green">PAYD insurance</span>][lexicon] participation (Azone)

+ Vehicle, Fuels, & Emissions
    + Electricity [<span style="color:green">carbon intensity</span>][lexicon] (Azone)
    + Fuel [<span style="color:green">carbon intensity</span>][lexicon] (composites by vehicle group) (Region)
    + LDV-HH percent Light Trucks (stock) (Azone)
    + LDV-HH [<span style="color:green">vehicle age</span>][lexicon] average (Azone)
    + LDV CarService, vehicle mix (stock) (Region)
    + Transit vehicles & fuels mix (Marea)
    + LDV CommService vehicle mix, %Light Trucks (stock) (Region)
    + [<span style="color:green">Heavy truck</span>][lexicon] vehicle mix (stock) (Region)

## Scenario analyses

A key value of VisionEval is how it facilitates running many scenarios or possible futures.  In practice, the user typically starts by setting up the model with a reference scenario (i.e. a scenario that represents current policies and extrapolation of current trends). The model can be validated for current and past years at this point. This Reference scenario then serves as a pivot point for the development of alternative scenarios that modify one or more policy assumptions or other assumptions about the future (e.g. assumptions about urban area expansion, assumptions about future light-duty vehicle fleet composition). Because VisionEval models address a large number of factors that are specified by dozens of input files, and because each set of inputs could have many different values, the potential number of alternate scenarios that could be defined is probably uncountable. For this reason, the scenario generation process is simplified by defining _categories_ of inputs that are related in how they affect behavior or are related in how policies are likely to be deployed. An example of the former would be the definition of a pricing category that groups all inputs affecting the price/cost of operating light-duty vehicles (e.g. fuel price, congestion price, carbon price). An example of the latter would be the definition of a land use category which in addition to including land use inputs such as development density, also includes transportation inputs that are associated with land use such as transit service frequency. For each category of inputs, several _levels_ of change from the reference scenario assumptions are defined. Alternate scenarios can then be developed by swapping out reference scenario inputs in each category with different level inputs for the category. This is typically done in two ways:

+ Sensitivity tests that change a single category of inputs for each run. Such tests are useful for exploring the relative effects of each category.
+ Combinatorial tests which compose scenarios from combinations of all categories and all levels. 

Note that the number of combinatorial scenarios is a function of the number of categories and the number of levels in each category. For example, if inputs are grouped into 5 categories and each category has 3 levels, at total of 243 scenarios (3x3x3x3x3) would be generated by all combinations. For this reason, automated processes are typically developed to aid in the set-up and running of these scenarios, and analysis of the results. 

## Building blocks


### Household synthesis and land use

One of the strengths of VisionEval is the rich detail on individual households. This allows for household specific policies, travel behavior can respond to specific household costs and attributes, and outputs can be mined for differences by population groups. The approach of building on a synthesized population borrows from the state of the practice in activity-based travel demand models.

> Watch a [short video](https://youtu.be/-ylFbyLfhbw?t=5371) on household synthesis
 
VisionEval creates simulated households in each AZone from user-supplied projections of persons by [<span style="color:green">age group</span>][lexicon] and average [<span style="color:green">per capita income</span>][lexicon]. Each simulated household has the characteristics of the number of persons in each of 6 age groups, number of workers in each of 5 age groups, [<span style="color:green">lifecycle category</span>][lexicon], and household income. The simulated households are assigned a [<span style="color:green">dwelling unit</span>][lexicon] type (single family or multi-family) using a model that is sensitive to the household characteristics and the number of units of each type assigned to the Azone (based on user inputs). Each simulated household is assigned to a BZone based on the number of dwelling units of their assigned type in each Bzone and the household's income compared to the relative income distribution by BZone. Separately, BZones are attributed with employment and land use attributes ([<span style="color:green">location type</span>][lexicon], [<span style="color:green">built form 'D' values</span>][lexicon], [<span style="color:green">urban mixed use</span>][lexicon], and [<span style="color:green">employment by type</span>][lexicon]). Household members who are workers are assigned a BZone work location as a function of the distribution of jobs in the model area. Each home and work location is tied to a specific Bzone with its associated attributes.

Policies are added to each household as a function of their home and work Bzones:

+ Parking restrictions (work and non-work)
+ [<span style="color:green">Travel demand management</span>][lexicon] (TDM) programs (home and work-based)
+ [<span style="color:green">CarService</span>][lexicon] program availability 

The following sections describe each module that contributes to this concept.

#### Synthesize households

Household synthesis is carried out in several steps:

1. _Create customized PUMS dataset_: This is done prior to setting up a model in VisionEval. A household dataset is prepared from [<span style="color:green">Census PUMS</span>][lexicon] data for the modeled region. The default data included with VisionEval is for Oregon. PUMS data for other regions may be used instead, rebuilding the package to reflect Census households for the region of interest.
2. _Create Households_: The identified types of PUMS households are expanded to meet user control totals and other demographic inputs. [<span style="color:green">Census PUMS</span>][lexicon] data are used define probabilities that a person by [<span style="color:green">age group</span>][lexicon] would be found in each of hundreds of household types. A matrix balancing process is used to allocate persons by age to each of the PUMS household types in a way that matches input control totals and optional constraints. The sampled households are expanded to meet user control totals and other demographic inputs. 
3. _Predict Workers_: The number of workers by [<span style="color:green">age group</span>][lexicon] within each simulated household is predicted using [<span style="color:green">Census PUMS</span>][lexicon] probabilities. The user may optionally specify changes in employment rates by age group and Azone to simulate changes in labor force participation over time and/or differences in employment rates by location. 
4. _Assign LifeCyle_: Categorizes households are categorized by six [<span style="color:green">lifecycle</span>][lexicon] categories given the household age mix and employment status.
5. _Predict Income_: The annual income for each simulated household is predicted as a function of the household's worker count by age group, the average [<span style="color:green">per capita income</span>][lexicon] where the household resides (AZone), and interactions between neighborhood income and age (all and seniors). The models are estimated with [<span style="color:green">Census PUMS</span>][lexicon] data.

#### Household drivers and autos

The number of drivers and autos in each household are calculated in two steps:

1. _Assign Drivers_: Drivers by [<span style="color:green">age group</span>][lexicon] are assigned to each household as a function of the numbers of persons and workers by age group, the household income, land use characteristics, and transit availability. [<span style="color:green">Metropolitan areas</span>][lexicon] are also sensitive to transit service level and urban [<span style="color:green">mixed use</span>][lexicon] indicators at the home location. Optional restriction on drivers by age group can be used in calibration or to address trends such as lower millennial [<span style="color:green">licensure rate</span>][lexicon]s.
2. _Assign Vehicle Ownership_: The number of vehicles owned or leased by each household are determined as a function of household characteristics, land use characteristics, and transportation system characteristics. Households in [<span style="color:green">metropolitan areas</span>][lexicon] are also sensitive to [<span style="color:green">transit service level</span>][lexicon] and [<span style="color:green">urban mixed use</span>][lexicon] indicators at the home location. The model first predicts zero-auto households and then the number of vehicles owned (up to 6), if any.

#### Land use attributes

Two steps are required to add land use attributes to the synthetic population:

1. _Calculate 4D Measures_: Several land use [<span style="color:green">5D built form measures</span>][lexicon] are calculated for each Bzone. The `density`, `diversity`, and     `destination` accessibilities are based on Bzone population, employment, dwelling units, and `developable land area` inputs. The `design` variable is a user input. 
2. _Calculate Urban Mixed Use Measure_: An [<span style="color:green">urban mixed</span>][lexicon] measure for the household is calculated based on population density of the home Bzone and [<span style="color:green">dwelling unit type</span>][lexicon]. The model is based on 2001 NHTS data. The model iterates to match an optional input target on the share of households to locate in [<span style="color:green">urban mixed-use</span>][lexicon] areas.

#### Land use-household linkages

Several land use attributes are added to each household:

1. _Assign Location Types_: Households are assigned to land use [<span style="color:green">location types</span>][lexicon] -- urban, town, or rural -- by random allocation based on the household's [<span style="color:green">dwelling unit type</span>][lexicon] and input proportions on the mix of dwelling types in its enclosing Bzone.
2. [_Predict Housing_](github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#41-predicthousing-module): [<span style="color:green">Dwelling unit types</span>][lexicon] are assigned to regular and group quarter households based on the input Bzone supply of dwelling units by type. Residential households also consider the relative costliness of housing within the Azone (logged ratio of the household’s income relative to mean income in their Azone), household size, oldest age person, and the interaction of size and income ratio.
3. [_Locate Employment_](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#42-locateemployment-module): The number of input jobs by Bzone and [<span style="color:green">employment type</span>][lexicon] (retail, service, total) are scaled so that total jobs equals total household workers within the Marea. A worker table is developed and each worker is assigned to a work Bzone. The assignment essentially uses a gravity-type model with tabulations of workers and jobs by Bzone (marginal controls) and distance between residence and employment Bzones (IPF seed, inverse of straight-line distances between home and all work Bzone centroids).

#### Policy levers

Several assumptions about parking, demand management, and mobility services can also be coded:

1. [_Assign Parking Restrictions_](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#46-assignparkingrestrictions-module): Households are assigned specific [<span style="color:green">parking restrictions</span>][lexicon] and fees for their residence, workplace(s), and other places they are likely to visit based on parking inputs by BZone (within Bzones coded as within metropolitan areas [Marea] only).
    + _Residential Parking Restrictions & Fees_: The number of free parking spaces available at the household's residence is set based on input value that identify the average residential parking spaces by dwelling type in each Bzone. For household vehicles that cannot be parked in a free space a residential parking cost (part of auto ownership costs) is identified as a function of input parking rates for the home Bzone (if any).
    + _Employer Parking and Fees_: Which workers pay for parking is set by inputs that define the proportion of workers facing parking fees in each Bzone. Whether their payment is part of a [<span style="color:green">cash out/buy back</span>][lexicon] program is similarly set by input proportions by Bzone and associated fees set by input parking rates for the work Bzone.
    + _Non-work Parking Fees:_ The cost of parking for other activities such as shopping is estimated as the likelihood that a household would visit each Bzone and the parking fee in that Bzone. The likelihood is calculated with a gravity-type model, given the relative amount of activity in the Bzone (numbers of households by Bzone and the scaled retail and service job attractions by Bzone as marginals) and the proximity to each destination (inverse distance matrix from home Bzone seed matrix). The average daily parking cost is a weighted average of the fee faced in each destination bzone and the likelihood of visiting that Bzone.
2. [_Assign Demand Management_](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#47-assigndemandmanagement-module): Households are assigned to [<span style="color:green">individualized marketing programs</span>][lexicon] based on input participation levels within their home Bzone. Each worker in the household can also be assigned to an [<span style="color:green">employee commute options program</span>][lexicon] based on input participation levels for workers within their assigned work Bzone. A simple percentage reduction in household VMT is applied based on the household's participation in one or more of these program (maximum of multiple program participation, to avoid double-counting). Worker reductions are only applied to that worker's work travel portion of overall household VMT, and summed if multiple workers in the household participate in such programs.

    > Caution: The model assumes high-caliber TDM programs are in place that produce significant VMT savings. Inputs should reflect this.

3. [_Assign CarSvc Availability_](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#48-assigncarsvcavailability-module): A [<span style="color:green">car service level</span>][lexicon] is assigned to each household based on the input car service coverage for where the household resides (Bzone). High Car Service availability can have an impact on [<span style="color:green">auto ownership </span>][lexicon] (households may own fewer vehicles where high level car service is available) and auto operating cost (see the discussion in the next chapter on [household costs and budgets](#household-costs-and-budgets)).

### Household multimodal travel

> Watch a [video overview](https://youtu.be/-ylFbyLfhbw?t=5927) of the Household Multimodal Travel module

Travel of various modes by households (vehicle, transit, bike, and walk modes) is estimated as a simple function of the rich demographic and land use attributes of the household. In [<span style="color:green">metropolitan areas</span>][lexicon] travel is also influenced by inputs on transport supply on a per capita basis, such as available [<span style="color:green">roadway capacity</span>][lexicon] and [<span style="color:red">bus-equivalent transit service</span>][lexicon] levels. Transit, bike, and walk trips are also influenced by household VMT (i.e. if household VMT decreases, trips by these modes increase, and vise verse). Traditional travel models incorporate behavioral dynamics in choice models to build tours and trips for each synthetic person. VisionEval, by contrast, uses simple regression equations that directly estimate average per capita trips and miles by mode, linked by average trip lengths.

After adjusting VMT for household budget limitations it is further adjusted for household participation in TDM programs (home & work-based) and [<span style="color:green">short-trip SOV diversion</span>][lexicon] before calculating household trips for all modes. The household's bike miles are also adjusted to reflect SOV diversion input.

The following sections describe each module, which are implemented in sequence:

1. The household's daily VMT is calculated without household budget adjustments
2. The household's vehicle operating costs are calculated
3. The household's vehicle operating cost budget is calculated and daily VMT is adjusted to fit within the budget if necessary
4. Daily VMT reductions due to TDM measures and short-trip SOV diversions are calculated and applied
5. Vehicle and non-vehicular (AltMode) trips are calculated for each household

#### Transport supply

Transport supply variables are defined in two steps. Note that these calculations are only carried out within [<span style="color:green">metropolitan areas</span>][lexicon]
 (Mareas) only:

1. _Assign Transit Service_: Transit service levels are input for each [<span style="color:green">metropolitan areas</span>][lexicon] and neighborhood (Bzone).  Annual revenue-miles (i.e. transit miles in revenue service) by eight [<span style="color:green">transit modes</span>][lexicon] are read from inputs for each metropolitan area. A Bzone-level [<span style="color:red">Transit D</span>][lexicon] attribute defines access to transit (not yet work access) for each household based on inputs on relative transit accessibility. Using factors derived from the National Transit Database (NTD), input annual transit revenue miles for each of the eight transit modes are converted to [<span style="color:green">bus-equivalent miles</span>][lexicon] by three [<span style="color:green">transit vehicle types</span>][lexicon] (van, bus, and rail). Per capita [<span style="color:red">relative transit supply</span>][lexicon] and bus-equivalent service-miles are calculated.
2. _Assign Road Miles_: Stores input on the numbers of freeway lane-miles and arterial lane-miles by [<span style="color:green">metropolitan area</span>][lexicon] and year. Computes the [<span style="color:green">relative roadway supply</span>][lexicon], arterial and freeway lane-miles per capita.

#### Household travel calculations

Household travel by vehicles are calculated in three steps:

1. _Calculate Household Daily VMT (Dvmt)_: Household average daily vehicle miles traveled (VMT) is estimated as a function of household characteristics(income, workers, children, drivers), vehicle ownership, and attributes of the neighborhood (population density) and metropolitan area ([<span style="color:green">urban mixed-use</span>][lexicon], [<span style="color:green">transit service level</span>][lexicon], freeway lane-miles) where the household resides. It also calculates household VMT percentiles which are used by other modules to calculate whether a household is likely to own an electric vehicle (EV) and to calculate the proportions of plug-in hybrid electric vehicles (PHEV) VMT powered by electricity. These values are derived from the 2001 [<span style="color:green">NHTS</span>][lexicon] data.
2. _CalculateVehicleTrips_: This module calculates average daily vehicle trips for households consistent with the household VMT. Average length of household vehicle trips is estimated as a function of household characteristics (drivers/non-driers, income), vehicle ownership ([<span style="color:green">auto sufficiency</span>][lexicon]), and attributes of the neighborhood (population density) and [<span style="color:green">metropolitan area</span>][lexicon] ([<span style="color:green">urban mixed-use</span>][lexicon], freeway lane-miles) where the household resides, and interactions among these variables. The average trip length is divided into the average household VMT to get an estimate of average number of daily vehicle trips.
3. _Calculate AltMode Trips_: This module calculates household transit trips, walk trips, and bike trips. The models are sensitive to household VMT so they are run after all household VMT adjustments (e.g., to account for cost on household VMT) are made. Twelve models estimate trips for the three modes in metropolitan and non-metropolitan areas, in two steps each. The first step determines whether a household has any AltMode trips and the second part determines the number of trips. All of the models include terms for household characteristics (size, income, age mix) and the household's overall VMT. Neighborhood factors (population density) factors into all but the bike trip models. For households in metropolitan areas [<span style="color:green">transit service level</span>][lexicon] has an impact as well, with transit ridership also sensitive to when residents live in [<span style="color:green">urban mixed-use</span>][lexicon] neighborhoods.

#### SOV diversion

Household single-occupant vehicle (SOV) travel is reduced to achieve bike and micro-transportation input policy goals, i.e., for diverting a portion of SOV travel within a 20-mile tour distance (round trip distance). This allows evaluating the potential for light-weight vehicles (e.g. bicycles, electric bikes, electric scooters) and infrastructure to support their use, in reducing SOV travel. First, the amount of the household's VMT that occurs in SOV tours having round trip distances of 20 miles or less is estimated. Then the average trip length within those tours is estimated. Both models are sensitive to household characteristics(drivers, income, kids), vehicle ownership ([<span style="color:green">auto sufficiency</span>][lexicon]), and attributes of the neighborhood (population density, dwelling type) and [<span style="color:green">metropolitan area</span>][lexicon] ([<span style="color:green">urban mixed-use</span>][lexicon], freeway lane-miles) where the household resides, and the household's overall VMT.

The diversion of these short trips is assumed to only apply in urban and town [<span style="color:green">location types</span>][lexicon]. The VMT reductions are allocated to households as a function of the household's SOV VMT and (the inverse of) SOV trip length. In other words, it is assumed that households having more qualifying SOV travel and households having shorter SOV trips will be more likely to divert SOV travel to bicycle-like modes. The estimates of the household's share of diverted VMT, average trip length of diverted VMT are applied elsewhere to reduce DMVT and increase bike trips. Zero vehicle households are not allowed to divert SOV travel. [<span style="color:green">Census PUMS</span>][lexicon] data is used to estimate the models.

#### DVMT reductions

Each household's VMT is adjusted for their TDM program(s) participation, if any, as well as input from metropolitan area [<span style="color:green">short-trips SOV diversion</span>][lexicon] goals. The SOV diversion also increases bike trips (diverted SOV VMT divided by SOV average trip length).

### Vehicles, fuels and emissions

The [<span style="color:green">powertrains</span>][lexicon], fuels, and associated emissions datasets for all modeled [<span style="color:green">vehicle groups</span>][lexicon] are among the most complex inputs used in VisionEval. Default datasets are included in the VisionEval installer to simplify this for the user. The user can use these defaults or develop their own data that matches the VisionEval input requirements. It is anticipated that different datasets will be developed by users that can be shared with the VisionEval community. For example, one package may represent a base scenario of federal vehicle, fuel, and emission standards, while another package represents the California zero-emissions vehicle (ZEV) rules and low carbon fuel for the home location's [<span style="color:green">CarService</span>][lexicon]. 

The model looks in household vehicle sales tables indexed by [<span style="color:green">vehicle type</span>][lexicon] and age to determine the probability of each powertrain in that sales year, along with its associated fuel efficiency and other attributes.  Each household vehicle is assigned attributes consistent with these probabilities. In some cases electric vehicles (EVs) are replaced by plug-in hybrid electric vehicles (PHEVs) if household VMT and residential charging limitations exist.  

The [<span style="color:green">powertrain</span>][lexicon] mix of non-household vehicle groups -- car service, commercial service, transit, and heavy trucks --  is applied to VMT (rather than individual vehicles) in the scenario year (rather than sales year). There is some input adjustment for average vehicle age and commercial [<span style="color:green">vehicle type</span>][lexicon] share.

Fuels for each vehicle groups can rely on the package defaults, or use one of two input options.  The user can either provide a composite [<span style="color:green">carbon intensity</span>][lexicon] representing all gallons of fuel used for that vehicle group, or provide fuel mix shares (base fuel mix, biofuel blend proportions), combined with package default lifecycle (well-to-wheels) carbon intensity for the individual fuels.  The resulting carbon intensity per gallon are applied to gallons generated from VMT and vehicle fuel efficiency assumptions. Adjustments to fuel efficiency due to reduced speeds due to congestion as well as ITS operational programs (e.g., [<span style="color:green">speed smoothing</span>][lexicon]) and [<span style="color:green">EcoDrive</span>][lexicon] programs.

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

1. [_Create Vehicle Table:_](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#64-createvehicletable)  A [<span style="color:green">vehicle table</span>][lexicon] is created with a record for every vehicle owned by the household, and additional vehicle records are added to reach the household’s number of driving age persons. Each vehicle record is populated with household ID and geography fields (Azone, Marea) and [<span style="color:green">access time</span>][lexicon] attributes. Each vehicle record is either “own” or (driving-age person without a vehicle) assigned access to a [<span style="color:green">CarService</span>][lexicon] level, depending upon coverage in the household’s home Bzone. 
2. [_Assign Vehicle Type:_](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#63-assignvehicletype). Identifies how many household vehicles are light trucks and how many are automobiles as a function of number of vehicles, person-to-vehicle and vehicle-to-driver ratios, number of children, [<span style="color:green">dwelling unit type</span>][lexicon], income, density, and [<span style="color:green">urban mixed use</span>][lexicon] data (in [<span style="color:green">metropolitan areas</span>][lexicon] only).

#### Powertrains and fuels defaults

These values are defined in two steps:

1. [_Load Default Values:_](https://github.com/gregorbj/A`rchive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#81-loaddefaultvalues). This script, run before the rest of VisionEval is started, reads and processes the default [<span style="color:green">powertrains</span>][lexicon] and fuels files in the package and creates datasets used by other modules to compute fuel and electricity consumption, and well as associated fuel and electricity [<span style="color:green">carbon intensity</span>][lexicon] emissions from vehicle travel.
2. An [_Initialize_](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#82-initialize-module) step is run by VisionEval as part of its initialization on each run. Optional user-supplied vehicle and fuel input files, if any, are processed (including input data checks). When available, modules that compute carbon intensities of vehicle travel will use the user-supplied data instead of the package default datasets.

#### Assign household powertrains and fuels

The powertrain and fuel type is assigned to each vehicle in each household in three steps:

1. [_Assign Vehicle Age:_](github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#65-assignvehicleage)  Assigns vehicle ages to each household vehicle and [<span style="color:green">CarService</span>][lexicon] vehicle used by the household as a function of the [<span style="color:green">vehicle group</span>][lexicon] (household vehicles only), household income, and assumed mean vehicle age by vehicle type and Azone. The age model starts with an observed vehicle age distribution and relationship between vehicle age and income. These data are currently based on summaries of the 2001 [<span style="color:green">NHTS</span>][lexicon]. Adjustments are made based on user average vehicle age inputs (household by vehicle type, car service overall). 
2. [_Assign Household Vehicle Powertrain:_](github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#84-assignhhvehiclepowertrain-module)  This module assigns a [<span style="color:green">powertrain</span>][lexicon] type to each household vehicle. The age of each vehicle is used with default tables by [<span style="color:green">vehicle type</span>][lexicon] that identify the powertrain mix of vehicles sold in each sales year. Other default tables identify vehicle characteristics tied to powertrain that include battery range, [<span style="color:green">fuel efficiency</span>][lexicon], and emissions rate. Assignments of EVs may be changed to PHEVs if the battery range is not compatible with estimated day-to-day trip lengths, or the home dwelling lacks vehicle charging availability.
3. [_Calculate Carbon Intensity:_](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#83-calculatecarbonintensity-module)  This module calculates the average [<span style="color:green">carbon intensity</span>][lexicon] of fuels (grams CO2e per megajoule) by [<span style="color:green">vehicle group</span>][lexicon] and, if applicable, [<span style="color:green">vehicle type</span>][lexicon]. Average fuel carbon intensities for transit vehicle modes are calculated by [<span style="color:green">metropolitan area</span>][lexicon], other vehicles are calculated for the entire model region. The module also reads the input average [<span style="color:green">carbon intensity</span>][lexicon] of electricity at the Azone level.

#### Assign non-household powertrains and fuels

The assignment of powertrain and fuel characteristics is carried out in two steps:

1. [_Calculate Transit Energy And Emissions:_](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#911-calculateptranenergyandemissions-module) This module calculates the energy consumption and carbon emissions from transit vehicles in urbanized areas. Assumptions (package default or user input) on [<span style="color:green">powertrain</span>][lexicon] mix and fuels for three [<span style="color:green">transit vehicle types</span>][lexicon] by [<span style="color:green">metropolitan area</span>][lexicon] are applied to associated Marea [<span style="color:green">transit service miles</span>][lexicon] for these types. Assumptions (package default or user input) on average [<span style="color:green">carbon intensity</span>][lexicon] of fuel and electricity by [<span style="color:green">transit vehicle types</span>][lexicon] are then applied to Marea fuel and electricity usage across types to calculate carbon emissions.
2. [_Calculate Commercial Energy And Emissions:_](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#910-calculatecomenergyandemissions-module)  The energy consumption and carbon emissions of [<span style="color:green">heavy trucks</span>][lexicon] and [<span style="color:green">commercial service</span>][lexicon] VMT (no vehicles) are calculated by on-road (not sales) year. VMT shares of Commercial Service [<span style="color:green">powertrains</span>][lexicon] by [<span style="color:green">vehicle type</span>][lexicon] and [<span style="color:green">heavy truck</span>][lexicon] powertrains are calculated (per package default or user input). Any [<span style="color:green">fuel efficiency</span>][lexicon] (MPG and MPKWH) adjustments are then applied, due to policies ([<span style="color:green">EcoDriving</span>][lexicon], [<span style="color:green">speed smoothing</span>][lexicon] and/or congestion (including effects of any [<span style="color:green">ITS</span>][lexicon] operational and congestion fee policies). Ecodriving applies only to internal combustion engine (ICE) vehicles and [<span style="color:green">ITS</span>][lexicon] operational policies and congestion apply only in [<span style="color:green">metropolitan areas</span>][lexicon]. Both vary by [<span style="color:green">powertrain</span>][lexicon] and for commercial vehicles, [<span style="color:green">vehicle type</span>][lexicon]. Combining [<span style="color:green">fuel efficiency</span>][lexicon] and VMT (from the Household Multimodal Travel Model) results in estimates of energy usage (fuel and electricity). Fuel carbon intensity for these modes is calculated by [<span style="color:green">metropolitan area</span>][lexicon] and/or region and applied to fuel and electricity usage to estimate CO2e emissions.

## Adjustments

### Congestion adjustments

Congestion, only calculated on urbanized roads (a subset of [<span style="color:green">metropolitan area</span>][lexicon] roads, requires estimating and combining together the VMT of all [<span style="color:green">vehicle groups</span>][lexicon]. For non-household vehicles, base year VMT is calculated directly from inputs and model parameters, while future year is a function of the input [<span style="color:green">growth basis</span>][lexicon]. Initial allocations of DMVT across [<span style="color:green">road class</span>][lexicon] is based on input values. 

Light duty vehicle (LDV) VMT is allowed to re-allocate between freeways and arterials to balance demand (VMT) and roadway supply (lane-miles) through a generalized cost framework (including roadway speed and congestion fees, if any). Roadway supply (i.e., capacity) is adjusted by delay-reducing [<span style="color:green">ITS</span>][lexicon] operations policies based on [<span style="color:green">fuel-speed curves</span>][lexicon] by [<span style="color:green">powertrain</span>][lexicon], the resulting congested speeds impact vehicle [<span style="color:green">fuel efficiency</span>][lexicon]. Further adjustments are applied to reflect any [<span style="color:green">speed smoothing</span>][lexicon] and [<span style="color:green">EcoDrive</span>][lexicon] programs that may not affect delay but reduce acceleration and deceleration with associated impacts on fuel efficiency.

No fuel efficiency adjustments for congestion or policies are made to non-urban roadway VMT.  The delays faced by each household and associated fuel economy impacts are applied to each individual household's VMT and vehicles. Resulting overall average speeds, delays, and DMVT proportions, by [<span style="color:green">road class</span>][lexicon] at each [<span style="color:green">congestion level</span>][lexicon] on urbanized and other roads are also tabulated along with the resulting average per mile [<span style="color:green">congestion fees</span>][lexicon] paid, if any, and overall vehicle hours of delay (VHD) by [<span style="color:green">vehicle group</span>][lexicon].

> Watch a [video summary](https://youtu.be/-ylFbyLfhbw?t=8401) of VisionEval's congestion adjustment

#### Initialize roadway conditions

The roadway conditions in the model are calculated in three steps:

1. [_Load Default Road VMT Values:_](github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#91-loaddefaultroadVMTvalues)  These calculations are completed before the model run starts. The base year roadway VMT is processed, including light duty vehicle and [<span style="color:green">heavy truck</span>][lexicon] VMT by state and urbanized area as well as VMT proportions by urbanized area, [<span style="color:green">vehicle group</span>][lexicon] (light duty vehicle, heavy truck, bus), and [<span style="color:green">road class</span>][lexicon]. The user can either provide direct inputs for these values or specify a state and/or urbanized area and the model will use default data from the [20xx USDOT Highway Statistics](https://github.com/VisionEval/VisionEval/tree/master/sources/modules/VETravelPerformance/inst/extdata/sources), where available.
2. [_Initialize:_](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#92-initialize-module). This step is run when the model run is initialized. User inputs used by several modules are read and checked (many with several valid options, proportions sum to 1, consistency, congestion fees increase with congestion level). Some of these values are optional, using default data where not specified. This includes various assumptions on base year VMT within both [<span style="color:red">urbanized area(s)</span>][lexicon] and the full model region, by [<span style="color:green">vehicle group</span>][lexicon], allocation among [<span style="color:green">road class</span>][lexicon], [<span style="color:green">growth basis</span>][lexicon], and assumptions for [<span style="color:green">freight vehicle groups</span>][lexicon]. It also checks inputs on [<span style="color:green">ITS</span>][lexicon] operational policies and [<span style="color:green">EcoDriving</span>][lexicon] programs, including any user-specified "other ops" programs and [<span style="color:green">congestion fees</span>][lexicon] (by road class and [<span style="color:green">congestion level</span>][lexicon]). 
3. [_Calculate Road VMT:_](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#93-calculateroadVMT-module)  Adds together [<span style="color:green">metropolitan area</span>][lexicon] VMT of all [<span style="color:green">vehicle groups</span>][lexicon] (Households, CarService, Commercial Service, Heavy Truck, Transit) and allocates it across [<span style="color:green">road classes</span>][lexicon] (freeway, arterial, other), limiting it to urbanized area roadways for use in congestion calculations. To do so, several factors are established in the base year.  One uses the input [<span style="color:green">growth basis</span>][lexicon] (population, income, household VMT) to estimate future year [<span style="color:green">freight vehicle group</span>][lexicon] (commercial service and heavy truck) VMT (using input base year VMT values by region and Marea, if provided, model-estimates otherwise). A second base year factor identifies the urban and non-urban allocation of VMT from [<span style="color:green">metropolitan area</span>][lexicon] households and related commercial service vehicles. For Heavy Trucks VMT an input specifies the proportion of VMT on urbanized roads while transit VMT (of all [<span style="color:green">transit service modes</span>][lexicon]) is assumed to only occur on urbanized roads. Base year allocations of urban VMT by [<span style="color:green">vehicle group</span>][lexicon] among [<span style="color:green">road classes</span>][lexicon] are based on input shares, subject to adjustment during subsequent congestion calculations. Finally, to assess delay faced by each household and associated fuel efficiency impacts, each individual household's VMT is split between miles on urbanized and other road miles.

#### Congestion model and adjustments

Three adjustments are made based on congestion levels:

1. [_Calculate Road Performance:_](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#94-calculateroadperformance-module)  [<span style="color:green">Congestion level</span>][lexicon] by [<span style="color:green">road class</span>][lexicon] and the associated amounts of VMT are iteratively estimated. Light duty vehicle (LDV) VMT is allowed to re-allocate between freeways and arterials to balance demand and roadway supply (lane-miles) through a generalized cost framework (including roadway speed and congestion fees, if any and an estimated base year urbanized area [<span style="color:green">lambda parameter</span>][lexicon] based on the area's population and freeway-arterial lane-mile ratio). DMVT allocation at different aggregate demand-supply ratios relies on data from the [2009 Urban Mobility Study (UMS)](https://static.tti.tamu.edu/tti.tamu.edu/documents/umr/archive/mobility-report-2009-wappx.pdf) for 90 urbanized areas, where the model chooses the 5-10 cities with most similar congestion ratios.

    The supply calculation considers the delay-reduction effects of deploying urban area [<span style="color:green">ITS</span>][lexicon] operations programs (freeway ramp metering, freeway incident management, arterial signal coordination, arterial access control or user-defined "other ops" programs. The standard ITS-operations program impacts are based on research ([Bigazzi & Clifton 2011](https://github.com/VisionEval/VisionEval/tree/master/sources/modules/VETravelPerformance/inst/extdata/sources)). Non-urban speeds are also calculated, using a simple ratio of rural-to-urban travel volumes.
    
    The resulting average speeds, delay and DMVT proportions, by [<span style="color:green">road class</span>][lexicon] at each [<span style="color:green">congestion level</span>][lexicon] on urbanized and other metropolitan area roads are calculated, as is the resulting average per mile [<span style="color:green">congestion fees</span>][lexicon] paid, if any, and overall VHD by [<span style="color:green">vehicle group</span>][lexicon].

2. [_Calculate Mpg Mpkwh Adjustments:_](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#95-calculatempgmpkwhadjustments-module)  Adjustments to [<span style="color:green">fuel efficiency</span>][lexicon] (MPG and MPKwhr) for all [<span style="color:green">vehicle groups</span>][lexicon] resulting from traffic congestion, [<span style="color:green">congestion fees</span>][lexicon], ITS [<span style="color:green">speed smoothing</span>][lexicon] (i.e. active traffic management which reduces speed variation), and [<span style="color:green">EcoDriving</span>][lexicon] are calculated. The [<span style="color:green">fuel-speed curves</span>][lexicon] vary by [<span style="color:green">road class</span>][lexicon], congestion [<span style="color:green">powertrains</span>][lexicon] (LdIce, LdHev, LdEv, HdIce) and, where applicable, [<span style="color:green">vehicle type</span>][lexicon] relative to reference speeds by [<span style="color:green">road class</span>][lexicon]. The adjustments are based on drive-cycle level simulation research ([Bigazzi & Clifton 2011](https://github.com/VisionEval/VisionEval/tree/master/sources/modules/VETravelPerformance/inst/extdata/sources)). Note that no adjustments are made for [<span style="color:green">ITS</span>][lexicon] policies (standard and speed smoothing policies) or [<span style="color:green">EcoDrive</span>][lexicon] programs on 'other' road classes (non-freeway or arterials) and non-urbanized roads, which are assumed to be uncongested. 
3. [_Adjust Household Vehicle MPg Mpkwh:_](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#96-adjusthhvehiclempgmpkwh-module)  Implements the [<span style="color:green">fuel efficiency</span>][lexicon] (MPG and MPKwh) adjustments of household vehicles (including Car Service VMT), reflecting the effects of congestion, [<span style="color:green">congestion fees</span>][lexicon], ITS [<span style="color:green">speed smoothing</span>][lexicon], and [<span style="color:green">eco-driving</span>][lexicon] that were calculated elsewhere. These adjustments vary by vehicle [<span style="color:green">powertrain</span>][lexicon], [<span style="color:green">vehicle type</span>][lexicon], and the proportion of the household's travel that is driven on urban and non-urban roads within the [<span style="color:green">metropolitan area</span>][lexicon]. Joint effects are calculated as the product of congestion speed effects and the maximum of implemented speed-smoothing policies (eco-driving & ITS-speed smoothing).

### Household costs and budgets {#household-costs-and-budgets}

Two adjustments are made in response to household budgets. [<span style="color:green">Auto ownership costs</span>][lexicon] are calculated and an adjustment is made to the number of household owned autos if the costs are greater than switching to a 'High' level [<span style="color:green">Car Service</span>][lexicon], where available (subject to input limits on [<span style="color:green">Car Service</span>][lexicon] substitutability). [<span style="color:green">Vehicle ownership costs</span>][lexicon] include financing, depreciation, insurance (unless in [<span style="color:green">PAYD program</span>][lexicon]), annual registration fees, and residential parking fees.

Additionally, in order to respond to pricing policies and energy costs, VisionEval imposes an operating cost budget limitation. Household VMT is constrained such that annual [<span style="color:green">vehicle operating costs</span>][lexicon] must stay below a maximum share of annual household income, or budget limit. A household-specific average annual vehicle operating costs is first calculated, including out-of-pocket per mile costs for each household owned and Car Service vehicles used by the household, as well as time-equivalent cost (input [<span style="color:green">access times</span>][lexicon], estimates of VMT at congested speeds, and [<span style="color:green">value of time</span>][lexicon] input). Vehicle operating costs determine the proportional split of VMT across household vehicles. Out-of-pocket costs include the energy, maintenance, repair, & tires, [<span style="color:green">road use taxes</span>][lexicon] (including [<span style="color:green">EV surcharge</span>][lexicon] and optional calculation of fee to fully recover road costs), work/non-work parking, [<span style="color:green">PAYD insurance</span>][lexicon], input share of carbon and other [<span style="color:green">social costs</span>][lexicon], as well as [<span style="color:green">CarService</span>][lexicon] fees by the household. Note that time-equivalent costs are only used to allocate travel between household vehicles (including car services used by the household). Time-equivalent cost is not used in the balancing of household vehicle operating cost and budget.

The following sections describe each module that contributes to this concept.

> Watch a [video overview](https://youtu.be/-ylFbyLfhbw?t=8739) of costs and budgets

#### Auto Ownership Cost & Adjustment

Two steps are required to calculate and adjust auto ownership costs:

1. [_Calculate Vehicle Own Cost:_](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#66-calculatevehicleowncost)  Average [<span style="color:green">vehicle ownership costs</span>][lexicon] are calculated for each vehicle based on the vehicle type, age, and annual VMT (financing, depreciation, and insurance), annual registration fees (flat and ad valorum), combined with any residential [<span style="color:green">parking fees</span>][lexicon] (if household exceeds free parking limits). To do so, [<span style="color:green">PAYD insurance</span>][lexicon] participation is assigned based on household characteristics (drivers by age, annual mileage, income, location type, vehicle type and age) and input PAYD insurance program participation. The ownership cost is converted into an average vehicle-specific ownership cost per mile by dividing by estimated household VMT per vehicle.

    Note that PAYD insurance does not affect the cost of vehicle ownership when determining whether a household will substitute car services for one or more of their vehicles. It does affect the out-of-pocket operating cost used in budget limitations on household VMT.
    
    2. [_Adjust Vehicle Ownership:_](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#67-adjustvehicleownership)  Household vehicle ownership is adjusted based on a comparison of the cost of owning versus 'high' [<span style="color:green">car service</span>][lexicon] per mile rates, where available. The module identifies all household vehicles in a 'High' car service area, where the car service mileage rate exceeds the household's estimated [<span style="color:green">vehicle ownership cost</span>][lexicon] per annual household VMT. The household's [<span style="color:green">vehicle table</span>][lexicon] entry changes from 'Own' to 'HighCarSvc' for these vehicles, limited by input assumptions regarding the average likelihood that an owner would substitute [<span style="color:green">car services</span>][lexicon] for a household vehicle (separate values are specified by [<span style="color:green">vehicle type</span>][lexicon]). Other auto ownership values are also updated (e.g., insurance, total vehicles).

#### Auto Operating Cost & Adjustment

Three primary adjustments adjustments to auto operating cost are carried out in VisionEval:

1. [_Calculate Vehicle Operating Cost:_](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#97-calculatevehicleoperatingcost-module)  A composite per mile cost is calculated as an [<span style="color:green">out-of-pocket cost</span>][lexicon] for various household and Car Service vehicle VMT (see below), combined with cost equivalent of travel time (access time and travel time at congested speeds times [<span style="color:green">value of time</span>][lexicon] (VOT)). Total costs result from applying this vehicle-specific cost rate to each vehicle's VMT, where VMT is split among household vehicles (including car services used by household members) as a (reciprocal) function of this vehicle-specific composite cost rate:

    + **Vehicle maintenance, repair, and tire cost (MRT)** costs are calculated as a function of the [<span style="color:green">vehicle type</span>][lexicon], [<span style="color:green">powertrain</span>][lexicon] and [<span style="color:green">vehicle age</span>][lexicon] based on data from the American Automobile Association (AAA) and the Bureau of Labor Statistics (BLS).
    + **Fuel and energy costs** are calculated as energy rates time average fuel efficiency (miles per gallon or Kwhr electricity).
    + **Gas taxes** are federal, state and local per gallon taxes to cover road costs. For Electric vehicles, an equivalent per mile cost is calculated and can be applied to some or all electric vehicles ($/gallon or EV vehicle surcharge tax).
    + **Other Road Cost Recovery taxes** (i.e. VMT tax) is a user input. If the (optional) `BalanceRoadCostsAndRevenues` module is run, an extra VMT tax is calculated that recovers household share of road costs, consistent across all model households.
    + **Congestion fees** are calculated average congestion price ($/mile) for travel on urbanized roads in the Marea multiplied by the proportion of household travel occurring on those roads.
    + **Carbon fee** and **other social cost fees** are carbon cost per mile is calculated as the input [<span style="color:green">carbon price</span>][lexicon] times the average household emissions rate (grams/mile), a VMT-weighting of all vehicles in the household.  Of the other [<span style="color:green">social costs</span>][lexicon], some are per gallon (non-EV vehicle miles) others per mile (regardless of [<span style="color:green">powertrain</span>][lexicon]). The full per mile costs are discounted to only reflect the input proportion of [<span style="color:green">social cost</span>][lexicon] paid by user.
    + Daily **parking costs** from work parking costs (workers who pay for parking) and other parking cost (cost of parking for shopping, etc.) are summed and divided by the household DMVT. Note that residential parking costs are included in the vehicle ownership not per mile cost calculations.
    + **Pay-as-you-drive (PAYD) insurance** is defined for participating households as the sum of the annual insurance cost for all the household vehicles is divided by the annual household VMT.
    + **Car-service costs** are the cost of using a [<span style="color:green">car service</span>][lexicon] (dollars/mile) is a user input by car service level (Low, High).

2. [_Balance Road Costs And Revenues:_](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#99-balanceroadcostsandrevenues-module)  Optionally, an extra mileage tax (\$/mile) for household vehicles needed to make up any difference in the cost of constructing, maintaining, and operating roadways and the revenues from total road cost fees including fuel, VMT, and congestion charges. Optionally, an additional mileage fee ($/mile) on household travel is calculated that would fully pay for roadway costs attributable to household vehicle travel. The cost of existing and new freeway and arterial lane-miles by Marea is calculated from the difference in input lane-miles relative to the base year and input unit [<span style="color:green">road costs</span>][lexicon] (constructing, maintaining, and operating). Reductions in lane-miles are ignored. The proportion of road costs attributable to households is set as the ratio of household VMT divided by the sum of household (including CarService), commercial service, and car-equivalent heavy truck VMT (multiply by [<span style="color:green">PCE</span>][lexicon]). Average road taxes collected per household vehicle mile are calculated as a weighted average of the average road tax per mile of each household (calculated by the `CalculateVehicleOperatingCost` module) using the household VMT (calculated by the `BudgetHouseholdDvmt` module) as the weight. Currently no annual fees contribute to road cost recovery.
3. [_Budget Household Dvmt:_](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#98-budgethouseholddvmt-module)  Household VMT is adjusted to keep within the household's [<span style="color:green">vehicle operating cost</span>][lexicon] budget, based on the historic maximum proportion of income the household is willing to pay for vehicle operations. This proportions varies with income. The household's DMVT is then reduced as needed to keep annual out-of-pocket [<span style="color:green">vehicle operating cost</span>][lexicon] within that share of the household's annual income. Annual vehicle operating costs include the household's VMT times their out-of-pocket per mile vehicle costs, adding credits for selected annual payments (annual work parking fee if in a work parking [<span style="color:green">cash-out-buy-back program</span>][lexicon], annual vehicle insurance if in a [<span style="color:green">PAYD insurance program</span>][lexicon], and annual auto ownership costs if [<span style="color:green">car service</span>][lexicon] program reduced auto ownership). The module relies on aggregate survey data from the U.S. Bureau of Labor Statistics (BLS) Consumer Expenditure Survey (CES) for years 2003-2015.

## Processing

VisionEval is designed to be easy to install, run, and summarize, even when comparing scores of different scenarios. It produces consistent and detailed performance metrics. The user can modify the metrics produced by the model or define their own from data exported from the model. There are also several ways to think about validation of the model within the VisionEval mindset. These topics are explored in this chapter.

### Running VisionEval

VisionEval is implemented entirely in the [R statistical language](https://www.r-project.org) and operates on recent versions of Microsoft Windows. All development work is done there, although macOS and Linux versions are usually distributed. A fully self-contained installer for the more recent production release of VisionEval can be found on the [download page](https://visioneval.org/category/download.html). It permits installation of the full VisionEval platform, to include example data, even behind firewalls that prevent access to R Project and GitHub repositories. 

Once installed the user assembles data into a [standard directory structure](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#12-basic-structure-of-model-system). Once the [model run script](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#17-basic-model-setup) is customized by the user it is typically run from a command prompt. Running it in this manner allows several different scenarios to be run at the same time with minimal user interaction. The results can then be mined or visualized using a variety of VisionEval and third-party products. Some users use [R Shiny](https://shiny.rstudio.com/) or similar interactive environments for summarizing and visualizing the output from VisionEval. Such an environment is especially useful when comparing key metrics from a large number of scenarios.

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
+ _Model estimation data_: Several modules use data specific to the region where the model is deployed, such as household synthesis. Functions within each module generate cross-tabulations required from these data. [<span style="color:green">Census PUMS</span>][lexicon]Census PUMS data from Oregon were used to develop the original models, and should be replaced with PUMS data for the modeled area.
+ _Model estimation scripts:_ An advanced user or developer can make adjustments to the model code itself in order to facilitate better matching observed local behavior or patterns. This, of course, is the most difficult option and opens up potential for significant errors, but it is possible for users that know what they are doing.

The main validation targets have historically included household income, vehicle ownership, vehicle miles of travel, and fuel consumption. The number of workers and drivers within each geography have recently become more widely used. These statistical comparisons can be made for the modeled area as a whole or for large geographies nested within them (e.g., Azones, Mareas). Sensitivity tests should be performed to evaluate the reasonableness (eg. correct direction and magnitude) of the VisionEval output estimates. Comparable community applications of VisionEval may also provide a reasonableness check that the model is functioning appropriately. 

> Note that HPMS definition of VMT differs from that used in VisionEval. VisionEval reports on all household travel regardless of where it occurs, and adds Commercial vehicle and Heavy Duty Truck and Bus travel on MPO roads.  HPMS reports vehicular travel of all modes on roads within the MPO boundary.

> Additional detail on validation can be found in this [validation document](https://github.com/visioneval/VisionEval/wiki/VE-Validation--UNDER-CONSTRUCTION)

## FROM WIKI, FOLD INTO CHAPTER
====================================THIS IS A DUMP OF UNSHAPED EXCERPTS....TBD
## 5. Inputs -- Pricing [Add table like in ODOT UG, maybe better in best practices?]
Pricing is one of the most effective and market-based policy in reducing vehicle miles travelled, promoting healthy active modes, and reducing energy use and emissions.  In VE the following pricing types combine to make up the travel costs faced by households relative to household budget:
  * **Energy Costs to run vehicles and associated variable use taxes**; This includes fuel and/or electricity costs, gas taxes, mileage (i.e. VMT) taxes, congestion taxes (typically only implemented in the statewide version), carbon taxes, pay-as-you-drive (PAYD) insurance, and parking pricing.
Per Mile Fees (Gas, VMT, Carbon in 2005$)(DEFAULT)
Several per mile fees combine to make up the roadway travel costs faced by households in RSPM.  As discussed above they are typically default values used consistently across the state for each modeled year.  They reside in the costs.csv file, as shown in Table 4 and 5.
    * Fuel & Electricity Costs – Cost for fuel and or electricity to run vehicles.  This is defined as the average cost of gasoline fuels excluding taxes in dollars per gasoline equivalent gallon. 
    * Gas Tax – Taxes on gasoline (in dollars per gallon)
    * VMT Fee– Road user fee collected from all vehicles per mile travelled (in dollars per vehicle mile)

  * **Congestion Charges** – The fee collected to manage congestion, by charging a higher price during congested periods, and thereby reducing demand and freeing capacity for higher value users such a freight movement. Separate price schemes can be set by year to be imposed only during severe or extreme congestion (in 2005 dollars per vehicle mile, where imposed (congestion_charges.csv)
  
  * **Other costs of vehicle ownership and use that the household pays directly**; This includes vehicle depreciation, vehicle maintenance, tires, finance charges, insurance, and registration. These costs primarily affect vehicle ownership, including CarService substitution with indirect impacts on VMT.  
  * **External costs** that are paid for by society as a result of the household's vehicle travel; This includes social and environmental costs that accrue to society but are not typically paid for by vehicle users. These costs include air pollution, climate change, energy security, safety, noise, and other resource impacts(e.g., water pollution). Social costs are calculated on a per VMT, per gallon, or per metric ton of CO2 basis so that they can be added to other taxes for scenarios in which it is assumed that some or all of these external costs will be paid by drivers.
  * **Road system costs**; This includes costs for roadway expansion, other modernization projects, preservation, operations, maintenance and administration. These costs were developed for the STS to compare with total vehicle use taxes (e.g. gas, mileage, congestion) to determine whether sufficient revenues were generated to cover costs.
  * **Parking pricing** is a trip-based cost, commonly paid for at one or both ends of a trip, and sometimes paid for on a monthly basis. The standard practice for handling parking pricing in urban travel demand models is to include it in the trip costs for auto travel. GreenSTEP handles parking pricing in a more general way within a household budget framework, where overall travel costs impact a household’s daily VMT. Two types of parking costs are addressed in the model - parking costs at places of employment and parking costs at other places. Daily parking costs are calculated for each household and added in with other variable costs.  This includes fees for parking at workplace (including cash-out policies) and for non-work trips.
  * **Pay-as-you-drive (PAYD) insurance** is automobile insurance that is paid strictly on a mileage traveled basis, rather than on a lump-sum periodic basis. On average, PAYD insurance does not change the amount that households pay for insurance. However, since the cost of PAYD to the motorist varies with the number of miles driven, there is an incentive to reduce travel to save money. It has been estimated that a PAYD insurance rate of 4 to 6 cents per mile, could reduce VMT from light vehicles by about 3.8%.  In RSPM the estimated effect of PAYD insurance will depend on what other travel costs are being paid as well, influencing the VMT estimated based on travel costs relative to the household budget. RSPM requires input on the proportion of households in the full Metropolitan area buying car insurance using PAYD (payd.csv).  A cost of 5 cents per mile (2005$) of PAYD insurance is used, a default value estimated through literature review and testing (payd.csv),* 

 ## ITS/Operations programs

ITS impact is modeled within RSPM, through speed reductions from basic and enhanced traffic operations, and active management of speed smoothing operational programs. Average speed on roadways in RSPM, is calculated as a function of congestion level and the type and amount of deployment of traffic operations programs. An average speed is associated with each roadway functional class (freeway or arterial) and congestion level. Those speeds are modified depending on the cumulative effect of user-specified deployment of the following traffic operations programs:
  *  Freeway ramp metering - Metering freeways can reduce delay by keeping mainline vehicle density below unstable levels. It creates delay for vehicles entering the freeway, but this is typically more than offset by the higher speeds and postponed congestion on the freeway facility. The Urban Mobility Report cites a delay reduction of 0 to 12%, with an average of 3%, for 25 U.S. urban areas with ramp metering.  Only urban areas with Heavy, Severe, and Extreme freeway congestion can benefit from ramp metering in RSPM
  *  Freeway incident management - Incident Response programs are designed to quickly detect and remove incidents which impede traffic flow. The UMR study  reports incident-related freeway delay reductions of 0 to 40%, with an average of 8%, for the 79 U.S. urban areas with incident response programs. This reflects the combined effects of both service patrols to address the incidents and surveillance cameras to detect the incidents. Effects were seen in all sizes of urban area, though the impacts were greater in larger cities. 
  *  Arterial access management– Access management on arterials can increase speeds by reducing the number of enter/exit points on the arterial and reduce crashes by reducing conflict points. Although improvements such as raised medians can reduce throughput by causing turning queue spillback during heavy congestion, other types of access management, such as reduced business ingress/egress points, show consistent benefits system-wide.
  *  Arterial signal coordination – Traffic signal coordination, particularly for adaptive traffic signals, can reduce arterial delay by increasing throughput in peak flow directions. UMR and other analysis estimates delay reductions of up to 6-9% due to signal coordination, with more potential savings from more sophisticated control systems. An average arterial delay savings was found to be about 1%.
  *  Enhanced ITS/Speed Smoothing programs– Insufficient aggregate performance data is available for a number of other current and future ITS/operations strategies.  These include: speed limit reductions, speed enforcement, and variable speed  limits that reduce the amount of high-speed freeway travel; advanced signal optimization techniques that reduce stops and starts on arterials;  and truck/bus-only lanes that can move high-emitting vehicles through congested areas at improved efficiency.
  *  Other Ops programs – Ability within VE allows flexibility within the model to accommodate future enhancements (other_ops.csv, other_ops_effectiveness.csv).  Further research and significant program investment would be needed to justify benefits in these enhanced ITS programs.

Inputs specifying the level of deployment of several roadway Intelligent Transportation System (ITS) programs, determine the area roadway speeds which influence fuel efficiency.   

## Eco-Driving Practices (autos and trucks)

Eco-driving involves educating motorists on how to drive in order to reduce fuel consumption and cut emissions. Examples of eco-driving practices include avoiding rapid starts and stops, matching driving speeds to synchronized traffic signals, and avoiding idling. Practicing eco-driving also involves keeping vehicles maintained in a way that reduces fuel consumption such as keeping tires properly inflated and reducing aerodynamic drag. In RSPM, fuel economy benefits of improved vehicle maintenance are included in the eco-driving benefit. A default 19% improvement in vehicle fuel economy is assumed 
Vehicle operations and maintenance programs (e.g. eco-driving) based on policy assumptions about the degree of deployment of those programs and the household characteristics.  Vehicle operating programs (eco-driving) reduces emissions per VMT

The fuel economy of all household vehicles of participating households is increased by a factor representing the average fuel economy gains of persons who are trained in eco-driving techniques. 
An RSPM input (speed_smooth_ecodrive.csv) specifies the proportion of light duty vehicle drivers who exhibit eco-driving habits.  The same file makes similar assumptions on the proportion of other (commercial,heavy truck) drivers who are eco-drivers.  

## Transportation Options Programs

In RSPM, each household is assigned as a participant or not in a number of travel demand management programs (e.g. employee commute options program, individualized marketing) based on policy assumptions about the degree of deployment of those programs and the household characteristics.   Individual households are also identified as candidate participants for car sharing programs based on their household characteristics and input assumptions on the market penetration of car sharing vehicles.  

## Workplace TDM Programs

Level of deployment assumptions for TDM (at work and home locations) lead to reduced VMT, diverting travel to other modes.  Car Sharing reduces VMT through changes in auto ownership and per mile costs. 
Employee commute options (ECO) programs are work-based travel demand management programs. They may include transportation coordinators, employer-subsidized transit passes, bicycle parking, showers for bicycle commuters, education and promotion, carpool and vanpool programs, etc. The default assumption is that that ECO programs reduce the average commute DVMT of participating households by 5.4%.  It is assumed that all work travel of the household will be reduced by this percentage if any working age persons are identified as ECO participants
The proportion of employees participating in ECO programs is a policy input at the district level (prop_wrk_eco.csv).  The input assumes workers participate in a strong employee commute options programs (e.g., free transit pass, emergency ride home, bike rider facilities, etc.).  

## Individualized Marketing Program 

Individualized marketing (IM) programs are travel demand management programs focused on individual households in select neighborhoods. IM programs involve individualized outreach to households that identify residents’ travel needs and ways to meet those needs with less vehicle travel. Customized to the neighborhood, IM programs work best in locations where a number of travel options are available. RSM assumes that households participating in an IM program reduce their DVMT by 9% based on studies done in the Portland area. IM programs target work as well as non-work travel and produce larger reductions than ECO work-based programs. Only the IM reduction is used for households that are identified as participating in both ECO and IM programs.

RSPM district-level inputs for IM programs (imp_prop_goal.csv) include an overall assumption for the percentage of households participating in an IM program.  A minimum population density of 4,000 persons per square mile necessary to implement a successful IM program and the requirement that the household reside an urban mixed-use district. The number of households identified as participating is the minimum of the number needed to meet the program goal or the number of qualifying households.

## Vehicle/Fuels Technology Inputs 

Vehicle and Fuel Technology are expected to change significantly during the next 20-50 years as vehicles turn-over and the newer fleets are purchased.  The characteristics of the fleet of new cars and trucks are influenced by federal CAFÉ standards as well as state energy policies and promotions.  Local areas can contribute through decisions about the light-duty fleet used by local transit agencies and by assisting in deployment of electric vehicle charging stations and their costs in work and home locations, but otherwise have less influence on the characteristics of the future vehicle fleet, including auto, light truck, and heavy truck vehicles.   As a consequence, the RSPM inputs on vehicle and fuel technology are largely specified at the state level.  These include inputs that reflect the default assumptions included in the Metropolitan GHG target rules and a more aggressive future as specified in the Oregon Statewide Transportation Strategy.  These will both be available to provide sensitivity test to assess their impact on energy use and GHG emissions in the metropolitan area.

The key local contribution to these inputs is the bus electric/fuels inputs; although defaults can be used if no additional local data is available. These variables are briefly summarized below.

## Vehicle age, fuel economy, and congestion 

Several input files specify vehicle attributes and fuel economy for autos, light trucks, heavy truck, and transit vehicles.  Four vehicle powertrain types are modeled : 

  -  **ICE** - Internal Combustion Engines  having no electrical assist;
  -  **HEV** - Hybrid-Electric Vehicles  where all motive power is generated on-board;
  -  **PHEV** - Plug-in Hybrid Electric Vehicles where some motive power comes from arging an on-board battery from external power supplies;
  -  **EV** - Electric Vehicles where all motive power comes from charging an on-board battery from external power supplies.

Household owned vehicles -- sales mix; %LtTrks & veh age from household and the regional trends for its area.  These combine with sales mix (powertain mix). Each Powertrain in each year has an associated fuel efficiency and power efficiency assumptions for PHEVs (MPG for PHEVs in charge-sustaining mode). For EVs and PHEVs, battery range is specified.  
All other vehicles -- skip sales and jump directly to the mix of vehicles on the road in the modeled year, adjusted by inputs. 

User inputs on vehicle age adjustment factors by vehicle type and year. The purpose of this input is to allow scenarios to be developed which test faster or slower turn-over of the vehicle fleet
Households and commercial fleets operate a mix of passenger autos and light trucks or SUVs.  This mix has an impact on fuel economy.  In RSPM a file contains base year and target values for the proportion of the passenger vehicle fleet that is light trucks for each Metropolitan division (`lttruck_prop.csv`), 

***NOTE***: the actual EV-HEV split depends on whether enough households have their 95Th percentile daily travel within the EV battery range 

## Vehicle Fuel Technology

A second set of inputs specifies the attributes of the fuels and their contributions to GHG emissions (fuel_co2.csv).  This file contains information on lifecycle CO2 equivalent emissions by fuel type in grams per mega joule of fuel energy content. Fuel types are ultra-low sulfur diesel (ULSD), Biodiesel, reformulated gasoline (RFG), CARBOB (California Reformulated Gasoline Blendstock for Oxygenate Blending), Ethanol, compressed natural gas (CNG), LtVehComposite. The latter category is a blend of the carbon values of all of the fuel types relative to the proportions in which they were used in 1990. This allows the model to be more easily run to simulate lower carbon content of fuels without having to specify the relative proportions of each specific fuel type.   The additives in fuel sold that contribute to GHG emissions.  These include the average ethanol proportion in gasoline and biodiesel proportion in diesel (auto_lighttruck_fuel.csv, comm_service_fuel.csv, heavy_truck_fuel.csv). 

Fuel Mix Shares (the remaining share is assumed to be diesel fuel):
  * PropGas – The proportion of bus miles using gasoline
  * PropCng – The proportion of bus miles using compressed natural gas

Biofuel Additives:
  * DieselPropBio – The biodiesel proportion of diesel fuel used
  * GasPropEth – The ethanol proportion of gasoline used

Electric Emissions Rate (Co2e lbs/ kwhr) of electricity consumed

Since electricity generation varies across the state, a local input to the model is the average cost and GHG emission rates of the local area.  The average cost of electricity per kilowatt hour (kWh) in dollars across the metropolitan study area is included in the file costs.csv, while the emissions rate (in average pounds of CO2 equivalents generated per kilowatt hour of electricity consumed by the end user) by district and forecast year is found in a separate input file (power_co2.csv).  Statewide default values for these inputs are available, if no local source is obtained.
