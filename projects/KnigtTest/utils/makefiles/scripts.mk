# ==============================
##@ 📜 Scripts
# ==============================

# Scripts Paths  (relative to the main Makefile's location)
SCRIPT_DIR		:= ./utils/scripts
SHOW_COLORS		:= $(SCRIPT_DIR)/ansi_colors.sh

# Scripts Logs and Artifacts
SCRIPT_LOG_DIR	:= ./utils/scripts/tmp_scripts_logs
SCRIPT_LOG_FILE	:= $(SCRIPT_LOG_DIR)/SCRIPT_$(TIMESTAMP).log
SCRIPT_ARTIFACTS	:= 

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
	$(call INFO,Scripts,$(ORANGE)Running $(1) script...); \
	if [ "$(3)" = "true" ]; then \
		$(2) >> $(SCRIPT_LOG_FILE) 2>&1; \
		$(call SUCCESS,Scripts,Script $(1) executed successfully.); \
		$(call INFO,Scripts,Logged in $(SCRIPT_LOG_FILE)); \
	else \
		$(2); \
		$(call SUCCESS,Scripts,Script $(1) executed successfully.); \
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
		echo "1) Display Terminal Colors"; \
		echo ""; \
		read -p "Enter your choice (1-1 (for now)): " choice; \
		case "$$choice" in \
			1) SCRIPT_TYPE="Show Colors"; SCRIPT_CHOICE="$(SHOW_COLORS)";; \
			*) echo "[ERROR] Invalid choice. Please enter 1 or 2."; exit 1;; \
		esac; \
		\
		# Export LOG_ENABLED for use in nested call \
		export LOG_ENABLED="$$LOG_ENABLED"; \
		$(MAKE) $(NPD) run-script SCRIPT_TYPE="$$SCRIPT_TYPE" SCRIPT_CHOICE="$$SCRIPT_CHOICE" LOG_ENABLED="$$LOG_ENABLED" \
	'

script-clean: ## Clean up test artifacts and logs
	@$(call CLEANUP,Scripts,script artifacts,$(SCRIPT_ARTIFACTS),"All scripts artifacts removed.","No artifacts to clean.")
	@$(call CLEANUP,Scripts,script log files,$(SCRIPT_LOG_DIR),"Scripts logs removed.","No logs to remove.")

$(SCRIPT_LOG_DIR):
	@$(MKDIR) $(SCRIPT_LOG_DIR)

.PHONY: script script-clean
