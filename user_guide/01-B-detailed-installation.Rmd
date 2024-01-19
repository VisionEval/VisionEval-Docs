# Detailed Installation {#detailed-installation}

Selecting an Installation Strategy
----------------------------------

When you install VisionEval, you need to choose whether to perform an [End-User Installation](#enduser-installation)
or to set up a full [Development Environment](#development-environment)?

Here are some considerations:

- The End-user version is easier to install and has fewer requirements. It is also the place to start if you are new to VisionEval.
- The Developer version lets you stay up-to-the-minute on new changes, and also to make
  changes to the software yourself (if you're up for that)
- You can install both and go back and forth if you like (especially if you create a [Production Environment](#production-environment)).

Setting up a [Production Environment](#production-environment) will let you keep all your models in their own folder
separate from where the VisionEval code resides. Use a Production Environment to avoid having to move your models when
you upgrade to a new version of VisionEval or R. A Production Environment also makes it easier to keep your models
backed up (without having to copy gigabytes of VisionEval code), and straightfoward to create a Github repository just
for your model.

### Recommended installation workflow:

  1. Do an [End User Installation](#enduser-installation)
     - That's all you need if you're just trying it out and running the walkthrough tutorials
  2. Set up a [Production Environment](#production-environment) for your own model
     - Start by connecting the Production Environment to the End User Installation
  3. Add a [Development Installation](#development-environment) to build VisionEval on your own
     - You can just do "Development Light" ('`src`' installation within your End User installation) if you are re-creating certain packages
       ([Instructions Here](#ve-buildprocess))
     - Or you can do a Full Development Version (Github)
       - The Full Development Version lets you stay current with the most recent VisionEval development.
       - You'll need to build the Full Development Version locally before you can run your model.
     - Re-connect your Production Environment to the Development Installation when you're ready
  5. When you get a new version of VisionEval, update the links in your Production environment
     - `VE_RUNTIME` to `.Renviron` in your VisionEval Home (i.e. where VisionEval code is)
     - `VE_HOME` to `.Renviron` in your VisionEval Runtime (i.e. where your VisionEval models are)

Full instructions are found below.

<a name='enduser-installation'>End-User Installation</a>
--------------------------------------------------------

1. Install R. Pick a recent version for which an installer exists
    - R does not require administrative permission to install
    - Pick a supported R version
        - If you already have R installed, make sure VisionEval is available for your R version.
        - You can have multiple R versions installed on your computer. Just make sure you use one that is consistent with the VisionEval code you have installed.
        - Choose the latest suppored R (R 4.3.2 as of January 2024) if you haven't already chosen for other reasons
        - You can download a specific supported version of R (as of January 2024) using the following links:
            - R 4.1.3: [https://cran.r-project.org/bin/windows/base/old/4.1.3](https://cran.r-project.org/bin/windows/base/old/4.1.3)
            - R 4.2.3: [https://cran.r-project.org/bin/windows/base/old/4.2.3](https://cran.r-project.org/bin/windows/base/old/4.2.3)
            - R 4.3.2: [https://cran.r-project.org/bin/windows/base/old/4.3.2](https://cran.r-project.org/bin/windows/base/old/4.3.2)

1. Install RStudio.
    - You don't need RStudio to run VisionEval, but many people find it helpful. If your computer is locked down, you won't be able to install it as it requires administrative permissions.
    - Get the latest version here: [https://posit.co/download/rstudio-desktop/](https://posit.co/download/rstudio-desktop/)
        - RStudio is now (November 2022) being maintained and distributed by a new company called "Posit" (the same key people are involved)
    - Start RStudio and check that it is using your intended version of R. The startup message in the console window will show the R version, or you can display the built-in variable `R.version` and look at the `version.string`
    - If RStudio doesn't find your desired R version automatically, connect it to the version of R you want to use for your VisionEval installation using the RStudio `Tools / Global Options` menu item

1. Download the VisionEval installer for your version of R
    - These are hosted in the [VisionEval-dev](https://github.com/visioneval/VisionEval-dev/releases) repository in the "releases" section
    - The latest development release is always located at [https://github.com/VisionEval/VisionEval-Dev/releases/latest](https://github.com/VisionEval/VisionEval-Dev/releases/latest)
    - VisionEval is available for these R versions (January 5, 2024):
        - R 4.1.3: [https://github.com/VisionEval/VisionEval-Dev/releases/download/VE-3.1/VE-3.0-Installer-Windows-R4.1.3_2023-09-25.zip](https://github.com/VisionEval/VisionEval-Dev/releases/download/VE-3.1/VE-3.0-Installer-Windows-R4.1.3_2023-09-25.zip)
        - R 4.2.3: [https://github.com/VisionEval/VisionEval-Dev/releases/download/VE-3.1/VE-3.0-Installer-Windows-R4.2.3_2023-09-25.zip](https://github.com/VisionEval/VisionEval-Dev/releases/download/VE-3.1/VE-3.0-Installer-Windows-R4.2.3_2023-09-25.zip)
        - R 4.3.2: [https://github.com/VisionEval/VisionEval-Dev/releases/download/VE-3.1/VE-3.0-Installer-Windows-R4.3.1_2023-09-25.zip](https://github.com/VisionEval/VisionEval-Dev/releases/download/VE-3.1/VE-3.0-Installer-Windows-R4.3.2_2023-09-25.zip)
    - Visit this page to check for newer releases: [https://github.com/VisionEval/VisionEval-Dev/releases](https://github.com/VisionEval/VisionEval-Dev/releases)
    - "Ignore the source, Luke." You can find out about the PackageSources zip files in the [Build Process](#ve-buildprocess) section

1. Unzip the installer into a new folder
    - On Windows, it is best NOT to install VisionEval in your "Documents" folder because of how Windows redirects access to that folder.
    - A better location would be in your User Profile that Windows refers to as `%USERPROFILE%`
    - To find your User Profile folder:
        - Press the Windows key
        - Type "%USERPROFILE%" and hit enter (File Explorer will open, showing you the folder)
        - Use 'New Folder' to create the folder that will hold the unzipped VisionEval installation
    - You can use a standalone unzipper (e.g. SecureZip or 7zip) to extract the VisionEval installer. Windows itself will let you use the zip file
      as a folder so you can open it (double click in Windows explorer), then highlight and copy everything inside it to your installation location.
    - The folder where you put the extracted files is referred to below as `VE_HOME`

1. To complete the installation, start R from the place you installed VisionEval
    - In Windows Explorer, Double-click VisionEval.Rproj
        - You can also use the `launch.bat` script to run VisionEval in the standard R GUI, if you can't (or don't want
          to) install and run RStudio
        - See the `launch.bat` [instructions here](#starting-visioneval-from-the-rgui).
    - If everything is working, an R console window will open where you can type instructions for VisionEval
    - The "Welcome to VisionEval!" message should appear
    - Return to the [Getting Started](#getting-started) page for how to run VisionEval, how to use the walkthrough to
      explore VisionEval models and features, and how to develop a VisionEval model setup for your own region.

<a name='production-environment'>Setting up a Production Environment</a>
------------------------------------------------------------------------

Though it is possible to build your own local VisionEval model in the "models" folder of your VisionEval installation,
we don't recommend that since you will need to move the model every time you install a new version of VisionEval.
Having your models in their own location makes it much easier to back up the models or to put them under version
control without having to bring along the entire VisionEval code base.

To keep the code and models separate, you can set up a "Production Environment" and store your model in a location
distinct from where the VisionEval code is located. That way you can upgrade (or downgrade) VisionEval without having to
move your model, or you can shift from using the end-user installation (downloadable .zip installer) to a development
installation (cloning the Github repository).

By default, VisionEval looks for models in the "models" folder of the VisionEval runtime, which itself defaults to the
folder into which you extracted the VisionEval installer .zip file.

- In production, the default behavior is a problem because you will need to move the model setups every time you change
  the version of R or VisionEval
- You can prevent headaches by setting up a separate permanent folder for your models, which we'll refer to as `VE_RUNTIME`

The VisionEval startup code knows about two locations referred to in environment variables (see below if you don't know
what environment variables are):

- `VE_HOME` is where the VisionEval application code is located
- `VE_RUNTIME` is where the "models" folder is located

These can be entirely different folders on different drives. Out of the box, `VE_HOME` and VE_RUNTIME are both the same, and they point to the folder
where you unzipped VisionEval.

By setting `VE_HOME` and `VE_RUNTIME` yourself, you can start visioneval from the same place you put your model, and
simply adjusting `VE_HOME` will allow you to run the model with a different version of R or VisionEval.

You can set VisionEval up to start either from within `VE_HOME` or from within `VE_RUNTIME. Separating these two
locations is what we call "creating a **Production Environment**".

We suggest that you set up your system so you can start VisionEval from `VE_RUNTIME` (the place you store your models),
since it is then easier to update your R or VisionEval version. Here is how to set that up:

- The first thing to do is decide where you want your VisionEval runtime (`VE_RUNTIME`)
- Create that folder (for example `%USERPROFILE%/VE_Models`)
- Go to your VisionEval installation (`VE_HOME` which is the place where you installed the VisionEval code)
- Open the `.Renviron` file with your favorite text editor (or Notepad, which is nobody's favorite, but which will do
  the job)
    - If the `.Renviron` file does not exist, please start your VisionEval installation once using VisionEval.Rproj or launch.bat and
      it will be created automatically
- Add a line like the following line (or change that line if it already exists) so that it refers to the folder you
  created to store your models:

  ```
  VE_RUNTIME=C:/Users/MyUserProfileDirectory/VE_Models
  ```

Now when you start VisionEval by clicking `VisionEval.Rproj` (or `launch.bat`), you'll see that it is running in the
folder you assigned to `VE_RUNTIME`. Also notice that an empty "models" directory was created there when you ran
VisionEval for the first time. The "models" folder is where you will be creating and running your own VisionEval
models.

To start VisionEval from within your `VE_RUNTIME` folder, you will need to copy some of the runtime support files from
the installation location.

- Copy these runtime files from your installation directory to your VE_RUNTIME:
    - `launch.bat`
    - `.Rprofile`
    - `.Renviron`
    - `VisionEval.Rproj`
- If you're learning VisionEval, you'll also want to copy the `walkthrough` folder.
- Do NOT move the following files and folders, which make up the actual VisionEval executable. It won't hurt to copy
  them, but it just wastes disk space and is confusing):
    - `ve-lib`
    - `VisionEval.R`
    - `LICENSE`

The `.Renviron` file should already have `VE_HOME` correctly defined, but you can check by opening it in a text editor.
You can also define `VE_HOME` yourself. It should point to the folder where you unzipped the VisionEval installer, or to
the folder into which you cloned the Github repository.

If you later change the R or VisionEval version, you can just copy over the `.Renviron` file from the new installation after
you have opened it once in R (or you can manually edit `.Renviron` to point to the new `VE_HOME` location.

To configure your `VE_RUNTIME` to use a development environment (the cloned Github repository) the steps are a little
different:

- Build visioneval (see the section on setting up a development environment and building VisionEval, below). That step
  is necessary to have runnable VisionEval code, and for it to generate a suitable `.Renviron` file for locating
  `VE_HOME`.
- Find and copy the runtime files from "MyVisionEval-Github-clone/built/visioneval/4.3.2/runtime" (or whatever R
  version you built VisionEval with). These are the files to copy:
    - `launch.bat`
    - `.Rprofile`
    - `.Renviron`
    - `VisionEval.Rproj`
- If you set the `VE_BUILD` variable (see below for setting up a development environment), the runtime files will be located
  in `VE_BUILD/built/VE_BRANCH/VE_R_VERSION/runtime` where:
     - VE_BUILD is the directory you set up to receive the built 
     - VE_BRANCH is the Github branch you are building from. The default for `ve.build` is "visioneval" and all branches will
       be built into that same location.
         - You can create different builds for the Github branches by running `ve.build(use.git=TRUE)`
     - VE_R_VERSION is the version of R with which you built VisionEval.
- Do NOT delete the original runtime folder from the `built` directory (the startup script requires it to be present,
  even if it is not going to be used).
- Finally, find the generated `.Renviron` file in the root directory of your development environment and copy that to `VE_RUNTIME`.
    - `VE_HOME` in `.Renviron` should be the location of the Git root directory (NOT the built runtime)
    - It will still work if you  point `VE_HOME` at the built runtime (where the runtime files are located),
      you just won't have access to the developmment environment tools.
    - The Github root also contains a `launch.bat` and a `VisionEval-dev.Rproj`. You can use those to start VisionEval.
    - To start VisionEval from your development environment (Github clone), you will need to add (or edit) the `VE_RUNTIME`
      line in the `.Renviron` file located in the development environment root directory (set it to the full path
      of your runtime folder).

<a name='development-environment'>Setting up a Development Environment</a>
------------------------------------------------------------------------

A development environment will allow you to build and rebuild VisionEval from the Github. Building VisionEval is easy;
it requires a little more software setup and it's just a bit time-consuming the first time. Here are the basic steps:

  - You will need a copy of git to clone the development source code, or you can download a snapshot of the code as a
    zip file from Github
  - You need one additional software installation (RTools43), in addition to R and (optionally) RStudio to run VisionEval
  - Then you just start R from the root of the Github and run the `ve.build()` function

After that you can make any change you want to VisionEval and rebuild those changes just by running `ve.build()` again.

To get the development code, you clone the Github repository.You can find VisionEval at these Github repositories:

1. [https://github.com/visioneval/Visioneval.git](https://github.com/visioneval/Visioneval.git) for the release
   version of the code (doesn't change often, but may be missing new features and bug fixes)
2. [https://github.com/visioneval/Visioneval-dev.git](https://github.com/visioneval/Visioneval-dev.git) for the
   development version, which is probably what you want to use if you're doing any development rather than just
   installing.

If you don't want to work with git, but would still like to build from code, you can do that. Visit the [Github](https://github.com/VisionEval/VisionEval-Dev),
nd hit the green Code button, select "Local", then choose "Download ZIP".

If you plan to contribute code back to the VisionEval project, you should work with `Visioneval-dev`. If you're just
making local changes or rebuilding certain packages for your own use, you can use `VisionEval`

We're not going to teach you `git` here. For an introduction try [the Git Book](https://git-scm.com/book/en/v2) or the
[W3 Schools tutorial](https://www.w3schools.com/git/default.asp).

You can use any Git client you are familiar with. [Git for Windows](https://gitforwindows.org) is one good choice, or you
can use the [Github desktop client](https://desktop.github.com). Either of those would need to be installed.

To clone the repository, you will want to execute the following instruction in your Git client of choice. Please be
aware that you do *NOT* need to "fork" the repository in order to make a clone and build VisionEval locally. See the
discussion of forking below for more information. Most people will NOT want to "fork".
  
```
cd /folder/for/Git-Repos
git clone https://github.com/visioneval/VisionEval-dev.git VisionEval-dev
```

The rest of this section on the development environment will presume your VisionEval git clone is in a folder called
"VisionEval-dev". If you're attaching your [Production Environment](#production-environment) to your new VisionEval
clone, use the Github root folder (e.g. `/folder/for/Git-Repos/VisionEval-dev`) as the value for the `VE_HOME`
environment variable. Or you can just copy the `.Renviron` file that is created when you first run `ve.build()`, which
will set VE_HOME to the correct value.

Once you've got the cloned repository, make sure you have the following software available. The first two (R and
RStudio) are the same that you would need for an end-user installation from the .zip installer.

- R for one of the supported versions (see `VisionEval-dev/build/R-versions.yml` for a complete list of supported versions)
    - [Get R here](https://cran.r-project.org)
    - R installation will work, even without administrative permissions (ignore the warning about not having access to certain features - none of them matter to VisionEval)
- RStudio (optional)
    - [Get RStudio here](https://posit.co/download/rstudio-desktop/)
    - RStudio needs administrative permissions; to continue without it, see the command line instructions below
- RTools43
    - [Get RTools43 here](https://cran.r-project.org/bin/windows/Rtools/rtools43/rtools.html)
    - Technically, you need a different RTools package for R 4.3.2 compared to R 4.1.x and R 4.2.x. In practice, you
      can always use RTools43 because the only part of RTools used by VisionEval is the `make` program and a couple of
      other standard GNU utilities, and the RTools shell for the command line is the same for all practical purposes in
      those versions.
    - You do NOT need administrative permissions to install RTools43, but you may need to hunt around for a folder in
      which you have write permissions (%USERPROFILE% is a good choice).

To build or re-build VisionEval from the Git code with RStudio, do this:

- Start RStudio by double-clicking the "VisionEval-dev.Rproj" file at the root of the Git code (in "VisionEval-dev")
- If you don't have RStudio, make sure R_HOME is set to point to your version of R (see above) and just double-click
  "launch.bat".  That will give you the standard R GUI with the VisionEval development environment loaded.
- Execute this R command from with the running R console to perform the build:

```
ve.build()
```

- The build needs an internet connection and will take an hour or so to complete depending on how fast your machine
  and internet connection are.
- You can run the built VisionEval with the command "ve.run()" and also do the walkthrough with the command
  "ve.test()" 

When you run `ve.build()` it creates two new non-versioned folders in "VisionEval-dev" as well as a couple of files.

- In the Git root (VisionEval-dev), an .Renviron file is created that you can use to set up your [Production Environment](#production-environment)
- In the existing build directory, a build configuration file is created called "ve-output-visioneval-4.x.x.make" where the "4.x.x" is whatever R version you were building for
- Two new folders are created at the top of the repository:
    - "dev" which contains build log files, build status, and a library of R packages that are used during building but are not included in the end-user installation
    - "built" which contains the built compoenents
- The directory structure under "built" looks like this:
    - built
        - visioneval (or really, VE_BRANCH - see below to build different git branches separately)
            - 4.x.x (where x.x is whatever sub-version of R you're using; if you build a different R version from the same repository branch you'll get additional folders)
                - docs (internal documentation, which will be empty unless you do `ve.build("docs")`
                - pkg-dependencies (a local R repository with all the dependency packages needed by VisionEval; these are also installed into ve-lib below)
                - pkg-ve-repo (a local R repository with the built-but-uninstalled VisionEval packages)
                - runtime (the base folder whose contents become the basis for an end-user installer; ve.run() copies this folder so as not to pollute eventual installers with results of your tests)
                - runtime.test (this folder won't exist until you do `ve.run()`)
                - src (this is the assembled source code for the framework and module packages that ends up the Source installer zip file; you can build or rebuild packages from these folders using R Studie or the R CMD instructions)
                - ve-lib (installed binary versions of the VisionEval packages and dependencies for windows; this is placed into the "runtime" folder of the VisionEval installer zip file)
                - ve-pkg (installable tar.gz package files that are only built for Mac or Linux for a source installation on those platforms; usually this folder will be empty on Windows though there are magic internal flags that can force ve-pkg to be populated)

You should NOT put real work or real models into the "runtime" or "runtime.test" folders. Those will get blown away when
you rebuild VisionEval. Set up a [Production Environment](#production-environment) instead to define `VE_RUNTIME`.

If you have a git feature branch for VisionEval-dev, you can build that branch separately from the default git branch
(and if that makes no sense to you, you don't need to know...).

You'll want to build a feature branch separately if you need to keep a built instance of your base branch alongside your
experiments and not have to rebuild everythign when you change branches back and forth. To use the name of your branch
(instead of the default "visioneval") just add a parameter to ve.build:

```
ve.build(use.git=TRUE)
```

You'll then get a subfolder of "built" named after your git branch (e.g. "built/mybranch/4.x.x/...")

If you're really working different branches (or if you're
[using git worktrees](https://opensource.com/article/21/4/git-worktree), which we recommend but won't explain
here), it can help to put all your VisionEval builds in the same separate folder. This amounts to creating a "build
environment" similar to your "production environment".

To put your builds somewhere else than in your git repository clone, just define a `VE_BUILD` environment variable in the
`.Renviron` in the root of your development environment (VisionEval-dev). `VE_BUILD` should name an existing folder
somewhere outside your VisionEval git directory (e.g. :%USERPROFILE%\VisionEval-build")

Once you have defined VE_BUILD, restart R or RStudio, and then when you run `ve.build()` or the command line equivalent,
you'll get this structure of files and folders:

- VE_BUILD
    - built (just like the "built" folder within the git repository )
        - mybranch (or "visioneval" if you don't set use.git=TRUE)
          - 4.x.x.
            - ... etc. 
    - dev (same contents as the "dev" folder within the git repository
      if you don't have VE_BUILD set)
        - lib
        - logs

`ve.build()` will still create ".Renviron" file in the git root and also create the "build/ve-output-visioneval-4.x.x.make" file within the Git repository

If you define `VE_BUILD`, you do NOT need to change `VE_HOME`: it should still point to the root of your VisionEval git repository.

### Frequently Asked Questions (development)

- Do I need to "fork" the VisionEval-dev repository (short answer: "NO") and why would I ever want to?

    - Github has a misleading operation called "forking" and people get confused about the difference between "cloning" and
      "forking". Forking is a Github-specific operation that will create a new Github-managed copy of the VisionEval repository within
      your own Git account. Cloning is a general Git action that makes a copy of a Github repository on your local computer.

    - You do *NOT* need to fork any VisionEval repository to clone a development environment on your computer. Just run
      the git clone operation locally and point it at the VisionEval repository using one of the connection strings
      revealed by Github's green "<> Code" button on the repository home page.

    - If you do "fork" you will still need to "clone" in order to get a local copy of a VisionEval repository that you
      can build or work on. You don't need to "fork" unless you want to make changes that you might contribute back to
      VisionEval. Forks on Github are needed to make pull requests. A "pull request" is an offer to merge your changes
      back into the main VisionEval code base.

    - If you are doing "pull requests", they should always be made against the "development" branch of VisionEval-dev, and you
      should be sure to rebase your changes on the current HEAD of the "development" branch prior to submitting the pull
      request (or it is guaranteed to be rejected). If none of that makes any sense to you, then you shouldn't even be
      thinking of forking or making a pull request.

- What if I'm not using Windows?

    - In principle, VisionEval should build and run on any system that has a supported version of R available (Mac or Linux or even the Windows Subsytem for Linux)
    - You need to have a full R development environment in place because `ve.build()` will do an R source build and installation for all the dependency packages
    - "All the dependency" packages means that the first build will take considerably longer than on an equivalent Windows
      machine for which binary packages are available (order of magnitude several hours instead of just one hour,
      depending on the speed of your machine).
    - You will need a LOT of RAM to do the build (we recommend 16 Gigabytes) so if you're trying this on a Linux
      cloud server, you'll want a premium setup configured. Once you've built it, it will run with less RAM (or work
      reasonably with a large swap file). Remember that running a large VE model may still need as much as 8 or 9 Gigabytes of
      RAM per concurrent scenario.
    - You do not need RStudio on Mac or Linux (but you could use it, if your system is [supported by RStudio](https://posit.co/download/rstudio-desktop/)
      and if the system  has a graphical user interface).
    - You do NOT need RTools, which is only for Windows. The RTools functions are part of the standard Mac or Linux operating system
      environments. On Linux, depending on your distribution, you will need to install the system build environment (e.g. the "build-essential" package on Debian
      or ubuntu). That will furnish make, GNU compilers, etc. You will also need the full R packages (r-base, and r-base-dev).
    - Without RStudio, just follow the command line instructions below
    - *Caveat* No one has recently (1/2024) tried a non-Windows build, so there may still be some weirdnesses (e.g. with
      file permissions). Contact jeremy.raw at dot.gov if you're having trouble with a non-Windows build.

- How do I build VisionEval from a command line?

    - It's easy, but if you don't already know why you would want to and especially if you have not familiarity with a GNU
      Bash command line, we're not going to explain it here. Just use RStudio or launch.bat (for the standard R GUI) and `ve.build()`.
    - Here's the command line drill:
      - Open the RTools43 Bash command line (it's an icon within the RTools43 Start Menu)
      - Change into the `build` folder of your git repository clone. That is NOT the same as the `built` folder - `build`
        contains the code needed to perform the build operations, and it is part of the versioned Github code.
      - Type `make` and then go do something else for an hour or so.
    - When `make` is done, go back to the git root in Windows Explorer and double-click launch.bat (or
      VisionEval-dev.Rproj) to start the built VisionEval with "ve.run()" 
    - If you really love the terminal, you can put the R executable on your PATH and then after `make` finishes, just change to
      the root of your git installation. Then enter "R" and you'll get an R command line right there with VisionEval running
      within it. But of courses, who would want to do that if they weren't setting up a cluster of machines to do massively
      parallel VisionEval scenario runs?
    - If you want to run a command line inside RStudio, you can open a Terminal window, change into the "build" directory,
      and run "make" from there. That's it! Everything else is just like doing `ve.build()` from within RStudio or the R
      GUI, though there are some more options to do partial builds.
      See [`Makefile.md`](https://github.com/VisionEval/VisionEval-Dev/blob/development/build/Makefile.md) in the `build`
      directory to learn about all the build options.

    By default, the command line "build" process does not save a log of what it did. (If you run `ve.build()` from within
    R, the console window keeps the log). Here's a magic incantation for the RTools43 Bash commend line (or Mac and Linux terminals)
    that will save a log file (in "build/make.out" - you can use any other file name or location your like):

    ```
    nohup make >make.out 2>&1 & tail -f make.out
    ```

    Type `Ctrl-C` to exit the `tail` program (which shows the log in the terminal window as the build runs). Start monitoring
    again by re-entering just the `tail -f make.out` part. If the `tail` display doesn't change for a while, stop it with
    `Ctrl-C` and see if you get the "done" message.

    If you then want to end the `make` process, end the tail command (with `Ctrl-C`) first then enter this commend
    (which gets the make process ID and stops the process):
    
    ```
    kill `ps aux | grep make | awk '{print $1}'`
    ```

    Or you can run the ps command by hand, find the `make` process id (the first colum in the ps output) and kill that id.
