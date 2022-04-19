# Definitions

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
