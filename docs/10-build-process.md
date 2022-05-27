# Module Build Process {#ve-buildprocess}




## Introduction
The purpose of this chapter is to familiarize users with the package build process for creating or modifying individual modules within the VisionEval framework. The package build process is a necessary step for users to incorporate custom or locally specific data into VisionEval. This chapter walks users through the process of substituting data and re-building a typical VE package, using the VESimHouseholds package as a case study in this example.

The typical steps involved in the process include:

- Collect the input data for the package
- Preprocess the inputs
- Re-stimate or update the data in the package into a VisionEval datastore
- Build & install the package for use in VE
- Call the re-built package


## Context
The "build process" in the context of VisionEval is the process of making ready any modifications to core VisionEval packages for use in the overall VisionEval modeling framework. Fundamentally it is the same as building any R-project into a package that can be imported, but in this context it is only able to be imported to the local VisionEval.

The reason that the underlying data cannot simply be modified and the module must be rebuilt before it is available for use in VisionEval is that the VisionEval framework relies on importing each module as an R package. R packages are a fundamental unit of the R ecosystem and create a structured way to bundle code, data, and documentation together into a single package. Packages are then able to be shared, installed, and utilized among R users. In the context of VisionEval, the package is being built specifically for the local VisionEval install.

The reason that simply modifying data inputs (e.g., changing a csv file) is that building the package preserves the R project in its current state, so any changes to the base project will not affect the package until it is rebuilt. Users will need to install the new package for the changes to be reflected. Moreover, VisionEval requires data to follow a consistent datastore structure in `.rda` files within each packages.

