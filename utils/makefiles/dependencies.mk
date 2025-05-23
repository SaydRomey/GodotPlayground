
## (WIP)

# sudo apt install scons clang g++ pkg-config

# Step 2: Clone and Build godot-cpp
# 
# cd common/cpp
# git clone https://github.com/godotengine/godot-cpp.git
# cd godot-cpp
# scons platform=linux generate_bindings=yes -j$(nproc)

# maybe create a sub=module with https://github.com/SaydRomey/godot-cpp
# git submodule add https://github.com/SaydRomey/godot-cpp godot-cpp
# cd godot-cpp
# git checkout 4.4.1-stable
## **
# # You can fetch tags from the official upstream repo and check out the correct one:
# git remote add upstream https://github.com/godotengine/godot-cpp
# git fetch upstream --tags
# git checkout 4.4.1-stable
# # If you want to keep your fork synced, you can later do:
# git merge upstream/4.4.1-stable
# # And optionally push to your GitHub fork.
## OR create a local branch from that tag
# git checkout -b 4.4.1-stable
# This way you can:
# Track changes
# Push updates to your fork if needed
# Easily pull upstream updates in the future
## * After checking out the correct version of godot-cpp, don't forget to rebuild the bindings:
# scons -j$(nproc) platform=linux generate_bindings=yes
## * then rebuild native module:
# cd ~/GodotPlayground/common/cpp/mynative
# scons -c
# scons -j$(nproc)
## **
# 
## then init and update submod if needed:
# git submodule update --init --recursive
# # build forked godot-cpp
# cd ~/GodotPlayground/common/cpp/godot-cpp
# scons platform=linux target=template_debug generate_bindings=yes -j$(nproc)
# # rebuild native module
# cd ~/GodotPlayground/common/cpp/mynative
# scons -c
# scons -j$(nproc)

GODOT_CPP_DIR := common/cpp/godot-cpp
GODOT_CPP_REPO := https://github.com/godotengine/godot-cpp.git

deps: deps-check ## Check installed dependencies

deps-check:
	@echo "[DEPS] Checking external dependencies..."
	@if [ ! -d "$(GODOT_CPP_DIR)" ]; then \
		echo "  - godot-cpp not found. Run 'make deps-install' to fetch."; \
	else \
		echo "  - godot-cpp already present."; \
	fi

deps-install: ## Install required dependencies
	@echo "[DEPS] Cloning godot-cpp..."
	@git clone $(GODOT_CPP_REPO) $(GODOT_CPP_DIR)

deps-update: ## Update dependencies
	@echo "[DEPS] Updating godot-cpp..."
	@if [ -d "$(GODOT_CPP_DIR)" ]; then \
		cd $(GODOT_CPP_DIR) && git pull origin master; \
	else \
		echo "godot-cpp not found. Run 'make deps-install' first."; \
	fi

.PHONY: deps deps-check deps-install deps-update

# 

# build-bindings:
# 	@$(call INFO,godot-cpp,Building bindings...)
# 	@if [ -d "$(GODOT_CPP_DIR)" ]; then \
# 		scons platform=linux generate_bindings=yes -j$(nproc); \
# 	else \
# 		$(call WARNING,godot-cpp,'$(GODOT_CPP_DIR)' not found); \
# 	fi

# MYNATIVE	:= common/cpp/mynative

# build-module:
# 	@$(call INFO,)

# .PHONY: build-bindings
