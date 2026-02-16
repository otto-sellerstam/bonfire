# Bonfire — My Python Project Template

A [Copier](https://copier.readthedocs.io/) template for Python projects with modern tooling. Supports **standalone projects** and **monorepos** from a single template.

## What's included

- **[uv](https://docs.astral.sh/uv/)** — Package & environment management (with workspace support for monorepos)
- **[Ruff](https://docs.astral.sh/ruff/)** — All lint rules enabled + formatting (replaces Black, Flake8, isort, etc.)
- **[Pyrefly](https://pyrefly.org/)** — Meta's Rust-based type checker in strict mode
- **[Pytest](https://docs.pytest.org/)** — Testing with coverage enforcement (80% threshold)
- **[Just](https://github.com/casey/just)** — Modern task runner (cleaner alternative to Make)
- **[Pre-commit](https://pre-commit.com/)** — Git hooks for lint + format on every commit
- **CLAUDE.md** — AI assistant context file for Claude Code / Claude chat
- **GitHub Actions** — Optional CI workflow
- **src/ layout** — [Recommended project structure](https://packaging.python.org/en/latest/discussions/src-layout-vs-flat-layout/)

## Usage

### Create a new project

```bash
# Install copier (one-time)
uv tool install copier

# Generate a standalone project
copier copy gh:ottosellerstam/bonfire my-new-project

# Generate a monorepo (select "monorepo" when prompted)
copier copy gh:ottosellerstam/bonfire my-platform
```

### Update an existing project

Existing projects can pull in the changes by:

```bash
cd my-existing-project
copier update
```

Copier will merge template changes, flagging conflicts for manual resolution.

For monorepos, add or remove packages by modifying the `packages` list during `copier update`.

## Template options

| Option | Default | Description |
|--------|---------|-------------|
| `project_name` | — | Project name (e.g. `my-platform` or `my-library`) |
| `project_type` | `standalone` | Standalone project or monorepo |
| `module_name` | derived from name | Python module name (standalone only) |
| `packages` | — | List of package names as YAML (monorepo only, e.g. `[core, api]`) |
| `description` | `""` | Short project description |
| `author_name` | `""` | Author name |
| `author_email` | `""` | Author email |
| `python_version` | `3.12` | Minimum Python version (3.11–3.14) |
| `license` | `MIT` | License (MIT/Apache-2.0/Proprietary) |
| `include_github_actions` | `true` | Include GitHub Actions CI workflow |

## Generated structures

### Standalone

```
my-project/
├── src/
│   └── my_project/
│       ├── __init__.py
│       ├── logging.py
│       └── py.typed
├── tests/
│   ├── conftest.py
│   └── test_placeholder.py
├── .github/workflows/ci.yml
├── .copier-answers.yml
├── .gitignore
├── .pre-commit-config.yaml
├── .python-version
├── CLAUDE.md
├── LICENSE
├── README.md
├── justfile
└── pyproject.toml
```

### Monorepo

```
my-platform/
├── core/
│   ├── src/core/
│   ├── tests/
│   ├── CLAUDE.md
│   ├── justfile
│   └── pyproject.toml
├── api/
│   ├── src/api/
│   ├── tests/
│   ├── CLAUDE.md
│   ├── justfile
│   └── pyproject.toml
├── .github/workflows/ci.yml
├── .copier-answers.yml
├── .gitignore
├── .pre-commit-config.yaml
├── .python-version
├── CLAUDE.md
├── LICENSE
├── README.md
├── justfile
└── pyproject.toml          # Workspace root: shared tool config + dev deps
```

## Config philosophy

### Standalone

Everything lives in a single `pyproject.toml` — project metadata, build system, and all tool configuration.

### Monorepo

Config is split based on how each tool resolves settings:

- **Root `pyproject.toml`**: Workspace definition, shared dev dependencies, Ruff rules, Pyrefly settings, Pytest options, coverage thresholds
- **Package `pyproject.toml`**: Only package metadata, build system, and per-package `[tool.coverage.run]`
- Sub-packages **inherit** Ruff/Pyrefly/Pytest config from root automatically (no duplication)

### Ruff: ALL rules enabled

We use `select = ["ALL"]` and explicitly ignore only rules that conflict with the formatter, conflict with each other, are deprecated, or are too noisy for practical use. Tests get relaxed rules via `per-file-ignores`.

### Pyrefly: strict mode

Pyrefly's default is already strict. We additionally enable `missing-return-annotation` and `missing-override-decorator`.

> **Note:** Pyrefly is in beta. Use `# pyrefly: ignore` for false positive suppression.

### Coverage: 80% threshold

Coverage uses `fail_under = 80` with branch coverage. Common exclusion patterns (`TYPE_CHECKING`, `@overload`, `__main__`) are pre-configured.

## Requirements

- [Copier](https://copier.readthedocs.io/) ≥ 9.5.0 (for `{% yield %}` monorepo support)
- [uv](https://docs.astral.sh/uv/) (for dependency management)
- [Just](https://github.com/casey/just) (for task running)
