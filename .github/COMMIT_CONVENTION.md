# Conventional Commits Configuration

## Commit Message Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

## Types

| Type | Description |
|------|-------------|
| feat | New feature |
| fix | Bug fix |
| docs | Documentation changes |
| style | Code style changes (formatting, semicolons, etc) |
| refactor | Code refactoring |
| perf | Performance improvements |
| test | Adding or updating tests |
| chore | Maintenance tasks |

## Examples

```
feat(tui): Add smart random command
fix(gui): Resolve thumbnail generation crash
docs(readme): Update installation instructions
perf(picker): Optimize video scanning speed
```

## Scope Options

| Scope | Description |
|-------|-------------|
| tui | Terminal UI changes |
| gui | Graphical UI changes |
| picker | Wallpaper picker logic |
| config | Configuration handling |
| docs | Documentation |
| ci | CI/CD workflows |
| aur | AUR package |
| release | Release process |

## Breaking Changes

Add `!` before `:` or add `BREAKING CHANGE:` in footer:

```
feat(config)!: Change default config format

BREAKING CHANGE: Old config files are no longer compatible.
```
