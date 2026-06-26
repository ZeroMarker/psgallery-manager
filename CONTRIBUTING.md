# Contributing to PsGalleryManager

Thank you for your interest in contributing!

## Development Setup

1. Clone the repository
2. Install dependencies:
   ```powershell
   Install-Module -Name Pester -MinimumVersion 5.0 -Scope CurrentUser
   Install-Module -Name PSScriptAnalyzer -Scope CurrentUser
   ```
3. Import the module:
   ```powershell
   Import-Module ./PsGalleryManager.psd1 -Force
   ```

## Code Style

- Follow [PowerShell Best Practices](https://poshcode.gitbook.io/powershell-practice-and-style/)
- Use approved verbs for function names
- Include comment-based help for all public functions
- Use `SupportsShouldProcess` for commands that modify state
- Support pipeline input where applicable

## Running Tests

```powershell
Invoke-Pester -Path ./Tests -Output Detailed
```

## Running Linter

```powershell
Invoke-ScriptAnalyzer -Path . -Recurse
```

## Commit Convention

This project uses [Conventional Commits](https://www.conventionalcommits.org/):

- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation changes
- `test:` - Test additions or changes
- `refactor:` - Code refactoring
- `ci:` - CI/CD changes

## Pull Requests

1. Create a feature branch from `main`
2. Make your changes
3. Run tests and linter
4. Submit a PR with a clear description
