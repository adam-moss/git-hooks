# Contributing

Contributions are welcome. Please open an issue before substantial changes so
that the intended behaviour and compatibility impact can be discussed.

## Development setup

Install the pinned tools and install hk's Git hooks:

```sh
mise install
hk install --mise
```

Run the complete validation suite:

```sh
mise run ci
```

## Coding standards

- Write portable POSIX `sh`; do not rely on Bash, Zsh or shell-specific arrays.
- Quote expansions unless splitting or globbing is intentional.
- Use explicit error handling and useful diagnostics.
- Never use `eval` with user-controlled input.
- Do not log private key material, passphrases, tokens or other secrets.
- Keep commands composable and return meaningful exit statuses.

## Tests

Add regression coverage for new behaviour. Tests must not require access to a
real SSH agent, a real signing key or a network service. Use temporary Git
repositories and stub executables where practical.

## Pull requests

- Explain the problem and the behavioural change.
- Include tests and documentation.
- Keep changes focused.
- Do not update pinned tools without explaining why.
- Ensure CI passes.
- Never include credentials, private keys or personal data.

The project licence has not yet been selected. External contributions should
not be submitted until the repository owner has added a licence and clarified
contribution terms. See [Licensing](licensing.md).
