#!/bin/bash

spatial_pkgs=(
    libgdal-dev
    libproj-dev
    libgeos-dev
    # qgis
)

sudo apt install ${spatial_pkgs[*]}
