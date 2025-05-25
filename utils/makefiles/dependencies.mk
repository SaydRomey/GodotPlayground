# dependencies.mk
## (WIP)

# ===========================
##@ 🧩 Dependency Management
# ===========================
# 📦

GODOT_CPP_DIR	:= common/cpp/godot-cpp
GODOT_CPP_REPO	:= https://github.com/godotengine/godot-cpp.git
GODOT_CPP_TAG	:= godot-4.4.1-stable

SYS_DEPS := scons clang g++ pkg-config

deps: deps-check deps-sys-check ## Run all dependency checks

deps-check:
	@echo "[DEPS] Checking godot-cpp..."
	@if [ ! -d "$(GODOT_CPP_DIR)" ]; then \
		echo "  ❌ godot-cpp not found."; \
		echo "  ➤ Run 'make deps-install' to clone."; \
	else \
		echo "  ✅ godot-cpp exists."; \
	fi

deps-sys-check:
	@echo "[DEPS] Checking required system packages..."
	@for cmd in $(SYS_DEPS); do \
		if ! command -v $$cmd >/dev/null 2>&1; then \
			echo "  ❌ $$cmd not found"; \
		else \
			echo "  ✅ $$cmd found"; \
		fi; \
	done

deps-install: ## Clone and init godot-cpp submodule
	@echo "[DEPS] Initializing git submodules..."
	@git submodule update --init --recursive

deps-update: ## Checkout correct tag in godot-cpp
	@echo "[DEPS] Updating submodule 'godot-cpp'..."
	@cd $(GODOT_CPP_DIR) && git fetch --tags && git checkout $(GODOT_CPP_TAG)

deps-bindings: ## Build godot-cpp bindings
	@echo "[DEPS] Building godot-cpp bindings..."
	@cd $(GODOT_CPP_DIR) && scons platform=linux target=template_debug generate_bindings=yes -j$$(nproc)

deps-all: deps-install deps-update deps-bindings ## Install + build all

.PHONY: deps deps-check deps-sys-check deps-install deps-update deps-bindings deps-all
