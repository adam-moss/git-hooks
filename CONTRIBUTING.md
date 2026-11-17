# Contributing

Contributions are welcome. Please open an issue before substantial changes so
that the intended behaviour and compatibility impact can be discussed.

## Development setup

Install the pinned tools and install hk's Git hooks:

```sh
mise install
hk install --mise
```

Run the complete local validation suite:

```sh
mise run ci
```

Individual tasks are available:

- `mise run lint:shell`
- `mise run format:shell`
- `mise run lint:markdown`
- `mise run format:markdown`
- `mise run lint:actions`
- `mise run lint:links`
- `mise run test`
- `mise run docs:build`

## Shell requirements

- Write portable POSIX `sh`; do not rely on Bash, Zsh or shell-specific arrays.
- Quote expansions unless splitting or globbing is intentional.
- Use explicit error handling and useful diagnostics.
- Never use `eval` with user-controlled input.
- Do not log private key material, passphrases, tokens or other secrets.
- Keep commands composable and return meaningful exit statuses.

## Tests

Use ShellSpec for unit and integration coverage. Run the suite with
`mise run test`; use `mise run test --shell dash` to exercise it with dash.
Tests must not require access to a real SSH agent, a real signing key, or a
network service. Use temporary Git repositories and stub executables where
practical.

## Pull requests

- Explain the problem and the behavioural change.
- Include tests and documentation.
- Keep changes focused.
- Do not update pinned tools without explaining why.
- Ensure the CI workflow passes.
- Never include credentials, private keys or personal data.

By contributing, you agree that your contribution may be distributed under the
project's eventual open-source licence. The project licence is currently
unselected; please do not submit contributions until the repository owner has
added a licence and clarified contribution terms.
