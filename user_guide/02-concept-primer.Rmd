# Concept Primer {#conceptprimer}

VisionEval differs from traditional travel demand models both in how it works and what kind of planning concerns it helps to address. This chapter provides a quick introduction approach to the unique features and applications of VisionEval. It reviews the main model components and key concepts at a high level, to assist new users in understanding concepts they will apply as they set up scenarios, develop inputs and evaluate outputs.  Links to more detailed documentation will allow the reader to delve further into each topic, as they choose.

## What can I do with VisionEval?

Structurally, VisionEval may be described as a "disaggregate demand/aggregate supply" model. That is, it combines rich demographic and socioeconomic detail from a synthetic population with aggregate treatments of travel (multi-modal VMT and congestion without explicit trips, or transport networks). The implication of the "aggregate supply" model is that VisionEval cannot be used to evaluate performance of specific projects or corridors.

What VisionEval can do, and even makes especially simple, is to evaluate large numbers of scenarios and explore how combinations of alternative future conditions might affect performance measures. Travel demand models, whether built using traditional trip-based or more contemporary activity-based techniques, sacrifice flexibility for network detail. It is difficult in such models to capture novel behaviors such as an increased propensity to use inexpensive ride-hailing services, or to express shifts in vehicle ownership and occupancy that may be influenced by multiple factors some of which have not yet been observed. Yet these potential shifts are often very important for assessing the potential of pricing, investment strategies or other policy priorities. VisionEval also makes it relatively simple to explore risks and opportunities that may eventually be realized as new transportation options mature.

VisionEval won't help us determine if a particular highway segment should be built or upgraded, or what kind of transit service improvements should be extended into new areas. But it can help us look at the market for new technologies, and explore future scenarios that are based both on changed circumstances (altered demographics, increased congestion, or alternate road pricing strategies) as well as on changed behaviors (including behaviors that _might_ happen, but that we have not yet observed because the key enabling technologies are too early in their deployment). VisionEval results can be explored in detail by market segment, asking questions about how benefits might be distributed regionally, and what overall system performance might look like.

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

## Lexicon

