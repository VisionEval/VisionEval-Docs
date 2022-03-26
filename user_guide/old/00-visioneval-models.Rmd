# VisionEval Models {-}

VisionEval is a collaborative project to merge the successful GreenSTEP family of strategic planning
tools into an open-source framework.  As a result, there are three separate models available to VisionEval users.

## Models {-}

  - **VERSPM** - The RSPM (Regional Strategic Planning Model) was developed by ODOT as an offshoot of the GreenSTEP model to
support the preparation of metropolitan area scenario plans. The name reflects a broadening of the policies, beyond state statutory requirements.  This model operates largely at the zonal level (i.e. inputs and outputs are zone-based).
  - **VERPAT** - The RPAT (Rapid Policy Analysis Tool) was developed under the federal Strategic Highway Research Program (SHRP2).  The model was developed to help planners evaluate the potential effect of growth policies on regional travel. Portions of the GreenSTEP model were used in RPAT, but substantial revisions were made to the code, including use of land use place type categories.  This model operates largely at the region or place type level for the entire region.
  - **VE-State** - The VE-State model is a state level version of VERSPM.  Like VERSPM, this model operates at the zonal level, but the zones are larger than their VERSPM counterparts.

## Spatial Detail {-}

One key distinction between the VERPAT and VERSPM models is the level of spatial detail.  
  - VERPAT operates primarily at the region level and therefore requires inputs at the region or place type level.  As shown below, place types are defined as a combination of area type and development type.  Area type (or regional role) describes the interdependencies of each neighborhood compared to the rest of the region, e.g. how centered is it to jobs in the region.   Development type (or neighborhood character) is used to describe the physical characteristics of each neighborhood in isolation.  Operating at the place type level simplifies the input data requirements and the spatial precision of outputs while still capturing the effects of the different place types in the region.  Take a look at the example model [inputs](https://github.com/gregorbj/VisionEval/tree/master/sources/models/VERPAT/inputs), which has only one input by bzone - population and employment - which represents population and employment for each place type.
  - VERSPM models the region in zones (in a manner similar to traditional travel model zones), which results in improved spatial resolution of outputs, but which also increases the data development burden.  The selection of the right tool therefore depends on a number of factors – available of data, project resources, desired spatial output detail, etc.  Take a look at the example model [inputs](https://github.com/gregorbj/VisionEval/tree/master/sources/models/VERSPM/Test1/inputs), which has many inputs by bzones.

