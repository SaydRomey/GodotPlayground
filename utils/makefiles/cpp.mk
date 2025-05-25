# cpp.mk

# For optional compiling of non-Godot, pure C++ utilities — useful for:
# 	- Game-specific CLI tools
# 	- Static analysis
# 	- Procedural generation helpers

# Used for standalone C++ utils (if ever needed)
CPP_NAME	:= standalone_app
CPP_DIR		:= standalone

# Compiler and Flags
COMPILE		:= c++
STANDARD	:= -std=c++17
CPP_FLAGS	:= -Wall -Werror -Wextra $(STANDARD)

# Source code files
SRC_DIR		:= $(CPP_DIR)/src
SRCS		:= $(shell find $(SRC_DIR) -name "*.cpp")

# Object files
OBJ_DIR		:= $(CPP_DIR)/obj
OBJS		:= $(SRCS:$(SRC_DIR)/%.cpp=$(OBJ_DIR)/%.o)

# Header files (including .ipp)
INC_DIR		:= $(CPP_DIR)/inc
HEADERS		:= $(shell find $(INC_DIR) -name "*.hpp" -o -name "*.ipp" -name "*.tpp")
INCLUDES	:= $(addprefix -I, $(shell find $(INC_DIR) -type d))

BUILD_DIR	:= build

# ==============================
##@ 🎯 CPP Standalone Targets
# ==============================

cpp-all: $(NAME) ## Build the standalone cpp executable

$(NAME): $(OBJS)
	@$(MKDIR) $(BUILD_DIR)
	@$(COMPILE) $(CPP_FLAGS) $(OBJS) $(INCLUDES) -o $(BUILD_DIR)/$@
	@$(call SUCCESS,$@,Build complete)
#	@$(MAKE) title $(NPD)

# Object compilation rules
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp $(HEADERS)
	@mkdir -p $(@D)
	@$(call INFO,$(NAME),$(ORANGE)Compiling...\t,$(CYAN)$(notdir $<))
	@$(COMPILE) $(CPP_FLAGS) $(INCLUDES) -c $< -o $@
	@$(call UPCUT)

cpp-clean: ## Remove standalone cpp object files
	@$(call CLEANUP,$(NAME),cpp object files,$(OBJ_DIR))

cpp-fclean: cpp-clean ## Remove standalone cpp executable
	@$(call CLEANUP,$(NAME),executable,$(NAME))

cpp-re: cpp-fclean cpp-all ## Rebuild standalone cpp executable

.PHONY: cpp-all cpp-clean cpp-fclean cpp-re




# ==============================
# ==============================
# ==============================

# # Compiler and Flags
# COMPILE		:= c++
# STANDARD	:= -std=c++98
# CPP_FLAGS		:= -Wall -Werror -Wextra $(STANDARD) -pedantic

# # Source code files
# SRC_DIR		:= src
# SRCS		:= $(shell find $(SRC_DIR) -name "*.cpp")

# # Object files
# OBJ_DIR		:= obj
# OBJS		:= $(SRCS:$(SRC_DIR)/%.cpp=$(OBJ_DIR)/%.o)

# # Header files (including .ipp)
# INC_DIR		:= inc
# HEADERS		:= $(shell find $(INC_DIR) -name "*.hpp" -o -name "*.ipp" -name "*.tpp")
# INCLUDES	:= $(addprefix -I, $(shell find $(INC_DIR) -type d))

# BUILD_DIR	:= build

# # ==============================
# ##@ 🎯 CPP Targets
# # ==============================

# cpp-all: $(NAME) ## Build the project

# $(NAME): $(OBJS)
# 	@$(COMPILE) $(CPP_FLAGS) $(OBJS) $(INCLUDES) -o $@
# 	@$(call SUCCESS,$@,Build complete)
# 	@$(MAKE) title $(NPD)

# # Object compilation rules
# $(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp $(HEADERS)
# 	@mkdir -p $(@D)
# 	@$(call INFO,$(NAME),$(ORANGE)Compiling...\t,$(CYAN)$(notdir $<))
# 	@$(COMPILE) $(CPP_FLAGS) $(INCLUDES) -c $< -o $@
# 	@$(call UPCUT)

# cpp-clean: ## Remove object files
# 	@$(call CLEANUP,$(NAME),cpp object files,$(OBJ_DIR))

# cpp-re: cpp-fclean cpp-all ## Rebuild everything

# .PHONY: cpp-all cpp-clean cpp-re
