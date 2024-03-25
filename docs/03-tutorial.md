# VisionEval Tutorial {#tutorial}

The VisionEval Tutorial provides an introductory walkthrough on how to set up a VisionEval model
specific to your area of interest. This chapter does not cover how to install and run VisionEval,
those instructions are covered in the [Getting Started][Getting Started] chapter. For users
completely new to VisionEval, reviewing the [Concept Primer][Concept Primer] chapter for an overview
of VisionEval modeling system is highly recommended before starting into the tutorial materials.

This VisionEval tutorial breaks down the process of setting up a model into several steps. Each step
is described in it's own chapter, referenced below, and can also be accessed from the main
navigation menu.

* The **[Picking a Model](#picking-a-model)** chapter is where to start for an overview of the three VisionEval models, VERSPM, VE-State, and VERPAT, and information on how to make a selection based on model differences and user needs. 
* The **[Model Geography and Years](#model-geography-and-years)** chapter is the first step in applying the selected VisionEval model by making key decision on spatial scale and years.
* The **[Developing Inputs](#model-inputs)** chapter has detailed information on the the specific inputs for each VisionEval model as well as generalized best practices on data sources and methods.
* The **[Validating and Troubleshooting](#validation-and-troubleshooting)** chapter is relevant once users have a complete set of inputs need to debug or validate their base model.
* The **[Developing Scenarios](#developing-scenarios)** chapter contains details on how to use VisionEval to set up multi-scenario runs for exploratory scenario planning.
* The **[Estimation in VisionEval](#ve-estimation)** chapter reviews advanced customization techniques for users, including how model estimation is integrated into the VisionEval modeling system and how to replace a model's default estimation with local data.

# Picking a Model {#picking-a-model}
The VisionEval system is comprised of three models:

* **VERSPM** (VisionEval Regional Strategic Planning Model) was developed by Oregon Department of Transportation (ODOT) as an offshoot of the GreenSTEP model to support the preparation of metropolitan area scenario plans. The name reflects a broadening of the policies, beyond state statutory requirements.  This model operates largely at the zonal level (i.e. inputs and outputs are zone-based).
* **VE-State** is a state level version of VERSPM.  Like VERSPM, this model operates at the zonal level, but the zones are larger than their VERSPM counterparts.
* **VERPAT** (VisionEval Rapid Policy Analysis Tool) was developed under the federal Strategic Highway Research Program (SHRP2).  The model was developed to help planners evaluate the potential effect of growth policies on regional travel. Portions of the GreenSTEP model were used in VERPAT, but substantial revisions were made to the code, including use of land use place type categories. This model operates largely at the region or place type level for the entire region.

## Spatial Detail

One key distinction between the all VisionEval models is the level of spatial detail. In general,
the VisionEval models with a greater level of spatial detail also require more effort for developing
the model inputs. In picking a model, users should consider their needs in the context of this
trade-off between spatial detail and development effort.

**VERSPM** was developed as a regional model for regional planning areas and MPOs. VERSPM models the region in zones (in a manner similar to traditional travel model zones), which results in improved spatial resolution of outputs, but which also increases the data development burden. The selection of the right tool therefore depends on a number of factors – available of data, project resources, desired spatial output detail, etc. Take a look at the model [inputs](#input-files), which has many inputs by Bzones.

**VE-State** was developed as an extension of the VERSPM model to enables users to apply the model for statewide applications. The main difference between the VERSPM and VE-State models is that a number of VERSPM inputs are specified at the Bzone level. Examples include numbers of dwelling units by type and numbers of jobs by sector. VE-State models run at a higher level of abstraction than VERSPM models and don’t have Bzone level inputs. Instead, the VE-State uses a process to [synthesis Bzones](http://htmlpreview.github.io/?https://github.com/VisionEval/VisionEval/blob/master/sources/modules/VESimLandUse/inst/module_docs/analyze_3Ds.html).

**VERPAT**, like VERSPM, operates primarily at the region level. However, VERPAT has less spatial detail than VERSPM and requires inputs at place type level.  As shown below, place types are defined as a combination of area type and development type.  Area type (or regional role) describes the interdependencies of each neighborhood compared to the rest of the region, e.g. how centered is it to jobs in the region. Development type (or neighborhood character) is used to describe the physical characteristics of each neighborhood in isolation.  Operating at the place type level simplifies the input data requirements and the spatial precision of outputs while still capturing the effects of the different place types in the region.  Take a look at the model [inputs](#inputs-and-parameters-2), which has only one input by Bzone (i.e., population and employment) which represents population and employment for each place type.

![](images/verpat-place-types.jpg)

# Model Geography and Years {#model-geography-and-years}

Once a VisionEval model has been selected, the next step is deciding on the model geography and
years. Both the model geography and years will inform the input data needed. 

## Years

Inputs in VisionEval are developed for every model year. Most applications consist of a base year
and a future year. If the model area has a travel demand model available, it is good practice to
align the VisionEval model years with those in the travel demand model, allowing the user to use the
travel demand model to develop VisionEval inputs and validate the VisionEval Model. VisionEval may
be used to model interim years, however each year modeled requires additional input data. 

## Geography

All VisionEval models share a standard geography framework. Although models are applied at different
scales, sharing a common geographic definitions enables modules to be more readily shared between
models. The standard geogrpahy framework specifies levels of geographical units, their names, their
relative sizes, and the hierarchical relationships between them. It is flexible in that it allows
geographical boundaries to be determined by the user and it allows the units in some geographical
levels to be simulated rather than being tied to actual physical locations. Allowing simulation of
one or more geographic levels enables modules to be shared between models that operate at different
scales. For example a statewide model and a metropolitan area model could use the same module for
assigning households to land development types even though the statewide model lacks the fine scale
of geography of the metropolitan model.

Following is the definition of the geographic structure of the VisionEval model system:

* **Region** level is the entire model area. Large-scale characteristics that do not vary across the region are specified at the region level. For example, the carbon intensities of vehicle fuels are defined at the region level since they tend not to vary widely across a large geographic area. Typically, in a VERSPM model the region level is the metropolitan planning region being modeled, for VE-State it's the entire state.
*	**Azones** are large subdivisions of the region level. Azones are used to represent demographic and economic characteristics that vary across the region such as population forecasts of persons by age group and average per capita income. County boundaries are commonly used to represent Azones in both VE-State. In VERSPM, county or municipal boundaries are commonly used. The Azone level of geography must represent actual geographic areas and may not be simulated.
*	**Bzones** are subdivisions of Azones. Bzones are nested within Azones and provide more granularity on the intensity and nature of development. Bzones may correspond to actual geographic areas or may be simulated. Bzone simulation greatly reduces model input data requirements while still enabling the modeling of land-use-related policies and the effects of land use on various aspects of travel behavior. In VERSPM, Bzones must be represented by actual geographic areas; examples of VERSPM Bzone inputs include housing and population density. Common Bzone boundaries for VERSPM are TAZs, Census Tracts, or Census Block Groups. In VE-State and VERPAT, Bzones are simulated and do not represent physical geographic boundaries. Bzones in VE-State are synthesized to represent characteristics likely to be found in an actual set of Bzones within each Azone, such as neighborhood density. In VERPAT, Bzones are simulated as *place types* which characterize the intensity and nature of development. 
* **Mareas** represent metropolitan urbanized areas. Mareas are represented in VisionEval as collections of Azones associated with an urbanized area either because a portion of the urbanized area is located in the Azone or because a substantial proportion of the workers residing in the Azone work at jobs located in the urbanized area. Metropolitan models (VERSPM and VERPAT) typically only have one assigned Marea whereas state models may have several. The model system requires that each Azone may be associated with only one Marea. It is also required that all Azones be associated with an Marea. A special Marea named **'None'** is used to apply to Azones that are not associated with any urbanized area. Mareas are used to specify and model urbanized area transportation characteristics such as overall transportation supply (transit, highways) and congestion. They are also used to specify large scale land-use-related characteristics and policies in models that use Bzone synthesis.
* **Location Type** is not a geography level but a categorical level that identifies whether households are urban/town/rural.
* **Place Type** is not a geography level but defines the level of urbanization (area type) and mixing of jobs and housing (development type).

### Setting Up the Model Geography

Users should note that their selected model geography will determine the geography levels for input
data development. Geographical relationships for a model are described in the "geo.csv" file
contained in the "defs" directory. This file tabulates the names of each geographic unit (except for
region) and the relationships between them. Each row shows a unique relationship. Where a unit of
geography is not explicitly defined (i.e. it will be simulated), "NA" values are placed in the
table. 

The examples below show versions of the "geo.csv" file where only Azones are specified and where
Azones and Bzones are specified. It should be noted that there are no naming conventions for
individual zones. The user is free to choose what conventions they will use.

**Example of a geo.csv file that only specifies Azones**

![](images/azone_geo_file.png)

**Example of geo.csv file that specifies Azones and Bzones**

![](images/azone_bzone_geo_file.png)

#### Model Geography Example
This section details the model geography for ODOT's VE-State model as an example. The geography levels are defined as follows:

* **Azones** must be physical boundaries and are represented by counties.
* **Mareas** are represented by the boundaries of Metropolitan Planning Organizations (MPOs), which can be multi-county. Azones, or counties, without an MPO have the Marea `None`.
* **Location Type** (Urbanized, Town, Rural) are defined as MPOs being urbanized (defined in the model as `Metro`), urban growth boundaries (UGBs) smaller than MPOs are `Town`, and the rest is `Rural`.
* **Marea Area Types** (Center, Inner, Outer, Fringe) (VE-State only) are based on VE-State EPA-SLD-based definition. ODOT builds TAZ-level place type maps for all MPOs to generate.

**ODOT VE-State geo.csv**

| Azone      | Bzone | Czone | Marea             |
| ---------- | ----- | ----- | ----------------- |
| Baker      | NA    | NA    | None              |
| Benton     | NA    | NA    | Corvallis         |
| Clackamas  | NA    | NA    | Metro             |
| Clatsop    | NA    | NA    | None              |
| Columbia   | NA    | NA    | None              |
| Coos       | NA    | NA    | None              |
| Crook      | NA    | NA    | None              |
| Curry      | NA    | NA    | None              |
| Deschutes  | NA    | NA    | Bend              |
| Douglas    | NA    | NA    | None              |
| Gilliam    | NA    | NA    | None              |
| Grant      | NA    | NA    | None              |
| Harney     | NA    | NA    | None              |
| Hood River | NA    | NA    | None              |
| Jackson    | NA    | NA    | RogueValley       |
| Jefferson  | NA    | NA    | None              |
| Josephine  | NA    | NA    | GrantsPass        |
| Klamath    | NA    | NA    | None              |
| Lake       | NA    | NA    | None              |
| Lane       | NA    | NA    | EugeneSpringfield |
| Lincoln    | NA    | NA    | None              |
| Linn       | NA    | NA    | Albany            |
| Malheur    | NA    | NA    | None              |
| Marion     | NA    | NA    | SalemKeizer       |
| Morrow     | NA    | NA    | None              |
| Multnomah  | NA    | NA    | Metro             |
| Polk       | NA    | NA    | SalemKeizer       |
| Sherman    | NA    | NA    | None              |
| Tillamook  | NA    | NA    | None              |
| Umatilla   | NA    | NA    | None              |
| Union      | NA    | NA    | None              |
| Wallowa    | NA    | NA    | None              |
| Wasco      | NA    | NA    | None              |
| Washington | NA    | NA    | Metro             |
| Wheeler    | NA    | NA    | None              |
| Yamhill    | NA    | NA    | None              |

Users can also have Mareas be equivalent to a [Census urbanized area](https://www.census.gov/programs-surveys/geography/guidance/geo-areas/urban-rural.html#:~:text=The%20Census%20Bureau's%20urban%20areas,decennial%20census%20and%20other%20data.) definition. Mareas do not include `Town` location types within the Marea counties. As such, "towns" in the Marea counties typically fall outside of the continuous urbanized area (i.e. Census urbanized area). A county with only `Town` and `Rural` location types will have the Marea `None`. Some exceptions may be made if the outside areas are contiguous enough with the official urbanized area or will be in the horizon of the modeled scenarios, such that they will use common (high frequency) transit systems, and share the same road/congestion. Some examples of this are Eugene VERSPM model including the city of Coburg as "urbanized" rather than a "town" and Portland including Ridgefield in the urbanized area.  The recommendation can be summarized as designating an Marea city outside the census "Urbanized area" definition as “towns” unless: (1) they are contiguous to the larger urbanized area, or will be in the planning horizon, or (2) if they have significant transit service, road congestion that the “town” formulas will not account for. 
