#!/bin/bash
# utils/scripts/gd-cpp-new-module.sh

set -e

source "$(dirname "$0")/ansi_colors.sh"

TEMPLATE_DIR="utils/templates/cpp-modules"
SRC_ROOT="common/cpp"

read -rp "Module name (lowercase): " MOD_NAME
if
 [[ -z "$MOD_NAME" ]]; then
	echo -e "${RED}Module name cannot be empty.${NC}"
	exit 1
fi

CLASS_NAME="$(tr '[:lower:]' '[:upper:]' <<< ${MOD_NAME:0:1})${MOD_NAME:1}"
CLASS_NAME_UPPER="$(echo "$CLASS_NAME" | tr '[:lower:]' '[:upper:]')"
MODULE_DIR="${SRC_ROOT}/${MOD_NAME}"

if [ -d "$MODULE_DIR" ]; then
	echo -e "${RED}Module '${MOD_NAME}' already exists at ${MODULE_DIR}.${NC}"
	exit 1
fi

echo -e "${CYAN}Creating native module '$CLASS_NAME'...${NC}"
mkdir -p "$MODULE_DIR"

# Generate files from templates
declare -A templates=(
	["class.cpp.template"]="${CLASS_NAME}.cpp"
	["class.hpp.template"]="${CLASS_NAME}.hpp"
	["register_types.cpp.template"]="register_types.cpp"
	["SConstruct.template"]="SConstruct"
	["template.gdextension"]="${MOD_NAME}.gdextension"
	# ["gdextension.template"]="${MOD_NAME}.gdextension"

)

for tpl in "${!templates[@]}"; do
	src="${TEMPLATE_DIR}/${tpl}"
	dst="${MODULE_DIR}/${templates[$tpl]}"
	if [ ! -f "$src" ]; then
		echo -e "${RED}Missing template: $src${NC}"
		exit 1
	fi

	sed \
		-e "s/{{MODULE_NAME}}/${MOD_NAME}/g" \
		-e "s/{{CLASS_NAME}}/${CLASS_NAME}/g" \
		-e "s/{{CLASS_NAME_UPPER}}/${CLASS_NAME_UPPER}/g" \
		"$src" > "$dst"
	
	echo -e "${GREEN}✔️  Generated: $dst${NC}"
done

# Create godot_includes.hpp if not already present
INCLUDES_FILE="${MODULE_DIR}/godot_includes.hpp"
if [ ! -f "$INCLUDES_FILE" ]; then
	cat <<EOF > "$INCLUDES_FILE"
#pragma once

#include <godot_cpp/core/class_db.hpp>
#include <godot_cpp/classes/node.hpp>
#include <godot_cpp/variant/utility_functions.hpp>
using namespace godot;
EOF
	echo -e "${GREEN}✔️  Created: $INCLUDES_FILE${NC}"
fi

echo -e "${GREEN}Native C++ module '${MOD_NAME}' created at '${MODULE_DIR}'.${NC}"
