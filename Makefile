ZIRAN ?= ziran
LOCKED := $(if $(wildcard ziran.local.toml),,--locked)
.PHONY: check test
check:
	$(ZIRAN) check --project $(LOCKED) src/crypto.zi src/aes.zi src/sha1.zi
test:
	$(ZIRAN) build --project $(LOCKED) --target=c --entry crypto_test:Main --exe -o build/tests tests/crypto_test.zi
	env -u DISPLAY -u WAYLAND_DISPLAY build/tests/crypto_test