#### 5D built form measures {#5d}{.unlisted .unnumbered}
The five dimensions considered in designing efficient and sustainable cities include density, design, destination access, distance to transit, and diversity of the built environment. The five dimensions build upon the original 3Ds (density, diversity, and design) advanced by [Cervero & Kockelman (1997)](https://www.sciencedirect.com/science/article/pii/S1361920997000096). These measures are calculated in the `Calculate4DMeasures` module during household synthesis.

access time {#access-time}
: The time required to get from the origin to the vehicle (or in the case of [CarService](#car-service), the time for the vehicle to get to the traveler) and the time to get from the vehicle to the destination (including time to park the vehicle). These values are defined for vehicles owned  by the household and for two levels of CarService (low and high availability levels) in each Bzone. These factors are defined in `azone_vehicle_access_times.csv` and used by the `CalculateVehicleOperatingCost` module in the `VETravelPerformance` package.
: [Additional details](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#97-calculatevehicleoperatingcost-module)

age group {#age-group}
: VisionEval uses the same age groups used in the U.S. Census: 0-14, 15-19, 20-29, 30-54, 55-64, and 65+ years old. The number of persons in each age group are defined for each synthetic household.
: [Additional details](https://github.com/gregorbj/Archive-VisionEval/blob/master/api/model_system_design.md#8111-model-estimation-datasets)

auto operating cost {#auto-operating-cost}
: A combination of out-of-pocket and travel time costs used to estimate the cost per mile of owning and operating an automobile. These costs include fuel (energy), maintenance, tires, and repairs for all households. In addition, pollution or carbon taxes, parking charges, and pay-as-you-drive (PAYD) insurance costs are included where coded for the household's enclosed Bzone. The costs are calculated in the `CalculateHhVehicleOperatingCosts` module of the `VETravelPerformance` package.
: [Additional details](https://github.com/gregorbj/Archive-VisionEval/blob/master/sources/modules/VETravelPerformance/inst/module_docs/CalculateVehicleOperatingCost.md)

auto ownership costs {#auto-ownership-costs}
: The average cost of auto ownership is calculated based upon vehicle type (automobile, light truck) and age using typical cost figures from AAA data. The cost per mile is estimated by dividing the average cost by the household daily VMT estimates produced by the model. A depreciation model is used to adjust this cost based upon the vehicle type, age, and annual miles driven (daily VMT converted into annual miles). The ownership costs represent the full costs of ownership, to include maintenance, tires, depreciation, fuel, insurance, etc.  
: Auto ownership is adjusted when the per-mile cost of owning a car is higher than car service (mobility services) when the latter has high availability. This adjustment is made in the `AdjustVehicleOwnership` module.
: [Additional details on auto ownership](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#66-calculatevehicleowncost) and [auto ownership adjustments](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#67-adjustvehicleownership)

auto sufficiency {#auto-sufficiency}
: Auto sufficiency is achieved when the number of vehicles available to a household is equal to or greater than the number of licensed drivers in a household. A household in "auto insufficient" when that is not true. Zero-auto households are cases where the household has access to a vehicle. In the age of ubiquitous mobility services this definition may become less important in describing mobility options open to the household.

bus-equivalent-miles {#bus-equivalent-miles}
: The total bus revenue miles for a transit system are divided by the assumed transit vehicle type capacities to arrive at bus-equivalent miles of service. 
: The total bus revenue miles for a transit system are divided by the population of the enclosing Marea(s) to compute per capita bus-equivalent miles.
: [Additional details](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#51-assigntransitservice-module)

carbon intensity {#carbon-intensity}
: A emissions measure in grams of carbon dioxide equivalents per megajoule of energy. VisionEval uses a "well-to-wheels" estimate that takes into account not only the emissions resulting from the use of the fuel ("tank-to-wheels" measures) but also the carbon emissions required to produce and transport the fuel it where it is purchased by consumers. Default values are estimated from various sources in VisionEval. The user can specify different values. These values are used in several places in the `VEPowertrainsAndFuels` package.
: [Additional details](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#8-vepowertrainsandfuels-package)

carbon price {#carbon-price}
: A carbon price in dollars per ton is used to estimate part of the [social cost](#social-cost) of emissions in the `CalculateVehicleOperatingCost` module of the `VETravelPerformance` package.
: [Additional details](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#97-calculatevehicleoperatingcost-module)

CarService {#carservice}
: This is a synonym for popular ride-sharing services provided by mobility-as-a-service (MaaS) companies. They are also more commonly referred to as mobility services.

cash-out/buy-back program {#cash-out-buy-back}
: Parking cash-out schemes are an employee benefit that enables them to accept taxable cash income in lieu of paid or subsidized parking at the workplace. The cash-out is sometimes combined with discounted transit passes in some places. It is used as an inducement to reduce commuting by auto, especially in single-occupant vehicles.
: FHWA has an [excellent primer on the topic](https://ops.fhwa.dot.gov/publications/fhwahop12026/sec_4.htm), while many consider Donald Shoup's [online book](http://shoup.bol.ucla.edu/Parking%20Cash%20Out%20Report.pdf) a definitive resource on the topic.

Census PUMS {#census-pums}
: The Public Use Microsample (PUMS) data are anonymized long form responses from the American Community Survey (ACS) that enable custom tabulations, summaries, and visualizations. The PUMS were formerly associated with each dicennial Census of Households and Population. The samples are anonymized by assigning each to a Public Use Microdata Area (PUMA) of 100,000 or more households. Several multi-dimensional summaries used in model estimation are gleaned from the PUMS that cannot be obtained from other Census data. Data indexed along these multiple dimensions permit the PUMS data to be fused with travel survey data and to create synthetic populations.
: ACS PUMS data from 2005-19 in annual increments can be accessed from the [PUMS website](https://www.census.gov/programs-surveys/acs/microdata.html). Data from 1996-2004 can be [accessed separately](https://www2.census.gov/programs-surveys/acs/data/pums/).

commercial service {#commercial-service}
: The use of vehicles by firms and government agencies for non-personal travel other than the delivery of freight. (e.g., parcel delivery, business meetings, sales calls). Both automobiles and light trucks can be used for commercial services, and are defined both in terms of [powertrain](#powertrain) and fuel type (gasoline, diesel, or compressed natural gas).
: [Additional details](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#81-loaddefaultvalues)

congestion fee {#congestion-fee}
: The average amount paid per mile in congestion pricing fee. This is an input to the `CalculateRoadPerformance` module in the `VETravelPerformance` package.
: [Additional details](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#94-calculateroadperformance-module)

congestion level {#congestion-level}
: Five levels of congestion -- none, moderate, heavy, severe, and extreme -- are estimated within each Marea by comparing [relative roadway supply] with the aggregate level of daily VMT (demand). Lookup tables are then used to estimate average speeds and delay for freeways and arterials. The effects of four standard operations programs (freeway ramp metering and incident management, arterial signal progression and access control) and optional user-defined programs are included in the calculations. The calculations are carried out in the `CalculateRoadPerformance` module of the `VETravelPerformance` package.
: [Additional details](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#94-calculateroadperformance-module)

dwelling unit type {#dwelling-unit-type}
: Each household inhabits a dwelling unit that is either a single-family dwelling, a multi-family dwelling, or group quarters.
: [Additional details](https://github.com/gregorbj/Archive-VisionEval/blob/master/api/model_system_design.md#811-model-specification-and-estimation)

EcoDrive {#ecodrive}
: A term used to describe energy efficient use of vehicles in order to reduce fuel consumption and emissions. Primarily a [European pursuit](https://www.ecodrive.org), EcoDriving involves changes to vehicular technology, vehicle navigation and automation systems, and driving techniques. Factors expressing the degree of EcoDriving adoption are applied in the `CalculateMpgMpkwhAdjustments` module of the `VETravelPerformance` package.
: [Additional details](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#96-adjusthhvehiclempgmpkwh-module)

employee commute options program {#employee-commute-options-program}
: A voluntary employer-based program aimed at reducing solo commutes by automobile using strategies and incentive tailored towards each specific organization. Strategies range from providing information and management encouragement to use alternative modes of transportation to cash incentives. Cash-out/buy-in programs are one example of the latter.
: A massDOT [guidebook](https://www.mass.gov/doc/guidebook/download) provides extensive information about such programs. 
: In some states such programs are mandatory for large employers. Information on Oregon's [Employee Commute Options](https://www.oregon.gov/deq/aq/programs/pages/eco.aspx) program includes information about conducting employee surveys to demonstrate progress towards commuting trip reduction targets.

employment type {#employment-type}
: Zonal employment estimates in VisionEval are made for retail, service, and total employment categories. The delineation of retail and service employment is typically by the [two-digit sectors](https://www.census.gov/cgi-bin/sssd/naics/naicsrch?chart=2017) in the [North American Industrial Classification System](https://www.census.gov/eos/www/naics/) (NAICS). The NAICS system is widely used in most governmental reporting systems.  

EV surcharge {#ev-surcharge}
: Some states impose a tax on electric vehicles beyond sales tax and vehicle registration fees to make up for the shortfall in gasoline sales tax revenue they might otherwise contribute towards the costs of roadway infrastructure. The methods and rates [vary considerably](https://www.wsj.com/articles/more-states-charge-fees-for-electric-vehicles-11585400401), with some EV owners paying more in sales tax and EV surcharges than most owners of conventional autos. The EV surcharge can be accounted for in the `CalculateVehicleOperatingCosts` module in the `VETravelPerformance` package.
: [Additional details](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#97-calculatevehicleoperatingcost-module)

freeway lane-miles {#freeway-lane-miles}
: The sum of the number of lanes multiplied by the length of each freeway segment within a metropolitan area (Marea). The lane-miles of arterials are calculated separated (see [roadway lane-miles](#roadway-lane-miles). Both are created in the `AssignRoadMiles` module of the `VETransportSupply` package.
: [Additional details](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#52-assignroadmiles-module)

freight vehicle groups
: _see_ [vehicle groups](#vehicle-groups)

fuel efficiency {#fuel-efficiency}
: VisionEval does not simulate driving cycles so uses measures of relative fuel efficiency derived from the USEPA's Physical Emission Rate Estimator (PERE) for different vehicle [powertrains](#powertrains) during congested conditions. The user-supplied values in `congestion_efficiency.csv` define the congestion performance of each powertrain relative to best (1.0) and worst (0.0) values. The data are used in the `LoadDefaultValues` module in the `VEPowertrainsAndFuels` package.
: [Additional details](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#81-loaddefaultvalues)

fuel-speed curves {#fuel-speed-curves}
: A set of exogenously calculated adjustments to the average fuel economy of vehicles as a function of the vehicle type (light-duty or heavy-duty), [powertrain](#powertrain), and [roadway type](#roadway-types). The curves and their derivation are described by [Bigazzi & Clifton (2011)](https://pdxscholar.library.pdx.edu/cengin_fac/342/).

growth basis {#growth-basis}
: The growth in commercial and heavy truck travel over time increase at the same rate as the population does, as firms and establishments are not explicitly modeled in VisionEval. Future year daily VMT is calculated as a function of population or income from heavy trucks or population, income, or household daily VMT for commercial service.
: [Additional details](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#93-calculateroaddvmt-module)

heavy truck {#heavy-truck}	
: A single class of heavy trucks are used to represent all commercial vehicles larger than the light duty trucks included in the [commercial service](#commercial-service) vehicles. The same vehicle operating and emissions parameters specified for other [vehicle groups](#vehicle-groups) are defined for heavy trucks, and their impacts are calculated in several VisionEval packages.

individualized marketing programs {#individualized-marketing-programs}
: Education and public outreach efforts designed to encourage voluntary travel behavior changes. Rather than using broad messages for the entire population this approaches targets specific groups of travelers with information more relevant to them.
: A [concise fact sheet](https://www.oregon.gov/ODOT/Planning/Documents/Mosaic-Individualized-Marketing-Programs.pdf) describes its implementation in Oregon. [Dill & Mohr (2010)](https://trec.pdx.edu/research/project/160/Long_term_evaluation_of_individualized_marketing_programs_for_travel_demand_management) investigate the long-term effectiveness of such programs.

intelligent transportation systems (ITS) {#intelligent-transportation-systems}
: Systems that integrate information, communications, and advanced vehicular technologies into transportation infrastructure, maintenance, and operations programs to improve mobility and safety. ITS programs are typically centrally controlled by transportation agencies rather than individually autonomous solutions like personal navigation systems. Examples of ITS systems include traveler information systems (e.g., 511 systems, variable message signs), adaptive traffic signal systems, ramp metering, and electronic toll collection.

ITS
: _see_ [intelligent transportation systems](#intelligent-transportation-systems}

lambda parameter {#lambda-parameter}
: The assumed split of light-duty household and [commercial service](#commercial-service) vehicles between freeways and arterials is calculated dynamically as the ratio of the respective average travel speeds and an urbanized area specific factor (lambda). The latter adjusts the raw ratio of speeds to match observed percentages using data from 90 urbanized areas. The calculation is carried out in the `CalculateRoadPerformance` module.
: [Additional details](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#94-calculateroadperformance-module)

lifecycle {#lifecycle}
: A label used to describe the stage of life that a household's members are at. This is guessed at in VisionEval as a function of the number of adults, children, and workers in the household. This is assigned in the `AssignLifeCycle` module. It assumes one of 10 values defined in the [2009 NHTS LIF_CYC variable](https://nhts.ornl.gov/tables09/CodebookPage.aspx?id=1239)
: [Additional details](https://github.com/gregorbj/Archive-VisionEval/blob/master/api/model_system_design.md#811-model-specification-and-estimation)

location type {#location-type}
: Each household is classified by whether its enclosing Bzone is located in an urban, town, or rural area. The `location_type` variable is defined for each Bzone.
: [Additional details](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#15-geographic-structure-of-a-visioneval-model)

metropolitan area {#metropolitan-area}
: In VisionEval a metropolitan area (Marea) is a collection of Azones that define a unique urbanized area with shared characteristics such as freeway lane-miles and transit revenue-miles. In some cases a transit service area might define a metropolitan area rather than political boundaries.
: [Additional details](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#15-geographic-structure-of-a-visioneval-model)

mixed use
: _see_ [urban mixed-use](#urban-mixed-use)

National Household Travel Survey (NHTS) {#national-household-travel-survey}
: The NHTS collects household and traveler information and travel diaries from a random sample of U.S. households. The 2017 survey collected data from 26,000 households selected nationwide and an additional 103,112 additional "add-on" samples purchased by nine states and four regional and metropolitan planning agencies. The information collected is comparable to the data collected in bespoke household travel surveys. The latest year for which NHTS data are available is 2017, with seven prior surveys dating to 1969 conducted before it.
: Publicly available data are available with reduced geographic detail (i.e., households only coded to state and place size ranges) for [2017](https://nhts.ornl.gov/) and [prior years](https://nhts.ornl.gov/download.shtml). VisionEval was developed using the public use NHTS data from 2001, while the Multimodal Travel package was developed using confidential 2009 NHTS data.

NHTS
: _see_ [National Household Travel Survey](#national-household-travel-survey)

Non-institutional group quarters {#non-institutional-group-quarters}
: Persons living in non-institutional group dwellings (e.g., college dormitories, halfway houses). Persons living in institutional group dwellings are not included in VisionEval, and include hospital patients, prison inmates, and military barracks.

out-of-pocket cost {#out-of-pocket-cost}
: The variable costs of automobile usage are considered out-of-pocket costs. They are often considered the perceived cost of using automobiles. In VisionEval they include the cost of fuel and parking or the cost of using [CarService](#car-service). The out-of-pockets are a subset of the [auto operating costs](#auto-operating-costs). 

parking fee {#parking-fee}
: Parking fees are a subset of [parking restrictions](#parking-restrictions). Parking fees can be paid for residential, workplace, or other destinations. 

parking restrictions {#parking-restrictions}
: Parking restrictions and fees affect households at their places of residence and work, as well as other places they travel to within the modeled area. This information is coded at the Bzone level and typically includes the average number of free parking spaces by dwelling unit type (single family, multi-family, and group quarters), the average daily parking cost, and proportion of workers who pay for parking or participate in a cash out-buy back program.
: Parking restrictions are used for Azones that are members of a defined metropolitan area (Marea) within the model.
: [Additional details](https://github.com/gregorbj/Archive-VisionEval/blob/master/sources/modules/VELandUse/inst/module_docs/AssignParkingRestrictions.md)

Pay-as-you-drive (PAYD) {#pay-as-you-drive}
: An insurance program, also known as usage-based insurance, whose premiums are based on actual usage of the insured vehicle as well as how well you drive. It is viewed by some as the emerging standard in insurance. Using a PAYD assumption in VisionEval enables the analyst to more precisely calculate [auto ownership cost](#auto-ownership-cost) based on household daily VMT estimates. The proportion of households using PAYD are included in the calculations carried out by the `CalculateVehicleOwnCost` module.
: [Additional details](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#66-calculatevehicleowncost)

Passenger car equivalents (PCE) {#passenger-car-equivalents}
: A factor that indicates the number of light-duty vehicles that a [heavy truck](#heavy-truck) is equivalent to in terms of vehicle length and lane usage when calculating [roadway capacity](#roadway-capacity). It is used in the `BalanceRoadCostsAndRevenues` module of the `VETravelPerformance` package.
: [Additional details](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#99-balanceroadcostsandrevenues-module)

powertrain {#powertrain}
: VisionEval uses detailed operating and emissions characteristics from several different types of vehicular powertrains, enabling scenarios to be quickly assembled with different assumptions about their mix in future years. Four powertrain types are presently defined in VisionEval: internal combustion engines (ICE), hybrid electric vehicles (HEV), plug-in hybrid electric vehicles (PHEV), and battery electric vehicles (BEV). The powertrain is assigned to each household vehicle in the `AssignHhVehiclePowertrain` module.

regular households {#regular-households}
: Related and unrelated persons living in the same dwelling unit, but not including persons living in non-institutional group quarters

relative roadway supply {#relative-roadway-supply}
: A synthetic measure that divides the total arterial and freeway lane-miles (i.e., the sum of the length in miles times the number of lanes for each distinct roadway segment) by the sum of the estimated trip lengths for all households. This calculation is carried out for each Marea and year. Thus, it is a measure that only applies in metropolitan areas defined in the model. This value is calculated in the `AssignRoadMiles` module and is used in several other modules.
: [Additional details](https://github.com/gregorbj/Archive-VisionEval/blob/master/sources/modules/VETransportSupply/inst/module_docs/AssignRoadMiles.md) 

road class {#road-class}
: The vehicle miles of travel (VMT) calculated for households, [commercial service](#commercial-service), and [heavy trucks](#heavy-trucks) is split between three classes of roadways -- freeways, arterials, and other roadways -- in the `LoadDefaultRoadDvmtValues` module of the `VETravelPerformance` package.
: [Additional details](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#91-loaddefaultroaddvmtvalues)

road costs {#road-costs}
: VisionEval calculates an average mileage tax for household vehicles needed to make up any differences in the cost of constructing, maintaining, and operating roadways from the revenues from fuel taxes and pricing schemes (e.g., VMT taxes, congestion taxes). The latter are calculated based on assumptions about fuel consumption (a function of total daily VMT) and fuel efficiency. While VisionEval adds this to the [auto operating costs](#auto-operating-costs) of households it is important to note that such costs might not be passed on by governments in future years as assumed by VisionEval. The road costs and revenues are reconciled in the `BalanceRoadCostsAndRevenue` module in the `VETravelPerformance` package.
: [Additional details](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#99-balanceroadcostsandrevenues-module)

road lane-miles {#road-lane-miles}
: The sum of the number of lanes multiplied by the length of each arterial roadway segment within a metropolitan area (Marea). The lane-miles of freeways are calculated separated (see [freeway lane-miles](#roadway-lane-miles). Both are created in the `AssignRoadMiles` module of the `VETransportSupply` package.
: [Additional details](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#52-assignroadmiles-module)

road use taxes {#road-use-taxes}
: _see_ [road costs](#road-costs)

short-trip SOV diversion
: The `DivertSovTravel` module reduces travel in single-occupant vehicles (SOVs) to account for assumed availability of solo travel alternatives such as bicycles (traditional and electric) and scooters. The user inputs a goal for diverting a proportion of SOV travel within a 20-mile round-trip distance (i.e., for trips longer than 10 miles in one direction). 
: [Additional details](https://github.com/gregorbj/Archive-VisionEval/blob/master/sources/modules/VEHouseholdTravel/inst/module_docs/DivertSovTravel.md)

social costs {#social-costs}
: Present and future generations bear costs due to the impact of transportation that are not fully recouped through [auto operating costs](#auto operating costs) or [auto ownership costs](#auto-ownership-costs), such as the costs of abating pollution, security and safety costs, and noise. VisionEval includes these costs in their full-cost accounting approach to calculating costs and benefits. The social cost parameters are defined as inputs to the `CalculateVehicleOperatingCost` module in the `VETravelPerformance` package.
: [Additional details](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#97-calculatevehicleoperatingcost-module)

speed smoothing {#speed-smoothing}
: A traffic management action or design that reduces the speed variation on freeways and arterials. 
: Note that the introduction of autonomous vehicles will likely achieve this effect even when they only constitute a quarter or more of all vehicles on the roadway ([Levin & Boyles 2015](https://doi.org/10.3141/2493-04), [Mahmassani 2016](https://doi.org/10.1287/trsc.2016.0712)). Thus, speed smoothing might become an important property of future traffic systems that analysts should include in future years even in spite of current local interest in such programs.
: [Additional details](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#95-calculatempgmpkwhadjustments-module)

transit modes {#transit-modes}
: VisionEval includes eight transit modes, which are also called transit service modes in some places in the documentation. The eight modes include demand-responsive (DR), vanpool and similar (VP), standard motor bus (MB), bus rapid transit and commuter bus (RB), monorail or other automated guideway (MG), streetcar or trolley bus (SR), light or heavy rail (HR), and commuter rail (CR) services. The latter includes specialized CR services such as hybrid rail, cable cars, and aerial tramways.
: [Additional details](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#51-assigntransitservice-module)

transit service level {#transit-service-levels}
: User-supplied annual revenue miles of service for each of the eight [transit modes](#transit-modes) are translated into bus-equivalents, revenue miles, and ultimately, vehicle miles. The transit service levels are set in the `AssignTransitService` module in the `VETransportSupply` package.
: [Additional details](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#51-assigntransitservice-module)

transit service miles {#transit-service-miles}
: [Bus-equivalent-miles](#bus-equivalent-miles) used to compute [transit service levels](#transit-service-levels) are summed to calculate transit miles by each [transit mode](#transit-modes). The calculations are carried out in the `AssignTransitService` module in the `VETransportSupply` package.
: [Additional details](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#51-assigntransitservice-module)

transit vehicle type {#transit-vehicle-type}
: Different energy consumption and emissions characteristics are defined for vans, buses, and rail transit modes. 
: [Additional details](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#911-calculateptranenergyandemissions-module)

travel demand management (TDM) {#travel-demand-management}
: Policies and programs used to discourage travel in single-occupant vehicles in order to achieve safer and more efficient multimodal transportation systems. TDM encompasses a wide variety of initiatives, to include promotion of active transport, public transportation modes, car and bike sharing, and telecommuting. Adjustments in household VMT due to TDM actions are coded in the `BudgetHouseholdDvmt` module in the `VETravelPerformance` package.
: [Additional details](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#98-budgethouseholddvmt-module)

urban mixed-use {#urban-mixed-use}
: A mixed use development or neighborhood is one that includes residential and non-residential land uses in close proximity to one another, allowing for pedestrian access to many desired goods and services. Such places are walkable,"bikeable," and encourage a local economy and strong social connections. From a transportation perspective such places are distinguished by their high degree of accessibility using non-motorized modes (active transport).
: In VisionEval the proportion of each Bzone that falls into this category can either be specified by the user or calculated by the program. If the latter a random sampling from an asserted distribution is used to define whether a household is in a mixed-use area. The density of the enclosing Bzone weights the probability of a household being so classified (i.e., the higher the density the higher probability of being assigned to a mixed-use neighborhood). These calculations are carried on in the `CalculateUrbanMixMeasure` module of the `VEHouseholds` package.
: [Additional details](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#45-calculateurbanmixmeasure-module)

value of time (VOT) {#value-of-time}
: The opportunity cost of the time that a person spends traveling rather than engaged in other activities. In theory it represents what the traveler would be willing to pay in order to reduce their time traveling. It is a surrogate for the value of travel times savings, which attempts to place a monetary value on the benefits of more efficient travel. While often an important parameter along with the equally influential value of reliability in pricing studies ([Kockelman et al. 2013](https://www.caee.utexas.edu/prof/kockelman/TransportationEconomics_Website/TranspEconReference.pdf), [Parsons Brinckerhoff et al. 2013](http://onlinepubs.trb.org/onlinepubs/shrp2/SHRP2prepubC04.pdf)) VOT is an average value in VisionEval. It is used in `TimeCost` calculations in the `CalculateVehicleOperatingCost` module. 
: [Additional details](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#97-calculatevehicleoperatingcost-module)

vehicle age {#vehicle-age}
: The age of each household vehicle is estimated as a function of vehicle type (auto or light truck), household income, and the assumed average vehicle age coded for each vehicle type and Azone. The vehicle age is assigned in the `AssignVehicleAge` module in the `VEHouseholdVehicles` package.
: [Additional details](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#65-assignvehicleage)

vehicle groups {#vehicle-groups}
: Different groups of vehicles are used in VisionEval by different types of users. Automobiles and light trucks are used by households, car service, and commercial service, and are assigned in the `VEHouseholdVehicles` package. Heavy trucks are treated separately, and three types of vehicles -- vans, buses, and rail -- are used for transit.
: [Additional details](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#83-calculatecarbonintensity-module)

vehicle hours of delay (VHD) {#vehicle-hours-of-delay}
: An aggregate performance measure usually calculated by subtracting vehicle hours of travel under uncontested conditions from total vehicle hours of travel (VHT). Both measures are approximated for each [metropolitan area](#metropolitan-area) in VisionEval in the `CalculateRoadPerformance` module of the `VETravelPerformance` package.
: [Additional details](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#94-calculateroadperformance-module) 

vehicle operating costs {#vehicle-operating-costs}
: _see_ [auto operating costs](#auto-operating-costs)

vehicle ownership costs {#vehicle-ownership-costs}
: _see_ [auto ownership costs](#auto-ownership-costs)

vehicle table {#vehicle-table}
: A vehicle table is a list of every vehicle owned by a household in VisionEval. It includes the vehicle characteristics, household ID, and the Azone and Marea the household is allocated to. It is created in the `CreateVehicleTable` module in the `VEHouseholdVehicles` package.
: [Additional details](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#64-createvehicletable)

vehicle type {#vehicle-type}
: _see_ [vehicle groups](#vehicle-groups)

## CONTENT FROM WIKI TO INTEGRATE INTO CHAPTER
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

## Definitions

<!-- Unnumbered sectionshttps://bookdown.org/yihui/rmarkdown-cookbook/unnumbered-sections.html -->

5D built form measures
: The five dimensions considered in designing efficient and sustainable cities include density, design, destination access, distance to transit, and diversity of the built environment. The five dimensions build upon the original 3Ds (density, diversity, and design) advanced by [Cervero & Kockelman (1997)](https://www.sciencedirect.com/science/article/pii/S1361920997000096). These measures are calculated in the `Calculate4DMeasures` module during household synthesis.


access time
: The time required to get from the origin to the vehicle (or in the case of [CarService](#car-service), the time for the vehicle to get to the traveler) and the time to get from the vehicle to the destination (including time to park the vehicle). These values are defined for vehicles owned  by the household and for two levels of CarService (low and high availability levels) in each Bzone. These factors are defined in `azone_vehicle_access_times.csv` and used by the `CalculateVehicleOperatingCost` module in the `VETravelPerformance` package.
[Additional details](https://github.com/visioneval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#97-calculatevehicleoperatingcost-module)

age group
: VisionEval uses the same age groups used in the U.S. Census0-14, 15-19, 20-29, 30-54, 55-64, and 65+ years old. The number of persons in each age group are defined for each synthetic household.
[Additional details](https://github.com/visioneval/VisionEval/blob/master/api/model_system_design.md#8111-model-estimation-datasets)

auto operating cost
: The out-of-pocket costs used to estimate the cost per mile of operating an automobile. These costs include fuel (energy), maintenance, tires, and repairs for all households. In addition, pollution or carbon taxes, parking charges, pay-as-you-drive (PAYD) insurance costs, and road use cost or VMT taxes are included where coded for the household's enclosed Bzone. For car service use, the operating cost is the assumed fare per mile. The costs are calculated in the `CalculateHhVehicleOperatingCosts` module of the `VETravelPerformance` package.
: [Additional details](https://github.com/visioneval/VisionEval/blob/master/sources/modules/VETravelPerformance/inst/module_docs/CalculateVehicleOperatingCost.md)

auto ownership costs
: The average cost of auto ownership is calculated based upon vehicle type (automobile, light truck) and age using typical cost figures from AAA data. The cost per mile is estimated by dividing the average cost by the household daily VMT estimates produced by the model. A depreciation model is used to adjust this cost based upon the vehicle type, age, and annual miles driven (daily VMT converted into annual miles). The ownership costs represent the full costs of ownership, to include depreciation, financing, insurance, etc. They also include any residential parking cost the household may have.  
: Auto ownership is adjusted when the per-mile cost of owning a car is higher than car service (mobility services) when the latter has high availability. This adjustment is made in the `AdjustVehicleOwnership` module.
: [Additional details on auto ownership](https://github.com/visioneval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#66-calculatevehicleowncost) and [auto ownership adjustments](https://github.com/visioneval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#67-adjustvehicleownership)

auto sufficiency
Auto sufficiency is achieved when the number of vehicles available to a household is equal to or greater than the number of licensed drivers in a household. A household in "auto insufficient" when that is not true. Zero-auto households are cases where the household has access to a vehicle. In the age of ubiquitous mobility services this definition may become less important in describing mobility options open to the household.

bus-equivalent-miles
The total bus revenue miles for a transit system are divided by the assumed transit vehicle type capacities to arrive at bus-equivalent miles of service. 
The total bus revenue miles for a transit system are divided by the population of the enclosing Marea(s) to compute per capita bus-equivalent miles.
[Additional details](https://github.com/visioneval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#51-assigntransitservice-module)

carbon intensity
A emissions measure in grams of carbon dioxide equivalents per megajoule of energy. VisionEval uses a "well-to-wheels" estimate that takes into account not only the emissions resulting from the use of the fuel ("tank-to-wheels" measures) but also the carbon emissions required to produce and transport the fuel it where it is purchased by consumers. Default values are estimated from various sources in VisionEval. The user can specify different values. These values are used in several places in the `VEPowertrainsAndFuels` package.
[Additional details](https://github.com/visioneval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#8-vepowertrainsandfuels-package)

carbon price
A carbon price in dollars per ton is used to estimate part of the <span style="color:green">social cost</span> of emissions in the `CalculateVehicleOperatingCost` module of the `VETravelPerformance` package.
[Additional details](https://github.com/visioneval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#97-calculatevehicleoperatingcost-module)

CarService
This is a synonym for popular ride-sharing services provided by mobility-as-a-service (MaaS) companies. They are also more commonly referred to as mobility services.

cash-out/buy-back program
Parking cash-out schemes are an employee benefit that enables them to accept taxable cash income in lieu of paid or subsidized parking at the workplace. The cash-out is sometimes combined with discounted transit passes in some places. It is used as an inducement to reduce commuting by auto, especially in single-occupant vehicles.
FHWA has an [excellent primer on the topic](https://ops.fhwa.dot.gov/publications/fhwahop12026/sec_4.htm), while many consider Donald Shoup's [online book](http://shoup.bol.ucla.edu/Parking%20Cash%20Out%20Report.pdf) a definitive resource on the topic.

Census PUMS
The Public Use Microsample (PUMS) data are anonymized long form responses from the American Community Survey (ACS) that enable custom tabulations, summaries, and visualizations. The PUMS were formerly associated with each dicennial Census of Households and Population. The samples are anonymized by assigning each to a Public Use Microdata Area (PUMA) of 100,000 or more households. Several multi-dimensional summaries used in model estimation are gleaned from the PUMS that cannot be obtained from other Census data. Data indexed along these multiple dimensions permit the PUMS data to be fused with travel survey data and to create synthetic populations.
ACS PUMS data from 2005-19 in annual increments can be accessed from the [PUMS website](https://www.census.gov/programs-surveys/acs/microdata.html). Data from 1996-2004 can be [accessed separately](https://www2.census.gov/programs-surveys/acs/data/pums/).

commercial service
The use of vehicles by firms and government agencies for non-personal travel other than the delivery of freight. (e.g., parcel delivery, business meetings, sales calls). Both automobiles and light trucks can be used for commercial services, and are defined both in terms of <span style="color:green">powertrain</span> and fuel type (gasoline, diesel, or compressed natural gas).
[Additional details](https://github.com/visioneval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#81-loaddefaultvalues)

congestion fee
The average amount paid per mile in congestion pricing fee. This is an input to the `CalculateRoadPerformance` module in the `VETravelPerformance` package.
[Additional details](https://github.com/visioneval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#94-calculateroadperformance-module)

congestion level
Five levels of congestion -- none, moderate, heavy, severe, and extreme -- are estimated within each Marea by comparing [relative roadway supply] with the aggregate level of daily VMT (demand). Lookup tables are then used to estimate average speeds and delay for freeways and arterials. The effects of four standard operations programs (freeway ramp metering and incident management, arterial signal progression and access control) and optional user-defined programs are included in the calculations. The calculations are carried out in the `CalculateRoadPerformance` module of the `VETravelPerformance` package.
[Additional details](https://github.com/visioneval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#94-calculateroadperformance-module)

dwelling unit type
Each household inhabits a dwelling unit that is either a single-family dwelling, a multi-family dwelling, or group quarters.
[Additional details](https://github.com/visioneval/VisionEval/blob/master/api/model_system_design.md#811-model-specification-and-estimation)

EcoDrive
A term used to describe energy efficient use of vehicles in order to reduce fuel consumption and emissions. Primarily a [European pursuit](https://www.ecodrive.org), EcoDriving involves changes to vehicular technology, vehicle navigation and automation systems, and driving techniques. Factors expressing the degree of EcoDriving adoption are applied in the `CalculateMpgMpkwhAdjustments` module of the `VETravelPerformance` package.
[Additional details](https://github.com/visioneval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#96-adjusthhvehiclempgmpkwh-module)

employee commute options program
A voluntary employer-based program aimed at reducing solo commutes by automobile using strategies and incentive tailored towards each specific organization. Strategies range from providing information and management encouragement to use alternative modes of transportation to cash incentives. Cash-out/buy-in programs are one example of the latter.
A massDOT [guidebook](https://www.mass.gov/doc/guidebook/download) provides extensive information about such programs. 
In some states such programs are mandatory for large employers. Information on Oregon's [Employee Commute Options](https://www.oregon.gov/deq/aq/programs/pages/eco.aspx) program includes information about conducting employee surveys to demonstrate progress towards commuting trip reduction targets.

employment type
Zonal employment estimates in VisionEval are made for retail, service, and total employment categories. The delineation of retail and service employment is typically by the [two-digit sectors](https://www.census.gov/cgi-bin/sssd/naics/naicsrch?chart=2017) in the [North American Industrial Classification System](https://www.census.gov/eos/www/naics/) (NAICS). The NAICS system is widely used in most governmental reporting systems.  

EV surcharge
Some states impose a tax on electric vehicles beyond sales tax and vehicle registration fees to make up for the shortfall in gasoline sales tax revenue they might otherwise contribute towards the costs of roadway infrastructure. The methods and rates [vary considerably](https://www.wsj.com/articles/more-states-charge-fees-for-electric-vehicles-11585400401), with some EV owners paying more in sales tax and EV surcharges than most owners of conventional autos. The EV surcharge can be accounted for in the `CalculateVehicleOperatingCosts` module in the `VETravelPerformance` package.
[Additional details](https://github.com/visioneval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#97-calculatevehicleoperatingcost-module)

freeway lane-miles
The sum of the number of lanes multiplied by the length of each freeway segment within a metropolitan area (Marea). The lane-miles of arterials are calculated separated (see <span style="color:green">roadway lane-miles</span>). Both are created in the `AssignRoadMiles` module of the `VETransportSupply` package.
[Additional details](https://github.com/visioneval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#52-assignroadmiles-module)

freight vehicle groups
_see_ vehicle groups

fuel efficiency
VisionEval does not simulate driving cycles so uses measures of relative fuel efficiency derived from the USEPA's Physical Emission Rate Estimator (PERE) for different vehicle <span style="color:green">powertrains</span> during congested conditions. The user-supplied values in `congestion_efficiency.csv` define the congestion performance of each powertrain relative to best (1.0) and worst (0.0) values. The data are used in the `LoadDefaultValues` module in the `VEPowertrainsAndFuels` package.
[Additional details](https://github.com/visioneval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#81-loaddefaultvalues)

fuel-speed curves
A set of exogenously calculated adjustments to the average fuel economy of vehicles as a function of the vehicle type (light-duty or heavy-duty), <span style="color:green">powertrain</span>, and <span style="color:green">roadway type</span>. The curves and their derivation are described by [Bigazzi & Clifton (2011)](https://pdxscholar.library.pdx.edu/cengin_fac/342/).

growth basis
The growth in commercial and heavy truck travel over time increase at the same rate as the population does, as firms and establishments are not explicitly modeled in VisionEval. Future year daily VMT is calculated as a function of population or income from heavy trucks or population, income, or household daily VMT for commercial service.
[Additional details](https://github.com/visioneval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#93-calculateroaddvmt-module)

heavy truck
A single class of heavy trucks are used to represent all commercial vehicles larger than the light duty trucks included in the <span style="color:green">commercial service</span> vehicles. The same vehicle operating and emissions parameters specified for other <span style="color:green">vehicle groups</span> are defined for heavy trucks, and their impacts are calculated in several VisionEval packages.

individualized marketing programs
Education and public outreach efforts designed to encourage voluntary travel behavior changes. Rather than using broad messages for the entire population this approaches targets specific groups of travelers with information more relevant to them.
A [concise fact sheet](https://www.oregon.gov/ODOT/Planning/Documents/Mosaic-Individualized-Marketing-Programs.pdf) describes its implementation in Oregon. [Dill & Mohr (2010)](https://trec.pdx.edu/research/project/160/Long_term_evaluation_of_individualized_marketing_programs_for_travel_demand_management) investigate the long-term effectiveness of such programs.

intelligent transportation systems (ITS)
Systems that integrate information, communications, and advanced vehicular technologies into transportation infrastructure, maintenance, and operations programs to improve mobility and safety. ITS programs are typically centrally controlled by transportation agencies rather than individually autonomous solutions like personal navigation systems. Examples of ITS systems include traveler information systems (e.g., 511 systems, variable message signs), adaptive traffic signal systems, ramp metering, and electronic toll collection.

ITS
_see_ intelligent transportation systems

lambda parameter
The assumed split of light-duty household and <span style="color:green">commercial service</span> vehicles between freeways and arterials is calculated dynamically as the ratio of the respective average travel speeds and an urbanized area specific factor (lambda). The latter adjusts the raw ratio of speeds to match observed percentages using data from 90 urbanized areas. The calculation is carried out in the `CalculateRoadPerformance` module.
[Additional details](https://github.com/visioneval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#94-calculateroadperformance-module)

lifecycle
A label used to describe the stage of life that a household's members are at. This is guessed at in VisionEval as a function of the number of adults, children, and workers in the household. This is assigned in the `AssignLifeCycle` module. It assumes one of 10 values defined in the [2009 NHTS LIF_CYC variable](https://nhts.ornl.gov/tables09/CodebookPage.aspx?id=1239)
[Additional details](https://github.com/visioneval/VisionEval/blob/master/api/model_system_design.md#811-model-specification-and-estimation)

location type
Each household is classified by whether its enclosing Bzone is located in an urban, town, or rural area. The `location_type` variable is defined for each Bzone.
[Additional details](https://github.com/visioneval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#15-geographic-structure-of-a-visioneval-model)

metropolitan area (Marea) 
A select set of Azones that are used in VisionEval to define a common metropolitan area (Marea). Separate VisionEval functions are often applied for metropolitan areas, making use of information on road, transit, and urban mixed used variables only present in the urbanized portion of the metropolitan area. Metropolitan areas in VisionEval are typically equivalent to Census urbanized areas.
[Additional details](https://github.com/visioneval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#15-geographic-structure-of-a-visioneval-model)

mixed use
_see_ urban mixed-use

National Household Travel Survey (NHTS)
The NHTS collects household and traveler information and travel diaries from a random sample of U.S. households. The 2017 survey collected data from 26,000 households selected nationwide and an additional 103,112 additional "add-on" samples purchased by nine states and four regional and metropolitan planning agencies. The information collected is comparable to the data collected in bespoke household travel surveys. The latest year for which NHTS data are available is 2017, with seven prior surveys dating to 1969 conducted before it.
Publicly available data are available with reduced geographic detail (i.e., households only coded to state and place size ranges) for [2017](https://nhts.ornl.gov/) and [prior years](https://nhts.ornl.gov/download.shtml). VisionEval was developed using the public use NHTS data from 2001, while the Multimodal Travel package was developed using confidential 2009 NHTS data.

NHTS
_see_ National Household Travel Survey

Non-institutional group quarters
Persons living in non-institutional group dwellings (e.g., college dormitories, halfway houses). Persons living in institutional group dwellings are not included in VisionEval, and include hospital patients, prison inmates, and military barracks.

out-of-pocket cost
The variable costs of automobile usage are considered out-of-pocket costs. They are often considered the perceived cost of using automobiles. In VisionEval they include the cost of fuel and parking or the cost of using <span style="color:green">CarService</span>. The out-of-pockets are a subset of the <span style="color:green">auto operating costs</span>. 

parking fee
Parking fees are a subset of <span style="color:green">parking restrictions</span>. Parking fees can be paid for residential, workplace, or other destinations. 

parking restrictions
Parking restrictions and fees affect households at their places of residence and work, as well as other places they travel to within the modeled area. This information is coded at the Bzone level and typically includes the average number of free parking spaces by dwelling unit type (single family, multi-family, and group quarters), the average daily parking cost, and proportion of workers who pay for parking or participate in a cash out-buy back program.
Parking restrictions are used for Azones that are members of a defined metropolitan area (Marea) within the model.
[Additional details](https://github.com/visioneval/VisionEval/blob/master/sources/modules/VELandUse/inst/module_docs/AssignParkingRestrictions.md)

Pay-as-you-drive (PAYD)
An insurance program, also known as usage-based insurance, whose premiums are based on actual usage of the insured vehicle as well as how well you drive. It is viewed by some as the emerging standard in insurance. Using a PAYD assumption in VisionEval enables the analyst to more precisely calculate [auto ownership cost](#auto-ownership-cost) based on household daily VMT estimates. The proportion of households using PAYD are included in the calculations carried out by the `CalculateVehicleOwnCost` module.
[Additional details](https://github.com/visioneval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#66-calculatevehicleowncost)

Passenger car equivalents (PCE)
A factor that indicates the number of light-duty vehicles that a <span style="color:green">heavy truck</span> is equivalent to in terms of vehicle length and lane usage when calculating <span style="color:green">roadway capacity</span>. It is used in the `BalanceRoadCostsAndRevenues` module of the `VETravelPerformance` package.
[Additional details](https://github.com/visioneval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#99-balanceroadcostsandrevenues-module)

powertrain
VisionEval uses detailed operating and emissions characteristics from several different types of vehicular powertrains, enabling scenarios to be quickly assembled with different assumptions about their mix in future years. Four powertrain types are presently defined in VisionEvalinternal combustion engines (ICE), hybrid electric vehicles (HEV), plug-in hybrid electric vehicles (PHEV), and battery electric vehicles (BEV). The powertrain is assigned to each household vehicle in the `AssignHhVehiclePowertrain` module.

regular households
Related and unrelated persons living in the same dwelling unit, but not including persons living in non-institutional group quarters

relative roadway supply
A synthetic measure that divides the total arterial and freeway lane-miles (i.e., the sum of the length in miles times the number of lanes for each distinct roadway segment) by the sum of the estimated trip lengths for all households. This calculation is carried out for each Marea and year. Thus, it is a measure that only applies in metropolitan areas defined in the model. This value is calculated in the `AssignRoadMiles` module and is used in several other modules.
[Additional details](https://github.com/visioneval/VisionEval/blob/master/sources/modules/VETransportSupply/inst/module_docs/AssignRoadMiles.md) 

road class
The vehicle miles of travel (VMT) calculated for households, <span style="color:green">commercial service</span>, and <span style="color:green">heavy trucks</span> is split between three classes of roadways -- freeways, arterials, and other roadways -- in the `LoadDefaultRoadDvmtValues` module of the `VETravelPerformance` package.
[Additional details](https://github.com/visioneval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#91-loaddefaultroaddvmtvalues)

road costs
VisionEval calculates an average mileage tax for household vehicles needed to make up any differences in the cost of constructing, maintaining, and operating roadways from the revenues from fuel taxes and pricing schemes (e.g., VMT taxes, congestion taxes). The latter are calculated based on assumptions about fuel consumption (a function of total daily VMT) and fuel efficiency, although this information can be both an input (default) and optional calculation with user-supplied data. While VisionEval adds this to the <span style="color:green">auto operating costs</span> of households it is important to note that such costs might not be passed on by governments in future years as assumed by VisionEval. The road costs and revenues are reconciled in the `BalanceRoadCostsAndRevenue` module in the `VETravelPerformance` package.
[Additional details](https://github.com/visioneval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#99-balanceroadcostsandrevenues-module)

road lane-miles
The sum of the number of lanes multiplied by the length of each arterial roadway segment within a metropolitan area (Marea). The lane-miles of freeways are calculated separated (see <span style="color:green">freeway lane-miles</span>. Both are created in the `AssignRoadMiles` module of the `VETransportSupply` package.
[Additional details](https://github.com/visioneval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#52-assignroadmiles-module)

road use taxes
_see_ road costs

short-trip SOV diversion
The `DivertSovTravel` module reduces travel in single-occupant vehicles (SOVs) to account for assumed availability of solo travel alternatives such as bicycles (traditional and electric) and scooters. The user inputs a goal for diverting a proportion of SOV travel within a 20-mile round-trip distance (i.e., for trips longer than 10 miles in one direction). 
[Additional details](https://github.com/visioneval/VisionEval/blob/master/sources/modules/VEHouseholdTravel/inst/module_docs/DivertSovTravel.md)

social costs
Present and future generations bear costs due to the impact of transportation that are not fully recouped through <span style="color:green">auto operating costs</span> or <span style="color:green">auto ownership costs</span>, such as the costs of abating pollution, security and safety costs, and noise. VisionEval includes these costs in their full-cost accounting approach to calculating costs and benefits. The social cost parameters are defined as inputs to the `CalculateVehicleOperatingCost` module in the `VETravelPerformance` package.
[Additional details](https://github.com/visioneval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#97-calculatevehicleoperatingcost-module)

speed smoothing
A traffic management action or design that reduces the speed variation on freeways and arterials. 
Note that the introduction of autonomous vehicles will likely achieve this effect even when they only constitute a quarter or more of all vehicles on the roadway ([Levin & Boyles 2015](https://doi.org/10.3141/2493-04), [Mahmassani 2016](https://doi.org/10.1287/trsc.2016.0712)). Thus, speed smoothing might become an important property of future traffic systems that analysts should include in future years even in spite of current local interest in such programs.
[Additional details](https://github.com/visioneval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#95-calculatempgmpkwhadjustments-module)

transit modes
VisionEval includes eight transit modes, which are also called transit service modes in some places in the documentation. The eight modes include demand-responsive (DR), vanpool and similar (VP), standard motor bus (MB), bus rapid transit and commuter bus (RB), monorail or other automated guideway (MG), streetcar or trolley bus (SR), light or heavy rail (HR), and commuter rail (CR) services. The latter includes specialized CR services such as hybrid rail, cable cars, and aerial tramways.
[Additional details](https://github.com/visioneval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#51-assigntransitservice-module)

transit service level
User-supplied annual revenue miles of service for each of the eight <span style="color:green">transit modes</span> are translated into bus-equivalents, revenue miles, and ultimately, vehicle miles. The transit service levels are set in the `AssignTransitService` module in the `VETransportSupply` package.
[Additional details](https://github.com/visioneval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#51-assigntransitservice-module)

transit service miles
<span style="color:green">Bus-equivalent-miles</span> used to compute <span style="color:green">transit service levels</span> are summed to calculate transit miles by each <span style="color:green">transit mode</span>. The calculations are carried out in the `AssignTransitService` module in the `VETransportSupply` package.
[Additional details](https://github.com/visioneval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#51-assigntransitservice-module)

transit vehicle type
Different energy consumption and emissions characteristics are defined for vans, buses, and rail transit modes. 
[Additional details](https://github.com/visioneval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#911-calculateptranenergyandemissions-module)

travel demand management (TDM)
Policies and programs used to discourage travel in single-occupant vehicles in order to achieve safer and more efficient multimodal transportation systems. TDM encompasses a wide variety of initiatives, to include promotion of active transport, public transportation modes, car and bike sharing, and telecommuting. Adjustments in household VMT due to TDM actions are coded in the `BudgetHouseholdDvmt` module in the `VETravelPerformance` package.
[Additional details](https://github.com/visioneval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#98-budgethouseholddvmt-module)

urban mixed-use
A mixed use development or neighborhood is one that includes residential and non-residential land uses in close proximity to one another, allowing for pedestrian access to many desired goods and services. Such places are walkable,"bikeable," and encourage a local economy and strong social connections. From a transportation perspective such places are distinguished by their high degree of accessibility using non-motorized modes (active transport).
In VisionEval the proportion of each Bzone that falls into this category can either be specified by the user or calculated by the program. If the latter a random sampling from an asserted distribution is used to define whether a household is in a mixed-use area. The density of the enclosing Bzone weights the probability of a household being so classified (i.e., the higher the density the higher probability of being assigned to a mixed-use neighborhood). These calculations are carried on in the `CalculateUrbanMixMeasure` module of the `VEHouseholds` package.
[Additional details](https://github.com/visioneval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#45-calculateurbanmixmeasure-module)

urbanized area
Collectively the "urban" <span style="color:green">location type</span> portion of the <span style="color:green">metropolitan area</span> (Marea) set of zones. The road, transit and <span style="color:green">urban mixed use</span> variables only cover this portion of the Marea, which is typically equivalent to a Census urbanized area. 

value of time (VOT)
The opportunity cost of the time that a person spends traveling rather than engaged in other activities. In theory it represents what the traveler would be willing to pay in order to reduce their time traveling. It is a surrogate for the value of travel times savings, which attempts to place a monetary value on the benefits of more efficient travel. While often an important parameter along with the equally influential value of reliability in pricing studies ([Kockelman et al. 2013](https://www.caee.utexas.edu/prof/kockelman/TransportationEconomics_Website/TranspEconReference.pdf), [Parsons Brinckerhoff et al. 2013](http://onlinepubs.trb.org/onlinepubs/shrp2/SHRP2prepubC04.pdf)) VOT is an average value in VisionEval. It is used in `TimeCost` calculations in the `CalculateVehicleOperatingCost` module. 
[Additional details](https://github.com/visioneval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#97-calculatevehicleoperatingcost-module)

vehicle age
The age of each household vehicle is estimated as a function of vehicle type (auto or light truck), household income, and the assumed average vehicle age coded for each vehicle type and Azone. The vehicle age is assigned in the `AssignVehicleAge` module in the `VEHouseholdVehicles` package.
[Additional details](https://github.com/visioneval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#65-assignvehicleage)

vehicle groups
Different groups of vehicles are used in VisionEval by different types of users. Automobiles and light trucks are used by households, car service, and commercial service, and are assigned in the `VEHouseholdVehicles` package. Heavy trucks are treated separately, and three types of vehicles -- vans, buses, and rail -- are used for transit.
[Additional details](https://github.com/visioneval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#83-calculatecarbonintensity-module)

vehicle hours of delay (VHD)
An aggregate performance measure usually calculated by subtracting vehicle hours of travel under uncontested conditions from total vehicle hours of travel (VHT). Both measures are approximated for each <span style="color:green">metropolitan area</span> in VisionEval in the `CalculateRoadPerformance` module of the `VETravelPerformance` package.
[Additional details](https://github.com/visioneval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#94-calculateroadperformance-module) 

vehicle operating costs
_see_ auto operating costs

vehicle ownership costs
_see_ auto ownership costs

vehicle table
A vehicle table is a list of every vehicle owned by a household in VisionEval. It includes the vehicle characteristics, household ID, and the Azone and Marea the household is allocated to. It is created in the `CreateVehicleTable` module in the `VEHouseholdVehicles` package.
[Additional details](https://github.com/visioneval/VisionEval/blob/master/api/VE_Training_March_13-14_2019/VE_Training.md#64-createvehicletable)

vehicle type
_see_ vehicle groups

## WIKI DEFINITIONS (TO ADD)

FUTURE:  Add links to example input .csv files, such as this for [azone_hh_pop_by_age.csv](https://github.com/VisionEval/VisionEval/blob/master/sources/models/VERSPM/Test1/inputs/azone_hh_pop_by_age.csv)

### VisionEval Inputs
This page summarizes VisionEval definitions by Concept, Explaining basic terminology used in VisionEval.  Terms may apply to multiple concepts, so searching the page may if you can't find it where you expect. 

This page organizes VisionEval Definitions by the following VE Concepts:
 * [Household Synthesis & Land Use](#1)
 * [Household Multi-modal Travel](#2)
 * [Vehicles, Fuels & Emissions](#3)
 * [Congestion](#4)
 * [Household Costs & Budgets](#5)* 

Other useful information:  A conceptual discussion of VisionEval is [here](). 

### VisionEval Geography
==Something like slide 11 of [VE Training Slides](https://github.com/VisionEval/VisionEval/wiki/VERSPM-Training/VE-RSPM_Training_Draft_Slides_3-15-19.pdf). Or Inputs by geo doc pictures of region-azone-bzones..

* **Region**: The model area such as metropolitan planning area or state
* **Azone**: Large-scale zones such as cities, counties, or PUMAs; geography of most inputs.
* **Bzone**: Subdivisions of Azones representing neighborhoods such as census block groups; land use geography for VE-RSPM.
* **Marea**: “Urbanized” portion of a select set of Azones that are associated with a common urbanized area; often separate models are applied for Mareas, making use of information on road, transit and urban-mixed use variables only present in the Marea.  Mareas are typically equivalent to a “census urbanized area”.

Not geographic areas, but related:
* **Location Type**:  Defines whether households are located in an Urban (i.e. urbanized area), Town, or Rural area. [[MORE ON URBANIZED Vs. MArea]]
* **Place Type**: Defines the level of urbanization (area type) and the mixing of jobs and housing (development type); Used most frequently in VE-State to synthesize Bzones from more aggregate inputs.
* (NOT USED CURRENTLY) Czone: Subdivisions of Bzones representing developments. 

#### 1. Household Synthesis
VERSPM Packages: (VESimHouseholds, VELandUse) + VEHouseholdVehicles-AssignDrivers?
##### DEFINITIONS
  * Age groups (for persons and workers): 0-14, 15-19, 20-29, 30-54, 55-64, 65+
  * Lifecycle (aggregated NHTS definition) – used in multi-modal travel module
    * 01: one adult, no children
    * 02: 2+ adults, no children
    * 03: one adult, children (corresponds to NHTS 03, 05, and 07)
    * 04: 2+ adults, children (corresponds to NHTS 04, 06, and 08)
    * 09: one adult, retired, no children
    * 10: 2+ adults, retired, no children
  * Annual income???
  * Types of househoSomething like slide 39 of [VE Training Slides](https://github.com/VisionEval/VisionEval/wiki/VERSPM-Training/VE-RSPM_Training_Draft_Slides_3-15-19.pdf). 
lds:
    * Regular households - related and unrelated persons living in the same dwelling unit
    * Group quarters households - persons living in non-institutional group quarters such as college dorm (household size =1)
  * Types of dwelling Units: 
    * Single-family (SF) 
    * Multifamily (MF)
    * Group Quarters (GQ)
  * Home and Work Location Types:
    * Urban - located within an urbanized area <MORE HERE...vs. "urbanized">
    * Town - located in a smaller urban area that does not have enough population to qualify as an urbanized area
    * Rural - located in an area characterized by low density dispersed development
  * Bzone-level Built Form “D” variables, based on EPA Smart Location Database definitions
    * **DENSITY**
      * Population density (EPA SLD D1B)
      * Employment density (D1C)
      * Activity density (employment + households) (D1D)
    * **DIVERSITY**
      * ratio of jobs to households (D2A_JPHH)
      * ratio of workers living in the zone to jobs located in the zone (D2A_WRKEMP).
      * entropy measure calculated from the number of jobs by sector and number of households (D2A_EPHHM)
    * Destination **ACCESSIBILITY** measure (D5), harmonic mean of jobs within 2 miles and population within 5 miles of the Bzone centroid
    * Pedestrian-oriented network **DESIGN **measure. Count of pedestrian-oriented intersections per land area is a common indicator of walkability.  Pedestrian-oriented intersections are defined here as intersections having four or more legs of low-speed roads (<= 30 MPH) which permit pedestrian travel and other pedestrian paths [similar to EPA SLD D3bpo4 measure]
    * Bzone-level Urban **MIXED USE** measure. Based on the 2001 National Household Travel Survey measure of the block group level urban/rural indicator. This measure developed by Claritas uses the density of the tract and surrounding tracts to identify the urban/rural context of the tract and identified 4 categories: urban, suburban, second city, town and rural. The urban category roughly corresponds to the inner portions of urbanized areas that are generally characterized by more urban and mixed-use development.

  * Policy Levers (Bzone-level Programs)
    * Worker parking cash-out program.xxx
    * Car services include taxis, car sharing services (e.g. Car-To-Go, Zipcar), and future automated taxi services. A high car service level is one that has vehicle access times (time to walk between car and origin or final destination) that are competitive with private car use. High level of car service is considered to increase household car availability similar to owning a car. Low level car service, approximates current taxi service does not have competitive access time and is not considered as increasing household car availability.
    *  Travel Demand Management Programs. These programs provide information and incentives to facilitate reductions in VMT.  VisionEval includes the following program that household participants can be enrolled in:
      *  Workplace employee commute options (ECO) programs 
      *  Household-based individualized marketing program (IMP) 
CAUTION:  The model assumes high-caliber TDM programs are in place that produce significant VMT savings. Inputs should reflect this. 

### 2. Vehicles & Fuels 
(VEHouseholdVehicles, VEPowerTrainsAndFuels, VETravelPerformance-Opcosts&Fee2coverRdcosts)+workers get auto own vs. car svc & own adjustment. AssignDrivers?, veh type, age, costs (own, op)


### 3. Congestion, freight, and emissions  
* [`road class`]() (freeway, arterial, other)
* [`urbanized area`]() -- define as used in CalculateRoadDvmt 
* [`growth basis`]() -- define, and give options


* **Speed smoothing.** Policies & programs that reduce fuel consumption by reducing acceleration and deceleration losses.  Adjustments are only made to [`ICE`]() powertrains, as electric motors are more efficient in acceleration and recover energy when decelerating.  Lower speeds have greater potential for improving fuel economy with speed smoothing.
* [`ITS-Speed smoothing programs`]() through active traffic management on freeways and/or arterials.   
* [`Eco-driving`] is the practice of driving in ways that increase fuel economy and reduce carbon emissions. This can occur via changes to driver behavior, e.g. as in marketing programs or commercial vehicle training programs, or by increased vehicle automation.  VisionEval allows for [`LDV`]() and [`Hvy Truck`]() eco-driving inputs. 

Note:  Eco-driving as modeled, does not account for non-speed related improvements to fuel economy, e.g., proper tire inflation, regular maintenance, and reduced vehicle payload. 

* **Fuel Efficiency.** used in the context of electric vehicles means the energy efficiency of the electric vehicle (i.e. miles per kilowatt-hour). 


### 4. Household Travel, Costs & Budgets 

  * Transit D:  Weekday PM Peak Period visits by transit service within 0.25 miles."EPA analyzed GTFS data to calculate the frequency of service for each transit route between 4:00 and 7:00 PM on a weekday. Then, for each block group, EPA identified transit routes with service that stops within 0.4 km (0.25 miles). Finally EPA summed total aggregate service frequency by block group. Values for this metric are expressed as service frequency per hour of service."
  * Transit Service Modes: Transit Service is characterized by 8 modes (as defined in the National Transit Database) 
    * VP = Vanpool and similar
    * MB = Standard motor bus
    * RB = Bus rapid transit and commuter bus
    * MG = Monorail/automated guideway
    * SR = Streetcar/trolley bus/inclined plane
    * HR = Heavy Rail/Light Rail
    * CR = Commuter Rail/Hybrid Rail/Cable Car/Aerial Tramway

  * more Transit D: within metropolitan areas the aggregate peak period transit service by Bzone and model run year. This measure is the aggregate frequency of transit service within 0.25 miles of the Bzone boundary per hour during evening peak period consistent with the EPA Smart Location Database.
  * more Transit Vehicle Types: For estimating emissions and congestion, transit service is simplified into 3 vehicle types (Van, Bus, Rail). Transit modes DR and VP are assumed to be served by vans, the MB and RB modes by buses, and the MG, SR, HR, and CR modes by rail.van (modes DR, VP), bus (modes MB, RB), and rail (modes MG, SR, HR).
  * more Transit Bus equivalent-miles: Bus equivalent factors for each of the 8 modes is calculated on the basis of the average productivity of each mode as measured by the ratio of passenger miles to revenue miles. The bus-equivalency factor of each mode is the ratio of the average productivity of the mode to the average productivity of the bus (MB) mode.

VMT NOTE: This module estimates household vehicle travel regardless of where is occurs (i.e. outside the model region as well as inside the model region). The calculations of DVMT on roadways within urbanized areas, for the purpose of calculating congestion and its effects, are carried out by the CalculateRoadDvmt module in the VETravelPerformance package. Household vehicle travel includes travel using car services.

**Vehicle Operating Cost**. Vehicle operating costs used in household budget limitations include the following components:
    * **In Owned Vehicles** (owned or leased by the household): Fuel (energy), Veh operations (Maintenance, tires and repairs, Pay-as-you-drive insurance mileage fee), per mile fees (Gas and Road use taxes, Pollution taxes (e.g. carbon tax)) and Parking charges.
    * **In CarService Vehicles** (owned or leased by the household): Car Service mileage fee, Fuel (energy), per mile fees (Gas and Road use taxes, Pollution taxes (e.g. carbon tax)).

**AccessTime** is the average amount of time spent on each end of the vehicle trip (owned or Car Service) to get from the origin to the vehicle and from the vehicle to the destination
**Social costs** are costs borne by present and future generations due to the impacts of transportation. VisonEval uses a 2011 ODOT white paper that identifies values for various social costs, such as transportation emissions increase the incidence of asthma and other lung diseases and impose costs to affected individuals in terms of reduced life expectancy, reduced quality of life (noise and safety), increased medical treatments, and national security. Typically drivers do not compensate society for these vehicle costs, but increasingly economists and others interested in transportation policy are proposing that social costs be included in vehicle pricing to reduce unwanted outcomes. For example, carbon pricing has been proposed at the state and federal level to reduce carbon-dioxide emissions which are increasing global temperatures and causing increased damages from extreme weather, flooding, drought, etc. As such, VisionEval distinguishes climate change separate from other social costs. 
   * **Climate Change Cost**: VisionEval estimates default climate change costs by year are based on a 3% discount rate per Interagency Working Group on Social Cost of Greenhouse Gases, August 2016 report. Users can also override the default with optional inputs. 
   * **Other Social Coat**: Values for other social costs are derived from an  white paper prepared for the Oregon Department of Transportation (ODOT) to support the development of ODOT's statewide transportation strategy for reducing greenhouse gas emissions from the transportation sector. This paper is included as the 'STS_White_Paper_on_External_Costs_9-21-2011.pdf' file in the 'inst/extdata/sources' directory of this package. The included social cost categories are air pollution, other resource pollution, energy security, safety, and noise.

**Maintenance, Tire, and Repair (MRT) Cost**

* **Electric vehicle surcharge tax proportion** From the input gas tax per mile paid by fuel-consuming vehicles, an equivalent per mile surcharge tax rate (average MPG of all vehicles) is calculated.  The user can identify what proportion of the PH/EV [both?] vehicles pay this per mile surcharge (0 to 1=100%).

### 5. Local policy actions 
(various), MArea attributes (VETransportSupply), rds, transit,res pkg restrictions, TDM/IMP, CarSvc?,   ITS & Fuel economy/ecodrive adj?
 

### 6. Setup & Validation 
(VETravelPerformance/LoadDefaultRoadDmtValues)

==FUTURE:  TARA merge with definitions page. Delete what is not used. This is a dump of shorter definition lists than the original definitions list. This also includes a more comprehensive list of terms to include, and possibly some add'l definitions. 

## VisionEval Definitions
This page summarizes VisionEval definitions by Concept, Explaining basic terminology used in VisionEval.  Terms may apply to multiple concepts, so searching the page may if you can't find it where you expect. 

This page organizes VisionEval Definitions by the following VE Concepts:
 * [Household Synthesis & Land Use](#1)
 * [Household Multi-modal Travel](#2)
 * [Vehicles, Fuels & Emissions](#3)
 * [Congestion](#4)
 * [Household Costs & Budgets](#5)* 

Other useful information:  A conceptual discussion of VisionEval is [here](). 

### VisionEval Geography
- Region (modelwide) 
- MArea (Metropolitan area)
- Azones (optional)(group of Bzones, often counties or cities)
- Bzones (often census tracts or block group size, group of travel model TAZs)


### DEFINITIONS: 1. Household Synthesis & Land Use
* [`Age groups`]() (for persons and workers)
* [`Lifecycle`]() (aggregated NHTS definition) – used in multi-modal travel module
* Annual Household [`Per Capita Income`]()
* [`Household Types`]() of : Regular & Non-instutional Group Quarters
* [`Dwelling Unit Types`]():  Single family, multi-family, GQ
* [`Location Types`]() for Home and Work: [`Metropolitan`](), Town, Rural
* [`Built Form 'D' variables`](): Bzone-level attributes of: 
    * **DENSITY**, **DIVERSITY**, Destination **ACCESSIBILITY**, Pedestrian-oriented network **DESIGN** (input), Distance to **TRANSIT** (input) measures [based on EPA Smart Location Database definitions] 
* Urban **[`MIXED USE`]()**. xxx [based on NHTS2001 definition]
* [`Worker parking cash-out program`]().xxx
* [`Car service`]():  Low and High service, including taxis, car sharing services (e.g. Car-To-Go, Zipcar), and future automated taxi services. 
* [`Employment Types`](): Total, Retail, Service
* [`Employment Rate`]()
* [`Licensure Rate`]()
* [`Travel Demand Management`]() Programs. Both home-based Individualized Marketing Programs (IMP) & Work-based Employee Commute Options (ECO) program
* [`Short Trip diversion`]()
* [`AZone mean income`]()
* [`Auto ownership cost`]()
* [`Transit service level`]()
* [`Parking restrictions`]() & [`Parking Fees`](), including workplace [`parking cash-out-buy-back program`]()
* [`Developable land area`]() (unprotected, removing parks and water)
* [`Census PUMS`]() public use datasets for the local area
* [`2001 National Household Travel Survey`]() public use datasets for the local area
   
## DEFINITIONS: 2. Household Multi-modal Travel
* [`Transit D`]().  Weekday PM Peak Period visits by transit service within 0.25 miles.
* [`Transit Service Modes`](). Transit Service is characterized by 8 modes. Demand responsive (DR), Vanpool (VP), Buses (standard motor bus MB, Rapid-Commuter RB), Rail (Monorail MG, Streetcar SR, Heavy-Light Rail HR).  
* [`Transit Vehicle Types`](). van (modes DR, VP), bus (modes MB, RB), and rail (modes MG, SR, HR).
* [`Transit Revenue miles`]().  In-service revenue miles, as defined by National Transit Database.  VisionEval estimates dead-heading when not in service, which are added to cover all miles when estimating emissions and congestion. 
* [`Transit Bus equivalent-miles`](). Revenue miles are adjusted to bus-equivalent (i.e. mode MB) miles (e.g. ratio of , to better reflect the service level experienced by a transit rider (i.e., light rail attracts more riders per in-service mile than demand-responsive service)

* [`Household DVMT by percentile`](). In addition to average day (7 days), VisionEval estimates DVMT for each 5% percentile (e.g. 5th percentile, 10th percentile, 15th percentile, etc.) as well as the 99th percentile. This is used to help identify whether an EV vehicle is feasible for this households typical travel
NOTE: This module estimates household vehicle travel regardless of where is occurs (i.e. outside the model region as well as inside the model region). The calculations of DVMT on roadways within urbanized areas, for the purpose of calculating congestion and its effects, are carried out by the CalculateRoadDvmt module in the VETravelPerformance package. Household vehicle travel includes travel using car services.

* [`SOV diversion`]() qualifying SOV tours (i.e. round trip tours 20 miles or less in length). allows evaluating the potential for light-weight vehicles (e.g. bicycles, electric bikes, electric scooters) and infrastructure to support their use, in reducing SOV travel.  Bikes represent this diversion in the outputs, but could be other light-weight vehicle modes.  

* [`Travel Demand Management program]() participation  - TDM/IMP
* [`Household VMT`]() - (auto and car share)

* [`Value of Time`]() 
 
 For TDM, Parking, PAYD?, Car Service inputs -- see Concept #1


### DEFINITIONS: 3. Vehicles, Fuels & Emissions
*  [`Vehicle Groups`](). VisionEval contains the following vehicle groups.  Light duty vehicles are further split by [`Vehicle Type`]()
    * Household vehicles, including CarService vehicles are considered light duty (roughly less than XX lbs).  
    * Commercial Service Vehicles represent local delivery within Metropolitan areas only, and are assumed to be light duty, but may contain some medium duty (roughly up to 26,000 lbs).  
    * Heavy trucks, represent intercity long-haul freight, and are considered heavy duty (over 26,000 lbs).  
    * Transit Buses are heavy duty, but transit vans are light duty.

Note: Fuel consumption and emissions from [`car services`]() are calculated in conjunction with household vehicle emissions and are attributed to the household. 

*  [`Vehicle Type`]().  Light duty vehicles consist of a mix of [`Light trucks`]() including pickup trucks, sport utility vehicles, vans, and any other vehicle not classified as a passenger car light truck. All others are [`automobiles`](). User inputs must be consistent with assumptions in default package data, which currrently uses this definition.
*  [`Vehicle Table`](). One record for each household of working age [or worker?]
    *  “Owned” for access to vehicles owned or leased by a household, with attributes of [`vehicle type`]() and average vehicle age.
    * [`Car Service Level`](). Either“LowCarSvc” or “HighCarSvc”, based on coverage in the home Azone, for workers without an owned vehicle.
* [`time-to-access vehicle`](). Attribute of owned and CarService vehicles, representing the time to.....
* [`Powertrains`](). Internal combustion engine vehicle ([`ICEV`]()), hybrid electric vehicle ([`HEV`]()), plug-in hybrid electric vehicle ([`PHEV`]()), and battery electric vehicles ([`BEV`]()). 

* [`fuel efficiency`](). Default inputs are in Miles per gallon (MPG) and Miles per kilowatt-hour (MPKWH) (or often more convenient gallons per mile (GPM) and kilowatt-hours per mile (KWHPM)), as well as calculations of Miles per gasoline gallon equivalent (MPGe).Statistics are also kept on the VMT powered by hydrocarbon fuel versus electricity.
* [`fuel blend`]() proportions (gasoline blended with ethanol, biodiesel blended with diesel, renewable natural gas is blended with natural gas)
* [`carbon intensity`]() of fuels (grams CO2e per megajoule)
Note: Energy consumption is calculated in gas gallon equivalents (GGE) or kilowatt hours (KWH) (or both in the case of [`PHEV`]()). Both are converted to equivalent megajoule (MJ) energy values. 

## DEFINITIONS: 4. Congestion
* [`road class`]() (freeway, arterial, other)
* [`urbanized area`]() -- define as used in CalculateRoadDvmt modulexxx
* [`growth basis`]() -- define, and give options
* [`road class`]()
* [`Congestion Levels,`]() -- VisionEval uses congestion levels defined in the 2009 Urban Mobility Study by the Texas Transportation Institute, Exhibit A-6.  The 2009 report's data-relationships used in VE are provided [here](https://github.com/VisionEval/VisionEval/blob/master/sources/modules/VETravelPerformance/inst/extdata/ums_2009.csv), and embodied in [this chart](https://github.com/VisionEval/VisionEval/blob/master/sources/modules/VETravelPerformance/inst/module_docs/art_dvmt_cong_prop.png).
### DEFINITIONS: 5. Household Costs & Budget
NOT SURE WHERE FITS: ‘OwnCost’ is how much the household pays each year to own their vehicles. It is the sunk cost they ‘pay’ each year as opposed to the variable cost that they pay for each mile that they drive. The ‘OwnCostSavings’ (separate output) is the ownership cost that they saved by substituting the use of car services for owning a vehicle. The module documentation describes how the decision is made to drop (or no) one or more cars from a household inventory if car service costs are price competitive.

* **Vehicle Operating Cost.** Vehicle operating costs include Out-of-pocket costs (used in household budget model) including....While composite operating costs add time-equivalent cost of travel: Fuel (energy), Veh operations (Maintenance, tires and repairs, Pay-as-you-drive insurance mileage fee), per mile fees (Gas and Road use taxes, Pollution taxes (e.g. carbon tax)), Parking charges, and car service fees. Some new terms include:
    * **Access Time.** average amount of time spent on each end of the vehicle trip (owned or Car Service) to get from the origin to the vehicle and from the vehicle to the destination 
    * **Social Costs**, including Cost of Carbon and other social costs. Input identifies portion paid by drivers.
    * **Electric Vehicle surcharge**. Equivalent fuel tax paid per mile for vehicles that don't purchase fuel. Input identifies portion of EV [or PH/EV?] vehicle miles subject to the fee.

* **Vehicle ownership costs.** Includes financing, depreciation, insurance--unless in PAYD program, annual registration fees, residential parking fees.

* **Car Service substitution probability**. Average likelihood that an owner would substitute car services for a household vehicle (separate values by [`Vehicle Type`]().  For example, if the user assumes that only a quarter of light truck owners would substitute car services for owning a light truck (e.g. because car services wouldn't enable them to use their light truck as they intend, such as towing a trailer), then the light truck substitution probability would be 0.25.

* **Passenger car equivalent (PCE)** for heavy trucks. PCE indicates the number of light-duty vehicles a heavy truck is equivalent to in calculating road capacity.

======Move to Definitions 
  * CO2eCost: Environmental and social cost of CO2e emissions per metric ton. in file [region_co2e_costs.csv]
  * PropClimateCostPaid: Proportion of climate change costs paid by users (i.e. ratio of carbon taxes to climate change costs).
  * PropOtherExtCostPaid: Proportion of other social costs paid by users.
  * RoadBaseModCost: Average base modernization cost per light-duty vehicle mile traveled (dollars per vehicle mile). Base modernization includes roadway improvements exclusive of addition of lanes.
  * RoadPresOpMaintCost: Average road preservation, operations, and maintenance cost per light-duty vehicle mile traveled (dollars per vehicle mile).
  * RoadOtherCost: Average other road cost (e.g. administration, planning, project development, safety) per light-duty vehicle mile traveled (dollars per vehicle mile).
  * FwyLnMiCost: Average cost to build one freeway lane-mile (dollars per lane-mile).
  * ArtLnMiCost: Average cost to build one arterial lane-mile (dollars per lane-mile).
  * HvyTrkPCE: Passenger car equivalent (PCE) for heavy trucks. PCE indicates the number of light-duty vehicles a heavy truck is equivalent to in calculating road capacity.
*  Access time includes the time to get from the origin to the vehicle (or in the case of taxi or TNC, the time for the vehicle to get to the traveler) and the time to get from the vehicle to the destination (including time to park the vehicle).  Covers Owned and Car Service (high and low service levels) in units of minutes per trip.
  * PevSurchgTaxProp: Proportion of equivalent gas tax per mile paid by hydrocarbon fuel consuming vehicles to be charged to plug-in electric vehicles per mile of travel powered by electricity.
  * FuelCost: Retail cost of fuel per gas gallon equivalent in dollars.
  * PowerCost: Retail cost of electric power per kilowatt-hour in dollars.
 
## VisionEval Definitions

> FUTURE:  TARA merge with definitions page. Delete what is not used. This is a dump of shorter definition lists than the original definitions list. This also includes a more comprehensive list of terms to include, and possibly some add'l definitions.

> Future possibility: Add links to deeper docs within VE repos

This document summarizes the VisionEval definitions, organized into thematic areas. Collectively these provide a lexicon of the concepts and terminology used in VisionEval. It is designed to be used in conjunction with the [VisionEval concept primer](https://github.com/VisionEval/VisionEval/wiki/VisionEval-Primer) rather than a standalone document. However, one can learn quite a bit about the architecture and functionality of VisionEval by skimming through this document.

Terms are alphabetized within each of the major thematic areas below. _Searching this page may be the quickest way to find specific items,_ as terms are alphabetized within each of five major thematic areas below:

1. [VisionEval Geography](#1-VisionEval-Geography)
2. [Household Synthesis & Land Use](#2-Household-Synthesis-and-Land-Use)
3. [Household Multi-modal Travel](#3-Household-Multi-Modal-Travel)
4. [Vehicles, Fuels & Emissions](#4-Vehicles-Fuels-and-Emissions)
5. [Congestion](#5-Congestion)
6. [Household Costs & Budgets](#6-Household-Costs-and-Budget)

## 1. VisionEval Geography

+ [`Region`](): The region defines the entire modeled area represented in the model. There is no limit to the size of the modeled region, although sub-state areas, states, and [megaregions](https://en.wikipedia.org/wiki/Megaregions_of_the_United_States) are often simulated using VisionEval.
+ [`MAreas`](): Metropolitan areas are defined within the model-wide Region. The primary benefit of doing so is to enable the coding of transit systems with higher levels of service and accessibility and to denote higher levels of background congestion.
+ [`Bzones`](): The smallest levels of geography coded in VisionEval, and often correspond to Census tracts or block groups. In most instances the Bzones are larger than traffic analysis zones used in traditional travel demand forecasting models.
+ [`Azones`](): Optional aggregations of Bzones, often corresponding to county, city, Census named place, or comparable political divisions.

## 2. Household Synthesis and Land Use

+ [`5D variables`](): Built form variables relating to housing _density_, land use _diversity_, _destination_ accessibility, and neighborhood _design_, _demographics_ and employment, and transit service proposed by Ewing & Cervero ([2001](https://journals.sagepub.com/doi/abs/10.3141/1780-10), [2010](https://www.tandfonline.com/doi/abs/10.1080/01944361003766766)). These variables are used to measure the relative efficiency of a location, particularly with respect to smart cities visions. These variables are coded at the Bzone level, and correspond to definitions found in the [EPA Smart Location Database](https://www.epa.gov/smartgrowth/smart-location-database-technical-documentation-and-user-guide).
+ [`Age groups`](): VisionEval classifies persons in the population as a child (0-10 years old), teenager (11-19 years old), young adult (20-44 years old), mid-life (25-64 years old), and seniors (65+ years old).
+ [`Auto ownership cost`](): 
+ [`Built form 'D' variables`](): see `5D variables`
+ [`Car service`]():  // Low and High service, including taxis, car sharing services (e.g. Car-To-Go, Zipcar), and future automated taxi services. 
+ [`Census PUMS`](): see `Public Use Microsample`
+ [`Developable land area`](): The amount of developable land area within a Bzone in acres. This can include vacant and under-developed land, as well as land available for reconstruction. The area calculation should exclude public spaces (e.g., parks, public buildings) and natural features such as water and ravines.
+ [`Dwelling Unit Types`](): Each synthetic household occupies a single family or multi-family dwelling, or is part of group quarters (GQ).
+ [`Employment Rate`](): The employment rate is the number potential workers aged 17 and over divided by the total number of persons in the Bzone. Note that it is a calculated rate based on zonal attributes, and is a proxy for the labor force participation rate. 
+ [`Employment Types`](): Employment is classified as Total, Retail, or Service. Retail employment corresponds to [NAICS](https://www.census.gov/eos/www/naics/) sector 44-45, while Service corresponds to sectors 51-81. The Total employment includes all sectors, to include Service and Retail. 
+ [`Household Types`](): Household are classified as either a regular household or unrelated persons living in non-institutional group quarters. The `Household type` describes the type of household in terms of the interpersonal relationships, while `Dwelling type` describes the type of structure that the household occupies.
+ [`Licensure Rate`](): The percent of adults aged 17 and over that possess a drivers license, summarized from the PUMS data for the modeled region. 
+ [`Location Types`](): Each home and work location is labeled metropolitan, town, or rural.
+ [`Mean income`](): The mean household income by Azone is compiled from Census data.
+ [`National Household Travel Survey`]() (NHTS): The [NHTS](https://nhts.ornl.gov/) is conducted periodically by the Federal Highway Administration to collect household, traveler, and travel diary information from households across the nation. Data from the 2001 NHTS has been used to develop the travel demand rates and distributions used in VisionEval.
+ [`Parking restrictions`]() and [`Parking Fees`](): // including workplace [`parking cash-out-buy-back program`]()
+ [`Per Capita Income`]():   // Annual household
+ [`Public Use Microsample`]() (PUMS): The [PUMS data](https://www.census.gov/programs-surveys/acs/technical-documentation/pums.html) are untabulated and anonymized person and household records with individual responses coded in the Census, to include age, employment status, etc. Multi-dimensional summaries of these data are used in population synthesis and to create travel and vehicle use statistics used in VisionEval.
+ [`Short Trip diversion`]():
+ [`Transit service level`]():
+ [`Travel Demand Management`]() programs: Both home-based Individualized Marketing Programs (IMP) and Work-based Employee Commute Options (ECO) programs can be coded.
+ [`Worker parking cash-out program`]():   // .xxx

> Unresolved:
>* Urban **[`MIXED USE`]()**. xxx [based on NHTS2001 definition]

## 3. Household Multi-Modal Travel 

+ [`Household DVMT by percentile`](): In addition to average day (7 days), VisionEval estimates DVMT for each 5% percentile (e.g. 5th percentile, 10th percentile, 15th percentile, etc.) as well as the 99th percentile. This is used to help identify whether an EV vehicle is feasible for this households typical travel. (Note that this module estimates household vehicle travel regardless of where is occurs (i.e. outside the model region as well as inside the model region). The calculations of DVMT on roadways within urbanized areas, for the purpose of calculating congestion and its effects, are carried out by the `CalculateRoadDvmt` module in the `VETravelPerformance` package. Household vehicle travel includes travel using car services.)
+ [`Household VMT`](): // - (auto and car share)
+ [`Lifecycle`](): // (aggregated NHTS definition) – used in multi-modal travel module
+ [`SOV diversion`](): Qualifying SOV tours (i.e. round trip tours 20 miles or less in length). This allows evaluating the potential for light-weight vehicles (e.g. bicycles, electric bikes, electric scooters) and infrastructure to support their use in reducing SOV travel. Bikes represent this diversion in the outputs, but could be other light-weight vehicle modes.
+ [`Transit Bus equivalent-miles`](): Revenue miles are adjusted to bus-equivalent (i.e. mode MB) miles (e.g. ratio of , to better reflect the service level experienced by a transit rider (i.e., light rail attracts more riders per in-service mile than demand-responsive service)
+ [`Transit D`](): Weekday PM Peak Period visits by transit service within 0.25 miles.
+ [`Transit Revenue miles`](): In-service revenue miles, as defined by National Transit Database.  VisionEval estimates dead-heading when not in service, which are added to cover all miles when estimating emissions and congestion. 
+ [`Transit Service Modes`](): Transit Service is characterized by 8 modes: demand responsive (DR), Vanpool (VP), Buses (standard motor bus MB, Rapid-Commuter RB), Rail (Monorail MG, Streetcar SR, Heavy-Light Rail HR).  
+ [`Transit Vehicle Types`](): The transit vehicle types include van (modes DR, VP), bus (modes MB, RB), and rail (modes MG, SR, HR).
+ [`Travel Demand Management program`](): see `Travel Demand Management`
+ [`Value of Time`]():
 
## 4. Vehicles, Fuels, and Emissions

+ [`Vehicle Groups`](): VisionEval includes the four several vehicle groups listed below. Light duty vehicles are further split by [Vehicle Type]. Fuel consumption and emissions from car services are calculated in conjunction with household vehicle emissions and are attributed to the household.
    + Household vehicles, including CarService vehicles are considered light duty (roughly less than 5,000 pounds).
    + Commercial Service Vehicles represent local delivery within Metropolitan areas only, and are assumed to be light duty, but may contain some medium duty (roughly up to 26,000 pounds).
    + Heavy trucks, represent intercity long-haul freight, and are considered heavy duty (over 26,000 pounds).
    + Transit Buses are heavy duty, but transit vans are light duty.

+ [`Vehicle Type`](): Light duty vehicles consist of a mix of [`Light trucks`]() including pickup trucks, sport utility vehicles, vans, and any other vehicle not classified as a passenger car light truck. All others are assumed to be [`automobiles`](). User inputs must be consistent with assumptions in default package data, which currently uses this definition.

+ [`Vehicle Table`](): One record for each household of working age [or worker?]:
    + "Owned" for access to vehicles owned or leased by a household, with attributes of [`vehicle type`]() and average vehicle age.
    + [`Car Service Level`](): Either “LowCarSvc” or “HighCarSvc”, based on coverage in the home Azone, for workers without an owned vehicle.
    + [`Time-to-access vehicle`](): Attribute of owned and CarService vehicles, representing the time to  // ...
    + [`Powertrains`](): Internal combustion engine vehicle ([`ICEV`]()), hybrid electric vehicle ([`HEV`]()), plug-in hybrid electric vehicle ([`PHEV`]()), and battery electric vehicles ([`BEV`]()).
    + [`Fuel efficiency`](): Default inputs are in miles per gallon (MPG) and miles per kilowatt-hour (MPKWH) (or often more convenient gallons per mile (GPM) and kilowatt-hours per mile (KWHPM)), as well as calculations of miles per gasoline gallon equivalent (MPGe). Statistics are also kept on the VMT powered by hydrocarbon fuel versus electricity.
    + [`Fuel blend`](): Specifies the proportions of gasoline blended with ethanol, biodiesel blended with diesel, renewable natural gas is blended with natural gas
    + [`Carbon intensity`](): The carbon intensity of fuels are expressed in grams of CO2e per megajoule

Note that energy consumption is calculated in gas gallon equivalents (GGE) or kilowatt hours (KWH) (or both in the case of [`PHEV`]()). Both are converted to equivalent megajoule (MJ) energy values within VisionEval.

## 5. Congestion

+ [`Congestion levels`](): VisionEval uses congestion levels defined in the 2009 Urban Mobility Study by the Texas Transportation Institute, Exhibit A-6.  The 2009 report's data-relationships used in VisionEval are included in the [`VETravelPerformance` documentation](https://github.com/VisionEval/VisionEval/blob/master/sources/modules/VETravelPerformance/inst/extdata/ums_2009.csv) and [embedded graphics](https://github.com/VisionEval/VisionEval/blob/master/sources/modules/VETravelPerformance/inst/module_docs/art_dvmt_cong_prop.png).
+ [`Growth basis`](): //define, and give options
+ [`Road class`](): The proportion of lane miles that are classified as freeway, arterial, other. This is coded separately for the modeled `Region` and for `MAreas` within it. The former is used for all non-metropolitan areas. 
+ [`Urbanized area`]():  // define as used in `CalculateRoadDvmt` modulexxx

## 6. Household Costs and Budget

+ [`Car service substitution probability`](): Average likelihood that an owner would substitute car services for a household vehicle (separate values by `Vehicle Type`. For example, if the user assumes that only a quarter of light truck owners would substitute car services for owning a light truck (e.g., because car services wouldn't enable them to use their light truck as they intend, such as towing a trailer), then the light truck substitution probability would be 0.25.
+ [`OwnCost`](): The amount each household pays each year to own their vehicles. It is the sunk cost they ‘pay’ each year as opposed to the variable cost that they pay for each mile that they drive. The `OwnCostSavings` (separate output) is the ownership cost that they saved by substituting the use of car services for owning a vehicle. The module documentation describes how the decision is made to drop (or no) one or more cars from a household inventory if car service costs are price competitive.
+ [`Passenger car equivalent`]() (PCE): The number of light-duty vehicles a heavy truck is equivalent to in calculating road capacity.
+ [`Vehicle operating cost`](): This includes out-of-pocket costs (used in household budget model), which include ... 

> Unsure how to untangle this (part of vehicle operating cost...)
> While composite operating costs add time-equivalent cost of travel: Fuel (energy), Veh operations (Maintenance, tires and repairs, Pay-as-you-drive insurance mileage fee), per mile fees (Gas and Road use taxes, Pollution taxes (e.g. carbon tax)), Parking charges, and car service fees. Some new terms include:
>    * **Access Time.** average amount of time spent on each end of the vehicle trip (owned or Car Service) to get from the origin to the vehicle and from the vehicle to the destination 
>    * **Social Costs**, including Cost of Carbon and other social costs. Input identifies portion paid by drivers.
>    * **Electric Vehicle surcharge**. Equivalent fuel tax paid per mile for vehicles that don't purchase fuel. Input identifies portion of EV [or PH/EV?] vehicle miles subject to the fee.

+ [`Vehicle ownership costs`](): Includes financing, depreciation, insurance (unless in PAYD program), annual registration fees, and residential parking fees.

## Pending definitions

> These have been identified as important to include, but which of the above sections they should be added to has yet to be decided:

+ Access time includes the time to get from the origin to the vehicle (or in the case of taxi or TNC, the time for the vehicle to get to the traveler) and the time to get from the vehicle to the destination (including time to park the vehicle).  Covers Owned and Car Service (high and low service levels) in units of minutes per trip.
+ ArtLnMiCost: Average cost to build one arterial lane-mile (dollars per lane-mile).
+ CO2eCost: Environmental and social cost of CO2e emissions per metric ton. in file [region_co2e_costs.csv]
+ FuelCost: Retail cost of fuel per gas gallon equivalent in dollars.
+ FwyLnMiCost: Average cost to build one freeway lane-mile (dollars per lane-mile).
+ HvyTrkPCE: Passenger car equivalent (PCE) for heavy trucks. PCE indicates the number of light-duty vehicles a heavy truck is equivalent to in calculating road capacity.
+ PevSurchgTaxProp: Proportion of equivalent gas tax per mile paid by hydrocarbon fuel consuming vehicles to be charged to plug-in electric vehicles per mile of travel powered by electricity.
+ PowerCost: Retail cost of electric power per kilowatt-hour in dollars.
+ PropClimateCostPaid: Proportion of climate change costs paid by users (i.e. ratio of carbon taxes to climate change costs).
+ PropOtherExtCostPaid: Proportion of other social costs paid by users.
+ RoadBaseModCost: Average base modernization cost per light-duty vehicle mile traveled (dollars per vehicle mile). Base modernization includes roadway improvements exclusive of addition of lanes.
+ RoadPresOpMaintCost: Average road preservation, operations, and maintenance cost per light-duty vehicle mile traveled (dollars per vehicle mile).
+ RoadOtherCost: Average other road cost (e.g. administration, planning, project development, safety) per light-duty vehicle mile traveled (dollars per vehicle mile). 
