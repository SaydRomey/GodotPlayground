
# ==============================
##@ 🎨 Decorations
# ==============================

define PROJECT_TITLE

██████╗ ██████╗ ██╗   ██╗███╗   ██╗ ██████╗██╗  ██╗    ██████╗  ██████╗ ██╗     ██╗ ██████╗███████╗
██╔══██╗██╔══██╗██║   ██║████╗  ██║██╔════╝██║  ██║    ██╔══██╗██╔═══██╗██║     ██║██╔════╝██╔════╝
██████╔╝██████╔╝██║   ██║██╔██╗ ██║██║     ███████║    ██████╔╝██║   ██║██║     ██║██║     █████╗  
██╔══██╗██╔══██╗██║   ██║██║╚██╗██║██║     ██╔══██║    ██╔═══╝ ██║   ██║██║     ██║██║     ██╔══╝  
██████╔╝██║  ██║╚██████╔╝██║ ╚████║╚██████╗██║  ██║    ██║     ╚██████╔╝███████╗██║╚██████╗███████╗
╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝╚═╝  ╚═╝    ╚═╝      ╚═════╝ ╚══════╝╚═╝ ╚═════╝╚══════╝

endef
export PROJECT_TITLE

title: ## Print ft_irc's logo in ASCII art
	@echo "$(PINK)$$PROJECT_TITLE$(RESET)"
	@echo "$(PINK_HOT)Created by $(BOLD)$(AUTHOR)$(RESET)"
	@echo "$(PINK_LIGHT)Compiled for $(ITALIC)$(BOLD)$(PURPLE)$(USER)$(RESET)"
	@echo "$(PINK_PASTEL)$(TIME)$(RESET)\n"

.PHONY: title

# ==============================
##@ 🌳 File Structure
# ==============================

# Outfile for 'tree' command
TREE_OUTFILE	:= tmp_tree.txt
TREE_OUT		:= -n -o $(TREE_OUTFILE)

# ^\..* : matches hiddens dirs like .git, .godot
# ^godot-cpp$: hides contents of godot-cpp while still showing the directory

# 'tree' command options (uncomment variables to activate)
TREE_IGNORES	:= -I '.git|.godot|*.uid|*.os|godot-cpp|docs|tmp*'
TREE_ALL		:= -a
# TREE_PERMS	:= -p
# TREE_PRUNE		:= --prune

TREE_OPTIONS	:= $(TREE_ALL) $(TREE_PERMS) $(TREE_PRUNE)

tree: ## Show file structure (without file listed in TREE_IGNORES)
	@if $(call IS_COMMAND_AVAILABLE,tree); then \
		$(call INFO,TREE,Displaying directory and file structure...); \
		tree $(TREE_IGNORES) $(TREE_OPTIONS); \
		if [ -f $(TREE_OUTFILE) ]; then \
			$(call INFO,TREE,File structure available at $(BLUE)$(TREE_OUTFILE)); \
		fi \
	else \
		$(call WARNING,TREE,Command 'tree' not found.); \
	fi

tree-log: ## Logs file structure in TREE_OUTFILE
	@if $(call IS_COMMAND_AVAILABLE,tree); then \
		$(call INFO,TREE,Logging directory and file structure...); \
		tree $(TREE_IGNORES) $(TREE_OPTIONS) $(TREE_OUT); \
		if [ -f $(TREE_OUTFILE) ]; then \
			$(call INFO,TREE,File structure available at $(BLUE)$(TREE_OUTFILE)); \
		fi \
	else \
		$(call WARNING,TREE,Command 'tree' not found.); \
	fi

tree-clean: ## Remove 'tree' outfile
	@$(call CLEANUP,TREE,'tree' output,$(TREE_OUTFILE))

.PHONY: tree tree-log tree-cleen

# ==============================
##@ 💾 Backup
# ==============================

BACKUP_DIR  := $(ROOT_DIR)_$(USER)_$(TIMESTAMP)
MOVE_TO     := ~/Desktop

backup: ffclean ## Prompt and create a .zip or .tar.gz backup of the project
	@echo "Choose backup format: [1] .zip  [2] .tar.gz"
	@read -p "Enter your choice (1 or 2): " choice; \
	case $$choice in \
		1) \
			ext=zip; \
			cmd="zip -r --quiet"; \
			file="$(BACKUP_DIR).zip"; \
			;; \
		2) \
			ext=tar.gz; \
			cmd="tar -czf"; \
			file="$(BACKUP_DIR).tar.gz"; \
			;; \
		*) \
			echo "❌ Invalid choice. Aborting backup."; \
			exit 1; \
			;; \
	esac; \
	if which $$cmd > $(VOID) 2>&1 || true; then \
		$${cmd} "$$file" ./*; \
		mv "$$file" $(MOVE_TO)/; \
		echo "✅ Backup created and moved to: $(MOVE_TO)/$$file"; \
	else \
		echo "❌ Required command '$$cmd' not found. Please install it."; \
	fi

.PHONY: backup

# ==============================
##@ 🔈 Sound
# ==============================

# Sound Files
WAV_DIR		:= ./utils/wav
WAV_WELCOME	:= $(WAV_DIR)/welcome.wav
WAV_PUSHIT	:= $(WAV_DIR)/push.wav

pushit: ## push it to the limit
	@$(PLAY_SOUND) $(WAV_PUSHIT)

welcome: ## what can i say
	@$(PLAY_SOUND) $(WAV_WELCOME)

.PHONY: pushit welcome
