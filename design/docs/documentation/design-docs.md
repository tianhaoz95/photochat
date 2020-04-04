# Design Docs

Design docs site: <https://minidonkey.github.io/design-docs>

Design docs should cover all the high level designs that are hard to cover in comments.

## Overview

For simplicity, design docs primarily are written in `markdown` and rendered with [VuePress](https://vuepress.vuejs.org/).

## Getting started

### Prerequisites

- Node JS: [official installation guide](https://nodejs.org/en/)
- Yarn: [official installation guide](https://yarnpkg.com/getting-started/install)

### Start locally

```bash
# Clone the repsository if you haven't done so
git clone https://github.com/tianhaoz95/photochat.git

# Go to the design docs sub-project
cd photochat/design

# Install dependencies
yarn install

# Start the design docs site locally
yarn docs:dev

# The local design docs site should start in http://localhost:8080
```

### Code formatting

```bash
yarn docs:format
```

::: warning
Please make sure to format the code every time before pushing to the repository. Otherwise the linter checks will fail and block pull request merging.
:::

### Building the site

```bash
yarn docs:build
# The static site generated locates in docs/.vuepress/dist
```

::: warning
You almost never have to do this because the design docs are automatically deployed to the site with every valid pull request merge to the `master` branch.
:::

### Deploy the docs

The design docs are deployed to [this repository](https://github.com/MiniDonkey/design-docs) and hosted with [GitHub Pages](https://pages.github.com/).

### Manual Deployment

First copy the files generated (located in `docs/.vuepress/dist`) from the [build step](#building-the-site) to a location outside the repository (e.g. `/tmp/design-docs`).

```bash
# This script assumes copying the static site into /tmp/design-docs
cd /tmp/design-docs
git init
git remote add origin https://github.com/MiniDonkey/design-docs.git
git add -A
git commit -m "docs: update"
git push -u -f origin master
```

::: warning
You almost never have to do this because the design docs are automatically uploaded to the hosting repository every time a pull request is merged into the `master` branch.
:::
