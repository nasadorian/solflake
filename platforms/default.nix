{ fetchzip }:
{
  platform-tools = rec {
    version = "v1.39";
    make = sys: hash: fetchzip {
      url = "https://github.com/solana-labs/platform-tools/releases/download/"
        + "${version}/platform-tools-${sys}.tar.bz2";
      sha256 = hash;
      stripRoot = false;
    };
    x86_64-linux =
      make "linux-x86_64" "sha256-PAlPrq7WP8T4Pq78mCbPLGpywGAgqTPkas1kX2yKhJI=";
    aarch64-darwin =
      make "osx-aarch64" "sha256-nijBjC8R0lxVsuPZI8m6JgT7rh4QcJWPG28V+RI3QUk=";
    x86_64-darwin =
      make "osx-x86_64" "";
  };
  cli = rec {
    version = "v1.17.6";
    name = "solana-cli";
    make = sys: hash: fetchTarball {
      url = "https://github.com/solana-labs/solana/releases/download/"
        + "${version}/solana-release-${sys}.tar.bz2";
      sha256 = hash;
    };
    x86_64-linux =
      make "x86_64-unknown-linux-gnu" "sha256:1qgwxaq906azfvjnkyvqlx8q2b51ahy75wrdlykkx1l2xs5048fh";
    aarch64-darwin =
      make "aarch64-apple-darwin" "sha256:1ssqd987r8q9fximi9a5c34jx8k7hy265i4h45dlbrykkm7r7n2p";
    x86_64-darwin =
      make "x86_64-apple-darwin" "";
  };
}
