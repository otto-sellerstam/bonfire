# Python Project Template

A [Copier](https://copier.readthedocs.io/) template for Python projects with modern tooling.

## What You Get

- **[uv](https://docs.astral.sh/uv/)** — Blazing-fast package & environment management
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

# Generate a new project
copier copy gh:YOUR_USERNAME/python-template my-new-project

# Or use the latest unreleased version
copier copy --vcs-ref=HEAD gh:YOUR_USERNAME/python-template my-new-project
```

### Update an existing project

When you improve this template, existing projects can pull in the changes:

```bash
cd my-existing-project
copier update
```

Copier will intelligently merge template changes, flagging conflicts for manual resolution.

## Template Options

| Option | Default | Description |
|--------|---------|-------------|
| `project_name` | — | Project name (e.g. `my-awesome-project`) |
| `module_name` | derived from name | Python module name |
| `description` | `""` | Short project description |
| `author_name` | `Otto` | Author name |
| `author_email` | `""` | Author email |
| `python_version` | `3.12` | Minimum Python version (3.11/3.12/3.13) |
| `license` | `MIT` | License (MIT/Apache-2.0/Proprietary) |
| `include_github_actions` | `true` | Include GitHub Actions CI workflow |

## Generated Project Structure

```
my-project/
├── .github/
│   └── workflows/
│       └── ci.yml
├── src/
│   └── my_project/
│       ├── __init__.py
│       └── py.typed
├── tests/
│   ├── __init__.py
│   ├── conftest.py
│   └── test_placeholder.py
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

## Tool Configuration Philosophy

Everything lives in `pyproject.toml`. No scattered config files.

### Ruff: ALL Rules Enabled

We use `select = ["ALL"]` and explicitly ignore only rules that:
- Conflict with the Ruff formatter (14 rules)
- Conflict with each other (e.g. D203 vs D211)
- Are deprecated (ANN101/ANN102)
- Are too noisy for practical use (ERA001, TD003, FIX002)

Tests get relaxed rules via `per-file-ignores` (no docstrings, no type annotations, asserts allowed, etc.).

### Pyrefly: Strict Mode

Pyrefly's default is already strict — it checks all function bodies and infers return types (`check-and-infer-return-type`). We additionally enable:
- `missing-return-annotation = true`
- `missing-override-decorator = true`

> **Note:** Pyrefly is currently in beta (v0.50+). It's very fast and actively developed, but you may encounter false positives with some libraries. Use `# pyrefly: ignore` for suppression.

### Coverage: 80% Threshold

Coverage is configured with `fail_under = 80` and branch coverage enabled. Common exclusion patterns (`TYPE_CHECKING`, `@overload`, `__main__`) are pre-configured.

## Why Copier over Cookiecutter?

Copier supports **updating existing projects** when the template evolves. Change the template → run `copier update` in your projects → changes propagate. Cookiecutter is fire-and-forget. The `.copier-answers.yml` file tracks which template version and answers were used, making updates seamless.

## Why Just over Make?

Just is a purpose-built task runner with sane syntax (spaces, not tabs), recipe arguments, better error messages, and no `.PHONY` boilerplate. See the [Just README](https://github.com/casey/just) for a full comparison.
