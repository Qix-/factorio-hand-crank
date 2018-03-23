.PHONY: clean clean-all install
SHELL:=$(shell which bash)

# some binaries
BLENDER:=/Applications/blender.app/Contents/MacOS/blender

NAME=HandCrank_0.1.0
ZIPFILE=dist/$(NAME).zip

GRAPHICS:=hand-crank
GRAPHIC_FILES=$(addsuffix .png,$(addprefix dist/$(NAME)/graphics/,$(GRAPHICS)))

SRC:= \
	control.lua \
	data.lua \
	info.json \
	locale/en/config.cfg \
	prototypes/entity/hand-crank.lua

DEST_FILES=$(addprefix dist/$(NAME)/,$(SRC))

all: $(ZIPFILE)

$(ZIPFILE): $(GRAPHIC_FILES) $(DEST_FILES)
	$(info >>> zip: $@)
	@rm -rf $@
	@(cd dist && zip -9 -r ../$@ $(NAME))

dist/$(NAME)/%: src/%
	$(info >>> copy: $^)
	@filename="$^" ; \
	if [ "$${filename$(shell echo '##')*.}" == lua ]; then \
		luacheck -q --codes --ignore 631 --globals script data game defines table.deepcopy -- $^ ; \
	fi
	@mkdir -p "$(dir $@)"
	@cp "$^" "$@"

.PRECIOUS: dist/gfx/%/0001.png
dist/gfx/%/0001.png: gfx/%.blend
	$(info >>> render: $^)
	@mkdir -p $(dir $@)
	@$(BLENDER) -b $^ -o dist/gfx/$(shell basename $(shell dirname "$@"))/$(shell echo '####') -F PNG -x 1 --python-exit-code 1 -t 0 -a

.PRECIOUS: dist/$(NAME)/graphics/%.png
dist/$(NAME)/graphics/%.png: dist/gfx/%/0001.png
	$(info >>> sprite sheet: $@)
	@mkdir -p $(dir $@)
	@convert $$(find $(dir $^) -name '*.png' -type f) -append $@

clean:
	$(info >>> clean (keep renders))
	@find dist -not \( -path dist -o -path dist/gfx -o -path 'dist/gfx/*' \) -delete

clean-all:
	$(info >>> clean (purge renders))
	@rm -rf dist

install: $(ZIPFILE)
	$(info >>> install to macOS mods folder)
	@cp $(ZIPFILE) "$(HOME)/Library/Application Support/factorio/mods/"
