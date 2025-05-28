#!/bin/bash
# utils/scripts/gd-new-project.sh

## TODO: maybe compile the cpp modules to be sure the .so are generated before running this script ?

# set -e

source "$(dirname "$0")/ansi_colors.sh"

read -p "Enter new project name: " PROJECT_NAME
PROJECT_DIR="projects/${PROJECT_NAME}"

if [ -d "$PROJECT_DIR" ]; then
	echo -e "${RED}Project '${PROJECT_NAME}' already exists.${NC}"
	exit 1
fi

mkdir -p "$PROJECT_DIR"/{scenes,scripts,native}
cd "$PROJECT_DIR" || exit 1

# Basic Godot project setup
echo "[gd_resource type=\"Resource\"]" > project.godot
echo -e "${GREEN}✔️  Initialized minimal Godot project.godot${NC}"

# Symlink shared gdlib
echo "Symlinking gdlib..."
ln -s ../../common/gdlib gdlib

TEMPLATE_PATH=../../utils/templates/cpp-modules/gdextension.template
if [ ! -f "$TEMPLATE_PATH" ]; then
	echo -e "${RED}Template not found: $TEMPLATE_PATH${NC}"
	exit 1
fi

# Symlink native modules and generate .gdextension files
for module_path in ../../common/cpp/*; do
	module_name=$(basename "$module_path")
	[[ "$module_name" == "godot-cpp" ]] && continue

	so_path="../../common/cpp/${module_name}/lib${module_name}.so"
	gdextension_path="native/${module_name}.gdextension"
	uid_path="native/${module_name}.gdextension.uid"

	# Link .so
	if [ -f "$so_path" ]; then
		ln -sf "$so_path" "native/lib${module_name}.so"
	else
		echo -e "${YELLOW}Warning: $so_path not found${NC}"
	fi

	# Generate .gdextension
	sed \
		-e "s/{{MODULE_NAME}}/${module_name}/" \
		"$TEMPLATE_PATH" > "$gdextension_path"

	# Optional: UID placeholder
	if [ ! -f "$uid_path" ]; then
		echo "gdextension" > "$uid_path"
	fi

	echo -e "${GREEN}✔️  Linked native module: ${module_name}${NC}"
done

echo -e "${GREEN}🎮 New Godot project '${PROJECT_NAME}' created at '${PROJECT_DIR}'.${NC}"
