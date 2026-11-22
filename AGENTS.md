# crypto agent guide

Portable Ziran cryptography package. Exports (import `crypto/<name>`):
`crypto`, `sha256`, `sha512`, `sha1`, `aes`, `bigint`, `wipe`, `kdf`,
`chacha20`, `totp`, `base64`, `blake2b`, `native` — all under `src/`.
This repository has no README; this guide is the entry document.

## Layout

- `src/` — one module per export, named after it.
- `tests/` — `crypto_test.zi` (native suite), `portable_test.zi` (hashes run
  as a bundle), `bench.zi` (libsodium comparison benchmark).
- `Makefile` — `check`, `test`, `bench`, `portable`. `build/` holds outputs;
  `backup/` is ignored local backup.
- `ziran.toml` / `ziran.lock` — identity and locked toolchain; an ignored
  `ziran.local.toml` selects a local checkout and drops `--locked`.

## Commands

- `make check` — `ziran check --project` over the core modules.
- `make test` — build and run `tests/crypto_test.zi` (no display), then
  `make portable`.
- `make portable` — bundle the hash tests as a `.zx` bundle and require a
  passing run.
- `make bench` — build and run the benchmark against system libsodium
  (`SODIUM_LIBS` overrides the default `-l:libsodium.so.23`).

## Pins

- Toolchain: `ziran.lock` pins ziran.git
  `5db3d3c39425d5dfe4bfe4a84e6f6e2e5a810ad0`.

## Question -> file

- Which primitives exist? -> exports list above and `ziran.toml`.
- Where are the correctness tests? -> `tests/crypto_test.zi`,
  `tests/portable_test.zi`.
- How do I benchmark? -> `make bench`, `tests/bench.zi`.
- Which toolchain? -> `ziran.toml`, `ziran.lock`.
