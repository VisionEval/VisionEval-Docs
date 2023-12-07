--- 
title: "VisionEval User Guide"
author: "VisionEval Pooled Fund Team"
date: "2023-12-07"
site: bookdown::bookdown_site
documentclass: book
bibliography: [book.bib, packages.bib]
url: https://visioneval.org/docs
cover-image: "images/cover.png"
description: 
biblio-style: apalike
csl: chicago-fullnote-bibliography.csl
---

# Welcome {-}

This guide contains documentation for users and developers of the VisionEval modeling system. This guide contains a diversity of information intended for different audiences interacting with VisionEval. The table below contains the main sections contained in this guide along, with their descriptions, and should be referenced to identify the sections that will serve the best starting points.

| Section | Description|
|:-------------------|:-----------------------------|
| [Getting Started][Getting Started] | Instructions on getting started with VisionEval on your computer |
| [Concept Primer](#conceptprimer) | A high-level introduction to the concepts and definitions underlying the VisionEval modeling system |
| [VisionEval Tutorial](#tutorial) | Introductory tutorial on how to start applying a VisionEval model, with chapters on [picking a model](#picking-a-model), [model geography](#model-geography-and-years), [inputs](#model-inputs), [validation](#validation-and-troubleshooting), and [scenarios](#developing-scenarios) |
| VisionEval Model Details | Comprehensive and in-depth documentation on the three VisionEval models: [VERSPM](#verspm), [VE-State](#vestate), and [VERPAT](#verpat) |
| [Estimation in VisionEval][Estimation in VisionEval] | Overview of model estimation in VisionEval and instructions to customize model applications |
| [Module Build Process](#ve-buildprocess) | Overview of building a VisionEval package module using custom data |
| [Developer Documentation](#developer) | Information for developers or researchers interested in making contributions to the VisionEval system |
| [API Documentation][API Documentation] | Module documentation from the model source code |
| [Software Framework][Software Framework] | Technical overview of the VisionEval software framework |

## About VisionEval {-}
VisionEval is a collaborative project to build a family of strategic tools for performance-based transportation planning into a single open-source programming framework. Strategic tools are designed to evaluate many alternative futures and policies to help state and metropolitan area governments address pressing issues, despite uncertainty. 

## Why Use VisionEval? {-}
Strategic planning is becoming increasingly important as a means to help state and metropolitan area governments select policies and actions to address pressing issues that are fraught with uncertainty. More specifically, Federal direction has challenged state, regional, and local transportation agencies with measuring the outcomes of decisions through performance-based planning, including considering how transportation solutions may impact future goals such as sustainability, health, and mobility. Further complicating matters, plans need to be resilient to changing transportation and land use trends and the implications of emerging technologies and constraints. VisionEval is an open source common framework building on the successful GreenSTEP family of strategic planning tools that is intended to address these needs.

VisionEval merges this family of tools into an open-source project with a supporting community forum of partner agencies and others sharing in its use and enhancement. The goal is to support a broad array of potential tool uses and enable pooled enhancements expanding the types of outcomes measured or refine the specificity of transportation and land use solutions considered. The work to date draws from successful past and interested future users nationally, who will both define the policy needs and uses of these tools, and set their direction moving forward.

## How to Use this Guide {-}
This guide contains a diversity of information intended for different audiences interacting with the VisionEval system. Use the list below to try to identify what kind of user you are and the sections of this guide that will serve the best starting points.

**Decision-maker & semi-technical planner:** You are interested in applying the VisionEval system but want a high-level overview and not the technical details.

* [Concept Primer](#conceptprimer): An introduction to the concepts underlying the VisionEval modeling system and how it can be used to support transportation planning efforts, without technical model details.

**Model applier:** You are wanting to learn about the VisionEval system and implement a model application.

* [Getting Started][Getting Started]: Instructions on how to get VisionEval installed and running
* [Concept Primer](#conceptprimer): An introduction to the concepts underlying the VisionEval modeling system and how it can be used to support transportation planning efforts, without technical model details
* Tutorials: Start with VisionEval Tutorial 101 for an introduction to start applying a VisionEval model, followed by referencing more in-depth tutorial materials on the [VERSPM](#verspm), [VERPAT](#verpat), and [VE-State](#vestate) models.

**Developer:** You are a developer or researcher and interested in making contributions to the VisionEval system.

* [Developer Documentation](#developer)



