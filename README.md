# mdu

GitHub Pages action to render Markdown documentation with [MDU](https://github.com/capjan/markdown-util) and publish it.

## Quick start

1. In the repository settings, open **Pages** and set **Build and deployment → Source** to **GitHub Actions**.
2. Add `.github/workflows/publish.yml`:

```yaml
name: Publish docs

on:
  push:
    branches: [main]
    paths:
      - 'docs/**'

permissions:
  contents: read
  pages: write
  id-token: write

jobs:
  publish:
    runs-on: ubuntu-latest
    environment:
      name: github-pages
    steps:
      - uses: capjan/mdu-action@v1
```

The workflow runs only when files under `docs/` change. The action checks out the repository, renders `docs` to `site` with the pinned MDU Docker image, and deploys the result. If your folder is named `Docs`, change the path filter to `Docs/**` and set the action input:

```yaml
        with:
          docs-path: Docs
```

The job must run on a Linux runner with Docker installed. GitHub-hosted `ubuntu-latest` runners meet this requirement.

## Inputs

| Input | Default | Description |
| --- | --- | --- |
| `docs-path` | `docs` | Folder containing Markdown documentation. |
| `output-path` | `site` | Folder for the generated site. |
| `edit-page-root` | empty | Optional URL to the repository folder where the Markdown files can be edited. |
| `mdu-version` | `5.1.0` | MDU Docker image tag to use. |

The action returns the deployed site URL as the `page_url` output.
