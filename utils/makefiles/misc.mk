
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

title: ## Print logo in ASCII art
	@echo "$(PINK)$$PROJECT_TITLE$(RESET)"
	@echo "$(PINK_HOT)Created by $(BOLD)$(TEAM)$(RESET)"
	@echo "$(PINK_LIGHT)Compiled for $(ITALIC)$(BOLD)$(PURPLE)$(USER)$(RESET)"
	@echo "$(PINK_PASTEL)$(TIME)$(RESET)\n"

.PHONY: title

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
