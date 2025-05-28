#!/bin/bash

# This script will:
# List available projects.
# Prompt the user to select one.
# Ask whether to run or open the project in the editor.

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

# Ask the user if they want to run or open in editor
echo -e "${CYAN}What do you want to do with '$PROJECT_NAME'?${NC}"
select ACTION in "Run the project" "Open in editor"; do
	case $REPLY in
		1) MODE="run"; break ;;
		2) MODE="edit"; break ;;
		*) echo -e "${RED}Invalid selection.${NC}" ;;
	esac
done

GODOT_BIN=$(command -v godot4 || command -v godot)

if [ -z "$GODOT_BIN" ]; then
	echo -e "${RED}Godot executable not found. Please install Godot or add it to your PATH.${NC}"
	exit 1
fi

PROJECT_PATH="${PROJECTS_DIR}/${PROJECT_NAME}"

if [ "$MODE" == "run" ]; then
	echo -e "${GREEN}Launching '$PROJECT_NAME'...${NC}"
	"$GODOT_BIN" --path "$PROJECT_PATH"
else
	echo -e "${GREEN}Opening '$PROJECT_NAME' in the editor...${NC}"
	"$GODOT_BIN" -e --path "$PROJECT_PATH"
fi
