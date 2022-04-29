# Developer Documentation {#developer}

## Developer Orientation

### Assumptions + prerequisites
  - Understand [[R|https://cran.r-project.org]]
  - Understand basic statistics, data analysis, and modeling principles
  - Understand how to build [[R packages|https://support.rstudio.com/hc/en-us/articles/200486488-Developing-Packages-with-RStudio]]
  - Understand how to use GitHub and [[TravisCI|https://travis-ci.org/]]
  - Understand [[RShiny|https://shiny.rstudio.com]] and [[shinytest|https://github.com/rstudio/shinytest]] if contributing to the User Interface

### Get VisionEval running
  - Use the [[Quick Start|Getting-Started]] guide to download and run an example

### Understand the development principles and organization of VisionEval framework

  - Review [[System Design Documentation|https://github.com/visioneval/VisionEval/blob/master/api/model_system_design.md]] 
  - Review [[Contribution Criteria|Contribution-Review-Criteria]]

### Skim useful references to know about
  - VE [[style guide |https://github.com/visioneval/VisionEval/blob/master/api/Coding_Guidelines.md]]
  - GitHub repo [[processes / branching and versioning plan | Working-Together]]
  - [[Testing requirements, test data, and running tests|Automated-Testing]]
  - Developer [[roadmap|Development-Roadmap]]
  - Organization and naming of packages and modules, see [[VE Name Registry|https://github.com/visioneval/VisionEval/blob/master/sources/modules/VENameRegistry.json]] [ Status: to be developed ]
  - Original GREENSTEP [[documentation | https://github.com/gregorbj/RSPM/blob/master/Version_3.5/Documentation/GreenSTEP-RSPM_Documentation_20151220.docx]]
  - Organization of data store and test data, see [[VE Name Registry|https://github.com/visioneval/VisionEval/blob/master/sources/modules/VENameRegistry.json]] [ Status: to be developed ] 
  - List of useful functions in the API for developers [ Status: to be developed; see [[API|https://github.com/visioneval/VisionEval/tree/master/api]] for now ]

### Go thru relevant Package Development Tutorials
  - Vignette for adding a module to existing package [ Status: needs to be developed ]
  - Vignette for making changes to existing module [ Status: needs to be developed ]

### Understand licensing

  - VisionEval uses this [LICENSE](https://github.com/visioneval/VisionEval/blob/master/LICENSE)
  - Each package has a DESCRIPTION file and a LICENSE file
  - The source files do not contain license and/or copyright information

## Contribution Guidelines 

When contributing to VisionEval, the set of [questions](#review-criteria) below will be asked of the contribution.  These review criteria help ensure contributions to VisionEval satisfy the [Goals and Objectives](https://github.com/visioneval/VisionEval/wiki/Goals-and-Objectives-of-VisionEval-Model-System) of the system.  Make sure to review the [[Developer Orientation|Developer-Orientation]] before making a submittal.  Questions are categorized by review type.  The automated test system also provides some helpful information where identified.

### Review Process
To submit a contribution for review, issue a pull request with a comment introducing your contribution.  The comment should include a brief overview, responses to the [questions](#review-criteria), and pointers to related information.  The entire submittal should ideally be self contained so the documentation of the methods should be in the R package as well.  The Repository Manager and [[Review Team|Review-Team-Charter]] Chair will handle the review request, comment on each question, complete the [feedback](#feedback) form, and reply to the pull request.  Its a good idea to setup a pre-submittal meeting to discuss questions and better understand expectations. See the [example submittal and review](Example-Review) for more information.

### Review Criteria
| Review Question                                                                                      | Test System Help      | Review Team - Software | Review Team - Documentation | Review Team - Methods |
|--------------------------------------------|-----------|-----------|-----------|-----------|
| 1. **Consistent with Design Specs**. Does it contain all the elements that are required by the VisionEval [system specifications](https://github.com/visioneval/VisionEval/blob/master/api/model_system_design.md)?  To help ease maintenance of VE, it is recommended to minimize the use of new R libraries, and to reuse R libraries used by existing VE modules when possible.|        | x                  | x                           | x                     |
| 2. **Valid Theory and Methods**. Why is it better, and/or different than [existing modules](https://github.com/visioneval/VisionEval/tree/master/sources/modules)? Does it do good science and provide documentation justifying this claim? Is it consistent with good practice in strategic modeling? How might it overlap with [existing modules](https://github.com/visioneval/VisionEval/wiki/Modules-and-Packages)?  How does it fit within the VE ecosystem of modules? If multiple functions, documentation summarizing the functions and their variables is recommended ([example submittal and review](Example-Review)) |                                |                        | x                           | x                     |
| 3. **Documentation**. Is the module documentation complete? Does it include documentation of model estimation, algorithms, and instructions for using?                                                                                                                                                                                                                                                                                     |                                |                        | x                           | x                     |
| 4. **Regional Estimation Ready** (if applicable). If the module allows the estimation of regional parameters, does it provide default data, does it have clear documentation of what the estimation data needs to be and how it is to be formatted, and does it include proper data specifications to ensure that the user's input data are correct?                                                                                                                   |                                | x                      | x                           | x                     |
| 5. **Geography**. Is it based on geographic definitions that are consistent with the model system definitions?                                                                                                                                                                                                                                                                                                                          |                                |                        | x                           | x                     |
| 6. **Runtime**. Does the module compute quickly enough and provide documentation justifying this claim?                                                                                                                                                                                                                                                                                                                               |                                | x                      | x                           |                       |
| 7. **Complete Code and Data**. Does it includes all source files and data?  If a contributed module does not include all source data, it should include a minimal example data file for testing and so it is clear what data structure is needed to run the module.  It should also include clear instructions on how to fetch the data and/or a clear explanation of why non-included data is confidential and contact information for data owners. | x                              | x                      | x                           |                       |
| 8. **Non-R code** (if applicable). Does the module only call R code and packages that work on all operating systems? If the code includes any non-R code (e.g. FORTRAN, C++) will that code compile on all operating systems?                                                                                                                                                                                                                            | x                              | x                      |                             |                       |
| 9. **License**. Is it licensed with the VisionEval [license](https//github.com/visioneval/VisionEval/blob/master/LICENSE) that allows the code to be freely distributed and modified and includes attribution so that the 'provenance' of the code can be tracked?  Does it include an official release of ownership from the funding agency?                                                                                                                                                                       | x                              |                        |                             |                       |
| 10. **Framework**. Does it only interact with the computing environment by returning a properly structured list to the framework (i.e. it does not modify the global environment, does not read or write files, and only calls framework functions that are allowed)?  Does it pose any security risk to the user (i.e. if applicable, it uses unsecured methods for authentication?)                                                                                                                                                                    | x                              | x                      |                             |                       |
| 11. **Pass Automated Tests**. Does it include regression tests to enable checking that consistent results will be returned when updates are made to the framework and/or R programming environment?                                                                                                                                                                                                                                                 | x                              | x                      |                             |                       |
| 12. **Sufficient Automated Test**s. Does it include [sufficient test coverage](Automated-Testing) and test data? Does it pass the [`testModule`](https://github.com/visioneval/VisionEval/blob/master/api/functions_summary.md#testmodule) test which validates that it will run correctly in the model system?  If possible, does it test against the existing RVMPO example?                                                                                                                                                                                                                                                           | x                              | x                      |                             |                       |
| 13. **Other**. Any other comments? Such as implementation issues (e.g., impact on other modules or the VisionEval framework, changes to automated testing, confidential or oversized data issues), or suggestions for changes to improve developer experience with VisionEval.                                                                                                                                                                                                                                                          |                               | x                      |   x                          |     x                  |

### Feedback
The Review Team will provide feedback for each review criteria above and tag each submittal category as follows:

| Status                         | Software | Documentation	| Methods | 
|--------------------------------|----------|-------------------|---------|
| Accept                         |          |                   |         |
| Accept but recommend revisions |          |                   |         |
| Do not accept                  |          |                   |         |
| Abstain                        |          |                   |         |


## Changelog for New Versions

When releasing a new version of VisionEval, we will:


1. Include the significant changes in the release notes template below
2. Record the significant changes in the changelog here

### Release Notes Template
For [releases](https://github.com/VisionEval/VisionEval/releases)
Make updates where marked with `**`

If there are changes to inputs that users need to know, make a note of that.
Make a note of which models a given new or updated module has been tested with.

```
Packaged versions of the VisionEval framework are provided as .zip files. Each has an installation .bat file for Windows to automatically prepare the R environment.

These installers are packaged for R versions from **3.5.1 to 3.6.1**.

This release includes the following changes:
**
- Change 1
- Change 2
- Change 3
**

Instructions for Installing
Install one of the supported R versions using its default options (R **3.5.1 to 3.6.1**). Make sure to leave the box checked that offers to add R to the Windows registry.
Download the corresponding installer .zip file
Unzip the downloaded installer into an empty folder of your choice
Double-click “VisionEval.bat” (this is the standard entry point – use it every time to start VisionEval)
a. If VisionEval has not run before, the batch file and associated script will set up a few pointers and the convenience functions (see below)
b. Otherwise, it will move straight to step 5.a below
A command window will briefly appear followed by one of these:
a. RGUI with the “Welcome to VisionEval!” message (you’re good to go)
b. Your default browser pointing at the R download page (if you forgot to do step 1 or if you picked the wrong version) – just redo step 1 or steps 2/3 to get them consistent
The previous instructions for launching VEGUI, VERPAT, etc. remain the same.
a. vegui() starts VEGUI
b. verpat() runs VERPAT in RGUI
c. verspm() runs VERSPM in RGUI
d. Note that there’s no helper function to run VESTATE from the command line yet – that will be added to the installation in a future release. You can just setwd() to the VE-State folder under “models” and then source(‘Run_Model.R’).
```

### Changelog

| Version | Changes         |
| --------|-----------------|
| 0.1     | Initial release |
| 0.1.1   |  Numerous updates to VELandUse and other modules              |
| 1.0     |  Added `ve.export` <br> Fixed bugs in unit conversions <br> Fixed issue with Azone file order dependence <br> |
| 1.0.1   |                 |
|         |                 |


## Testing Strategies

The VisionEval model system and design of the framework software incorporates a number of features that facilitate automated testing to assure that modules will work within the system. Perhaps the most significant feature is the 'data typing' system that requires modules to completely specify all data that the module handles in some fashion: as model inputs, as data fetched from the common datastore, and as data that is output to be saved in the common datastore. These data specifications establish 'contracts' that assure data consistency and the framework software includes a number of functions that use the specifications to check consistency. These functions help to ensure that modules will work properly together. 

Following are some of the checks that are done:
  - Input data are checked against input data specifications;
  - Input data geography is checked against specified model geography;
  - Module specifications are checked for correctness;
  - Module specifications for data to be fetched from the datastore are checked against the specifications for the data stored in the datastore; and,
  - Module outputs are checked for consistency with the module specifications for those outputs.

Because of these checks and related checks, it is possible to automate a number of tests that allow a module developer to test that their module (when supplied with suitable test inputs) will work in the VisionEval model system. These checks are carried out by the 'testModule' function. In addition, this test can be run automatically when the package is built, enabling the developer to check at built time that the module works and the correctness to be checked as when the package is added to the VisionEval repository.

The data specification system also enables a model to be thoroughly checked before it is run. This will greatly reduce, if not eliminate, model runtime crashes. This is done by the 'initializeModel' function. The function checks:

  - Whether all module packages are installed, those packages contain the identified modules, and all module specifications are correct (have required attributes);
  - Specified model geography and consistency of model inputs with the geography;
  - Whether model inputs are consistent with specifications; and,
  - Whether every module when it is called will have the data it needs to run (either in specified input files or the datastore) and whether the attributes of those data are consistent with the specifications for the module.

These checks that are built into the framework software make it possible to implement automated checking of VisionEval module packages and VisionEval model whenever a module package and/or model is added to or modified in the VisionEval repository. 

### UI Testing
VEGUI is an application that allows a user to run various VisionEval models. VEGUI is tested using shinytest to ensure its functionality and its usability. Multiple test scripts are written to test different functionalities. Following is a list of tests currently implemented:

- [open_test](https://github.com/VisionEval/VisionEval/blob/develop/sources/VEGUI/tests/opentest.R): Checks if VEGUI opens and closes without any glitch,
- [run_verpat_model_test](https://github.com/VisionEval/VisionEval/blob/develop/sources/VEGUI/tests/run_verpat_model_test.R): Checks if VEGUI opens, runs a VERPAT model, collects all the results, and closes properly.

A test requires a set of expected results (images or json) to make comparisons and draw conclusions. A test is successful if it finishes. A failed test will prompt the user with the differences compared to the expected results.
The main test script [run_vegui_test](https://github.com/visioneval/VisionEval/blob/develop/sources/VEGUI/run_vegui_test.R) serves has a host and makes call to all the aforementioned tests.

The following steps describe a process to create a new test and/or the expected results:
 - Use [test_template](https://github.com/visioneval/VisionEval/blob/develop/sources/VEGUI/tests/test_template.R) as a template to write your own script;
 - Set the parameter `createExpectedResults` in the main test script [run_vegui_test](https://github.com/visioneval/VisionEval/blob/develop/sources/VEGUI/run_vegui_test.R) to TRUE (this will allow a user to create a new set of expected results);
 - Source the new test script in [run_vegui_test](https://github.com/visioneval/VisionEval/blob/develop/sources/VEGUI/run_vegui_test.R);
 - Run [run_vegui_test](https://github.com/visioneval/VisionEval/blob/develop/sources/VEGUI/run_vegui_test.R) to save the expected results;
 - Set the parameter `createExpectedResults` in the main test script [run_vegui_test](https://github.com/visioneval/VisionEval/blob/develop/sources/VEGUI/run_vegui_test.R) to FALSE;
 - Run [run_vegui_test](https://github.com/visioneval/VisionEval/blob/develop/sources/VEGUI/run_vegui_test.R) to ensure that the test finishes successfully.

### Test System
[TravisCI](https://travis-ci.org/) services are used to automatically test all modules and models to assure that they work properly.  Here are a few details on the test system:
  - Tests automatically run with every commit and the pass/fail status is at the bottom of the README as [rendered by GitHub](https://github.com/visioneval/VisionEval/tree/develop)
  - The current Travis build and test script is [here](https://github.com/visioneval/VisionEval/blob/develop/.travis.yml), which includes all the steps to install, build, and run all the VE resources.  To add a new module or model, add an additional line to the `env` property for the module or model.  This will result in an additional parallel build process using Travis' [build matrix](https://docs.travis-ci.com/user/customizing-the-build/#Build-Matrix).  Example environment variables are:

    - FOLDER=sources/modules/VELandUse (folder location relative to the root; note framework, modules, and models are fixed)
    - SCRIPT=tests/scripts/test.R (test script to run, which is required by the VisionEval specification)
    - TYPE=module (either module or model)
    - DEPENDS=VE2001NHTS,VESimHouseholds (list of packages required to run this module or model)
    
  - The build logs, which are helpful when errors happen, are [here](https://travis-ci.org/VisionEval/VisionEval/builds/)
  - Mysterious failures sometimes happen. If the log reports a substantive error (e.g. missing documentation, missing package), the problem probably lies in a damaged cache.  See the next item, and the following that describes how to delete the cache.
  - VE testing with Travis makes use of [caching](https://docs.travis-ci.com/user/caching/) due to Travis' [job time limit](https://docs.travis-ci.com/user/customizing-the-build#Build-Timeouts).  In order for all the jobs to complete within the time limit, installation of the package dependencies need to be done from the cache (rather than from source).  The caches are built in the first stage of the tests, and then modules are built and tested using the cached contents.
  - To delete a Travis cache (if you suspect it might be causing problems), go to the failed build entry via your Dashboard or list of recent build attempts and open the failed build. Look for the "More Options" menu in the upper right, choose "Caches" and find the cache associated with the branch whose build failed. Hit the "garbage can" icon on the right to delete it.  Then you can return to the build and push the "Restart Build" button.

## Add or Modify a Package
