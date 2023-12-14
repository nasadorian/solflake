# solflake

Anttempt at Nix-ifying the Solana toolchain for reproducible builds with pinned dependencies.
This repository is a work in progress and contributions are welcome!

# Usage
Assuming [Nix](nixos.org) is already installed, this repository can be directly referenced in a `flake.nix` file for a Solana project.

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
