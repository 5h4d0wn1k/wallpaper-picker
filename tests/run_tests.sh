#!/usr/bin/env bash
#
# Test Suite for wallpaper-picker
# Run with: ./tests/run_tests.sh
#

set -uo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Counters
TESTS_PASSED=0
TESTS_FAILED=0
TESTS_SKIPPED=0

# Test functions
pass() {
    echo -e "${GREEN}✓ PASS${NC}: $1"
    ((TESTS_PASSED++))
}

fail() {
    echo -e "${RED}✗ FAIL${NC}: $1"
    ((TESTS_FAILED++))
}

skip() {
    echo -e "${YELLOW}⊘ SKIP${NC}: $1"
    ((TESTS_SKIPPED++))
}

info() {
    echo -e "${BLUE}ℹ INFO${NC}: $1"
}

# Check if command exists
has_command() {
    command -v "$1" >/dev/null 2>&1
}

# Test: Script exists and is executable
test_script_exists() {
    if [[ -x "$SCRIPT_DIR/src/wallpaper-picker" ]]; then
        pass "Script exists and is executable"
    else
        fail "Script missing or not executable"
    fi
}

# Test: Script has valid syntax
test_script_syntax() {
    if bash -n "$SCRIPT_DIR/src/wallpaper-picker" 2>/dev/null; then
        pass "Script has valid bash syntax"
    else
        fail "Script has syntax errors"
    fi
}

# Test: Version command works
test_version() {
    if "$SCRIPT_DIR/src/wallpaper-picker" --version | grep -q "wallpaper-picker"; then
        pass "Version command works"
    else
        fail "Version command failed"
    fi
}

# Test: Help command works
test_help() {
    if "$SCRIPT_DIR/src/wallpaper-picker" --help | grep -q "USAGE"; then
        pass "Help command works"
    else
        fail "Help command failed"
    fi
}

# Test: Doctor command works
test_doctor() {
    local output
    output=$("$SCRIPT_DIR/src/wallpaper-picker" doctor 2>&1 | cat)
    if echo "$output" | grep -qi "doctor\|check\|passed"; then
        pass "Doctor command works"
    else
        fail "Doctor command failed"
    fi
}

# Test: List command works
test_list() {
    local output
    output=$("$SCRIPT_DIR/src/wallpaper-picker" list 2>&1 | cat)
    if echo "$output" | grep -qi "wallpaper\|available"; then
        pass "List command works"
    else
        fail "List command failed"
    fi
}

# Test: Monitors command works
test_monitors() {
    local output
    output=$("$SCRIPT_DIR/src/wallpaper-picker" monitors 2>&1 | cat)
    if echo "$output" | grep -qi "monitor\|available"; then
        pass "Monitors command works"
    else
        fail "Monitors command failed"
    fi
}

# Test: Random command works
test_random() {
    local output
    output=$("$SCRIPT_DIR/src/wallpaper-picker" random 2>&1 | cat)
    if echo "$output" | grep -qi "wallpaper set\|set:"; then
        pass "Random command works"
    else
        skip "Random command (no wallpapers or mpvpaper)"
    fi
}

# Test: Status command works
test_status() {
    local output
    output=$("$SCRIPT_DIR/src/wallpaper-picker" status 2>&1 | cat)
    if echo "$output" | grep -qi "status\|configuration"; then
        pass "Status command works"
    else
        fail "Status command failed"
    fi
}

# Test: Config file is created
test_config_created() {
    if [[ -f "$HOME/.config/wallpaper-picker/config" ]]; then
        pass "Config file is created"
    else
        info "Config file will be created on first run"
    fi
}

# Test: Watch dirs command works
test_watch_dirs() {
    if "$SCRIPT_DIR/src/wallpaper-picker" watch-dirs 2>&1 | grep -q "Watch\|Default"; then
        pass "Watch-dirs command works"
    else
        fail "Watch-dirs command failed"
    fi
}

# Test: GUI script exists
test_gui_exists() {
    if [[ -f "$SCRIPT_DIR/src/wallpaper-picker-gui" ]]; then
        pass "GUI script exists"
    else
        skip "GUI script not present"
    fi
}

# Main
main() {
    # Navigate to repo root
    cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1
    cd .. || exit 1
    SCRIPT_DIR="$(pwd)"
    
    echo ""
    echo "╔══════════════════════════════════════════════════╗"
    echo "║       Wallpaper Picker Test Suite              ║"
    echo "╚══════════════════════════════════════════════════╝"
    echo ""
    
    info "Running tests from: $SCRIPT_DIR"
    echo ""
    
    # Run tests
    test_script_exists
    test_script_syntax
    test_version
    test_help
    test_doctor
    test_list
    test_monitors
    test_status
    test_watch_dirs
    test_config_created
    test_gui_exists
    test_random
    
    echo ""
    echo "╔══════════════════════════════════════════════════╗"
    echo "║                  Test Results                  ║"
    echo "╚══════════════════════════════════════════════════╝"
    echo ""
    echo -e "  ${GREEN}Passed:${NC}  $TESTS_PASSED"
    echo -e "  ${RED}Failed:${NC}  $TESTS_FAILED"
    echo -e "  ${YELLOW}Skipped:${NC} $TESTS_SKIPPED"
    echo ""
    
    if [[ $TESTS_FAILED -eq 0 ]]; then
        echo -e "${GREEN}All tests passed!${NC}"
        exit 0
    else
        echo -e "${RED}Some tests failed!${NC}"
        exit 1
    fi
}

main "$@"