**Note**: It is recommended to build VisionEval packages using a version of VisionEval built from the source code located on the [VisionEval github repository](https://github.com/VisionEval/VisionEval). This is different than the zipped VisionEval installer (available on the VisionEval website and GitHub) has been pre-built and bundled together with all necessary dependencies embedded, making it difficult to modify individual VisionEval packages without creating dependency issues.

### Generic VisionEval Module
VisionEval packages will generally have a structure similar to the following:
```
VisionEval\built\visioneval\4.x.x\src\VEGenericPackage
├───data
│   ├─ GenericPackageSpecifications.rda
│   ├─ GenericPackage_df.rda
│   └─ GenericPackage_ls.rda
├───R
│   ├─ CreateEstimationDatasets.R
│   └─ GenericModel.R
└───inst
    └─ extdata
        ├─ input_data1.csv
        └─ input_data2.txt
```
- `inst\extdata` is where any input data and reference files will be placed
- `R` directory contains any R scripts used in the packages
- `data` contains the datastore files generated/estimated by the R scripts
- `man` and `inst\module_docs`, contain the markdown documentation generated during the build process.

The package might function by first creating the datastore files (`.rda`) from the input files using an `initialize.R` or the `CreateEstimationDatasets.R` script to incorporate the data in the comma separated value (`.csv`) files. 

When the package is called by VisionEval, a function in `GenericModel.R` runs a model using easily accessed data in the datastore.

## Case Study - 1


### VESimHouseholds - PUMS example
The VESimHouseholds contains a number of modules that work within the VisionEval framework to simulate households and their characteristics. The critical purpose of this package is that the data contained within the package are available throughout the VisionEval framework simply by referencing the [VESimHouseholds](https://github.com/VisionEval/VisionEval/tree/master/sources/modules/VESimHouseholds) package. The source code for this package is located on the VisionEval github here: https://github.com/VisionEval/VisionEval/tree/master/sources/modules/VESimHouseholds

It is recommended that package modifications be made withiin your local VisionEval build (i.e., after running `ve.build()`) located in `VisionEval\built\visioneval\4.x.x\src\`, and not the cloned source modules. That way any changes can be reverted to the default VisionEval by re-running `ve.build()`. The ".x.x" will be replaced by whichever R version was used during the build.

## Objective of the Case Study
The objective of this case study is to substitute the default Oregon-based data with another State PUMS data. This is done in three major steps:

1. Preprocess and format "raw'' PUMS data into the comma separated value (.CSV) files for VisionEval input
2. Create the estimated dataset stored as R data files (.Rda) for VisionEval (commonly referred to as "datastore" format)   ++{do we link to a definition of datastore in the Lexicon}
3. Re-build and install the module to make it available as a VisionEval module package


## Prerequisites
To build a VisionEval package, or any R package, you need the follow packages. These should have already been installed as requisite of the overall VisionEval framework.

- [RTools 4.0](https://cran.r-project.org/bin/windows/Rtools/rtools40.html)
- [devtools](https://www.r-project.org/nosvn/pandoc/devtools.html)


## Input files being modified
As mentioned, the default data inputs shipped with VESimHouseholds are Oregon-based PUMS data. The input files are two CSV files located in:

- `VESimHouseholds/inst/extdata/pums_households.csv`
- `VESimHouseholds/inst/extdata/pums_persons.csv`

The two CSV files contain disaggregated persons and households data linked by a primary key id field. These data come from Public Use Microdata Sample (PUMS) from the 2000 Decennial US Census. By default, the data in VisionEval is shipped using Oregon-based PUMS.

The files have the following fields and field values.

```
HOUSEHOLDS
----------
SERIALNO: Housing/Group Quarters Unit Serial Number
PUMA5: 5% Public Use Microdata Area code
HWEIGHT: Housing unit weight
UNITTYPE: Type of housing unit
    0 = Housing unit
    1 = Institutional group quarters
    2 = Noninstitutional group quarters
PERSONS: Number of persons living in housing unit
BLDGSZ: Size of Building
    blank = group quarters
    1 = mobile home
    2 = detached one-family house
    3 = attached one-family house
    4 = building with 2 apartments
    5 = building with 3 or 4 apartments
    6 = building with 5 to 9 apartments
    7 = building with 10 to 19 apartments
    8 = building with 20 to 49 apartments
    9 = building with 50 or more apartments
    10 = boat, RV, van, etc.
HINC: Household Total Income in 1999
```

```
PERSONS
-------
SERIALNO: Housing/Group Quarters Unit Serial Number
AGE: Age
WRKLYR: Worked in 1999
    0 = Not in universe (Under 16 years)
    1 = Yes
    2 = No
INCTOT: Person's Total Income in 1999
    NA = Not in universe (Under 15 years)
    ?019998 = Loss of $19,998 or more
    ?000001..019997 = Loss of $1 to $19,997
    0000000 = No/none
    0000001 = $1 or break even
    0000002..4999999 = $2 to $4,999,999
    5000000 = $5,000,000 or more
```


The data are disaggregated (i.e., records) individual persons and households. For example, household data might look like this:

| SERIALNO| PUMA5| HWEIGHT| UNITTYPE| PERSONS| BLDGSZ|   HINC|
|--------:|-----:|-------:|--------:|-------:|------:|------:|
|       45| 25080|      22|        0|       1|      9|  68100|
|       92| 25060|      17|        0|       3|      5| 105530|
|      103| 25090|      21|        0|       2|      6| 359000|
|      142| 25100|      25|        0|       2|      2| 141500|
|      157| 25100|       0|        1|       1|     NA|      0|
|      159| 25070|      22|        0|       1|      2|  14700|

And an example of the persons data might look like this:

| SERIALNO| AGE| WRKLYR| MILITARY| INCTOT|
|--------:|---:|------:|--------:|------:|
|       45|  66|      1|        4|  68100|
|       92|  28|      1|        4|  33000|
|       92|  28|      1|        4|  37000|
|       92|  26|      1|        4|  35530|
|      103|  53|      1|        4|  33000|
|      103|  53|      1|        4| 326000|
|      142|  49|      1|        4| 111500|
|      142|  49|      1|        4|  30000|
|      157|  39|      1|        4|   2100|
|      159|  80|      2|        2|  14700|

Note that the two data files are also linked by a primary key field `SERIALNO`. Meaning that for each unique household, there are at least one or more persons linked to that household by the `SERIALNO` key.


## Step 1 - Preprocessing

To start, we must download our new "raw" PUMS data and format it to match the current VisionEval input files. Processing and formatting can be done manually using spreadsheets and text editors, but some PUMS data are stored in a space saving format that most spreadsheets and humans cannot easily read.

To help with this process, an R script was written with functions that both download the PUMS data and preprocess the data into CSV files for VisionEval, located here: https://github.com/RSGInc/VEProcessPUMS

**NOTE:** It is important to note here that VisionEval household and person fields are based on the 2000 <em>Decennial Census</em> PUMS.

For year 2000 and earlier, PUMS data were based on the decennial Census counted every ten years. <u>Post-2000 PUMS</u> are based on the American Community Survey (ACS), which is a sampling-based survey method collected continuously rather than from a full decennial Census. Statistically, the ACS-based PUMS are reliable, but the fields <u>differ</u> and will need to be migrated to match the inputs used by VisionEval. More [PUMA history](https://www2.census.gov/geo/pdfs/reference/puma/puma_history.pdf) can be read online at the US Census website.

- [2000 Decennial Census PUMS](https://www2.census.gov/census_2000/datasets/PUMS/)
- [Post-2000 ACS PUMS](https://www2.census.gov/programs-surveys/acs/data/pums/)

### 2000 PUMS (aka Census PUMS)
2000 PUMS data comes in two forms, 1% and 5%, which the Census explains as:

> "The 1-percent super-PUMAs were used to present 1-percent PUMS files, were required to contain a minimum population of 400,000 persons, and had to nest within states. These super-PUMAs were a new geographic entity for Census 2000 and were aggregations of the smaller, 5-percent PUMAs.
>
> The 5-percent PUMAs were used to present the 5-percent PUMS files, were required to contain a minimum population of 100,000 persons, and had to nest within states. PUMAs could consist of a single county or an aggregation of one or more counties, census tracts, or minor civil divisions (MCDs) in the New England states. Additionally, an incorporated place with a minimum population of 100,000 persons could be defined as a PUMA."

Basically the 1% PUMS have more persons, but cover a larger geographic area than the 5% PUMS. In this case we are looking to download the revised 5% data. Within each state directory (e.g., https://www2.census.gov/census_2000/datasets/PUMS/FivePercent/California/) there will be several files.

```
PUMEQ5-CA.TXT	        30-Aug-2003 05:21	1.0M
PUMS5_06.TXT	        30-Aug-2003 05:35	677M
REVISEDPUMS5_06.TXT   26-Oct-2010 14:24	676M
all_California.zip    02-Sep-2003 23:08	98M
```

The file named `REVISEDPUMS5_06.TXT` is the file to download. However, the data for both households and persons are stored in a continuous string, which is not an easy to parse delimited format (e.g., comma separated). Extracting the data and converting it into a tabular dataframe is non-trivial.

To help with this process, an R function called `process_2000_pums()` was written in the [VEProcessPUMS](https://github.com/RSGInc/VEProcessPUMS/blob/master/R/ProcessPUMS.R) package to read the `.txt` files, extract the data columns need, convert to R dataframes, and then export the remaining data into the two person and household `.csv` files as VESimHousehold input.

### Post-2000 PUMS (aka ACS PUMS)
Post-2000 PUMS data are typically stored as separate CSV files for persons and households. This makes parsing and importing the data into R very easy. However, the columns are different and the new column names will need to be identified and migrated over. Below is a column crosswalk to translate ACS PUMS to the required field names.

#### Household {-}

|2000 PUMS Field | ACS PUMS Field Name|
| -------------- | ------------------ |
| SERIALNO       | SERIALNO           |
| PUMA5          | PUMA               |
| HWEIGHT        | WGTP               |
| UNITTYPE       | TYPE               |
| PERSONS        | NP                 |
| BLDGSZ         | BLD                |
| HINC           | HINCP              |

#### Persons {-}

|2000 PUMS Field | ACS PUMS Field Name|
| -------------- | ------------------ |
| SERIALNO       | SERIALNO           |
| AGE            | AGEP               |
| WRKLYR         | WKL                |
| MILITARY       | MIL                |
| INCTOT         | PINCP              |


### Preprocessing for VisionEval input data
You can either manually download the text file and process the PUMS data, or use the automated R wrappers `getACSPUMS()` and `getDecPUMS()`.

#### Manually download PUMS and process using process_2000_pums() & process_acs_pums() {-}
An example PUMS processing using the `process_2000_pums` and `process_acs_pums`:
```
# For the 2000 data:
# process_2000_pums() function reads in REVISEDPUMS5_06.TXT,
# parses the data into two dataframes for persons and households, then
# returns a list('p'= person_df, 'h' = household_df)
# It has two input parameters:
#  - PumsFile: path to PUMS TXT data
#  - GetPumas: optional vector of PUMAS ids, defaults to 'ALL'

PUMS_DATA_LIST <- process_2000_pums(PumsFile='REVISEDPUMS5_06.TXT', GetPumas='ALL')
```

The process is similar using the process_acs_pums(). You can specify the path for the extracted .csv or the .zip file. It has one additional parameter to specify the file type as either 'p' for persons or 'h' for households. For example:

```
# For the ACS data:
PUMS_DATA_LIST <- process_acs_pums(PumsFile='csv_pca.csv', type='p' GetPumas='ALL')
```

Then from where you only need to save the dataframes to a csv:

```
# Using base R write.csv
write.csv(PUMS_DATA_LIST[['p']],
          file = file.path(output_dir, 'pums_persons.csv'),
          row.names = FALSE)

# Using fwrite() from `data.table`
fwrite(PUMS_DATA_LIST[['p']],
       file = file.path(output_dir, 'pums_persons.csv'))
```

#### Automatically download PUMS and process using getDecPUMS and getACSPUMS{-}

To streamline the whole process, there is also a download wrapper function which both downloads and calls the preprocessing function. The user only needs to specify the State (and year if using ACS) that they want PUMS data from. For example:

```
# This function downloads the PUMS txt data to a temporary file,
# parses it using the process_2000_pums function, then
# saves or returns the processed data.
# It has two input parameters:
# - STATE: This can be the State name, abbreviation, or fips code
#          (e.g., California, CA, or 6)
# - output_dir: Optional path to save the files pums_persons.csv and pums_households.csv
#               NA path returns the dataframes in a list

# Get 2000 Decennial Census PUMS
# data_list <- getDecPUMS(STATE='CA', output_dir = NA)
getDecPUMS(STATE='CA', output_dir = './output_folder')
```

Similarly, ACS PUMS data for more recent years can be downloaded. For example:

```
# Get ACS PUMS for specified year
# data_list <- getACSPUMS(STATE='CA', YEAR='2020', output_dir = NA)
getACSPUMS(STATE='CA', YEAR='2020', output_dir = './output_folder')
```


## Step 2 - Create the VisionEval estimation data sets

The next step is to use the R scripts in VESimHouseholds to re-generate the VisionEval `.Rda` data files stored in `VESimHouseholds\data`. These data files are stored in a structure and format (e.g., dataframes) that VisionEval can use as part of the framework.

a. Start by instantiating the VisionEval R project environment by loading your model build's `VisionEval.Rproj`. If you have already built your VisionEval using `ve.build()`, you will have a `VisionEval.Rproj` file in your `built` directory. For example, `VisionEval\built\visioneval\4.1.2\runtime\VisionEval.Rproj`.

b. Next navigate to the VESimHousehold package and set your current working directory to the `your_path_to_this/VESimHouseholds` folder. (hint <em>Session -> Set Working Directory</em>)

c. Run the R datastore generation scripts. Depending on the purpose of the module you are working with, the generation R script may vary. Within the package's "R" folder, some will save a datastore with the command `visioneval::savePackageDataset()`, some may not need any data updates, and others might only contain model functions with no immediate output saved.

For example, the `VESimHouseholds/R/CreateEstimationDatasets.R` script reads in the csv input data we created and creates the household data `Hh_df.rda` for VisionEval in the data folder.



## Step 3 - Build the VESimHouseholds package
Although the previous step generated the R data files, your current VisionEval environment will still be using the old package build data. You will need to re-build and re-install the VESimHousehold package for VisionEval to use this new input data.

While your VisionEval R project environment is loaded and current working is `VESimHouseholds`, run the following commands:

```
# This builds the VESimHouseholds data and scripts into an R package
devtools::build()

# This then installs the VESimHouseholds package into VisionEval library
devtools::install()
```

Your new PUMS data should now be ready to use in a VisionEval model run.



## Case Study - 2


### VEPowertrainsandFuels - Changing Inputs for a Scenario Test

This second case study explores a common challenge when certain inputs are embedded in a package.  This case study will be documented in the next version of this Build Process example narrative.



