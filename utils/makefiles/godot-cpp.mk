# godot-cpp.mk

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
	@$(call RUN_SCRIPT,cpp module,$(GD_CPP_NEW))

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

# check: ## Verify all .gdextension files and .so links
# 	@echo "[CHECK] Verifying native modules..."
# 	@for mod in $(CPP_MODULE_NAMES); do \
# 		[ "$$mod" = "godot-cpp" ] && continue; \
# 		gdext="projects/testgame/native/$$mod.gdextension"; \
# 		sofile="projects/testgame/native/lib$$mod.so"; \
# 		if [ ! -f "$$gdext" ]; then \
# 			echo "$(RED)Missing: $$gdext$(RESET)"; \
# 		else \
# 			grep -q "$$mod_init" "$$gdext" || echo "$(RED)Mismatch in: $$gdext (missing $$mod_init)$(RESET)"; \
# 		fi; \
# 		if [ ! -f "$$sofile" ]; then \
# 			echo "$(RED)Missing: $$sofile$(RESET)"; \
# 		fi; \
# 	done

# symlink-all: ## Create gdlib and native links for all projects
# 	@for proj in $(shell ls -d projects/*/); do \
# 		echo "Updating $$proj..."; \
# 		ln -snf ../../common/gdlib $$proj/gdlib; \
# 		mkdir -p $$proj/native; \
# 		ln -snf ../../../common/cpp/mynative/libmynative.so $$proj/native/libmynative.so; \
# 		if [ ! -f $$proj/native/native.gdextension ]; then \
# 			cp utils/templates/native.gdextension.template $$proj/native/native.gdextension; \
# 		fi; \
# 	done

.PHONY: cpp cpp-bindings cpp-build cpp-clean cpp-re cpp-status cpp-gdextension-links # check
