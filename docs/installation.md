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
artifacts are published. The release process publishes a versioned source
archive, checksum file and GitHub build-provenance attestation.

## Requirements

- POSIX-compatible shell.
- Git.
- OpenSSH client utilities for SSH signing-key commands.
- `sha256sum` or `shasum` for configuration digests.

The SSH signing commands require an accessible `ssh-agent` and a private key
file configured as `user.signingKey`.

## hk integration

A repository can invoke commands from its own `hk.pkl`. For example, hk
exposes `commit_msg_file` to the `prepare-commit-msg` and `commit-msg`
hooks:

```pkl
hooks {
  ["prepare-commit-msg"] {
    fix = true
    steps {
      ["config-trailer"] {
        fix = "git-hooks trailers add-config-trailer {{commit_msg_file}}"
      }
    }
  }
}
```

Install hk's Git hooks with mise integration:

```sh
hk install --mise
```

See the [hk hook documentation](https://hk.jdx.dev/hooks.html) for event
arguments and lifecycle details.
