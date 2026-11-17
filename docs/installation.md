# Installation

## From a source checkout

The project is currently distributed as source. Clone it and add its `bin`
directory to your `PATH`:

```sh
git clone https://github.com/adam-moss/git-hooks.git
export PATH="$PWD/git-hooks/bin:$PATH"
git-hooks --help
```

For a durable installation, install a tagged release through mise once release
artifacts are published. The release process is designed to publish a
versioned source archive and checksum file.

## Requirements

- POSIX-compatible shell.
- Git.
- OpenSSH client utilities for SSH signing-key commands.
- `sha256sum` or `shasum` for configuration digests.

The SSH signing commands require an accessible `ssh-agent` and a private key
file configured as `user.signingKey`.

## hk integration

A repository can invoke commands from its own `hk.pkl`. For example:

```pkl
["git-hooks-config-trailer"] {
  check = "git-hooks trailers add-config-trailer {{commit_msg_file}}"
}
```

The command must be attached to a hook that supplies a commit-message file.
Configure the appropriate Git lifecycle hook for your workflow; do not assume a
generic hk check has a commit-message argument.
