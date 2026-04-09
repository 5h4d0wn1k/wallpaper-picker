# Contributing to wallpaper-picker

Thank you for your interest in contributing to wallpaper-picker!

## Code of Conduct

This project adheres to the [Contributor Covenant Code of Conduct](https://www.contributor-covenant.org/).
By participating, you are expected to uphold this code.

## How to Contribute

### Reporting Bugs

1. **Search first** - Check if the bug has already been reported
2. **Use the template** - Include system info, steps to reproduce, and expected behavior
3. **Be specific** - Include your distribution, Hyprland version, and relevant config

### Suggesting Features

1. **Open an issue** - Describe the feature and its use case
2. **Be open to discussion** - The maintainer may have suggestions or concerns
3. **Consider scope** - Keep feature requests focused and reasonable

### Pull Requests

1. **Fork and branch** - Create a feature branch from `main`
2. **Follow the style** - Match existing code style
3. **Test your changes** - Ensure all tests pass
4. **Write clear commits** - Use descriptive commit messages
5. **Update docs** - Include relevant documentation updates

## Development Setup

```bash
# Clone your fork
git clone https://github.com/YOUR_USERNAME/wallpaper-picker.git
cd wallpaper-picker

# Install dependencies
sudo pacman -S mpvpaper fzf mpv jq ffmpeg

# Run tests
./tests/run_tests.sh

# Test locally
./wallpaper-picker pick
```

## Coding Standards

### Shell Script (wallpaper-picker)

- Use `set -euo pipefail` for strict mode
- Use `[[ ]]` for conditionals (not `[ ]`)
- Quote all variables that could contain spaces
- Use `readonly` for constants
- Follow the existing function structure
- Add logging for important actions

### Python (wallpaper-picker-gui)

- Follow PEP 8 style guidelines
- Use type hints where appropriate
- Add docstrings to all functions and classes
- Handle errors gracefully with informative messages

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
