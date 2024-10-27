# automate-renv-analysis-project

This helper-script is intended for those who need to run several short term R analysis projects, primarily interacting through jupyter notebooks, and want to ensure you have a reproducible R environment managed by `renv` and with a consistent folder structure.

Provided you can manage your R installation yourself, this script can be added to your path and run whenever you need to create a new project folder and jupyter kernel.

## Requirements

The script requires an R installation with renv installed.

## Usage

### Setup

- ensure your system has R installed
- Add the script to your `PATH` for example by placing it in a folder `~/bin/` and adding `export PATH=$PATH:~/bin` to your .zshrc or .bashrc file (adjust for your chosen choice of shell)

### Usage

When you need to start a new project, identify the path for the root directory of the project, and the desired name of the R kernel, and run the following, for example :

```{bash}
setup-r-project --directory /path/to/project/directory --kernel-name my_kernel_name
```

The directory structure is somewhat opinionated, creating a tree of directories as follows:

```{bash}
/path/to/project/directory/
├── data
│   ├── 00_source
│   ├── 01_staging
│   └── 02_final
├── figures
├── notebooks
│   └── 00-install-kernel.R
├── output
│   ├── data
│   ├── figures
│   └── other
├── renv/...
└── renv.lock
```

- Keep your R jupyter notebooks in the notebooks directory, using the kernel installed by the script.
  - At the end of each notebook, after saving, include and run a cell containing `renv::snapshot()`.  This will maintain your  R environment via the `renv/` folder and `renv.lock` file for you.
- *Note that the `renv/` directory and `renv.lock` file are to be maintained by renv, not the user.*
- The intention is that scripts and Jupyter notebooks are all located in the `notebooks/` directory.  This is achieved with a hidden `.Rprofile` file that ensures the renv environment in the `renv/` folder is automatically referenced from the notebooks directory.  Alternatively, R sessions started frrom the main project directory will also use the same renv environment.
- The script 00-install-kernel.R is provided in case the jupyter kernel is not available for use in future (for example, someone has removed it).  Running this will reinstall the R kernel for the corresponding environment.  It can be run with either of the following commands:
  - `Rscript 00-install-kernel.R` in the terminal, or
  - `source("00-install-kernel.R")`, from an interactive R session.

## Output

The logs should be informative.  If the project directory already exists the script will fail informatively.

- A jupyter kernel is installed for the corresponding R environment.
any R session running in the notebooks folder will automatically use the R environment specified by renv.  The corresponding jupyter kernel will be installed.
There is also a hidden .Rprofile file created in the notebooks/ directory - this is critical to ensure renv works correctly from this folder.

## Testing

This script has been tested extensively in a couple of different environments, and to step toward a more robust test, it has been run in a rocker docker container.  This is provided via the Dockerfile in the repository.  To see the logs provided when running, run `make run-test-image` from the command line.
