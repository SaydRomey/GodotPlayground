
# TODO: Check if we can pull environment info from the host with the template option

# Path to the .env files relative to the project root
ENV_FILE		:= ./.env
ENV_TEMPLATE	:= ./utils/templates/.env.template
ENV_SCRIPT		:= ./utils/scripts/generate-env.sh

# Default values if environment variables are missing
USER_NAME := $(or $(USER), someone)

# ==============================
# Defined multi-line variable for the .env content
define ENV_CONTENT
# File: .env

# Environment variables
USER=$(USER_NAME)

# Script-related variables
PROJECT_CLEANUP_PASSWORD="please"

endef
export ENV_CONTENT

# ==============================
##@ .env Automation
# ==============================

env: ## Generate the .env file (uses 'env.mk' variables)
	@if [ ! -f $(ENV_FILE) ]; then \
		echo "$$ENV_CONTENT" > $(ENV_FILE); \
		echo "$(ENV_FILE) $(GREEN)Generated!$(RESET)"; \
	fi

env-create: ## Generate the .env file (with prompt for overwrite)
	@if [ ! -f $(ENV_FILE) ]; then \
		echo "$(YELLOW)Creating $(RESET)$(ENV_FILE) $(YELLOW)file...$(RESET)"; \
		echo "$$ENV_CONTENT" > $(ENV_FILE); \
		echo "$(GREEN).env file created at$(RESET) $(ENV_FILE)!"; \
	else \
		printf "$(ORANGE)$(ENV_FILE) file already exists.$(RESET) Overwrite? [Y/n]: "; \
		read confirm; \
		if [ "$$confirm" = "y" ] || [ "$$confirm" = "Y" ] || [ -z "$$confirm" ]; then \
			echo "$(YELLOW)Overwriting$(RESET) $(ENV_FILE)$(ORANGE)...$(RESET)"; \
			echo "$$ENV_CONTENT" > $(ENV_FILE); \
			echo ".env $(GREEN)file overwritten!$(RESET)"; \
		else \
			echo "$(GREEN)Keeping existing .env file.$(RESET)"; \
		fi \
	fi

env-script: ## Generate the .env file (uses generate-env.sh script)
	@(call RUN_SCRIPT,.env generate,$(ENV_SCRIPT))

env-copy: ## Generate the .env file (uses the '.env' template')
	@if [ ! -f $(ENV_FILE) ]; then \
		echo "Copying $(ENV_TEMPLATE) file at $(ENV_FILE)..."; \
		cp $(ENV_TEMPLATE) $(ENV_FILE); \
		echo "$(GREEN).env file created at $(ENV_FILE)"; \
	fi

env-clean: ## Remove .env files
	@$(call CLEANUP,Environment,.env file,$(ENV_FILE))

env-reset: env-clean env-create ## Overwrite .env file

.PHONY: env env-create env-script env-copy env-clean env-reset
