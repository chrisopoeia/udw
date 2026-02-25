# ubuntu-data-workstation (udw)

## Introduction

## Installation

```
$ sudo apt install git

$ git clone https://github.com/chrisopoeia/ubuntu-data-workstation.git
```

## Modules

### setup

### project

### backup

### venv

####

Additional packages:

```
# additional
matplotlib
pyarrow # required for df to/from parquet
lxml # required for pandas read_html
beautifulsoup4
coverage
datamodel-code-generator #https://pypi.org/project/datamodel-code-generator/
faker
jupyter # required in addition to ipykernel for extended Jupyter functionality e.g. running notebooks from command line
openpyxl
sphinx
xsdata # https://xsdata.readthedocs.io/en/latest/
xsdata-pydantic # https://xsdata-pydantic.readthedocs.io/en/latest/     

# build tools - in this order?
build
setuptools
twine
```

### postgres

## Extras

### dconf_diff

```
tools/dconf_diff.sh
```

Identify updated dconf keys/values after making changes to Ubuntu settings.

If differences are found, use dconf Editor's search function to find the key(s).