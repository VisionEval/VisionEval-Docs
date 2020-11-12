5D built form measures {#5D}
: The five dimensions considered in designing efficient and sustainable cities include density, design, destination access, distance to transit, and diversity of the built environment. The five dimensions build upon the original 3Ds (density, diversity, and design) advanced by [Cervero & Kockelman (1997)](https://www.sciencedirect.com/science/article/pii/S1361920997000096). These measures are calculated in the `Calculate4DMeasures` module during household synthesis.

access time {#access-time}
: The time required to get from the origin to the vehicle (or in the case of [CarService](#car-service), the time for the vehicle to get to the traveler) and the time to get from the vehicle to the destination (including time to park the vehicle). These values are defined for vehicles owned  by the household and for two levels of CarService (low and high availability levels) in each Bzone. These factors are defined in `azone_vehicle_access_times.csv` and used by the `CalculateVehicleOperatingCost` module in the `VETravelPerformance` package.
: [Additional details](https://github.com/gregorbj/Archive-VisionEval/blob/develop/api/VE_Training_March_13-14_2019/VE_Training.md#97-calculatevehicleoperatingcost-module)

age group {#age-group}
: VisionEval uses the same age groups used in the U.S. Census: 0-14, 15-19, 20-29, 30-54, 55-64, and 65+ years old. The number of persons in each age group are defined for each synthetic household.
:[Additional details](https://github.com/gregorbj/Archive-VisionEval/blob/master/api/model_system_design.md#8111-model-estimation-datasets)

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

