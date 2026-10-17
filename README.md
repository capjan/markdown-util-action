# MarkdownUtil GitHub Pages Action

Render Markdown documentation with [MarkdownUtil](https://github.com/capjan/markdown-util) and publish it to GitHub Pages.

## Quick start

1. In the repository settings, open **Pages** and set **Build and deployment → Source** to **GitHub Actions**.
2. Add `.github/workflows/publish.yml`:

```yaml
name: Publish docs

on:
  push:
    branches: [main]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: pages
  cancel-in-progress: false

jobs:
  publish:
    runs-on: ubuntu-latest
    environment:
      name: github-pages
      url: ${{ steps.publish.outputs.page_url }}
    steps:
      - name: Publish
        id: publish
        uses: capjan/markdown-util-action@v1
```

The action checks out the repository, installs .NET 10 and MarkdownUtil, renders `docs` to `site`, and deploys the result. Set `docs-path` if your Markdown files are in a different folder. For example, use `Docs` for a capitalized folder:

```yaml
        with:
          docs-path: Docs
```

## Inputs

| Input | Default | Description |
| --- | --- | --- |
| `docs-path` | `docs` | Folder containing Markdown documentation. |
| `output-path` | `site` | Folder for the generated site. |
| `edit-page-root` | empty | Optional URL to the repository folder where the Markdown files can be edited. |

The action returns the deployed site URL as the `page_url` output.
