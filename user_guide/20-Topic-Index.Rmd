# VisionEval Topic Index {#topic-index}

Here are detailed descriptions of the documentation available in the VisionEval book.

## End User Documentation {-}

1. Introduction to VisionEval
   a. [Getting Started][Getting Started]
   a. [Quick Setup](#installation)
   b. [In Depth Setup](#detailed-installation)
   a. [Walkthrough](#walkthrough)
1. [Concept Primer](#conceptprimer)
1. [Setting up your own VisionEval model](#tutorial)
   a. Selecting a Model
   b. Building model inputs (general)
   c. Building scenarios
1. Details on the three main models in VisionEval
   a. VERSPM
   b. VE-State
   c. VERPAT
1. VisionEval module reference (User level; module by module)
   a. Model Script and Modules
   a. Module
   b. Inputs and Outputs
   b. module_docs
   b. Rebuilding Packages (PUMS, PowertrainsAndFuels
1. VEModel Framework API
   a. visioneval.cnf environment (cascading)
   a. Model setup
      i. Geography and extra fields, deflators, units and display units
      i. Model scripts (structure, runModule parameters)
      i. Inputs (including search path and scenarios)
      i. Stages (including StartFrom and BaseScenario)
      i. Scenarios (Manual and category combinations)
   b. Results / Exporting
      i. Results (including Logs, ModelState_ls and Datastore)
      i. Outputs
   c. Queries
      i. Designing (with examples)
      i. Running and exporting
   d. R Visualizer

## Developer Documentation {#developer}

1. Repository Structure and Build Tools
   b. Github and Development Environment Tutorial
      i. Cloning and building tutorial
      i. Directory tree of sources in Git repository
      i. Where built stuff goes
   b. Development Environment in depth
      i. Directories
      i. ve.build / ve.run / ve.test
      I. Build scripts, config, components
      i. Make from command line, Makefile
   c. Startup scripts
      1. launch.bat / .Rprofie
      1. VisionEval.R
      1. build/VisionEval-dev.R
2. Debugging VisionEval
   a. Debug tools
      1. Post-mortem with Load Model
      1. R debugger (with 'src' for modules)
      1. ve.test(pkgLoad=TRUE), for framework only
   b. VESnapshot
2. VisionEval Framework 3.0
   a. Oveview of how it works
      1. Model Running
      1. Packages versus Modules
      1. Model Script Structure
   a. Module Structure (for module developers)d
      i. Specifications
      i. Module Function
      i. Estimation / Package Data
      i. Module Docs
   a. visioneval package
      1. Source Files
      1. Functions
      1. Function Interdependencies / Workflows
   b. VEModel package
      1. Source Files
      1. How VEModel functions work / relate to `visioneval` framework
