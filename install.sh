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
    echo -e "${BLUE}  Claude Skills Installer${NC}"
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

check_prerequisites() {
    print_info "Checking prerequisites..."

    if [ ! -d "$SKILLS_SOURCE_DIR" ]; then
        print_error "Skills directory not found: $SKILLS_SOURCE_DIR"
        exit 1
    fi

    local skill_count=$(find "$SKILLS_SOURCE_DIR" -name "*.md" -type f | wc -l | tr -d ' ')
    if [ "$skill_count" -eq 0 ]; then
        print_error "No skill files found in $SKILLS_SOURCE_DIR"
        exit 1
    fi

    print_success "Found $skill_count skill(s) to install"
    echo
}

create_skills_directory() {
    if [ ! -d "$CLAUDE_SKILLS_DIR" ]; then
        print_info "Creating Claude skills directory: $CLAUDE_SKILLS_DIR"
        mkdir -p "$CLAUDE_SKILLS_DIR"
        print_success "Directory created"
    else
        print_success "Claude skills directory exists"
    fi
    echo
}

backup_existing_skills() {
    local backup_needed=false

    # Check if any of our skills would overwrite existing ones
    for skill_file in "$SKILLS_SOURCE_DIR"/*.md; do
        [ -e "$skill_file" ] || continue
        local basename=$(basename "$skill_file")
        if [ -f "$CLAUDE_SKILLS_DIR/$basename" ]; then
            backup_needed=true
            break
        fi
    done

    if [ "$backup_needed" = true ]; then
        local backup_dir="${CLAUDE_SKILLS_DIR}.backup.$(date +%Y%m%d_%H%M%S)"
        print_warning "Existing skills found. Creating backup..."
        cp -r "$CLAUDE_SKILLS_DIR" "$backup_dir"
        print_success "Backup created: $backup_dir"
        echo
    fi
}

install_skills() {
    print_info "Installing skills..."
    echo

    local installed=0
    local updated=0
    local failed=0

    for skill_file in "$SKILLS_SOURCE_DIR"/*.md; do
        [ -e "$skill_file" ] || continue

        local basename=$(basename "$skill_file")
        local skill_name="${basename%.md}"
        local dest_file="$CLAUDE_SKILLS_DIR/$basename"

        if [ -f "$dest_file" ]; then
            # Check if files are different
            if ! cmp -s "$skill_file" "$dest_file"; then
                cp "$skill_file" "$dest_file"
                print_success "Updated: $skill_name"
                ((updated++))
            else
                print_info "Unchanged: $skill_name (already up to date)"
            fi
        else
            cp "$skill_file" "$dest_file"
            print_success "Installed: $skill_name"
            ((installed++))
        fi
    done

    echo
    print_success "Installation complete!"
    echo
    echo "Summary:"
    echo "  - New skills installed: $installed"
    echo "  - Skills updated: $updated"
    echo "  - Skills unchanged: $(($(find "$SKILLS_SOURCE_DIR" -name "*.md" -type f | wc -l | tr -d ' ') - installed - updated))"
    echo
}

print_next_steps() {
    echo -e "${BLUE}Next Steps:${NC}"
    echo "  1. Restart Claude Code (if running)"
    echo "  2. Test the skills by typing '/' in Claude Code"
    echo "  3. Try the tech-debt skill with: /tech-debt"
    echo
    echo -e "${BLUE}Available Skills:${NC}"
    for skill_file in "$SKILLS_SOURCE_DIR"/*.md; do
        [ -e "$skill_file" ] || continue
        local skill_name=$(basename "$skill_file" .md)
        echo "  - /$skill_name"
    done
    echo
    print_info "For more information, see README.md and INSTALLATION.md"
}

# Main installation flow
main() {
    print_header
    check_prerequisites
    create_skills_directory
    backup_existing_skills
    install_skills
    print_next_steps
}

# Run main function
main
