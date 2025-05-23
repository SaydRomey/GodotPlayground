#!/bin/bash

source "$(dirname "$0")/ansi_colors.sh"

# Path to the .env file (relative to the root of the project)
ENV_FILE="./.env"

# Pulling environment info from the host
USER_NAME=${USER:-someone}

# Write variables to .env file
ENV_CONTENT=$(cat <<EOL
# File: .env

# Environment variables
USER=$USER_NAME

# Script-related variables
PROJECT_CLEANUP_PASSWORD="please"

EOL
)

echo "$ENV_CONTENT" > "$ENV_FILE"
echo ".env file created at $ENV_FILE with host information."

# # Function to generate the .env file
# gen_env() {
#     echo "$ENV_CONTENT" > "$ENV_FILE"
#     echo ".env file created at $ENV_FILE with host information."
# }

# # Function to clean the .env file
# clean_env() {
#     rm -rf "$ENV_FILE"
#     echo "$ENV_FILE deleted."
# }

# # Function to reset the .env file
# reset_env() {
#     clean_env
#     gen_env
# }

# # Main script logic to handle commands
# case "$1" in
#     gen_env)
#         gen_env
#         ;;
#     clean_env)
#         clean_env
#         ;;
#     reset_env)
#         reset_env
#         ;;
#     *)
#         echo "Usage: $0 {gen_env|clean_env|reset_env}"
#         exit 1
#         ;;
# esac
