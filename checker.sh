#!/bin/sh

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No color
DIVIDER="\n----------------------------------------\n"

# Helper function for displaying section headers
print_section() {
    printf "${YELLOW}${DIVIDER}$1${DIVIDER}${NC}"
}

# Check PHP 8.2
print_section "Checking PHP"
if command -v php >/dev/null 2>&1; then
    PHP_VERSION=$(php -v | head -n 1 | awk '{print $2}')
    PHP_MAJOR=$(echo "$PHP_VERSION" | cut -d. -f1)
    PHP_MINOR=$(echo "$PHP_VERSION" | cut -d. -f2)
    if [ "$PHP_MAJOR" -gt 8 ] || { [ "$PHP_MAJOR" -eq 8 ] && [ "$PHP_MINOR" -ge 2 ]; }; then
        printf "${GREEN}PHP 8.2 or greater is installed (Version: $PHP_VERSION)${NC}\n"
    else
        printf "${RED}PHP is installed, but the version is less than 8.2 (Version: $PHP_VERSION)${NC}\n"
    fi
else
    printf "${RED}PHP is not installed.${NC}\n"
fi

# Check if Composer is installed
print_section "Checking Composer"
if command -v composer >/dev/null 2>&1; then
    # Get installed Composer version
    COMPOSER_VERSION=$(composer --version | grep -oP "\d+\.\d+\.\d+")
    # Fetch latest Composer version from the official Composer website
    LATEST_VERSION=$(curl -s https://getcomposer.org/versions | grep -oP '"version":\s*"\K\d+\.\d+\.\d+' | head -1)
    # Compare installed version with the latest version
    if [ "$COMPOSER_VERSION" = "$LATEST_VERSION" ]; then
        printf "${GREEN}Composer is up to date (Version: $COMPOSER_VERSION).${NC}\n"
    else
        printf "${RED}Composer is not up to date. You have version $COMPOSER_VERSION. Please update to version $LATEST_VERSION.${NC}\n"
    fi

# Check if Composer's global vendor bin directory is in the PATH
print_section "Checking if Composer's global vendor bin is in the PATH"

# Check Composer's configured global bin path
COMPOSER_BIN_DIR=$(composer config --global home 2>/dev/null)/vendor/bin

if [ -d "$COMPOSER_BIN_DIR" ]; then
    if echo "$PATH" | grep -q "$COMPOSER_BIN_DIR"; then
        printf "${GREEN}Composer's global bin directory is properly configured in the PATH environment variable (${COMPOSER_BIN_DIR}).${NC}\n"
    else
        printf "${RED}Composer's global bin directory is not in the PATH.${NC}\n"
        printf "${YELLOW}To add Composer's global bin directory to your PATH for the current session, run:${NC}\n"
        printf "  export PATH=\$PATH:$COMPOSER_BIN_DIR\n"
        printf "${YELLOW}To permanently add Composer's global bin directory to your PATH, add the following line to your shell's configuration file (e.g., .bashrc or .zshrc):${NC}\n"
        printf "  export PATH=\$PATH:$COMPOSER_BIN_DIR\n"
    fi
fi

else
    printf "${RED}Composer is not installed.${NC}\n"
fi

# Check for SQLite
print_section "Checking SQLite"
if command -v sqlite3 >/dev/null 2>&1; then
    SQLITE_VERSION=$(sqlite3 --version | awk '{print $1}')
    printf "${GREEN}SQLite is installed (Version: $SQLITE_VERSION)${NC}\n"
else
    printf "${RED}SQLite is not installed.${NC}\n"
fi

# Check if Node.js is installed and up to date
print_section "Checking Node.js"
if command -v node >/dev/null 2>&1; then
    # Get installed Node.js version
    NODE_VERSION=$(node --version | sed 's/v//')
    printf "${GREEN}Node.js is installed (Version: $NODE_VERSION).${NC}\n"
else
    printf "${RED}Node.js is not installed.${NC}\n"
fi

# Check if VS Code is installed and working
print_section "Checking Visual Studio Code"
if command -v code >/dev/null 2>&1; then
    # Get the installed version of VS Code
    VS_CODE_VERSION=$(code --version | head -n 1)
    printf "${GREEN}VS Code is installed (Version: $VS_CODE_VERSION).${NC}\n"
else
    printf "${RED}VS Code is not installed.${NC}\n"
fi

# Check if npm is installed and up to date
print_section "Checking npm"
if command -v npm >/dev/null 2>&1; then
    # Get installed npm version
    NPM_VERSION=$(npm --version)
    printf "${GREEN}npm is installed (Version: $NPM_VERSION).${NC}\n"

    # Fetch the latest npm version from the npm registry
    LATEST_NPM_VERSION=$(npm show npm version)

    # Compare the installed version with the latest version
    if [ "$NPM_VERSION" = "$LATEST_NPM_VERSION" ]; then
        printf "${GREEN}npm is up to date (Version: $NPM_VERSION).${NC}\n"
    else
        printf "${RED}npm is not up to date (Current version: $NPM_VERSION, Latest version: $LATEST_NPM_VERSION).${NC}\n"
    fi
else
    printf "${RED}npm is not installed.${NC}\n"
fi

# Check sudo access
# Disabled by default because it requires root privileges, uncomment if you want to be thorough though :-)
# print_section "Checking Sudo Access"
# if sudo -v >/dev/null 2>&1; then
#     printf "${GREEN}User has sudo access.${NC}\n"
# else
#     printf "${RED}User does not have sudo access.${NC}\n"
# fi

# Promote YouTube Channel
print_section "Subscribe to My YouTube Channel!"

# Display YouTube channel details
YOUTUBE_CHANNEL="@Zedatrix"
YOUTUBE_URL="https://www.youtube.com/@Zedatrix"

printf "${YELLOW}🚀 Don't forget to subscribe to my YouTube channel for more awesome content! 🚀${NC}\n"
printf "${GREEN}Channel: $YOUTUBE_CHANNEL${NC}\n"
printf "${GREEN}URL: $YOUTUBE_URL${NC}\n"
printf "${YELLOW}Thank you for your support! 🙌${NC}\n"
