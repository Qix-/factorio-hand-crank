.PHONY: clean install

# some binaries
BLENDER:=/Applications/blender.app/Contents/MacOS/blender

NAME=HandCrank_0.1.0
ZIPFILE=dist/$(NAME).zip

GRAPHICS:=hand-crank
GRAPHIC_FILES=$(addsuffix .png,$(addprefix dist/$(NAME)/graphics/,$(GRAPHICS)))

$(ZIPFILE): $(GRAPHIC_FILES)
	@mkdir -p dist/$(NAME)
	cp -R src/* dist/$(NAME)/
	luacheck --codes --ignore 631 --globals script data game defines table.deepcopy -- $$(find src -type f -name '*.lua')
	@rm -rf $@
	(cd dist && zip -9 -r ../$@ $(NAME))

.PRECIOUS: dist/gfx/%/0001.png
dist/gfx/%/0001.png: gfx/%.blend
	@mkdir -p $(dir $@)
	$(BLENDER) -b $^ -o dist/gfx/$(shell basename $(shell dirname "$@"))/$(shell echo '####') -F PNG -x 1 --python-exit-code 1 -t 0 -a

.PRECIOUS: dist/$(NAME)/graphics/%.png
dist/$(NAME)/graphics/%.png: dist/gfx/%/0001.png
	@mkdir -p $(dir $@)
	convert $$(find $(dir $^) -name '*.png' -type f) -append $@

clean:
	rm -rf dist

install: $(ZIPFILE)
	cp $(ZIPFILE) "$(HOME)/Library/Application Support/factorio/mods/"
