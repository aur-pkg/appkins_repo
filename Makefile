BUILD_DIR = pub
REPO_NAME = appkins-current
MAKE_CMD = makepkg -ACcsf #-ACcs

PKG_FILES := $(wildcard *.pkgbuild)
BIN_FILES := $(patsubst %.pkgbuild,%.pkg.tar,$(PKG_FILES))

TARGETS := adapta-midnight

.PHONY: all cleanup repo src

all: $(BIN_FILES) cleanup repo
	@echo '$@ $^'

src: $(BIN_FILES)

%.pkg.tar: %.pkgbuild
	$(MAKE_CMD) -p $<

cleanup:
	rm -rf $(TARGETS)
	mkdir -p $(BUILD_DIR) && mv *.[tar]* $(BUILD_DIR)/

repo:
	cd $(BUILD_DIR) && repo-add $(REPO_NAME).db.tar.gz $(shell cd $(BUILD_DIR) && find . -name '*.pkg.tar' -type f)

clean:
	rm -rf $(BUILD_DIR)

# all: cpp-redis

# tacopie:
# 	$(MAKE_CMD) -p $@.pkgbuild

# cpp-redis:
# 	$(MAKE_CMD) -p cpp-redis.pkgbuild