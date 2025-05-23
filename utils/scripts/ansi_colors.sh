#!/bin/bash

# Utility script for color-coded output in scripts
# Usage:
# Can be sources in other scripts like this:
#	source "$(dirname "$0")/ansi_colors.sh"
# (Using 'dirname' to ensure it works regardless of our current working directory)

# Text Reset
NC='\033[0m' # No Color

# Regular Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'

# Bold
BRED='\033[1;31m'
BGREEN='\033[1;32m'
BYELLOW='\033[1;33m'
BBLUE='\033[1;34m'
BCYAN='\033[1;36m'
BWHITE='\033[1;37m'
