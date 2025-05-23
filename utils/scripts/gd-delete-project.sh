#!/bin/bash

# (tmp)
# PROJECT_CLEANUP_PASSWORD='please'
# export PROJECT_CLEANUP_PASSWORD="please"

# Load password from .env if available
if [ -f .env ]; then
	export $(grep -v '^#' .env | xargs)
fi

source "$(dirname "$0")/ansi_colors.sh"

PROJECTS_DIR="projects"
PROJECTS=($(ls -1 "$PROJECTS_DIR"))

if [ ${#PROJECTS[@]} -eq 0 ]; then
	echo -e "${YELLOW}No projects found to delete.${NC}"
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

# Confirm project deletion

# 

# # Option 1: Regular confirmation
# read -p "Are you sure you want to delete '$PROJECT_NAME'? (y/N): " CONFIRM
# if [[ "$CONFIRM" == "y" || "$CONFIRM" == "Y" ]]; then
#   rm -rf "${PROJECTS_DIR}/${PROJECT_NAME}"
#   echo -e "${GREEN}Project '$PROJECT_NAME' deleted.${NC}"
# else
#   echo -e "${YELLOW}Aborted.${NC}"
# fi

# 

# Option 2: Require password confirmation
read -sp "Enter password to confirm deletion: " INPUT_PASS
echo

# We can set this in a config or export in our shell
EXPECTED_PASS="${PROJECT_CLEANUP_PASSWORD:-prettyplease}"

if [[ "$INPUT_PASS" != "$EXPECTED_PASS" ]]; then
	echo -e "${RED}❌ Incorrect password. Aborting.${NC}"
	exit 1
fi

rm -rf "${PROJECTS_DIR}/${PROJECT_NAME}"
echo -e "${GREEN}✅ Project '$PROJECT_NAME' deleted.${NC}"

# 

# # Option 3: Regular confirmation + require password (**TO TEST)
# EXPECTED_PASS="${PROJECT_CLEANUP_PASSWORD:-prettyplease}"

# read -p "Are you sure you want to delete '$PROJECT_NAME'? (y/N): " CONFIRM
# if [[ "$CONFIRM" == "y" || "$CONFIRM" == "Y" ]]; then
# 	echo "Enter password to confirm deletion: "; \
# 	read INPUT_PASS; \
# 	if [[ "$INPUT_PASS" != "$EXPECTED_PASS" ]]; then \
# 		echo -e "${RED}❌ Incorrect password. Aborting.${NC}"; \
#   		exit 1; \
# 	fi; \
# 	rm -rf "${PROJECTS_DIR}/${PROJECT_NAME}"
# 	echo -e "${GREEN}Project '$PROJECT_NAME' deleted.${NC}"
# else
# 	echo -e "${YELLOW}Aborted.${NC}"
# fi
