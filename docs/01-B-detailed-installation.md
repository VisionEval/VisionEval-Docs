# Detailed Installation {#detailed-installation}

Selecting an Installation Strategy
----------------------------------

When you install VisionEval, you need to choose whether do do an [End-User Version](#End-User Installation) or to set up a full [Development Environment](#development-environment)?

Here are some considerations:

- The End-user version is easier to install and has fewer requirements. It is also the place to start if you are new to VisionEval.
- The Developer version lets you stay up-to-the-minute on new changes, and also to make
  changes to the software yourself (if you're up for that)
- You can install both and go back and forth if you like (especially if you create a [Production Environment](#production-environment)).

Setting up a [Production Environment](#production-environment) will let you keep all your models in their own folder
separate from where the VisionEval code resides. Use a Production Environment to avoid having to move your
models when you upgrade to a new VisionEval version. A Productrion Environment also makes it easier to keep your models
backed up without having to copy gigabytes of VisionEval code

### Recommended installation workflow:

  1. Do an [End User Installation](#enduser-installation)
     - That's all you need if you're just trying it out and running the walkthrough tutorials
  2. Set up a [Production Environment](#production-environment) for your own model
     - Start by connecting the Production Environment to the End User Installation
  3. Add a [Development Installation](#development-environment) to build VisionEval on your own
     - "Development Light" ('`src`' installation within your End User installation)
     - Full Development Version (Github)
       - The Full Development Version lets you stay current with the most recent VisionEval development.
       - You'll need to build the Full Development Version before you can run your model.
       - See the separate instructions on how to use the Full Development Version.
  4. Re-connect your Production Environment to the Development Installation
  5. When you get a new version of VisionEval, update `VE_RUNTIME` and `VE_HOME` in the .Renviron
     files to link the new VisionEval to your Production Environment

<a name='enduser-installation'>End-User Installation</a>
--------------------------------------------------------

- Install R itself
  - R does not require administrative permission to install
  - Pick a supported R version
    - If you already have R installed, make sure VisionEval is available for your R version.
    - You can have multiple R versions installed on your computer
    - Choose R 4.3.1 if you haven't already chosen for other reasons
    - You can download a specific supported version using the following links:
      - R 4.1.3: [https://cran.r-project.org/bin/windows/base/old/4.1.3](https://cran.r-project.org/bin/windows/base/old/4.1.3)
      - R 4.2.3: [https://cran.r-project.org/bin/windows/base/old/4.2.3](https://cran.r-project.org/bin/windows/base/old/4.2.3)
      - R 4.3.1: [https://cran.r-project.org/bin/windows/base/old/4.3.1](https://cran.r-project.org/bin/windows/base/old/4.3.1)
- Install RStudio (optional; administrative permission required)
  - Get the latest version here: [https://posit.co/download/rstudio-desktop/](https://posit.co/download/rstudio-desktop/)
    - RStudio is now (November 2022) being maintained and distributed by a new company called "Posit" (the same key people are involved)
  - Start RStudio
  - If RStudio doesn't find your desired R version automatically, connect it to the version of R you want to use for your VisionEval installation
    using the RStudio `Tools / Global Options` menu item
- Download the VisionEval installer for your version of R
  - These are hosted in the VisionEval-dev repository in the "releases" section
  - VisionEval is available for these R versions (September 26, 2023):
    - R 4.1.3: [https://github.com/VisionEval/VisionEval-Dev/releases/download/VE-3.0.4/VE-3.0-Installer-Windows-R4.1.3_2023-09-25.zip](https://github.com/VisionEval/VisionEval-Dev/releases/download/VE-3.0.4/VE-3.0-Installer-Windows-R4.1.3_2023-09-25.zip)
    - R 4.2.3: [https://github.com/VisionEval/VisionEval-Dev/releases/download/VE-3.0.4/VE-3.0-Installer-Windows-R4.2.3_2023-09-25.zip](https://github.com/VisionEval/VisionEval-Dev/releases/download/VE-3.0.4/VE-3.0-Installer-Windows-R4.2.3_2023-09-25.zip)
    - R 4.3.1: [https://github.com/VisionEval/VisionEval-Dev/releases/download/VE-3.0.4/VE-3.0-Installer-Windows-R4.3.1_2023-09-25.zip](https://github.com/VisionEval/VisionEval-Dev/releases/download/VE-3.0.4/VE-3.0-Installer-Windows-R4.3.1_2023-09-25.zip)
  - Visit this page to check for newer releases:
    - [https://github.com/VisionEval/VisionEval-Dev/releases](https://github.com/VisionEval/VisionEval-Dev/releases)
  - "Ignore the source, Luke". You can find out about the PackageSources zip files in the [Development Installation](#development-environment) section
- Unzip the installer
  - On Windows, it is best NOT to install VisionEval in your "Documents" folder because of how Windows redirects access to it
  - A better location would be in your `%USERPROFILE%` (same place R probably went if you did a non-administrative installation...)
  - To find your User Profile folder:
    - Press the Windows key
    - Type "%USERPROFILE%" and hit enter (File Explorer will open, showing you the folder)
    - Use 'New Folder' to create the folder for the installation
  - You can use a standalone unzipper (e.g. SecureZip or 7zip) or Windows itself will let you use the zip file
    as a folder so you can open it, then highlight and copy everything inside it to your installation location.
- To complete the installation, start R from the place you installed VisionEval
  - Double-click VisionEval.Rproj
    - You can use the "launch.bat" script to avoid having to install RStudio
    - launch.bat requires the R_HOME user environment variable to be set (or for R to be found in %USERPROFILE% or another well-known location)
  - If everything is working, an R console window will open where you can type instructions for VisionEval
  - The "Welcome to VisionEval!" message should appear
  - Return to the Getting Started page for how to run VisionEval and to use the walkthrough to explore VisionEval models and features.

<a name='production-environment'>Setting up a Production Environment</a>
------------------------------------------------------------------------

- Where should I put my own model?
  - By default, VisionEval looks for models in the "models" folder of the VisionEval runtime
  - In production, that's a problem because you will need to move the model setups every time you change
    the version of R or VisionEval
  - You can save headaches by setting up a separate folder for your models (VE_RUNTIME)
- For production use (i.e. in the "real world") it is best to put your VisionEval models in a separate
  folder
- The VisionEval startup code knows about two locations:
  - VE_HOME, which is where the VisionEval application code is located
  - VE_RUNTIME, which is where the "models" folder is located
  - These can be entirely different folders on different drives
  - Out of the box, VE_HOME and VE_RUNTIME are both the same, and they point to the folder
    where you unzipped VisionEval
- Decide how you would like to start VisionEval
  - You can start from VE_HOME
  - Or, you can start from VE_RUNTIME
  - Or you can set up both and see what works for you
  - We suggest staring from VE_RUNTIME, since it is then easier to update your R or VisionEval version
    (You don't need to remember which installation to visit to start)
- To start from your installation directory using a different VE_RUNTIME location
  - The first thing to do is decide where you want your VisionEval runtime (VE_RUNTIME)
  - Create a folder (e.g. %USERPROFILE%/VE_Models)
  - Go to your VisionEval installation and open the .Renviron file
    - if that file does not exist, please start your VisionEval installation once using VisionEval.Rproj or launch.bat,
  - Using your favorite text editor (or Notepad, which is nobody's favorite but does work), add this line with the
    directory adjusted to the place you created the new runtime folder:
      VE_RUNTIME=C:/Users/MyUserProfileDirectory/VE_Models
  - Now when you start VisionEval, you'll see that it is running in the folder you assigned to VE_RUNTIME
    - You'll also notice that there is now an empty "models" directory created when you ran VisionEval for the first time
- You can move some of the runtime support files over to your new VE_RUNTIME if you like
  - Consider moving just these files and folders to have access to tutorial and support tools
    - tools
    - walkthrough
- To start from within your VE_RUNTIME, you need to copy some files from the installation runtime and add a line to .Renviron
  - Copy these runtime files from your installation directory to your VE_RUNTIME:
    - launch.bat
    - .Rprofile
    - .Renviron
    - VisionEval.Rproj
    - visioneval.cnf.sample (OPTIONAL)
  - If you do not have an end user installation (just the development environment from Github),
    you need to do the following first:
    - Build visioneval (see the section on setting up a development environment and building VisionEval)
    - Get the runtime files from "MyVisionEval-Github-clone/built/visioneval/4.3.1/runtime")
  - Do NOT move the following files and folders (it won't hurt, but it just wastes disk space and is confusing):
    - ve-lib
    - VisionEval.R
    - LICENSE
  - Do NOT delete the original runtime folder (the startup script requires it)
  - Edit .Renviron to add this line (you can use either kind of slash: / or \\ )
      VE_HOME=c:/My/Installed/VisionEval
  - If VE_HOME points into a development environment
    - VE_HOME should be the location of the Git root directory (NOT the built runtime)
    - It will still work if you  point VE_HOME at the built runtime, you just won't have access
      to the developmment environment tools.
