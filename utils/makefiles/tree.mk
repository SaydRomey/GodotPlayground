
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
	@if [ -f $(TREE_OUTFILE) ]; then \
		$(call CLEANUP,TREE,'tree' output,$(TREE_OUTFILE)); \
	fi

.PHONY: tree tree-log tree-cleen
