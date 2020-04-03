# Design Docs

## Prerequisites

- Node JS: [official installation guide](https://nodejs.org/en/)
- Yarn: [official installation guide](https://yarnpkg.com/getting-started/install)

## Getting started

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

## Code formatting

```bash
yarn docs:format
```

::: warning
Please make sure to format the code every time before pushing to the repository. Otherwise the linter checks will fail and block pull request merging.
:::

## Building the site

```bash
yarn docs:build
```

::: warning
You almost never have to do this because the design docs are automatically deployed to the site with every valid pull request merge to the `master` branch.
:::
