# ==============================
##@ 📜 Scripts
# ==============================

# Scripts Paths  (relative to the main Makefile's location)
SCRIPT_DIR		:= ./utils/scripts
SCRIPT_MISC		:= $(SCRIPT_DIR)/misc-scripts
SCRIPT_GODOT	:= $(SCRIPT_DIR)/godot-scripts

SHOW_COLORS		:= $(SCRIPT_MISC)/show_colors.sh

# Godot-related script
GD_NEW_PROJECT	:= $(SCRIPT_DIR)/gd-new-project.sh
GD_DEL_PROJECT	:= $(SCRIPT_DIR)/gd-delete-project.sh
GD_OPEN_PROJECT	:= $(SCRIPT_DIR)/gd-open-project.sh
GD_CPP_NEW		:= $(SCRIPT_DIR)/gd-cpp-new-module.sh

# Environment script
GENERATE_ENV	:= $(SCRIPT_DIR)/generate-env.sh

# Scripts Logs and Artifacts
SCRIPT_LOG_DIR	:= ./utils/scripts/tmp_scripts_logs
SCRIPT_LOG_FILE	:= $(SCRIPT_LOG_DIR)/SCRIPT_$(TIMESTAMP).log
# SCRIPT_ARTIFACTS	:= 

# ==============================
# Script Related Utilty Macros
# ==============================

# Macro: RUN_SCRIPT
# Run a script with optional logging
# 
# Parameters:
# $(1): Name of the script (for logging and clarity).
# $(2): Path to the script.
# $(3): Boolean to enable logging
# 
# Behavior:
# Ensures the script exists and is executable.
# Runs the script.
# If logging is enabled, appends the output to a log file.
# Displays appropriate success messages based on logging status.
# 
# Example Usage:
# $(call RUN_SCRIPT,Create Users,$(SHOW_COLORS))
# $(call RUN_SCRIPT,Create Users,$(SHOW_COLORS),true)
# 
define RUN_SCRIPT
	if [ ! -f "$(2)" ]; then \
		$(call ERROR,Script Missing: ,Script '$(2)' does not exist.); \
		exit 1; \
	fi; \
	if [ ! -x "$(2)" ]; then \
		chmod +x $(2); \
	fi; \
	$(call INFO,Scripts,$(ORANGE)Running '$(1)' script...); \
	if [ "$(3)" = "true" ]; then \
		$(2) >> $(SCRIPT_LOG_FILE) 2>&1; \
		$(call SUCCESS,Scripts,Script '$(1)' executed successfully.); \
		$(call INFO,Scripts,Logged in $(SCRIPT_LOG_FILE)); \
	else \
		$(2); \
		$(call SUCCESS,Scripts,Script '$(1)' executed successfully.); \
	fi
endef

# **************************************************************************** #

run-script:
	@$(call RUN_SCRIPT,$(SCRIPT_TYPE),$(SCRIPT_CHOICE),$(LOG_ENABLED))

script: | $(SCRIPT_LOG_DIR) ## Interactive script selection menu
	@bash -c '\
		clear; \
		read -p "Do you want to log script output? (y/n): " log_choice; \
		if [ "$$log_choice" = "y" ] || [ "$$log_choice" = "Y" ] || [ -z "$$log_choice" ]; then \
			LOG_ENABLED=true; \
		else \
			LOG_ENABLED=false; \
		fi; \
		\
		echo ""; \
		echo "📜 Choose a script to run:"; \
		echo "Misc"; \
		echo "0) Display Terminal Colors"; \
		echo "Godot"; \
		echo "1) Create a new Godot project"; \
		echo "2) Delete a Godot project"; \
		echo "3) Launch a Godot project or open it in editor"; \
		echo "4) Create a new C++ Native module"; \
		echo "Environment"; \
		echo "10) Generate a .env file"; \
		read -p "Enter your choice: " choice; \
		case "$$choice" in \
			0) SCRIPT_TYPE="Show Colors"; SCRIPT_CHOICE="$(SHOW_COLORS)";; \
			1) SCRIPT_TYPE="New Godot Project"; SCRIPT_CHOICE="$(GD_NEW_PROJECT)";; \
			2) SCRIPT_TYPE="Delete Godot Project"; SCRIPT_CHOICE="$(GD_DEL_PROJECT)";; \
			3) SCRIPT_TYPE="Open Godot Project"; SCRIPT_CHOICE="$(GD_OPEN_PROJECT)";; \
			4) SCRIPT_TYPE="New native C++ Module"; SCRIPT_CHOICE="$(GD_CPP_NEW)";; \
			10) SCRIPT_TYPE="Generate .env file"; SCRIPT_CHOICE="$(GENERATE_ENV)";; \
			*) echo "[ERROR] Invalid choice."; exit 1;; \
		esac; \
		\
		# Export LOG_ENABLED for use in nested call \
		export LOG_ENABLED="$$LOG_ENABLED"; \
		$(MAKE) $(NPD) run-script SCRIPT_TYPE="$$SCRIPT_TYPE" SCRIPT_CHOICE="$$SCRIPT_CHOICE" LOG_ENABLED="$$LOG_ENABLED" \
	'

script-clean: ## Clean up test artifacts and logs
	@if [ -d $(SCRIPT_LOG_DIR)]; then \
		$(call CLEANUP,Scripts,script log files,$(SCRIPT_LOG_DIR),"Scripts logs removed.","No logs to remove."); \
	fi
#	@$(call CLEANUP,Scripts,script artifacts,$(SCRIPT_ARTIFACTS),"All scripts artifacts removed.","No artifacts to clean.")

$(SCRIPT_LOG_DIR):
	@$(MKDIR) $(SCRIPT_LOG_DIR)

script-make-exec: ## Make all scripts in SCRIPT_DIR executable
	@$(call INFO,Scripts,Making all scripts in $(SCRIPT_DIR) executable...)
	@count_file=$$(mktemp); \
	echo 0 > $$count_file; \
	find $(SCRIPT_DIR) -type f -name "*.sh" | while read script; do \
		if [ -x "$$script" ]; then \
			echo "$(YELLOW)Already executable: $$(basename "$$script")$(RESET)"; \
		else \
			chmod +x $$script; \
			echo "$(GREEN)Made executable: $$(basename "$$script")$(RESET)"; \
			count=$$(cat $$count_file); \
			count=$$((count + 1)); \
			echo $$count > $$count_file; \
		fi; \
	done; \
	total=$$(cat $$count_file); \
	rm -f $$count_file; \
	echo "$(CYAN)Total scripts made executable: $$total$(RESET)"

script-make-exec-silent: ## Run script-make-exec but suppress all output
	@$(MAKE) script-make-exec $(STDOUT_NULL) $(STDERR_STDOUT)

.PHONY: script script-clean \
		script-make-exec \
		script-make-exec-silent
