# godot.mk

# ==============================
##@ 🎮 Godot Project Management
# ==============================

PROJECTS_DIR	:= ./projects

GD_NEW_PROJECT	:= ./utils/scripts/gd-new-project.sh
GD_DEL_PROJECT	:= ./utils/scripts/gd-delete-project.sh
GD_RUN_PROJECT	:= ./utils/scripts/gd-run-project.sh
GD_OPEN_PROJECT	:= ./utils/scripts/gd-open-project.sh

gd-new: ## Create a new Godot project
	@$(call RUN_SCRIPT,New Godot Project,$(GD_NEW_PROJECT))

gd-delete: ## Delete a Godot project
	@$(call RUN_SCRIPT,Delete Godot Project,$(GD_DEL_PROJECT))

gd-run: ## Launch a Godot project
	@$(call RUN_SCRIPT,Launch Godot Project,$(GD_RUN_PROJECT))

gd-open: ## Launch a Godot project or open it in godot editor
	@$(call RUN_SCRIPT,Launch Godot Project,$(GD_OPEN_PROJECT))

.PHONY: gd-new gd-delete gd-run
