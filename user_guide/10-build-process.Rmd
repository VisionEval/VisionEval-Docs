# VisionEval Module Build Process {#ve-buildprocess}

   knitr::opts_chunk$set(echo = TRUE, results='hide')

## (Re)Building VisionEval

This chapter describes the build process for VisionEval. The VisionEval "build process" (re)builds VisionEval packages to incorporate default, localized, or custom data in the module's model estimation and data processing steps in order to update data resources and estimated model coefficients.

This chapter sets out the process for updating these datasets that VisionEval modules use during any of the model runs.

For the VisionEval models to access any of these updated data requires re-building of the VisionEval package source. The reason that a package must be rebuilt before it is available for use in VisionEval is that VisionEval creates its own R environment with its own VisionEval modules built as R packages.

### What is an R "package"?

R is a community-based project and depends upon a community of re-usable, reproducible, and shareable code. To facilitate this, R uses a standardized method for bundling a collection of code and data into a built into a shareable binary "package". Packages can then be downloaded and installed into your local R library. An R environment can only access the packages installed in a local R library.

### Why is this relevant?

VisionEval relies on this fundamental package framework for sharing code and data from its modules. In order to alter the data used within a VisionEval module (i.e., an R Package) it must be repackaged, or re-built, using the new data. Otherwise, if only the source data is altered and not re-built, the VisionEval environment fails to recognize the updated data.

### How are packages built?

#### Build vs Runtime Environment

It is crucial for users to understand the distinction between the VisionEval runtime environment and the VisionEval build environment. The VisionEval begins as source code and data in the build environment from which the VisionEval R packages are built, and a runtime environment is created. VisionEval models can only be run from a runtime environment where the built packages are loaded (into an R session) and used by R to perform the model steps. VisionEval runtime environment will be referred to as *VisionEval* from this point on in the document.

## Where do we Start the ‘Re-Building’ Process

The process for obtaining the source code used for rebuilding or updating any module within VisionEval depends on how a user obtained the current runtime:

-   Users who installed a pre-built VisionEval runtime environment using a VisionEval installer.

-   Users who created a VisionEval runtime environment through a build environment by obtaining the source code from GitHub.

The processes for both types of users are described below. Additionally, the process for advanced users who may want to build VisionEval natively from the source code for development or on non-Windows computers is described at the end of this section.

### Users who installed *VisionEval* through the VisionEval installer

Users at this point should have a full *VisionEval* installed and running. If not visit <https://visioneval.org/docs/getting-started.html#installation-and-setup> and follow the path 1 listed to download and install the base model.

#### Software Requirements

-   *R* – R for windows can be downloaded here: <https://cran.rstudio.com/> *(Tested using 4.1.3). It is suggested to use an R version that aligns with the VE R version. The Cran website includes links to past versions although the most current is the one often highlighted on the first page.*

-   *RStudio –* RStudio for windows can be downloaded here: <https://www.rstudio.com/products/rstudio/download/>

#### (Re)Building Package

