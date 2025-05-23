
# ==============================
##@ 📚 Documentation
# ==============================

# Godot
URL_GODOT		:= https://docs.godotengine.org/en/stable/index.html
URL_2D_GUIDE	:= https://www.gamedev.net/tutorials/programming/general-and-gameplay-programming/the-guide-to-implementing-2d-platformers-r2936/
URL_KCC_CHAR	:= https://kidscancode.org/godot_recipes/4.x/2d/platform_character/index.html

doc: ## Show documentation links
	@clear
	@echo "Select documentation subject:"
	@echo "\n$(ORANGE)Godot$(RESET)"
	@echo "  0. Godot Documentation"
	@echo "  1. Guide to Implementing 2D Platformers"
	@echo "  2. Platform Character"

	@read url_choice; \
	case $$url_choice in \
		0) CHOICE=$(URL_GODOT);; \
		1) CHOICE=$(URL_2D_GUIDE);; \
		2) CHOICE=$(URL_KCC_CHAR);; \
		*) $(call ERROR,Invalid choice:,$$CHOICE, Exiting.); exit 1;; \
	esac; \
	$(OPEN) $$CHOICE
	@clear
	@$(call INFO,,Opening documentation...)

.PHONY: doc
