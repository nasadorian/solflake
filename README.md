# solflake

An attempt at Nix-ifying the Solana toolchain for reproducible builds with pinned dependencies.

*This repository is a work in progress and contributions are welcome!*


## Install
Assuming [Nix](nixos.org) is already installed, this project can be used
directly from the command line to load the Solana platform in a shell.

```nix
$ nix develop github:nasadorian/solflake
```

It can also be referenced in a `flake.nix` file for a Solana project.

```nix
{
  description = "A very basic Solana flake";
  inputs = {
    solflake.url = "github:nasadorian/solflake";
  };
  outputs = { self, solflake }: {
    ...
  };
}
```

## Usage
Once the flake has been loaded into the developer environment, a Solana program
project can be compiled using `cargo` directly.

```sh
cargo build --release --target sbf-solana-solana
```

Please note that the `cargo-build-sbf` tool and `cargo build-sbf` will not
work, as they depend on `rustup`, which this flake intentionally elides.

## Supported Versions
Version is currently pinned to Solana `v1.17.6` and platform-tools `v1.39`
while development is underway. The longer term aim is to mirror all available
upstream releases so the flake can be used with a version tag.

## Supported Systems
System support mirrors that of [solana](https://github.com/solana-labs/solana)
and [platform-tools](https://github.com/solana-labs/platform-tools).
* Linux `x86_64`
* Darwin `x86_64` and `aarch64` aka Apple Silicon
* Windows **not yet supported, please contribute**
