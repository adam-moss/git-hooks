# Documentation versions

Documentation is published to GitHub Pages from the `gh-pages` branch.

- **Development**: [latest changes from `main`](https://adam-moss.github.io/git-hooks/dev/)
- **Latest release**: [current stable documentation](https://adam-moss.github.io/git-hooks/latest/)
- **Versioned releases**: each pushed `v*` tag is published at
  `https://adam-moss.github.io/git-hooks/vX.Y.Z/`

The `latest` alias is updated only by a version-tag deployment. Existing
version directories are retained when a new version is published. Before the
first release tag, the site root redirects to the development documentation;
after the first tag, it redirects to the latest release.
