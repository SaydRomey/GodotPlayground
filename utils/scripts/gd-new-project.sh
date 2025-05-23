#!/bin/bash

# This script will:
# Ask for a project name.
# Create a new subfolder in 'projects/'.
# Initialize a basic Godot project using the .godot and project.godot boilerplate.
# Symlink the shared gdlib (later for reuse).
# (Optional later: clone a Godot C++ template for native modules.)

source "$(dirname "$0")/ansi_colors.sh"

read -p "Enter new project name: " PROJECT_NAME

PROJECT_DIR="projects/${PROJECT_NAME}"

if [ -d "$PROJECT_DIR" ]; then
  echo -e "${RED}Project '${PROJECT_NAME}' already exists.${NC}"
  exit 1
fi

mkdir -p "$PROJECT_DIR"
cd "$PROJECT_DIR" || exit 1

# Minimal Godot project setup
echo "[gd_resource type=\"Resource\"]" > project.godot
mkdir -p scenes scripts

# Symlink shared gdlib
ln -s ../../common/gdlib gdlib

echo -e "${GREEN}New project '${PROJECT_NAME}' created at '${PROJECT_DIR}'.${NC}"
