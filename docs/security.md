# Security

## Threat model

These scripts run as the developer and inherit the privileges and environment
of the invoking Git process. Treat them as trusted code and review updates
before installing them into a repository.

## SSH signing keys

The signing commands pass the configured key path directly to OpenSSH. They
do not print key contents or passphrases. Only use private keys you control.
An agent may prompt for a passphrase.

## Commit trailers

Commit trailers are metadata, not proof of security. A configuration digest
helps identify the configuration used at commit time, but does not prove that
the checks ran or passed.

## CI skip controls

The push check is a developer-side guard. It can be bypassed by changing or
removing local hooks. GitHub Actions workflows, required checks, protected
branches and repository rulesets are the authoritative controls.

## GitHub Actions

Workflows use least-privilege permissions, pinned third-party actions,
concurrency controls and separate CI and release workflows. Release publishing
is restricted to version tags and requires a signed tag.
