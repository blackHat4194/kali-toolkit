# Contributing to Kali Toolkit

Thank you for your interest in improving Kali Toolkit!

## How to Contribute

1. Fork the repository.
2. Create a feature branch.
3. Make a focused change.
4. Test the affected scripts.
5. Submit a pull request describing the change and its purpose.

## Coding Guidelines

- Use Bash-compatible syntax.
- Quote variables used as file paths.
- Prefer functions for reusable logic.
- Handle missing commands and invalid input gracefully.
- Use clear messages and consistent terminal colors.
- Ask for confirmation before destructive operations.
- Do not overwrite existing user files without explicit confirmation.
- Avoid hardcoded home-directory paths.

## Testing

Run Bash syntax checks on changed scripts:

```bash
bash -n main.sh
bash -n explorer.sh
```

Repeat the check for every modified script. Test file operations inside a temporary directory before using real data.

## Security

Do not submit credentials, API keys, private backups, personal data, or unreviewed third-party code.

For security-sensitive reports, follow SECURITY.md rather than posting exploit details publicly.

## Pull Requests

Explain what changed, why it is needed, how it was tested, and whether it introduces new dependencies.