
# cd ~/GodotPlayground
# ln -sf ../../../common/cpp/mynative/libmynative.so projects/testgame/native/libmynative.so

# Explanation:
# 	You’re in GodotPlayground/
# 	You want the link in projects/testgame/native/
# 	The relative path from projects/testgame/native/ → common/cpp/mynative/ is:
# 	../../common/cpp/mynative/

# Verify:
# readlink -f projects/testgame/native/libmynative.so
# 	This must now return the full absolute path like:
# 	/home/sayd/GodotPlayground/common/cpp/mynative/libmynative.so

# ==============================
##@ 🎮 Godot
# ==============================

PROJECTS_DIR	:= ./projects

GD_NEW_PROJECT	:= ./utils/scripts/gd-new-project.sh
GD_DEL_PROJECT	:= ./utils/scripts/gd-delete-project.sh
GD_RUN_PROJECT	:= ./utils/scripts/gd-run-project.sh

gd-new: ## Create a new Godot project
	@$(call RUN_SCRIPT,New Godot Project,$(GD_NEW_PROJECT))

gd-delete: ## Delete a Godot project
	@$(call RUN_SCRIPT,Delete Godot Project,$(GD_DEL_PROJECT))

gd-run: ## Launch a Godot project
	@$(call RUN_SCRIPT,Launch Godot Project,$(GD_RUN_PROJECT))

.PHONY: gd-new gd-delete gd-run

# ==============================
##@ 👾 Godot-CPP
# ==============================

CPP_ROOT := common/cpp
GODOT_CPP_DIR := $(CPP_ROOT)/godot-cpp
GODOT_CPP_BIN := $(GODOT_CPP_DIR)/bin
GODOT_CPP_HEADERS := $(GODOT_CPP_DIR)/godot-headers

CPP_MODULES := $(filter-out $(GODOT_CPP_DIR),$(wildcard $(CPP_ROOT)/*))
CPP_MODULE_NAMES := $(notdir $(CPP_MODULES))

# Script path (also defined in scripts.mk)
GD_CPP_NEW		:= utils/scripts/gd-cpp-new-module.sh

cpp: cpp-bindings cpp-build

cpp-new:
	@(call RUN_SCRIPT,cpp module,$(GD_CPP_NEW))

cpp-bindings: ## Build godot-cpp bindings
	@echo "[C++] Building godot-cpp bindings..."
	cd $(GODOT_CPP_DIR) && scons platform=linux generate_bindings=yes -j$(nproc)

cpp-build: ## Build all native C++ modules
	@for mod in $(CPP_MODULE_NAMES); do \
		echo "[C++] Building module: $$mod"; \
		cd $(CPP_ROOT)/$$mod && scons -j$$(nproc) verbose=1; \
	done

cpp-clean: ## Clean all compiled C++ modules
	@for mod in $(CPP_MODULE_NAMES); do \
		echo "[C++] Cleaning module: $$mod"; \
		cd $(CPP_ROOT)/$$mod && scons -c; \
	done

cpp-re: cpp-clean cpp-build ## Clean and rebuild

.PHONY: cpp cpp-bindings cpp-build cpp-clean
