# Security Policy

## Supported versions

Only the latest version on the default branch is currently supported. Once
versioned releases are established, the supported release policy will be
documented here.

## Reporting a vulnerability

Do not report exploitable vulnerabilities in public issues. Use GitHub's
private vulnerability reporting feature for this repository. Include the
affected command, reproduction steps, impact and any suggested mitigation.

Please allow time for investigation and a coordinated fix before public
disclosure.

## Security design

- Scripts are POSIX shell and avoid evaluating untrusted input.
- SSH key operations delegate to OpenSSH `ssh-add`; private key contents are
  never read or printed by this project.
- Push policy checks inspect Git push options and commits being pushed.
- Git hooks can be bypassed or not installed. Mandatory controls must also be
  enforced by CI, protected branches and server-side policy.
- GitHub Actions use read-only permissions by default and narrowly scoped
  release permissions.
