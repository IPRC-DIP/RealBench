# Tool configuration
GPG := gpg
FIND := find
RM := rm -f

# File discovery
MD_FILES := $(shell $(FIND) . -name '*.md' -not -name 'README.md')
GPG_FILES := $(patsubst %.md,%.md.gpg,$(MD_FILES))
DEC_FILES := $(patsubst %.md.gpg,%.md,$(shell $(FIND) . -name '*.md.gpg'))

# Password setting (recommended to pass via environment variable)
PASSWORD = iprc-dip

.PHONY: all encrypt decrypt clean_encrypt clean_decrypt help

all: help

help:
	@echo "Markdown file encryption/decryption system (using GPG)"
	@echo "Usage:"
	@echo "  make encrypt    # Encrypt all .md files"
	@echo "  make decrypt    # Decrypt all .md.gpg files"
	@echo "  make clean_encrypt      # Remove all .md.gpg files"
	@echo "  make clean_decrypt      # Remove all generated .md files"

# Encryption rule
encrypt: $(GPG_FILES)

%.md.gpg: %.md
	@echo "[Encrypting] $< -> $@"
	@$(GPG) --batch --yes --passphrase "$(PASSWORD)" \
		--symmetric --output "$@" "$<"

# Decryption rule
decrypt: $(DEC_FILES)

%.md: %.md.gpg
	@echo "[Decrypting] $< -> $@"
	@$(GPG) --batch --yes --passphrase "$(PASSWORD)" \
		--decrypt --output "$@" "$<" 2>/dev/null || \
		(echo "Decryption failed: Please check if password is correct"; exit 1)

# Cleanup
clean_encrypt:
	@echo "[Cleaning] Removing .md.gpg files"
	@$(RM) $(GPG_FILES)

clean_decrypt:
	@echo "[Cleaning] Removing .md files"
	@$(RM) $(DEC_FILES)