Rebuilding a package in this *VisionEval* setup will require source code for the specific build that was installed (specific R, operating system, etc.) which is made available in a zip file \[here\]. This zip file contains the source code and default data for all the VisionEval packages that can be easily installed in *VisionEval* using R native command “install.packages” or [RStudio build tools](https://support.posit.co/hc/en-us/articles/200486518-Customizing-Package-Build-Options-in-the-RStudio-IDE). The user can download and unzip the zip file into their *VisionEval* directory. After unzipping, the *VisionEval* directory structure should look similar to Figure 1.

![](images/10_image1.png)

Figure 1 VisionEval runtime directory structure with source code unzipped

The source code of these packages contains code and data upon which the modules are built. This data can then be updated with localized or custom data and the module can be rebuilt into *VisionEval*. The process of rebuilding is explained in more detail in the \[Common Use Cases\] section of this document.

### Users who created *VisionEval* through source code from GitHub

For advanced users who have a complete *VisionEval* built using the source code from GitHub, the process for updating and rebuilding individual modules and packages can be done without the need to download additional source code material. A version of the source code, easily installable in R, is created during the “build process”. A default directory structure for this setup is shown in Figure 2.

![Directory structure for built VisionEval](images/10_image2.png)

Figure 2 VisionEval build directory structure

*Note: if you want to install a complete VisionEval model from the source code please see the section* *VisionEval Full Build Process.*

#### Additional Software Requirements

-   *RTools* – RTools for windows can be downloaded here: <https://cran.r-project.org/bin/windows/Rtools/rtools43/files/rtools43-5493-5475.exe>.

-   *Git* – Git for windows can be downloaded here: <https://github.com/git-for-windows/git/releases/download/v2.39.2.windows.1/Git-2.39.2-64-bit.exe>.

#### (Re)Building Packages Using Package Sources

The source code created during the build process can be used to rebuild packages in this *VisionEval* setup. The process of rebuilding is the same as before, the only difference is the location of the source code relative to the *VisionEval* setup.

VisionEval build environment allows for a single VisionEval package to be created, modified, and installed (aka "built") into an existing *VisionEval* that had been previously created from a full install build. This is useful for creating or modifying single packages and their constituent modules within the VisionEval framework. The build process can be used to incorporate localized or custom data into *VisionEval* by making a change to a module and then rebuilding it.

### VisionEval Full Build Process

Advanced users may want to build VisionEval natively from the source code for development or on non-Windows computers. This process can take several hours the first time it runs. For more details, see instruction in [build/Building.md](https://github.com/VisionEval/VisionEval/blob/master/build/Building.md).

1.  Install [RTools](https://cran.r-project.org/bin/windows/Rtools/rtools43/files/rtools43-5493-5475.exe). The easiest way is to download and run the RTools windows install. RTool4.0 has been tested, but [RTool4.3](https://cran.r-project.org/bin/windows/Rtools/rtools43/files/rtools43-5493-5475.exe) should also work.

2.  Clone or "fork" a copy of the VisionEval from the Github repository (<https://github.com/VisionEval/VisionEval>) into a directory of your choice (e.g., `C:/Users/<``user name``>/Documents/VisionEval-Source`) using:

-   `git clone ``git@github.com:VisionEval``/``VisionEval.git`` VisionEval-Source`

    -   For developers, there is a separate development repository with the latest unreleased source code: <https://github.com/VisionEval/VisionEval-Dev>

    -   Users not familiar with [git](https://git-scm.com/downloads) and GitHub can simply download the repository as a zip file (<https://github.com/VisionEval/VisionEval/archive/refs/heads/master.zip>). In either case, the download is very large (over 900MB compressed download and 3.4GB uncompressed on disk). The Zip file download is shown in the figure below.

    &nbsp;

    -   [![](images/image3.png "fig:")](https://github.com/VisionEval/VisionEval/archive/refs/heads/master.zip)

3.  Start VisionEval by double clicking the `VisionEval.RProj` file in the newly cloned `VisionEval-Source` directory.

4.  Start the build process by entering `ve.build``()` into the console. This will start the process of downloading and installing every R package dependencies required by VisionEval as well as installing the VisionEval framework specific packages. The output will look something like this:

-   This will take a while, potentially over an hour. Once completed, you've successfully performed a full build install of the VisionEval runtime environment.

5.  A new folder called 'built' will be created your source directory, populated with a sub-folder for the R-version you used to build VisionEval with:\\  
    `VisionEval-Source\built\visioneval\<your R version number e.g., 4.1.``3``>\`

-   This will contain a few key folders:

    -   `src`: The VisionEval package source.

    -   `ve-lib`: The package library containing all built and installed R packages.

    -   `runtime`: The built model runtime.

# Common Use Cases

This chapter includes two common use cases:

1.  The first case study example substitutes the default household population data (estimation dataset) with a locally-specific US Census data Public Use Microdata Sample (PUMS) - a valuable way to get your VE model to reflect local conditions - and then rebuilds all the necessary packages reliant on the PUMS data for some of the estimation work.

2.  The second case study example shows how to use different data that is used to build internal VisionEval modules – in this case to adjust future fleet composition information.

**Both Use Cases will identify the differences in rebuilding the package data depending on what type of VisionEval install process that was used.**

## Case Study 1: Using local PUMS data

### What are PUMS?

To summarize, the US Census Bureau provides anonymized data in two general forms:

-   **Aggregated census tables** - These tables provide the total or estimated counts by topic (e.g., total number of persons by age group). The smallest geographic unit are census blocks, but not all data are available at that level.

-   **Disaggregated PUMS** - A sample of individual record-level data for each person or household counted. (e.g., a persons age, gender, employment and the household they belong to.). The smallest geographic unit are Public Use Microdata Areas (PUMAs), which are aggregated areas to protect confidentiality and must include at least 100,000 persons.

Most people are at least somewhat familiar with the US Census and the information they collect. The primary function of the US Census is to collect a count of people living in the United States for federal allocation of political representatives and taxes. However, the US Census has since expanded to include a variety of other useful statistical information regarding demographics and employment. Census data are spatially organized into a hierarchy of sub-divided spatial areas, the smallest of which is called a Census Blocks, which aggregate into Block Groups, Tracts, Counties, and States. See the example figure below:

![Example Census geographic hierarchy](images/image4.png "fig:") 

*source: US Census*

The primary census program is the Decennial Census, which is a comprehensive count collected every 10 years. However, because populations can significantly change within a decade, the American Community Survey (ACS) was created to obtain data at more frequent intervals. Rather than a full census, the ACS collects ongoing samples on a monthly basis. These data are then used to publish statistically adjusted estimates in 1-year, 3-year, and 5-year estimates. 1-year estimates use the most recent data but are the least reliable because the sample is smaller, whereas the 5-year estimate uses data from the previous 5 years. Although not exactly equivalent, the 1- and 5-year estimates are often considered analogous with a 1% and 5% sample of the population.

The summary tables provide the total count of persons, but are aggregated, meaning that it only shows the total number of persons in each topic, but not the combination of topics. For example, we may know the count of people by age group, gender, occupation, and household size; but we do not know the count for a particular combination of those variables, or to which household they belong. For this reason, the US Census Bureau also releases what it calls a Public Use Microdata Sample (PUMS) using sample data from the ACS.

The generalized approach to updating data within a VE package is set out below.

### Instructions

#### Step 1) Gather PUMS and replace data:

In this example we will be replacing the default PUMS data in the VESimHouseholds package with your project specific local PUMS data. Based on how you obtained *VisionEval* navigate to the *src* directory. The source code for this package should be located in the *VESimHouseholds* directory (e.g, `C:/Users/<``user`` ``name``>/Documents/VisionEval``/``src``/``VESimHouseholds`).

Packages will require the data to be in a certain format, and in this case the VESimHouseholds package requires two input data files `pums_households.csv` and `pums_persons.csv`.

##### *A) Download PUMS data*

> US Census data are available from the Census' website (<https://www.census.gov/>), which provides an interface to search, browse, and download Census data in a variety of formats, the most typical being Comma Separated Value (CSV) files. PUMS data can be filtered using the Census data browser, or the entire PUMS tables for States can be downloaded from the legacy FTP website: <https://www2.census.gov/programs-surveys/acs/data/pums/>
>
> The files are named according to file type, (e.g., csv\_), record type ("h" for household or "p" for persons), and then the State abbreviation. For example, `"csv_haz.zip"` are household PUMS data for Arizona. Additional documentation can be found here: <https://www.census.gov/programs-surveys/acs/microdata/access.html>

##### *B) Process PUMS data.*

> VE was originally coded using an older PUMS file, which had slightly different field names and *must be renamed*. A name mapping key is in the table below:

| Table name               | VESimHouseholds field | New PUMS field | Description                               |
|--------------------------|-----------------------|----------------|-------------------------------------------|
| **pums\_households.csv** | SERIALNO              | SERIALNO       | Housing/Group Quarters Unit Serial Number |
|                          | PUMA5                 | PUMA           | 5% Public Use Microdata Area code         |
|                          | HWEIGHT               | WGTP           | Housing unit weight                       |
|                          | UNITTYPE              | TYPEHUGQ       | Type of housing unit                      |
|                          | PERSONS               | NP             | Number of persons living in housing unit  |
|                          | BLDGSZ                | BLD            | Size of Building                          |
|                          | HINC                  | HINCP          | Household Total Income in 1999 US Dollar  |
| **pums\_persons.csv**    | AGE                   | AGEP           | Age                                       |
|                          | WRKLYR                | WKL            | Worked in year                            |
|                          | MILITARY              | MIL            | In military                               |
|                          | INCTOT                | PINCP          | Person's total employment                 |

> Depending on the file, other pre-processing may be required, such as removing NAs or converting categories. For example, missing NA values to 0 in HINC, shifting UNITYPE scale from {1,2,3} to {0,1,2}, or aggregating the 4-level WKL categories into 3-levels of WRKLYR. If these conversions are not made, issues may arise in the package building step.

##### *C) Replace PUMS files*

> Once processing is complete, replace the old files in your *src/VESimHouseholds/inst/extdata* with the new `pums_households.csv` and `pums_persons.csv`. External data for VisionEval packages are typically located in the `inst``/``exdata` folder.

#### Step 2) Package building

The critical objective of re-building a package is to build a package from the package source to the VisionEval environment. This guide uses the RStudio interface and the procedure for rebuilding a single package.

##### *A) Initialize the VisionEval Environment*

> To start the *VisionEval* environment, navigate to your *VisionEval* runtime directory (e.g., `C:/Users/<``user name``>/Documents/VisionEval`) and double click `VisionEval.Rproj`. The RStudio layout should look similar to the figure below (there may be minor differences):
>
> ![Graphical user interface, text, application, email Description automatically generated](images/image5.png)
>
> There are two options for the next step: (B1) using RStudio Build Tools, or (B2) using the R native install command. Instructions for both methods are included in steps B1 and B2 below.

##### *B1) Using RStudio Build Tools*

###### 1) Select Configure Build Tools from the Build menu (image shows an RStudio window)

> ![](images/image6.png)

###### 2) Configure Build tools from the build menu

> i\. From "Project build tools", select "Package" from the drop-down.
>
> ii\. For "Package directory", browse to your source package folder (e.g` ``C:/Users/<``user name``>/Documents/VisionEval``/``src``/modules/``VESimHouseholds`).
>
> ![](images/image7.png)
>
> Click OK. RStudio will flicker and restart.

###### 3) Install from package source

> Click the "Build" drop-down from the main banner menu again. This time there will be new options, select "Install Package".
>
> ![](images/image8.png)

###### 4) Build again

> After one successful build, you must run build again to ensure that the new source data files have been (1) generated and (2) the new data files have been loaded into the VisionEval package.
>
> At this point the new data should now be imported and usable through the VESimHouseholds package. The last step is to test if the updated data is available within the VESimHouseholds package by inspecting the data using the command `VESimHouseholds``::``Hh_df` in the RStudio console.

##### *B2)* *Using R native install command*

> The R command “install.packages” is used to install any R packages. The command
>
> `install.package``(“C:/Users/<user name>/Documents/VisionEval/``src``/modules/``VESimHousehold``s``”``, repos=NULL, type=“source”)`
>
> within VisionEval environment will rebuild and install VESimHouseholds package into *VisionEval*.

##### *C) Update Dependent Packages*

> The final step of incorporating local PUMS data is to update the packages that have in-built estimation processes and uses the PUMS for estimating models. The PredictHousing module from VELandUse package uses PUMS to estimate housing choice model. Thus, it is important to rebuild VELandUse package after rebuilding VESimHouseholds package where the updated PUMS is now available. Follow steps B1) or B2) to rebuild VELandUse package.

**Done!**

## Case Study 2: VEPowertrainsandFuels

There may be scenarios where we may want to study a future fleet mix (penetration of electric vehicles) that is different than the default fleet mix which comes with the VEPowertrainsandFuels package. This was the motivation behind this case study. The updates to the default fleet mix can be done by simply replacing the `hh_powertrain_prop.csv` input file, similar to Case Study 1, with a version customized for the intended study. This input file needs the package to be 'rebuilt' in order to take effect in the *VisionEval* model run. The steps to rebuilding are similar to Case Study 1 and are outlined here.

The input data for the VEPowertrainsandFuels package is in the `VEPowertrainsAndFuels``\``inst``\``extdata``\ `directory. Each of the input files can be updated to reflect changes in the fleet makeup as well as fuel types that the vehicles use. The `hh_powertrain_prop.csv` contains the proportion of household vehicles powertrain types by vehicle type and vehicle vintage year. This case study will present steps on how to update this input file. A more detailed description of the structure and content of the file can be found in the `hh_powertrain_prop.``txt` file in the same directory. The figure below shows where the input file is located within the source code of the VEPowertrainsandFuels package.

![](images/image9.png)

### Instructions

This case study explores the basic level of analysis needed to update the data to ensure integrity and consistency between other data components within the package. Any spreadsheet application can be used to alter the default data values and perform analysis.

This section walks users through a brief analysis that is conducted to define a modifying function and demonstrate the effects if the modifications.

#### Step 1) Data

`VEPowertrainsAndFuels``\``inst``\``extdata``\hh_powertrain_prop.csv` are the default powertrain proportions contained in the package, which resembles the table below (the table is compressed to select years for clarity). The file's purpose is to provide the sales by vehicle powertrain, vehicle type (auto and light trucks), and vehicle vintage year.

| ModelYear | AutoPropIcev | AutoPropHev | AutoPropPhev | AutoPropBev | LtTrkPropIcev | LtTrkPropHev | LtTrkPropPhev | LtTrkPropBev |
|-----------|--------------|-------------|--------------|-------------|---------------|--------------|---------------|--------------|
| 1975      | 1            | 0           | 0            | 0           | 1             | 0            | 0             | 0            |
| 2000      | 1            | 0           | 0            | 0           | 1             | 0            | 0             | 0            |
| 2010      | 0.8786       | 0.1213      | 0            | 0.0001      | 0.9820        | 0.0180       | 0             | 0            |
| 2020      | 0.8212       | 0.0788      | 0.0202       | 0.0798      | 0.9524        | 0.0143       | 0.0067        | 0.0266       |
| 2030      | 0.6676       | 0.0908      | 0.0358       | 0.2058      | 0.9093        | 0.0179       | 0.0106        | 0.0622       |
| 2040      | 0.5701       | 0.0922      | 0.0403       | 0.2974      | 0.8996        | 0.0191       | 0.0114        | 0.0698       |
| 2050      | 0.5198       | 0.0895      | 0.0407       | 0.3500      | 0.8916        | 0.0193       | 0.0119        | 0.0772       |

The table contains two powertrain proportions, the left-most four columns are for automobiles (i.e., `AutoProp`) and the right-most are for light trucks (i.e., `LtTrkProp`). Each will sum up to 1 (for a rowsum of 2).

#### Step 2) Analysis

Here we will conduct a brief exploratory analysis to demonstrate visually what the data look like and how they will be modified. Using standard spreadsheet application we can format and visualize the data as shown in the figure below.

![](images/image10.png)

We can see that battery electric vehicles (BEV), specifically automobiles, are projected to make up the majority of vehicles bought in future years. This causes the share of internal combustion engines to decline proportionally.

Let us assume that the state government is deciding whether to aggressively promote BEV cars starting in 2025. The policies cause the share of alternative powertrains (BEV, HEV, and PHEV) to increase more over time. To model this increase, we will use an arbitrary function which adds to the current value of \$x\$ (i.e., the proportion) at a quadratic rate.

\$\$  
f(x) = x + (x^2) (1 - x)  
\$\$

We use this function to adjust each of the alternative powertrains in the spreadsheet. To ensure that the proportions sum up to 1 for autos and light trucks, respectively, we then calculate the remaining proportion of ICE powertrains by subtracting the total proportion of alternative powertrains. The following figure shows the effect of increasing the share of alternative powertrain at a quadratic rate compared to default data.

![](images/image11.png)

We then update the existing `hh_powertrain_prop.csv` file for the year 2025 and above with the newly calculated values.

#### Step 3) Build Package

Once the data file has been updated you will need to re-build and re-install the VEPowertrainsAndFuels package for VisionEval to use this new fleet mix data.

We can follow the instructions listed in Step 2) of the Case Study 1 to rebuild the package.

Once the package re-build is complete, your new powertrain data will be ready to use in a VisionEval model run.





## Miscellaneous Information

This section contains miscellaneous information that may be useful for more advanced users.

1.  VisionEval Package Structure

2.  Build from command line

3.  PUMS data processing helper scripts

4.  Modifying package code

### VisionEval Package Structure

The source code of VisionEval packages will generally have a structure similar to the following:

    src/VEGenericPackage
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

-   `inst``\``extdata` is where "external" input data sources and reference files will be placed

-   The `R` directory contains any R scripts used in the packages. These must be independent non-sequential scripts that do not depend on results from other scripts.

-   `data` contains the resulting data that VisionEval generates and utilizes.

-   `man` and `inst``\``module_docs`, contain the markdown documentation generated during the build process.

### Build from command line

While the GUI method is intuitive, it can be convenient to simply execute a build command from a generic R session rather than navigating menu trees in the GUI.

The fundamental command to build an r package can be run from R console using `system(``"R ``CMD`` INSTALL ``package_path`` -l ``lib_path``")`. The GUI method essentially constructs this command and executes it.

-   `package_path` is the path to the package source code you are building for e.g. `"C:\Users\<user name>\Documents\VisionEval\src\modules\VESimHouseholds"`. If your working directory is already located in the package, you can use “`.``”` to denote the local directory.

-   `lib_path` is the runtime environment, in this case the VisionEval environment for e.g. `"C:\Users\<user name>\Documents\VisionEval\ve-lib"`:

Here’s an example of a command that is used to rebuild VESimHouseholds package from its source code into *VisionEval*.

    system("R CMD INSTALL "C:\Users\<user name>\Documents\VisionEval\src\modules\VESimHouseholds" -l "C:\Users\<user name>\Documents\VisionEval\ve-lib")

### PUMS data processing helper scripts

Processing PUMS data can be challenging for two reasons.

1.  PUMS data evolves, with some field names and levels changing.

2.  The 2000 PUMS are stored in a compressible serial text file structure, rather a common delimited file (e.g., CSV), making importing tedious.

Below are some helper scripts for future users to build upon:

NOTE: These may not work with all PUMS file years, operating systems, or R versions. Best effort was made to identify weak points (e.g., unzipping), but cannot be guaranteed. These scripts are meant to be a resource to you as a starting point, not a production level code.

### PUMS File import and header processing

    # IMPORTS
    library(data.table)
    library(tools)


    # Function to process PUMS as it is read in
    process_acs_pums <- function(PumsFile, type, GetPumas='ALL') {
      # ACS PUMS to legacy Census PUMS fields
      # Make any modifications here as necessary
      meta = list(
        'h' = list(
          SERIALNO = list(acsname = 'SERIALNO', class ='character'),
          PUMA5 = list(acsname='PUMA', class='character'),
          HWEIGHT = list(acsname='WGTP', class='numeric'),
          UNITTYPE = list(acsname='TYPE', class='numeric'),
          PERSONS = list(acsname='NP', class='numeric'),
          BLDGSZ = list(acsname='BLD', class='character'),
          HINC = list(acsname='HINCP', class='numeric')
        ),
        'p' = list(
          SERIALNO = list(acsname = 'SERIALNO', class ='character'),
          AGE = list(acsname='AGEP', class='numeric'),
          WRKLYR = list(acsname='WKL', class='character'),
          MILITARY = list(acsname='MIL', class='numeric'),
          INCTOT = list(acsname='PINCP', class='numeric')
        )
      )
      
      colNames <- lapply(meta, function(x) sapply(x, function(y) y[['acsname']]))
      colclass <- lapply(meta, function(x) sapply(unname(x), function(y) {
        setNames(y[['class']], y[['acsname']])
      }))


​      
​      
​      if(Sys.info()['sysname'] == 'Windows') {
​        cmd <- paste0("unzip -p '", PumsFile, "'")
​      }
​      
​      if(Sys.info()['sysname'] == 'Linux') {
​        cmd <- paste0("gunzip -cq '", PumsFile,"'")
​      }
​      
    # Checks if it is a zip file or a bytefile
      if(grepl('.zip', PumsFile)) {
        df <- fread(cmd = cmd, 
                    select = names(colclass[[type]]),
                    colClasses = colclass[[type]])
      } else {
        df <- fread(PumsFile,
                    select = names(colclass[[type]]),
                    colClasses = colclass[[type]])
      }
      
      # Rename ACS PUMS fields to match legacy Census PUMS fields
      setnames(df, colNames[[type]], names(colNames[[type]]))
      
      return(df)
    }
    
    process_2000_pums <- function(PumsFile, GetPumas='ALL') {
      #Read in file and split out household and person tables
      Pums_ <- readLines(PumsFile)
      RecordType_ <- 
        as.vector(sapply(Pums_, function(x) {
          substr(x, 1, 1)
          }))
      H_ <- Pums_[RecordType_ == "H"]
      P_ <- Pums_[RecordType_ == "P"]
      rm(Pums_, RecordType_, PumsFile)
      
      #Define a function to extract specified PUMS data and put in data frame
      extractFromPums <- 
        function(Pums_, Fields_ls) {
          lapply(Fields_ls, function(x) {
            x$typeFun(unlist(lapply(Pums_, function(y) {
              substr(y, x$Start, x$Stop)
            })))
          })
        }
      
      #Identify the housing data to extract
      HFields_ls <-
        list(
          SERIALNO = list(Start = 2, Stop = 8, typeFun = as.character),
          PUMA5 = list(Start = 19, Stop = 23, typeFun = as.character),
          HWEIGHT = list(Start = 102, Stop = 105, typeFun = as.numeric),
          UNITTYPE = list(Start = 108, Stop = 108, typeFun = as.numeric),
          PERSONS = list(Start = 106, Stop = 107, typeFun = as.numeric),
          BLDGSZ = list(Start = 115, Stop = 116, typeFun = as.character),
          HINC = list(Start = 251, Stop = 258, typeFun = as.numeric)
        )
      
      #Extract the housing data and clean up
      H_df <- data.frame(extractFromPums(H_, HFields_ls), stringsAsFactors = FALSE)
      #Extract records for desired PUMAs
      if (GetPumas[1] != "ALL") {
        H_df <- H_df[H_df$PUMA5 %in% GetPumas,]
      }
    
      #Identify the person data to extract
      PFields_ls <-
        list(
          SERIALNO = list(Start = 2, Stop = 8, typeFun = as.character),
          AGE = list(Start = 25, Stop = 26, typeFun = as.numeric),
          WRKLYR = list(Start = 236, Stop = 236, typeFun = as.character),
          MILITARY = list(Start = 138, Stop = 138, typeFun = as.numeric),
          INCTOT = list(Start = 297, Stop = 303, typeFun = as.numeric)
        )
      
      #Extract the person data and clean up
      P_df <- data.frame(extractFromPums(P_, PFields_ls), stringsAsFactors = FALSE)
      #If not getting data for entire state, limit person records to be consistent
      if (GetPumas[1] != "ALL") {
        P_df <- P_df[P_df$SERIALNO %in% unique(H_df$SERIALNO),]
      }
    
      return( list('p' = P_df, 'h' = H_df) )
    }

### PUMS data web-scraping

This has been automated one step further by scraping the data and running the above functions on the files as they are read in.


    # Downloads and processes legacy 2000 PUMS data 
    getDecPUMS <- function(STATE, output_dir = NA){ 
      #VARS 
      state_codes <- fread('state.txt') 
      state_codes <- setNames(state_codes$STATE, state_codes$STUSAB) 
      base_url = 'https://www2.census.gov/census_2000/datasets/PUMS/FivePercent' 
       
      if(length(STATE) > 2 & !is.numeric(STATE)) { 
        STATE <- state.abb[match(toTitleCase(STATE),state.name)] 
      } 
      STATE_NAME <- state.name[match(toupper(STATE),state.abb)] 


​       
​      if(!is.numeric(STATE)) STATE_NUM <- state_codes[toupper(STATE)] 


​       
​      # Download the PUMS data to tempfile and load directly to data table 
​      url <- file.path(base_url, 
​                       STATE_NAME, 
​                       paste0('REVISEDPUMS5_', sprintf("%02d", STATE_NUM), '.TXT')) 
​       
​      temp <- tempfile() 
​      download.file(url, temp) 
​       
      # Read .txt to data frames 
      PUMS <- process_2000_pums(temp) 
       
      # SAVE OUTPUT 
      if(!is.na(output_dir)) { 
        if(!dir.exists(output_dir)) dir.create(output_dir) 
        fwrite(PUMS[['p']], file.path(output_dir, 'pums_persons.csv')) 
        fwrite(PUMS[['h']], file.path(output_dir, 'pums_households.csv')) 
      } else { 
        return(PUMS) 
      } 
    } 
     
    # Downloads and processes post-2000 PUMS 
    getACSPUMS <- function(STATE, YEAR='2000', GetPumas='ALL', output_dir, save_zip = T){ 
      #VARS 
      try({ 
        state_codes <- fread('state.txt') 
        state_codes <- setNames(state_codes$STATE, state_codes$STUSAB) 
        }) 
      base_url = 'https://www2.census.gov/programs-surveys/acs/data/pums' 


​       
​      if(length(STATE) > 2 & !is.numeric(STATE)) { 
​        STATE <- tolower(state.abb[match(toTitleCase(STATE),state.name)]) 
​      } 


​      
​      # Download the PUMS data to tempfile and load directly to data table 
​      PUMS <- lapply(c('p', 'h'), function(f) { 
​        url <- file.path(base_url, YEAR, '5-Year', 
​                         paste0('csv_', f, tolower(STATE), '.zip')) 
​         
​        if(save_zip == F){ 
​          temp <- tempfile() 
​        } else { 
​          temp <- file.path(output_dir, basename(url)) 
​        } 
​         
        download.file(url, temp) 
        df <- process_acs_pums(temp, type=f, GetPumas) 
       
        return(df) 
      }) 
      names(PUMS) <- c('p', 'h') 


​       
​      # SAVE OUTPUT 
​      if(!is.na(output_dir)) { 
​        if(!dir.exists(output_dir)) dir.create(output_dir) 
​        fwrite(PUMS[['p']], file.path(output_dir, 'pums_persons.csv')) 
​        fwrite(PUMS[['h']], file.path(output_dir, 'pums_households.csv')) 
​      } else { 
​        return(PUMS) 
​      } 
​    }
