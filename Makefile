.PHONY: clean clean-all install
SHELL:=$(shell which bash)

# some binaries
BLENDER:=/Applications/blender.app/Contents/MacOS/blender

NAME=HandCrank_0.1.0
ZIPFILE=dist/$(NAME).zip

ENTITY_GRAPHICS:=hand-crank
GRAPHIC_FILES= \
	$(addsuffix .png,$(addprefix dist/$(NAME)/graphics/entity/,$(ENTITY_GRAPHICS))) \
	$(addsuffix _shadow.png,$(addprefix dist/$(NAME)/graphics/entity/,$(ENTITY_GRAPHICS))) \
	$(addsuffix _dark.png,$(addprefix dist/$(NAME)/graphics/entity/,$(ENTITY_GRAPHICS)))

SRC:= \
	control.lua \
	data.lua \
	info.json \
	locale/en/config.cfg \
	prototypes/entity/hand-crank.lua \
	prototypes/item/hand-crank.lua

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
		luacheck -q --codes --ignore 631 --globals script data game defines util table.deepcopy -- $^ ; \
	fi
	@mkdir -p "$(dir $@)"
	@cp "$^" "$@"

.PRECIOUS: dist/gfx/entity/%/entity_0001.png
dist/gfx/entity/%/entity_0001.png: gfx/entity/%.blend
	$(info >>> render (entity): $^)
	@rm -rf $(dir $@)/entity_*.png
	@mkdir -p $(dir $@)
	# NOTE: arg order matters here!
	@$(BLENDER) -b $^ -t 0 --python-exit-code 1 --python-expr 'import bpy; bpy.data.scenes[0].render.layers["entity"].use = True' -P /tmp/test.py -o dist/gfx/entity/$(shell basename $(shell dirname "$@"))/entity_$(shell echo '####') -F PNG -x 1 -a

.PRECIOUS: dist/gfx/entity/%/shadow_0001.png
dist/gfx/entity/%/shadow_0001.png: gfx/entity/%.blend
	$(info >>> render (shadow): $^)
	@rm -rf $(dir $@)/shadow_*.png
	@mkdir -p $(dir $@)
	# NOTE: arg order matters here!
	@$(BLENDER) -b $^ -t 0 --python-exit-code 1 --python-expr 'import bpy; bpy.data.scenes[0].render.layers["shadow"].use = True' -P /tmp/test.py -o dist/gfx/entity/$(shell basename $(shell dirname "$@"))/shadow_$(shell echo '####') -F PNG -x 1 -a

.PRECIOUS: dist/gfx/entity/%/dark_0001.png
dist/gfx/entity/%/dark_0001.png: gfx/entity/%.blend
	$(info >>> render (dark): $^)
	@rm -rf $(dir $@)/dark_*.png
	@mkdir -p $(dir $@)
	# NOTE: arg order matters here!
	@$(BLENDER) -b $^ -t 0 --python-exit-code 1 --python-expr 'import bpy; bpy.data.scenes[0].render.layers["dark"].use = True' -P /tmp/test.py -o dist/gfx/entity/$(shell basename $(shell dirname "$@"))/dark_$(shell echo '####') -F PNG -x 1 -a

.PRECIOUS: dist/$(NAME)/graphics/entity/%.png
dist/$(NAME)/graphics/entity/%.png: dist/gfx/entity/%/entity_0001.png
	$(info >>> sprite sheet: $@)
	@mkdir -p $(dir $@)
	@convert $$(find $(dir $^) -name '*.png' -type f -name 'entity_*.png') -append $@

.PRECIOUS: dist/$(NAME)/graphics/entity/%_shadow.png
dist/$(NAME)/graphics/entity/%_shadow.png: dist/gfx/entity/%/shadow_0001.png
	$(info >>> sprite sheet: $@)
	@mkdir -p $(dir $@)
	@convert $$(find $(dir $^) -name '*.png' -type f -name 'shadow_*.png') -append $@

.PRECIOUS: dist/$(NAME)/graphics/entity/%_dark.png
dist/$(NAME)/graphics/entity/%_dark.png: dist/gfx/entity/%/dark_0001.png
	$(info >>> sprite sheet: $@)
	@mkdir -p $(dir $@)
	@convert $$(find $(dir $^) -name '*.png' -type f -name 'dark_*.png') -append $@

clean:
	$(info >>> clean (keep renders))
	@find dist -not \( -path dist -o -path dist/gfx -o -path 'dist/gfx/*' \) -delete

clean-all:
	$(info >>> clean (purge renders))
	@rm -rf dist

install: $(ZIPFILE)
	$(info >>> install to macOS mods folder)
	@cp $(ZIPFILE) "$(HOME)/Library/Application Support/factorio/mods/"
