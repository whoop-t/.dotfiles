# My agent instructions

These are common instructions for my agents across all scenarios.

## General Guidelines

- Never use the em dash "—". Use plain dash "-" instead.
- When writing commit messages, NEVER auto-add your agent name as co-author.
- Never manually modify CHANGELOG.md files or any files that are marked as auto-generated.
- When writing or substantially editing long Markdown files, put each full sentence on its own line.
  Preserve normal Markdown structure, but avoid wrapping multiple sentences onto one physical line.
- When making technical decisions, do not give much weight to development cost.
  Instead, prefer quality, simplicity, robustness, scalability, and long term maintainability.
- Always create branches with a type prefix: `feat/`, `fix/`, `chore/`, etc. (e.g. `feat/add-login`).
- Always write PR titles to follow the Conventional Commits format (e.g. `feat: add login`, `fix: handle null user`).
