
# # Compiler and Flags
# COMPILE		:= c++
# STANDARD	:= -std=c++98
# C_FLAGS		:= -Wall -Werror -Wextra $(STANDARD) -pedantic

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
# 	@$(COMPILE) $(C_FLAGS) $(OBJS) $(INCLUDES) -o $@
# 	@$(call SUCCESS,$@,Build complete)
# 	@$(MAKE) title $(NPD)

# # Object compilation rules
# $(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp $(HEADERS)
# 	@mkdir -p $(@D)
# 	@$(call INFO,$(NAME),$(ORANGE)Compiling...\t,$(CYAN)$(notdir $<))
# 	@$(COMPILE) $(C_FLAGS) $(INCLUDES) -c $< -o $@
# 	@$(call UPCUT)

# cpp-clean: ## Remove object files
# 	@$(call CLEANUP,$(NAME),cpp object files,$(OBJ_DIR))

# cpp-re: cpp-fclean cpp-all ## Rebuild everything

# .PHONY: cpp-all cpp-clean cpp-re
