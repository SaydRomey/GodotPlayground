# godot.mk

# ==============================
##@ 🎮 Godot Project Management
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
##@ 👾 Godot C++ Integration
# ==============================

CPP_ROOT			:= common/cpp
GODOT_CPP_DIR		:= $(CPP_ROOT)/godot-cpp

CPP_MODULES			:= $(filter-out $(GODOT_CPP_DIR),$(wildcard $(CPP_ROOT)/*))
CPP_MODULE_NAMES	:= $(notdir $(CPP_MODULES))

# Script path (also defined in scripts.mk)
GD_CPP_NEW			:= utils/scripts/gd-cpp-new-module.sh

cpp: cpp-bindings cpp-build ## Build bindings and all C++ modules

cpp-new: ## Create new C++ native module
	@(call RUN_SCRIPT,cpp module,$(GD_CPP_NEW))

cpp-bindings: ## Build godot-cpp bindings
	@echo "[C++] Building godot-cpp bindings..."
	@cd $(GODOT_CPP_DIR) && scons platform=linux target=template_debug generate_bindings=yes -j$$(nproc)

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

cpp-status: ## Show available C++ modules and their contents
	@for mod in $(CPP_MODULE_NAMES); do \
		echo "[C++] Module: $$mod"; \
		ls -lh $(CPP_ROOT)/$$mod; \
	done

cpp-gdextension-links: ## Regenerate .gdextension files for all modules
	@for mod in $(CPP_MODULE_NAMES); do \
		[ "$$mod" = "godot-cpp" ] && continue; \
		echo "[GDExtension] Generating $$mod.gdextension"; \
		sed \
			-e "s/{{ENTRY_SYMBOL}}/$$mod_init/" \
			-e "s/{{LIB_NAME}}/lib$$mod/" \
			utils/templates/cpp-modules/template.gdextension > projects/testgame/native/$$mod.gdextension; \
	done

.PHONY: cpp cpp-bindings cpp-build cpp-clean cpp-re cpp-status cpp-gdextension-links
