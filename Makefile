ZIRAN ?= ziran
LOCKED := $(if $(wildcard ziran.local.toml),,--locked)
.PHONY: check test portable
check:
	$(ZIRAN) check --project $(LOCKED) src/crypto.zi src/aes.zi src/sha1.zi
test:
	$(ZIRAN) build --project $(LOCKED) --target=c --entry crypto_test:Main --exe -o build/tests tests/crypto_test.zi
	env -u DISPLAY -u WAYLAND_DISPLAY build/tests/crypto_test
	$(MAKE) portable

# The hashes portable bundles use, built and run as a bundle.
portable:
	mkdir -p build
	$(ZIRAN) bundle --root . --module-path src --module-path "$$($(ZIRAN) pkg path ziran $(LOCKED))/std" \
		--entry portable_test:Run -o build/portable.zx tests/portable_test.zi
	test "$$($(ZIRAN) run build/portable.zx)" = 0
	@echo 'Portable hashes passed'
