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

# Check if VS Code is installed and working
print_section "Checking Visual Studio Code"
if command -v code >/dev/null 2>&1; then
    # Get the installed version of VS Code
    VS_CODE_VERSION=$(code --version | head -n 1)
    printf "${GREEN}VS Code is installed (Version: $VS_CODE_VERSION).${NC}\n"

    # Fetch the latest version of VS Code from GitHub API
    LATEST_VS_CODE_VERSION=$(curl -s https://api.github.com/repos/microsoft/vscode/releases/latest | grep -oP '"tag_name":\s*"\K[\d.]+')

    # Compare the installed version with the latest version
    if [ "$VS_CODE_VERSION" = "$LATEST_VS_CODE_VERSION" ]; then
        printf "${GREEN}VS Code is up to date (Version: $VS_CODE_VERSION).${NC}\n"
    else
        printf "${RED}VS Code is not up to date (Current version: $VS_CODE_VERSION, Latest version: $LATEST_VS_CODE_VERSION).${NC}\n"
    fi
else
    printf "${RED}VS Code is not installed.${NC}\n"
fi

# Check sudo access
print_section "Checking Sudo Access"
if sudo -v >/dev/null 2>&1; then
    printf "${GREEN}User has sudo access.${NC}\n"
else
    printf "${RED}User does not have sudo access.${NC}\n"
fi
