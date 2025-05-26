
# example symlink (run at root, to place link in testgame)
# ln -sf ../../common/cpp/mynative/libmynative.so projects/testgame/native/libmynative.so

# ==============================
# Project Info
# ==============================

NAME		:= GodotPlayground
AUTHOR		:= cdumais
TEAM		:= $(AUTHOR)
REPO_LINK	:= https://github.com/SaydRomey/GodotPlayground

# ==============================
# Makefile Imports
# ==============================

MK_PATH		:= utils/makefiles

include $(MK_PATH)/utils.mk			# Utility Variables and Macros
include $(MK_PATH)/doc.mk			# Documentation Targets
include $(MK_PATH)/env.mk			# .env File Management
include $(MK_PATH)/class.mk			# CPP Class Creator
include $(MK_PATH)/scripts.mk		# Scripts Management
include $(MK_PATH)/godot.mk			# Goodot and C++ native
include $(MK_PATH)/tree.mk			# File structure output
include $(MK_PATH)/misc.mk			# Miscellaneous Utilities
include $(MK_PATH)/dependencies.mk	# 

# ==============================
# Default
# ==============================

.DEFAULT_GOAL	:= all

.DEFAULT:
	$(info make: *** No rule to make target '$(MAKECMDGOALS)'.  Stop.)
	@$(MAKE) help $(NPD)

# ==============================
##@ 🛠  Utility
# ==============================

help: ## Display available targets
	@echo "\nAvailable targets:"
	@awk 'BEGIN {FS = ":.*##";} \
		/^[a-zA-Z_0-9-]+:.*?##/ { \
			printf "   $(CYAN)%-15s$(RESET) %s\n", $$1, $$2 \
		} \
		/^##@/ { \
			printf "\n$(BOLD)%s$(RESET)\n", substr($$0, 5) \
		}' $(MAKEFILE_LIST)

repo: ## Open the GitHub repository
	@$(call INFO,$(NAME),Opening $(AUTHOR)'s github repo...)
	@$(OPEN) $(REPO_LINK);

.PHONY: help repo

# ==============================
##@ 🎯 Main Targets
# ==============================

all: help

new: gd-new | env ## gd-run but depends on .env file

run: gd-run ## gd-run


# # ==============================
# ##@ 🧹 Cleanup
# # ==============================

clean: ## Remove object files
	@$(MAKE) cpp-clean $(NPD)

fclean: clean ## Remove executable
#	@$(call CLEANUP,$(NAME),executable,$(NAME))
#	@$(MAKE) cpp-clean $(NPD)

ffclean: fclean ## Remove all generated files and folders
	@$(MAKE) script-clean $(NPD)
	@$(MAKE) tree-clean $(NPD)
#	@$(MAKE) cpp-fclean $(NPD)
#	@$(MAKE) env-clean $(NPD)
#	@$(MAKE) -clean $(NPD)

re: fclean all ## Rebuild everything

.PHONY: clean fclean ffclean re
