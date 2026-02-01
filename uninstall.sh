#!/usr/bin/env bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default Claude skills directory
CLAUDE_SKILLS_DIR="${HOME}/.claude/skills"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_SOURCE_DIR="${SCRIPT_DIR}/skills"

# Functions
print_header() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}  Claude Skills Uninstaller${NC}"
    echo -e "${BLUE}================================${NC}"
    echo
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

confirm_uninstall() {
    echo -e "${YELLOW}This will remove the following skills:${NC}"
    echo

    local found=false
    for skill_file in "$SKILLS_SOURCE_DIR"/*.md; do
        [ -e "$skill_file" ] || continue
        local basename=$(basename "$skill_file")
        local skill_name="${basename%.md}"
        local dest_file="$CLAUDE_SKILLS_DIR/$basename"

        if [ -f "$dest_file" ]; then
            echo "  - $skill_name"
            found=true
        fi
    done

    if [ "$found" = false ]; then
        print_info "No skills from this repository are currently installed."
        exit 0
    fi

    echo
    read -p "Are you sure you want to uninstall these skills? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "Uninstall cancelled."
        exit 0
    fi
    echo
}

uninstall_skills() {
    print_info "Uninstalling skills..."
    echo

    local removed=0
    local not_found=0

    for skill_file in "$SKILLS_SOURCE_DIR"/*.md; do
        [ -e "$skill_file" ] || continue

        local basename=$(basename "$skill_file")
        local skill_name="${basename%.md}"
        local dest_file="$CLAUDE_SKILLS_DIR/$basename"

        if [ -f "$dest_file" ]; then
            rm "$dest_file"
            print_success "Removed: $skill_name"
            ((removed++))
        else
            print_info "Not installed: $skill_name"
            ((not_found++))
        fi
    done

    echo
    print_success "Uninstall complete!"
    echo
    echo "Summary:"
    echo "  - Skills removed: $removed"
    echo "  - Skills not found: $not_found"
    echo
}

print_next_steps() {
    echo -e "${BLUE}Next Steps:${NC}"
    echo "  1. Restart Claude Code to apply changes"
    echo "  2. To reinstall, run: ./install.sh"
    echo
}

# Main uninstall flow
main() {
    print_header
    confirm_uninstall
    uninstall_skills
    print_next_steps
}

# Run main function
main
