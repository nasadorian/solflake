{
  description = "Basic Solana dev environment";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/23.11";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem [
      "aarch64-darwin" "x86_64-linux"
    ] (system:
      with import nixpkgs { inherit system; };
      let
        platforms = import ./platforms { inherit fetchzip; };
        solana-platform = stdenv.mkDerivation {
          name = "solana-rust";
          version = platforms.platform-tools.version;
          src = platforms.platform-tools.${system};
          installPhase = ''
            mkdir -p $out
            cp -r $src/* $out
            chmod 0755 -R $out
          '';
        };
        solana-cli = stdenv.mkDerivation {
          name = "solana-cli";
          version = platforms.cli.version;
          src = platforms.cli.${system};
          installPhase = ''
            mkdir -p $out/bin/sdk/sbf/dependencies/platform-tools
            cp -r $src/* $out
            ln -s ${solana-platform}/* $out/bin/sdk/sbf/dependencies/platform-tools
            ln -s ${solana-platform}/rust/bin/* $out/bin/
            ln -s ${solana-platform}/llvm/bin/* $out/bin/
            ln -s $out/bin/ld.lld $out/bin/ld
            chmod 0755 -R $out
          '';
        };
      in {
        packages = { default = solana-cli; };
        devShells = {
          default = mkShellNoCC {
            CC = "${solana-platform}/llvm/bin/clang";
            AR = "${solana-platform}/llvm/bin/llvm-ar";
            OBJDUMP = "${solana-platform}/llvm/bin/llvm-objdump";
            OBJCOPY = "${solana-platform}/llvm/bin/llvm-objcopy";
            RUSTC = "${solana-platform}/rust/bin/rustc";
            RUSTFLAGS = "linker=ld.lld -C ar=llvm-ar";
            CARGO_CFG_TARGET_OS = "solana";
            CARGO_BUILD_TARGET = "sbf-solana-solana";
            buildInputs = [
              darwin.apple_sdk.frameworks.System
              darwin.apple_sdk.frameworks.Security
              darwin.apple_sdk.frameworks.SystemConfiguration
              darwin.apple_sdk.frameworks.CoreFoundation
              darwin.apple_sdk.frameworks.CoreServices
            ];
            packages = [ solana-cli ];
          };
        };
      }
    );
}
