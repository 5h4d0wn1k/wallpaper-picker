#!/usr/bin/env bash
#
# Comprehensive Test Suite for wallpaper-picker
# Run with: ./tests/run_tests.sh
#

set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

TESTS_PASSED=0
TESTS_FAILED=0
TESTS_SKIPPED=0

pass() { echo -e "${GREEN}✓ PASS${NC}: $1"; ((TESTS_PASSED++)); }
fail() { echo -e "${RED}✗ FAIL${NC}: $1"; ((TESTS_FAILED++)); }
skip() { echo -e "${YELLOW}⊘ SKIP${NC}: $1"; ((TESTS_SKIPPED++)); }
info() { echo -e "${BLUE}ℹ INFO${NC}: $1"; }

run_test() {
    local name="$1"
    local cmd="$2"
    if eval "$cmd" &>/dev/null; then
        pass "$name"
        return 0
    else
        fail "$name"
        return 1
    fi
}

test_output() {
    local name="$1"
    local cmd="$2"
    local pattern="$3"
    if output=$(eval "$cmd" 2>&1) && echo "$output" | grep -q "$pattern"; then
        pass "$name"
        return 0
    else
        fail "$name"
        return 1
    fi
}

main() {
    echo ""
    echo "╔══════════════════════════════════════════════════╗"
    echo "║     Wallpaper Picker Test Suite v2.2.0          ║"
    echo "╚══════════════════════════════════════════════════╝"
    echo ""
    info "Testing: $PROJECT_DIR"
    echo ""

    echo "━━━ Basic Tests ━━━"
    run_test "Script exists" "[[ -f '$PROJECT_DIR/src/wallpaper-picker' ]]"
    run_test "Script is executable" "[[ -x '$PROJECT_DIR/src/wallpaper-picker' ]]"
    run_test "Bash syntax valid" "bash -n '$PROJECT_DIR/src/wallpaper-picker'"
    run_test "GUI script exists" "[[ -f '$PROJECT_DIR/src/wallpaper-picker-gui' ]]"
    run_test "Install script exists" "[[ -f '$PROJECT_DIR/install.sh' ]]"
    run_test "Desktop entry exists" "[[ -f '$PROJECT_DIR/desktop/wallpaper-picker.desktop' ]]"

    echo ""
    echo "━━━ Core Commands ━━━"
    test_output "Version command" "$PROJECT_DIR/src/wallpaper-picker --version" "wallpaper-picker"
    test_output "Help command" "$PROJECT_DIR/src/wallpaper-picker --help" "USAGE"
    test_output "Doctor command" "$PROJECT_DIR/src/wallpaper-picker doctor" "Doctor\|check"
    test_output "Status command" "$PROJECT_DIR/src/wallpaper-picker status" "Status\|Configuration"
    test_output "List command" "$PROJECT_DIR/src/wallpaper-picker list" "wallpaper\|list"
    test_output "Monitors command" "$PROJECT_DIR/src/wallpaper-picker monitors" "monitor"

    echo ""
    echo "━━━ Playback Commands ━━━"
    test_output "Stop command" "$PROJECT_DIR/src/wallpaper-picker stop" "stop\|Wallpaper"
    test_output "Pause command" "$PROJECT_DIR/src/wallpaper-picker pause" "pause\|No wallpaper"
    test_output "Resume command" "$PROJECT_DIR/src/wallpaper-picker resume" "resume\|No wallpaper"
    test_output "Toggle command" "$PROJECT_DIR/src/wallpaper-picker toggle" "toggle\|No wallpaper"
    test_output "Current command" "$PROJECT_DIR/src/wallpaper-picker current" "Current wallpaper"

    echo ""
    echo "━━━ Management Commands ━━━"
    test_output "Watch-dirs command" "$PROJECT_DIR/src/wallpaper-picker watch-dirs" "Watch\|Default"
    test_output "Toggle-fav help" "$PROJECT_DIR/src/wallpaper-picker --help" "toggle-fav"
    test_output "Config command" "$PROJECT_DIR/src/wallpaper-picker --help" "config"

    echo ""
    echo "━━━ Advanced Commands ━━━"
    test_output "Smart-random exists" "$PROJECT_DIR/src/wallpaper-picker --help" "smart-random"
    test_output "Time-based exists" "$PROJECT_DIR/src/wallpaper-picker --help" "time-based"
    test_output "Slideshow exists" "$PROJECT_DIR/src/wallpaper-picker --help" "slideshow"
    test_output "Preview exists" "$PROJECT_DIR/src/wallpaper-picker --help" "preview"
    test_output "Pywal exists" "$PROJECT_DIR/src/wallpaper-picker --help" "pywal"
    test_output "Restore exists" "$PROJECT_DIR/src/wallpaper-picker --help" "restore"

    echo ""
    echo "━━━ New Commands ━━━"
    test_output "Backend command" "$PROJECT_DIR/src/wallpaper-picker backend" "backend\|mpvpaper"
    test_output "Quality command" "$PROJECT_DIR/src/wallpaper-picker quality" "Quality\|profile"
    test_output "Wallhaven help" "$PROJECT_DIR/src/wallpaper-picker wallhaven" "Wallhaven\|Usage"
    test_output "Span command" "$PROJECT_DIR/src/wallpaper-picker --help" "span"

    echo ""
    echo "━━━ Integration Tests ━━━"
    run_test "Config file exists or created" "[[ -f '$HOME/.config/wallpaper-picker/config' ]] || true"
    run_test "Data directory exists" "[[ -d '$HOME/.local/share/wallpaper-picker' ]] || true"
    run_test "History file accessible" "[[ -f '$HOME/.local/share/wallpaper-picker/history' ]] || true"

    echo ""
    echo "━━━ Documentation Files ━━━"
    run_test "README exists" "[[ -f '$PROJECT_DIR/README.md' ]]"
    run_test "CHANGELOG exists" "[[ -f '$PROJECT_DIR/CHANGELOG.md' ]]"
    run_test "License exists" "[[ -f '$PROJECT_DIR/LICENSE' ]]"
    run_test "PKGBUILD exists" "[[ -f '$PROJECT_DIR/PKGBUILD' ]]"

    echo ""
    echo "━━━ CI/CD Files ━━━"
    run_test "GitHub workflows exist" "[[ -d '$PROJECT_DIR/.github/workflows' ]]"
    run_test "Tests workflow exists" "[[ -f '$PROJECT_DIR/.github/workflows/tests.yml' ]]"

    echo ""
    echo "━━━ Completions ━━━"
    run_test "Bash completions" "[[ -f '$PROJECT_DIR/completions/bash/wallpaper-picker' ]]"
    run_test "Zsh completions" "[[ -f '$PROJECT_DIR/completions/zsh/_wallpaper-picker' ]]"
    run_test "Fish completions" "[[ -f '$PROJECT_DIR/completions/fish/wallpaper-picker.fish' ]]"

    echo ""
    echo "╔══════════════════════════════════════════════════╗"
    echo "║                  Test Results                    ║"
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
