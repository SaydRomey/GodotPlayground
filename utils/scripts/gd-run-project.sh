#!/bin/bash

# This script will:
# List available projects.
# Prompt the user to select one.
# Launch the selected project with godot (assuming it's in our path).

source "$(dirname "$0")/ansi_colors.sh"

PROJECTS_DIR="projects"
PROJECTS=($(ls -1 "$PROJECTS_DIR"))

if [ ${#PROJECTS[@]} -eq 0 ]; then
  echo -e "${YELLOW}No projects available to run.${NC}"
  exit 0
fi

echo -e "${CYAN}Available projects:${NC}"
select PROJECT_NAME in "${PROJECTS[@]}"; do
  if [[ -n "$PROJECT_NAME" ]]; then
    break
  else
    echo -e "${RED}Invalid selection.${NC}"
  fi
done

GODOT_BIN=$(command -v godot4 || command -v godot)

if [ -z "$GODOT_BIN" ]; then
  echo -e "${RED}Godot executable not found. Please install Godot or add it to your PATH.${NC}"
  exit 1
fi

PROJECT_PATH="${PROJECTS_DIR}/${PROJECT_NAME}"
echo -e "${GREEN}Launching '$PROJECT_NAME'...${NC}"
"$GODOT_BIN" --path "$PROJECT_PATH"

